<map version="0.9.0">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1355235790870" ID="ID_1019984678" MODIFIED="1355235803874" TEXT="JavaHarmony">
<node CREATED="1355235824551" ID="ID_1554900448" MODIFIED="1355235851047" POSITION="right" TEXT="[ReadingRes](http://www.ibm.com/developerworks/cn/java/j-harmony/)"/>
<node CREATED="1355275383669" ID="ID_1168735380" MODIFIED="1355275386647" POSITION="left" TEXT="Background">
<node CREATED="1355275399710" ID="ID_700270842" MODIFIED="1355275400948" TEXT="Aim">
<node CREATED="1355275411597" ID="ID_367708010" MODIFIED="1355275413267" TEXT="&#x5f00;&#x53d1;&#x51fa;&#x4e00;&#x4e2a;&#x72ec;&#x7acb;&#x5e76;&#x4e14;&#x4e0e;&#x73b0;&#x6709; JDK &#x517c;&#x5bb9;&#x7684; Java SE 5 &#x5b9e;&#x73b0;&#xff0c;&#x5e76;&#x4e14;&#x4ee5; Apache &#x8f6f;&#x4ef6;&#x8bb8;&#x53ef;&#x8bc1; 2.0 &#x7248;&#x53d1;&#x884c;"/>
<node CREATED="1355275423765" ID="ID_71819222" MODIFIED="1355275425263" TEXT="&#x5efa;&#x7acb;&#x4e00;&#x4e2a;&#x5f00;&#x653e;&#x7684;&#x6a21;&#x5757;&#x5316;&#x8fd0;&#x884c;&#x65f6;&#x67b6;&#x6784;&#xff0c;&#x5305;&#x62ec;&#x865a;&#x62df;&#x673a;&#x548c;&#x7c7b;&#x5e93;&#x4e4b;&#x95f4;&#x53ca;&#x5176;&#x5185;&#x90e8;&#x7684;&#x6a21;&#x5757;&#x5316;&#xff0c;&#x5e76;&#x901a;&#x8fc7;&#x8fd9;&#x4e2a;&#x5e73;&#x53f0;&#xff0c;&#x5141;&#x8bb8;&#x793e;&#x533a;&#x5728;&#x6b64;&#x57fa;&#x7840;&#x4e0a;&#x81ea;&#x7531;&#x5b9a;&#x5236;&#x81ea;&#x5df1;&#x7684; Java &#x5b9e;&#x73b0;&#xff0c;&#x6216;&#x8005;&#x5bf9;&#x67d0;&#x4e2a;&#x6a21;&#x5757;&#x5355;&#x72ec;&#x8fdb;&#x884c;&#x521b;&#x65b0;"/>
</node>
<node CREATED="1355275436254" ID="ID_1446533784" MODIFIED="1355275439595" TEXT="Structure">
<node CREATED="1355275478214" ID="ID_161271234" MODIFIED="1355275487405" TEXT="![StructureImage](http://www.ibm.com/developerworks/cn/java/j-lo-harmony1/images/image002.jpg)"/>
<node CREATED="1355275503891" ID="ID_1744921443" MODIFIED="1355275508148" TEXT="ThreeLevels">
<node CREATED="1355275518143" ID="ID_166405256" MODIFIED="1355275520393" TEXT="OS"/>
<node CREATED="1355275520788" ID="ID_291337443" MODIFIED="1355275523131" TEXT="JVM"/>
<node CREATED="1355275526857" ID="ID_1580039531" MODIFIED="1355275530235" TEXT="Java Library"/>
</node>
<node CREATED="1355275542163" ID="ID_1445721025" MODIFIED="1355275545170" TEXT="Feature">
<node CREATED="1355275559184" ID="ID_1284804252" MODIFIED="1355275560141" TEXT="&#x865a;&#x62df;&#x673a;&#x548c;&#x7c7b;&#x5e93;&#x5185;&#x90e8;&#x88ab;&#x9ad8;&#x5ea6;&#x6a21;&#x5757;&#x5316;">
<node CREATED="1355275568122" ID="ID_1643290363" MODIFIED="1355275570492" TEXT="Library">
<node CREATED="1355275571191" ID="ID_660796272" MODIFIED="1355275571964" TEXT="&#x7c7b;&#x5e93;&#x5728;&#x529f;&#x80fd;&#x548c; Java Package &#x7684;&#x57fa;&#x7840;&#x4e0a;&#x88ab;&#x5206;&#x6210; 31 &#x4e2a;&#x6a21;&#x5757;"/>
</node>
<node CREATED="1355275579830" ID="ID_1001472332" MODIFIED="1355275581003" TEXT="JVM">
<node CREATED="1355275615779" ID="ID_80329101" MODIFIED="1355275616906" TEXT="JIT"/>
<node CREATED="1355275619715" ID="ID_1710921853" MODIFIED="1355275623142" TEXT="MemoryManager"/>
<node CREATED="1355275626400" ID="ID_1511324642" MODIFIED="1355275629716" TEXT="ThreadManager"/>
<node CREATED="1355275633436" ID="ID_1300777531" MODIFIED="1355275634570" TEXT="JNI"/>
</node>
<node CREATED="1355275650461" ID="ID_1276271162" MODIFIED="1355275651339" TEXT="&#x6bcf;&#x4e2a;&#x6a21;&#x5757;&#x90fd;&#x6709;&#x4e00;&#x5b9a;&#x7684;&#x63a5;&#x53e3;&#x5b9a;&#x4e49;&#xff0c;&#x4ece;&#x800c;&#x6709;&#x53ef;&#x80fd;&#x5355;&#x72ec;&#x88ab;&#x66ff;&#x6362;&#x6210;&#x4e0d;&#x540c;&#x7684;&#x5b9e;&#x73b0;"/>
</node>
<node CREATED="1355275668694" ID="ID_1779920979" MODIFIED="1355275669511" TEXT="Port Layer">
<node CREATED="1355275676340" ID="ID_1485368907" MODIFIED="1355275677262" TEXT="&#x64cd;&#x4f5c;&#x7cfb;&#x7edf;&#x5c42;&#x6b21;&#x4e0e;&#x865a;&#x62df;&#x673a;&#x5c42;&#x6b21;&#x4e4b;&#x95f4;&#x7684;&#x63a5;&#x53e3;"/>
<node CREATED="1355275686095" ID="ID_253093368" MODIFIED="1355275686892" TEXT="&#x5c01;&#x88c5;&#x4e86;&#x4e0d;&#x540c;&#x7684;&#x64cd;&#x4f5c;&#x7cfb;&#x7edf;&#x7684;&#x5dee;&#x5f02;&#xff0c;&#x4e3a;&#x865a;&#x62df;&#x673a;&#x548c;&#x7c7b;&#x5e93;&#x7684;&#x672c;&#x5730;&#x4ee3;&#x7801;&#x63d0;&#x4f9b;&#x4e86;&#x4e00;&#x5957;&#x7edf;&#x4e00;&#x7684; API &#x8bbf;&#x95ee;&#x5e95;&#x5c42;&#x7cfb;&#x7edf;&#x8c03;&#x7528;&#x3002;"/>
</node>
<node CREATED="1355275713655" ID="ID_151072911" MODIFIED="1355275716634" TEXT="VMI(&#x52a0;&#x5165;&#x4e86;&#x4e00;&#x5c42;&#x865a;&#x62df;&#x673a;&#x63a5;&#x53e3;&#x52a0;&#x5165;&#x4e86;&#x4e00;&#x5c42;&#x865a;&#x62df;&#x673a;&#x63a5;&#x53e3;)">
<node CREATED="1355275739815" ID="ID_950305244" MODIFIED="1355275740678" TEXT="&#x4e3b;&#x8981;&#x7531;&#x5185;&#x6838;&#x7c7b;&#xff08;Kernel Class&#xff09;&#x548c;&#x672c;&#x5730;&#x4ee3;&#x7801; VMI &#x7ec4;&#x6210;"/>
<node CREATED="1355275756402" ID="ID_865237895" MODIFIED="1355275757170" TEXT="&#x5b9e;&#x73b0;&#x4e86;&#x865a;&#x62df;&#x673a;&#x63a5;&#x53e3;&#x7684;&#x865a;&#x62df;&#x673a;&#x5b9e;&#x73b0;&#x90fd;&#x53ef;&#x4ee5;&#x4f7f;&#x7528; Harmony &#x7684;&#x7c7b;&#x5e93;&#x5b9e;&#x73b0;&#xff0c;&#x5e76;&#x4e14;&#x53ef;&#x4ee5;&#x88ab; Harmony &#x63d0;&#x4f9b;&#x7684;&#x540c;&#x4e00;&#x4e2a; Java &#x542f;&#x52a8;&#x7a0b;&#x5e8f;&#x542f;&#x52a8;"/>
</node>
</node>
</node>
</node>
<node CREATED="1355275586519" ID="ID_65172530" MODIFIED="1355275607082" POSITION="right" TEXT="tags: JVM Harmony JDK Java"/>
</node>
</map>
