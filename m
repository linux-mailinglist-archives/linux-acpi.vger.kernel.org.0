Return-Path: <linux-acpi+bounces-978-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975E47D75B8
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DD41C20DB3
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024491BDF9
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpnolXxb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADDD1D69B
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 18:43:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B898DC;
	Wed, 25 Oct 2023 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698259387; x=1729795387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T1sOH8MzD7ijqC2IX92sIk4YyeSEBbdujMf4a6IQTo0=;
  b=hpnolXxbUnhqliba/zRd5Kq7TqHBo9QG2rVe0DUEYI9NYknDTF8L9NhT
   w9UgrPaKeBzpIeKOFxNz/DyyN/UF+gG9VIjZXlXLOuVFLRz153x02Weuv
   ueBBRv5zvsEqrizUG+Izc8nk+cma87X5C8rXsNdXdnDWea1mWa9Ah1aVF
   SqPnwXn+wgQaIZuQnAHh5j5xcsj8qClexLf1NWbBDnjNXOrd8cwn8z10j
   vK2zIYYWHB6x/nbDM66W6qImUr9n8pb9+hKByZBtvonzIxv5wXBdyKJyC
   X+sPW0h/m6Y4y3MYXgGI3clFaM2yuNgHa5nS9G/vSYx7wI0rpzU6/dOd5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="390233006"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="390233006"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="932458246"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="932458246"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 25 Oct 2023 11:43:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D2142FF; Wed, 25 Oct 2023 21:43:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v1 1/3] device property: Implement device_is_big_endian()
Date: Wed, 25 Oct 2023 21:42:57 +0300
Message-Id: <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some users want to use the struct device pointer to see if the
device is big endian in terms of Open Firmware specifications,
i.e. if it has a "big-endian" property, or if the kernel was
compiled for BE *and* the device has a "native-endian" property.

Provide inline helper for the users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/property.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 2b8f07fc68a9..d1400a477b0a 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -80,12 +80,38 @@ int fwnode_property_match_string(const struct fwnode_handle *fwnode,
 
 bool fwnode_device_is_available(const struct fwnode_handle *fwnode);
 
+static inline bool fwnode_device_is_big_endian(const struct fwnode_handle *fwnode)
+{
+	if (fwnode_property_present(fwnode, "big-endian"))
+		return true;
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
+	    fwnode_property_present(fwnode, "native-endian"))
+		return true;
+	return false;
+}
+
 static inline
 bool fwnode_device_is_compatible(const struct fwnode_handle *fwnode, const char *compat)
 {
 	return fwnode_property_match_string(fwnode, "compatible", compat) >= 0;
 }
 
+/**
+ * device_is_big_endian - check if a device has BE registers
+ * @dev: Pointer to the struct device
+ *
+ * Returns: true if the device has a "big-endian" property, or if the kernel
+ * was compiled for BE *and* the device has a "native-endian" property.
+ * Returns false otherwise.
+ *
+ * Callers would nominally use ioread32be/iowrite32be if
+ * device_is_big_endian() == true, or readl/writel otherwise.
+ */
+static inline bool device_is_big_endian(const struct device *dev)
+{
+	return fwnode_device_is_big_endian(dev_fwnode(dev));
+}
+
 /**
  * device_is_compatible - match 'compatible' property of the device with a given string
  * @dev: Pointer to the struct device
-- 
2.40.0.1.gaa8946217a0b


