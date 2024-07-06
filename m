Return-Path: <linux-acpi+bounces-6793-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22579929484
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 17:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975F41F2266D
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFA3143C4D;
	Sat,  6 Jul 2024 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6zzqxGr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E478C13F432;
	Sat,  6 Jul 2024 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279445; cv=none; b=glI9oZ/LFiys/+i0UHPeuICDNfTikQ+JfxIYgc8joqFNXBHHc0DL7w9cxa+yj48IEUlgAIzitxeEoUV98CujjfJUMuevRB2JxCF8XZeZmPiCZHUAhiGQeA79M3/oaUaazwj8zMo7hNQ5xxUg2qcYTNDsOoWPHZkwXJ5szBqx+UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279445; c=relaxed/simple;
	bh=K3R8ogK7IVMeFaCChZAZLu9Bvl86iEg/W4IL7S7RZa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gVn2IYz2OVYuRpQroNKKxtuvntkRps6uOLNhSgMqh64In/hkY5546Gt6r2E2Lj3nj+nA7Lfuhx9mPJ6KBC70uZ5cJeRmQogdCmaNMVQeaKZ0VxFUEile5XdUQopCdP73PY0lILTU39ps0LEgveg8RWbJHz5dvWGTRj4Sw47frhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6zzqxGr; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ee910d6a8bso20463901fa.0;
        Sat, 06 Jul 2024 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720279442; x=1720884242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miy9Di9xCntCHDeUmGUbX6OsYDKhV54cCzIVatLBuUA=;
        b=E6zzqxGrsqaQKamuTgqE79s1eguPyuMBbliLAQMtrK+cdwQ6UHyPeTydiMAPp8PA0H
         SbnlMIBop1ACi3JK5VqeW+65NUJT9kgt6j8tGUPyYDThp4UwWzH6Emzw9mSrGmbYCzQ4
         9JESVpwqipu/s/kSWtG3lLgm5+rLnQsdhhMgAM1p5OtHZp/xOQeDcb55hCY5wDZ21BNz
         XV51Pw0eqD2lduflO/ndccMAUIMNJaJlIFaxH2EDxQCyjLsmfziW59BG4+x4dq2HPFe4
         dKYsD4JiXZ56KPK04blRBVl7tN/mnc170j6MvechI9+CkNH28c+UskOjozQfTHBeCums
         gTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720279442; x=1720884242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miy9Di9xCntCHDeUmGUbX6OsYDKhV54cCzIVatLBuUA=;
        b=HWMMCY3SjsB1/bAfnH0IXNOu5A5dgV/+QACR+P+KnlxqKHNSdrg+USXgUay+xi33Fi
         MqDDBUYTgh6DI/fJnav4w2JuJ9N+r/mj5LE8IFhMoSwmqtVoUkAAc6ruq/QSkUw5TyZB
         BPz31SugGyLDfPJ3iR7bYgCE+AyfWfWxCnXOI39IoeLw9MBlSox2LVHv6HYirtkfqL+U
         cy+Z3pDKp20vwphUOVmNmQEfVwC84NiS/YU2QbcuExnDDGxdKu69GWzcdfK6ozXh1ZOK
         pUFvxO4Ng2geLpfhiTG/zLHEgftpk5qm4pHJjtf+fHK02ncjTwfX+9kUjMGMJjqUypbD
         9r7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqsBaCOfzpQhYSvSwf4fUbGglzLb0RL/Fc3JOgbkf5dfVQn4IGF+QlezyOJUKs0SSXYOPFaHZpCenS/fNXeK2SicXkqy6XrBrXwQPsaTBqptCqtum/IDb9il1GdIxaWmjuPAPzpfS7Ufn3o5NcD2GA5lC2DFH6oOc/CBDcF+42iHgUM4B5azp4n5i4d8MZG8V0d2iXETM5XqHNTKDd
X-Gm-Message-State: AOJu0YwxgEslYz/WkEGSKfJed+hDKoPhLSidMyj/OdGPH0PvaNmg5jpf
	JOXw9St6yy1p218WXkdnAoFJ2oTRVqVvJbsKKZX5QzVe+IUtv/kU
X-Google-Smtp-Source: AGHT+IEl+fY7kn5+q/a8NpX0f9qd1gxze3aB0YAOzgBJhOMrKDCtNUXcKSAjD3y6X941eQrjNOfHgw==
X-Received: by 2002:a2e:b5b7:0:b0:2ec:5364:c791 with SMTP id 38308e7fff4ca-2ee8ed9132bmr46099601fa.17.1720279441709;
        Sat, 06 Jul 2024 08:24:01 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d11b-8ec4-ea76-796c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d11b:8ec4:ea76:796c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679ed376cdsm6421593f8f.114.2024.07.06.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:24:01 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 06 Jul 2024 17:23:37 +0200
Subject: [PATCH 5/6] leds: pca995x: use device_for_each_child_node() to
 access device child nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240706-device_for_each_child_node-available-v1-5-8a3f7615e41c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720279430; l=2009;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=K3R8ogK7IVMeFaCChZAZLu9Bvl86iEg/W4IL7S7RZa4=;
 b=60bPyJCCQaiTgPKHxfDehXlLgljOBSixt0bYCkeZYlDJfQF/YdKwjI57sn/g7FCDty7e2dKVj
 FfxuObbdT6uBw7l/xk35X0tnV4cEdh1CNbUN9YsFzXudcztBEIQfWeD
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
2.40.1


