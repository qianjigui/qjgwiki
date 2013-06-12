<map version="0.9.0">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1364476063773" ID="ID_767118317" MODIFIED="1371017804057" TEXT="SystemServer">
<node CREATED="1364476098851" ID="ID_1474480407" MODIFIED="1364476102929" POSITION="right" TEXT="PackageManagerService">
<node CREATED="1364476110116" ID="ID_1830481345" MODIFIED="1364476255351" TEXT="http://blog.sina.com.cn/s/blog_3e3fcadd01014678.html">
<node CREATED="1364476114944" ID="ID_1833700996" MODIFIED="1364476119194" TEXT="PackageManger"/>
<node CREATED="1364476119460" ID="ID_140909108" MODIFIED="1364476121444" TEXT="Permission"/>
</node>
<node CREATED="1364476260429" ID="ID_1565273986" MODIFIED="1364476263585" TEXT="Main Tasks">
<node CREATED="1364476284632" ID="ID_160018582" MODIFIED="1364476285179" TEXT="&#x5efa;&#x7acb;installer&#x4e0e;installd&#x7684;socket&#x8fde;&#x63a5;"/>
<node CREATED="1364476289257" ID="ID_1565089846" MODIFIED="1364476289773" TEXT="&#x5efa;&#x7acb;PackageHandler&#x6d88;&#x606f;&#x5faa;&#x73af;: &#x7528;&#x4e8e;&#x5904;&#x7406;&#x5916;&#x90e8;&#x7684;apk&#x5b89;&#x88c5;&#x7b49;&#x8bf7;&#x6c42;"/>
<node CREATED="1364476293929" ID="ID_1580732438" MODIFIED="1364476294335" TEXT="&#x89e3;&#x6790;/system/etc/permissionsetc/permissions/&quot;&#xff08;&#x4e00;&#x822c;&#x5c31;&#x662f;/system/etc/permissions&#xff09;&#x4e0b;&#x7684;&#x5404;&#x4e2a;.xml&#x6587;&#x4ef6;&#x4e2d;&#x8bfb;&#x53d6;&#x7cfb;&#x7edf;&#x7684;&#x57fa;&#x672c;permissions&#xff0c;&#x800c;&#x4e14;&#x6587;&#x4ef6;platform.xml&#x5728;&#x6700;&#x540e;&#x8bfb;&#xff0c;&#x8868;&#x660e;&#x5176;&#x4f18;&#x5148;&#x7ea7;&#x6700;&#x9ad8;">
<node CREATED="1364476298710" ID="ID_1063899805" MODIFIED="1364476299210" TEXT="Android&#x7684;&#x57fa;&#x672c;permission&#x3001;Linux gid(s)&#x3001;&#x4ee5;&#x53ca;&#x5b83;&#x4eec;&#x7684;&#x5bf9;&#x5e94;&#x5173;&#x7cfb; -- mSettings.mPermissions&#xff0c; mGlobalGids"/>
<node CREATED="1364476302351" ID="ID_1868866619" MODIFIED="1364476302851" TEXT="&#x4e3a;Android permission&#x6307;&#x5b9a;&#x7684;Linux uid   --  mSystemPermissions"/>
<node CREATED="1364476306398" ID="ID_1777923861" MODIFIED="1364476306944" TEXT="&#x4e3a;Android&#x6240;&#x589e;&#x52a0;&#x7684;&#x5e94;&#x7528;&#x9700;&#x8981;&#x94fe;&#x63a5;&#x7684;java&#x5e93;&#x7684;&#x540d;&#x79f0;&#x548c;&#x5168;&#x8def;&#x5f84;  --  mSharedLibraries"/>
<node CREATED="1364476310148" ID="ID_912062178" MODIFIED="1364476310679" TEXT="&#x7cfb;&#x7edf;&#x6240;&#x652f;&#x6301;&#x7684;&#x5404;&#x79cd;&#x786c;&#x4ef6;&#x6a21;&#x5757;&#x7684;feature(&#x672a;&#x89c1;&#x5177;&#x4f53;&#x5b9e;&#x4f8b;&#xff0c;&#x636e;&#x4ee3;&#x7801;&#x53ef;&#x77e5;&#xff0c;&#x8fd9;&#x53ea;&#x662f;&#x4e00;&#x4e2a;&#x540d;&#x5b57;) -- mAvailableFeatures"/>
</node>
<node CREATED="1364476311804" ID="ID_1949986418" MODIFIED="1364476319413" TEXT="&#x89e3;&#x6790;/data/system/packages.xml&#x6587;&#x4ef6;"/>
<node CREATED="1364476322335" ID="ID_437464966" MODIFIED="1364476322788" TEXT="&#x5bf9;jar&#x8fdb;&#x884c;dexopt&#x4f18;&#x5316;"/>
<node CREATED="1364476328304" ID="ID_212046416" MODIFIED="1364476328773" TEXT="&#x901a;&#x8fc7;ScanDirLI()&#x626b;&#x63cf;&#x5e76;&#x89e3;&#x6790;&#x5f53;&#x524d;&#x5df2;&#x5b58;&#x5728;&#x7684;apk"/>
<node CREATED="1364476333366" ID="ID_951079635" MODIFIED="1364476334523" TEXT="&#x5c06;&#x89e3;&#x6790;/&#x5b89;&#x88c5;&#x7684;.apk&#x4fe1;&#x606f;&#x4fdd;&#x5b58;&#x5230;/data/system/packages.xml&#x548c;/data/system/packages.lst&#x6587;&#x4ef6;&#x4ee5;&#x5907;&#x67e5;&#x8be2;"/>
</node>
</node>
<node CREATED="1366003396676" ID="ID_1226061651" MODIFIED="1366003406191" POSITION="left" TEXT="tags:Android SystemServer PackageManager"/>
<node CREATED="1369658756952" ID="ID_1987383606" MODIFIED="1369658760873" POSITION="right" TEXT="HowToStart">
<node CREATED="1355406549423" ID="ID_1904075238" MODIFIED="1355406550505" TEXT="RuntimeInit.zygoteInit">
<node CREATED="1355406718281" ID="ID_629318682" MODIFIED="1369658800686" TEXT="&#x8c03;&#x7528; com.android.server.SystemServer&#x7c7b;&#x7684;main&#x51fd;&#x6570; ">
<node CREATED="1369658867091" ID="ID_15095877" MODIFIED="1369658869373" TEXT="init1">
<node CREATED="1369658919279" ID="ID_1473830463" MODIFIED="1369658932872" TEXT="system_init(System_init.cpp)">
<node CREATED="1369719601271" ID="ID_307753104" MODIFIED="1369719609708" TEXT="Start Surface Flinger"/>
<node CREATED="1369719615958" ID="ID_454514930" MODIFIED="1369719620239" TEXT="Start Sensor Service"/>
<node CREATED="1369719698099" ID="ID_1677510696" MODIFIED="1369719701833" TEXT="com/android/server/SystemServer::init2">
<node CREATED="1369719760989" ID="ID_21713355" MODIFIED="1369719761458" TEXT="Thread thr = new ServerThread();"/>
<node CREATED="1369719762005" ID="ID_629512981" MODIFIED="1369719856380" TEXT="thr.start">
<arrowlink DESTINATION="ID_1034105861" ENDARROW="Default" ENDINCLINATION="964;0;" ID="Arrow_ID_917088078" STARTARROW="None" STARTINCLINATION="964;0;"/>
</node>
</node>
<node CREATED="1369719711349" ID="ID_994677247" MODIFIED="1369719711958" TEXT="ProcessState::self()-&gt;startThreadPool();"/>
<node CREATED="1369719717114" ID="ID_1141928693" MODIFIED="1369719718255" TEXT="IPCThreadState::self()-&gt;joinThreadPool();"/>
</node>
</node>
</node>
</node>
<node CREATED="1369719841083" ID="ID_1034105861" MODIFIED="1369719856380" TEXT="thr.start">
<node CREATED="1369719859505" ID="ID_155128252" MODIFIED="1369719871989" TEXT="ServerThread::run"/>
</node>
</node>
<node CREATED="1371017805495" ID="ID_1330306919" MODIFIED="1371017807370" POSITION="left" TEXT="Debug">
<node CREATED="1371017808604" ID="ID_1148958922" MODIFIED="1371017811120" TEXT="Crash">
<node CREATED="1371017828401" ID="ID_1718504272" MODIFIED="1371017829010" TEXT="System server fault">
<node CREATED="1371017838025" ID="ID_1442205832" MODIFIED="1371017855806" TEXT="Zygote&#x4f1a;&#x91cd;&#x65b0;&#x542f;&#x52a8;SystemServer"/>
<node CREATED="1371017859884" ID="ID_306352396" MODIFIED="1371017864166" TEXT="&#x4e3b;&#x8981;&#x539f;&#x56e0;">
<node CREATED="1371017932508" ID="ID_126228920" MODIFIED="1371017935008" TEXT="Watchdog">
<node CREATED="1371017943555" ID="ID_453152888" MODIFIED="1371017944024" TEXT="killed a system_server process because of deadlock in of services it&apos;s running"/>
<node CREATED="1371017982023" ID="ID_1863799878" MODIFIED="1371017982539" TEXT="In rare cases watchdog can be timed out because of high memory and CPU usage."/>
<node CREATED="1371018011273" ID="ID_302549709" MODIFIED="1371018017711" TEXT="&#x5b58;&#x5728;&#x5f62;&#x5f0f;">
<node CREATED="1371018555384" ID="ID_216110283" MODIFIED="1371018560041" TEXT="system_process thread">
<node CREATED="1371018560650" ID="ID_517263383" MODIFIED="1371018562494" TEXT="watchdog">
<node CREATED="1371018564791" ID="ID_513565679" MODIFIED="1371018572870" TEXT="com.android.server.Watchdog.run"/>
</node>
</node>
</node>
</node>
<node CREATED="1371017954398" ID="ID_1670809329" MODIFIED="1371017954930" TEXT="Fatal exception occured in one of system services">
<node CREATED="1371017963883" ID="ID_33482671" MODIFIED="1371017964601" TEXT="a hardware issue"/>
</node>
</node>
</node>
<node CREATED="1371018065788" ID="ID_1213490611" MODIFIED="1371018066320" TEXT="Kernel panic">
<node CREATED="1371018184022" ID="ID_1405878394" MODIFIED="1371018187381" TEXT="Device reboot"/>
<node CREATED="1371018188444" ID="ID_26738874" MODIFIED="1371018189491" TEXT="dmesg"/>
</node>
</node>
</node>
</node>
</map>
