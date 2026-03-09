Return-Path: <linux-acpi+bounces-21537-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBrZIIbArmlEIgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21537-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 13:43:50 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2CF2390E4
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 13:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC6C93058553
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 12:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B73C3B95E7;
	Mon,  9 Mar 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EooQVqgb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="isxEtZd6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7053B960A
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060182; cv=none; b=mTfTxhEj9RUu+t+b1u9z4nUUsZ6OXKDINoWeU0rOCfHVeMuBSgF2MWJ1Z4ZwCTvQGMdYwu+DzKVqVJAOFaQ+LNuzIcj5RmW1AtaDtofa+oOFgn4oihmYQqUOdM5B8qciN8d0fyI51dSQsf4tcaQP0M8wa2dMw6kDOD+K2Bou5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060182; c=relaxed/simple;
	bh=pDUWjkvolt9aVkc3THlY+/toYWrYnAZq17Xs7p08jFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ppIUDurTVp8918aSXCoj+WS+U/5naFG5E0km+HsIY6OTlamLSwdUVRs7f5LChtUScynmQe7HCVUqYqlh5P9FpNco695KiXVL2XkNOCs+coKjiHbZifThBCl0fvPf64xvjtdrQ8Z3uWWcorMNvl5GW/rbX10WhrvhLXKWHJqT72A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EooQVqgb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=isxEtZd6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629C5duB526831
	for <linux-acpi@vger.kernel.org>; Mon, 9 Mar 2026 12:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5ki8nOv3ANbax1Y6/vTexXDa+QoJVJxEjtgFCiUIaSw=; b=EooQVqgbfcPpySxv
	m2i6sOpnTEEQdx2jOro/AlgXy6C2bNrvGDod1I847LdocEyOefQ28R2S8pFwWQir
	uvoiC+I8m720WemF2vtR+X84LmydBk1k389NhinCxGLOF7Ty5LJV9mEZQvJ95oI3
	twqKL8qJe55gfuwRJIUvZPFryRZIKy1jhaE+tLnLk4rHZXuiQj8lozc3rsg3oDNF
	ryd0MeUzjSipNWyz88X7gV95S6Who7OtsBhC0d4M78A/WHL3d6TwgxVyaAbaA/Iu
	WKQvNL9OXnSaQTYEYYCBBH6feKUUoHqFWRjUjO3aFbS70wq1Z7hSmXImvxYZ+/69
	KQiAwg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cswwkg40j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 12:42:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb52a9c0eeso9166613085a.2
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 05:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773060179; x=1773664979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ki8nOv3ANbax1Y6/vTexXDa+QoJVJxEjtgFCiUIaSw=;
        b=isxEtZd6kA2oxZl6CoO9IPTtdMDiGBlRiaxuRL3WTuRsNBnhyAFC4eI0uZW0dMfq20
         RoJFDXe9xS01fZmS2De5yGZgV86K2Ju/066AvK6ipYH8Z+acn3vfQG/jUUJ8c+22yjYf
         L0w5GL84R88bG50S+4uGPQ4Gg/6YM4DSymG2tQ0TBXt2W57Rb2giwksy1YMhdBnZJEJT
         InCvhoSxo8ihvDQPF9V4qfJpgdeINWjV4AYofTX62smq0M8M/+vuPxa7szWIopt+9UbV
         nt8bPUMfsb2SZJEsRGdy6t/WP8LLbdIR9IlfGDPeYYy76is8HCVCyI7KzAGjy8LtbK7w
         XRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060179; x=1773664979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5ki8nOv3ANbax1Y6/vTexXDa+QoJVJxEjtgFCiUIaSw=;
        b=f2TUXkiu5asVGurMyeCROJe+EDo6ZGnWY2PARWjmzbmordNP6RK8gpUcBMHZky27xF
         k/GNYVV/3wkwg8tEicbkwabHpDQ2cjuei/aJlTqmr/jqyOhS7z9WyD9C9OBuMq5lUBKE
         Cj+r4wWQK3Fud/PHYaSd0ngCsX00rRjnBN8TJDk9zRBWvrkxJqolSGeQd9Skn1qeBUS6
         kbMqeC+/lbFKofroa30LnVzKV9EvjT8tGTzq/Lh16e1zCiDmc8hPe0MTmz9j84J+exWv
         p9+Lm3k+enYAvUUmyl1obJt3bsPzQtOWjjrmfn8lhStI0MQ40aDeGIW32GY8uZ8ilw1N
         1Yiw==
X-Forwarded-Encrypted: i=1; AJvYcCVgxSRYwIyj6KxvyBueqxYj8MnwVDElJzsJXsl3vwseN+5BRibAF4fJptEgPtBSUMw2qO7Zm1yncQpN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi39qjit5Q/fIUch0/SvJuzi4DhgNXWAfOLxKgE4TRLRMl3mS0
	XdbDFN3TlXjvong1GzJkPR0E5696X7qMyhK+KRysNU+5EnvNNArNFxDKKUKw/0/YjicEhGM4fxG
	Eq71hFsx61X/AQg643T9Jhgt9M6RL0oSogtrcve+m/23lWCLAAIlULGmyP6niH6cmYTd7Utnk
X-Gm-Gg: ATEYQzyReMVhQZJfVQadIjQmanJ2Bw96FXXQkjLTRMs3j56K3F/PkHs7YImCtlBZMdn
	8swX/HF02tUBzJn6rYNR0r7QnjBYjlx7EaZ5InIK8a+3EQQ8r8jAqrt+r6fX6G/N06RBczUxZpO
	fGoPEdPHpCH8cFDR67J80xdFMAaucNfWWVUXbV/g2Yrm8uPxMNriWSnkykHAIzmnOtHf88eMkss
	OQsxtaJTZPGgXPJ1qJLjXmwgJpPrztxIA7tXwV9GbTTcRzOBkv2H/+FgIL8faHaMS6u5qvrx+6r
	q7hbF91hOsHUonpol1YndBZepxaejdi1hil15eaUUDvl7KCH2ZR0UyAMnKiXrkeCKDwraYeFlD0
	ZFXINsFxp4OCsukOyjC8OKxqrjNhDha3ewnEeDeJ33Nu6rD1HDDI+
X-Received: by 2002:a05:620a:4688:b0:8ca:d5cb:6839 with SMTP id af79cd13be357-8cd6d4eb0b2mr1430385785a.65.1773060179271;
        Mon, 09 Mar 2026 05:42:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4688:b0:8ca:d5cb:6839 with SMTP id af79cd13be357-8cd6d4eb0b2mr1430382285a.65.1773060178835;
        Mon, 09 Mar 2026 05:42:58 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:494a:62d9:d95b:cb98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48539e574b5sm107803345e9.8.2026.03.09.05.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:42:58 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 09 Mar 2026 13:42:37 +0100
Subject: [PATCH v2 1/6] gpio: of: clear OF_POPULATED on hog nodes in remove
 path
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-gpio-hog-fwnode-v2-1-4e61f3dbf06a@oss.qualcomm.com>
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
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=pDUWjkvolt9aVkc3THlY+/toYWrYnAZq17Xs7p08jFI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBprsBHLgjRTayL4zBT+0z81rGSe5BLprPXLVoTZ
 c0qyL+zRzOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaa7ARwAKCRAFnS7L/zaE
 w96MD/wIM8Ae5r7/4bUltHDXNPzgPX7vyGNhGbK6AaMf07BOU/jE0U5P9hc/NHek5F2elC2U8iM
 QmDj7wCBLAWMTYRi6Yuq8y3pviPQeJRFJ0Ln20uOsJyWjxGO3Nn5VFPVqxkXy/oKLum3KbtN459
 IVkRFAWynXtLJ6PM2XqnIkfyAewfvCCzICzeDYCcctbLpFU0JO+VsgBM7umdeklPD4X5h39WoEh
 D0zV+aZXhFDBEWZocpWFvovm3yDhnYFCLCIUkN5ICKQAlcRzP7+k4m3AEcWnaj3qnitspwbiqJr
 S9zTMKuo6K8KhXi3yjaxOmvpbSp8FoOLDRGAXrbdXrbosn2u+gqOu4nMvWeLlQy/ybuTAgS/UHC
 5v+y0RCNhSQXMEYR2fErUgNjiF2w/nVEeEZHDh7sOS47NboWLM/hHJ7L+8788JQUr4UQRy4gVd9
 qWG75cRoqYWZD1fwDRCoMIR/NOeW80SJPctYaKqwOCEmym0AAqQ3Zd+lRYmJaOZ3vlr92UZYhXU
 pUDp7cD89aYD6C1vZAJmWaemI/pmDIQ805+5Th0Iqg/W98EFIHrPfgDtuEkJKVzf8cIBrh0tC9F
 jDIisj7PVHz5AR+GOXTfEKu1wBjhg9pprHOfMGhMwSqZsrqXQYIkANiX4K/LNe5ICSbxMutEcut
 EGXzIu8rNHKjW8g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=cZ/fb3DM c=1 sm=1 tr=0 ts=69aec053 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=wIkqWORfvUmHQsOhi0cA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: GAiCwXgTSV2yapI2sp7ut4SuSPSo19iy
X-Proofpoint-GUID: GAiCwXgTSV2yapI2sp7ut4SuSPSo19iy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNiBTYWx0ZWRfXyzlesM2q7fjh
 Z6b0J4QI0Pn3PjzwUvnKAOueQn9GmvP1/BN6no0qzMC6hY7fV4Ok2X9pKEkJMzOFms+PdbqNV1I
 QcjvlrUm5RdqTFPqiDXotuVroe+Yf7g/A965kbX6mjJGsfsiAesLvXllbaCmAM7jq8O+1MxhNAs
 J4nJBbT1231w8fGoq3fnUnmIQwHDd/+s41iyt2rWP59+SwVkBto2ayxSWYFlX9NSDsIexT84Eh5
 Oa3Xbt8qB9Y34hfvHPbkunaRAgud6oGNve+3oW9XtLAiszrGN7zdKUbywtu2qkoq8BwS3aSGbZW
 oF5foxOVXBzy18vH4TXeFNotWgqZykTUeEI1LoNsK4fEuyZEwlMWlUZQ6DS+MvotWQ2y+Rr+Qqq
 CnAJxEIKWWjQNuaaxFxDyxgIZpznx5JmbIskJm9f92TrT8LSxopxl3gQqgl+dTJiX6AJz5F6w6W
 w1cmtpnF1U7k/FcG6+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090116
X-Rspamd-Queue-Id: DF2CF2390E4
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
	TAGGED_FROM(0.00)[bounces-21537-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,intel.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
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

The previously set OF_POPULATED flag should be cleared on the hog nodes
when removing the chip.

Cc: stable@vger.kernel.org
Fixes: 63636d956c455 ("gpio: of: Add DT overlay support for GPIO hogs")
Acked-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-of.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index ef1ac68b94b78f09e768cc740e893632b8817505..08b7b662512b825086cd70440be98b59befc3ffe 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -1210,7 +1210,14 @@ int of_gpiochip_add(struct gpio_chip *chip)
 
 void of_gpiochip_remove(struct gpio_chip *chip)
 {
-	of_node_put(dev_of_node(&chip->gpiodev->dev));
+	struct device_node *np = dev_of_node(&chip->gpiodev->dev);
+
+	for_each_child_of_node_scoped(np, child) {
+		if (of_property_present(child, "gpio-hog"))
+			of_node_clear_flag(child, OF_POPULATED);
+	}
+
+	of_node_put(np);
 }
 
 bool of_gpiochip_instance_match(struct gpio_chip *gc, unsigned int index)

-- 
2.47.3


