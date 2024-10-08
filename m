Return-Path: <linux-acpi+bounces-8620-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D8B99541E
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 18:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C8D8B288C2
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE53E1E131E;
	Tue,  8 Oct 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pstc5aoK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41131E0E1B;
	Tue,  8 Oct 2024 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403842; cv=none; b=fVL2+XWmd3mOtUPe2mRCpYO8qB64LjVk8xzX5tQVDGpwHWJCxGzzSjyiMBbeUj/zT1g/RGdc3bpuUL29HDYgJv0RrK7aVbE2gqa2UZcYAWFrbLgOerG1w74E2jahb2tebItMGlrZdA1ql0sS+ceadCDeLGU/CzWFqYmjm+MM/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403842; c=relaxed/simple;
	bh=cWyudSNwMdAoPLDHpxMU3t/7IYAcpd1uRUv+IKIqdyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AShsH8pzkf7V9QbEVsTJwD/OX3PItNfY3welWbu19ogPuwxZQ8DC1j7JfOInKGJQl6Z3lMPhKpIm2ad6kiDAAlHAowlvWjbc414Ia5lkca31L82/C2SfRFPYGC8OYFi8rd1M9X8VyQhPQZqYyddst913M2I+KePIu2KpO2P9uck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pstc5aoK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43056d99a5aso3826295e9.0;
        Tue, 08 Oct 2024 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728403839; x=1729008639; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKEcyPzV2K4r+AP5/PHCK58XwhBSe6yI2S077zk0qgU=;
        b=Pstc5aoKtRGP5YQVeCVZXRokGeOGMS/l3LyMRI/eO4bsf0bY9gCAaQ3EoHi++xiSxK
         CBNxO6DNFxfymE9bSZiSpD441+QkImA9WMSf4OJMdTgwTZi2xJzNI5k/WpK50to3+WcC
         OeBZyJOEYhW/ubqOoIt/xJ8nAteNyz/vpNTgSDTHazS0+JOU9ReiPNCdDcn9gC1Lzf9o
         DaBpI4/lBMTSap6axxBUAQCZVD8aIF/TZYMGmy6kIS1j/znCOa3AAvF+IuAQWMBnBieS
         2QWIRpHlo8jYmsMPk50o7uFjz6DB7AUMOMP2uuA3lKuUUISV1N+HgVYbwwP/Oi7qmhvn
         V74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403839; x=1729008639;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKEcyPzV2K4r+AP5/PHCK58XwhBSe6yI2S077zk0qgU=;
        b=SwnzQgNQG3DFTKkDc2SRbNel+A26N2TikqCHJP8wvLEPe/eiWqb4WFBuvQaO81Av3R
         0SxkOPFoSx7pZoUmFkcJWYLyhHxpObIeJb55+YtUpp0ex7yi31YzmABbipqsTX5AsuFL
         mEbAx9VuCfOtJbXzqcURTVZXQouPm4ntJD9YVw0OJi5cGYsdSOxuZ7mKDTXypQ1URTdE
         0RwUiNsL1yZx9VzukBJ4UEJahGMuL17aPU5JKQZQyK4EDTVl56a+/hC3jNBrHj4VXYYq
         RJnZesnp0VlL5gpJ8ADYCu9hFto+t/hgQbsOWiep/L5AKJ5Z4T1q/75nWdWUhJDw5kYG
         Ws7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUeK7aqdjeRba8brnv/UoX1mvY8gFvIT5FMsG2/CzId61c/jVUq5BDT8ERN3ZVRjbwceeDxJeE@vger.kernel.org, AJvYcCWATiFvDrMh70BkSAUZ6WzBd5kpS7CMFM+IQhtsssAx78PDvfN/Pi75EjDmAZb0Zso3yNs5JnRCE0NzBbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx13XYKkbm7pN1v16MqJpVxqVvIn2I4L2aMsCW1LqUVmKnpzfAA
	2nvIDxkUH+sdauMgM+Qg0E66nEu6r/16PZg6J+dnrONuaLhn04BtZPS+Uoyy
X-Google-Smtp-Source: AGHT+IGNjyCJTmyTOfXgVwWxpuw+hFn0QXE40kSv7Ekdba6rn3qd+huk2emCJAp/YE7300IIDQiy5w==
X-Received: by 2002:a05:600c:4748:b0:426:64c1:8388 with SMTP id 5b1f17b1804b1-43057b96e01mr4863305e9.17.1728403838405;
        Tue, 08 Oct 2024 09:10:38 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-f2f2-fc2e-cc91-5c72.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f2f2:fc2e:cc91:5c72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec71aesm113505385e9.33.2024.10.08.09.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:10:37 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 08 Oct 2024 18:10:29 +0200
Subject: [PATCH net-next 3/3] net: dsa: mv88e6xxx: leds: fix leds refcount
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-mv88e6xxx_leds_fwnode_put-v1-3-cfd7758cd176@gmail.com>
References: <20241008-mv88e6xxx_leds_fwnode_put-v1-0-cfd7758cd176@gmail.com>
In-Reply-To: <20241008-mv88e6xxx_leds_fwnode_put-v1-0-cfd7758cd176@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728403830; l=1498;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=cWyudSNwMdAoPLDHpxMU3t/7IYAcpd1uRUv+IKIqdyE=;
 b=R+xeU5F94QPGHpYg+aR9IRcr5vI7nx8crw+ihr1x9cAGGvKTllbNcIVDyIuV/1uGByQv5Zu1N
 KB5AHretsNrCiMl+l8E2WSCN30YHNBCwKUZd/kJg+/TMoKi5/vrZTbP
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'leds' fwnode_handle is initialized by calling
fwnode_get_named_child_node(), which requires an explicit call to
fwnode_handle_put() when the node is not required anymore.

Instead of adding the missing call, and considering that this driver was
recently introduced, use the automatic clenaup mechanism to release the
node when it goes out of scope.

Fixes: 94a2a84f5e9e ("net: dsa: mv88e6xxx: Support LED control")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/leds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/leds.c b/drivers/net/dsa/mv88e6xxx/leds.c
index 92a57552beda..b9959e1f3c9e 100644
--- a/drivers/net/dsa/mv88e6xxx/leds.c
+++ b/drivers/net/dsa/mv88e6xxx/leds.c
@@ -744,7 +744,6 @@ mv88e6xxx_led1_hw_control_get_device(struct led_classdev *ldev)
 
 int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port)
 {
-	struct fwnode_handle *leds = NULL;
 	struct led_init_data init_data = { };
 	enum led_default_state state;
 	struct mv88e6xxx_port *p;
@@ -763,7 +762,8 @@ int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port)
 
 	dev = chip->dev;
 
-	leds = fwnode_get_named_child_node(p->fwnode, "leds");
+	struct fwnode_handle *leds __free(fwnode_handle) =
+		fwnode_get_named_child_node(p->fwnode, "leds");
 	if (!leds) {
 		dev_dbg(dev, "No Leds node specified in device tree for port %d!\n",
 			port);

-- 
2.43.0


