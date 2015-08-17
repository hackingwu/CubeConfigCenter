<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2014/10/24
  Time: 14:39
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <link href="${g.resource([ dir: "/ext/resources/css", file: "ext-all-neptune.css"])}" rel="stylesheet" type="text/css"/>
    <link href="${g.resource([ dir: "/css", file: "data-view.css"])}" rel="stylesheet" type="text/css"/>
    <link href="${g.resource([ dir: "/css", file: "toolbar.css"])}" rel="stylesheet" type="text/css"/>
    <link href="${g.resource([ dir: "/css", file: "wintip.css"])}" rel="stylesheet" type="text/css"/>
    <script src="${g.resource([ dir: "/ext", file: "ext-all.js"])}" type="text/javascript"></script>
    <script src="${g.resource([ dir: "/ext/locale", file: "ext-lang-zh_CN.js"])}" type="text/javascript"></script>
    <script src="${g.resource([ dir: "/js", file: "WinTip.js"])}" type="text/javascript"></script>
    <script src="${g.resource([dir:"/js",file: "cookie.js"])}" type="text/javascript"></script>
    <script type="text/javascript">
        var path;
        var pathToCopy;
        var pathToPaste;

        var configCreateWnd;
        var configUpdateWnd;
        var configDetailWnd;
        var configStore;
        var configTree;
                function configCreate(){
            if(!configCreateWnd){
                configCreateForm = Ext.widget({
                    xtype:'form',
                    id:'configCreateWnd',
                    layout:'form',
                    autoScroll:true,
                    width:750,
                    bodyPadding:'5 5 5 5',
                    buttonAlign:'center',
                    defaultType:'textfield',
                    items:[
                        {fieldLabel:'节点名称',name:'nodeName',allowBlank:false,maxLength:127,minLength:2},
                        {fieldLabel:'属性值',name:'value',maxLength:127,minLength:2}
                    ],
                    buttons:[
                        {
                            text:'确定',
                            handler:function(){
                                var cmpForm = this.up('form').getForm();
                                if(cmpForm.isValid()){
                                    cmpForm.submit({
                                        url:'<g:createLink controller="configCenter" action="create" />',
                                        params:{parent:path},
                                        success:function(form,response){
                                            if(response.result.success){
                                                Ext.wintip.msg('操作成功!',  response.result.message);
                                                configCreateWnd.hide();
                                                configStore.reload();
                                                configTree.getLoader().load(root);
                                            }else{
                                                Ext.wintip.error('操作失败!',  response.result.message);
                                            }
                                        },
                                        failure: function(form, action) {
                                            Ext.wintip.error('操作失败!',  action.result.message);
                                        }
                                    });
                                }
                            }
                        },{
                            text:'关闭',
                            handler:function(){
                                configCreateWnd.hide();
                            }
                        }
                    ]
                });
                configCreateWnd = Ext.create('Ext.Window',{
                    title:'新增节点',
                    plain:true,
                    modal:true,//隐藏后面
                    resizable:false,
                    closeAction:'hide',
                    items:[configCreateForm]
                });
            }
            configCreateWnd.down('form').form.reset()
            configCreateWnd.show();
            var autoHeight = parseInt(document.documentElement.clientHeight*0.7);
            if(document.getElementById('configCreateForm').scrollHeight>autoHeight){
                configCreateWnd.down('form').setHeight(autoHeight);
                configCreateWnd.down('form').setWidth(750);
                configCreateWnd.center();
            }
        }

        function configDetail(){
            if (!configDetailWnd) {
                configDetailForm = Ext.widget({
                    xtype: 'form',
                    id: 'configDetailForm',
                    layout: 'form',
                    autoScroll:true,
                    width:750,
                    bodyPadding: '5 5 5 5',
                    buttonAlign: 'center',
                    defaultType: 'textfield',
                    items: [
                        {fieldLabel:'节点名称',name:'nodeName',allowBlank:false,maxLength:127,minLength:1},
                        {fieldLabel:'属性值',name:'value',maxLength:127,minLength:1}
                    ],
                    buttons: [
                        {
                            text: '关闭',
                            handler: function () {
                                configDetailWnd.hide();
                            }
                        }
                    ]
                });

                configDetailWnd = Ext.create('Ext.Window', {
                    title: '配置明细',
                    plain: true,
                    modal: true,
                    resizable: false,
                    closeAction: 'hide',
                    items: [configDetailForm]
                });
            }

            configDetailWnd.down('form').form.reset();

            configDetailWnd.down('form').getForm().load({
                params: { path:path},
                url: '<g:createLink controller="configCenter" action="detail"/>',
                autoLoad: true,
                success:function(form,action){
                    try{
                    }catch(e){
                        //error
                    }


                    configDetailWnd.show();

                    var autoHeight = parseInt(document.documentElement.clientHeight*0.7);
                    if(document.getElementById('configDetailForm').scrollHeight>autoHeight){
                        configDetailWnd.down('form').setHeight(autoHeight);
                        configDetailWnd.down('form').setWidth(750);
                        configDetailWnd.center();
                    }
                },
                failure: function(form, action) { //失败返回：{ success: false, errorMessage:"指定的数据不存在" }
                    Ext.MessageBox.show({
                        title: '数据加载失败',
                        msg: action.result.errorMessage,
                        buttons: Ext.MessageBox.OK
                    });
                }
            });
        }



        function configUpdate(){
            if (!configUpdateWnd) {
                configUpdateForm = Ext.widget({
                    xtype: 'form',
                    id: 'configUpdateForm',
                    layout: 'form',
                    autoScroll:true,
                    width:750,
                    bodyPadding: '5 5 5 5',
                    buttonAlign: 'center',
                    defaultType: 'textfield',
                    items: [
                        {fieldLabel:'属性值',name:'value',maxLength:127,minLength:2}
                    ],
                    buttons: [
                        {
                            text: '确定',
                            handler: function () {
                                var cmpForm = this.up('form').getForm();
                                if(cmpForm.isValid()){
                                    cmpForm.submit({
                                        url:'<g:createLink controller="configCenter" action="update"/>',
                                        params:{path:path},
                                        success: function(form, response) {
                                            if(response.result.success){
                                                Ext.wintip.msg('操作成功!',  response.result.message);
                                                configUpdateWnd.hide();
                                            }else{
                                                Ext.wintip.error('操作失败!',  response.result.message);
                                            }
                                        },
                                        failure: function(form, action) {
                                            Ext.wintip.error('操作失败!',  action.result.message);
                                        }
                                    });
                                }
                            }
                        },
                        {
                            text: '关闭',
                            handler: function () {
                                configUpdateWnd.hide();
                            }
                        }
                    ]
                });

                configUpdateWnd = Ext.create('Ext.Window', {
                    title: '配置编辑',
                    plain: true,
                    modal: true,
                    resizable: false,
                    closeAction: 'hide',
                    items: [configUpdateForm]
                });
            }

            configUpdateWnd.down('form').form.reset();

            configUpdateWnd.down('form').getForm().load({
                params: { path:path},
                url: '<g:createLink controller="configCenter" action="detail"/>',
                autoLoad: true,
                success:function(form,action){
                    try{
                    }catch(e){
                        //error
                    }

                    configUpdateWnd.show();

                    var autoHeight = parseInt(document.documentElement.clientHeight*0.7);
                    if(document.getElementById('configUpdateForm').scrollHeight>autoHeight){
                        configUpdateWnd.down('form').setHeight(autoHeight);
                        configUpdateWnd.down('form').setWidth(750);
                        configUpdateWnd.center();
                    }
                },
                failure: function(form, action) { //失败返回：{ success: false, errorMessage:"指定的数据不存在" }
                    Ext.MessageBox.show({
                        title: '数据加载失败',
                        msg: action.result.errorMessage,
                        buttons: Ext.MessageBox.OK
                    });
                }
            });
        }

        function configDelete(){
            Ext.Ajax.request({
                url:'<g:createLink controller="configCenter" action="delete" />',
                params:{path:path},
                success:function(response){
                    var result = Ext.JSON.decode(response.responseText)
                    if(result.success){
                        Ext.wintip.msg('操作成功!',  result.message);
                        configStore.reload()
                        configTree.getLoader().load(root);
                    }else{
                        Ext.wintip.error('操作失败!',  result.message);
                    }
                }
            });
        }
        function configCopy(){
            pathToCopy = path
        }
        function configPaste(){
            pathToPaste = path
            Ext.Ajax.request({
                url:'<g:createLink controller="configCenter" action="copy"/> ',
                params:{pathToCopy:pathToCopy,pathToPaste:pathToPaste},
                success:function(response){
                    var result = Ext.JSON.decode(response.responseText)
                    if(result.success){
                        Ext.wintip.msg('操作成功!',  result.message);
                        configStore.reload()
                        configTree.getLoader().load(root);
                    }else{
                        Ext.wintip.error('操作失败!',  result.message);
                    }
                }
            })
        }
        function exportConfig(){
            Ext.Ajax.request({
                url:'<g:createLink controller="configCenter" action="exportConfig"/> '
            })
        }
        function importConfig(){
            var configForm = Ext.widget( {
                xtype:'form',
                width: 500,
                bodyPadding: 10,
                items: [{
                    xtype: 'filefield',
                    name: 'config',
                    fieldLabel: '配置文件',
                    labelWidth: 50,
                    msgTarget: 'side',
                    allowBlank: false,
                    anchor: '100%',
                    buttonText: '选择.....',
                    listeners:{
                        change:function(self,v,opts){
                            var config_reg = /\.properties$/
                            if(!config_reg.test(v)){
                                Ext.Msg.alert('提示','请选择正确的配置文件');
                                self.setRawValue("")
                            }
                        }
                    }
                }],

                buttons: [{
                    text: '上传',
                    handler: function() {
                        var form = this.up('form').getForm();
                        if(form.isValid()){
                            form.submit({
                                url: '<g:createLink controller="configCenter" action="importConfig"/> ',
                                params:{path:path},
                                waitMsg: '选择...',
                                success: function(fp, o) {
                                    Ext.Msg.show({
                                        title: "上传成功",
                                        msg: o.result.message,
                                        modal: true,
                                        icon: Ext.Msg.INFO,
                                        buttons: Ext.Msg.OK
                                    });
                                    configStore.reload()
                                    configTree.getLoader().load(root);
                                    this.up('window').close();
                                },
                                failure: function(form, action) {
                                    Ext.Msg.show({
                                        title: "上传失败",
                                        msg: action.result.message,
                                        modal: true,
                                        icon: Ext.Msg.ERROR,
                                        buttons: Ext.Msg.OK
                                    });
                                }
                            });
                        }
                    }
                },
                    {
                        text:'取消',
                        handler:function(){
                            this.up('window').close();
                        }
                    }]
            });
            var configWindow = Ext.create('Ext.Window',{
                title:'配置文件上传',
                modal:true,
                resizable:false,
                items:[configForm]
            });
            configWindow.show();
        }
        Ext.onReady(function(){

            configStore = Ext.create('Ext.data.TreeStore', {
                proxy:{
                    type:'ajax',
                    autoLoad:true,
                    url:'<g:createLink controller="configCenter" action="configTree"/>',
                    reader:{
                        type:'json'
                    }
                }

            });
            configTree = Ext.create('Ext.tree.Panel', {
                title: '',
                width:500,
                height:800,
                store: configStore,
                rootVisible: true,
                overflowX:'auto',
                overflowY:'auto',
                root:{
                    id:"/",
                    text:"/",
                    expanded:true
                }
            });
            configTree.on('itemclick',function(view,record,item,index,event,eOpts){
                path = record.data.id;
            });
            configTree.on('itemdblclick',function(view,record,item,index,event,eOpts){
                configUpdate()
            })
            var toolbar = Ext.create('Ext.Toolbar',{
               minWidth:800,
                items:[
                    {
                        text: '添加',
                        disabled: false,
                        iconCls: 'icon-add',
                        handler: function () {
                            configCreate();
                        }
                    },
                    {
                        itemId: 'detail',
                        text: '详细',
                        disabled: false,
                        iconCls: 'icon-grid',
                        handler: function () {
                            configDetail();
                        }
                    },
                    {
                        itemId: 'update',
                        text: '修改',
                        disabled: false,
                        iconCls: 'icon-edit',
                        handler: function () {
                            configUpdate();
                        }
                    },
                    {
                        itemId:'delete',
                        text:'删除',
                        disabled:false,
                        iconCls:'icon-delete',
                        handler:function(){
                            configDelete();
                        }
                    },
                    {
                        itemId:'copy',
                        text:'复制',
                        disabled:false,
                        iconCls:'icon-add',
                        handler:function(){
                            configCopy();
                        }
                    },
                    {
                        itemId:'paste',
                        text:'粘贴',
                        disabled:false,
                        iconCls:'icon-grid',
                        handler:function(){
                            configPaste();
                        }
                    },
                      '->',
                    {
                        itemId:'import',
                        text:'导入',
                        disabled:false,
                        iconCls:'icon-grid',
                        handler:function(){
                            importConfig();
                        }
                    },
                    {
                        itemId:'export',
                        text:'导出',
                        disable:false,
                        iconCls:'icon-grid',
                        handler:function(){
                            exportConfig();
                        }
                    }
                ]
            });
            Ext.create('Ext.Viewport', {
                layout: 'border',
                items: [{
                    region:'north',
                    border:false,
                    items:toolbar,
                    height:50
                },{
                    region: 'center',
                    border:false,
                    items: configTree
                }]
            });





        });

    </script>

</head>

<body style="overflow: auto;">

</body>
</html>