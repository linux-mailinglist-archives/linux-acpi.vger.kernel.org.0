Return-Path: <linux-acpi+bounces-21539-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA7oEtLArmmKIgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21539-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 13:45:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4662239136
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 13:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60564308F602
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 12:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43433BA230;
	Mon,  9 Mar 2026 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bqmHL/4V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KsRaZrwc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2B3B95E0
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060189; cv=none; b=I8wm9BiGETJ9DNWBi3hN7fweF1j4IwOeDNf7z0s3MJiHMo26Vc86Pt1n91Ln+Yvb8zHdBQLgPaLVi+jigKZrTEhshZNO4NnK7R8V3LIH16oosw+8bf/SFcqWHVHaPiUgdA9ouLksysXdFFA9I8Qh7HPncOpnJBrDr2owIEiGOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060189; c=relaxed/simple;
	bh=657u5VcsdCwH5K3uh0YA0oSgSY82ZXzp8LKA80Hy5Pc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MICrfN5ejAZ3tvbbrn2MdbhRXnAWtyArsDs0o2CdGY1gz9wT+uDJYzCoFWEYhLNVm7OrfXcm5AR7ZuSeuPIg6TBEm7Wewdhv0vv/6gCO/LJu4wGmpxlmQ8ZeL3CYBCHjJjr7XUwmwEUw2OQhwe5KfCjsl1IwXsauzHy0zyPADm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bqmHL/4V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KsRaZrwc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298UXE03466070
	for <linux-acpi@vger.kernel.org>; Mon, 9 Mar 2026 12:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SQwazpAS/p8xBP8ywiNVLcoVJEL1G6gSbs/PG65TAEg=; b=bqmHL/4VSNwRWM8b
	zRkOwuPJXJcW6NCQgD7/GLLOPdIJx/ohQONcGW6ViXOnvgJn6xsI0ZJVyeREi792
	XaWQuUNMQQltO7/iZLEc+JwdlnQAIeqsUUvnkkZEf69jnbPH3fGeX3tgn8bnDdWk
	YouR8i1kZZ7SnOXQzUTrfHZLTMfvLTwOMuaBiokL9Yb7r8dZrdVXesdVziwlGIMu
	eO7DFHN47nbr/+w/CjDYnHcGCE0aAcMkxuaCiqm8uggZo0mj1PYqLgKi10tOm370
	qyqgTwG0jEQLGNKeJYx8uxHBqLa2apnj9oZwXGUsE7InwozSFb4Lih/SuM6T/ALF
	/kO0Cg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crcd8dbht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 12:43:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd827a356aso699915885a.3
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 05:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773060186; x=1773664986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQwazpAS/p8xBP8ywiNVLcoVJEL1G6gSbs/PG65TAEg=;
        b=KsRaZrwc9L4twFk7N8+iRsoRruHTQXrMe6ELEY6JEsrl+VeyFZeihC/SGO81sZF/7S
         zeLucgF/C5Jv/AboRUMrgdOK6b1NlQDJz8rpDl4jH9k6T4FOkW9fG6qvy3bBeG2WC0VF
         Pl1aLcMzrWzU4lICPDaD/RQKaTP26Au7ZLxtU+4REfJx+EfTEJpkS5+5t6NsGpuYs0sU
         lpfLKMlrz5dJTL75IHOhbCrJriQBGwdtJteIztxui5uYUm0+kGuUI3XxzZS32KliXLVm
         9CT1eII34/36wgNcOQdl4w61+UL5+fgXx9ERUWmBuBMrNXMyJcoSH+K/aBxplTgTOV4c
         /8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060186; x=1773664986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SQwazpAS/p8xBP8ywiNVLcoVJEL1G6gSbs/PG65TAEg=;
        b=pnn42/7KUE5QJMH09IRDtitrPO+3Mrux5v97/fMwnKsyhnVMzV3ziPr1PNSMV0WWuR
         XWFZggd+VD6OWuPnOAXAQ9T45sDKPV//Mwq362BIUIkdYaa2mV7mbG/Ne9ITDpCKHIL2
         pp6dYbmVbCFLfJKyZscoM6uoW9RqHCnNGSPy9MumDGkXFEkh616nAUVXveCWsWF60O/T
         n53Pzb1hu0OyWtyc8Hqu+Cb1lc+vbNMxkjEv1KXpBu/G+IxaL6PxEqTzH6aqxETHsAY6
         cmVTOp+2L6ljBxXclrABVjpv7yyi9xT8K3VO5djnVYqNg7NoqnGkuvTrpNT9TP/1iM9O
         5mdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzWI9IqQ+d6A+spio6091STbsqjHtjpvpBNFRHo6JIb2jeTZR1F8oq1WoHwNFWeZQ63ErNGq7mmzTZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxRpQI9tQz4LFewces36Mo+fCdtvHs4vMd2KxaPBYy+9wIGWePx
	CYSZj1uJTv7GqtcBwmxrsLkegnYRJkYGuashNPh5b2UQmjFBo36CSJRu9fr1FwK7OIw12vI5UNv
	R7M5gVBoPSNt71ks6lKXPXnbR4UJt+5zvqgjGU/p5otx8FVATspM9qv109Dz2M4XG+svA12F1
X-Gm-Gg: ATEYQzzifG/noAlW6U+BF5b1BzXkJgclI9XyMrWBy9uNxJdQDNktuygJyFraeZ8HMO7
	0aguwLu2GSm3ZEWR1MSqFskdG+Ng+aMdW6ZDIn3EuylcVO0/VF61FlvbXIS8+Zrj2iC34mhZsm+
	O4aMBSa5/ni89M6SmDP28e5gEK6aGWg/JgVGZZN4gJQFvujkJpB6csPSa1g6Obr9QHIqdH5cWLj
	sV71qS7woOz1ivy7120qdB37NuPgvN47HRkb2J1QlifZe4R1U+tW5BuKn8uyHUqnhx5vaieB7sX
	fdHl/KvfBJnnww2YA5SAd87ZEQ4ljnYA9X9XIVLileThItn1FiY3vjY0okpLlQdJ564SlZg+0dc
	Eu7mpgrZf8pTk1U/ZG6s8kqRoreAIYZAvsbo/KpGyLcHkvBzurO0B
X-Received: by 2002:a05:620a:4002:b0:8cb:3e86:d98b with SMTP id af79cd13be357-8cd6d49b8a4mr1509511685a.70.1773060186326;
        Mon, 09 Mar 2026 05:43:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4002:b0:8cb:3e86:d98b with SMTP id af79cd13be357-8cd6d49b8a4mr1509506985a.70.1773060185863;
        Mon, 09 Mar 2026 05:43:05 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:494a:62d9:d95b:cb98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48539e574b5sm107803345e9.8.2026.03.09.05.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:43:05 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 09 Mar 2026 13:42:40 +0100
Subject: [PATCH v2 4/6] ARM: omap1: ams-delta: convert GPIO hogs to using
 firmware nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-gpio-hog-fwnode-v2-4-4e61f3dbf06a@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2531;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=657u5VcsdCwH5K3uh0YA0oSgSY82ZXzp8LKA80Hy5Pc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBprsBK0MJaZuCEcNXm/8LzHDpWPQN1bHIaz1w2v
 TCs2lep/p6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaa7ASgAKCRAFnS7L/zaE
 w1F+D/4u8ii/H1cE8fIlALXnOq3ppXSQii0gcpwUkzxyl2aq8K2iP9cVIuRXmWGSQBm8jrGtlLI
 uEKZW8XuSSvPq0v1kKz7ocOoUX62HTnzfjnWVp/fqmt62t2FXJaf4e877htmTDMfuu4WAOJv3Vi
 aycFNT86SGgLs7TNaQR8pKpxpVs8K2OXwZkFBdAiWtYE9m3fmtVYO142796Ldt9ZJk2hLEqQQ1s
 Dlm8xOOMtF6PBpBCUjy1N7795nGEocaF28EagBGJ3E+hzSPDkhV7e7BETT2xqAqUV2+D5LtYYm4
 WvG/bcLqvWHzhuvepS3qaRzRBwdbPEDzKgK6NEt/FcN1zjEuPX+rNE9LXgmjOiqKD72AIg/nvMZ
 JePKfzK5cfgOM17iAOXpQCpnNgYdWqUGxZpFzfTMTBPEKTfgtoCF2wCTUWnVJg/Z6HE5YyTGfSS
 rFR+lZgSRmmoDexhb9G3i2US0rL4NW2s70miKvDL/8OGOurFkHImhCc4C1+HNNyhNKPOCmoP7es
 e1UNoclkcwxf4CIvOsOcVEV7yejTycZD3CzLRdAZ8poSH8lgPEqKzss/XQfySnVXDe1UmDWgnmV
 gLqXZvGZoHK5xrjEX5+eyErEz7y58ofVkYqFx0icSyFPJR6v3IrCuoCLMWqToRxANhsryXTsWJI
 DAiNr1FHZFSJGJA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: 4arRkP2MF4LzN0wXiqrbmpN8na5IcbVH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNiBTYWx0ZWRfX18tRd29rKojW
 +NJswieaqQMmj6/xv73+bxkL9B7n5SLGnKhRNEfHyve4/SG4k5gxHUpbHJFeJZ0vnRmJI6727Sd
 DDcSm74fRr83l5VttNZpkhxhrfr+9tIUVLUjRuxCzQ3lLnPonJuarHXp59wNSsbZXoMPhifokwS
 pBmeGEEFTxwwrqqoBgIIGep/D798GQ3pN8L4DrDc4sz5xCJW+RFWTl8kfb58VKHOvb1RHOKs+iD
 5qBN78NXrJYTeRgbiCKxP5Xs9Gypz9SiWxkt4g3TbhD27gd52ip3NN+9EveU8AGipYSEIO+szU3
 Ai8IjjqHRWMlpatT/3OdUMlniHus6CPpxay7aBv0+c1lRsqBH+ls5yoDJzv/9tXzNE1mmdhry7E
 rMk7LTIZJZmTN/OkopIl/W1EztVG0Ap0J7gKSvU3BU1jYzuzeZbtJ7XxzhOFT4Qxf3YuAteWr2E
 aY/PGJ95QYCGh0+E02w==
X-Authority-Analysis: v=2.4 cv=O/w0fR9W c=1 sm=1 tr=0 ts=69aec05b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=IpJZQVW2AAAA:8
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=5psZAbpHc07LGj0ksyMA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 4arRkP2MF4LzN0wXiqrbmpN8na5IcbVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090116
X-Rspamd-Queue-Id: A4662239136
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21539-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[kernel.org,glider.be,gmail.com,linux.intel.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	TAGGED_RCPT(0.00)[linux-acpi,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Setup a software node hierarchy for the latch2 GPIO controller defining
the required hog and stop using legacy machine hog API.

Acked-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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


