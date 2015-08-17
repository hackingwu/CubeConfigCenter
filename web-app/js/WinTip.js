/*
 * 提示消息控件
 **/
Ext.wintip = function(){
    var msgCt;

    function createBox(t, s,type){
        var ret;
        if(type=='msg'){
            ret = '<div class="msg ' + Ext.baseCSSPrefix + 'border-box"><span>' + t + '</span><p>' + s + '</p></div>';
        }else{
            ret = '<div class="error ' + Ext.baseCSSPrefix + 'border-box"><span>' + t + '</span><p>' + s + '</p></div>';
        }
       return ret;
    }
    return {
        msg : function(title, format){
            if(!msgCt){
                msgCt = Ext.DomHelper.insertFirst(document.body, {id:'msg-div'}, true);
            }
            var s = Ext.String.format.apply(String, Array.prototype.slice.call(arguments, 1));
            var m = Ext.DomHelper.append(msgCt, createBox(title, s,'msg'), true);
            m.hide();
            m.slideIn('t',{easing: 'easeOut',duration: 500}).ghost("t", { delay: 3000, remove: true});
        },
        error : function(title, format){
            if(!msgCt){
                msgCt = Ext.DomHelper.insertFirst(document.body, {id:'msg-div'}, true);
            }
            var s = Ext.String.format.apply(String, Array.prototype.slice.call(arguments, 1));
            var m = Ext.DomHelper.append(msgCt, createBox(title, s,'error'), true);
            m.hide();
            m.slideIn('t',{easing: 'easeOut',duration: 500}).ghost("t", { delay: 6000, remove: true});
        },
        init : function(){
            if(!msgCt){
                msgCt = Ext.DomHelper.insertFirst(document.body, {id:'msg-div'}, true);
            }
        }
    };
}();

Ext.onReady(Ext.wintip.init, Ext.wintip);
