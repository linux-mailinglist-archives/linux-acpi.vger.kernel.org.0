Return-Path: <linux-acpi+bounces-12010-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46656A5991F
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 16:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DAE3A5D79
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 15:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB1722D4F4;
	Mon, 10 Mar 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeiUr9bw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFE222D4DD;
	Mon, 10 Mar 2025 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619325; cv=none; b=tIlgiAqTqMbLaMs8rDcVhXGkvx3dIVMbpN6cCxGCAOWT1GjNrN8MWGjd3RO3EpKGekudAXD7SQvKeBSUWtU8ZYVCyDe8bF1vy/FsaE9/LYrRpFsSllsNsjNoTaHtoh8ZQ4ZHfWpQF+cKv+Swp/bqOkPaysNQItXNk90LBhkQvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619325; c=relaxed/simple;
	bh=9oJVJa0qo0kpfDX4vakbrBm7GZ7WYtWfrZEPpzP3HUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3XjDgriFP+0ZT6eBi6o6ZyK6XC3lsHMEyK3fqoxKsfjMp0+kdxnDZ1NysLcCKUp79GkMPWEMXJ7J2HnUMQAz+6zJJqVixl/UFUbxblBG1y8EnstsxA2D0nVW7DPwRxjaAWhpt9jaXnQPaZ6xXskfy7fcT+iI/5BEYijOkHFmpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeiUr9bw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741619324; x=1773155324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9oJVJa0qo0kpfDX4vakbrBm7GZ7WYtWfrZEPpzP3HUU=;
  b=BeiUr9bwHAl9GKO0GyTqiq3Ujf6GcVQXoJbROzaYXhU24a2JIlb0yZkG
   ru/4/8+JTmLuKhIF8SrjhwNXlK7W3QC6/BLH/t/0A1lo0PNqbXasUlBym
   oymhUYCsjuEGAhPtlbxLtvvNKNYlFqvi90uWPqXSbGtho9/6x5E6Cu+Fa
   392OEF998SAB/0XV+FlWJ3Lk7A4TqQJejTiQ8O5Ls0vGzXfhyMh3xVaiV
   73Gx2fk5NdDvfoJxv3ZuJ/KKQp09pHsphE48qfGqvGNSX7F+sfvAEozR0
   BMTafsexsYRX9hhhyk84cyuhFx9hZpgaKupfoa18ieHfnX5tS2bTaDsVv
   g==;
X-CSE-ConnectionGUID: l0QMQnovRQWNqMLnzB59+Q==
X-CSE-MsgGUID: 2yw0lH4XQUCDT0jPbpHRrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42470909"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42470909"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:08:42 -0700
X-CSE-ConnectionGUID: flxv6K3FSNqrKieGKtEtFA==
X-CSE-MsgGUID: z0IQtfEYTQ6YfH+WNEvbsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="124619903"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 10 Mar 2025 08:08:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CE22D130; Mon, 10 Mar 2025 17:08:36 +0200 (EET)
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
Subject: [PATCH v1 1/4] device property: Split fwnode_get_child_node_count()
Date: Mon, 10 Mar 2025 16:54:51 +0200
Message-ID: <20250310150835.3139322-2-andriy.shevchenko@linux.intel.com>
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

The new helper is introduced to allow counting the child firmware nodes
of their parent without requiring a device to be passed. This also makes
the fwnode and device property API more symmetrical with the rest.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 12 ++++++------
 include/linux/property.h |  7 ++++++-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c1392743df9c..805f75b35115 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -928,22 +928,22 @@ bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(fwnode_device_is_available);
 
 /**
- * device_get_child_node_count - return the number of child nodes for device
- * @dev: Device to count the child nodes for
+ * fwnode_get_child_node_count - return the number of child nodes for a given firmware node
+ * @fwnode: Pointer to the parent firmware node
  *
- * Return: the number of child nodes for a given device.
+ * Return: the number of child nodes for a given firmware node.
  */
-unsigned int device_get_child_node_count(const struct device *dev)
+unsigned int fwnode_get_child_node_count(const struct fwnode_handle *fwnode)
 {
 	struct fwnode_handle *child;
 	unsigned int count = 0;
 
-	device_for_each_child_node(dev, child)
+	fwnode_for_each_child_node(fwnode, child)
 		count++;
 
 	return count;
 }
-EXPORT_SYMBOL_GPL(device_get_child_node_count);
+EXPORT_SYMBOL_GPL(fwnode_get_child_node_count);
 
 bool device_dma_supported(const struct device *dev)
 {
diff --git a/include/linux/property.h b/include/linux/property.h
index e214ecd241eb..bc5bfc98176b 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -208,7 +208,12 @@ DEFINE_FREE(fwnode_handle, struct fwnode_handle *, fwnode_handle_put(_T))
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
 
-unsigned int device_get_child_node_count(const struct device *dev);
+unsigned int fwnode_get_child_node_count(const struct fwnode_handle *fwnode);
+
+static inline unsigned int device_get_child_node_count(const struct device *dev)
+{
+	return fwnode_get_child_node_count(dev_fwnode(dev));
+}
 
 static inline int device_property_read_u8(const struct device *dev,
 					  const char *propname, u8 *val)
-- 
2.47.2


