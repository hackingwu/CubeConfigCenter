class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: "configCenter" , action: "index")
        "500"(view:'/error')
        "/cubeUser/login"(controller: "cubeUser",action: "login")
	}
}
