Return-Path: <linux-acpi+bounces-12013-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE1EA5992B
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 16:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9E8167EB9
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5764222DFE5;
	Mon, 10 Mar 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqzj2mcP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20622D78F;
	Mon, 10 Mar 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619327; cv=none; b=pl5ExvdrouqyKsVDVVqJZ5YEHGYkWMcUXWYtj0ThDrAscRokolZ4SRvrHgsGejwsV7l3/DS/hlEToyrAxW5IJk0DsjQvrUJaTcjlhde5M+TFysXThw02eNfTgndh+zSUF+GB/8dDwpZTnScTnGC7R5GMB+L8tFuMNuhpPw8HWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619327; c=relaxed/simple;
	bh=MNV2x4YXuI3EbpVLRxfKOQWNxGNCe/SqUoLSpVNi0M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPW914YcqhIL1u2A7aSYp39pe/SqMNTUS/o0k2wu7g00q16YT3vY1lBFDKSH5HyMKIedmuxRVfXeZLM8N0b2BrzwjSpFFLKq4fd66OV5JcQUqyUAh/iA1WogeEUVwK4zyxVU5VLC0e5anoa6stDhoOW8j0EUaE8IdJaWHQiO91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqzj2mcP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741619326; x=1773155326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MNV2x4YXuI3EbpVLRxfKOQWNxGNCe/SqUoLSpVNi0M0=;
  b=nqzj2mcPfbK8/SVmB7jauhB/NSU/c1wp406YTxeWw6jDQM09/PYu+j2i
   fIMou4nHCS5GDTP3ACzlp5DEmRz8RlGDtXuvupW1CSmn1deeU8V1/ktxh
   MS8sfpdue7wWEfdVnWxtGTx+HsBEN4S9KerXdCzkNT8V2JDPq1GhlpPi7
   Ix/9/yR2o3tvNDM3mxHFcC8P5KuHMeKfGhg2hh2OH5owIkYb16wBr+RtU
   x4s4zUcHPgsWIexPPKuWnc/0EqHdP3APwo58EhKHv9ZrAjvGA8OwOPXkK
   f/b1J7WbqUywhwjuTE0siqoGDt+E4UeC1UpsWatkyaAAQll20GzVdVXSc
   g==;
X-CSE-ConnectionGUID: dm7l8EEzTkKJgRhbudTNMA==
X-CSE-MsgGUID: tf+6VIcoTB6Odz/h+XBdoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42470928"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42470928"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:08:43 -0700
X-CSE-ConnectionGUID: mUmVCTCiScyhQY6GM3rDeA==
X-CSE-MsgGUID: A3xcm5rtTmSOkhv6SQuHyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="124619904"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 10 Mar 2025 08:08:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DBB89340; Mon, 10 Mar 2025 17:08:36 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Jakob Riepler <jakob+lkml@paranoidlabs.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 2/4] leds: pwm-multicolor: Use fwnode_get_child_node_count()
Date: Mon, 10 Mar 2025 16:54:52 +0200
Message-ID: <20250310150835.3139322-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since fwnode_get_child_node_count() was split from its device property
counterpart, we may utilise it in the driver and drop custom implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/rgb/leds-pwm-multicolor.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/rgb/leds-pwm-multicolor.c b/drivers/leds/rgb/leds-pwm-multicolor.c
index f80a06cc31f8..61f4e17100f8 100644
--- a/drivers/leds/rgb/leds-pwm-multicolor.c
+++ b/drivers/leds/rgb/leds-pwm-multicolor.c
@@ -107,12 +107,12 @@ static int iterate_subleds(struct device *dev, struct pwm_mc_led *priv,
 
 static int led_pwm_mc_probe(struct platform_device *pdev)
 {
-	struct fwnode_handle *mcnode, *fwnode;
+	struct fwnode_handle *mcnode;
 	struct led_init_data init_data = {};
 	struct led_classdev *cdev;
 	struct mc_subled *subled;
 	struct pwm_mc_led *priv;
-	int count = 0;
+	unsigned int count;
 	int ret = 0;
 
 	mcnode = device_get_named_child_node(&pdev->dev, "multi-led");
@@ -121,8 +121,7 @@ static int led_pwm_mc_probe(struct platform_device *pdev)
 				     "expected multi-led node\n");
 
 	/* count the nodes inside the multi-led node */
-	fwnode_for_each_child_node(mcnode, fwnode)
-		count++;
+	count = fwnode_get_child_node_count(mcnode);
 
 	priv = devm_kzalloc(&pdev->dev, struct_size(priv, leds, count),
 			    GFP_KERNEL);
-- 
2.47.2


