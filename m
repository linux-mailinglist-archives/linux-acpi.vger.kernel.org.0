Return-Path: <linux-acpi+bounces-6792-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 007DB92947F
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 17:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51830B21D39
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 15:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EBA13E3F6;
	Sat,  6 Jul 2024 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftLWwh4w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA9613D8B6;
	Sat,  6 Jul 2024 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279443; cv=none; b=aK+JKqM8x04zw2/D2La6zYo/BL1+fgKyw3++YHGwV+j+qA+8W54OUTku4DRHQs7/8gEXSzJVyvpt95dh9lXMy9VQPlnRG5BupqMs1LM26HGwHSTIiO/BWIMe+WXgg9RjuOkeb+sNIGGl1ed4uYp3xIcdXnqNFMrujOWE95xw3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279443; c=relaxed/simple;
	bh=A8DEj2ZkqU7SP3vJMUJGnKFPlor+UycUMys9QrcisPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MNS0mjB5AkPUwkixIfA5IaI+sJ9QZgkkpda4vUyq+uMVmfLR3vVfs2C21P6DCia1rUzbXQMd8xQlu+6fxSKOZ7GTeKQzQ9DkVLXScr6sw6wG3nCJ7jSNPXeMi35jZHoOocYws7/0131+Y7HuFKGEA14p5FxLM/zBGamB8gAXXDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftLWwh4w; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367b6e5ffbfso284653f8f.0;
        Sat, 06 Jul 2024 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720279440; x=1720884240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yn6WsK79DmUmiECl4Pth1iGaHBlA8QEqkWn9Q8DE2Gw=;
        b=ftLWwh4w8cQgNkzCQ7hwlQZwgdFiNLECLzmnnWEa+N+w6wAwsFJ5x/6q8awccRAy3b
         VkCou93vFY4tqm+EJTS5kn/cHRPAkdSZJqPqZqaDnWPt2LidQR/W8tQrTfR0EJRMzgpx
         MF4tJpe91PL5o57N6FBfwDS05NC87GF0+DEj/ksbRqaJsH2C3ZUi8c9REP0jHlTwMv1e
         AUtqyFyClpeGHEY0DAl269SrRkVT5mYXS7xbgYJzPXvRs7txBe8yshqWWXtnf/kQftHG
         So8GbrAczLv+hNu67kLIbFYiSewC0E18XwBYr/RmlRul26hNRTxv3OVLyi2+FkH8Qnau
         JpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720279440; x=1720884240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yn6WsK79DmUmiECl4Pth1iGaHBlA8QEqkWn9Q8DE2Gw=;
        b=rZmgMNJ60UcgtK429W9ZDyHLOfDvutxZActQw6siOI6hobPUBMd01JEsSW8cTbwWwT
         sOAsjMhMRxJj++XtNU9OQtHu0htL5UYloHRcP3eiNaxQcbw4PqgWri2AeXgcjtLzzjBb
         jxonwn3562gltnwGTfbomPVRi8R7VN08Wgjk9yLizgmAoUMG+Fp48AMlvcAv7igF54yW
         Mqbr6JvG3h4ABsaAWcfa4t4pZ9d8D8oD2klnP3XBrAfjFdYFlUf24eLrOdFNZcGrgLlj
         bGnzGuAshfmKGZhKL1+/IUiuuxv36ZA2syMiOxO5LaqJbkwSMIW/AOTK3jvbqtfIsjUS
         jUuA==
X-Forwarded-Encrypted: i=1; AJvYcCWL+gK+LralryUlBdljRpAxRs+5BU2NrQfNI0NtO64eBTjSAM/6IgpzSiCkqELZdXHHRfvo+lZHG6iijfE7WmX+Dl2vNAQJeAg03KQ18L7M0xdLysPmXSqNYOJtOHlGfizAVfqBUtLAwDG+QHMgLdJyAJ9DXNbImm6OeB9snzmV2gAUwiwqCrgVGvVNPT3ACgKKU4SBW/8cISedqckp
X-Gm-Message-State: AOJu0Yy/lP3DVLYsDuvfgh0FpLovvaNMNvQSbH2exiDFbpU9oP7zZpE2
	rakd53wcj5BEV+wo8KfOw1PSc3qBRtOLQJ1WBE6P7hfHkLKVWecr
X-Google-Smtp-Source: AGHT+IEL9TbwlSVtRbY0REhBEkD1pyO6EslQex2SbVP2og0jgwsCSsS4OdNwEJDFMuIpXTxFGIS8JA==
X-Received: by 2002:adf:ab13:0:b0:367:9ce9:f05a with SMTP id ffacd0b85a97d-3679dd29521mr4939810f8f.21.1720279439812;
        Sat, 06 Jul 2024 08:23:59 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d11b-8ec4-ea76-796c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d11b:8ec4:ea76:796c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679ed376cdsm6421593f8f.114.2024.07.06.08.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:23:59 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 06 Jul 2024 17:23:36 +0200
Subject: [PATCH 4/6] leds: is31fl319x: use
 device_for_each_child_node_scoped() to access child nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240706-device_for_each_child_node-available-v1-4-8a3f7615e41c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720279430; l=3380;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=A8DEj2ZkqU7SP3vJMUJGnKFPlor+UycUMys9QrcisPE=;
 b=Fv97yiGs2DQNJVxEW7bimU1F9DZUlPxDGD3VwcD+c9cOUNyxUbaKKLba2vQflBEHAr2/1Kj/D
 ssB/DIeFTzxC0DuZHk7n39/y72jttF+S0CH/BDWknCECHdtw318LLxM
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
2.40.1


