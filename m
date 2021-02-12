Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE1431A073
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 15:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhBLOQK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 09:16:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:44203 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231571AbhBLOQJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Feb 2021 09:16:09 -0500
IronPort-SDR: vkN1Yn4D1SP2TQwRaKUt/HpTc0fhwgnOM4VlfqQsYtiPoNfvCPKgGT6msQhA3UoweVRe+kubCW
 WAVcyrcPWSaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="246483866"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="246483866"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 06:11:37 -0800
IronPort-SDR: Vnbi98rWZkRC5kJFiofmHLLfUjTgbAT93qCiMWpT+49pc/1njkt/Cy+CxapPOw1FqsC6NJyYfw
 vM7FGNIhVd0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="360386122"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 12 Feb 2021 06:11:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 87D161FA; Fri, 12 Feb 2021 16:11:34 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 1/5] ACPI: property: Remove dead code
Date:   Fri, 12 Feb 2021 16:11:17 +0200
Message-Id: <20210212141121.62115-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After the commit 3a7a2ab839ad couple of functions became a dead code.
Moreover, for all these years nobody used them. Remove.

Fixes: 3a7a2ab839ad ("ACPI / property: Extend fwnode_property_* to data-only subnodes")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 20 --------------------
 include/linux/acpi.h    | 21 ---------------------
 2 files changed, 41 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 16b28084c1ca..22ccab4e7c6d 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -841,20 +841,6 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 	return ret;
 }
 
-int acpi_dev_prop_read_single(struct acpi_device *adev, const char *propname,
-			      enum dev_prop_type proptype, void *val)
-{
-	int ret;
-
-	if (!adev || !val)
-		return -EINVAL;
-
-	ret = acpi_data_prop_read_single(&adev->data, propname, proptype, val);
-	if (ret < 0 || proptype != ACPI_TYPE_STRING)
-		return ret;
-	return 0;
-}
-
 static int acpi_copy_property_array_u8(const union acpi_object *items, u8 *val,
 				       size_t nval)
 {
@@ -995,12 +981,6 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
 	return ret;
 }
 
-int acpi_dev_prop_read(const struct acpi_device *adev, const char *propname,
-		       enum dev_prop_type proptype, void *val, size_t nval)
-{
-	return adev ? acpi_data_prop_read(&adev->data, propname, proptype, val, nval) : -EINVAL;
-}
-
 /**
  * acpi_node_prop_read - retrieve the value of an ACPI property with given name.
  * @fwnode: Firmware node to get the property from.
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ea296289a94c..14ac25165ae1 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1121,14 +1121,9 @@ acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
 
 int acpi_node_prop_get(const struct fwnode_handle *fwnode, const char *propname,
 		       void **valptr);
-int acpi_dev_prop_read_single(struct acpi_device *adev,
-			      const char *propname, enum dev_prop_type proptype,
-			      void *val);
 int acpi_node_prop_read(const struct fwnode_handle *fwnode,
 			const char *propname, enum dev_prop_type proptype,
 			void *val, size_t nval);
-int acpi_dev_prop_read(const struct acpi_device *adev, const char *propname,
-		       enum dev_prop_type proptype, void *val, size_t nval);
 
 struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 					    struct fwnode_handle *child);
@@ -1230,14 +1225,6 @@ static inline int acpi_node_prop_get(const struct fwnode_handle *fwnode,
 	return -ENXIO;
 }
 
-static inline int acpi_dev_prop_read_single(const struct acpi_device *adev,
-					    const char *propname,
-					    enum dev_prop_type proptype,
-					    void *val)
-{
-	return -ENXIO;
-}
-
 static inline int acpi_node_prop_read(const struct fwnode_handle *fwnode,
 				      const char *propname,
 				      enum dev_prop_type proptype,
@@ -1246,14 +1233,6 @@ static inline int acpi_node_prop_read(const struct fwnode_handle *fwnode,
 	return -ENXIO;
 }
 
-static inline int acpi_dev_prop_read(const struct acpi_device *adev,
-				     const char *propname,
-				     enum dev_prop_type proptype,
-				     void *val, size_t nval)
-{
-	return -ENXIO;
-}
-
 static inline struct fwnode_handle *
 acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 		      struct fwnode_handle *child)
-- 
2.30.0

