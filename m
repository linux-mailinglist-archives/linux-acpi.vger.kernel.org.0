Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC51F454CCC
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Nov 2021 19:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbhKQSKQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 13:10:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:12435 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239853AbhKQSKQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Nov 2021 13:10:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="220903256"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="220903256"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 10:07:17 -0800
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="568068342"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 10:07:11 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 4A95E206C1;
        Wed, 17 Nov 2021 20:07:06 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1mnPLL-00D2p6-P6; Wed, 17 Nov 2021 20:07:35 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 2/2] ACPI: Make acpi_node_get_parent() local
Date:   Wed, 17 Nov 2021 20:07:35 +0200
Message-Id: <20211117180735.3109054-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211117180735.3109054-1-sakari.ailus@linux.intel.com>
References: <20211117180735.3109054-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_node_get_parent() isn't used outside drivers/acpi/property.c. Make it
local.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 3 ++-
 include/linux/acpi.h    | 7 -------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 781e312f45342..2366f54d8e9cf 100644
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

