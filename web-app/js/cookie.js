/**
 * Created by wuzj on 2015/1/4.
 */
function createCookie(name,value,days){
    var expires
    if(days){
        var date = new Date();
        date.setTime(date.getTime() + days*24*60*60*1000);
        expires = ";expires="+date.toGMTString();
    }else{
        expires = "";
    }
    document.cookie = name+"="+value+expires+";path=/";
}
function readCookie(name){
    var nameEQ = name + "=";
    var cookieArray = document.cookie.split(";");
    for(var i = 0;i < cookieArray.length;i++){
        var cookie = cookieArray[i];
        while(cookie.charAt(0)==" ") cookie = cookie.substring(1, cookie.length);
        if(cookie.indexOf(nameEQ) == 0) return cookie.substring(nameEQ.length, cookie.length);
    }
    return null;
}
function easingCookie(name){
    createCookie(name,"",-1)
}