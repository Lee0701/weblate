// Conv-4x3x3x8 (5)
// ��ֲ�� https://github.com/bloc97/Anime4K/blob/master/glsl/Upscale/Anime4K_Upscale_CNN_M_x2.glsl
//
// Anime4K-v3.1-Upscale(x2)-CNN(M)-Conv-4x3x3x8


cbuffer constants : register(b0) {
	int2 srcSize : packoffset(c0);
};


#define D2D_INPUT_COUNT 1
#define D2D_INPUT0_COMPLEX
#define MAGPIE_USE_SAMPLE_INPUT
#include "Anime4K.hlsli"


D2D_PS_ENTRY(main) {
	InitMagpieSampleInput();

	float left1X = GetCheckedLeft(1);
	float right1X = GetCheckedRight(1);
	float top1Y = GetCheckedTop(1);
	float bottom1Y = GetCheckedBottom(1);

	// [ a, d, g ]
	// [ b, e, h ]
	// [ c, f, i ]
	float4 a = Uncompress(SampleInputRGBANoCheck(0, float2(left1X, top1Y)));
	float4 b = Uncompress(SampleInputRGBANoCheck(0, float2(left1X, coord.y)));
	float4 c = Uncompress(SampleInputRGBANoCheck(0, float2(left1X, bottom1Y)));
	float4 d = Uncompress(SampleInputRGBANoCheck(0, float2(coord.x, top1Y)));
	float4 e = Uncompress(SampleInputRGBACur(0));
	float4 f = Uncompress(SampleInputRGBANoCheck(0, float2(coord.x, bottom1Y)));
	float4 g = Uncompress(SampleInputRGBANoCheck(0, float2(right1X, top1Y)));
	float4 h = Uncompress(SampleInputRGBANoCheck(0, float2(right1X, coord.y)));
	float4 i = Uncompress(SampleInputRGBANoCheck(0, float2(right1X, bottom1Y)));

	float4 na = -min(a, ZEROS4);
	float4 nb = -min(b, ZEROS4);
	float4 nc = -min(c, ZEROS4);
	float4 nd = -min(d, ZEROS4);
	float4 ne = -min(e, ZEROS4);
	float4 nf = -min(f, ZEROS4);
	float4 ng = -min(g, ZEROS4);
	float4 nh = -min(h, ZEROS4);
	float4 ni = -min(i, ZEROS4);

	a = max(a, ZEROS4);
	b = max(b, ZEROS4);
	c = max(c, ZEROS4);
	d = max(d, ZEROS4);
	e = max(e, ZEROS4);
	f = max(f, ZEROS4);
	g = max(g, ZEROS4);
	h = max(h, ZEROS4);
	i = max(i, ZEROS4);

	float s = 0.00025631802 * a.x + 0.057320878 * b.x + -0.041412644 * c.x + 0.16791897 * d.x + 0.16617729 * e.x + -0.48703465 * f.x + -0.12931561 * g.x + 0.4140343 * h.x + -0.33470672 * i.x;
	float t = 0.03830889 * a.y + -0.051282525 * b.y + 0.09902938 * c.y + 0.051170327 * d.y + -1.0059495 * e.y + 0.3998207 * f.y + -0.026771523 * g.y + -0.23292333 * h.y + 0.23323184 * i.y;
	float u = 0.033804324 * a.z + -0.16789144 * b.z + 0.11551676 * c.z + 0.2096383 * d.z + -0.5732962 * e.z + 0.37778842 * f.z + -0.035116088 * g.z + 0.089063995 * h.z + 0.070677355 * i.z;
	float v = 0.22857346 * a.w + -0.079091504 * b.w + -0.31563935 * c.w + 0.5057771 * d.w + -1.3217461 * e.w + -0.12721835 * f.w + 0.16177909 * g.w + -0.2629097 * h.w + -0.0029459773 * i.w;
	float w = -0.030586343 * na.x + -0.13376898 * nb.x + 0.13974473 * nc.x + -0.24266301 * nd.x + -0.11947399 * ne.x + 0.19367288 * nf.x + -0.34237102 * ng.x + 0.3096073 * nh.x + 0.043135814 * ni.x;
	float x = -0.14012407 * na.y + 0.016800448 * nb.y + 0.1570266 * nc.y + 0.7430246 * nd.y + -0.005562219 * ne.y + 0.26139715 * nf.y + 0.64244574 * ng.y + -0.51432157 * nh.y + -0.114942044 * ni.y;
	float y = -0.10178008 * na.z + 0.23307206 * nb.z + -0.29321644 * nc.z + 0.24498452 * nd.z + -1.1282628 * ne.z + 0.022412058 * nf.z + -0.16838956 * ng.z + 0.40056717 * nh.z + -0.21463306 * ni.z;
	float z = -1.005476 * na.w + 0.8050052 * nb.w + 0.12235334 * nc.w + -0.6732282 * nd.w + 0.3369146 * ne.w + 0.06454999 * nf.w + -0.17765191 * ng.w + 0.10384625 * nh.w + -0.11302512 * ni.w;
	float o = s + t + u + v + w + x + y + z + -0.061198946;
	s = 0.08390676 * a.x + -0.011123063 * b.x + -0.03269317 * c.x + -0.19219291 * d.x + -0.050676446 * e.x + 0.07472215 * f.x + 0.085977115 * g.x + 0.11578824 * h.x + -0.28158212 * i.x;
	t = -0.02405043 * a.y + -0.13468283 * b.y + 0.014654289 * c.y + 0.28977296 * d.y + 0.6254546 * e.y + 0.16947387 * f.y + -0.026750885 * g.y + 0.037516773 * h.y + 0.29321685 * i.y;
	u = 0.017659916 * a.z + -0.0513346 * b.z + 0.014308151 * c.z + -0.07032843 * d.z + -0.124652594 * e.z + 0.027099187 * f.z + -0.042692557 * g.z + -0.32160884 * h.z + -0.124402575 * i.z;
	v = 0.173668 * a.w + 0.16868736 * b.w + 0.105285004 * c.w + -0.27488157 * d.w + -0.62909824 * e.w + -0.28937566 * f.w + 0.021574946 * g.w + 0.090454094 * h.w + 0.088722266 * i.w;
	w = 0.011426444 * na.x + -0.16358133 * nb.x + -0.24628234 * nc.x + -0.12582813 * nd.x + 0.37491634 * ne.x + 0.66146225 * nf.x + 0.17739972 * ng.x + -0.24103446 * nh.x + -0.12512414 * ni.x;
	x = 0.049656067 * na.y + 0.35043705 * nb.y + -0.06541586 * nc.y + 0.036384188 * nd.y + -0.88243604 * ne.y + 0.15085825 * nf.y + 0.01566454 * ng.y + 0.26099333 * nh.y + -0.23653607 * ni.y;
	y = -0.05713696 * na.z + 0.31915048 * nb.z + 0.09413395 * nc.z + -0.056367278 * nd.z + 0.500199 * ne.z + -0.10129501 * nf.z + 0.22792955 * ng.z + 0.27008235 * nh.z + 0.11766709 * ni.z;
	z = -0.30272278 * na.w + -0.032818265 * nb.w + -0.0091206925 * nc.w + 0.7295555 * nd.w + 0.078978635 * ne.w + -0.036731187 * nf.w + -0.04899552 * ng.w + -0.23233992 * nh.w + 0.120634325 * ni.w;
	float p = s + t + u + v + w + x + y + z + -0.006999369;
	s = -0.021856444 * a.x + -0.0006963466 * b.x + 0.02784665 * c.x + -0.1285126 * d.x + -0.47980213 * e.x + 0.3816084 * f.x + 0.11308428 * g.x + -0.43742862 * h.x + 0.43896514 * i.x;
	t = -0.053421438 * a.y + 0.0963073 * b.y + -0.13441114 * c.y + -0.12122123 * d.y + -0.15046698 * e.y + -0.39540198 * f.y + -0.0028491614 * g.y + 0.22168712 * h.y + -0.33935112 * i.y;
	u = -0.02753673 * a.z + 0.13554272 * b.z + -0.08918299 * c.z + -0.17173594 * d.z + 0.46268475 * e.z + -0.35359815 * f.z + 0.046332352 * g.z + 0.02462448 * h.z + -0.023167444 * i.z;
	v = -0.23453364 * a.w + 0.07788929 * b.w + 0.16012788 * c.w + -0.41643515 * d.w + -0.6417199 * e.w + 0.3087294 * f.w + -0.14682502 * g.w + 0.25157255 * h.w + -0.0602734 * i.w;
	w = 0.028217131 * na.x + 0.12867944 * nb.x + -0.05617058 * nc.x + 0.28762993 * nd.x + -0.5784438 * ne.x + -0.36014605 * nf.x + 0.21616842 * ng.x + -0.18586996 * nh.x + -0.009710477 * ni.x;
	x = 0.123937346 * na.y + -0.112089925 * nb.y + -0.079855986 * nc.y + -0.65935284 * nd.y + 1.6843947 * ne.y + -0.37654027 * nf.y + -0.5687655 * ng.y + 0.36904392 * nh.y + 0.22348003 * ni.y;
	y = 0.10575013 * na.z + -0.28616336 * nb.z + 0.22265147 * nc.z + -0.2137293 * nd.z + -0.91093117 * ne.z + 0.011338876 * nf.z + 0.10558912 * ng.z + -0.47041062 * nh.z + 0.16206238 * ni.z;
	z = 0.9702835 * na.w + -0.82380474 * nb.w + -0.0043063024 * nc.w + 0.4436007 * nd.w + -0.69435906 * ne.w + -0.11961962 * nf.w + 0.18174438 * ng.w + -0.050473217 * nh.w + 0.07299529 * ni.w;
	float q = s + t + u + v + w + x + y + z + -0.042621654;
	s = 0.012985117 * a.x + 0.069789566 * b.x + 0.012881662 * c.x + -0.013086082 * d.x + -0.16663207 * e.x + 0.18778817 * f.x + -0.009702196 * g.x + 0.038190898 * h.x + -0.050225593 * i.x;
	t = -0.07929176 * a.y + -0.06990447 * b.y + -0.06669893 * c.y + 0.025257275 * d.y + 0.7689759 * e.y + -0.10249004 * f.y + 0.017197285 * g.y + -0.10194497 * h.y + 0.090725824 * i.y;
	u = 0.0030403193 * a.z + 0.012294587 * b.z + -0.023400322 * c.z + -0.043591868 * d.z + -0.16327766 * e.z + -0.02788577 * f.z + 0.018733488 * g.z + -0.034326617 * h.z + -0.05105706 * i.z;
	v = -0.062092993 * a.w + 0.18108387 * b.w + 0.0864376 * c.w + -0.16197896 * d.w + -0.12865224 * e.w + -0.069327936 * f.w + 0.0015153112 * g.w + 0.018491505 * h.w + 0.049098536 * i.w;
	w = 0.019960985 * na.x + 0.051785935 * nb.x + -0.21044643 * nc.x + 0.09824475 * nd.x + -0.14958306 * ne.x + 0.3990458 * nf.x + 0.016052058 * ng.x + 0.049709063 * nh.x + -0.17706677 * ni.x;
	x = 0.019563846 * na.y + 0.18184721 * nb.y + -0.11986355 * nc.y + -0.2601329 * nd.y + -0.28785226 * ne.y + 0.085305505 * nf.y + 0.024360009 * ng.y + -0.20685866 * nh.y + -0.086421244 * ni.y;
	y = -0.0028385085 * na.z + -0.007392961 * nb.z + 0.12550405 * nc.z + 0.05340696 * nd.z + -0.24601264 * ne.z + -0.19635704 * nf.z + -0.035968296 * ng.z + 0.10348485 * nh.z + -0.009769748 * ni.z;
	z = 0.26647258 * na.w + -0.63420767 * nb.w + -0.02826515 * nc.w + 0.06637238 * nd.w + 0.57809395 * ne.w + 0.06882983 * nf.w + -0.004849368 * ng.w + -0.093381576 * nh.w + -0.10812531 * ni.w;
	float r = s + t + u + v + w + x + y + z + -0.018241946;

	return Compress(float4(o, p, q, r));
}