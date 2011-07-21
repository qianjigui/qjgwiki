<map version="0.9.0">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1311254200226" ID="ID_1087536524" MODIFIED="1311254206960" TEXT="OpenMP">
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
</html>
</richcontent>
</node>
</node>
<node CREATED="1311254431628" ID="ID_386925736" MODIFIED="1311257181076" TEXT="Work-Sharing&#x4ee5;&#x4e0b;&#x4ee3;&#x7801;&#x5c06;&#x8fdb;&#x884c;&#x591a;&#x7ebf;&#x7a0b;&#x6539;&#x5199;">
<node CREATED="1311257184721" ID="ID_666043063" MODIFIED="1311257215605" TEXT="iterations over the threads &#x4e0d;&#x4f9d;&#x8d56;&#x8fed;&#x4ee3;">
<node CREATED="1311257257050" ID="ID_720247660" MODIFIED="1311257345436">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <b>#pragma omp for </b><i>[clause[[,] clause]...] </i>
    </p>
    <p>
      <i>&#160;&#160;&#160;&#160;for-loop</i>
    </p>
  </body>
</html>
</richcontent>
</node>
</node>
<node CREATED="1311257192535" ID="ID_763206218" MODIFIED="1311257225267" TEXT="independent work units&#x76f8;&#x4e92;&#x72ec;&#x7acb;&#x7684;&#x4ee3;&#x7801;&#x5355;&#x5143;">
<node CREATED="1311257257050" ID="ID_1591262793" MODIFIED="1311257435963">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <b>#pragma omp sections </b><i>[clause[[,] clause]...] </i>
    </p>
    <p>
      <i>{ </i>
    </p>
    <p>
      <i>&#160;&#160;&#160;&#160;&#160;[</i><b>#pragma omp section</b><i>] </i>
    </p>
    <p>
      <i>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;structured block </i>
    </p>
    <p>
      <i>&#160;&#160;&#160;&#160;&#160;[</i><b>#pragma omp section</b><i>] </i>
    </p>
    <p>
      <i>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;structured block </i>
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;......
    </p>
    <p>
      <i>}</i>
    </p>
  </body>
</html>
</richcontent>
</node>
</node>
<node CREATED="1311257226408" ID="ID_788966758" MODIFIED="1311257252431" TEXT="Only one thread executes the code block&#x53ea;&#x6709;&#x4e00;&#x4e2a;&#x7ebf;&#x7a0b;&#x8fd0;&#x884c;&#x7684;&#x4ee3;&#x7801;&#x5355;&#x5143;">
<node CREATED="1311257257050" ID="ID_1660604550" MODIFIED="1311257482118">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <b>#pragma omp single </b><i>[clause[[,] clause] ...] </i>
    </p>
    <p>
      <i>&#160;&#160;&#160;&#160;&#160;structured block</i>
    </p>
  </body>
</html>
</richcontent>
</node>
</node>
<node CREATED="1311257521388" ID="ID_8061124" MODIFIED="1311257528355" TEXT="Combined Parallel"/>
</node>
<node CREATED="1311254435299" ID="ID_180751899" MODIFIED="1311254441691" TEXT="Barrier"/>
</node>
<node CREATED="1311254448928" ID="ID_1657897954" MODIFIED="1311254476288" TEXT="Clauses&#x9644;&#x52a0;&#x4fee;&#x9970;&#x548c;&#x6761;&#x6b3e;"/>
</node>
</node>
</map>
