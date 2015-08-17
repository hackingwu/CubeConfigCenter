package framework.zookeeper

import grails.converters.JSON

class CubeUserController {
    def index(){

    }

    def login(){
        String login = params.login
        String password = params.password
        CubeUser cubeUser = null
        String output = ""
        if ((cubeUser = CubeUser.findByLogin(login)) != null && cubeUser.password == password){
            session.setAttribute("name",cubeUser.name)
            output = ["success":true] as JSON
        }else{
            output = ["success":false] as JSON
        }
        render output
    }
}
