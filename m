Return-Path: <linux-acpi+bounces-21407-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCDNCNJTqWkj4wAAu9opvQ
	(envelope-from <linux-acpi+bounces-21407-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 10:58:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 684AD20F292
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 10:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2044730B5B51
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 09:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0101637F74E;
	Thu,  5 Mar 2026 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="am21ufQP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HWHBddrk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB837EFEF
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704322; cv=none; b=rrI6gWMhlZcPHGVwL7hwJ6xm6T3h47yYwS/n9q2ZRx+ErlcIHQRhzNPlGHKoUU/oRndXabQfQFUBU8DAVrnngfLkCsXAlea48BKXPeUUtXqAWcijYSEo+dHiZK3GMqqZF7hBJrOKJiSvr6ppP/m6D685fBdCY3BOT5av8wiv7WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704322; c=relaxed/simple;
	bh=HHxKSnrx8QF12IYAV4N9qkzXGUbUGiRNZBd69B8GJus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQf31SKf3mlLXHveGRmBKa44I5NlAFQE9keoEShEH8pof7g9jJBn2WQxXYNXV0As96/7M2vBgtxZt/3FLBtMufpCNOzfbAa2zLBg8zchncbEPyEL7P81VZdbjYh+dkzYBzHTTR/bVHifd6j4XopOdsP1fBn1T655/iyqoLbjrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=am21ufQP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HWHBddrk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62595jeT2665021
	for <linux-acpi@vger.kernel.org>; Thu, 5 Mar 2026 09:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CHD0ZvMybN/f9h6/Y0JvrxV1/0Bjsr+YtXr5TqQuVw0=; b=am21ufQPh0hu2PwZ
	4Wg+bv86mBQiRBwf/Ej1najcNbnmrAMFcJkEeRUX1AOkHd+pe+guARxGfTpJHLAG
	fiRzI4lzaQHdYJx/E4RXfKcRp4ecSfTMwgzfUd9eVpVhXAHYIom9ldftEMRt8Xya
	wv6XDGDhdRoPmAYzPk3Tk7UanyNku573qvtwxshE9vwfiL2uuX3bMgJDYwsvCYpw
	ctroLjqDJaPmvisffJAyN7d1hhdvljE92rZt5I9YMMhhGy1YjM2hqz6tZhCJPtaE
	jDc/7PeUHEDGk+QhLJu7TzyJDRlf+nq6ZM5BHMfOXaUenIbBoRETNMP6heP8THWM
	9ayEOA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpuhb286g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 09:52:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb52a9c0eeso5839100185a.2
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 01:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772704320; x=1773309120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHD0ZvMybN/f9h6/Y0JvrxV1/0Bjsr+YtXr5TqQuVw0=;
        b=HWHBddrkO2hA9iLfqsYrmwUa3DFYkl34890wOKLTVnvhyafby4cU6gz9TZUft8g6bA
         RdhhO1DYtvIMaJ75GpIWcniRQxf3/pMIafL/rsUbZqVs/8nGuroKzuGu3TkEcESJVJ58
         3S6D39Z32rP+23gqtueB3iWpLtt5P+un3SAIP6A73iyYy66/0t1NfZA03znWgm1t9zdV
         h/eOwsumf0kHusG5fX26EZGu1JPP6OVV/myzqDjQ5EyxnD9tDUbO/EFRNzB6xOhHQsmb
         iGSDDAI4D74nKjz+ZlEQEJ8SPL/n9edCHdL5PwNTYXbbWHrg2oEMTl+agvF0Ddh8XH+h
         7fFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704320; x=1773309120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CHD0ZvMybN/f9h6/Y0JvrxV1/0Bjsr+YtXr5TqQuVw0=;
        b=G1ib/g1O+4lk/8iacYxeBeflgVU/4FGZ2h/N5PJAImbA3Fnl/SQMS0OHvO4w+NWxTR
         4tUtUO9FBErTNLxiLg/0fdqmyfLkIc+nq4bpD/ubVUGYBHKBj4OxUyrIo82yDriACwjF
         W46YrZglExeFptb2XL+S/gdHwuWWyAei3J6fAlbSqfg5CO5scHx3JLSnGYsX96Zbcdb3
         uOmf6VHGqGZzHb3iyH/TWI8RuO3tCQrF9F08Krt1fLqEMAcxuUPPEBifAUQvarLw+TG9
         8hqYivXe0ONNHSWyr2ChSmnchNqh9VX4sqZng4bTwd2nkYW6ixjkKkNCmCH/JfKw/xCL
         ZLNg==
X-Forwarded-Encrypted: i=1; AJvYcCXYU23o3D1RrA5QIX7WYFKZXPpVyeNwQfkF81iwOEBZCMaxSjCJz7wz+3lTG45MndbKLgoC6AUYVps9@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLqxe1PKAivVaj58kWhseKBz0OYZW3Bc0bcbxeyU6Jb7Y10Vn
	Il8MZD/i5kpNI18Y2ZSRmOFfr4A7CzBexa9zcf0r2bUq+HyFKlP6qrJ1O/NPLhoNJHmtkj6msXJ
	12qJDsOTO4dn3OYi2sB1+7BMWEfuXjdRP1hIM7VJrwY0gdczFHhMsavM2LwV1kGLh
X-Gm-Gg: ATEYQzwo5Cloo4c3PPvN3BmH5NhSSqfwaMQG/wbF36S5T5WJTtV821YWNOWqJDrn5I3
	+5aqf5O/0CJ8oDw/brsI1f48M3PUJGhyRMiqNI2khlZOvHRg+TVeVT4vbZXg+PPoTSogFOy3Ve+
	SjaNFgtHFd7DVmfBzqEqZcA1vCiSZCqUIZFZThr8yXLYK5wtC4KMlfeR6OwtNoxudRuEsZyIXfp
	PNcDWZGPF0YK84sc2kYpvV6wp84jTh7czAAswBldfu8Tt5jZ2qipdPfWNldHpPgCBfb/vV8W6GB
	TjNAVvWmlLA8Wz9UY1fn0U19RY+Tm8I6oEa1sxVlQqRHwKice2hAWzV96i3YH70kdfKjZn32OeA
	C4RONhr3H9VuEsDgahAm8gfyus349GGOB0dtl3ndPUReUNNYb5zUS
X-Received: by 2002:a05:620a:29d1:b0:8cb:72b2:2a15 with SMTP id af79cd13be357-8cd5af12a64mr588825085a.33.1772704319991;
        Thu, 05 Mar 2026 01:51:59 -0800 (PST)
X-Received: by 2002:a05:620a:29d1:b0:8cb:72b2:2a15 with SMTP id af79cd13be357-8cd5af12a64mr588823785a.33.1772704319561;
        Thu, 05 Mar 2026 01:51:59 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8314:9d33:34c1:88ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad1656bsm35598215e9.24.2026.03.05.01.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:51:58 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 10:51:31 +0100
Subject: [PATCH 6/6] gpio: sim: allow to define the active-low setting of a
 simulated hog
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-gpio-hog-fwnode-v1-6-97d7df6bbd17@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=HHxKSnrx8QF12IYAV4N9qkzXGUbUGiRNZBd69B8GJus=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpqVItGibV7CIxkL+FQcAk1MH5WBNN2KFBq4i2N
 nNYJebj6OOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaalSLQAKCRAFnS7L/zaE
 w1gjD/9X6GlKnqvOTIly4upROqqQSVnKHqiA8DysHPSXiS5iN3krsYiZb4kjSRWtLDsjs6N9RSH
 66v14HXZDcxmd97WQE2xt0cqBYYxE3LKHrw0901xDk1HzAcPxeoAOB8j6tOQbGN9N8U+frKyruq
 6hRZNl6N4C4w60ZvrFbVT5KD0dJ7aynBsLgIFaB5v6bDK2uf993Pelr/fAVd3Wc64YtUUuM4Y4K
 Y82r8lGxsfD/t+wvUxxPu8GAkqGTuAEww+g+sGNR4F15yFwGTD1UXWmMiAaupBwB9D2XDTj5rxA
 9d3GBcO/NXSX38ro2o6SlgMT5ZpZvXsAU28+rVB81JrKYavQn+u2B5Njj20vpXVHbOipFk1ZxpV
 PDxU0lZD9uOcaGv45XumkJVu52UROm9GhPYlfQE4y/NIIFChQ6YHwcxXR/NbR1VBn0EbHOL1+77
 6eVE1ytqDcMd3kvU4aqZdvBMlL48SGz8x1c9rCnwAjcB1SYvzwMaOfWkXKgqsF0H9mC0CXJl77V
 EHGvjr8+nTeytrqVFiD9cQcB0f7L1rHDcJnztVNxu8uQYh68/3EUw0frZec8ZpGW67RQnC4JW5W
 uTN0EOg0HQSGwnKfd5gzUOVdVaYJxnZ+ykuxZ144n8Bbx474aE5atdX5Hn81viTWRb7pBy8dDwu
 t4r0f46Ohl1gLZg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3OSBTYWx0ZWRfX87r/IT4Dh/wH
 qamgHUXxwxUZC4Jcm6kLP49r3QqkjkdtjkQiOkQZAkGz7QL9o+j9OqNVbIw85d4FPv5c7iHAoB/
 x8wYEosP8Ohjy2KZFq0mZhatJH279VVH6UXvgnhlbZ88YIfeNouIgyBLuUX+/NG1E964lwoCUP7
 FmRMT+QR2rdFbLEaz8UIi3pjAvMCUR4xBbLLY/GxUkhParmIQeg9ICbXOAXmgI5hUUjINVxVDU8
 1CMI4/js9NG3RT8VR/OkMPV+CJCmXjru7/AqaDNj66tXsz/RXYJv1m3aoqnDW1r+g7hreqojDhf
 WgsXGmDqQ5oQY24zDSBDsSOIJiohaeM5mxXCXyXT44hYTD6WtHavMstez2Mx2Z+ckS6IbapHlK2
 m+8SjZI8P7nWGg8izpgtCJh+ZBavAVoUd4+Wo9XACkLhkhsyBvciU1VxndZmo7IE1ZRZzcH0L0r
 nEgtWHuam0CDwiWlAuw==
X-Proofpoint-GUID: VxA1BiExx-lXxl8QjPTLMTO4edktwyLz
X-Authority-Analysis: v=2.4 cv=SqydKfO0 c=1 sm=1 tr=0 ts=69a95240 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Z_vE--IGminT9Q5MwdQA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: VxA1BiExx-lXxl8QjPTLMTO4edktwyLz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050079
X-Rspamd-Queue-Id: 684AD20F292
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21407-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[kernel.org,glider.be,gmail.com,linux.intel.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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

Add a new configfs attribute to the hog group allowing to configure the
active-low lookup flag for hogged lines.

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


