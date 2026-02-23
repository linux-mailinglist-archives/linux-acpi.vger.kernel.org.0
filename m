Return-Path: <linux-acpi+bounces-21063-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kASQA1x1nGlrHwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21063-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:42:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5F178EA3
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7AECB303D5FC
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 15:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D9C2FE075;
	Mon, 23 Feb 2026 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e/cAMltJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NFE4gCV5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6602FA0DB
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861287; cv=none; b=FrkJK3lKRO+wonBUfEOeT0ngKgSZnK2Wji+CZXO1V8QjbDpRz5kCXURsdzudOB4rl+svle3exLnxaeiu//vSzIRdgsnZIRWtHwuDR7Cc/Zo7LLLwWssvKM4luNQwX0LKSWsyCXoj5AKDi0z9Y2W2dLalS46iNkOWHXfeekK8Z2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861287; c=relaxed/simple;
	bh=BNNIjvS76V/Hdkeg6mk+QBQ5AT8jv6jaK5X2R0TgRPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XNfpWODAUWzlAwhgiwRdBFpjPbG+PwBM31Ye5WoBgeiM0pbnfaLEpvjaXQ2vi5pfisQkrOFtvRJDvnDfd4ncKu2HidhopETLkpr78LcpgcVHxXggEXCUw0qmEpIAjoExlqz2cblvo5/ruula7zz0pK3UDtxVBmcMMhrlhLIk54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e/cAMltJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NFE4gCV5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NFVcYc1200431
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 15:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZjEW/a3QR9rT3ZJb9meXpjWiYGeiMJNq2GHOjywEIkI=; b=e/cAMltJvYlAY5t3
	RzXeXW7YXpeLYFk7Z2h5TyBrxRfGfbSDnwl3xq50n87WPkP4GAgoQnHan8HOmpuq
	8FE/cvIxyHjLhWaTQ/zcHJkRL/2uKVyDu+i9C8Azr+1AK7szEe7Loe0tJEWDmfQf
	XzRh3yh+Z/sBlZkqwgfa9/ptJl+uazOoJFrL7kQ8RimnX2aSTCHjxeXW5sC9ywvw
	pjM0520XLXTcbl5OKvGWk8OUy58W2d8POFw5fK2umMgjwUoWoR85r16YcQEtwhXi
	TFIb8+LID3ThAA+sIyPksNVoRKdZlSnyJ3Zv9jG2KWF3P/8wAmiTa+cLks8fOQOa
	/l5STw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8r8uxq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 15:41:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb706313beso631928185a.3
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 07:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771861283; x=1772466083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjEW/a3QR9rT3ZJb9meXpjWiYGeiMJNq2GHOjywEIkI=;
        b=NFE4gCV5tMVUHwlZ5r7BWfsM7fkJlEsPT0RjoMbx3BHOLTmHbyJ0Zz9NC19qkbYIa1
         +qtpU4gpfEuTBw0sydYfgsMfA0MXQaOpZTBpdg4XvcUWGkRrGTZfApWxf7kjoPxXZX0F
         hxLsUr8jTNRZxEpS+5YFdB9shW4lE3S+EBUyqa63JCi3c9KpBnIPshopiE13WAZzZc23
         Af39AFwhcqn0Xx9BjOmOxXBGhfQFIYFd0gvkZaIlGL7hsiBWmdM7HJerGl6xf+ffv/Gk
         IDiV1AaHJyVAA11q6rmBpUE0SEHVgLcRPmNtTmZ4shgTIieFU21N2fSo/bvkVyYKdyBZ
         GTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771861283; x=1772466083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZjEW/a3QR9rT3ZJb9meXpjWiYGeiMJNq2GHOjywEIkI=;
        b=U8elviXg7P6lUi60m1I33GpQ+vMKGOtBfNuEt/sw7clheNqvJDUrJB54n9tsNiF4Jd
         HsXJdWUozJbh1yDWCHA2gjn68y/cyBfM7FJSOjUV5GWXMtqZHh9w+so1ezpHnP9+H+MA
         wvqvxVGwKh8qPJPJUqBK4Iq+JHu0Dw4rC7cko/MsaW5jOfDoon81+N63wts6rcgMqEtD
         87oLjS52u6OMCSIMoG3C8ZoMQ4g1BswIeNa4pUQzxTJFurqbT7qepM1eFrd6rrTWiCuL
         tbDBraFRWXMmN12uKD6VY1ZYOGaBRYkvcHruGoyf+5nO+EZppNm3iXOjM6/LmBcYpE0q
         agzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGeZ4zu5u1r7eUVyV7Fvwo9t+CAEf51uVgJvODDr9dLjESKr7U4HECN3nGYiBsL4sISbLO8WbhIWCL@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbbn97D+5Gcb0ZEjplJXZDiTMRM6680xcIAM7DESvrhuVEijW5
	3XWF/HKpy282EMuUfzEYHV22ftvkZtd0xK4tSzRmJoSSrNTtdEjuKAjbuLksRvd7dGBCQVc/Dtd
	nLxQ9w656v7baVIaRoPtHXjmMuHcfCYmxoH3wGTmTaDMkct5XCCt+PN108lcoYeMC
X-Gm-Gg: AZuq6aKONaQNcZYHiEuKCCzNEUPOwTsWadiBOWl6JrhY5vqAHlKo4l2N4PSvA3wtwVu
	pyi+ybtVFEx4U5DT+oEFNP1meOfdUHs62oXFFD/61OK1UI99EWmNktefBj+W8NrJdYZcKYDBIVW
	EPqAN3o7TZXC1/AVmB13Aba6ZWIQ4DkecXwLIYSjOhxM1GdueZpR2oC8M4E72HS6pM+VxzcRC91
	t2Jyo7NQd5RhNJuMoNBANexERuT1WMv/em8Be/kW/QRYwrxtY3U8tWcQ4/P8Vg7cZbOXj7+Y0gt
	j18APBMZgxdBT1sYubnjJK8mOTzBaAUx7kKF0EXm1/KtUYZe7RQK9fzL5XO2FZrg/N6JvzBH+jX
	Oq/GCWIdOaEt8U/0XnfHeztD3IXC+SSxG/MnkYKfGF1GN+qWiq3G3
X-Received: by 2002:a05:620a:4691:b0:8b1:1585:225d with SMTP id af79cd13be357-8cb8caa16femr980032685a.82.1771861283247;
        Mon, 23 Feb 2026 07:41:23 -0800 (PST)
X-Received: by 2002:a05:620a:4691:b0:8b1:1585:225d with SMTP id af79cd13be357-8cb8caa16femr980028085a.82.1771861282763;
        Mon, 23 Feb 2026 07:41:22 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:3fa4:55d7:7aa4:50d6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b3d88sm295266755e9.3.2026.02.23.07.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:41:22 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 16:40:53 +0100
Subject: [PATCH v2 2/2] gpiolib: match secondary fwnode too in
 gpio_device_find_by_fwnode()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com>
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
In-Reply-To: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, brgl@kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1416;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=BNNIjvS76V/Hdkeg6mk+QBQ5AT8jv6jaK5X2R0TgRPI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnHUcXGUZFY2bJGG6ak3/hcC6aURUqtliv5WGm
 JaCvkmr3UuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZx1HAAKCRAFnS7L/zaE
 wx7iD/9Ox2KjiCRYRPB7DEiGMzPK7yYFaZJwMiRI3r2n1MY5PCTCkPqxCpTyZBUW/XsuZ4uTbom
 dlangVitHGjm3QhThgnK6uNDUiEdtyth9gm2ocqbQClRWeLxdzJnDZBpIgoujcI2otS2KbvkEJV
 C6XZRSKZVqDTZ4bY9XoB4bq9YTjcxe0AWPflUfh3fdgTq3I3HpNDoX3bZeOrWmVVzhmTiD/bbe3
 Qiq9ZmPU00EjzKWv/8upoOuOjr9Uv9P7Kfig9CC503P2ekwI36Bp2scgbdn/2ZKW6Bo7p0LWsUq
 cQc+POtJWewxGnjgGp3SWagAOecMdlP5RaiWRN+1nWxOK84Occ7JBOSpo9j1wzcoitQxyRakns9
 4fXj2P/eQZF7ssehnRGbCsuJd+lY1Ia4KUz6VYBAbG3VzimBbazJxUwI8D6493EgeRViKlK60m9
 7ri2wg5PVBd0RkOepLgh2MudpvSq5sYFV8pg3LogJmD/stJWcCVI0KjcAdCW1WQZJZXXOeGthel
 tUccrql7+xx4xP/EgGjc0CttNv8Afd0ti2Cpi2fsaO8iqbXV1okEGJKNleljY1aNnHIyvsNY3Zz
 GlfW2OhexWouW+TtWQB6zZ2ioq6EeY2YYEIGUGjcN5OSmgTKtMKGD5tzvKSwxAMz2X+dFsQGtfo
 QQs8Pj4fcG0WFpQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: _auyBwXPjgGGDBstPR5Y0_3TgWUnlvcg
X-Authority-Analysis: v=2.4 cv=V7twEOni c=1 sm=1 tr=0 ts=699c7524 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=h1C75ECfyOkdviiQQ0oA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEzNCBTYWx0ZWRfX5NmPvViD3IvS
 xY0YNy9NlnF0WvC3WM9PsmrSGeQSwxV7UcucXjRsgN93Wmx4gjduEN5avVBLi4l0m6A20g5xIUR
 eK2LiycLjnBhcIi2vNpJKm9yu734S4EMK3vnPojacZESR9sv8nQJsBZY1bCYb9RRBf3LnSxzhoZ
 yqa5/KEfGEMBLshhYxjLierddQpeTN0qx214WofM1qYooxKanQz/tz8BUhizBxfERJ3f6V6P61X
 RFhLKlTC05Su2Gj8q9Q0KSKDsrZKorwOD+ZjLRXEzpRLxNCp4zlEPseGTu9qwk/2DZWV6wUB/2f
 llYAUY7aMQ8fa0i7GFHwxO7eeNxg+r0pZrXL6g4JYgHGwKHRJ5MZFMXB0Bn3UwOgMyQgVsU30gN
 uwtp+pZ47eYEfIV2r/sQKQ37aJoiH5w1r1xQZ/5OUTgds2SCdTmNc0/eG5ArVYSW6LQ6EowY1AR
 zdjR8UjA0mBh7UIHSxg==
X-Proofpoint-GUID: _auyBwXPjgGGDBstPR5Y0_3TgWUnlvcg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230134
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21063-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D0A5F178EA3
X-Rspamd-Action: no action

In GPIOLIB, during fwnode lookup, after having resolved the consumer's
reference to a specific fwnode, we only match it against the primary
node of the controllers. Let's extend that to also the secondary node by
reworking gpio_chip_match_by_fwnode()

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c52200eaaaff82b12f22dd1ee8459bdd8ec10d81..7fe1d9ab1281d6c5022b9bdd8909fef2cb74122e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/fwnode.h>
 #include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -1395,7 +1396,16 @@ EXPORT_SYMBOL_GPL(gpio_device_find_by_label);
 
 static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const void *fwnode)
 {
-	return device_match_fwnode(&gc->gpiodev->dev, fwnode);
+	struct device *dev = &gc->gpiodev->dev;
+	struct fwnode_handle *node = dev_fwnode(dev);
+
+	if (IS_ERR(fwnode))
+		return 0;
+
+	if (device_match_fwnode(dev, fwnode))
+		return 1;
+
+	return fwnode_is_primary(node) && node->secondary == fwnode;
 }
 
 /**

-- 
2.47.3


