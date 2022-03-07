Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2830D4D0850
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Mar 2022 21:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiCGUal (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Mar 2022 15:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiCGUak (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Mar 2022 15:30:40 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2309574A7;
        Mon,  7 Mar 2022 12:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646684985; x=1678220985;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uQIjKu/qjwzFXGSLSmIUdR//ml6vKPhPZdbrnXFYAAU=;
  b=WszdeIccC+fM0JlGUdqh9MzZypJsV7RpzqtRNjOHgRUey77RoscLzTuG
   VCZtQly5E1ycMxLBYhdziW2+ZVeE56L+4Oc3DdaOU95nZ6bh45Pf3B5XV
   KYanFbpfr1b8xFyUpp8JbdWrpbzwNptHckzaQZG9jc6hLq77eRPusbGnp
   oCTE8QwsqJNuKnXrWHcYAM+7uIdnaYA5VY21nWyIHYHAc+BbuZe2OHAKg
   i7/YvAhZf1VJKS0pNLFhLe3lh5f4TDXE85xm8cBsnTw7mdP7ar2As5ULE
   Af3WDyThPxCQjb9wK4ucqJCF1l8zFGumVfBVqphZ8azCY4grmpRnlkZEy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="234451976"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="234451976"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:29:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="509838533"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 07 Mar 2022 12:29:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E5A551D6; Mon,  7 Mar 2022 22:29:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v3 1/1] device property: Allow error pointer to be passed to fwnode APIs
Date:   Mon,  7 Mar 2022 22:29:49 +0200
Message-Id: <20220307202949.75300-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some of the fwnode APIs might return an error pointer instead of NULL
or valid fwnode handle. The result of such API call may be considered
optional and hence the test for it is usually done in a form of

	fwnode = fwnode_find_reference(...);
	if (IS_ERR(fwnode))
		...error handling...

Nevertheless the resulting fwnode may have bumped the reference count
and hence caller of the above API is obliged to call fwnode_handle_put().
Since fwnode may be not valid either as NULL or error pointer the check
has to be performed there. This approach uglifies the code and adds
a point of making a mistake, i.e. forgetting about error point case.

To prevent this, allow an error pointer to be passed to the fwnode APIs.

Fixes: 83b34afb6b79 ("device property: Introduce fwnode_find_reference()")
Reported-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Nuno Sá <nuno.sa@analog.com>
---

v3: dropped test of secondary fwnode (Nuno), added tag (Nuno), amended commit message
v2: adjusted the entire fwnode API (Sakari)

Nuno, can you re-test this with the ltc2983 series to be sure it is still okay?

 drivers/base/property.c | 76 +++++++++++++++++++++++------------------
 include/linux/fwnode.h  | 10 +++---
 2 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c0e94cce9c29..635a0e556a4f 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -9,6 +9,7 @@
 
 #include <linux/acpi.h>
 #include <linux/export.h>
+#include <linux/fwnode.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -47,12 +48,14 @@ bool fwnode_property_present(const struct fwnode_handle *fwnode,
 {
 	bool ret;
 
+	if (IS_ERR_OR_NULL(fwnode))
+		return false;
+
 	ret = fwnode_call_bool_op(fwnode, property_present, propname);
-	if (ret == false && !IS_ERR_OR_NULL(fwnode) &&
-	    !IS_ERR_OR_NULL(fwnode->secondary))
-		ret = fwnode_call_bool_op(fwnode->secondary, property_present,
-					 propname);
-	return ret;
+	if (ret == true)
+		return ret;
+
+	return fwnode_call_bool_op(fwnode->secondary, property_present, propname);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_present);
 
@@ -232,15 +235,16 @@ static int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
 {
 	int ret;
 
+	if (IS_ERR_OR_NULL(fwnode))
+		return -EINVAL;
+
 	ret = fwnode_call_int_op(fwnode, property_read_int_array, propname,
 				 elem_size, val, nval);
-	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
-	    !IS_ERR_OR_NULL(fwnode->secondary))
-		ret = fwnode_call_int_op(
-			fwnode->secondary, property_read_int_array, propname,
-			elem_size, val, nval);
+	if (ret != -EINVAL)
+		return ret;
 
-	return ret;
+	return fwnode_call_int_op(fwnode->secondary, property_read_int_array, propname,
+				  elem_size, val, nval);
 }
 
 /**
@@ -371,14 +375,16 @@ int fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
 {
 	int ret;
 
+	if (IS_ERR_OR_NULL(fwnode))
+		return -EINVAL;
+
 	ret = fwnode_call_int_op(fwnode, property_read_string_array, propname,
 				 val, nval);
-	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
-	    !IS_ERR_OR_NULL(fwnode->secondary))
-		ret = fwnode_call_int_op(fwnode->secondary,
-					 property_read_string_array, propname,
-					 val, nval);
-	return ret;
+	if (ret != -EINVAL)
+		return ret;
+
+	return fwnode_call_int_op(fwnode->secondary, property_read_string_array, propname,
+				  val, nval);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
 
@@ -480,15 +486,16 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 {
 	int ret;
 
+	if (IS_ERR_OR_NULL(fwnode))
+		return -ENOENT;
+
 	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
 				 nargs, index, args);
+	if (ret == 0)
+		return ret;
 
-	if (ret < 0 && !IS_ERR_OR_NULL(fwnode) &&
-	    !IS_ERR_OR_NULL(fwnode->secondary))
-		ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
-					 prop, nargs_prop, nargs, index, args);
-
-	return ret;
+	return fwnode_call_int_op(fwnode->secondary, get_reference_args, prop, nargs_prop,
+				  nargs, index, args);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
 
@@ -698,7 +705,7 @@ fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
 {
 	struct fwnode_handle *next_child = child;
 
-	if (!fwnode)
+	if (IS_ERR_OR_NULL(fwnode))
 		return NULL;
 
 	do {
@@ -722,16 +729,16 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
 	const struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct fwnode_handle *next;
 
+	if (IS_ERR_OR_NULL(fwnode))
+		return NULL;
+
 	/* Try to find a child in primary fwnode */
 	next = fwnode_get_next_child_node(fwnode, child);
 	if (next)
 		return next;
 
 	/* When no more children in primary, continue with secondary */
-	if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
-		next = fwnode_get_next_child_node(fwnode->secondary, child);
-
-	return next;
+	return fwnode_get_next_child_node(fwnode->secondary, child);
 }
 EXPORT_SYMBOL_GPL(device_get_next_child_node);
 
@@ -798,6 +805,9 @@ EXPORT_SYMBOL_GPL(fwnode_handle_put);
  */
 bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
+	if (IS_ERR_OR_NULL(fwnode))
+		return false;
+
 	if (!fwnode_has_op(fwnode, device_is_available))
 		return true;
 
@@ -988,14 +998,14 @@ fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 		parent = fwnode_graph_get_port_parent(prev);
 	else
 		parent = fwnode;
+	if (IS_ERR_OR_NULL(parent))
+		return NULL;
 
 	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
+	if (ep)
+		return ep;
 
-	if (IS_ERR_OR_NULL(ep) &&
-	    !IS_ERR_OR_NULL(parent) && !IS_ERR_OR_NULL(parent->secondary))
-		ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
-
-	return ep;
+	return fwnode_graph_get_next_endpoint(parent->secondary, NULL);
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 3a532ba66f6c..7defac04f9a3 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -148,12 +148,12 @@ struct fwnode_operations {
 	int (*add_links)(struct fwnode_handle *fwnode);
 };
 
-#define fwnode_has_op(fwnode, op)				\
-	((fwnode) && (fwnode)->ops && (fwnode)->ops->op)
+#define fwnode_has_op(fwnode, op)					\
+	(!IS_ERR_OR_NULL(fwnode) && (fwnode)->ops && (fwnode)->ops->op)
+
 #define fwnode_call_int_op(fwnode, op, ...)				\
-	(fwnode ? (fwnode_has_op(fwnode, op) ?				\
-		   (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : -ENXIO) : \
-	 -EINVAL)
+	(fwnode_has_op(fwnode, op) ?					\
+	 (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : (IS_ERR_OR_NULL(fwnode) ? -EINVAL : -ENXIO))
 
 #define fwnode_call_bool_op(fwnode, op, ...)		\
 	(fwnode_has_op(fwnode, op) ?			\
-- 
2.34.1

