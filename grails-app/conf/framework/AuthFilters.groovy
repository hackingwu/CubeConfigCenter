package framework

import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib

class AuthFilters {

    static Map<String,List> excludedUrl = [
            cubeUser:["index","login","logOut"]
    ]
    def filters = {
        all(controller: '*', action: '*') {
            before = {
                if (excludedUrl.containsKey(controllerName) && excludedUrl.get(controllerName).contains(actionName) || null != session.getAttribute("name") ){
                   return true
                }else{
                    def url= grailsApplication.mainContext.getBean(ApplicationTagLib.class).createLink(controller: "cubeUser", action: "index")
                    response.getWriter().write("<script text='text/javascript'>top.location.href='"+url+"';</script>")
                    return false
                }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
