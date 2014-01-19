
Ext.net.ResourceMgr.init(
	
	{cdnPath:"http://speed.ext.net/ext.net/2.3.1",isMVC:true,theme:"gray"});
	
	Ext.onReady(function(){
		
		Ext.ns("App.direct");
		Ext.apply(App.direct, { 
				GetTime:function(config){
					return Ext.net.DirectMethod.request("GetTime",	Ext.applyIf(config || {}, 
						{url:"/Events/AnotherDirectMethod/GetTime"}));
				},
				
				Events:{
					SetTimeStamp:function(config){
						return Ext.net.DirectMethod.request("SetTimeStamp",Ext.applyIf(config || {}, {url:"/Events/DirectMethod/SetTimeStamp"}));
					},
				
					LogCompanyInfo:function(name,count,config){
						return Ext.net.DirectMethod.request("LogCompanyInfo",Ext.applyIf(config || {}, {params:{name:name,count:count},url:"/Events/DirectMethod/LogCompanyInfo"}));
					}
				} 
		});
		// done of Ext.apply
		
		// the first button  => In the controller that we have: 
		// [DirectController(AreaName="Events")], ah... it is alias to DirectMethodController
		//public class DirectMethodController : Controller
		
		Ext.create("Ext.button.Button",{renderTo:"App.id2fe908206b35135a_Container",
				handler:function(){App.direct.Events.SetTimeStamp();},
				iconCls:"#Lightning",text:"Click Me"});
		
		Ext.create("Ext.net.Label",{id:"Label1",renderTo:"App.Label1_Container",
				format:"Server Time: {0}",text:"1:29:14 AM"});
		
		
		// The second Button, direct method from another controller 
		// no idea, from which controller? 
		
		// wtf is App.direct.GetTime
		Ext.create("Ext.button.Button",{renderTo:"App.idf7349bb78263c53a_Container",
				
				handler:function(){App.direct.GetTime({success : function(result){
                Ext.Msg.alert('Server Time', result);
            }});},iconCls:"#Lightning",text:"Click Me"});


// App.direct.Events
// hitting the App.direct.Events => Alias to DirectMethodController 
		Ext.create("Ext.panel.Panel",{frame:true,renderTo:"App.id979bd47b375a0e2a_Container",
				width:350,items:[
					{id:"TextField3",xtype:"textfield",fieldLabel:"Company Name",allowBlank:false},
					{id:"ComboBox3",xtype:"combobox",fieldLabel:"# of Employees",queryMode:"local",store:[["0","1-5"],["1","6-25"],["2","26-100"],["3","101+"]]}
				],
				layout:"form",bodyPadding:5,
				buttons:[
					{
						handler:function(){
							App.direct.Events.LogCompanyInfo(App.TextField3.getValue(), App.ComboBox3.getValue());
						},
						iconCls:"#Lightning",text:"Submit"
					}
				],title:"Company Information"});
				
		Ext.create("Ext.net.Label",{id:"Label3",renderTo:"App.Label3_Container",text:"Write Company Information Here"});
		
		Ext.net.ResourceMgr.registerIcon(["Lightning"]);});