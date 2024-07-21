Return-Path: <linux-acpi+bounces-6998-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C0893853C
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 17:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC671C209FD
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 15:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912A616C438;
	Sun, 21 Jul 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsDTo0Z+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D916B3AD;
	Sun, 21 Jul 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721575173; cv=none; b=Ps7D7wd0dc1k3FzD3yJMo3a9HCxF9PiMwvhMx4d5Gvr5K2hkOZFGwwQsW0ZGYqkB8yzRYjjnF1tSptYoU15uLDIjm+K6lziMc1ZVARAcRsfYZC7QdKm7nyEBH2uK/qslyPIfocYWS1FoDSj73jsb3JqZfEhEZh67yMCohl0TPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721575173; c=relaxed/simple;
	bh=IZz056KNV/K5vy8xE0mpvGhKiXnzIveHDDS4W0kv+KA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WoXFdjRbDA1NEzVCJ/Nb2X1MNQ1Lckny9Jmb9PSh/cJ7J+axxn/twMWbW55ZiwYFifcwdy8kXsyIF1lNds+Q/3qp7VAaD6l3R5WWaw8ox7zcdbrbNA68yAcA20P1vGkquhhioqWHcJrrUNVXyIl6Ucl13CoyRuz6YWI0ITct7lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsDTo0Z+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77baa87743so367070666b.3;
        Sun, 21 Jul 2024 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721575170; x=1722179970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCaeppO5TKYQKt2aHsXVMJ2MVvG+IrdjQ14PrXl1bh0=;
        b=PsDTo0Z+xpbzxgrVTn4r2Krq254svorwrSKsYndG2InltVmeOhZjofFhtBS3vKcyhG
         eHV7SUxF9YD3/M4unSScyCdDqoJ13orTPC2F24r23B0VcIwsb+rMSEMcdvaN/fsBNQEh
         SkeLTfK9XI4twqc8Z84xIm4DChlr5LeVZ4c192lDIWl2ZZ4UVM7N5UuVm8/DYtaULrd1
         QGnXZUW+kjnsMpkSAJyEAeQ7ixuTgmVaBx/SZHev+IfWFuDQmo3EdfMqWaa585jBp7l0
         2CjBlPUasav8l0yidKbQFGJK7hfw4bzt1JtAmFx3wgzrFmvz6eXT60D+qqqv0NuPRoFz
         lHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721575170; x=1722179970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCaeppO5TKYQKt2aHsXVMJ2MVvG+IrdjQ14PrXl1bh0=;
        b=F83PcdDfSoTNaG+zIYn20nxfg7Z6Eji2mET31x9ODyGykpU1+PiaGfF8uygquIotSP
         Bq06zupdpYbsKALIKiIbrLvOP/ryAfuX+tDyO4UhT8de9OgIRqsduSxKjExGlAQOB5oP
         P+npAXseWSvfQiHqFD6n7Krfjmz4s+5NJ5dTG8UOl/SuNyJHc3IxCDAQd/qkOafgDLNX
         FKSHmATyTNov+Eao/bs4UQHtlKmKjnBQpCnxzEPf0xa0LD5O9qCfk1wmkAPPw5La7vYS
         Oa90CMwN65ry/W91fXYtMJzTnpx3Ik3pBPBaCHAVSNTl8T2zvpa9oZuwUYTJtiEpVNWh
         D6aw==
X-Forwarded-Encrypted: i=1; AJvYcCUz6G9DasdzhFkoKcX3bw2Fhlf8CHCJS8uz7SRtYjecdivQ8pCVoYyAndly2TX3uaoBimua7oOPOwx9R1LKGGxFhg7IgJpXiazAL7ze8x8phU6tsxquJayHZfcIO67gGenhtKhEkbPtjym1IAUtUWlYMFUn2VmYSDJZ0x5vmVYkWqPLsqYN6apWF+a9ibEgpfMQuWLyNkY5N0F70YtQ
X-Gm-Message-State: AOJu0YzS9SwuhD4EaiJGnVQ14LkO1ol30mzxT943LHa6b1MxgjnSDPb8
	RG6C/6LzQbq1a/cV7kpC9YmBG+LUi4psEWe/vSUe4j7nMF464DaH
X-Google-Smtp-Source: AGHT+IHxuJd7XSf6nb/ITawU9NSqfoOysNSpBdPER5Ug2vlASU0Mv26PZB28946+o5vf6kRkZ120kQ==
X-Received: by 2002:a17:907:72c1:b0:a6f:b702:8a21 with SMTP id a640c23a62f3a-a7a4c4711d8mr313073866b.63.1721575169807;
        Sun, 21 Jul 2024 08:19:29 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-859e-243c-21d1-9ff6.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:859e:243c:21d1:9ff6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c78603dsm302270366b.8.2024.07.21.08.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 08:19:29 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 21 Jul 2024 17:19:05 +0200
Subject: [PATCH v2 5/6] leds: pca995x: use device_for_each_child_node() to
 access device child nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240721-device_for_each_child_node-available-v2-5-f33748fd8b2d@gmail.com>
References: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
In-Reply-To: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
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
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andreas Kemnade <andreas@kemnade.info>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, 
 netdev@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721575158; l=2070;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=IZz056KNV/K5vy8xE0mpvGhKiXnzIveHDDS4W0kv+KA=;
 b=0Hk6DPbuVgat91nCbXV2Uc5dy+J5iKlJx6cRKAKwJr7juKeeou3yTnjpfStfyQu+WL6OixVhc
 lD4IQMFZXQSDDVSS2NouYI1/3ePm+ZSC6gokltOpL2DR856jpP9HQwO
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/leds/leds-pca995x.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/leds-pca995x.c b/drivers/leds/leds-pca995x.c
index 78215dff1499..a5b32eaba724 100644
--- a/drivers/leds/leds-pca995x.c
+++ b/drivers/leds/leds-pca995x.c
@@ -102,7 +102,7 @@ static const struct regmap_config pca995x_regmap = {
 static int pca995x_probe(struct i2c_client *client)
 {
 	struct fwnode_handle *led_fwnodes[PCA995X_MAX_OUTPUTS] = { 0 };
-	struct fwnode_handle *np, *child;
+	struct fwnode_handle *child;
 	struct device *dev = &client->dev;
 	struct pca995x_chip *chip;
 	struct pca995x_led *led;
@@ -110,8 +110,7 @@ static int pca995x_probe(struct i2c_client *client)
 
 	btype = (unsigned long)device_get_match_data(&client->dev);
 
-	np = dev_fwnode(dev);
-	if (!np)
+	if (!dev_fwnode(dev))
 		return -ENODEV;
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
@@ -125,17 +124,13 @@ static int pca995x_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, chip);
 
-	fwnode_for_each_available_child_node(np, child) {
+	device_for_each_child_node(dev, child) {
 		ret = fwnode_property_read_u32(child, "reg", &reg);
-		if (ret) {
-			fwnode_handle_put(child);
+		if (ret)
 			return ret;
-		}
 
-		if (reg < 0 || reg >= PCA995X_MAX_OUTPUTS || led_fwnodes[reg]) {
-			fwnode_handle_put(child);
+		if (reg < 0 || reg >= PCA995X_MAX_OUTPUTS || led_fwnodes[reg])
 			return -EINVAL;
-		}
 
 		led = &chip->leds[reg];
 		led_fwnodes[reg] = child;

-- 
2.43.0


