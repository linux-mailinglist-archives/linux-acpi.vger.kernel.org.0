Return-Path: <linux-acpi+bounces-17150-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB945B8D079
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Sep 2025 22:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C517C7642
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Sep 2025 20:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC2D273D92;
	Sat, 20 Sep 2025 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzlsEfcc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CCC273803;
	Sat, 20 Sep 2025 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758399000; cv=none; b=mFH91syG8srQSjt4x8RZB+L46+AGs6fbHGFij3T+3sSuSF6WEu7JgqNpvuA3dhffP3/krlNzrQoc+zPBnH+8BQTBP4nPLma9iXMogXja5z7knJK386ekSdWfMs90h50vduF0xZIQuDDh+oBN1Dztxt1i2P3yB/1t7mWyJzPgSdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758399000; c=relaxed/simple;
	bh=qUxZfacXHGMxn2bdLfok8t/9VFvH3pGux5faHIK2zbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBmUEdYqWOgB/k6+XhB6isGJTkM833V4198wAfCktRU19460nwj/r+qmFzhoOBVAc46ea/ahMco0Hf9JnwC65IV03SR05D6fbUWdOv40npGzqL9IUUS6v7wQMCSVi1KC2UcSL4AHUbwwX0/zMxapnl/1jR2ZeREaXuTBwJJrb1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzlsEfcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B625C4CEEB;
	Sat, 20 Sep 2025 20:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758398999;
	bh=qUxZfacXHGMxn2bdLfok8t/9VFvH3pGux5faHIK2zbY=;
	h=From:To:Cc:Subject:Date:From;
	b=CzlsEfccXgZ9RkFJBhvhbjU6yNlfWA1pHpX1wlWnMDn6QetaagziT5e3ooIAaYSWM
	 dl30wDE9yjHXf3yDWwBiIAwQsf1iGdkkYye85Of+gSuv7I+F8tJ5cg3mxTBnG8WEad
	 AjIwyNTaVSA9qFrYFknfCZeVmU9ndm1ZwSR7DqLVrfPft3Ai5IQ6fiGAYLGlzr/sty
	 h39DZpegIAMI5CQaVuD3AWneaNP6AdI9OS9o1a4iAvMFSD3iGKEifyfAgi74xNqfpN
	 JEuEJ4YiuJns64tuSOOPM5pe2NbWMp3M4lfOlellNQ8ltv4uwV5eD/C/MLlV7fowQ1
	 ZvEYMLLM0fOPg==
From: Hans de Goede <hansg@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] gpiolib: Extend software-node support to support secondary software-nodes
Date: Sat, 20 Sep 2025 22:09:55 +0200
Message-ID: <20250920200955.20403-1-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a software-node gets added to a device which already has another
fwnode as primary node it will become the secondary fwnode for that
device.

Currently if a software-node with GPIO properties ends up as the secondary
fwnode then gpiod_find_by_fwnode() will fail to find the GPIOs.

Add a new gpiod_fwnode_lookup() helper which falls back to calling
gpiod_find_by_fwnode() with the secondary fwnode if the GPIO was not
found in the primary fwnode.

Fixes: e7f9ff5dc90c ("gpiolib: add support for software nodes")
Cc: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
Changes in v2:
- Add a new gpiod_fwnode_lookup() helper instead of putting the secondary
  fwnode check inside gpiod_find_by_fwnode()
---
 drivers/gpio/gpiolib.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0d2b470a252e..74d54513730a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4604,6 +4604,23 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
 	return desc;
 }
 
+static struct gpio_desc *gpiod_fwnode_lookup(struct fwnode_handle *fwnode,
+					     struct device *consumer,
+					     const char *con_id,
+					     unsigned int idx,
+					     enum gpiod_flags *flags,
+					     unsigned long *lookupflags)
+{
+	struct gpio_desc *desc;
+
+	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, flags, lookupflags);
+	if (gpiod_not_found(desc) && !IS_ERR_OR_NULL(fwnode))
+		desc = gpiod_find_by_fwnode(fwnode->secondary, consumer, con_id,
+					    idx, flags, lookupflags);
+
+	return desc;
+}
+
 struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 					 struct fwnode_handle *fwnode,
 					 const char *con_id,
@@ -4622,8 +4639,8 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 	int ret = 0;
 
 	scoped_guard(srcu, &gpio_devices_srcu) {
-		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
-					    &flags, &lookupflags);
+		desc = gpiod_fwnode_lookup(fwnode, consumer, con_id, idx,
+					   &flags, &lookupflags);
 		if (gpiod_not_found(desc) && platform_lookup_allowed) {
 			/*
 			 * Either we are not using DT or ACPI, or their lookup
-- 
2.51.0


