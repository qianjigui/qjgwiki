<map version="0.9.0">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1355405941649" ID="ID_631344100" MODIFIED="1355406032576" TEXT="Zygote">
<node CREATED="1355406007594" ID="ID_457699158" MODIFIED="1355406020812" POSITION="right" TEXT="tags: Android OS Zygote Startup"/>
<node CREATED="1355406033905" ID="ID_977934526" MODIFIED="1355406037211" POSITION="left" TEXT="From">
<node CREATED="1355406038314" ID="ID_1585371270" MODIFIED="1355406041641" TEXT="init process"/>
<node CREATED="1355406047826" ID="ID_1712269780" MODIFIED="1355406050632" TEXT="app_process"/>
</node>
<node CREATED="1355406075731" ID="ID_191431857" MODIFIED="1355406079043" POSITION="right" TEXT="Resources">
<node CREATED="1355406079732" ID="ID_1333205651" MODIFIED="1355406091106" TEXT="[Android&#x7cfb;&#x7edf;&#x8fdb;&#x7a0b;Zygote&#x542f;&#x52a8;&#x8fc7;&#x7a0b;&#x7684;&#x6e90;&#x4ee3;&#x7801;&#x5206;&#x6790;](http://blog.csdn.net/luoshengyang/article/details/6768304)"/>
<node CREATED="1355746891047" ID="ID_950908139" MODIFIED="1355746896514" TEXT="![Steps](http://pic.yupoo.com/qianjigui/CuRPLCqf/UhmYQ.png)"/>
</node>
<node CREATED="1355406123243" ID="ID_1534774886" MODIFIED="1355406125528" POSITION="left" TEXT="IPC">
<node CREATED="1355406127083" ID="ID_989818391" MODIFIED="1355406131875" TEXT="UNIX domain socket"/>
</node>
<node CREATED="1355406293125" ID="ID_1840793574" MODIFIED="1355406294892" POSITION="left" TEXT="Steps">
<node CREATED="1355406295896" ID="ID_681868926" MODIFIED="1355406296810" TEXT="app_process.main">
<node CREATED="1355406307643" ID="ID_1379964178" MODIFIED="1355406308606" TEXT="&#x521b;&#x5efa;&#x4e00;&#x4e2a;AppRuntime&#x53d8;&#x91cf;"/>
</node>
<node CREATED="1355406319721" ID="ID_1551867080" MODIFIED="1355406320736" TEXT="AndroidRuntime.start">
<node CREATED="1355406331544" ID="ID_1807680987" MODIFIED="1355406333493" TEXT="&#x542f;&#x52a8;Android&#x7cfb;&#x7edf;&#x8fd0;&#x884c;&#x65f6;&#x5e93;"/>
<node CREATED="1355406333912" ID="ID_70189313" MODIFIED="1355406338338" TEXT="Work">
<node CREATED="1355406348074" ID="ID_1242392800" MODIFIED="1355406349264" TEXT="&#x8c03;&#x7528;&#x51fd;&#x6570;startVM&#x542f;&#x52a8;&#x865a;&#x62df;&#x673a;"/>
<node CREATED="1355406355349" ID="ID_1356256127" MODIFIED="1355406356662" TEXT="&#x8c03;&#x7528;&#x51fd;&#x6570;startReg&#x6ce8;&#x518c;JNI&#x65b9;&#x6cd5;"/>
<node CREATED="1355406363487" ID="ID_405278842" MODIFIED="1355406364516" TEXT="&#x8c03;&#x7528;&#x4e86;com.android.internal.os.ZygoteInit&#x7c7b;&#x7684;main&#x51fd;&#x6570;"/>
</node>
</node>
<node CREATED="1355406374140" ID="ID_35157551" MODIFIED="1355406375217" TEXT="ZygoteInit.main">
<node CREATED="1355406387555" ID="ID_1124882460" MODIFIED="1355406388668" TEXT="&#x8c03;&#x7528;registerZygoteSocket&#x51fd;&#x6570;&#x521b;&#x5efa;&#x4e86;&#x4e00;&#x4e2a;socket&#x63a5;&#x53e3;&#xff0c;&#x7528;&#x6765;&#x548c;ActivityManagerService&#x901a;&#x8baf;"/>
<node CREATED="1355406396357" ID="ID_859475971" MODIFIED="1355406397392" TEXT="&#x8c03;&#x7528;startSystemServer&#x51fd;&#x6570;&#x6765;&#x542f;&#x52a8;SystemServer&#x7ec4;&#x4ef6;"/>
<node CREATED="1355406406766" ID="ID_1119421569" MODIFIED="1355406407868" TEXT="&#x8c03;&#x7528;runSelectLoopMode&#x51fd;&#x6570;&#x8fdb;&#x5165;&#x4e00;&#x4e2a;&#x65e0;&#x9650;&#x5faa;&#x73af;&#x5728;&#x524d;&#x9762;&#x521b;&#x5efa;&#x7684;socket&#x63a5;&#x53e3;&#x4e0a;&#x7b49;&#x5f85;ActivityManagerService&#x8bf7;&#x6c42;&#x521b;&#x5efa;&#x65b0;&#x7684;&#x5e94;&#x7528;&#x7a0b;&#x5e8f;&#x8fdb;&#x7a0b;"/>
</node>
<node CREATED="1355406480915" ID="ID_1544944816" MODIFIED="1355406482024" TEXT="ZygoteInit.registerZygoteSocket"/>
<node CREATED="1355406495091" ID="ID_403556068" MODIFIED="1355406496127" TEXT="ZygoteInit.startSystemServer"/>
<node CREATED="1355406523938" ID="ID_1214230557" MODIFIED="1355406525015" TEXT="ZygoteInit.handleSystemServerProcess">
<node CREATED="1355406598104" ID="ID_365371106" MODIFIED="1355406614272" TEXT="SystemServer&#x4e0d;&#x9700;&#x8981;socket&#x901a;&#x4fe1;&#xff0c;&#x5173;&#x95ed;socket"/>
</node>
<node CREATED="1355406549423" ID="ID_1904075238" MODIFIED="1355406550505" TEXT="RuntimeInit.zygoteInit">
<node CREATED="1355406664422" ID="ID_354227875" MODIFIED="1355406665515" TEXT="&#x8c03;&#x7528;zygoteInitNative&#x51fd;&#x6570;&#x6765;&#x6267;&#x884c;&#x4e00;&#x4e2a;Binder&#x8fdb;&#x7a0b;&#x95f4;&#x901a;&#x4fe1;&#x673a;&#x5236;&#x7684;&#x521d;&#x59cb;&#x5316;&#x5de5;&#x4f5c;"/>
<node CREATED="1355406718281" ID="ID_629318682" MODIFIED="1355406719051" TEXT="&#x8c03;&#x7528;&#x4e0a;&#x9762;Step 5&#x4f20;&#x8fdb;&#x6765;&#x7684;com.android.server.SystemServer&#x7c7b;&#x7684;main&#x51fd;&#x6570; "/>
</node>
<node CREATED="1355406709665" ID="ID_309690597" MODIFIED="1355406712105" TEXT="RuntimeInit.zygoteInitNative"/>
<node CREATED="1355406737548" ID="ID_1467248899" MODIFIED="1355406738590" TEXT=" SystemServer.main"/>
<node CREATED="1355406760397" ID="ID_187436455" MODIFIED="1355406761454" TEXT="ZygoteInit.runSelectLoopMode"/>
</node>
</node>
</map>
