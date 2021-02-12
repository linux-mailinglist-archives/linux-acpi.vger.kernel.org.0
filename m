Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D36631A071
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 15:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhBLOPo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 09:15:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:44070 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230228AbhBLOPn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Feb 2021 09:15:43 -0500
IronPort-SDR: 5QZqDiWEirAWy9fepU8XNc3FwKOPvdQk6fGCZPZAPVNOBDAnro1gFEN6aw2mTwsBh4nsqUhcuT
 7ObbkqRYRULQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="246483851"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="246483851"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 06:11:36 -0800
IronPort-SDR: vMPon+9t5QQHPV+Eh//vRhovp5yxzBmX3cADKdOZsA50Nl/qIrGuHJlc4AV8kYMf6OzYSDB5WA
 sbq2ysSEW9fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="437596730"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2021 06:11:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 932C1DE; Fri, 12 Feb 2021 16:11:34 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 2/5] ACPI: property: Make acpi_node_prop_read() static
Date:   Fri, 12 Feb 2021 16:11:18 +0200
Message-Id: <20210212141121.62115-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210212141121.62115-1-andriy.shevchenko@linux.intel.com>
References: <20210212141121.62115-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is no users outside of property.c. No need to export
acpi_node_prop_read(), hence make it static.

Fixes: 3708184afc77 ("device property: Move FW type specific functionality to FW specific files")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c |  6 +++---
 include/linux/acpi.h    | 11 -----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 22ccab4e7c6d..2b65ad9b4c0d 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -993,9 +993,9 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
  * of the property.  Otherwise, read at most @nval values to the array at the
  * location pointed to by @val.
  */
-int acpi_node_prop_read(const struct fwnode_handle *fwnode,
-			const char *propname, enum dev_prop_type proptype,
-			void *val, size_t nval)
+static int acpi_node_prop_read(const struct fwnode_handle *fwnode,
+			       const char *propname, enum dev_prop_type proptype,
+			       void *val, size_t nval)
 {
 	return acpi_data_prop_read(acpi_device_data_of_node(fwnode),
 				   propname, proptype, val, nval);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 14ac25165ae1..3c5757d539ab 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1121,9 +1121,6 @@ acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
 
 int acpi_node_prop_get(const struct fwnode_handle *fwnode, const char *propname,
 		       void **valptr);
-int acpi_node_prop_read(const struct fwnode_handle *fwnode,
-			const char *propname, enum dev_prop_type proptype,
-			void *val, size_t nval);
 
 struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 					    struct fwnode_handle *child);
@@ -1225,14 +1222,6 @@ static inline int acpi_node_prop_get(const struct fwnode_handle *fwnode,
 	return -ENXIO;
 }
 
-static inline int acpi_node_prop_read(const struct fwnode_handle *fwnode,
-				      const char *propname,
-				      enum dev_prop_type proptype,
-				      void *val, size_t nval)
-{
-	return -ENXIO;
-}
-
 static inline struct fwnode_handle *
 acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 		      struct fwnode_handle *child)
-- 
2.30.0

