Return-Path: <linux-acpi+bounces-17039-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DDEB59CD3
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8011C0494C
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A9B2C11CE;
	Tue, 16 Sep 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nueq3z7x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB346374297
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038507; cv=none; b=Jc0sMcP9gzakWQzDnj7N02vNG7FYMg1iY4k9pcSZh1RCJjzg14dr2b0ZGZY6bz8mQBDNA1lxsAvGXeY9447FjgF0MdM6auaY7FFsdL8AqeHpg7nV8rlNE5SX15oaUxW7iwmyOEKFdkoh9S6xO4ajZUDx8mQ4yVB2ee/shilvp04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038507; c=relaxed/simple;
	bh=m3EgVXjs4Dtr5qYQxifEIBFpl8KtZPRL3QVvAO6C2R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBoBgBcHHlcd7N/AnZFq4rhAeY8S5tKEREhxqebTI5QpM0p4SDGOwV5YHab3scPvsNjhVKg5Fn864DKzscuYcNo+rBvHbZqU4uXDXx6Vbvfq0dJNcJk5+l78qXGsyd3mxSicN2cXEhYkMewd4wKwTNl4nhCH+JZIRclmyr9w4o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nueq3z7x; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038506; x=1789574506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m3EgVXjs4Dtr5qYQxifEIBFpl8KtZPRL3QVvAO6C2R8=;
  b=nueq3z7xH0KYPjAYgeHr2lOPJPMlfxxDEvRniAW8NN84Qx+gL30Ajucx
   vnsv741wU8nnWBw/FGfts4ta71peFLcn4BOTYzuvGSRIJLhHGr1Nt7l5b
   lK8Gno164uIPYEnJutvzUmK94fk5wLktbmyUd04tDf0H55h3JGycgUMtx
   rYYcAc6ngH0JxZrtuT4RJ0nZtpmOu02q9EapwxpLYZ4m3s9wVAH4FXs9S
   IuHRfkbAylVrd/RQMYhLq8OdUtA4Yk7uQf7NbMfnLx69h1QvYG/DPYMFi
   J8UT8PaLr6agY4MsilqMw3bIiJfTjhbGjQUvTjuQkVFuwG9SmcSocjXFq
   A==;
X-CSE-ConnectionGUID: qD2RQHzFQES+JtJ6m6776g==
X-CSE-MsgGUID: J1XDO3v0Tp2ljLjBHA9N/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71422987"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71422987"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:41 -0700
X-CSE-ConnectionGUID: 83HAltXMQsKR8uRbnIv6jA==
X-CSE-MsgGUID: IQtnQV6qR8+EcYCyUGuRyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174091547"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:38 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 835E3121F0B;
	Tue, 16 Sep 2025 19:01:30 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uyY7W-0000000Gb0Q-24Jx;
	Tue, 16 Sep 2025 19:01:30 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 11/14] leds: Use fwnode_for_each_child_node() instead
Date: Tue, 16 Sep 2025 19:01:26 +0300
Message-ID: <20250916160129.3955410-12-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwnode_for_each_child_node() is now the same as
fwnode_for_each_available_child_node() on all backends (OF, ACPI and
swnode). In order to remove the available variants, switch the uses to
non-available variants.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/leds/leds-max5970.c     | 2 +-
 drivers/leds/leds-max77705.c    | 2 +-
 drivers/leds/rgb/leds-ktd202x.c | 4 ++--
 drivers/leds/rgb/leds-ncp5623.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/leds-max5970.c b/drivers/leds/leds-max5970.c
index 285074c53b23..a1e91a06249c 100644
--- a/drivers/leds/leds-max5970.c
+++ b/drivers/leds/leds-max5970.c
@@ -60,7 +60,7 @@ static int max5970_led_probe(struct platform_device *pdev)
 	if (!led_node)
 		return -ENODEV;
 
-	fwnode_for_each_available_child_node(led_node, child) {
+	fwnode_for_each_child_node(led_node, child) {
 		u32 reg;
 
 		if (fwnode_property_read_u32(child, "reg", &reg))
diff --git a/drivers/leds/leds-max77705.c b/drivers/leds/leds-max77705.c
index b7403b3fcf5e..1e2054c1bf80 100644
--- a/drivers/leds/leds-max77705.c
+++ b/drivers/leds/leds-max77705.c
@@ -191,7 +191,7 @@ static int max77705_add_led(struct device *dev, struct regmap *regmap, struct fw
 		cdev->brightness_set_blocking = max77705_led_brightness_set_multi;
 		cdev->blink_set = max77705_rgb_blink;
 
-		fwnode_for_each_available_child_node(np, child) {
+		fwnode_for_each_child_node(np, child) {
 			ret = max77705_parse_subled(dev, child, &info[i]);
 			if (ret < 0)
 				return ret;
diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index 04e62faa3a00..e4f0f25a5e45 100644
--- a/drivers/leds/rgb/leds-ktd202x.c
+++ b/drivers/leds/rgb/leds-ktd202x.c
@@ -391,7 +391,7 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct fwnode_handle *fwn
 	int i = 0;
 
 	num_channels = 0;
-	fwnode_for_each_available_child_node(fwnode, child)
+	fwnode_for_each_child_node(fwnode, child)
 		num_channels++;
 
 	if (!num_channels || num_channels > chip->num_leds)
@@ -401,7 +401,7 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct fwnode_handle *fwn
 	if (!info)
 		return -ENOMEM;
 
-	fwnode_for_each_available_child_node(fwnode, child) {
+	fwnode_for_each_child_node(fwnode, child) {
 		u32 mono_color;
 		u32 reg;
 		int ret;
diff --git a/drivers/leds/rgb/leds-ncp5623.c b/drivers/leds/rgb/leds-ncp5623.c
index 7c7d44623a9e..85d6be6fff2b 100644
--- a/drivers/leds/rgb/leds-ncp5623.c
+++ b/drivers/leds/rgb/leds-ncp5623.c
@@ -180,7 +180,7 @@ static int ncp5623_probe(struct i2c_client *client)
 		goto release_mc_node;
 	}
 
-	fwnode_for_each_available_child_node(mc_node, led_node) {
+	fwnode_for_each_child_node(mc_node, led_node) {
 		ret = fwnode_property_read_u32(led_node, "color", &color_index);
 		if (ret)
 			goto release_led_node;
-- 
2.47.3


