Return-Path: <linux-acpi+bounces-21542-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOotDQLBrmmKIgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21542-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 13:45:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9304E23918D
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 13:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6241430A0006
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 12:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11C03BD62B;
	Mon,  9 Mar 2026 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="keI0l7AZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YbTNz15L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673923BD62E
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060196; cv=none; b=DzzWi0LZx9BsqEiQ+Nr95pBRvUmPPDuwygNeBjQHQM0CfOi652H8J8IV2qQqJPi/f3sqU770WbxDsQY2LBxwtarjqSMgz+GmSRukae11KlsGpHc83RkU7F6ksDkiHlRKN6PZFEaq/7jTM4crF2OnU4kvsfQ/7clPuvgp7J2Nj3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060196; c=relaxed/simple;
	bh=R4Ywu/pAKIvIVEZDR6pAqvPYf0v/XCn2dkIco/jqnjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uh5olFp7cnPrRXrNg689C/SMaVRxLxbo+RuaXFjwzsrzUxIgpUsY0g0cpJ8B5CrWyaXwr3mD9gCwnTBmQejCyyCNF49hrHc6Z/6wgDpIMr06AHV3CwsfrqpLWUne7FwScRLMWGWylKg+6oQXIGcq+8QZuHDFzoOhKOiVtCU3HUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=keI0l7AZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YbTNz15L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298W9cq3773088
	for <linux-acpi@vger.kernel.org>; Mon, 9 Mar 2026 12:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4+44pNLvKD6wmlyUHopw7JCev4MUbKdOMecmtcoK78I=; b=keI0l7AZufa5NJR9
	FxGOQJ82CTfr4mFRHFugkpK3cXX+IIsYH5lra08dS+9AK9XSvgBD5JKR2q6iWWuZ
	G8MRhRAlcnvmPlUbQKn47suu4v6aPEvDVZv8G8kqBAA05GiP/GR3mwa/R6A0hBk8
	DvgFbcQbQ/V/rgisY+O9yAaHxvTChxp8wpZ8PVrlzO1OPGydIInKtfEhGUhftXU6
	eUiH8X4FzkJMa/99XU6OgK67g3k5UqBsez9pUt6e04/tmfM0KdwodjRo3xWzoqs+
	lgk29vdKF1kcH+bRQQBndZoexA0ScP6R/hBdKJRSK5k1SzCBs9R9qf94OesuLpDa
	1EIqxw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cstsa8urd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 12:43:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd77e5e187so1145482285a.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 05:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773060190; x=1773664990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+44pNLvKD6wmlyUHopw7JCev4MUbKdOMecmtcoK78I=;
        b=YbTNz15LnNMMkisg21hFJps1dDul6em0VMvPTSben8utXN3ZBrmZKR/KyizmTEB2zE
         FP4ULGR+UGmgV9+56Axwee5F+B5O4b0Pg/VBAVIPCFiHQKsV9K0mI8SGidkn2WWGJ+Oi
         9d8Elw2oTxjzQJXRp63ymzXr7TTjv5KtJY35OZPGFD41T2MXy4XYjHwrkCMbylQTimV2
         p0XG80Cjq1PFBumXp603kCWt0IoJAYXBYmCoBn/s7eyGQi/leNiAZzkBoQpQeRtbyECO
         gxPqg+NMnWSV1O+75+EJmn/MutUUSIynm4SvSLkob+3w/PlGM2QIWEFvLRgvA9MT073L
         R/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060190; x=1773664990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4+44pNLvKD6wmlyUHopw7JCev4MUbKdOMecmtcoK78I=;
        b=lIFarQVyzjmRLsjs/mvZLN/arHzyjjaqUhRmmGLje7DpY3RREzEHAOQIjnEcgUvynD
         N6sRGtEkFZfsmXw5Ye5tkuHz24PZ1mKQxV7DpyR+Y0w73LBdxWH+AWZbg3ox39Vve4Sp
         Qc/q5jNGJ0UJjm9XjQYv/wPqSn/KcIV3IW+YDoJiZquVB28J0Lx1XDCpW1Io4aeMLnba
         skr8UuARVp5eLY4DsDz4Ts/d5KdiZKMXQ8ViZzikRjU6I7PWsG/k7FUBUN43WAJug/nU
         3Rl7xiLWFAh4bilnJ6B6OqQA2DL84NcASvtQwwZyqI0Q9JCQgzZkiIajfszDvrBYUpry
         w43w==
X-Forwarded-Encrypted: i=1; AJvYcCX5KyuBAOHUwwXYmyKwkl0vfk9AyjQ2yg7mSW6jDyxQI3d3CCktR+M7Y3+zqgkEYzlOUoMSTsTza2ia@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQYSQedReebPgjSSE/sQBwL8REWBMlUxAPDvL0XoiyFORyN1E
	DI7J6t5LoptVKrsTqg9sicAgLyj/oDv9FDjotACV67tdsCfrDmA//ULMwcHv6qWm2P0oEEb2nec
	95y1xGMo3/wIRzG7/EC+A4z0d/lf8JVH8V+J6dmIlFveXtxXK0z/5NvGVvBiuLo0dh+QKdsTd
X-Gm-Gg: ATEYQzwaD9xTmYbKPFvJs/gciHY3k2GIJcMJiYXqTOb7he4b+8+8TTUb3fwz4JnXWF3
	KOi+L2Z/6vWsyQw4f8k/BlyCfmWEvHrNLG37XsK185SCiGZs1KuFj5gK1p8/QFAN0G1bGe2FhcA
	UF6X8lZixVgpZi1t0C76AE1psSmCBKWPKl+mhqBFFlX3/wvjYS6IkWwCJijEYsC4T4HHlZs7WWY
	uve8rZe8DBwb6fuQCTDzPqLUc1dlwwg3uAeFmDRtYJQGfS02ymU6zSM9g5hJ9nGawTfS6A55Hm3
	dOy9LfrmMLrI4fQCQbm3XW/XMu13E/YQaj7md+vxKd6sqGsEEKOEQ7iDzj+T971zgsW/DwQHquT
	p3gtUcsaxJmcDsKNCa4vlIpGpxfxlji2LDqnde1uHWxudqUGWBgy0
X-Received: by 2002:a05:620a:400b:b0:8cd:8efb:b7d9 with SMTP id af79cd13be357-8cd8efbbe47mr163771685a.28.1773060190464;
        Mon, 09 Mar 2026 05:43:10 -0700 (PDT)
X-Received: by 2002:a05:620a:400b:b0:8cd:8efb:b7d9 with SMTP id af79cd13be357-8cd8efbbe47mr163765685a.28.1773060189835;
        Mon, 09 Mar 2026 05:43:09 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:494a:62d9:d95b:cb98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48539e574b5sm107803345e9.8.2026.03.09.05.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:43:09 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 09 Mar 2026 13:42:42 +0100
Subject: [PATCH v2 6/6] gpio: sim: allow to define the active-low setting
 of a simulated hog
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-gpio-hog-fwnode-v2-6-4e61f3dbf06a@oss.qualcomm.com>
References: <20260309-gpio-hog-fwnode-v2-0-4e61f3dbf06a@oss.qualcomm.com>
In-Reply-To: <20260309-gpio-hog-fwnode-v2-0-4e61f3dbf06a@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <westeri@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-doc@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=R4Ywu/pAKIvIVEZDR6pAqvPYf0v/XCn2dkIco/jqnjY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBprsBNxYsA8Q1LF5HZoRzIH4kwEDuPpcFPljJRv
 aDgYFtdqiKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaa7ATQAKCRAFnS7L/zaE
 wzp8D/sFgjA+zH/WzHB4KtIHoXip9zBsEn/LDT+Fc0zQjsN9Pq30alODEdm8KQ+4kbj30kiNHoX
 dstNie7A4CFOFdJPwCFC30iLABL/O3LGw0GcuGqDLpQyrQzw4wvdqKrSTu4mtdwyiivYzCRq8os
 u0H8OQF4+84yB9DQkNLZeGhmzmvXwz6+k/kpqHKJOzFIV5SHNHdwPV4n0+GKX0dM1YnGl9ggY7y
 isMrdgdf2mRdxkcuoHIq5Rj6e0TbaRn0noJig2+VwRyCSYbvQBCj88TIvDvzed0M+mp9Gwp2EnP
 x3fzOCgD8Gsava3M/x+mNa8MI3AGFCYHBrEGa3ST13BvF5u1P7NyvfgbHLY3qhafqoSd6Wk7WHw
 HUxKt/9nSykSy5BiCq8bbEr/Regwj3eWvVt0kOmfUNkz7oN5aFhS30szutYVtyIv+pyz//vvlvf
 PIVRWLbKRPH+narFofUFn7ynAgZf5cS/RKt89sbbM7qbCPisCZRLuX/kHvgtAujYbJy8N4cM0U+
 mrzJYamb4ipvmCxMdOG+2WG+3LqW/9omjYlWFhOzZ2v6+VJa+yxmVSfptO5zH1GoTfymaly/vir
 6u5EXCUzF9qDtPLwu6tfIR25m1CcmZU5WRnXPt9lPRFZ8NNZmctQoaUAdle8rpzM7F7e/dp0JPJ
 Mt+lWwKr5E+YH+Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: 5j_em9XBEZWwPQEx-pJIYuZZGXm9eoA5
X-Authority-Analysis: v=2.4 cv=I+Vohdgg c=1 sm=1 tr=0 ts=69aec05f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=Z_vE--IGminT9Q5MwdQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNiBTYWx0ZWRfX9vpNfGNJKfwv
 pXzC54RQ+Bfv1+0a733J3BNUyl4Xuj8grFAKJfNwX9E3BbDwCz5jle1qcJ29LKWDOdvY80Ep3tz
 mD9xrjTmifD161HaMXTNeSqx2viLFE6x+uP3eKT9Ymi31Gf1cJbh0APA6P+LnwTsHYY+0tyOkkP
 pGVa3mojmYP5GOWGcxc/0xc6UF7X7eOytwNNQqyStdou8GJZWQoMYiguUdPyfn0nbwfUYSfEtES
 kYG6YdYwoE3nqRgmbEef8wbohIpRd3Whl0roPMuTJ7ZT91T28jrKrNDGZEpjhFG6rKrymJfS/Qm
 8vYYufgbFyLFg07NohCsp9hRPGneM7aUR0m4zXpsA1eG1LYDCtAfX3BL2Es2EYJQPWmVFGmc0hO
 xVoC+eS/cQ/qjwANJN17qi0bMpcartlTIcAnuHjywiP6dQLaadilqs7TpyDvXjlS9z+qs9aucFY
 s4s44yMV+S2VYWx+7sw==
X-Proofpoint-ORIG-GUID: 5j_em9XBEZWwPQEx-pJIYuZZGXm9eoA5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090116
X-Rspamd-Queue-Id: 9304E23918D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21542-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,glider.be,gmail.com,linux.intel.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	TAGGED_RCPT(0.00)[linux-acpi,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add a new configfs attribute to the hog group allowing to configure the
active-low lookup flag for hogged lines. This will allow us to extend
tests to also cover the line config of hogs set up using software nodes.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpio-sim.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 51bcbdd91b4b027b7a340971a11cce5280ca1295..f32674230237eb08bbf8dd1337a79b5d0aa13259 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -654,6 +654,7 @@ struct gpio_sim_hog {
 
 	char *name;
 	int dir;
+	bool active_low;
 };
 
 static struct gpio_sim_hog *to_gpio_sim_hog(struct config_item *item)
@@ -836,7 +837,7 @@ static int gpio_sim_bank_add_hogs(struct gpio_sim_bank *bank)
 		hog = line->hog;
 
 		gpios[0] = line->offset;
-		gpios[1] = 0;
+		gpios[1] = hog->active_low ? 1 : 0;
 
 		memset(properties, 0, sizeof(properties));
 
@@ -1315,9 +1316,46 @@ gpio_sim_hog_config_direction_store(struct config_item *item,
 
 CONFIGFS_ATTR(gpio_sim_hog_config_, direction);
 
+static ssize_t gpio_sim_hog_config_active_low_show(struct config_item *item,
+						   char *page)
+{
+	struct gpio_sim_hog *hog = to_gpio_sim_hog(item);
+	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
+
+	guard(mutex)(&dev->lock);
+
+	return sprintf(page, "%c\n", hog->active_low ? '1' : '0');
+}
+
+static ssize_t
+gpio_sim_hog_config_active_low_store(struct config_item *item,
+				     const char *page, size_t count)
+{
+	struct gpio_sim_hog *hog = to_gpio_sim_hog(item);
+	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
+	bool active_low;
+	int ret;
+
+	guard(mutex)(&dev->lock);
+
+	if (gpio_sim_device_is_live(dev))
+		return -EBUSY;
+
+	ret = kstrtobool(page, &active_low);
+	if (ret)
+		return ret;
+
+	hog->active_low = active_low;
+
+	return count;
+}
+
+CONFIGFS_ATTR(gpio_sim_hog_config_, active_low);
+
 static struct configfs_attribute *gpio_sim_hog_config_attrs[] = {
 	&gpio_sim_hog_config_attr_name,
 	&gpio_sim_hog_config_attr_direction,
+	&gpio_sim_hog_config_attr_active_low,
 	NULL
 };
 

-- 
2.47.3


