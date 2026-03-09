Return-Path: <linux-acpi+bounces-21541-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOJgA/TArmmKIgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21541-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 13:45:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E6823915E
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 13:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2758C3097A79
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 12:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9773BD650;
	Mon,  9 Mar 2026 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a71wUr1p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L677vjSM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682C3B531B
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060194; cv=none; b=F7Qc6Gx0YMI56qRFrEx1HqBsMt+hG2EnoptyL5Y3f3OU3NUpR8bs/DI6KivFx8D/ATwg9bgmWjmRgVxzbbxhin30651kWDwU0kYzetrL3OgIE1V0DVagklRj9GhDdKG1QrTjgnn3L3bC7R4Uy3oCGsk6HPWFn2TtqTuC7kEeIQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060194; c=relaxed/simple;
	bh=4BnEUtmMiOiwXU1lQlZ9yMyJWb+fawm1Al0WC9Bh4bA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epi/Z9Xkaggu1DdMein4GIKnb/yvboF/6fYOKaJ0gB7oCq9LONCk+Qcd5983R5+lTlIYNW6acQcB3bmn11Mz6IUamrKiJEFuvHaoRZlT9VXcJA3V762dieOuU/fyMRZxnyZ10Dv1Yd2+CNf8miXLmCdl90OTNNCRyptzm/vIISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a71wUr1p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L677vjSM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629AC7mq1128815
	for <linux-acpi@vger.kernel.org>; Mon, 9 Mar 2026 12:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l5nIeS9X1YbhohJRIffAt90+vLpOah8/bJUe3CSaJyU=; b=a71wUr1pe4R5IEa8
	iSygIp4wnj5qqTTJPqGOhK+aYYo7Cw2zreCRcO89hfNNn3LzGoViM3kFxy4dtvtb
	klXS5g3nnay5U+/kKE2PJStRpbmuBpEpqs7f55uUHXRlCg1WVwVw3huhJpYKI6mI
	RU48Bv9snpSqu/J7BEd3HbcmiTyLIliDKgMrQ6Hd3R3qt+GWK+/n+wP+PqVowCk4
	7Ut1SVvEpVrjiJACPEuonRem4fz16fQvrjWl/NbqeX4oua2BIoh1L2BHDtdgUJYO
	f1pI+VpqKAhZw5BS3uqHmqYqmTdWVvGfPvt/zAeebjQXUQHIA5MmFEI1M4e7tHCd
	wmhs4A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crcd8dbj5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 12:43:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7d4cc049so1649629985a.0
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 05:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773060189; x=1773664989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5nIeS9X1YbhohJRIffAt90+vLpOah8/bJUe3CSaJyU=;
        b=L677vjSMNEc519Pj67yE3lMM2VqA+zNE5/A0n5VLLJrYRAfvbDpn0tpnDNgAkpfUDr
         y9lfqsg4jequT4+QJwPhDGnOGFm0IbX0C0qRWqNW6FEbTpW85iJOWEQGLZSZ0ndyvncE
         lCg5Ja3dE3xdxTUZTzJ0oDjk/4BfRNsFmiqVVzz3xq3uY37Owmg1/ciS0G1qe4Ob3awc
         pr/MNXUJzbsN37Fc5eEn94fdTadoPrAWBvdrokta018VJMpU4AEv3dNNrrSuNc/j/mrG
         s7QX3hm4UcGqMGuTri6Qx2DbcJ7aRhqf5Cegw0V5Swp7DMqmtQeFJEOFmYt/5EloBlUA
         dLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060189; x=1773664989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l5nIeS9X1YbhohJRIffAt90+vLpOah8/bJUe3CSaJyU=;
        b=jwO85fj26ZjjaF8S8uEgp5Vlr0aRN3mXYSBr4zwEQeZ0SM3ys99IlVN66i3vzngTG+
         v0ERV/fzfsKc1nG9mdwqJCcElzebYHWoSOVvQe36NFYzs5J8RI3olI4b+yck547rjCB/
         jNg4I5CV9hGdzbpHzIvQWwzEc2jtwpicO0mQRzDt11Q8k3DrUC3Bwe5HqugCWF93wcWJ
         Qh0GwLk0mc0r/2hQwCZ+ghp6UdX5VkfiDqBtwOVpGgRIwipUxvuP218sSz76Qshb+mle
         WR+dTwV2qGBAAz3Q9/yJuV1QUtxwyrihSqkXZuj+/RnsBnRIU/zPNRRd6IsaAbAtL6fz
         DdQw==
X-Forwarded-Encrypted: i=1; AJvYcCVvqHpyoFbT7jbEKjeeTputV4pu6dQzu4eWkGitYKNB0CDdylJYhyIQIN7GoT7wHOFU8UDI2YSX8uc9@vger.kernel.org
X-Gm-Message-State: AOJu0YzVfGp+GirvJc1BEnpBrTVg9K8Mu9ohaSCnuQghOc1/Plfb9wy/
	4jV0SYqQsPIL74oP0QinN7qfsR46JuOWjy45tXMsbBDBZaAfziUrxu/ZChk/+3K7TWOivILBR+m
	a+CO1gYTVcOV+qGgRK9QTQzqPrHcw7gTzxoA2GGkgGzl73eCdQqxooIbPTZ7++Ukts2rYtu+J
X-Gm-Gg: ATEYQzwLEbt1FCayc3z8Ww80cP9rExJq7rhdpKiyfT32WCGnrBEqFqjP24w65pNABHm
	/afw+3IlYsn/XX4V8J+GGdS2CnSS1vHbMK0vqVLv0Tgs4Ihu9j/jscEIuWBxrrTAbxW+A8jcxHD
	IhXZ7rhYdApHb250ID/9K2aqXiegCFsbcoLyzGQzXKxLfPEdVU0sG6sONm6G/hjmuK6CDQz2nkK
	ZIMgYKAan9MRyjgFFJ6YL//gFX4R8bq94DtIUXti88IuCPEEMhHnLffYC4O/EJ4DRjFUWgUEp+f
	Nq+L7eRT2/TG449J6WeszLv2o+md4f6XFwYBkk71xZb4eqzBK/mmeLc0KkNhrwMRlvErSe43EOr
	wCaOBi4tulGgDjPBSLyYsscMtOcSvEZ6ntenKPRL2ETtOiC8PL8kL
X-Received: by 2002:a05:620a:4586:b0:8cb:72b2:2a01 with SMTP id af79cd13be357-8cd6d42728emr1388185485a.18.1773060188400;
        Mon, 09 Mar 2026 05:43:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4586:b0:8cb:72b2:2a01 with SMTP id af79cd13be357-8cd6d42728emr1388181585a.18.1773060187916;
        Mon, 09 Mar 2026 05:43:07 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:494a:62d9:d95b:cb98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48539e574b5sm107803345e9.8.2026.03.09.05.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:43:07 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 09 Mar 2026 13:42:41 +0100
Subject: [PATCH v2 5/6] gpio: remove machine hogs
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-gpio-hog-fwnode-v2-5-4e61f3dbf06a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7227;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=4BnEUtmMiOiwXU1lQlZ9yMyJWb+fawm1Al0WC9Bh4bA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBprsBM34X8qWjOEe+ZIX7SQxEMQg+Byczj+gL/y
 9GR18NPlZaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaa7ATAAKCRAFnS7L/zaE
 w+JFD/9QC8D34cOdqUHb/kJTimscTHraiX+HApC9PJcT8Ybsb9sRAhOhzU8XdLexeM9OyapI3IL
 ftjBOhqv7huCWsA5ChENpkS/mhZyFmjNZCpDgf9Mc/dHJIl5cKwYYIGSTNmTZ2bN4ONtQMoagfa
 gz7Kfe64CE3mayaZKIQq97j431fJPAYCdfusPtQZimHCFkPKPLQ/LDf0Sxl5buLpl7gQMLai36z
 aY1wG5XpLxhM5/NRicW56ARQg2DxOZbKGdLWkxQTkd4jVuZGNB2ef9dzmamHYRxqMVG23U81/JB
 XQTdpbY8q0boVBQTi8M8B/1kHxA/Hr12CQhxMEon0ZwM8WIop3/30+N1SJBJgSpXK+BaSuvrS86
 yJ4nbV/KRmCwHcptGuGZ5vQ3tBKm0yRpYA7/DO9iigjXJvciROMp69HCS7Yonv4JfHFBpEzt3zZ
 yzO8FK+TTWKZpjdoy7vEQQHbpftOmJv5KRo5pdnZTSejilcUfNn6wZK2Opj4VvJFxwuwsZkyq5D
 8E6xChvRWAn1p8FHOxz/hH9WfUkOY5KzNaCo6Ue8S4iovjzAHCIii2vnZ2bfxjIJIV4dctBKNwx
 YpzfO9YDXGcNa9zWTdgBBhaSwRRhymFfk3hoLBhr31i7DBeuDBHkAkDeyvLKqVoxrE5TUDi286f
 08Oz7S3X9LtMxIg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: -XLjQzlT3cTBi9hmPQG2BpF9no7GlBFO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNiBTYWx0ZWRfX+7TW9eKtX2pX
 WAPFK2J9scxbElbqq0VvqnyN+TuH9XNYrhbn0tJVQ41+dwCoJ7fjc6JS0CTR2tc3pFDVBshU0iy
 nOxd/7LL2cNK2mTWUYNKj259y0evc7nwFbSkAD70zF/ZOZZMTx2ObXSneDtURUXJtC/7Xus6dTu
 MsW2Js/5f32gnYlVDPA8aEuOMoHy9BIm5wx4OCbkv0Ah837IiZWf/1bXrSMENjbnEaw8K1oOc39
 I4nF8paBbEbwxyFhLjtUcFpVqb/nuKn/2NUWr38XTdWw5W/keL3LCQ1fbbOSLK/g3gM5S624yPu
 sc6GMs3ag7M2Esb57ns0FY+INikfaEDmHNmBTWdzq8KrsWIeT7NrIPRCdkwIuLg6KN+o/qPMUdc
 K9RCV+2bDf/OBZixMt5Cl2keH5duvdG5cGpxL1bwWLdWDkJjyMtwwTadA4t5YJeFBcEvwICdWaW
 eweKcvn0Djng2uDainw==
X-Authority-Analysis: v=2.4 cv=O/w0fR9W c=1 sm=1 tr=0 ts=69aec05d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=EJ0IlyYtn7jNkuMCNfoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: -XLjQzlT3cTBi9hmPQG2BpF9no7GlBFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090116
X-Rspamd-Queue-Id: 59E6823915E
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
	TAGGED_FROM(0.00)[bounces-21541-lists,linux-acpi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.973];
	TAGGED_RCPT(0.00)[linux-acpi,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

With no more users, remove legacy machine hog API from the kernel.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 Documentation/driver-api/gpio/board.rst | 16 --------
 drivers/gpio/gpiolib.c                  | 71 ---------------------------------
 include/linux/gpio/machine.h            | 33 ---------------
 3 files changed, 120 deletions(-)

diff --git a/Documentation/driver-api/gpio/board.rst b/Documentation/driver-api/gpio/board.rst
index 069b54d8591bdeb975a6c650d643db4f7eb98ab7..0993cac891fb5e4887a1aee6deae273197c6aae1 100644
--- a/Documentation/driver-api/gpio/board.rst
+++ b/Documentation/driver-api/gpio/board.rst
@@ -239,22 +239,6 @@ mapping and is thus transparent to GPIO consumers.
 A set of functions such as gpiod_set_value() is available to work with
 the new descriptor-oriented interface.
 
-Boards using platform data can also hog GPIO lines by defining GPIO hog tables.
-
-.. code-block:: c
-
-        struct gpiod_hog gpio_hog_table[] = {
-                GPIO_HOG("gpio.0", 10, "foo", GPIO_ACTIVE_LOW, GPIOD_OUT_HIGH),
-                { }
-        };
-
-And the table can be added to the board code as follows::
-
-        gpiod_add_hogs(gpio_hog_table);
-
-The line will be hogged as soon as the gpiochip is created or - in case the
-chip was created earlier - when the hog table is registered.
-
 Arrays of pins
 --------------
 In addition to requesting pins belonging to a function one by one, a device may
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b993cdae79e6dc389ca42ed079b3e39d1f9fed5a..829774322f3595d191e13e89ef83001507f6fdea 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -103,9 +103,6 @@ static DEFINE_MUTEX(gpio_devices_lock);
 /* Ensures coherence during read-only accesses to the list of GPIO devices. */
 DEFINE_STATIC_SRCU(gpio_devices_srcu);
 
-static DEFINE_MUTEX(gpio_machine_hogs_mutex);
-static LIST_HEAD(gpio_machine_hogs);
-
 const char *const gpio_suffixes[] = { "gpios", "gpio", NULL };
 
 static void gpiochip_free_hogs(struct gpio_chip *gc);
@@ -930,36 +927,6 @@ static int gpiochip_setup_dev(struct gpio_chip *gc)
 	return ret;
 }
 
-static void gpiochip_machine_hog(struct gpio_chip *gc, struct gpiod_hog *hog)
-{
-	struct gpio_desc *desc;
-	int rv;
-
-	desc = gpiochip_get_desc(gc, hog->chip_hwnum);
-	if (IS_ERR(desc)) {
-		gpiochip_err(gc, "%s: unable to get GPIO desc: %ld\n",
-			     __func__, PTR_ERR(desc));
-		return;
-	}
-
-	rv = gpiod_hog(desc, hog->line_name, hog->lflags, hog->dflags);
-	if (rv)
-		gpiod_err(desc, "%s: unable to hog GPIO line (%s:%u): %d\n",
-			  __func__, gc->label, hog->chip_hwnum, rv);
-}
-
-static void gpiochip_machine_hog_lines(struct gpio_chip *gc)
-{
-	struct gpiod_hog *hog;
-
-	guard(mutex)(&gpio_machine_hogs_mutex);
-
-	list_for_each_entry(hog, &gpio_machine_hogs, list) {
-		if (!strcmp(gc->label, hog->chip_label))
-			gpiochip_machine_hog(gc, hog);
-	}
-}
-
 int gpiochip_add_hog(struct gpio_chip *gc, struct fwnode_handle *fwnode)
 {
 	struct fwnode_handle *gc_node = dev_fwnode(&gc->gpiodev->dev);
@@ -1047,8 +1014,6 @@ static int gpiochip_hog_lines(struct gpio_chip *gc)
 			return ret;
 	}
 
-	gpiochip_machine_hog_lines(gc);
-
 	return 0;
 }
 
@@ -4582,42 +4547,6 @@ void gpiod_remove_lookup_table(struct gpiod_lookup_table *table)
 }
 EXPORT_SYMBOL_GPL(gpiod_remove_lookup_table);
 
-/**
- * gpiod_add_hogs() - register a set of GPIO hogs from machine code
- * @hogs: table of gpio hog entries with a zeroed sentinel at the end
- */
-void gpiod_add_hogs(struct gpiod_hog *hogs)
-{
-	struct gpiod_hog *hog;
-
-	guard(mutex)(&gpio_machine_hogs_mutex);
-
-	for (hog = &hogs[0]; hog->chip_label; hog++) {
-		list_add_tail(&hog->list, &gpio_machine_hogs);
-
-		/*
-		 * The chip may have been registered earlier, so check if it
-		 * exists and, if so, try to hog the line now.
-		 */
-		struct gpio_device *gdev __free(gpio_device_put) =
-				gpio_device_find_by_label(hog->chip_label);
-		if (gdev)
-			gpiochip_machine_hog(gpio_device_get_chip(gdev), hog);
-	}
-}
-EXPORT_SYMBOL_GPL(gpiod_add_hogs);
-
-void gpiod_remove_hogs(struct gpiod_hog *hogs)
-{
-	struct gpiod_hog *hog;
-
-	guard(mutex)(&gpio_machine_hogs_mutex);
-
-	for (hog = &hogs[0]; hog->chip_label; hog++)
-		list_del(&hog->list);
-}
-EXPORT_SYMBOL_GPL(gpiod_remove_hogs);
-
 static bool gpiod_match_lookup_table(struct device *dev,
 				     const struct gpiod_lookup_table *table)
 {
diff --git a/include/linux/gpio/machine.h b/include/linux/gpio/machine.h
index 44e5f162973eb6f6e85188f56ec34e1e3e2beab6..5eb88f5d0630f83b6a3a0e6727103c319e139b27 100644
--- a/include/linux/gpio/machine.h
+++ b/include/linux/gpio/machine.h
@@ -46,23 +46,6 @@ struct gpiod_lookup_table {
 	struct gpiod_lookup table[];
 };
 
-/**
- * struct gpiod_hog - GPIO line hog table
- * @chip_label: name of the chip the GPIO belongs to
- * @chip_hwnum: hardware number (i.e. relative to the chip) of the GPIO
- * @line_name: consumer name for the hogged line
- * @lflags: bitmask of gpio_lookup_flags GPIO_* values
- * @dflags: GPIO flags used to specify the direction and value
- */
-struct gpiod_hog {
-	struct list_head list;
-	const char *chip_label;
-	u16 chip_hwnum;
-	const char *line_name;
-	unsigned long lflags;
-	int dflags;
-};
-
 /*
  * Helper for lookup tables with just one single lookup for a device.
  */
@@ -95,24 +78,10 @@ static struct gpiod_lookup_table _name = {				\
 	.flags = _flags,                                                  \
 }
 
-/*
- * Simple definition of a single GPIO hog in an array.
- */
-#define GPIO_HOG(_chip_label, _chip_hwnum, _line_name, _lflags, _dflags)  \
-(struct gpiod_hog) {                                                      \
-	.chip_label = _chip_label,                                        \
-	.chip_hwnum = _chip_hwnum,                                        \
-	.line_name = _line_name,                                          \
-	.lflags = _lflags,                                                \
-	.dflags = _dflags,                                                \
-}
-
 #ifdef CONFIG_GPIOLIB
 void gpiod_add_lookup_table(struct gpiod_lookup_table *table);
 void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n);
 void gpiod_remove_lookup_table(struct gpiod_lookup_table *table);
-void gpiod_add_hogs(struct gpiod_hog *hogs);
-void gpiod_remove_hogs(struct gpiod_hog *hogs);
 #else /* ! CONFIG_GPIOLIB */
 static inline
 void gpiod_add_lookup_table(struct gpiod_lookup_table *table) {}
@@ -120,8 +89,6 @@ static inline
 void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n) {}
 static inline
 void gpiod_remove_lookup_table(struct gpiod_lookup_table *table) {}
-static inline void gpiod_add_hogs(struct gpiod_hog *hogs) {}
-static inline void gpiod_remove_hogs(struct gpiod_hog *hogs) {}
 #endif /* CONFIG_GPIOLIB */
 
 #endif /* __LINUX_GPIO_MACHINE_H */

-- 
2.47.3


