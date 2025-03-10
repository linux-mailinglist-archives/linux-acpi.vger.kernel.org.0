Return-Path: <linux-acpi+bounces-12011-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5310CA59922
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 16:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF093A5B10
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B433F22D79A;
	Mon, 10 Mar 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIYap6lr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B80A22D4DE;
	Mon, 10 Mar 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619325; cv=none; b=X8eeGJfFb6IhUFuEkKcL5tY5/hvqtw69kQWdQiBOKIS1oHXEVcHiK3V48a2UBxYX94cyQ7MQKQ6R8Jut3LbI2zO0bvNd/VJh/f9YYpmy2mSC01GmEBn/3ULeIGB+3rPJupcIM2+ER9PD9t3TZ13kIzSAPkl2lJXRIQHAQDoIEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619325; c=relaxed/simple;
	bh=j9ACf3C/6xmuNSerOIzYrxEPtrP4pqy0z2n/p3IOeUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/quVm6vaeZEFCILvhLFA+ge0GTXFO+BiPg4hqDd5SmnqV/14VXkrI3+b0riwPLSjb/ueQm9tGcmBauPD6lrotFF8jMM29xPVB2Kc7yHcZTff0AjYHVCOjgTNZyKuL0+9Z3WGCt5HB7bwEifDtVndImNxQ5v7UwUa7rxzYHswfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIYap6lr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741619324; x=1773155324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j9ACf3C/6xmuNSerOIzYrxEPtrP4pqy0z2n/p3IOeUA=;
  b=hIYap6lrUNCb93nMVpLt85I9Mg+Re2mS8lw0+eJ2fUW7orIcbq08kiKn
   kaMA/EGUi9+/QPp24hynVLsj8QS2gl14G/B6MgsKjvcZT0XcMgfhNv+fi
   7t4+ayewzv+La13hseGAJsfxoETtkadhcyWXETKzyVZMPsacECXZHtSUU
   jYuDzUeRJDm3p4uInwHx8Kls4bfdVTN6RKJobm+rdz9VfJlKC2HFVYbU0
   SYzfYF5kD/i5val2rtb+UxJ4H8DYGvVVyfVL/fzyWmIbSrznVTHQ9oMrX
   xykkCm1n+LlaL8VpNh5yeBemfRHkVVLrO/aTSVh0xliqjPYP5gRqCiBLO
   A==;
X-CSE-ConnectionGUID: JycGKDslTSWSD92YnI6ExA==
X-CSE-MsgGUID: dHiE1rBDSNiFkuta4VOXIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42334989"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42334989"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:08:43 -0700
X-CSE-ConnectionGUID: FaU1Z4XnSIOFlimyoSy2eQ==
X-CSE-MsgGUID: KL9q+jCwQNmdXjfuRWAQqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="119731644"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 10 Mar 2025 08:08:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E9601476; Mon, 10 Mar 2025 17:08:36 +0200 (EET)
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
Subject: [PATCH v1 3/4] leds: ncp5623: Use fwnode_get_child_node_count()
Date: Mon, 10 Mar 2025 16:54:53 +0200
Message-ID: <20250310150835.3139322-4-andriy.shevchenko@linux.intel.com>
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
 drivers/leds/rgb/leds-ncp5623.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-ncp5623.c b/drivers/leds/rgb/leds-ncp5623.c
index f18156683375..7c7d44623a9e 100644
--- a/drivers/leds/rgb/leds-ncp5623.c
+++ b/drivers/leds/rgb/leds-ncp5623.c
@@ -155,9 +155,9 @@ static int ncp5623_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct fwnode_handle *mc_node, *led_node;
 	struct led_init_data init_data = { };
-	int num_subleds = 0;
 	struct ncp5623 *ncp;
 	struct mc_subled *subled_info;
+	unsigned int num_subleds;
 	u32 color_index;
 	u32 reg;
 	int ret;
@@ -172,8 +172,7 @@ static int ncp5623_probe(struct i2c_client *client)
 	if (!mc_node)
 		return -EINVAL;
 
-	fwnode_for_each_child_node(mc_node, led_node)
-		num_subleds++;
+	num_subleds = fwnode_get_child_node_count(mc_node);
 
 	subled_info = devm_kcalloc(dev, num_subleds, sizeof(*subled_info), GFP_KERNEL);
 	if (!subled_info) {
-- 
2.47.2


