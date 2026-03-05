Return-Path: <linux-acpi+bounces-21404-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKBfBXNTqWkj4wAAu9opvQ
	(envelope-from <linux-acpi+bounces-21404-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 10:57:07 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8916920F20C
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 10:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 727123092310
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1807E37CD20;
	Thu,  5 Mar 2026 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OoELvcRW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WvpYW4tk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE237CD25
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704316; cv=none; b=Bpyg/42O5Qnm2krWbHml5OVOc5KTktH6ip+xdFrffIwTl+dnLpvdUjViSIVPZlx6QgMUfMVFFwMkZUWKdR8SXJL5y6+J10Pslrl/oTI/5eFcoq+gvDoroB7ESLoIDTjGr4dr/uujo7dfkJB0sFZaWlg38LlJRY948AcqcrF1l50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704316; c=relaxed/simple;
	bh=w+u8gA5XSfpUL1fVDzCB/568FB2uADEJ2aLQiT1wF00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QH3Sh78lz937I0Y3UwO/jd6WuKxgyWA6ur9fPiLsRULMIIVP6sWga+bNeyBWUnq6JpUnmFyq0Nvb10xgujkHpq4mtmTkWpkQO52juwYlAq6uNsEMDHprFU8qq4j7toPye+GZHkUTmusaNHYj/wn7dNOeC7K7g8B1KAnaVlIgqoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OoELvcRW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WvpYW4tk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6258tv0P3473514
	for <linux-acpi@vger.kernel.org>; Thu, 5 Mar 2026 09:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/zGlsuieF8HfJaz+k7Z2A0mMLjNmMLEqk6t8sei415o=; b=OoELvcRWdM9CeGze
	LeL6UFp4Y0ufgp61OQdtuC6wrU+XbgaORw2FKsn48hTjpCcuSeMQP/wHbSPHEh6q
	evvYJwHEJqTao+b1olGryJGGHdo3W2wzVdJyQVW7Qz3QAaZprwlvLCNZOEa9Yd7P
	plgXKdmYo8qcKHkO7dU81yHV692zR5L2HXSVcp01jdNa1Wpm5tIsYGSF5Mpr6oUb
	3hGhr/0eUHWWmt18eQX+nNhOcZ0vqH+W0eSBIwtYUoyvNd7dniyPvlHBc+HEi/bU
	wLKYn4BykMuFsaVHYy26prMQpNa/KBidEjQiHc3skLX5LR07ZQmAPefNjsIM6YkR
	8PXJAQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpj18479m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 09:51:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c71500f274so834067785a.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 01:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772704313; x=1773309113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zGlsuieF8HfJaz+k7Z2A0mMLjNmMLEqk6t8sei415o=;
        b=WvpYW4tkr3KgtyR2sr0Q0r2BmTonSQ4FNN4mJtoaDWW+VRyrGHlSmNogtBWd0u6sH3
         AopirXX4gT1u+GbK6i+hIFryZdaDSmxAOipO/2TK8woejcf+gFm9ipe4kPCbQ1kSz4XX
         McSAvVV8PyOYsnA3qOGOzgTSp3Sx78UTt9eY/CMa2shWloEo2q4G0UQjWC4xbQkei90H
         eyVrhLWQQeHOpz8XQ910d1RpDHIa822fUZGdWxQpH9zkBM8bfeAnfSj87bqKOzMyZ5WT
         XtNLbxeWbn8hh+N3TLahrkQp3W+KK0Kwm/gtUkdFWjI95KL0x2YBmldtRnDgnc9jAT2z
         Zgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704313; x=1773309113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/zGlsuieF8HfJaz+k7Z2A0mMLjNmMLEqk6t8sei415o=;
        b=OI5B7EZqyCYVp+SDgPGUERAdqmMchmy8UNVmiZN7upufDRFM28ke5fbYlltCibRRSf
         94+OApYnPrZaJzwoPK+ZmfZrPsQK5P7fSA2Pdy39mmeWuKtNr7UoHYEY+PWpGzEVj/fw
         bAO8YGJ3v2zTU6Jr8PoIkAa3ng5KSeqx5mt2TDgVUdMmdKIpdUjyZGeoeMlIooWL5dFB
         1IXV+SIE42lob1UVZIk6n4I2QkCrudCp38fVhma1n6+Dw5eMvB4ytvQa0KzKeaDqDtMW
         IJoF0iBOcdG4LCEiBH/hGc0y2QEXnn2LmVpxQtIdBt+Eg9iAKUt4fXoOED0JabhGEing
         QaXg==
X-Forwarded-Encrypted: i=1; AJvYcCWam8ArmRB4TpcH+ycJsoD07xgYcm8KJsXmhEOnihTh3SVPPoSZpntFnPw/djNpg2yqn+gPyDuwAFbE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6+9lRG3JAscdNrmlVlqkZiNbVErI+TzEy5NvpE5HdykMTDNh1
	Lfwgb4or4PFKQ4zokUOoO0P3Ouh9tC2uS10mOfXlVeAYK6sfxbD6hJTh221HIhXwr2j2C3pHZrL
	iQ9O7UUEwhsLzT7aXdhtK/H0EGxovnYeRs5t8LS1UaflR1s0ziM3DI1ZDh1tmmJbu
X-Gm-Gg: ATEYQzw6PAt2BpH2YoSNSpqrdB+S6mBAh55/WUHXq4cOq31+k1xlV8yagSBl6kBDxqy
	yP4QXyeRw4+EVkS6c4uZmz76+Y3P8OvqXPdElHXBlJVex1yCwB+r+aNzJlg644Nclmu8h4wkRfz
	oXhvbLtO7nSpVatrzCtxwpVIik/J+/cG3pODp3nBSZCdVfmnhezmM1d9OVP3Jiw+JuWGHm3Ejzx
	Jw1ZT39g4AE6S1ah6OKoZWjlM+4XSd2ktgifYp6PpiVh0TDCZXdLhoKsjt9jpKpmq7ZG0W6Lvot
	Fj1UKe+tVCYThTll8NQCkOuU9Btox5J8CYi84DiLQtNrE6yct9C2FnI/4Ir+6Q4i9hKXEko3j6W
	C6pw1ALDOjEi0WrHxCs69VQAtNgjHtVgfF/bExyAH/jXQpi5FGnjw
X-Received: by 2002:a05:620a:46a4:b0:8c6:e0c5:7bc0 with SMTP id af79cd13be357-8cd5af2009emr605342485a.36.1772704312564;
        Thu, 05 Mar 2026 01:51:52 -0800 (PST)
X-Received: by 2002:a05:620a:46a4:b0:8c6:e0c5:7bc0 with SMTP id af79cd13be357-8cd5af2009emr605341085a.36.1772704311967;
        Thu, 05 Mar 2026 01:51:51 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8314:9d33:34c1:88ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad1656bsm35598215e9.24.2026.03.05.01.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:51:51 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 10:51:28 +0100
Subject: [PATCH 3/6] gpio: sim: use fwnode-based GPIO hogs
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-gpio-hog-fwnode-v1-3-97d7df6bbd17@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6143;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=w+u8gA5XSfpUL1fVDzCB/568FB2uADEJ2aLQiT1wF00=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpqVIqF5bDfNvDEyB2c6UAu36TpqFzWTqhJE5A/
 24jyOm5XamJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaalSKgAKCRAFnS7L/zaE
 w3TKD/0W/9hVvY0nJXtP8TC53TGxU7WXAisF7NfDZBbc9ZJOaGumieq+KfFlYiRZmYoNZFkYZr6
 gMB0aQ9d5FehTrSRGPDYvjzEyRVMWmo+/Q2+EZuFdkLcXluphVeBSE9JcM3pQkqGCHTRAM0R/tW
 3RhxSL/3p5enWc0rXbZtXmCUNUM6pR1FBrsG1d0O7k41AtUP8+nJkChJ8FrrkOIUWLAV1AA3kyt
 i3nq0Lg7+RhiupyQxWhd0rfXriL1N/Cqwr/D50QL56KmgHGQJ6HWi7CkexCRbAvrltnJu5nwojC
 mou7BtX7+/g19dnURgezf11ZKl8mnz7eVZ5jbh5NBC9AXD7bakONARjPLT/3ZBBA/M837hMAZ/9
 Y4hpIondm9bYbLKwTnzozGO/LCJfTGnOkfhafuYv14U/pELEoKAGstLsaHsP/eIq5yv1AtTz3ir
 fdvLWO7feEZxq3LGVEgFXphSbRdcK/MB9eUGl53+DO90wHLQ9T4HfQOUJwP3LEetlIF+NDr2Cfn
 XXYsjl8sMOJ9cr2j5gQ6J6RlmQ4HPE3CU3pp+kGKXJ4NUVVV7Ua42V1RymFwf0aHHJyMcoIdQEJ
 iqNElW0h8xTrsHdBPNYnktMHweDqoN6OTiFOdJxaguiRBw2MRmbE1NGi6vukbgqTTGqgUYNzZ15
 k7e9vRTrCik7OSA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: RU-n5Q5kTDtkoG7DC3IWVYyUL1jyj-br
X-Proofpoint-ORIG-GUID: RU-n5Q5kTDtkoG7DC3IWVYyUL1jyj-br
X-Authority-Analysis: v=2.4 cv=Ed7FgfmC c=1 sm=1 tr=0 ts=69a95239 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=EViWBFm1GAVLN6HfglMA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3OSBTYWx0ZWRfX74lnIyWVa6yn
 v7VtnG2jYPd0E7b5+kOaLazKreQKx5Ua2WMdmkjuFe6jo74rlFHDnna0YUAEqipsVDlwRKFnOkY
 dEC6rTLj2+1ZsRh3TVnFmpYhvO8jJlnL9Y8A5JCLk589L7nu75sEUAerzWaqS9poLvNqf4Qo9pb
 2LeiM1p+cd4ZKUwd/gqjkW6Y3pJli/Kzg2Sn9lT7+txiQuXawBm72yRtuSU36pfPBZDZZkizdsu
 PsPiewDWacW00UA1x3y5RDuVfLHtcaruqLZiU8FY0bRjfMzBlr9Uq4CI6WVLvIBrZk3z8vg6NTQ
 v1kAWGP1e8iQ2t2QbtQC0yUaQQf3me/qoHZcyEWOa0RbKRTNBfWkzlQPkpckKAPogPcK88KmiL5
 tETlc9jbrOuo+dP49CMEK3s23ON47B/k42YN1aFEYvMTolNVVEgHXqDEp9HVfluXIH182AlIP/s
 4fhNKEeWtU4ZDQDhTfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050079
X-Rspamd-Queue-Id: 8916920F20C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21404-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,glider.be,gmail.com,linux.intel.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

Convert gpio-sim to using software nodes for setting up simulated hogs
instead of legacy machine hogs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpio-sim.c | 162 +++++++++++++++++-------------------------------
 1 file changed, 56 insertions(+), 106 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 13b87c8e6d0caf62ce311dad409a9b4d3f091caa..51bcbdd91b4b027b7a340971a11cce5280ca1295 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -40,6 +40,7 @@
 
 #define GPIO_SIM_NGPIO_MAX	1024
 #define GPIO_SIM_PROP_MAX	5 /* Max 4 properties + sentinel. */
+#define GPIO_SIM_HOG_PROP_MAX	5
 #define GPIO_SIM_NUM_ATTRS	3 /* value, pull and sentinel */
 
 static DEFINE_IDA(gpio_sim_ida);
@@ -561,8 +562,6 @@ struct gpio_sim_device {
 	 */
 	struct mutex lock;
 
-	struct gpiod_hog *hogs;
-
 	struct list_head bank_list;
 };
 
@@ -774,102 +773,6 @@ static void gpio_sim_set_reserved_ranges(struct gpio_sim_bank *bank,
 	}
 }
 
-static void gpio_sim_remove_hogs(struct gpio_sim_device *dev)
-{
-	struct gpiod_hog *hog;
-
-	if (!dev->hogs)
-		return;
-
-	gpiod_remove_hogs(dev->hogs);
-
-	for (hog = dev->hogs; hog->chip_label; hog++) {
-		kfree(hog->chip_label);
-		kfree(hog->line_name);
-	}
-
-	kfree(dev->hogs);
-	dev->hogs = NULL;
-}
-
-static int gpio_sim_add_hogs(struct gpio_sim_device *dev)
-{
-	unsigned int num_hogs = 0, idx = 0;
-	struct gpio_sim_bank *bank;
-	struct gpio_sim_line *line;
-	struct gpiod_hog *hog;
-
-	list_for_each_entry(bank, &dev->bank_list, siblings) {
-		list_for_each_entry(line, &bank->line_list, siblings) {
-			if (line->offset >= bank->num_lines)
-				continue;
-
-			if (line->hog)
-				num_hogs++;
-		}
-	}
-
-	if (!num_hogs)
-		return 0;
-
-	/* Allocate one more for the sentinel. */
-	dev->hogs = kzalloc_objs(*dev->hogs, num_hogs + 1);
-	if (!dev->hogs)
-		return -ENOMEM;
-
-	list_for_each_entry(bank, &dev->bank_list, siblings) {
-		list_for_each_entry(line, &bank->line_list, siblings) {
-			if (line->offset >= bank->num_lines)
-				continue;
-
-			if (!line->hog)
-				continue;
-
-			hog = &dev->hogs[idx++];
-
-			/*
-			 * We need to make this string manually because at this
-			 * point the device doesn't exist yet and so dev_name()
-			 * is not available.
-			 */
-			if (gpio_sim_bank_has_label(bank))
-				hog->chip_label = kstrdup(bank->label,
-							  GFP_KERNEL);
-			else
-				hog->chip_label = kasprintf(GFP_KERNEL,
-							"gpio-sim.%u:%pfwP",
-							dev->id,
-							bank->swnode);
-			if (!hog->chip_label) {
-				gpio_sim_remove_hogs(dev);
-				return -ENOMEM;
-			}
-
-			/*
-			 * We need to duplicate this because the hog config
-			 * item can be removed at any time (and we can't block
-			 * it) and gpiolib doesn't make a deep copy of the hog
-			 * data.
-			 */
-			if (line->hog->name) {
-				hog->line_name = kstrdup(line->hog->name,
-							 GFP_KERNEL);
-				if (!hog->line_name) {
-					gpio_sim_remove_hogs(dev);
-					return -ENOMEM;
-				}
-			}
-
-			hog->chip_hwnum = line->offset;
-			hog->dflags = line->hog->dir;
-		}
-	}
-
-	gpiod_add_hogs(dev->hogs);
-
-	return 0;
-}
-
 static struct fwnode_handle *
 gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
 			  struct fwnode_handle *parent)
@@ -917,12 +820,61 @@ gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
 	return fwnode_create_software_node(properties, parent);
 }
 
+static int gpio_sim_bank_add_hogs(struct gpio_sim_bank *bank)
+{
+	struct property_entry properties[GPIO_SIM_HOG_PROP_MAX];
+	struct fwnode_handle *swnode;
+	struct gpio_sim_line *line;
+	struct gpio_sim_hog *hog;
+	unsigned int idx;
+	u32 gpios[2];
+
+	list_for_each_entry(line, &bank->line_list, siblings) {
+		if (!line->hog)
+			continue;
+
+		hog = line->hog;
+
+		gpios[0] = line->offset;
+		gpios[1] = 0;
+
+		memset(properties, 0, sizeof(properties));
+
+		idx = 0;
+		properties[idx++] = PROPERTY_ENTRY_BOOL("gpio-hog");
+		properties[idx++] = PROPERTY_ENTRY_U32_ARRAY("gpios", gpios);
+		properties[idx++] = PROPERTY_ENTRY_STRING("line-name", hog->name);
+
+		switch (hog->dir) {
+		case GPIOD_IN:
+			properties[idx++] = PROPERTY_ENTRY_BOOL("input");
+			break;
+		case GPIOD_OUT_HIGH:
+			properties[idx++] = PROPERTY_ENTRY_BOOL("output-high");
+			break;
+		case GPIOD_OUT_LOW:
+			properties[idx++] = PROPERTY_ENTRY_BOOL("output-low");
+			break;
+		default:
+			/* Would have been validated at configfs store. */
+			WARN(1, "Unexpected hog direction value: %d", hog->dir);
+			return -EINVAL;
+		}
+
+		swnode = fwnode_create_software_node(properties, bank->swnode);
+		if (IS_ERR(swnode))
+			return PTR_ERR(swnode);
+	}
+
+	return 0;
+}
+
 static void gpio_sim_remove_swnode_recursive(struct fwnode_handle *swnode)
 {
 	struct fwnode_handle *child;
 
 	fwnode_for_each_child_node(swnode, child)
-		fwnode_remove_software_node(child);
+		gpio_sim_remove_swnode_recursive(child);
 
 	fwnode_remove_software_node(swnode);
 }
@@ -977,12 +929,12 @@ static int gpio_sim_device_activate(struct gpio_sim_device *dev)
 			gpio_sim_remove_swnode_recursive(swnode);
 			return ret;
 		}
-	}
 
-	ret = gpio_sim_add_hogs(dev);
-	if (ret) {
-		gpio_sim_remove_swnode_recursive(swnode);
-		return ret;
+		ret = gpio_sim_bank_add_hogs(bank);
+		if (ret) {
+			gpio_sim_remove_swnode_recursive(swnode);
+			return ret;
+		}
 	}
 
 	pdevinfo.name = "gpio-sim";
@@ -991,7 +943,6 @@ static int gpio_sim_device_activate(struct gpio_sim_device *dev)
 
 	ret = dev_sync_probe_register(&dev->probe_data, &pdevinfo);
 	if (ret) {
-		gpio_sim_remove_hogs(dev);
 		gpio_sim_remove_swnode_recursive(swnode);
 		return ret;
 	}
@@ -1007,7 +958,6 @@ static void gpio_sim_device_deactivate(struct gpio_sim_device *dev)
 
 	swnode = dev_fwnode(&dev->probe_data.pdev->dev);
 	dev_sync_probe_unregister(&dev->probe_data);
-	gpio_sim_remove_hogs(dev);
 	gpio_sim_remove_swnode_recursive(swnode);
 }
 

-- 
2.47.3


