Return-Path: <linux-acpi+bounces-12647-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E33A78E46
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 14:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272A73AC648
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB6323A984;
	Wed,  2 Apr 2025 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEC0IT1e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C7239581;
	Wed,  2 Apr 2025 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596591; cv=none; b=UdPEr80dprqSh39gknfADjp+U5lfCSx2kCviQJT9dL4GdpQYIBgwr1OzsCzH0wwzdgVxraBWqjGCRiYn48kJzyKKVDtBjA/2998mvzt6bxTTxgkf65KQKgMpsl402srIt7uF6eJUC8LwnKk+pUNZMy5rukD1KCIBk2ZWedICayM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596591; c=relaxed/simple;
	bh=vF5juCg/6dnuChWLFVdhEXWfPsLDUW9kA6pZwXk5Ffo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPLdvbmtgHc79L3E6Qcp2GWTVqWvQbLj9zOuRNjhaqo5nEyJ03sEAOpeVQpxzMmqEJWRmMx98gN4chkYFpvNrTotsOmYP6ZMKKTqLgv1JBma3FxXIRaQ7W3xoO9HiEA1YMqGn9ejQf0jAO5qnyMqZV6ZK7mH+1mrcDKzzTouLyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEC0IT1e; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743596590; x=1775132590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vF5juCg/6dnuChWLFVdhEXWfPsLDUW9kA6pZwXk5Ffo=;
  b=XEC0IT1eY+Y0m0VQMlfJIt6Qb3jp0obViIPHKA3eSG2WelYGayvpvf3v
   fHVcn1KE2z83GMwxD6ra41bwg86elB8SUgvuUthwdx5r36UCiwpOUnWy3
   ZDhW6vDqlGW6wquiTZEdRWNKlc2um96g/svPQIAWBVJFUDqvG8P7piGW9
   g5AuwMt+l3IrWEsxeJd0DSLDlt7DQzDM5E/j6MpTR7MCR4oTEVwGONCBf
   lZ/DvzuZcdwenOw35LUuWQUmT01yZtfVNU/E8OLQH5f+n81QprN4/DhOd
   LojjQmJQyGfMQNvYRRqo64eRwH55PXZdcM4SEVT9jEAbGzVyJmARXrSr8
   Q==;
X-CSE-ConnectionGUID: hvNlDlooSSOvxMIW4zb0oQ==
X-CSE-MsgGUID: h+epLI7NQh+p1kUtKISDVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44865041"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44865041"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:23:07 -0700
X-CSE-ConnectionGUID: kgFN5AjWR9i67zi+ofdETg==
X-CSE-MsgGUID: 4iTbWnQjR9GqKSVfugWG7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="157635538"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 02 Apr 2025 05:23:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 58674271; Wed, 02 Apr 2025 15:23:03 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/5] gpiolib: acpi: Remove index parameter from acpi_gpio_property_lookup()
Date: Wed,  2 Apr 2025 15:21:17 +0300
Message-ID: <20250402122301.1517463-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402122301.1517463-1-andriy.shevchenko@linux.intel.com>
References: <20250402122301.1517463-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In all cases the supplied index is the same as the passed one in
the struct acpi_gpio_lookup. Remove index parameter and reuse one
from the struct acpi_gpio_lookup instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 878b11c81c7b..afeb8d1c7102 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -830,17 +830,17 @@ static int acpi_gpio_resource_lookup(struct acpi_gpio_lookup *lookup,
 	return 0;
 }
 
-static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
-				     const char *propname, int index,
+static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode, const char *propname,
 				     struct acpi_gpio_lookup *lookup)
 {
 	struct fwnode_reference_args args;
+	unsigned int index = lookup->index;
 	unsigned int quirks = 0;
 	int ret;
 
 	memset(&args, 0, sizeof(args));
-	ret = __acpi_node_get_property_reference(fwnode, propname, index, 3,
-						 &args);
+
+	ret = __acpi_node_get_property_reference(fwnode, propname, index, 3, &args);
 	if (ret) {
 		struct acpi_device *adev;
 
@@ -905,8 +905,7 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 	if (propname) {
 		dev_dbg(&adev->dev, "GPIO: looking up %s\n", propname);
 
-		ret = acpi_gpio_property_lookup(acpi_fwnode_handle(adev),
-						propname, index, &lookup);
+		ret = acpi_gpio_property_lookup(acpi_fwnode_handle(adev), propname, &lookup);
 		if (ret)
 			return ERR_PTR(ret);
 
@@ -955,7 +954,7 @@ static struct gpio_desc *acpi_get_gpiod_from_data(struct fwnode_handle *fwnode,
 	memset(&lookup, 0, sizeof(lookup));
 	lookup.index = index;
 
-	ret = acpi_gpio_property_lookup(fwnode, propname, index, &lookup);
+	ret = acpi_gpio_property_lookup(fwnode, propname, &lookup);
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.47.2


