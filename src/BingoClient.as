package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.InterfaceAddress;
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;

	public class BingoClient extends Sprite
	{
		private var iAddr:InterfaceAddress;
		
		public function BingoClient()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			init();
		
		}
		private function init():void{
			NetworkInfo.networkInfo.addEventListener(Event.NETWORK_CHANGE,onNetworkChange);
			
			calculateInterfaceAddress();
			
		}
		private function onNetworkChange(event:Event):void{
			trace("networkChange");
			updateInterfaceAddress();
			
		}
		private function updateInterfaceAddress():void{
			var results:Vector.<NetworkInterface> = NetworkInfo.networkInfo.findInterfaces();
			var output:String;
			var newiAddr:InterfaceAddress;
			
			for(var i:int = 0; i < results.length;i++)
			{
				output = output
					+ "Name: " + results[i].name + "\n"
					+ "DisplayName: " + results[i].displayName + "\n"
					+ "MTU: " + results[i].mtu + "\n"
					+ "HardwareAddr: " + results[i].hardwareAddress + "\n"
					+ "Active: " + results[i].active + "\n";
				
				for(var j:int = 0; j<results[i].addresses.length; j++)
				{
					output = output
						+ "Addr: " + results[i].addresses[j].address + "\n"
						+ "Broadcast: " + results[i].addresses[j].broadcast + "\n"
						+ "PrefixLength: " + results[i].addresses[j].prefixLength + "\n"
						+ "IPVersion: " + results[i].addresses[j].ipVersion + "\n";
					
					if((results[i].addresses[j].broadcast == iAddr.broadcast) && (results[i].active)){
						trace("same broadcast");
						return;
					}
					
					if(results[i].active && results[i].addresses[j].broadcast)
					{
						
						newiAddr = results[i].addresses[j];
						
					
					}
				}
				
				output += "\n";
				iAddr = newiAddr;
				trace("broadcast updated");
				}
		}
		private function calculateInterfaceAddress():void{
			var output:String;
			var results:Vector.<NetworkInterface> = NetworkInfo.networkInfo.findInterfaces();
			
			
			for(var i:int = 0; i < results.length;i++)
			{
				output = output
					+ "Name: " + results[i].name + "\n"
					+ "DisplayName: " + results[i].displayName + "\n"
					+ "MTU: " + results[i].mtu + "\n"
					+ "HardwareAddr: " + results[i].hardwareAddress + "\n"
					+ "Active: " + results[i].active + "\n";
				
				for(var j:int = 0; j<results[i].addresses.length; j++)
				{
					output = output
						+ "Addr: " + results[i].addresses[j].address + "\n"
						+ "Broadcast: " + results[i].addresses[j].broadcast + "\n"
						+ "PrefixLength: " + results[i].addresses[j].prefixLength + "\n"
						+ "IPVersion: " + results[i].addresses[j].ipVersion + "\n";
					
					if(results[i].active && results[i].addresses[j].broadcast)
					{
						trace("\n--------------------------");
						iAddr = results[i].addresses[j];
						
						trace("enabled addr: " +  iAddr.broadcast);
						trace("\n--------------------------");
					}
				}
				
				output += "\n";
			
			}
			trace(output);
		}
	}
}