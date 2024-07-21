Return-Path: <linux-acpi+bounces-6997-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1FF938535
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7421C20B88
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0F416B3AC;
	Sun, 21 Jul 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ev+EFb8w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D518816A954;
	Sun, 21 Jul 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721575171; cv=none; b=eorkg4oGjUNGHjgtDBlv4zryMz2IbG4pzsGgcU0A7IRmWqoIyQlFNmjl8S9oHx5Jf55ZEr2KleMtL7SfMZLFT3ddS/ZIO0jAYR8n8PiAfCAxdo2x9muOZeSRLXfzF9hh8hFn1aSyleLFPhfJGGHgjS5HlzvqacG+PkKoKUKG5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721575171; c=relaxed/simple;
	bh=j/RHG5S2KBp37HXXynDqIlrHp6BrAXodPNBCnQweexc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qEe349N9iNwnK+pXDrIT1Ve6R5oIICDl1G4GtHFUqQZjH+sZt9SAgDSw3jpNGOvlvRVHYghxUcnJxvshz0SVqizi+/8CnddpGiGqBUDZZ/CdR+XmIyT3wwTjT/GKDdcBdeu9/XlZJg4wRuPrTMvOmzDdvn+E9Y9i6F3/hKcO9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ev+EFb8w; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77e392f59fso358171966b.1;
        Sun, 21 Jul 2024 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721575168; x=1722179968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8k5b/mbk8JidSQkDkpUc1By8/0Pl5zLywNFvxqirlc=;
        b=Ev+EFb8w85qD39zxBUprT/j3fK7IY5B/NoKw3RxBoE+b0xPRWW4ndAmTx1EhZpC3nW
         V6OhoN1gYdf1yYpv2y4k9lPJz3yF1bClq7WJdMV3wyzaRxRf1E8CWg0a8TusGtlk4VBA
         pMAWOrZ/58iDCKXcKygawnvNSdKGSQzgNl6ooS3G6X28Ubfd1vemN1rXIuMorfpzheNF
         kheiNb3xTLCCQRONBbDsvE3jZ7fSM0Eb6iFB7oGDzn8U8QNf2Brc65NVQslHgveMyRY8
         Al/aCcoKVx7JN2syxmrF5+cMFdOKKvgzEgN6FCEcioZUP8CrXPt6tSQEtcCekbZeoHqb
         plGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721575168; x=1722179968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8k5b/mbk8JidSQkDkpUc1By8/0Pl5zLywNFvxqirlc=;
        b=TtA0GXPhmYMXKgPL+PSdEcu4+gsIPSuzjTkahCe6k8WawKuoWQHQ0UlnOmiZYmqgyM
         roHYOueQLQiUMU2bjtSCqNeia9rEoe7E29IptGquW1RwR2sjp1ftLcAlO8fVckZI4w6E
         pewzGszUkn6lymsZnCVLIA4WUFqBE92qOsKuya/VfWpiOYg5AbZb1PZ3LCao6zsc65FB
         UA6mlf0iaH9aQVnoeFrTREl21g4+GH78BsE+qMKhI6FrGuweCNZIBDRzNf+yQya6e/jr
         1X8FvRGSERSl1TW8E6RAvVXK3QeVcBvWEf9zidNKYcf32z6L/fdoB6UQkqLVD2K1ywF2
         NjHw==
X-Forwarded-Encrypted: i=1; AJvYcCVb0JEpyOAYw4GkLvovrXYPzu/JSSw5AOFxskitxqauZRp86etXBcsoixvxqvT9D4YDcDqcDjMteM1rBUPCF+u5A3B+uOIluxI/yj3Gn4BNN6DRmkuhO9XwnU5JqUhk6tXWqlWfpnRYtIXxlydGZ4wsUKAh9Wun89FpgpN7FtYGeJrGiqyUg/z6CQZCZR3c9qj2lN7GKb0dcjtBZUld
X-Gm-Message-State: AOJu0YzyqFims69oj0raCHm6eCSNKzA8lBm0fjtAtWX1BlPEg4wiXoeT
	e/D3GWwgoQ2imlb10TS29Q8aQoJ8+jYmJxAsgI1Oak/kVDdXJOPH
X-Google-Smtp-Source: AGHT+IGp55aRgT5ci8RjSPk4Z8pjU7fk+RHTFyEes+YN7ooGbgnG832FPrZ8ml4i+8/DWxjznFAfyQ==
X-Received: by 2002:a17:907:7d88:b0:a77:c080:11fc with SMTP id a640c23a62f3a-a7a4c0cfd91mr268413266b.36.1721575168037;
        Sun, 21 Jul 2024 08:19:28 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-859e-243c-21d1-9ff6.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:859e:243c:21d1:9ff6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c78603dsm302270366b.8.2024.07.21.08.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 08:19:27 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 21 Jul 2024 17:19:04 +0200
Subject: [PATCH v2 4/6] leds: is31fl319x: use
 device_for_each_child_node_scoped() to access child nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240721-device_for_each_child_node-available-v2-4-f33748fd8b2d@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721575158; l=3441;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=j/RHG5S2KBp37HXXynDqIlrHp6BrAXodPNBCnQweexc=;
 b=GnDe4jzcJoRelbHvrSCqaVtirX0l96JIpTFerOd5HX5Z5a4TOcwdirZvJSxljFBhbZpWn21hp
 wrMec4QL9fYA5kMGSUry7pLPrIQ9WFJnGkUznPUmuFEvd1LOCW1MQVD
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The iterated nodes are direct children of the device node, and the
`device_for_each_child_node()` macro accounts for child node
availability.

`fwnode_for_each_available_child_node()` is meant to access the child
nodes of an fwnode, and therefore not direct child nodes of the device
node.

In this case, the child nodes are not required outside the loop, and
the scoped version of the macro can be used to remove the repetitive
`goto put` pattern.

Use `device_for_each_child_node_scoped_scoped()` to indicate device's
direct child nodes.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/leds/leds-is31fl319x.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index 5e1a4d39a107..27bfab3da479 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -392,7 +392,7 @@ static int is31fl319x_parse_child_fw(const struct device *dev,
 
 static int is31fl319x_parse_fw(struct device *dev, struct is31fl319x_chip *is31)
 {
-	struct fwnode_handle *fwnode = dev_fwnode(dev), *child;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	int count;
 	int ret;
 
@@ -404,7 +404,7 @@ static int is31fl319x_parse_fw(struct device *dev, struct is31fl319x_chip *is31)
 	is31->cdef = device_get_match_data(dev);
 
 	count = 0;
-	fwnode_for_each_available_child_node(fwnode, child)
+	device_for_each_child_node_scoped(dev, child)
 		count++;
 
 	dev_dbg(dev, "probing with %d leds defined in DT\n", count);
@@ -414,33 +414,25 @@ static int is31fl319x_parse_fw(struct device *dev, struct is31fl319x_chip *is31)
 				     "Number of leds defined must be between 1 and %u\n",
 				     is31->cdef->num_leds);
 
-	fwnode_for_each_available_child_node(fwnode, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		struct is31fl319x_led *led;
 		u32 reg;
 
 		ret = fwnode_property_read_u32(child, "reg", &reg);
-		if (ret) {
-			ret = dev_err_probe(dev, ret, "Failed to read led 'reg' property\n");
-			goto put_child_node;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to read led 'reg' property\n");
 
-		if (reg < 1 || reg > is31->cdef->num_leds) {
-			ret = dev_err_probe(dev, -EINVAL, "invalid led reg %u\n", reg);
-			goto put_child_node;
-		}
+		if (reg < 1 || reg > is31->cdef->num_leds)
+			return dev_err_probe(dev, -EINVAL, "invalid led reg %u\n", reg);
 
 		led = &is31->leds[reg - 1];
 
-		if (led->configured) {
-			ret = dev_err_probe(dev, -EINVAL, "led %u is already configured\n", reg);
-			goto put_child_node;
-		}
+		if (led->configured)
+			return dev_err_probe(dev, -EINVAL, "led %u is already configured\n", reg);
 
 		ret = is31fl319x_parse_child_fw(dev, child, led, is31);
-		if (ret) {
-			ret = dev_err_probe(dev, ret, "led %u DT parsing failed\n", reg);
-			goto put_child_node;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "led %u DT parsing failed\n", reg);
 
 		led->configured = true;
 	}
@@ -454,10 +446,6 @@ static int is31fl319x_parse_fw(struct device *dev, struct is31fl319x_chip *is31)
 	}
 
 	return 0;
-
-put_child_node:
-	fwnode_handle_put(child);
-	return ret;
 }
 
 static inline int is31fl3190_microamp_to_cs(struct device *dev, u32 microamp)

-- 
2.43.0


