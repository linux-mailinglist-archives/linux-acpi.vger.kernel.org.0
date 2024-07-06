Return-Path: <linux-acpi+bounces-6790-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE465929472
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 17:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDF51C212D3
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D4613C812;
	Sat,  6 Jul 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZiJI74o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5813B585;
	Sat,  6 Jul 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279439; cv=none; b=OFLLtE6+sb8FWlGQKO3BOGOHNKMwSfRoCPs6/KhKSkXDIXcMyegsp1en5ZaTDfwHhYCdg6HNRazFuzatEwEo+UZN91CHc2mWiKi8tno0OuM7FDhbgv1Ehjs7oFpJigfvWaLQAF01ra1jlIYCKdQbBUTSq0d3OCARTGtrGMuwuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279439; c=relaxed/simple;
	bh=J/DKHnWwklUy1ZaywRXLH+SB/DamAjhdOjVxM8WXYcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PxsXZpiMBwHD07FKZ50yiwq3qB73CNbqJe1f2Gj/1FUz4V52JaB7rYwDEQb66h7OC7QpcQMTXrJAbgxpok9eR7S5UF0/vCqyC7UkPhpdLdOsiPtcHBWGEA/2yrpBPYLul3r3g80/0v3JMD2zZho3JwigNwfYMFy5AdaCC84PDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZiJI74o; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36798e62aeeso1631334f8f.1;
        Sat, 06 Jul 2024 08:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720279436; x=1720884236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WklQuGWTyUZGXjSt3Sj1gy49uGRkFZnR7/Z3/DZXyU=;
        b=RZiJI74o3iY5geJR7evAximq6eFELX+dVBz6/+m7LyeXk+6GpunIHxXaiJ4YqwymeW
         vI/jgJVqsWc/x6sbNAE8yNJ1WCMwS14wY5BXvG+raWivbWRbnelr5DnBPuouilxNwgZu
         ItIh+OiZOWo5uvZjuHD8F4aoaejgdUbXiVK0AULj9G8ff1BgtyYoHrMEWFppcNaoPPLq
         eHi1AxaVVY493z5+24NZr1efPj64Ra4PwaYyTUd5HXWN0fiSY8VhIt0STVg44SYejtwQ
         DuYN6FYOE5Fd6UoiFgIv8Vt+LLXY9G5XsyRsc30xITdYb+KA87bcFuOdiMfvLOYfcvYl
         xnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720279436; x=1720884236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WklQuGWTyUZGXjSt3Sj1gy49uGRkFZnR7/Z3/DZXyU=;
        b=vBdbrAl0buPNgK7VFpNV0jEEOHvQZ2vcUIrX4W5nYk+0gIQZHaj01nkyDdy1KA/bAQ
         Lyu9SHNe6potJ0GD3v8jPlH44zhFhSGUVNbdSxsY0Zv0F4z2dNnR3MJILnRSgPVXIeg1
         y4NIKxMsI9Rl6W1np4se+a50SH+7Ce0naRPYqUBXWeH2CDOSYhkz9k2E0n626DUtqELw
         Hb2l8A8kgxSqPtv9DCFMnTXYMxh7ngsCqallVtjb03lBiRNuM4I5cZcCrGkFnbmwOTHI
         FM2fQMbzDrhUoiFPYcpjUVPG3NImLsGr9i77lduL1PKlDvYEqN3R4vwkg8CQnlqKBnA4
         BcMw==
X-Forwarded-Encrypted: i=1; AJvYcCWwrY0bf77nr0KcScgr0xUZrTcCgWCrQRrZunBw04Im5CdvHxtHHiWEloEVElHrr2hFf9Giv9qbwR6aj+wTglek6S+PEZlnjZqQvLyHdk0BRMZLzw3Y46wUYMbgcwtaettUobb7KLWdeUZb1sAhmFgoupwoBSyaUZay0hc4HnOWYm8xk7tRgyL9r8Fs9Law7NTsR9itiR4AZ3BWhZlp
X-Gm-Message-State: AOJu0Yw6038dz6UN8GS2eG5EfidVYJfzFqCLVVZrQ0PUngwxEmb2mopj
	Aibx95Zze4BJtRX6q3MVg0GA0ormQX6A0li7Dk0KSp/Z2xbBy3SJ
X-Google-Smtp-Source: AGHT+IFmo8jZVBKEzOMMJzT8ULSphrmfgsUFkXzLGQBqQAyu2DhNTZpcNQriljIov4bBp75pXtmMLg==
X-Received: by 2002:a5d:664b:0:b0:364:3ba5:c5af with SMTP id ffacd0b85a97d-3679de96b30mr5176147f8f.61.1720279436002;
        Sat, 06 Jul 2024 08:23:56 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d11b-8ec4-ea76-796c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d11b:8ec4:ea76:796c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679ed376cdsm6421593f8f.114.2024.07.06.08.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:23:55 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 06 Jul 2024 17:23:34 +0200
Subject: [PATCH 2/6] hwmon: (ltc2992) use
 device_for_each_child_node_scoped() to access child nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240706-device_for_each_child_node-available-v1-2-8a3f7615e41c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720279430; l=1901;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=J/DKHnWwklUy1ZaywRXLH+SB/DamAjhdOjVxM8WXYcE=;
 b=fPXEHlwcpK9k22fEHLCAEULQo4I96aPEgd/oDAs8po1HIlTQCq5s1WW+OkVtaPet8BxeiaRod
 dNZUWVjlxsJD1xWgPCr1e59DfdQNJP+pFj8c2YXnAGp6xv/9Rg9H5b7
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
 drivers/hwmon/ltc2992.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
index d4a93223cd3b..541fa09dc6e7 100644
--- a/drivers/hwmon/ltc2992.c
+++ b/drivers/hwmon/ltc2992.c
@@ -854,33 +854,24 @@ static const struct regmap_config ltc2992_regmap_config = {
 
 static int ltc2992_parse_dt(struct ltc2992_state *st)
 {
-	struct fwnode_handle *fwnode;
-	struct fwnode_handle *child;
 	u32 addr;
 	u32 val;
 	int ret;
 
-	fwnode = dev_fwnode(&st->client->dev);
-
-	fwnode_for_each_available_child_node(fwnode, child) {
+	device_for_each_child_node_scoped(&st->client->dev, child) {
 		ret = fwnode_property_read_u32(child, "reg", &addr);
-		if (ret < 0) {
-			fwnode_handle_put(child);
+		if (ret < 0)
 			return ret;
-		}
 
-		if (addr > 1) {
-			fwnode_handle_put(child);
+		if (addr > 1)
 			return -EINVAL;
-		}
 
 		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms", &val);
 		if (!ret) {
-			if (!val) {
-				fwnode_handle_put(child);
+			if (!val)
 				return dev_err_probe(&st->client->dev, -EINVAL,
 						     "shunt resistor value cannot be zero\n");
-			}
+
 			st->r_sense_uohm[addr] = val;
 		}
 	}

-- 
2.40.1


