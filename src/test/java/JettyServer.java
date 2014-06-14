
import org.mortbay.jetty.Connector;
import org.mortbay.jetty.Server;
import org.mortbay.jetty.bio.SocketConnector;
import org.mortbay.jetty.webapp.WebAppContext;

/**
 * 
 * @author liangwm
 * 
 */
public class JettyServer {
	public static void main(String[] args) throws Exception {
		start(args);
	}

	public static void usage() {
		System.err.println("\nUsage: JettyServer [-h] [-p] [-d] [-m]\n"
				+ "    -h[elp]\tPrint this usage message and exit\n"
				+ "    -p[ort]\tRequest listen port, default to 8080\n"
				+ "    -m[ap]\tMap virule directory path\n"
				+ "    -d[irectory]\tWeb application path\n"
				+ "\n\tExample command lines:\n"
				+ "    java JettyServer -p 8088 -d ./web -m /oam\n"
		);
	}
	
	private static void start(String[] args) throws Exception{
		int port = 2000;
		String webpath = getAppWebRoot() + "../../../WebRoot";
		String mappath = "/";
		int argInd = 0;

		// Iterate over all of the arguments
		for (argInd = 0; argInd < args.length; argInd++) {

			// Break out if argument does not start with '-'
			if (args[argInd].charAt(0) != '-') {
				break;
			}

			if (args[argInd].equalsIgnoreCase("-h")
					|| args[argInd].equalsIgnoreCase("-help")) {
				usage();
				System.exit(0);

			} else if (args[argInd].equalsIgnoreCase("-p")
					|| args[argInd].equalsIgnoreCase("-port")) {
				argInd++;
				if (argInd >= args.length) {
					System.err.println("Error: -port option requires an argument.");
					usage();
					System.exit(1);
				}
				port = new Integer(args[argInd]);

			} else if (args[argInd].equalsIgnoreCase("-d")
					|| args[argInd].equalsIgnoreCase("-directory")) {

				argInd++;
				if (argInd >= args.length) {
					System.err.println("Error: -directory option requires an argument.");
					usage();
					System.exit(1);
				}
				webpath = args[argInd];
			} else if (args[argInd].equalsIgnoreCase("-m")
					|| args[argInd].equalsIgnoreCase("-map")) {

				argInd++;
				if (argInd >= args.length) {
					System.err.println("Error: -map option requires an argument.");
					usage();
					System.exit(1);
				}
				mappath = args[argInd];

			} else {
				System.err.println("Error: unknown argument " + args[argInd]);
				usage();
				System.exit(1);
			}
		}

		// If there are any left over arguments, it is an error at this point.
		if (argInd < args.length) {
			System.err.println("Error: too many arguments. Parsing stopped at "
					+ args[argInd]);
			usage();
			System.exit(1);
		}
		
        Server server = new Server();
        Connector connector = new SocketConnector();
        connector.setPort(port);
        server.setConnectors(new Connector[]{connector});
        
        WebAppContext handler = new WebAppContext(webpath, mappath);
        server.setHandler(handler);
        
		server.setStopAtShutdown(true);
		server.setSendServerVersion(true);
		server.start();
        server.join();

	}
	
	public static String getAppWebRoot(){
		String s = Thread.currentThread().getContextClassLoader().getResource("").toString();
		if(s.startsWith("file://")){
			return s.substring(6);
		}else if(s.startsWith("file:/")){
			return s.substring(6);
		}else{
			return s;
		}
	}
}
