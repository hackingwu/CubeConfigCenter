package framework.zookeeper

class CubeUser {

    String login
    String name
    String password
    int role
    static constraints = {
        login attributes:[cn:"登录名"]
        name attributes:[cn:"用户名"]
        password attributes:[cn:"密码"]
        role attributes:[cn:"角色"],nullable: true
    }
}
