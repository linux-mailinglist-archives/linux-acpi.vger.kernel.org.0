Return-Path: <linux-acpi+bounces-6791-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CDA929479
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 17:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E903C1C20ED8
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FB313D639;
	Sat,  6 Jul 2024 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgDjJOXj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575D13C8E2;
	Sat,  6 Jul 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279441; cv=none; b=c+NJcwqGPbk9uJGj4g+QiZXH+vIqPg7ArLpbx//oUP6fZkRMPq5reywR8qXBU8jTYGv/f2h7K6muA4dUVHxoh5J/yyLjrnmjRyeH1y9nRip0adDDVO/r0hQHgDbzU3tPHN+/M6QPcbztveOfem7zYOJW3k+C4XVv8cz1KnL1X1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279441; c=relaxed/simple;
	bh=fqZJ701DBgGh6DQqiXNJ/NxMzjiGcQXtbhZJoo4oHkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GNqNK0scmcqJ1ga7XMAIHPCb7cskWoSFDiEArXp1zeWfhLNR2Gx2Z/OGpyDK9JwkrtGMI8C4jSadkQ3X1bKstEzWyJ2rws7us03R/Ld4snfgn7towgpi8Ubzu6Qp9H0k7K8brRHsJ+g8Bnvk8TZIqIniKKS2LheD+B7GTKA1fY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgDjJOXj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367ac08f80fso797525f8f.1;
        Sat, 06 Jul 2024 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720279438; x=1720884238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNURRg1zXJNR5Gqt2mpwpSYiaUFcsBTrqWCau16CfK0=;
        b=ZgDjJOXjrZh1nHR042VIlDYWE0gI+IZNbqAn50dc6LczvBa1SyodSNj04q2fmmFhVa
         KJd5xqBOXL1GO0Onu4GswafqCLfD76urJnbbs+6SgzAEprRGWFRQQBbzxvWbo0juvI/a
         H05+gkP0t/QjcHUjJT3XwiXawBpF/pwqg1T6U0LV6ZlQoCP6QloHAPRmOxyLzaihkFLs
         DROOww+QpWD3+HyxH8uyGKpOh+ngWLrJbCGZzFP51He4UAI5hrAtDU/fE1EQ/NH62h/k
         vkqCBxT3wd7uAeL0ti/gJlETpcd4OTb1hC0+T1L18c4ZGZp9May/WU8MLxVUG4BN0w+W
         8nSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720279438; x=1720884238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNURRg1zXJNR5Gqt2mpwpSYiaUFcsBTrqWCau16CfK0=;
        b=WfIHtM5/TmYn7Gw4M+enX6/5uLNmrOyI7qr5xs7iqqkEA+dZCkg4P4qhSQ6PbdtQWx
         oqdAPSekm5Nb3M5ttQxb9GAX+0LSAUltEvwXgzt+veasec2OuAkvYpNJjf6foGG7h+Vw
         JkuY+LdoJ/hSiZnp0wRx4XFqDbF0++DoqvHp7JdMWxx4DfWZ7Z6SkU0S1627nHIs981s
         PuIWxISdrhQDjE7dI8/Exnx68ddq1d/bgDasCs/CzoygfZl6uI5xTklSjFZ7C9qaffIc
         n6m3GNudsQKN4pYaFmLlLx7QjHdFhEwNomwRQxMT1fsxUaKbWRJLlqr4BxEmCVsQuSpe
         c0qg==
X-Forwarded-Encrypted: i=1; AJvYcCXsXK9HRm6xnk2dPY5SsEKdzFDtpUSfkxAmxsawWv2C40hnWPnNl7OXvGaMUeVLw99NR2k1H6FVFeIxsVi+BkRalqSV/+ahNbGhfvelv2OhYD838kLxhH0+2U8R2AIg4dL5Zqr1c7dkEz4VWfd3uYX6cjWupbI7/8i2t/l8HiSbZPubI0entBU1cYrOKJRivYilF11lnUBD1ApLlEWR
X-Gm-Message-State: AOJu0YwcULgms1t5giz8jnjZJM1H88JLbJLFGaXC2T24Q1LaUk0QoQya
	ToaOB808jKRTCtUmft3pHS/iNkzGXS+QpsldCF+X0BHFxipCVuHh
X-Google-Smtp-Source: AGHT+IEAraam7CVa4mw68xmzTqSt57yaoOsCYGEh2+l2Ul03bC3MBXIPuXXfeNvaHAEWI3IVwZdghw==
X-Received: by 2002:adf:f887:0:b0:367:8c22:5b7a with SMTP id ffacd0b85a97d-3679dd2adc6mr5606639f8f.22.1720279437902;
        Sat, 06 Jul 2024 08:23:57 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d11b-8ec4-ea76-796c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d11b:8ec4:ea76:796c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679ed376cdsm6421593f8f.114.2024.07.06.08.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:23:57 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 06 Jul 2024 17:23:35 +0200
Subject: [PATCH 3/6] leds: bd2606mvv: use device_for_each_child_node() to
 access device child nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240706-device_for_each_child_node-available-v1-3-8a3f7615e41c@gmail.com>
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
In-Reply-To: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, 
 netdev@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720279430; l=1637;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=fqZJ701DBgGh6DQqiXNJ/NxMzjiGcQXtbhZJoo4oHkw=;
 b=dcBAFFldBGqI8x3o514eq/AXVIdyRvFUMSia+cqpFszPq4N2AkkUE2Ds/x7OasYwC3u/+Tth4
 YOxArhUD6TJAw2ABLY08LcYEkvRdZqFIhlo9jOuQk0Qntk4Moqsvme3
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The iterated nodes are direct children of the device node, and the
`device_for_each_child_node()` macro accounts for child node
availability.

`fwnode_for_each_available_child_node()` is meant to access the child
nodes of an fwnode, and therefore not direct child nodes of the device
node.

Use `device_for_each_child_node()` to indicate device's direct child
nodes.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/leds/leds-bd2606mvv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/leds-bd2606mvv.c b/drivers/leds/leds-bd2606mvv.c
index 3fda712d2f80..4f38b7b4d9d1 100644
--- a/drivers/leds/leds-bd2606mvv.c
+++ b/drivers/leds/leds-bd2606mvv.c
@@ -69,7 +69,7 @@ static const struct regmap_config bd2606mvv_regmap = {
 
 static int bd2606mvv_probe(struct i2c_client *client)
 {
-	struct fwnode_handle *np, *child;
+	struct fwnode_handle *child;
 	struct device *dev = &client->dev;
 	struct bd2606mvv_priv *priv;
 	struct fwnode_handle *led_fwnodes[BD2606_MAX_LEDS] = { 0 };
@@ -77,8 +77,7 @@ static int bd2606mvv_probe(struct i2c_client *client)
 	int err, reg;
 	int i;
 
-	np = dev_fwnode(dev);
-	if (!np)
+	if (!dev_fwnode(dev))
 		return -ENODEV;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -94,7 +93,7 @@ static int bd2606mvv_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, priv);
 
-	fwnode_for_each_available_child_node(np, child) {
+	device_for_each_child_node(dev, child) {
 		struct bd2606mvv_led *led;
 
 		err = fwnode_property_read_u32(child, "reg", &reg);

-- 
2.40.1


