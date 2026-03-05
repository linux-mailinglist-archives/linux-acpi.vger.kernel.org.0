Return-Path: <linux-acpi+bounces-21406-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLRXOHNVqWng5gAAu9opvQ
	(envelope-from <linux-acpi+bounces-21406-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 11:05:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E77BE20F54F
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 11:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66E70301083E
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE4537E301;
	Thu,  5 Mar 2026 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jSg/4hJg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bj4LZCmJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7855137D13B
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704320; cv=none; b=eDSVV/DCDZODU8O5KTvZ3qWJoEmuAi1F5atS04HB3G0QLgPV8x4bzE1Az0Fb+C/XMXiTs5w4JslWExckeyb7Vgv2Zj6fwwgWIJoU5K5b02akevaj4j8MSv0MASwYdiwEPM17rG6nLHQv8bNfzLTALNp8jqK6NyAGFJtDbruD7lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704320; c=relaxed/simple;
	bh=nHHCSm94RSmEIVpUlb5PB0C2I8hqgvSMHOW0imJuagM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fFGGPnOhfhpaBL1EJ+qWahguSJGIqT3sq+NbdX14442oW9wFJYzYFRnYEhWTRHZsQyB5vbqK0EV/7roRz/saULVBSZWy5CfMHEOvebLjfXGBQuvlLI2mGtppR5TpLgDjCnTNwIARIJHCkTDQvazsaBfZn7l2F69pV9rPxJwMGuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jSg/4hJg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bj4LZCmJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6258wRBO021036
	for <linux-acpi@vger.kernel.org>; Thu, 5 Mar 2026 09:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9lXayYJMb4sTE8GVHr0RX0rbTjMxVYXXnx+bVcFFBhk=; b=jSg/4hJghyJX7lU7
	UqNa0NeFSNDZTu2aeyWp+WKa8GFkTQBkF4JpTzvgoE6DsaalJjvMwNzhqeVwMugr
	wNt6j5clx/9FfcwA03lArVyuABsLpfefsK4uYJk74G0QOSsPs0waA5+b0vxoXycF
	5On7egWWivRCcT/cY/X6ZqFJ4TyMVEkdBDFaaQjVtmrBlzbrl2t1VDVWKnAMvntK
	OwirLW3Hk8VdDxZl5syi0QaUPGUSMRC2P2eONS7pEPFqESjFtwDnJbmk4Zk8Nogs
	Xn+dltxPgSn/YhBQLmUDCD4bkD1t7/JeqwT1R8blXiaIBsV0zd3Y7k0XTQap+Dad
	hc3KWQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpuptj79e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 09:51:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70ef98116so5473129885a.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 01:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772704318; x=1773309118; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lXayYJMb4sTE8GVHr0RX0rbTjMxVYXXnx+bVcFFBhk=;
        b=Bj4LZCmJyM0jeD9PWWmLxXcf0BQJyA3LITflcd+PpUQXm6WcUSZljdBfyMtfMBrFxr
         tVBY/+xY5P6bORGQDyzONOJLec9JC+ja46VJhaqwTV300aTgHuNGkkpR8mIj04QCYDbk
         adiG0lt5JoR5ufBIwu7MkK0IqbL7yAFXRgiMW1uqNTk3Og8quu+wU/IbMqzQYtZqqIFi
         6xajzRGMuztJXaoGeRH+YSL8o9Gh03uI6Yqn1vovrPrNkNQvBhAECUsAb3Po4tjQq9Oi
         5hoIjIdnIG+uXcW9MD1sKaHjHkJPqsFrh68DwVKl7kIMeIwOYERTq/hSai/BzdFDzyRn
         r5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704318; x=1773309118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9lXayYJMb4sTE8GVHr0RX0rbTjMxVYXXnx+bVcFFBhk=;
        b=Li9TWQCi4HBUe5epOXDg422yv8fs/Gr5Rod+u/W/BmcMjdvJTdjH3hsWx5Ncj07cBl
         Ah1t2tz3q/syk0uA+iQxNpkbIP3ETNeYEL11JZ8In4bmlsx86xDYFDI0aoP8yyibaWWC
         bj/Sig6bUTcKt5eIwizBALA9ueDnQrKQfBAN8cAya2psIpS7C0XLOUKwikJFV9fUYlFt
         ZxExrhHuy94qCP+W8tln7ic4vtrKoJx0Jujyj00h6xFwB0B5K9HtNy63PskJhyQR3UNe
         o7DKCMzsO1Q7S2Jf7pPigmqlcKQQ5270g5Gxj8S99dLuV4/vWoMuqAgMsRVlEIVLDY9S
         qg8w==
X-Forwarded-Encrypted: i=1; AJvYcCWn5zOpz44KS9PqTz8mHJ0Nlh2Ds4XgTY4m6oFF1L4krt70SnrmlLsNVV8TyVprZdwB3F9gDqNks3oO@vger.kernel.org
X-Gm-Message-State: AOJu0Yyovaen0Bp4GDFxcUgj/QWRwFUI19ZUXcta+VA1MSY03BkRPoiG
	nn3aIk3SGbCPqAPJ7sUUJlzYGSPmhoTUZSeJcXjbnvMPwmYgFRao/KF2TL8YIdbaNPDTK3ueelv
	ahxjCOd2UEstt9dYSrhSHzPzs0PtHaq/+j4ZELhBXkG9k5lBO5JrlMydPGdXaVSqV
X-Gm-Gg: ATEYQzxQvWqHi8Grijwfw4y52KeLIkmn6m+0qCjf3QkJKtxcJo6dz+UO+MORdUTRcuI
	W2QTJAdfcJtpMeBWDcKudVj/b5u0GqhqqoVbHhsdKZ3KmNtWq1Z6aL6TisA8bml4yriNdVxfyrk
	ddoRmfannV8qO87m32vIOOzCI7fZ7qCy2kCvjYw4KY82ox3YDDljfmiOOAnNQ0xWIPc6PyAVRHW
	MSaKeMFutVl6qqXJmYOWfm1JbJOVhqIlb5whLZYHaF99Wk40Yyf/yDkj1w8AiVc+jd4YvSLb+1r
	7TwOMI8qFwCaX4lioz2P2jSsVISqvWgZBwVYlNSRwsAoISnam//uYLDTE9p2mnAvpX2j9mNPcL0
	jRpG+r9bDmcPAvSchgAg96LuE3oKf4uk3c13tAQ/kV3U54dqfl+vj
X-Received: by 2002:a05:620a:1a94:b0:8c6:670c:953f with SMTP id af79cd13be357-8cd5afa51a0mr579593285a.58.1772704317653;
        Thu, 05 Mar 2026 01:51:57 -0800 (PST)
X-Received: by 2002:a05:620a:1a94:b0:8c6:670c:953f with SMTP id af79cd13be357-8cd5afa51a0mr579591885a.58.1772704317222;
        Thu, 05 Mar 2026 01:51:57 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8314:9d33:34c1:88ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad1656bsm35598215e9.24.2026.03.05.01.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:51:56 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 10:51:30 +0100
Subject: [PATCH 5/6] gpio: remove machine hogs
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-gpio-hog-fwnode-v1-5-97d7df6bbd17@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7113;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=nHHCSm94RSmEIVpUlb5PB0C2I8hqgvSMHOW0imJuagM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpqVIr3OTbQ+EhTR/0KOPIsw7kVLs2Ax4N5tZgk
 wRj0KhbwzOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaalSKwAKCRAFnS7L/zaE
 w8qkD/4sUoU6WuCaaKi2i05/0ZwSbE8TTFhBiPRiYDkdfYLS6WyiOS92WfOTLqKUORwgNJLJce7
 0he2vPpJWv8I5nkqqglm3uo4hudl7P9RwR8tJnmUyt8MYPoKqNRJex3EC9r4Ud349DlvZ6zr7T2
 PWuGqbTlNlY2qvulNPAM9PnvLU14dwT4Kw60jacWu6SzA8FpX8PSDLQYgayVxVaHf624BU3GIjp
 Xjm+lnPeVRt2m485svet2KXR3UfJTWMC9QkWIZJfwM8PCNtviAvdSBBQMgOpKXKL5T3IZGSj6Op
 wHdAkU0u8oT3Coc0JQTKRmZyQG1wtyoKJ5qNrwCoVJoNUL7NhEgP2xX5Ordg286h4szTMSwsRux
 2KqcC3+Om7DAWIA6ZSRjIIhL5zkNvQ1N/3KN6NmQ2+RMnK+fw5WmrqcIE5igotMCNGdX5wWWiWp
 guEtIXSTXIg5teWGUIx4sLQaL4Sb4cB5jjrGWBUCH65KzsVTf6THOyyW48SIXDzUqqOk5t1Bp+4
 s/TzXkY8lfm3VCmfqsEZZuccywZVEl5AEAX30YAtEYJeSRIfgduGmKMi7byO2CT/zv72YxHCZsd
 QYcKlgEAOGe9yEAFXwhmTQLZjLj5aywhBnJ2NKBwVsXJk9TZvilTgRHDA3inVwXpiJjoIPtYheC
 HhRpJgAzingRmUQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3OSBTYWx0ZWRfX0vYiY3t3i6hZ
 AWA99Bs93TQJ6NHw+iXFy8ekafWck81CHCk+ucQiUYQjSr4fRUpggkV+FmsS65EqAzApvFYYgAM
 QUuGX1ZPQTr6wNiVJKxSCVzkvRtPQA/1JMpCptRS3KibAJR8OpU70gjfToYmI38OuH/IgpjJjDE
 LgdZRygpy5om95txUpjkVJDnlit2MGPqKEplq7W2SngdFiYmaqcC7zWboiCy3fAem14q95jN+TG
 euEaGPkaN2fZcXQVOW6RfAJDn26kcDYlR3oN4yBagluBtp0AbXDfmrZ7FDYNx4wvuU1aqe1MrsU
 HJi+GjJz5KIvFV+aF+rmQxXMBmgfWHJ8T5uFml5H98jgtIE2B4pdjh9js2wTSIGtRzi6vFi1IOL
 WkfPJ49qKNu5cgxnGv7gBzM4QK5AJVaSX8UohBD1iYNV5qZiYr0Gv1Q7veiOGRkK2uFC8e/PdHS
 qV00suZy+ezO6DqQN+A==
X-Proofpoint-ORIG-GUID: Xgo3Hk8OPTIqjnioCyQ9JR5Ia7Q-9MyE
X-Authority-Analysis: v=2.4 cv=Ddsaa/tW c=1 sm=1 tr=0 ts=69a9523e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=ljULaDYbSg_dSHWjUBoA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: Xgo3Hk8OPTIqjnioCyQ9JR5Ia7Q-9MyE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050079
X-Rspamd-Queue-Id: E77BE20F54F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21406-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[kernel.org,glider.be,gmail.com,linux.intel.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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

With no more users, remove legacy machine hog API from the kernel.

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
index be2e6ed0e744c23939491717a060d3a8456c842b..e732427e2a975585ec873a5240ab92e3a4cf187f 100644
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
@@ -1049,8 +1016,6 @@ static int gpiochip_hog_lines(struct gpio_chip *gc)
 			return ret;
 	}
 
-	gpiochip_machine_hog_lines(gc);
-
 	return 0;
 }
 
@@ -4584,42 +4549,6 @@ void gpiod_remove_lookup_table(struct gpiod_lookup_table *table)
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


