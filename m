Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1284444776
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2019 19:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393021AbfFMQ74 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 12:59:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:1397 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbfFMQ74 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Jun 2019 12:59:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 09:59:54 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Jun 2019 09:59:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EE1EB141; Thu, 13 Jun 2019 19:59:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2, resend] device property: Add helpers to count items in an array
Date:   Thu, 13 Jun 2019 19:59:51 +0300
Message-Id: <20190613165951.64148-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The usual pattern to allocate the necessary space for an array of properties is
to count them first by calling:

  count = device_property_read_uXX_array(dev, propname, NULL, 0);
  if (count < 0)
	return count;

Introduce helpers device_property_count_uXX() to count items by supplying hard
coded last two parameters to device_property_readXX_array().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 include/linux/property.h | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 088d4db7e949..dbacf17fff2e 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -148,6 +148,26 @@ static inline int device_property_read_u64(struct device *dev,
 	return device_property_read_u64_array(dev, propname, val, 1);
 }
 
+static inline int device_property_count_u8(struct device *dev, const char *propname)
+{
+	return device_property_read_u8_array(dev, propname, NULL, 0);
+}
+
+static inline int device_property_count_u16(struct device *dev, const char *propname)
+{
+	return device_property_read_u16_array(dev, propname, NULL, 0);
+}
+
+static inline int device_property_count_u32(struct device *dev, const char *propname)
+{
+	return device_property_read_u32_array(dev, propname, NULL, 0);
+}
+
+static inline int device_property_count_u64(struct device *dev, const char *propname)
+{
+	return device_property_read_u64_array(dev, propname, NULL, 0);
+}
+
 static inline bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
 					     const char *propname)
 {
@@ -178,6 +198,30 @@ static inline int fwnode_property_read_u64(const struct fwnode_handle *fwnode,
 	return fwnode_property_read_u64_array(fwnode, propname, val, 1);
 }
 
+static inline int fwnode_property_count_u8(const struct fwnode_handle *fwnode,
+					   const char *propname)
+{
+	return fwnode_property_read_u8_array(fwnode, propname, NULL, 0);
+}
+
+static inline int fwnode_property_count_u16(const struct fwnode_handle *fwnode,
+					    const char *propname)
+{
+	return fwnode_property_read_u16_array(fwnode, propname, NULL, 0);
+}
+
+static inline int fwnode_property_count_u32(const struct fwnode_handle *fwnode,
+					    const char *propname)
+{
+	return fwnode_property_read_u32_array(fwnode, propname, NULL, 0);
+}
+
+static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
+					    const char *propname)
+{
+	return fwnode_property_read_u64_array(fwnode, propname, NULL, 0);
+}
+
 /**
  * struct property_entry - "Built-in" device property representation.
  * @name: Name of the property.
-- 
2.20.1

