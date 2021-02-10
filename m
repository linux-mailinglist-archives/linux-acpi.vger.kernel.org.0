Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88A131658E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 12:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBJLru (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 06:47:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:64421 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230155AbhBJLpl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Feb 2021 06:45:41 -0500
IronPort-SDR: 1aYOGg/K/Ex3vHeDXzuozZwtk0JrzUZ3DruK0+HDrJMI/2jMRN6jgqdro7iGV/Fd7soMmUf3UH
 CLQGztS5vZ2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="169181910"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="169181910"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 03:43:34 -0800
IronPort-SDR: hzriPaiTvPDGjGnUl4bRhI8m1Oq29jgVSXM808k8fIuX9gZl2HzVVE3fPWbJySWVkUlDIoLVVf
 qWJSOYZ4hv7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="488729857"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2021 03:43:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 35C32DE; Wed, 10 Feb 2021 13:43:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/7] ACPI: property: Remove dead code
Date:   Wed, 10 Feb 2021 13:43:14 +0200
Message-Id: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
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
index 24e87b630573..d9f3132466b5 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -829,20 +829,6 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 	return ret;
 }
 
-int acpi_dev_prop_read_single(struct acpi_device *adev, const char *propname,
-			      enum dev_prop_type proptype, void *val)
-{
-	int ret;
-
-	if (!adev)
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
@@ -973,12 +959,6 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
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

