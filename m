Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51F444AC73
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Nov 2021 12:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245676AbhKILWO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Nov 2021 06:22:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:59381 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245674AbhKILWO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Nov 2021 06:22:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="256106666"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="256106666"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 03:19:28 -0800
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="582073407"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 03:19:26 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id E0E6120970;
        Tue,  9 Nov 2021 13:19:24 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1mkPA7-006pNO-TX; Tue, 09 Nov 2021 13:19:35 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH 2/2] ACPI: Make acpi_node_get_parent() local
Date:   Tue,  9 Nov 2021 13:19:35 +0200
Message-Id: <20211109111935.1627406-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109111935.1627406-1-sakari.ailus@linux.intel.com>
References: <20211109111935.1627406-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_node_get_parent() isn't used outside drivers/acpi/property.c. Make it
local.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/acpi/property.c | 6 +++---
 include/linux/acpi.h    | 7 -------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index dc97711ba8081..ea82e5e2fdbce 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1084,7 +1084,8 @@ struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
  * Returns parent node of an ACPI device or data firmware node or %NULL if
  * not available.
  */
-struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode)
+static struct fwnode_handle *
+acpi_node_get_parent(const struct fwnode_handle *fwnode)
 {
 	if (is_acpi_data_node(fwnode)) {
 		/* All data nodes have parent pointer so just return that */
@@ -1092,8 +1093,7 @@ struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode)
 	}
 
 	if (is_acpi_device_node(fwnode)) {
-		struct device *dev =
-			to_acpi_device_node(fwnode)->dev.parent;
+		struct device *dev = to_acpi_device_node(fwnode)->dev.parent;
 
 		if (dev)
 			return acpi_fwnode_handle(to_acpi_device(dev));
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 974d497a897dc..a8e84be083a26 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1170,7 +1170,6 @@ int acpi_node_prop_get(const struct fwnode_handle *fwnode, const char *propname,
 
 struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 					    struct fwnode_handle *child);
-struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode);
 
 struct acpi_probe_entry;
 typedef bool (*acpi_probe_entry_validate_subtbl)(struct acpi_subtable_header *,
@@ -1275,12 +1274,6 @@ acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 	return NULL;
 }
 
-static inline struct fwnode_handle *
-acpi_node_get_parent(const struct fwnode_handle *fwnode)
-{
-	return NULL;
-}
-
 static inline struct fwnode_handle *
 acpi_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 			     struct fwnode_handle *prev)
-- 
2.30.2

