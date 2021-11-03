Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79386444273
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 14:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhKCNg1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 09:36:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:64399 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230527AbhKCNg0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Nov 2021 09:36:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="294944290"
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="294944290"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 06:33:48 -0700
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="599900240"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 06:33:47 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 335C5207CE;
        Wed,  3 Nov 2021 15:33:45 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1miGP0-002lak-Oi; Wed, 03 Nov 2021 15:34:06 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com
Subject: [PATCH 3/3] ACPI: Make acpi_node_get_parent() local
Date:   Wed,  3 Nov 2021 15:34:06 +0200
Message-Id: <20211103133406.659542-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
References: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_node_get_parent() isn't used outside drivers/acpi/property.c. Make it
local.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 3 ++-
 include/linux/acpi.h    | 7 -------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 7403ee2816eb8..49301d1bba4ff 100644
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
index 375715b0535fb..c65a754b1db53 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1168,7 +1168,6 @@ int acpi_node_prop_get(const struct fwnode_handle *fwnode, const char *propname,
 
 struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 					    struct fwnode_handle *child);
-struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode);
 
 struct acpi_probe_entry;
 typedef bool (*acpi_probe_entry_validate_subtbl)(struct acpi_subtable_header *,
@@ -1273,12 +1272,6 @@ acpi_get_next_subnode(const struct fwnode_handle *fwnode,
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

