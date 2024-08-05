Return-Path: <linux-acpi+bounces-7296-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD7C947D28
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 16:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5CF1F2160F
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 14:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213AE15A863;
	Mon,  5 Aug 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjZfb6Wc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632DA14AD0C;
	Mon,  5 Aug 2024 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869417; cv=none; b=S8fz6XMQQPNVyLImPbrmdvgLtjJTEeTHwPLSqUfQ8slDvm1zqCYDSQo9CiWsAGiA+MUmzaOv/ah4a9UEFN4hdO9p1SKOahBXIEaj/sAprdkSn5xwHr1ljVB5DOnwa2GJ/o14NnLoKLt85PBxb7YEYDn6cwZZIKSWoG0LOWuqGHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869417; c=relaxed/simple;
	bh=7kg2DOJCEtgdPsOeKLV9ms+2/ZVz5OINInC7YD7FABM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsZjHRHlZ4ps/IHZbVVgnxiWCSc2OQctIS+QE2D58240zuLEMPhDL2DI3ATQjdWPPapSjOPyT8Sy9nAozbsLAXalgyF8tWYnjRCnKAoe5N2ShZIdtQ1LoITA5Y27G4aASyjpWr3LGrHAhsV9MBHyXAbMrSnRbXgfnGn7dIyHbQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjZfb6Wc; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a611adso3413870a12.1;
        Mon, 05 Aug 2024 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722869413; x=1723474213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4WMWgX9rgsbhmTu7vAUUT2lJjgAav7/XXIZkFnGczE=;
        b=OjZfb6Wcy7+jzdowXqxK3wGLaRLoOHyr/qeZ7jwJMYiFkL8q7U2/Wm6ZmK7ut1r871
         i3/nx3Umghxsv/8WPC+YfZQGlDfatoTr25rubsNGzExXHciPwB/Xon+GogjDlW/Dsrnk
         kPpiNdr82JiCiRWzKID6qbYavwDqvZNozbYwnALtEpiDNu25DMkCPKSklx6GEUmBQRCN
         0f2zvXAUeh2ArEEoME9t0eHoxrBmvTzlyhObypJi5csxi31ZT/LV1Rj5Fe4uvGpJ6rjX
         lqZKTYAkR1vbdwOZOqvJCqzwAIJvskYAu4hdUtvKLRZ0NQup40HXmM78x/cMcFW3nUEb
         ncbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722869413; x=1723474213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4WMWgX9rgsbhmTu7vAUUT2lJjgAav7/XXIZkFnGczE=;
        b=vJ8KbDvJipvRM6ujsL4dXgUfVFBnaDn7brZKlbL+HqhGi7g4+vi3fSMZT1FRNJ1qxD
         FH4QaPPJB9mRT4CvEZargi4TNr4wuEOaxQFW1cCdnchiaVAHwlmLBAll5Rsf1iOrTBlr
         cH0n0gNAHl3OT3m4PTtKO0apJHYI2bdlk5dcvldMBC6pysByGBlHM5z96YlbRv8jPxOr
         x9TWAaD9DU68zW3frEK+J01RnfM0Qa0lJXLeOR1Xg8LIo9yzqkV/oCkCKgtQCTvxgGOD
         FX+QwPNNnKNqfYgXkf7nuvbbiQZRI7WwlEaPrWqs4v3V/kr/tTSoHMEV2mVOKieToJbu
         jarQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtkT3H1VXkzFeLl0ieYWpJFxEBMIJuxoS6ndKcQoMlUrn1yg1xZ2C4Lmu4LPc4ghOreIDhhwks7W4CfsmgmYLmfEsS0dQYR0ZJ464v8PHvhagb1fTiCqHTCYvKrA9AY3TmpVxW7XGsL67L4h4iLlBWVxtXbJPqVUhxGXviIox+SNy2BMm/rQHFDzkws2iSTzeO6H+Xwvqdn4Nw0tF6
X-Gm-Message-State: AOJu0Ywiw9FJc7a/w/utH4rpsRVD/FqSXwGSWPemb/DeTkUT6IQzoiib
	+0vpeaFl591d6HQwpcFjCdZ7nVF5bAvAuzprOIG700FTi55mcpcg9sap29ZM
X-Google-Smtp-Source: AGHT+IGdfYnO2aZpNz0tetKDt/ok3aBPmZNSfSIcOBMQclRRV+msC+93vgDlMfbq4Wu8iCRcKiTLBw==
X-Received: by 2002:a05:6402:3588:b0:5bb:8e11:f688 with SMTP id 4fb4d7f45d1cf-5bb8e11f82emr2427451a12.10.1722869413229;
        Mon, 05 Aug 2024 07:50:13 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b82f308sm5004088a12.63.2024.08.05.07.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:50:12 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 05 Aug 2024 16:49:45 +0200
Subject: [PATCH v3 2/4] leds: pca995x: use device_for_each_child_node() to
 access device child nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-device_for_each_child_node-available-v3-2-48243a4aa5c0@gmail.com>
References: <20240805-device_for_each_child_node-available-v3-0-48243a4aa5c0@gmail.com>
In-Reply-To: <20240805-device_for_each_child_node-available-v3-0-48243a4aa5c0@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722869407; l=2071;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=7kg2DOJCEtgdPsOeKLV9ms+2/ZVz5OINInC7YD7FABM=;
 b=q5g6nykQ9OaDuAHv+zzIBfQXn8CygcT99X05g7rWy9/EpjkKbyLBSp7nJFERHp6rR3EtacTMH
 z8x4MVdmX6ABlGoPSEQDPikyNvrFcUxmYotzJ9Wy3xm20DRxXgIrk0z
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
index 686b77772cce..83bc9669544c 100644
--- a/drivers/leds/leds-pca995x.c
+++ b/drivers/leds/leds-pca995x.c
@@ -120,7 +120,7 @@ static const struct regmap_config pca995x_regmap = {
 static int pca995x_probe(struct i2c_client *client)
 {
 	struct fwnode_handle *led_fwnodes[PCA995X_MAX_OUTPUTS] = { 0 };
-	struct fwnode_handle *np, *child;
+	struct fwnode_handle *child;
 	struct device *dev = &client->dev;
 	const struct pca995x_chipdef *chipdef;
 	struct pca995x_chip *chip;
@@ -129,8 +129,7 @@ static int pca995x_probe(struct i2c_client *client)
 
 	chipdef = device_get_match_data(&client->dev);
 
-	np = dev_fwnode(dev);
-	if (!np)
+	if (!dev_fwnode(dev))
 		return -ENODEV;
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
@@ -144,17 +143,13 @@ static int pca995x_probe(struct i2c_client *client)
 
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


