import framework.zookeeper.CubeUser
import framework.zookeeper.ZookeeperStarter

class BootStrap {

    def init = { servletContext ->
        ZookeeperStarter.start()
        if (CubeUser.count == 0)
            new CubeUser(name: "管理员",login: "test",password: "e10adc3949ba59abbe56e057f20f883e").save()
    }
    def destroy = {
    }
}
