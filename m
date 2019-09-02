Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D4BA58A2
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 15:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfIBN6N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 09:58:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:40636 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730136AbfIBN5c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 09:57:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:57:29 -0700
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="266027119"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:57:27 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id A829020D4C;
        Mon,  2 Sep 2019 16:57:25 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i4mpo-00067L-K1; Mon, 02 Sep 2019 16:57:32 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v5 03/11] device property: Move fwnode_get_parent() up
Date:   Mon,  2 Sep 2019 16:57:24 +0300
Message-Id: <20190902135732.23455-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
References: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Move fwnode_get_parent() above fwnode_get_next_parent(), making the order
the same as in the header file.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 81bd01ed40427..3d9dffbe96378 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -556,6 +556,19 @@ int device_add_properties(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(device_add_properties);
 
+/**
+ * fwnode_get_parent - Return parent firwmare node
+ * @fwnode: Firmware whose parent is retrieved
+ *
+ * Return parent firmware node of the given node if possible or %NULL if no
+ * parent was available.
+ */
+struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
+{
+	return fwnode_call_ptr_op(fwnode, get_parent);
+}
+EXPORT_SYMBOL_GPL(fwnode_get_parent);
+
 /**
  * fwnode_get_next_parent - Iterate to the node's parent
  * @fwnode: Firmware whose parent is retrieved
@@ -577,19 +590,6 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
 
-/**
- * fwnode_get_parent - Return parent firwmare node
- * @fwnode: Firmware whose parent is retrieved
- *
- * Return parent firmware node of the given node if possible or %NULL if no
- * parent was available.
- */
-struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
-{
-	return fwnode_call_ptr_op(fwnode, get_parent);
-}
-EXPORT_SYMBOL_GPL(fwnode_get_parent);
-
 /**
  * fwnode_get_next_child_node - Return the next child node handle for a node
  * @fwnode: Firmware node to find the next child node for.
-- 
2.20.1

