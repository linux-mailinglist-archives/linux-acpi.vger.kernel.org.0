Return-Path: <linux-acpi+bounces-21405-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFf5Bb5SqWkj4wAAu9opvQ
	(envelope-from <linux-acpi+bounces-21405-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 10:54:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F343F20F0DC
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 10:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15876306583F
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 09:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C55C37D130;
	Thu,  5 Mar 2026 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LfLV3pQv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C5YPXriz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA33237D10B
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704319; cv=none; b=BpN0LYDcNArBNKeZunM4N7/g9AZV0T8cqB/iEsSNeVVII57iDxqZVDfDoJa2bSXxQGhCZI6Ws9H/CVrUVyxHzYdXv3tlQyNTlYlyW1HaXnhXhdq0ouCu+EMkRlysXOKc5IVTBe4+Kz+GuaWPsVmi200tYLrWrtZNv+bSlzmLqGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704319; c=relaxed/simple;
	bh=yLeXFSR75ccR0iQLMahtPOCj8es5shZ6FJ/i3qInIHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ClCBimYj0EKHP2zvCOmMblD/LM4GABR0e42glPPwOKqXjj6vJKdvdOs6P1wJcXj9GFZAPmYqNdkZx6SpSougasTQo6HKhLYE45fpQVpbPM/01nf5oA/128yYgqdvbwcGdVZyu8n1FszFHbpAIP5t30pbpg2n+Itg+dEyxg4PleA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LfLV3pQv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C5YPXriz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6259C3mg3665284
	for <linux-acpi@vger.kernel.org>; Thu, 5 Mar 2026 09:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qzRzywPx0O0mlAF6vGhDfHihQLjnBGrCLr3m/uQi+Mg=; b=LfLV3pQvclLyN8oO
	WGlEmqiZs4p5Tcg/XKjCFQZf7kaW4HFV3UqOlpEU9/saeKlugDqgksH/oGlDX6dE
	C9P7zN1h7dftsFPBdhDGSPa3AMk+8TXQgIokjjy37xaGhMps46QfCjRTFE+ptke5
	e3Cnb1gAsd+mXCg6Fn2ce23cnzrUbu1yOfue51hnOGdwFM5E9Q1VeHUy4VXODF/K
	G+PH1ie3w9DEuPEdbsGfwwNhxoCjv04Ju9t1WuVUYV5Zqw267+NeTxCto43Od1Mv
	yshpZ/YMTezNyfisZ3uCiuckuuZfaGa+mIaohtOPYF6pqz8bLM+ancwRlo5B0kkF
	aFF16g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq04u1hnj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 09:51:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70b6a5821so3952753485a.0
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 01:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772704315; x=1773309115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzRzywPx0O0mlAF6vGhDfHihQLjnBGrCLr3m/uQi+Mg=;
        b=C5YPXrizTAOGWy2N6AncBWKC8F4UcBKYxLow4j6pY1Z1X+7ctYUo3oMIQYgrs9JGDt
         AMj+XgtyzcVsickkeDMktnAb4cxIRTxk3Pi8vFaxYQSfMyDbdyJYUceCn7QPK73AjYHO
         zxAxFmgOBEICLrDRAyfsGs/RS6df028xmO/U4J14Ea9XQ8YaBUsqh4IwdhCN8QgaASm5
         gpISCnZiRbaP3kwNKaKqYS/7fm8eCLRL+pmrAKf7UDawWQ7Q91+RUQXI2V4bPhtCr/6Y
         RQfFZyFLs+a0Fh5h/w0mrd9B2/brH6yi1Kse83hXDcTez7mcIgFY1fGAuA7/SDBFpWEn
         mEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704315; x=1773309115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qzRzywPx0O0mlAF6vGhDfHihQLjnBGrCLr3m/uQi+Mg=;
        b=Y9kO+ey7f4b5+U3IAVuv3G9TJG7U47LTGymXPPUJiEU7GN3JRZLVrsnPhHXqug/Ot6
         xE3xdFNDGTacjFtGX82ZSLZIPEqtb70uFV9z3gKi7pTMehfuj0NTKUi0B5NX0brQ6zHF
         KIVCZ9U+HaWDmyj5NXBdO88Bujux2KhElGIe2abHtBCJJI0M24heU7cYMliK979Orel/
         KxoPkLzzUceda5K/4rafRPOb32DFaGPRmK/F6gh9OWjg/zg3Tv2UN0xJltmyrYuZGcCo
         W5sJTI6dYKvefqTxVqGUMzWUeXgwPlS5/W4n7YHv1Gl2bmF1ovGv4M7zemrrU47DC0ng
         Hadw==
X-Forwarded-Encrypted: i=1; AJvYcCWuOeLABde9TdxZ5GguiG2cbsC98i45GF1whDWcSOAoC8tgJbOpM+lcITEBtc/ONO44abV8ykfYzdGA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1v1eHYV2009QkVR+MWBbT764R8dU1nkFKKda8qFLiETKUGP35
	IsDgzsDrA1JfkTJXHv0KKWnB/e4NYxhl1Suk8fV+pQDUexx0Kvmf1Twv8LVdpx0NxCd9vX+bJD8
	BWMFqR6cxCaMxO1iQu0P7aTIgE/XrymnlLbWXowdYPwYCHrkZ95G2PGRIydxgkPKl
X-Gm-Gg: ATEYQzxnnAmtH7Y/uEYFhBQvaRLuKj/D6Wfq5oPqJftRYAMTFuFS3qh0Ly5dYrg0B3j
	t1CwsFuxWzDCEzchDwzzZljNFIqRvdx0bunSuVeDSKadcbJIx1NGet37zL5uZ0s6CSYDDNV1/Oz
	CdvEGoqr3ROUZ0oyJ2XY2XjXCyIteemhuJoKtnMrFdSH5r1djuUVuQo33OO1zfzLkWzQXQcblHP
	9EY6eq0pd8ryZPNog7ozV+71/qsgejpHeNrFKyNDCk9c+BEcB8wF1SRs9eIFEYam5ax/i9fCtCi
	k2KASLOfrQW/o20pGkc+BHsJEhe3BL9kBX0Scnl913k81OAfs0bOIUI4W09RSuTQbTXyPVfAAg0
	tV2M449yVGNwdb4qZYWne5iur5FUz6wUZZkls3kk/6mSa4nvyu7bW
X-Received: by 2002:a05:620a:4713:b0:8c7:fdc:e84f with SMTP id af79cd13be357-8cd5aebfc5dmr661934785a.11.1772704315215;
        Thu, 05 Mar 2026 01:51:55 -0800 (PST)
X-Received: by 2002:a05:620a:4713:b0:8c7:fdc:e84f with SMTP id af79cd13be357-8cd5aebfc5dmr661931985a.11.1772704314701;
        Thu, 05 Mar 2026 01:51:54 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8314:9d33:34c1:88ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad1656bsm35598215e9.24.2026.03.05.01.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:51:53 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 10:51:29 +0100
Subject: [PATCH 4/6] ARM: omap1: ams-delta: convert GPIO hogs to using
 firmware nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-gpio-hog-fwnode-v1-4-97d7df6bbd17@oss.qualcomm.com>
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com>
In-Reply-To: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2370;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=yLeXFSR75ccR0iQLMahtPOCj8es5shZ6FJ/i3qInIHs=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpqVIrub3GKRGYVOnznATyf6cDQTE9HMMiXE/dd
 JGGx1EnnGCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaalSKwAKCRAFnS7L/zaE
 w3yuEACRLeLuPAaAcj37K3QsyNwQjPOc0IB4iJjV4FzCiOgnjoC9UyKuFYAvefMNet2QRTI7ihG
 PIUxdCg8Uwbu6IBavAIfyYj+kYu2LKh7IK+/EoaWYcJ+vowqem2T5cDfR+T6wrOwkAMZcgJSjSI
 8jNwmLr7x52h50vitgs2AqEfzeQygMi2J8L7ZqLWMVB3TlYgOK7UUfGUs6/D3iuHt1/xAmPpF1/
 c5ux/zDcMHvl2UxRviEkq6/teNmO0Zb7jIy1NzZmlR91Rc//nBb5k+qSRlnP3oM0Fysl6cjWihQ
 BaV6v4fnvt6aeFAqX9kJwCPQtVFR8B22Bb2m6JdwF9X8Gy+Iw/wFPEFbU7L7FRha8lcqC3VM4AX
 +Lop3w9rtHrfy76f2jYO9eucsdRthzaQRQaHLDL5oBNiOtD9KtmTR6wYMAizArxZqU3ibeEIujl
 KSkLCUHyk0elsalUfwpWwZ9YWEgbdWNOz/M9MEqti9T3QUkkS44cjG+gnN2L+eUBu3XfCkkiqJP
 eCMcpWLeQmejZUVr0Zw0FBNzdFGvdaHF2J4+KeSDg9QnQHQIQErw8Ua2DtbYdBWvKGueczWHICV
 c2nYtImPF5WES/h14iVlNbJDaefOpTxc9K4tJaX6Zql2DHr7oHNqHonRZApPqJH5qA5hQo/wMGl
 eG/blmKCuQZz4KA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: fko23J1XePLMWHXrsbI75njkfW0PGZs1
X-Authority-Analysis: v=2.4 cv=eqTSD4pX c=1 sm=1 tr=0 ts=69a9523c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=5psZAbpHc07LGj0ksyMA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: fko23J1XePLMWHXrsbI75njkfW0PGZs1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3OSBTYWx0ZWRfX/IEleY2tvZ3/
 RPye2UVKAEYm/o3ZL0XOnz2wnF2rACkerp4WCBZvYPz9S00EsLBR2r6Ff22g29baJK1vMC6SqTX
 3fXzmK2b1lp6F9tKx1CxHJyYM+mR7nwaChHRQpwrxpZ8ixy6HukJDfkgxxuzN7ioyGKossv+nev
 /WBActvhGaJznpppJ9md3UJWZwrqMjJWvTlCbwiDbPLg8k0IIRQ/PVb/Bo4S+gPzOvG6C9A6emI
 zFv7Ty6mQsM8MErH0WR9KAjQHVK4qEmFDhtLpUMTD61d4ZJi7N5WCqjEXyzIFSycyKPEGCwWfW9
 b9z6YsrCHbIU61muCj+3lqSQT3R3+pegcN6blSFHTEaRBqVqIywSmcSo3H/AtVzcneQd8l+I63r
 s4Ku3DjHiI31pkFWjUOwkHaU1TUAUI5TOcPMMF9VnsYM82pmuLjoHdDxLL0Muz2T/Ce5y2eX0Gi
 dNPgYu/35U0pN9nkWjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050079
X-Rspamd-Queue-Id: F343F20F0DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21405-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[kernel.org,glider.be,gmail.com,linux.intel.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-acpi,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Setup a software node hierarchy for the latch2 GPIO controller defining
the required hog and stop using legacy machine hog API.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 16392720296cd224732450c85419c35bbab506f6..1bec4fa0bd5e8bfc58103d1f24b22176707fd26f 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -556,10 +556,30 @@ static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
 	&ams_delta_nand_gpio_table,
 };
 
-static struct gpiod_hog ams_delta_gpio_hogs[] = {
-	GPIO_HOG(LATCH2_LABEL, LATCH2_PIN_KEYBRD_DATAOUT, "keybrd_dataout",
-		 GPIO_ACTIVE_HIGH, GPIOD_OUT_LOW),
-	{},
+static const struct software_node latch2_gpio_swnode = {
+	.name = LATCH2_LABEL,
+};
+
+static const u32 latch2_hog_gpios[] = { LATCH2_PIN_KEYBRD_DATAOUT, 0 };
+
+static const struct property_entry latch2_gpio_hog_props[] = {
+	PROPERTY_ENTRY_BOOL("gpio-hog"),
+	PROPERTY_ENTRY_U32_ARRAY("gpios", latch2_hog_gpios),
+	PROPERTY_ENTRY_STRING("line-name", "keybrd_dataout"),
+	PROPERTY_ENTRY_BOOL("output-low"),
+	{ }
+};
+
+static const struct software_node latch2_gpio_hog_swnode = {
+	.parent = &latch2_gpio_swnode,
+	.name = "latch2-hog",
+	.properties = latch2_gpio_hog_props,
+};
+
+static const struct software_node *const latch2_gpio_swnodes[] = {
+	&latch2_gpio_swnode,
+	&latch2_gpio_hog_swnode,
+	NULL
 };
 
 static struct plat_serial8250_port ams_delta_modem_ports[];
@@ -684,7 +704,6 @@ static void __init ams_delta_init(void)
 
 	omap_gpio_deps_init();
 	ams_delta_latch2_init();
-	gpiod_add_hogs(ams_delta_gpio_hogs);
 
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
@@ -693,6 +712,9 @@ static void __init ams_delta_init(void)
 	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 
 	platform_device_register_full(&latch1_gpio_devinfo);
+
+	software_node_register_node_group(latch2_gpio_swnodes);
+	latch2_gpio_devinfo.fwnode = software_node_fwnode(&latch2_gpio_swnode);
 	platform_device_register_full(&latch2_gpio_devinfo);
 
 	/*

-- 
2.47.3


