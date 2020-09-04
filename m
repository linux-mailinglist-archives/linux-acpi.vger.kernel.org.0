Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E3825D8FA
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 14:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgIDMvr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 08:51:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:65322 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730249AbgIDMva (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 08:51:30 -0400
IronPort-SDR: wEbqVZ8eufwrvzEBhRGC45PeflJRM0Ey/PPWJXoRBbH5z2BPMSYVjTepBEQDScniqGsz9UvqvJ
 hgz3T3ZnZo9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="221944956"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="221944956"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 05:51:29 -0700
IronPort-SDR: itmLEUQGXFFs1O8DJSVvLTtjYjRie5A0pPdImpIQfVTtSStr5EsZJUrjIMd5QeYKWIIyWudv4R
 nbT70B5iCtwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="405834945"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2020 05:51:28 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 2/4] device connection: Remove device_connection_add()
Date:   Fri,  4 Sep 2020 15:51:21 +0300
Message-Id: <20200904125123.83725-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904125123.83725-1-heikki.krogerus@linux.intel.com>
References: <20200904125123.83725-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

All the users of that API have now been converted to use
software fwnodes instead.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/devcon.c  | 59 +-----------------------------------------
 include/linux/device.h | 29 ---------------------
 2 files changed, 1 insertion(+), 87 deletions(-)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 51ad546303ddb..94ab22a451ce3 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -9,9 +9,6 @@
 #include <linux/device.h>
 #include <linux/property.h>
 
-static DEFINE_MUTEX(devcon_lock);
-static LIST_HEAD(devcon_list);
-
 static void *
 fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 			  void *data, devcon_match_fn_t match)
@@ -99,60 +96,6 @@ EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
 void *device_connection_find_match(struct device *dev, const char *con_id,
 				   void *data, devcon_match_fn_t match)
 {
-	struct fwnode_handle *fwnode = dev_fwnode(dev);
-	const char *devname = dev_name(dev);
-	struct device_connection *con;
-	void *ret = NULL;
-	int ep;
-
-	if (!match)
-		return NULL;
-
-	ret = fwnode_connection_find_match(fwnode, con_id, data, match);
-	if (ret)
-		return ret;
-
-	mutex_lock(&devcon_lock);
-
-	list_for_each_entry(con, &devcon_list, list) {
-		ep = match_string(con->endpoint, 2, devname);
-		if (ep < 0)
-			continue;
-
-		if (con_id && strcmp(con->id, con_id))
-			continue;
-
-		ret = match(con, !ep, data);
-		if (ret)
-			break;
-	}
-
-	mutex_unlock(&devcon_lock);
-
-	return ret;
+	return fwnode_connection_find_match(dev_fwnode(dev), con_id, data, match);
 }
 EXPORT_SYMBOL_GPL(device_connection_find_match);
-
-/**
- * device_connection_add - Register a connection description
- * @con: The connection description to be registered
- */
-void device_connection_add(struct device_connection *con)
-{
-	mutex_lock(&devcon_lock);
-	list_add_tail(&con->list, &devcon_list);
-	mutex_unlock(&devcon_lock);
-}
-EXPORT_SYMBOL_GPL(device_connection_add);
-
-/**
- * device_connections_remove - Unregister connection description
- * @con: The connection description to be unregistered
- */
-void device_connection_remove(struct device_connection *con)
-{
-	mutex_lock(&devcon_lock);
-	list_del(&con->list);
-	mutex_unlock(&devcon_lock);
-}
-EXPORT_SYMBOL_GPL(device_connection_remove);
diff --git a/include/linux/device.h b/include/linux/device.h
index 4a98cd2d442c7..43569297c6cc1 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -297,7 +297,6 @@ struct device_dma_parameters {
  * @fwnode: The device node of the connected device
  * @endpoint: The names of the two devices connected together
  * @id: Unique identifier for the connection
- * @list: List head, private, for internal use only
  *
  * NOTE: @fwnode is not used together with @endpoint. @fwnode is used when
  * platform firmware defines the connection. When the connection is registered
@@ -307,7 +306,6 @@ struct device_connection {
 	struct fwnode_handle	*fwnode;
 	const char		*endpoint[2];
 	const char		*id;
-	struct list_head	list;
 };
 
 typedef void *(*devcon_match_fn_t)(struct device_connection *con, int ep,
@@ -319,33 +317,6 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
 void *device_connection_find_match(struct device *dev, const char *con_id,
 				   void *data, devcon_match_fn_t match);
 
-void device_connection_add(struct device_connection *con);
-void device_connection_remove(struct device_connection *con);
-
-/**
- * device_connections_add - Add multiple device connections at once
- * @cons: Zero terminated array of device connection descriptors
- */
-static inline void device_connections_add(struct device_connection *cons)
-{
-	struct device_connection *c;
-
-	for (c = cons; c->endpoint[0]; c++)
-		device_connection_add(c);
-}
-
-/**
- * device_connections_remove - Remove multiple device connections at once
- * @cons: Zero terminated array of device connection descriptors
- */
-static inline void device_connections_remove(struct device_connection *cons)
-{
-	struct device_connection *c;
-
-	for (c = cons; c->endpoint[0]; c++)
-		device_connection_remove(c);
-}
-
 /**
  * enum device_link_state - Device link states.
  * @DL_STATE_NONE: The presence of the drivers is not being tracked.
-- 
2.28.0

