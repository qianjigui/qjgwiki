<map version="0.9.0">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1311254200226" ID="ID_1087536524" MODIFIED="1367660053275" TEXT="OpenMP">
<node CREATED="1311254251974" ID="ID_1100983390" MODIFIED="1311254255849" POSITION="right" TEXT="&#x57fa;&#x672c;&#x539f;&#x7406;">
<node CREATED="1311254256562" ID="ID_1953246059" MODIFIED="1311254264691" TEXT="Fork/Join&#x591a;&#x7ebf;&#x7a0b;&#x6a21;&#x578b;"/>
<node CREATED="1311254265087" ID="ID_1329908165" MODIFIED="1311254292688" TEXT="&#x5728;&#x7ebf;&#x7a0b;&#x7ea7;&#x522b;&#x91c7;&#x7528;*&#x5171;&#x4eab;&#x5185;&#x5b58;*&#x5e76;&#x884c;&#x8ba1;&#x7b97;&#x6a21;&#x578b;"/>
<node CREATED="1311254304936" ID="ID_1187233815" MODIFIED="1311254338393" TEXT="&#x7a0b;&#x5e8f;&#x5458;&#x9700;&#x8981;&#x81ea;&#x6211;&#x5904;&#x7406;&#x597d;&#x5e76;&#x884c;&#x903b;&#x8f91;&#x95ee;&#x9898;"/>
</node>
<node CREATED="1311254370070" ID="ID_870655033" MODIFIED="1311254374745" POSITION="left" TEXT="&#x57fa;&#x7840;API">
<node CREATED="1311254392898" ID="ID_527892936" MODIFIED="1311254423290" TEXT="Construct&#x6784;&#x5efa;&#x8bed;&#x53e5;(&#x548c;&#x7f16;&#x7a0b;&#x8bed;&#x53e5;&#x4e00;&#x6837;&#xff0c;&#x5f15;&#x5bfc;&#x7f16;&#x8bd1;&#x5668;&#x505a;&#x5904;&#x7406;)">
<node CREATED="1311254425569" ID="ID_628206285" MODIFIED="1311257151985" TEXT="Parallel&#x58f0;&#x660e;&#x4e0b;&#x9762;&#x7684;&#x4ee3;&#x7801;&#x5757;&#x5c06;&#x8fdb;&#x884c;&#x5e76;&#x884c;&#x5904;&#x7406;">
<node CREATED="1311255709334" ID="ID_784898654" MODIFIED="1311255911524">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <b>#pragma omp parallel</b>&#160;<i>[clause[[,] clause]...]</i>
    </p>
    <p>
      &#160;&#160;&#160; <i>structured block</i>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1311274723975" ID="ID_1057604326" MODIFIED="1311274728679" TEXT="clauses">
<node CREATED="1311274748116" ID="ID_1268712881" MODIFIED="1311274760378" TEXT="if(scalar-expression)"/>
<node CREATED="1311274786207" ID="ID_75758067" MODIFIED="1311274800151" TEXT="num_threads(integer-expression)"/>
<node CREATED="1311274800884" ID="ID_680776796" MODIFIED="1311274805414" TEXT="private(list)"/>
<node CREATED="1311274805710" ID="ID_109900500" MODIFIED="1311274811566" TEXT="firstprivate(list)"/>
<node CREATED="1311274812108" ID="ID_134286608" MODIFIED="1311274822599" TEXT="shared(list)"/>
<node CREATED="1311274822895" ID="ID_264207989" MODIFIED="1311274834115" TEXT="default(none|shared)"/>
<node CREATED="1311274834460" ID="ID_1841389363" MODIFIED="1311274840756" TEXT="copyin(list)"/>
<node CREATED="1311274841056" ID="ID_740615793" MODIFIED="1311274850281" TEXT="reduction(operator:list)"/>
</node>
</node>
<node CREATED="1311254431628" ID="ID_386925736" MODIFIED="1311257181076" TEXT="Work-Sharing&#x4ee5;&#x4e0b;&#x4ee3;&#x7801;&#x5c06;&#x8fdb;&#x884c;&#x591a;&#x7ebf;&#x7a0b;&#x6539;&#x5199;">
<node CREATED="1311257184721" ID="ID_666043063" MODIFIED="1311257215605" TEXT="iterations over the threads &#x4e0d;&#x4f9d;&#x8d56;&#x8fed;&#x4ee3;">
<node CREATED="1311257257050" ID="ID_720247660" MODIFIED="1311274555721">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <b>#pragma omp for </b><i>[clause[[,] clause]...] </i>
    </p>
    <p>
      &#160;&#160;&#160;&#160;<i>for-loop</i>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1311274859153" ID="ID_627817025" MODIFIED="1311274862247" TEXT="clauses">
<node CREATED="1311274886319" ID="ID_1362875657" MODIFIED="1311274890046" TEXT="private(list)"/>
<node CREATED="1311274891877" ID="ID_1169926233" MODIFIED="1311274897744" TEXT="firstprivate(list)"/>
<node CREATED="1311274898266" ID="ID_1900260359" MODIFIED="1311274904851" TEXT="lastprivate(list)"/>
<node CREATED="1311274905161" ID="ID_1689432820" MODIFIED="1311274911964" TEXT="reduction(operator:list)"/>
<node CREATED="1311274912360" ID="ID_1307374038" MODIFIED="1311274916975" TEXT="ordered"/>
<node CREATED="1311274917286" ID="ID_104405635" MODIFIED="1311274939567" TEXT="schedule(kind`[`,chunk_size`]`)"/>
<node CREATED="1311274940149" ID="ID_1974496496" MODIFIED="1311274943228" TEXT="nowait"/>
</node>
</node>
<node CREATED="1311257192535" ID="ID_763206218" MODIFIED="1311257225267" TEXT="independent work units&#x76f8;&#x4e92;&#x72ec;&#x7acb;&#x7684;&#x4ee3;&#x7801;&#x5355;&#x5143;">
<node CREATED="1311257257050" ID="ID_1591262793" MODIFIED="1311274594596">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <b>#pragma omp sections </b><i>[clause[[,] clause]...] </i>
    </p>
    <p>
      &#160;{
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;[<b>#pragma omp section</b>]
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;structured block
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;[<b>#pragma omp section</b>]
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;structured block
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;......
    </p>
    <p>
      &#160;&#160;}
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1311274985088" ID="ID_592346694" MODIFIED="1311274988190" TEXT="clauses">
<node CREATED="1311274989114" ID="ID_1319397379" MODIFIED="1311274993411" TEXT="private(list)"/>
<node CREATED="1311274993838" ID="ID_1799543590" MODIFIED="1311274998643" TEXT="firstprivate(list)"/>
<node CREATED="1311274998984" ID="ID_1670452537" MODIFIED="1311275003682" TEXT="lastprivate(list)"/>
<node CREATED="1311275003956" ID="ID_1294712119" MODIFIED="1311275010483" TEXT="reduction(operator:list)"/>
<node CREATED="1311275010824" ID="ID_1220500141" MODIFIED="1311275013711" TEXT="nowait"/>
</node>
</node>
<node CREATED="1311257226408" ID="ID_788966758" MODIFIED="1311257252431" TEXT="Only one thread executes the code block&#x53ea;&#x6709;&#x4e00;&#x4e2a;&#x7ebf;&#x7a0b;&#x8fd0;&#x884c;&#x7684;&#x4ee3;&#x7801;&#x5355;&#x5143;">
<node CREATED="1311257257050" ID="ID_1660604550" MODIFIED="1311274605758">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <b>#pragma omp single </b><i>[clause[[,] clause] ...] </i>
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;<i>structured block</i>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1311275029994" ID="ID_1309371516" MODIFIED="1311275035434" TEXT="clauses">
<node CREATED="1311275036300" ID="ID_1317665760" MODIFIED="1311275039705" TEXT="private(list)"/>
<node CREATED="1311275040001" ID="ID_399043603" MODIFIED="1311275044988" TEXT="firstprivate(list)"/>
<node CREATED="1311275045262" ID="ID_1185482239" MODIFIED="1311275051320" TEXT="copyprivate(list)"/>
<node CREATED="1311275051595" ID="ID_1694432213" MODIFIED="1311275052841" TEXT="nowait"/>
</node>
</node>
<node CREATED="1311257521388" ID="ID_8061124" MODIFIED="1311257528355" TEXT="Combined Parallel"/>
</node>
<node CREATED="1311254435299" ID="ID_180751899" MODIFIED="1311371829617" TEXT="Synchronization&#x7528;&#x4e8e;&#x7ebf;&#x7a0b;&#x540c;&#x6b65;">
<node CREATED="1311371839652" ID="ID_1121450710" MODIFIED="1311371852807" TEXT="barrier">
<node CREATED="1311371854686" ID="ID_1314419406" MODIFIED="1311371859174" TEXT="#pragma omp barrier"/>
<node CREATED="1311371865101" ID="ID_1179594756" MODIFIED="1311371888543" TEXT="&#x8fd9;&#x6b64;&#x5904;&#x6240;&#x6709;&#x7ebf;&#x7a0b;&#x5168;&#x90e8;&#x6267;&#x884c;&#x5b8c;&#xff0c;&#x540c;&#x6b65;&#x540e;&#x7ee7;&#x7eed;&#x6267;&#x884c;"/>
</node>
<node CREATED="1311371896501" ID="ID_1381469070" MODIFIED="1311371899861" TEXT="Ordered">
<node CREATED="1311371913080" ID="ID_1378383623" MODIFIED="1311371956168">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <b>#pragma</b>&#160;<b>omp</b>&#160;<b>ordered</b>
    </p>
    <p>
      &#160;&#160;&#160;&#160; <i>structured block</i>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1311372066990" ID="ID_1902840735" MODIFIED="1311372068221" TEXT="&#x6307;&#x5b9a;&#x63a5;&#x4e0b;&#x4f86;&#x88ab;&#x7a0b;&#x5f0f;&#xff0c;&#x5728;&#x88ab;&#x5e73;&#x884c;&#x5316;&#x7684; for &#x8ff4;&#x5708;&#x5c07;&#x4f9d;&#x5e8f;&#x7684;&#x57f7;&#x884c;&#x3002; Specifies that code under a parallelized for loop should be executed like a sequential loop. "/>
</node>
<node CREATED="1311372076199" ID="ID_1895062273" MODIFIED="1311372079529" TEXT="critical">
<node CREATED="1311372081031" ID="ID_1516305058" MODIFIED="1311372147799">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <b>#pragma</b>&#160;<b>omp</b>&#160;<b>critical</b>&#160;<i>[(name)] </i>
    </p>
    <p>
      &#160;&#160;&#160;&#160; <i>structured block</i>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1311372153016" ID="ID_906969573" MODIFIED="1311372265810" TEXT="block&#x4e2d;&#x7684;&#x8bed;&#x53e5;&#x5c06;&#x901a;&#x8fc7;&#x9501;&#x673a;&#x5236;&#x6765;&#x7ef4;&#x62a4;&#x6267;&#x884c;&#x7684;&#x5355;&#x4e00;&#x6027;"/>
<node CREATED="1311372210479" ID="ID_984043041" MODIFIED="1311372228736" TEXT="&#x901a;&#x8fc7;&#x540d;&#x5b57;name&#x6765;&#x5b9e;&#x73b0;&#x4e0d;&#x540c;&#x5730;&#x65b9;&#x7684;&#x9501;&#x673a;&#x5236;"/>
</node>
<node CREATED="1311372240773" ID="ID_827007005" MODIFIED="1311372244581" TEXT="atomic">
<node CREATED="1311372267762" ID="ID_633177756" MODIFIED="1311372295437">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <b>#pragma</b>&#160;<b>omp</b>&#160;<b>atomic</b>
    </p>
    <p>
      &#160;&#160;&#160; <i>statement</i>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1311372296306" ID="ID_792518696" MODIFIED="1311372306707" TEXT="&#x8bed;&#x53e5;&#x539f;&#x5b50;&#x5316;&#x6267;&#x884c;"/>
</node>
<node CREATED="1311372317958" ID="ID_654730046" MODIFIED="1311372321202" TEXT="master">
<node CREATED="1311372324613" ID="ID_275108654" MODIFIED="1311372372930">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <b>#pragma</b>&#160;<b>omp</b>&#160;<b>master</b>
    </p>
    <p>
      &#160;&#160;&#160; <i>structured block</i>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1311372373815" ID="ID_1395054546" MODIFIED="1311372382674" TEXT="&#x53ea;&#x6709;&#x4e3b;&#x7ebf;&#x7a0b;&#x6267;&#x884c;"/>
</node>
</node>
</node>
<node CREATED="1311254448928" ID="ID_1657897954" MODIFIED="1311254476288" TEXT="Clauses&#x9644;&#x52a0;&#x4fee;&#x9970;&#x548c;&#x6761;&#x6b3e;">
<node CREATED="1311275066111" ID="ID_1525812033" MODIFIED="1311275070973" TEXT="shared(list)">
<node CREATED="1311275081059" ID="ID_216784158" MODIFIED="1311275099403" TEXT="&#x5229;&#x7528;&#x8fd9;&#x4e2a;&#x6709;&#x6548;&#x533a;&#x57df;&#x7684;&#x53d8;&#x91cf;"/>
<node CREATED="1311275099684" ID="ID_1133079160" MODIFIED="1311275106539" TEXT="&#x5229;&#x7528;&#x6307;&#x9488;&#x6765;&#x8fbe;&#x5230;&#x6548;&#x679c;"/>
</node>
<node CREATED="1311275112176" ID="ID_1019140478" MODIFIED="1311275115433" TEXT="private(list)">
<node CREATED="1311275116080" ID="ID_766655686" MODIFIED="1311275127043" TEXT="&#x5728;&#x5404;&#x81ea;&#x7ebf;&#x7a0b;&#x5185;&#x90e8;&#x521b;&#x5efa;&#x4e00;&#x4e2a;&#x526f;&#x672c;"/>
<node CREATED="1311275132459" ID="ID_108279782" MODIFIED="1311275139761" TEXT="&#x5229;&#x7528;&#x4f20;&#x503c;&#x7684;&#x6548;&#x679c;"/>
</node>
<node CREATED="1311275143706" ID="ID_833737897" MODIFIED="1311275147583" TEXT="lastprivate(list)">
<node CREATED="1311275151790" ID="ID_1551039736" MODIFIED="1311275182185" TEXT="&#x6309;&#x903b;&#x8f91;&#x5148;&#x540e;&#x5c06;&#x6700;&#x540e;&#x4e00;&#x4e2a;&#x88ab;&#x8d4b;&#x503c;&#x7684;&#x6570;&#x636e;&#x4f5c;&#x4e3a;&#x672c;&#x6570;&#x636e;&#x57df;&#x7684;&#x7ed3;&#x679c;"/>
</node>
<node CREATED="1311275187031" ID="ID_44574148" MODIFIED="1311275194041" TEXT="firstprivate(list)">
<node CREATED="1311275203277" ID="ID_1188768481" MODIFIED="1311275209070" TEXT="&#x7528;&#x4e8e;&#x521d;&#x59cb;&#x5316;"/>
<node CREATED="1311275209353" ID="ID_85561451" MODIFIED="1311275227663" TEXT="&#x5728;&#x5404;&#x4e2a;&#x7ebf;&#x7a0b;&#x4e2d;&#x53ef;&#x80fd;&#x9700;&#x8981;&#x7528;&#x5230;&#x5916;&#x9762;&#x7684;&#x521d;&#x59cb;&#x6570;&#x636e;"/>
</node>
<node CREATED="1311275241220" ID="ID_860560069" MODIFIED="1311275248930" TEXT="default(none|shared)">
<node CREATED="1311275251635" ID="ID_1989014717" MODIFIED="1311275264596" TEXT="&#x7ed9;&#x4e0b;&#x9762;&#x6240;&#x6709;&#x7684;&#x6570;&#x636e;&#x6307;&#x5b9a;&#x9ed8;&#x8ba4;&#x533a;&#x95f4;"/>
<node CREATED="1311275265012" ID="ID_1366430105" MODIFIED="1311275281651" TEXT="none:&#x4e0d;&#x6307;&#x5b9a;&#xff0c;&#x9700;&#x8981;&#x7a0b;&#x5e8f;&#x5458;&#x9010;&#x4e2a;&#x8bbe;&#x7f6e;"/>
<node CREATED="1311275281915" ID="ID_358873981" MODIFIED="1311275292036" TEXT="shared:&#x9ed8;&#x8ba4;&#x90fd;&#x4e3a;shared(....)"/>
</node>
<node CREATED="1311275309485" ID="ID_1260521232" MODIFIED="1311275311370" TEXT="nowait">
<node CREATED="1311275354637" ID="ID_1620680431" MODIFIED="1311275355701" TEXT="&#x5ffd;&#x7565; barrier&#xff08;&#x7b49;&#x5f85;&#xff09;&#x3002; Overrides the barrier implicit in a directive. "/>
</node>
<node CREATED="1311275440224" ID="ID_557967183" MODIFIED="1311275459417" TEXT="schedule(kind`[`,chunk_size`]`)">
<node CREATED="1311275460154" ID="ID_1300513937" MODIFIED="1311275461522" TEXT="kind">
<node CREATED="1311275462371" ID="ID_1493632343" MODIFIED="1311275472153" TEXT="&#x6709; dynamic&#x3001;guided&#x3001;runtime&#x3001;static &#x56db;&#x7a2e;&#x65b9;&#x6cd5;&#x3002;"/>
<node CREATED="1311275483898" ID="ID_1754198025" MODIFIED="1311275498310" TEXT="&#x5404;&#x4e2a;&#x7ebf;&#x7a0b;&#x7684;for&#x8fed;&#x4ee3;&#x8303;&#x56f4;"/>
</node>
<node CREATED="1311275473243" ID="ID_719735212" MODIFIED="1311275473814" TEXT="&#x8a2d;&#x5b9a; for &#x8ff4;&#x5708;&#x7684;&#x5e73;&#x884c;&#x5316;&#x65b9;&#x6cd5;&#xff1b;"/>
</node>
<node CREATED="1311372406596" ID="ID_544925194" MODIFIED="1311372421365" TEXT="if(scalar-logical-expression)"/>
<node CREATED="1311372428258" ID="ID_289229188" MODIFIED="1311372438164" TEXT="num_threads(scalar-integer-expression)"/>
<node CREATED="1311372447669" ID="ID_619979244" MODIFIED="1311372455031" TEXT="reduction(operator:list)">
<node CREATED="1311372455985" ID="ID_1875412181" MODIFIED="1311372502217" TEXT="operator:initial ization value">
<node CREATED="1311372488883" ID="ID_929888444" MODIFIED="1311372506633" TEXT="`*`:0"/>
<node CREATED="1311372507277" ID="ID_1205232730" MODIFIED="1311372526984" TEXT="`*`:1"/>
<node CREATED="1311372507277" ID="ID_112871023" MODIFIED="1311372532246" TEXT="`-`:0"/>
<node CREATED="1311372507277" ID="ID_338777555" MODIFIED="1311372547633" TEXT="`&amp;`:`~`0"/>
<node CREATED="1311372507277" ID="ID_1354264393" MODIFIED="1311372557654" TEXT="`|`:0"/>
<node CREATED="1311372507277" ID="ID_448303208" MODIFIED="1311372563704" TEXT="`^`:0"/>
<node CREATED="1311372507277" ID="ID_650874343" MODIFIED="1311372571373" TEXT="`&amp;&amp;`:1"/>
<node CREATED="1311372507277" ID="ID_165335805" MODIFIED="1311372576495" TEXT="`||`:0"/>
</node>
<node CREATED="1311442305143" ID="ID_1480502092" MODIFIED="1311442318763" TEXT="&#x5bf9;&#x4e8e;&#x7279;&#x6b8a;&#x7c7b;&#x578b;&#x8fd8;&#x662f;&#x5f97;&#x501f;&#x52a9;critical">
<node CREATED="1311442322924" ID="ID_830233061" MODIFIED="1311454961664">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      {% highlight html %}
    </p>
    <p>
      sum=0;
    </p>
    <p>
      #pragma omp parallel shared(n,a,sum) private(TID,sumLocal)
    </p>
    <p>
      {
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;TID = omp_get_thread_num();
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;sumLocal = 0;
    </p>
    <p>
      
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;#pragma omp for
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;for(i=0;i&lt;n;i++)
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;sumLocal += a[i];
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;#pragma omp critical (update_sum)
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;{
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;sum += sumLocal;
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;printf(&quot;TID=%d: sumLocal=%d sum=%d\n&quot;,TID,sumLocal,sum);
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;}
    </p>
    <p>
      }
    </p>
    <p>
      {% endhighlight %}
    </p>
  </body>
</html></richcontent>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1311275364328" ID="ID_153449745" MODIFIED="1311275368396" POSITION="right" TEXT="&#x5b66;&#x4e60;&#x8d44;&#x6e90;">
<node CREATED="1311275385907" ID="ID_1706241026" MODIFIED="1311373819667" TEXT="[OpenMP&#x7b80;&#x4ecb;&#x4e0e;&#x8bed;&#x6cd5;&#x8be6;&#x7ec6;&#x5217;&#x8868;](http://kheresy.wordpress.com/2006/06/09/&#x7c21;&#x6613;&#x7684;&#x7a0b;&#x5f0f;&#x5e73;&#x884c;&#x5316;&#x65b9;&#x6cd5;&#xff0d;openmp&#xff08;&#x4e00;&#xff09;&#x7c21;&#x4ecb;/)"/>
<node CREATED="1311373252066" ID="ID_1842661791" MODIFIED="1311373830872" TEXT="[OpenMp&#x7f16;&#x7a0b;&#x6750;&#x6599;&#x96c6;&#x5408;](http://www.cnblogs.com/me115/archive/2011/01/25/1944567.html)"/>
<node CREATED="1311373276300" ID="ID_1975021489" MODIFIED="1311373842891" TEXT="[OpenMP&#x5de5;&#x4f5c;&#x539f;&#x7406;](http://cobweb.ecn.purdue.edu/ParaMount/iwomp2008/documents/chapman-underthehood)"/>
</node>
<node CREATED="1367660054103" ID="ID_1037016713" MODIFIED="1367660063368" POSITION="left" TEXT="tags: MultiCPU"/>
</node>
</map>
