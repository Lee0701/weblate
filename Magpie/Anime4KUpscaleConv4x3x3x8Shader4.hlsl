// Conv-4x3x3x8 (4)
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

	float s = -0.23822114 * a.x + -0.49224076 * b.x + -0.2603839 * c.x + -0.22270115 * d.x + -0.23199631 * e.x + -0.08860003 * f.x + -0.11150333 * g.x + -0.31895813 * h.x + -0.035482813 * i.x;
	float t = 0.06318636 * a.y + -0.53629327 * b.y + -0.10155968 * c.y + -0.06471427 * d.y + 0.5817465 * e.y + -0.13474646 * f.y + 0.0058701304 * g.y + 0.1711669 * h.y + 0.08656512 * i.y;
	float u = -0.06168478 * a.z + -0.014518998 * b.z + -0.038895532 * c.z + -0.18411076 * d.z + 0.06959173 * e.z + -0.03780323 * f.z + -0.054073177 * g.z + 0.05846756 * h.z + 0.0526453 * i.z;
	float v = 0.1637899 * a.w + -0.17392571 * b.w + -0.044026185 * c.w + -0.36689785 * d.w + 0.14791447 * e.w + -0.03293263 * f.w + -0.13484396 * g.w + 0.025672594 * h.w + 0.0018860486 * i.w;
	float w = 0.00056899054 * na.x + -0.018397113 * nb.x + 0.092683315 * nc.x + 0.15637913 * nd.x + -0.093613446 * ne.x + -0.12215183 * nf.x + -0.01812064 * ng.x + 0.052842487 * nh.x + 0.024374953 * ni.x;
	float x = -0.18763757 * na.y + 0.30196622 * nb.y + 0.08883403 * nc.y + -0.054503135 * nd.y + -0.6387117 * ne.y + -0.051367637 * nf.y + 0.062047742 * ng.y + -0.25852874 * nh.y + -0.16576186 * ni.y;
	float y = 0.13587122 * na.z + 0.08522579 * nb.z + 0.03095689 * nc.z + 0.25446168 * nd.z + -0.1795436 * ne.z + 0.12887624 * nf.z + 0.16522995 * ng.z + -0.12371819 * nh.z + 0.018461064 * ni.z;
	float z = 0.33695576 * na.w + 0.27555978 * nb.w + 0.12422293 * nc.w + 0.4810716 * nd.w + 0.24170946 * ne.w + 0.109018564 * nf.w + 0.1475024 * ng.w + 0.008883083 * nh.w + -0.06614558 * ni.w;
	float o = s + t + u + v + w + x + y + z + -0.009210918;
	s = 0.011271452 * a.x + -0.42887446 * b.x + -0.16086382 * c.x + -0.2105586 * d.x + 0.24786222 * e.x + -0.13847941 * f.x + -0.18258463 * g.x + -0.32100454 * h.x + 0.014219074 * i.x;
	t = 0.023105236 * a.y + -0.01578845 * b.y + -0.050536994 * c.y + 0.039284714 * d.y + 0.16437066 * e.y + 0.0356428 * f.y + -0.062688194 * g.y + 0.07783894 * h.y + 0.009747119 * i.y;
	u = 0.030821703 * a.z + 0.06083882 * b.z + 0.025873283 * c.z + 0.017223293 * d.z + 0.08845148 * e.z + 0.061377097 * f.z + 0.06515027 * g.z + 0.0019544929 * h.z + 0.017247573 * i.z;
	v = 0.012934576 * a.w + 0.07368678 * b.w + -0.040340308 * c.w + 0.067247815 * d.w + -0.08931617 * e.w + 0.031227414 * f.w + -0.06303663 * g.w + 0.03044627 * h.w + 0.012112707 * i.w;
	w = -0.024660507 * na.x + -0.009060651 * nb.x + -0.0035039044 * nc.x + 0.06341225 * nd.x + -0.52527195 * ne.x + -0.005501108 * nf.x + 0.0588685 * ng.x + 0.09516038 * nh.x + 0.04720441 * ni.x;
	x = -0.063695304 * na.y + -0.067882225 * nb.y + 0.009680431 * nc.y + 0.11614084 * nd.y + 0.07604306 * ne.y + -0.2850213 * nf.y + 0.06081603 * ng.y + -0.078130275 * nh.y + 0.010210937 * ni.y;
	y = 0.020847162 * na.z + 0.08855373 * nb.z + 0.0023585085 * nc.z + 0.046964426 * nd.z + 0.029082319 * ne.z + -0.010446979 * nf.z + 0.069331944 * ng.z + -0.1097909 * nh.z + 0.0066273385 * ni.z;
	z = 0.07595761 * na.w + 0.21096602 * nb.w + -0.0016103018 * nc.w + 0.01423776 * nd.w + 0.39817473 * ne.w + 0.017830608 * nf.w + 0.10896886 * ng.w + 0.05775906 * nh.w + -0.008378969 * ni.w;
	float p = s + t + u + v + w + x + y + z + 0.007218698;
	s = 0.034728855 * a.x + -0.24261177 * b.x + 0.28377128 * c.x + -0.07902698 * d.x + 0.53327984 * e.x + 0.25865844 * f.x + -0.0034399142 * g.x + -0.43674976 * h.x + 0.032661323 * i.x;
	t = -0.07738957 * a.y + 0.057249602 * b.y + 0.2050702 * c.y + 0.17566027 * d.y + 0.011081271 * e.y + -0.23351799 * f.y + -0.09890139 * g.y + 0.018036745 * h.y + 0.047635887 * i.y;
	u = -0.020469286 * a.z + 0.047594436 * b.z + -0.002022923 * c.z + -0.20256907 * d.z + -0.78263223 * e.z + 0.0072576823 * f.z + -0.0490066 * g.z + 0.029040253 * h.z + 0.017826209 * i.z;
	v = -0.020083593 * a.w + 0.06858024 * b.w + 0.06368863 * c.w + 0.20496108 * d.w + -0.16528691 * e.w + -0.10180708 * f.w + -0.16950546 * g.w + 0.10020681 * h.w + 0.012377215 * i.w;
	w = -0.03253046 * na.x + 0.066873014 * nb.x + -0.068452045 * nc.x + -0.010155748 * nd.x + -0.46329933 * ne.x + -0.1307425 * nf.x + 0.048001047 * ng.x + 0.123704046 * nh.x + 0.074856944 * ni.x;
	x = 0.062060773 * na.y + 0.13428265 * nb.y + -0.24431407 * nc.y + -0.072135694 * nd.y + 0.9167748 * ne.y + 0.23750597 * nf.y + 0.04223396 * ng.y + -0.39293385 * nh.y + -0.2623536 * ni.y;
	y = 0.021315947 * na.z + 0.09439878 * nb.z + 0.015211157 * nc.z + 0.2038265 * nd.z + 0.69010055 * ne.z + 0.042161886 * nf.z + 0.0677661 * ng.z + -0.023256699 * nh.z + 0.014574618 * ni.z;
	z = -0.04407271 * na.w + 0.11794614 * nb.w + 0.03630912 * nc.w + 0.7663727 * nd.w + 0.39717525 * ne.w + 0.22002636 * nf.w + -0.010754877 * ng.w + -0.051768698 * nh.w + -0.010918847 * ni.w;
	float q = s + t + u + v + w + x + y + z + 0.024105644;
	s = 0.030766528 * a.x + 0.16373588 * b.x + 0.21841961 * c.x + 0.10914003 * d.x + 0.05621998 * e.x + 0.25531125 * f.x + 0.058601663 * g.x + -0.029884653 * h.x + -0.03693911 * i.x;
	t = -0.045011982 * a.y + 0.093240164 * b.y + 0.09846852 * c.y + 0.06726326 * d.y + 0.628559 * e.y + -0.02637863 * f.y + 0.0064472784 * g.y + 0.042976446 * h.y + 0.0080402335 * i.y;
	u = -0.017018517 * a.z + -0.0002487334 * b.z + 0.051482406 * c.z + 0.09698756 * d.z + -0.06515222 * e.z + 0.020085098 * f.z + 0.049856555 * g.z + 0.09850702 * h.z + 0.06601598 * i.z;
	v = 0.0029910787 * a.w + 0.027113425 * b.w + 0.056177218 * c.w + 0.1544931 * d.w + 0.28678927 * e.w + -0.031562537 * f.w + -0.015119418 * g.w + 0.059966877 * h.w + 0.009752991 * i.w;
	w = -0.06231565 * na.x + -0.03341734 * nb.x + -0.072572425 * nc.x + -0.04877089 * nd.x + -0.047237467 * ne.x + -0.10683365 * nf.x + -0.002816312 * ng.x + -0.05710042 * nh.x + -0.01591127 * ni.x;
	x = 0.025939502 * na.y + 0.10218501 * nb.y + -0.10536432 * nc.y + -0.071161434 * nd.y + -0.3066342 * ne.y + 0.061602294 * nf.y + 0.03169828 * ng.y + 0.005768011 * nh.y + -0.18946463 * ni.y;
	y = -0.013577987 * na.z + -0.025278145 * nb.z + 0.00625481 * nc.z + -0.08724931 * nd.z + 0.15522881 * ne.z + -0.015623531 * nf.z + -0.040420238 * ng.z + 0.07587788 * nh.z + -0.026974916 * ni.z;
	z = 0.05199736 * na.w + -0.046465985 * nb.w + 0.020043945 * nc.w + -0.1230899 * nd.w + -0.26674423 * ne.w + 0.039947394 * nf.w + -0.039006326 * ng.w + -0.08176985 * nh.w + 0.030418074 * ni.w;
	float r = s + t + u + v + w + x + y + z + -0.012540265;

	return Compress(float4(o, p, q, r));
}