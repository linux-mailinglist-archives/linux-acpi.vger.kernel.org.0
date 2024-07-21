Return-Path: <linux-acpi+bounces-6996-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1EA93852F
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 17:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0171C20B5F
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12B616A934;
	Sun, 21 Jul 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC2YCcRz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F09168C26;
	Sun, 21 Jul 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721575169; cv=none; b=q+/X1fftAQK+xOSpjE0PZBUDtIQAK7Sy7olHAflEcj4Ff09d2OyCYDPPjUXw581qgaw9lmtlKaezHbqIOuSQueP7SpFu7mttvhO0ik6NDujI7sVXJlftztEEHVod1L+YeWYtO87+GKEYvQVJXIfC9SPMrRX830ARlKYF9lU8hv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721575169; c=relaxed/simple;
	bh=zfKvVl56Ee/YHYsPw//vbpTx3vfqLNtRUd8E8z686Yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=blKuWa73li85jvUp7Phezp2tXQaNG88TPoUtQhiew+AtfANDN5OOcw8+e9sF22hQcWjow458cenglU7S3hRqjhV1W7nqmE9tU25AT68bvBeAxBwUfIYN1LEosZ+ACQzQyuGktfFVURY4THOxIVgTVq5yZWCkQow4uTQUnOFxTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC2YCcRz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a79a7d1a0dbso338526366b.2;
        Sun, 21 Jul 2024 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721575166; x=1722179966; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34LO3D9/a+9GkhCYyyEdto/l7dIIOtnNwsjkTzmylGo=;
        b=PC2YCcRz8BR6GekTVCiCPZyuy0qMoZ77SWhm3BYT0dgidVUJJUybDGNarn6nnaxHSl
         W3lupiiISme53mf21YW8XVet7qES/NeKTqciCVReCTaGkoTdN1Dn/oLUb+Yl2AD0eUlU
         XEQwlErvM+OIZI48bCTP6pYqF+zB4lUKoafvsmTPLaTmpoVbCFzdcXFvHDAG2jduMxS7
         ZRKxGbh6A2QPFf3/AeLfLp4V41EnlSQgDaRxxdOdFjcpz2wtJL9645ulJL3lV8F24FK6
         El6A6ZdOHWo+yYDLPfBAK+ka/kXE6b9Qx3q7oCWDTJn0TN6EuMZVAw7UJ59GOryycWp8
         D2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721575166; x=1722179966;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34LO3D9/a+9GkhCYyyEdto/l7dIIOtnNwsjkTzmylGo=;
        b=dP0piCfqa3+YMasKKygBY4gCwgxvv/+KPJJS4zjIIPvP8cXVdKMFuhVmiKJefanssC
         PBU63NWfjYMxUMBJhbadwISybQEptgw4ZnpbvB20F9Y//8PRS3jfq9OPF6hR3AzUWWMS
         DJyw80Iozz/o9b5u+2tPnhGtnsUKa7qJHWPy/cq28cIFViybSKxG8pJW6MW/rMHOrCag
         bX1bkBcIUadxpR+AWJbu0HP/U4eJxQ2ia9wgDAPpZGyG7SuKC6FWZ9QXmIBiO9JquzCi
         iBOkOgwUjs0QOq1sEjpoqFDUj57ayFe1evkNYVBBi5oTLSU8I5Y1Mn/+jZzjYlOzfwyt
         FlFA==
X-Forwarded-Encrypted: i=1; AJvYcCWzNELsSN70qRHniTcjNdLMO+ByE3wuTySMYyn6BBMdZUdizM1aRK9oj2G6orOOjn8qr1NGEjkumhFuc05qlhuxn0dgz3xgChuQwD0C3u6V7Ug2oi5CVRdYJ2r7Psg4NTiKjoapWiiP7gbiIxJBFZj4tkm8ITFAWU441z1lRTOHAeRQDFNnn6nS/j0HOfL1GAX5vthbnnvxuLhnaKCF
X-Gm-Message-State: AOJu0Yw1ykOhfSR7oCCZMOQ39jhGkOJUCjcARqH4pU8qF+eBYu37+SIX
	y7/1Z6TtB7gbCmg6cta1ap8imG9ZLdzj8+Z5ZLyd/g/kfTZqR+l3
X-Google-Smtp-Source: AGHT+IE2m8FTqLcaB0ayAtsAcxDklDrh0Jeo9GelAe8928pHZaIlEmSx4Gb+ZFErkTLXrmOEbver9Q==
X-Received: by 2002:a17:907:7d86:b0:a77:bfca:da54 with SMTP id a640c23a62f3a-a7a4bfa7767mr288110166b.29.1721575166197;
        Sun, 21 Jul 2024 08:19:26 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-859e-243c-21d1-9ff6.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:859e:243c:21d1:9ff6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c78603dsm302270366b.8.2024.07.21.08.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 08:19:25 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 21 Jul 2024 17:19:03 +0200
Subject: [PATCH v2 3/6] leds: bd2606mvv: fix device child node usage in
 bd2606mvv_probe()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240721-device_for_each_child_node-available-v2-3-f33748fd8b2d@gmail.com>
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
 netdev@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721575158; l=3278;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=zfKvVl56Ee/YHYsPw//vbpTx3vfqLNtRUd8E8z686Yk=;
 b=ZOs+XB1NOY29jgnwIKho0VKLh2Hw7hfs9FxrizpKpodfRzt1jD2qEBOPUZ/OgG6WdVgMs7pyg
 0s3G95aCiF8A1ViieFgNQ20Rsb1P2WxwE8ftDUkaao75AfAxCNb2kSV
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The current implementation accesses the `child` fwnode handle outside of
fwnode_for_each_available_child_node() without incrementing its
refcount. Add the missing call to `fwnode_handle_get(child)`.

The cleanup process where `child` is accessed is not right either
because a single call to `fwnode_handle_put()` is carried out in case of
an error, ignoring unasigned nodes at the point when the error happens.
Keep `child` inside of the first loop, and use the helper pointer that
receives references via `fwnode_handle_get()` to handle the child nodes
within the second loop.

Moreover, the iterated nodes are direct children of the device node,
and the `device_for_each_child_node()` macro accounts for child node
availability. By restricting `child` to live within that loop, the
scoped version of it can be used to simplify the error handling.

`fwnode_for_each_available_child_node()` is meant to access the child
nodes of an fwnode, and therefore not direct child nodes of the device
node.

Use `device_for_each_child_node_scoped()` to indicate device's direct
child nodes.

Fixes: 8325642d2757 ("leds: bd2606mvv: Driver for the Rohm 6 Channel i2c LED driver")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/leds/leds-bd2606mvv.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/leds/leds-bd2606mvv.c b/drivers/leds/leds-bd2606mvv.c
index 3fda712d2f80..c1181a35d0f7 100644
--- a/drivers/leds/leds-bd2606mvv.c
+++ b/drivers/leds/leds-bd2606mvv.c
@@ -69,16 +69,14 @@ static const struct regmap_config bd2606mvv_regmap = {
 
 static int bd2606mvv_probe(struct i2c_client *client)
 {
-	struct fwnode_handle *np, *child;
 	struct device *dev = &client->dev;
 	struct bd2606mvv_priv *priv;
 	struct fwnode_handle *led_fwnodes[BD2606_MAX_LEDS] = { 0 };
 	int active_pairs[BD2606_MAX_LEDS / 2] = { 0 };
 	int err, reg;
-	int i;
+	int i, j;
 
-	np = dev_fwnode(dev);
-	if (!np)
+	if (!dev_fwnode(dev))
 		return -ENODEV;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -94,20 +92,18 @@ static int bd2606mvv_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, priv);
 
-	fwnode_for_each_available_child_node(np, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		struct bd2606mvv_led *led;
 
 		err = fwnode_property_read_u32(child, "reg", &reg);
-		if (err) {
-			fwnode_handle_put(child);
+		if (err)
 			return err;
-		}
-		if (reg < 0 || reg >= BD2606_MAX_LEDS || led_fwnodes[reg]) {
-			fwnode_handle_put(child);
+
+		if (reg < 0 || reg >= BD2606_MAX_LEDS || led_fwnodes[reg])
 			return -EINVAL;
-		}
+
 		led = &priv->leds[reg];
-		led_fwnodes[reg] = child;
+		led_fwnodes[reg] = fwnode_handle_get(child);
 		active_pairs[reg / 2]++;
 		led->priv = priv;
 		led->led_no = reg;
@@ -130,7 +126,8 @@ static int bd2606mvv_probe(struct i2c_client *client)
 						     &priv->leds[i].ldev,
 						     &init_data);
 		if (err < 0) {
-			fwnode_handle_put(child);
+			for (j = i; j < BD2606_MAX_LEDS; j++)
+				fwnode_handle_put(led_fwnodes[j]);
 			return dev_err_probe(dev, err,
 					     "couldn't register LED %s\n",
 					     priv->leds[i].ldev.name);

-- 
2.43.0


