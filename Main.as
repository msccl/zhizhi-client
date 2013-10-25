package
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import ruiji.zhizhi.as3.IChat;
	import ruiji.zhizhi.as3.IFriend;
	import ruiji.zhizhi.as3.IMenu;
	import ruiji.zhizhi.as3.IMod;
	import ruiji.zhizhi.as3.ZZ;
	import ruiji.zhizhi.as3.ZZChat;
	import ruiji.zhizhi.event.AuthEvent;
	import ruiji.zhizhi.event.ModEvent;
	
	
	[SWF(width = "800", height = "480", backgroundColor = "#000000", frameRate = "40")]
	public class Main extends Sprite
	{
		public var demoItem:Class;
		
		public var Bg:Class; 
		private var zz:ZZ;
		private var mod:IMod;
		private var chat:IChat;
		private var friend:IFriend;
		private var menu:IMenu;
		
		public function Main()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			zz = new ZZ();
			//装载吱吱UI的容器， 游戏ID，游戏高，游戏宽， UI类
			zz.initSys( this, "a1",550, 400, {
				//菜单模块,聊天模块,好友模块,背包模块,商店模块是可自定义的模块，自定义位置的方法是,修改后面数组中的数据
				//例如："ChatPanel"  : [0,145]来表示ChatPanel的x,y坐标,0为默认位置
				//注册，登录，道具购买界面居中不可设置
				
				//菜单模块(包括大厅，商店，背包，好友面板的开关按钮)
				"MenuPanel" : [10,85],
				//退出登录按钮
				"Logout" : [10,125],
				//聊天模块
				"ChatPanel"  : [0,150],
				//聊天模块上部对齐位置
				"ChatTop":[0,150],//聊天框顶部对齐到的y坐标
				//好友模块
				"FriendPanel" : [300,0]}
				
			);
			//初始化完成后，还可以再动态设置各模块位置：
			zz.addEventListener(ModEvent.MOD_INITED,function (e:Event):void{
				mod = zz.Mod;
				chat = mod.getChat();
				friend = mod.getFriend();
				menu = mod.getMenu();
				
				//动态设置菜单坐标		
				menu.location(10,30);
				//动态设置退出按钮坐标
				menu.logLocation(10,70);
				//动态设置聊天界面位置
				chat.location(0,255);
				//动态设置聊天框缩放调节按钮位置
				chat.sizeTo(0,150);
				//动态设置好友面板坐标
				friend.location(300,0);
				
			});
			
			//登录成功后，可以获得用户信息
			zz.addEventListener(AuthEvent.LOGIN_SUCCEED,function (e:Event):void{
				var userinfo:Object = mod.getUser();
				trace(userinfo["name"],userinfo["uid"]);
			});
		}
		
		private function completeInit( iMod:Object ):void
		{
			// 设置道具图片读取的回叫函数
			//iMod.getBag().setGetImg(getItemImage);
			// 设置道具使用成功的回叫函数
			//iMod.getBag().useItemCallBack = useItemCallBack;
		}
		
		/**
		 * 客户端需要提供一个函数供IBag调用，调用时将提供一个参数id
		 * 即道具的id号，该函数需要根据id号返回客户端正确的位图数据
		 * 
		 * @param	id	道具id
		 */ 
		private function getItemImage(id:uint):BitmapData
		{
			return new demoItem().bitmapData;	
		}
		
		private function useItemCallBack(data:Object):void
		{
			trace("使用物品："+data.name,"道具id："+data.itemid,"道具说明："+data.info,"剩余数量："+data.num,"道具图像："+data.bitmap,"图像地址："+data.imgurl);
		}
	}
}