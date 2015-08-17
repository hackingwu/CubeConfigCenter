package framework.zookeeper

import grails.converters.JSON
import org.springframework.core.io.support.PropertiesLoaderUtils

class ConfigCenterController {

    ZKCommander zkCommander = null
    def beforeInterceptor={
        if (zkCommander == null)
            zkCommander = ConfigCenter.getInstance().getZKCommander()
    }
    def index() { }

    def create(){
        String output
        try{
            String path = params.parent+"${params.parent=='/'?'':'/'}"+params.nodeName
            zkCommander.createPath(path,params.value)
            output = [success:true,message:"创建成功"] as JSON
        }catch (Exception e){
            output = [success:true,message:"创建失败"] as JSON
        }
        render output
    }
    def delete(){
        String output
        try{
            zkCommander.delete(params.path)
            output = [success:true,message:"删除成功"] as JSON
        }catch (Exception e){
            output = [success:true,message:"删除失败"] as JSON
        }
        render output
    }
    def update(){
        String output = null
        try{
            zkCommander.update(params.path,params.value)
            output =  [success:true,message:"修改成功"] as JSON
        }catch (Exception e){
            output = [success:true,message:"修改失败"] as JSON
        }
        render output
    }
    def detail(){
        String path = params.path
        String nodeName = path.substring(path.lastIndexOf("/")+1)
        String output = null
        try {
            String value = zkCommander.detail(params.path)
            output = [
                    success: true,
                    message: "查询成功",
                    data   : [nodeName: nodeName, value: value]
            ]as JSON
        }catch (Exception e){
            output = [
                    success: false,
                    message: "查询失败",
                    data:null
            ] as JSON
        }
        render output
    }
    def configTree(){
        String path = null
        List<Map> result =[]
        if(params.node=="root"){
            path = "/"
        }else{
            path = params.node
        }
        List<String> children = zkCommander.list(path)
        children.each {
            result << ['id':"${path}${params.node=="/"?"":"/"}${it}",'text':it,'leaf':false]
        }
        render result as JSON
    }
    def copy(){
        String output = ""
        try{
            String pathToCopy = params.pathToCopy
            String pathToPaste = params.pathToPaste
            List<String> childrenPath = []
            children(pathToCopy,childrenPath)
            String copyPathParent = pathToCopy.substring(0,pathToCopy.lastIndexOf("/"))
            childrenPath.each {
                String path = ""
                if (copyPathParent == ""){
                    path = pathToPaste + it
                }else{
                    path = it.replace(copyPathParent,pathToPaste)
                }
                zkCommander.createPath(path,zkCommander.detail(it))
            }
            output = [success: true,data: null,message: "复制成功"] as JSON
        }catch (Exception e){
            e.printStackTrace()
//            log.error("",e)
            output = [success: false,data: null,message: "复制失败"] as JSON
        }
        render output
    }

    def exportConfig(){
        println "test"
    }

    def importConfig(){
        String output
        try{
            String parent = params.path
            def f = request.getFile('config')
            Properties properties = new Properties()
            properties.load(f.getInputStream())
            properties.keys().each {String key->
                String path = ""
                if (parent.endsWith("/")){
                    path = parent + key
                }else{
                    path = parent + "/" + key
                }
                println path
                String data = (String) properties.get(key)
                if (zkCommander.exists(path)){
                    zkCommander.update(path,data)
                }else{
                    zkCommander.createPath(path,data)
                }
            }
            output = [success: true,message: "导入成功"] as JSON
        }catch (Exception e){
            e.printStackTrace()
            output = [success:false,message:"导入失败"] as JSON
        }
        render output
    }
    private void children(String path,List<String> childrenPath){
        childrenPath.add(path)
        zkCommander.list(path).each {
            String fullPath = ""
            if (!path.endsWith("/"))
                fullPath = path + "/"
            fullPath += it
            children(fullPath,childrenPath)
        }

    }
}
