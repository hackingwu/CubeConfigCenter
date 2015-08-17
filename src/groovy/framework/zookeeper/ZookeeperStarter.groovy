package framework.zookeeper

import org.apache.zookeeper.server.ServerConfig
import org.apache.zookeeper.server.ZooKeeperServerMain
import org.apache.zookeeper.server.quorum.QuorumPeerConfig
import org.springframework.core.io.ClassPathResource
import org.springframework.core.io.support.PropertiesLoaderUtils

/**
 * Created by wuzj on 2014/12/18.
 */
class ZookeeperStarter {

    private static String filePath = "zoo.cfg"
    public static void start(){
        QuorumPeerConfig quorumPeerConfig
        try{
            ClassPathResource resource = new ClassPathResource(filePath)
            Properties startupProperties = PropertiesLoaderUtils.loadProperties(resource)
            quorumPeerConfig = new QuorumPeerConfig()
            quorumPeerConfig.parseProperties(startupProperties)
        }catch (Exception e){
            e.printStackTrace()
        }
        def zooKeeperServer = new ZooKeeperServerMain()
        final ServerConfig configuration = new ServerConfig();
        configuration.readFrom(quorumPeerConfig)
        new Thread(){
            public void run(){
                try{
                    zooKeeperServer.runFromConfig(configuration);
                }catch (Exception e){
                    e.printStackTrace()
                }
            }
        }.start()
    }
}
