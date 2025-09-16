Return-Path: <linux-acpi+bounces-17041-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4750CB59CDF
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4813B71CD
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3852288C27;
	Tue, 16 Sep 2025 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGB/irjU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADB236CE18
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038513; cv=none; b=cE2uC02U4Tv8/FcWza8j3ZVv5YFmzlY5vNG3OznAkqrL1EbI2dWhahaHiJYKzU+QfkIibtQYZTxrk12zDx4OlWx0bzs5O4A63WGrRy+4vYu9Lo4+m4KV/SWVt1RhPPU6zrEUxZP1byyKKZDvNY0016+H+O9Hwtp9CVPe7YccbqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038513; c=relaxed/simple;
	bh=T1KbadFDRRmMzOvlB4KnoUsOTWPbnWRgOnHSsiBC+KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJtcNCOvJXCaoj52mDnQvVXqnpv98+sHzROMq1Un0zu6G4qDxVNxY3td7rFjreQ671xRehtHnbipeHlSlo5+sbNCtiubbBJNl30mqYRC/bS6nbEnOaLv/ssVOTuUZBNu+lcUZe5zmF6difcaJBOCUJRstpjCX/ikNN3AAm3ra6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGB/irjU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038507; x=1789574507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T1KbadFDRRmMzOvlB4KnoUsOTWPbnWRgOnHSsiBC+KY=;
  b=aGB/irjUb//DmKxQag8+iNqu1/oG6OhTW+1b3ftLNPLHBSDy8hd1VDj8
   9ELG2OiYoMtCv1DNJToohQQSRTg6PFrnArmxNVeyewMCZe8xuGS49H5um
   iSCGKdcv4lZor9dy9nV7bUw1e5k4iXoI3T3FT1B4S2YVeEDYyUApzht5b
   JrU3cPgD+2rKiq1WbU+IMR6jwI1B4LGdHLjiK4U0JfXEl2jHUPYORv8kZ
   Do/ofK6Xzef42N9lULIJRTTCp5kD7o7zB5PJlSpaGsthRYzsybyi4yJpg
   2ORdGACGrryMYfipoWax5p6W4z2CfXVY/1/HRRj3xFk1IGU+0M6TpeAF/
   Q==;
X-CSE-ConnectionGUID: dUjJlBroRwO9s6w7nB7gmw==
X-CSE-MsgGUID: 5Y7iiIERRgyAlwXtfWxpng==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71422978"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71422978"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:41 -0700
X-CSE-ConnectionGUID: 8Cfb9MnAQJexR9XoMXuktQ==
X-CSE-MsgGUID: v0zitCGBQ3qMHOD0NrmyHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174091543"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:38 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 85F79121F0C;
	Tue, 16 Sep 2025 19:01:30 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uyY7W-0000000Gb0V-27tl;
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
Subject: [PATCH 12/14] leds: Use fwnode_get_next_child_node() instead
Date: Tue, 16 Sep 2025 19:01:27 +0300
Message-ID: <20250916160129.3955410-13-sakari.ailus@linux.intel.com>
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

fwnode_get_next_child_node() is now the same as
fwnode_get_next_available_child_node() on all backends (OF, ACPI and
swnode). In order to remove the available variants, switch the uses to
non-available variants.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/leds/flash/leds-rt4505.c   | 2 +-
 drivers/leds/flash/leds-rt8515.c   | 2 +-
 drivers/leds/flash/leds-sgm3140.c  | 3 +--
 drivers/leds/flash/leds-tps6131x.c | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/flash/leds-rt4505.c b/drivers/leds/flash/leds-rt4505.c
index f16358b8dfc1..d3b1c5ca77ca 100644
--- a/drivers/leds/flash/leds-rt4505.c
+++ b/drivers/leds/flash/leds-rt4505.c
@@ -365,7 +365,7 @@ static int rt4505_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	child = fwnode_get_next_available_child_node(client->dev.fwnode, NULL);
+	child = fwnode_get_next_child_node(client->dev.fwnode, NULL);
 	if (!child) {
 		dev_err(priv->dev, "Failed to get child node\n");
 		return -EINVAL;
diff --git a/drivers/leds/flash/leds-rt8515.c b/drivers/leds/flash/leds-rt8515.c
index 6af0d2c7fc56..c2187a282dd9 100644
--- a/drivers/leds/flash/leds-rt8515.c
+++ b/drivers/leds/flash/leds-rt8515.c
@@ -304,7 +304,7 @@ static int rt8515_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(rt->enable_torch),
 				     "cannot get ENT (enable torch) GPIO\n");
 
-	child = fwnode_get_next_available_child_node(dev->fwnode, NULL);
+	child = fwnode_get_next_child_node(dev->fwnode, NULL);
 	if (!child) {
 		dev_err(dev,
 			"No fwnode child node found for connected LED.\n");
diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
index 3e83200675f2..1008a819fa7e 100644
--- a/drivers/leds/flash/leds-sgm3140.c
+++ b/drivers/leds/flash/leds-sgm3140.c
@@ -214,8 +214,7 @@ static int sgm3140_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "Failed to request regulator\n");
 
-	child_node = fwnode_get_next_available_child_node(pdev->dev.fwnode,
-							  NULL);
+	child_node = fwnode_get_next_child_node(pdev->dev.fwnode, NULL);
 	if (!child_node) {
 		dev_err(&pdev->dev,
 			"No fwnode child node found for connected LED.\n");
diff --git a/drivers/leds/flash/leds-tps6131x.c b/drivers/leds/flash/leds-tps6131x.c
index 6f4d4fd55361..12f957a76e34 100644
--- a/drivers/leds/flash/leds-tps6131x.c
+++ b/drivers/leds/flash/leds-tps6131x.c
@@ -544,7 +544,7 @@ static int tps6131x_parse_node(struct tps6131x *tps6131x)
 
 	tps6131x->valley_current_limit = device_property_read_bool(dev, "ti,valley-current-limit");
 
-	tps6131x->led_node = fwnode_get_next_available_child_node(dev->fwnode, NULL);
+	tps6131x->led_node = fwnode_get_next_child_node(dev->fwnode, NULL);
 	if (!tps6131x->led_node) {
 		dev_err(dev, "Missing LED node\n");
 		return -EINVAL;
-- 
2.47.3


