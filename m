Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812E8472A34
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Dec 2021 11:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbhLMKe1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Dec 2021 05:34:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:51780 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238817AbhLMKdu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Dec 2021 05:33:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="238930055"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="238930055"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 02:32:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="660821548"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2021 02:32:49 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] usb: Remove usb_for_each_port()
Date:   Mon, 13 Dec 2021 13:32:43 +0300
Message-Id: <20211213103243.33657-6-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211213103243.33657-1-heikki.krogerus@linux.intel.com>
References: <20211213103243.33657-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There are no more users for the function.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/core/usb.c | 46 ------------------------------------------
 include/linux/usb.h    |  9 ---------
 2 files changed, 55 deletions(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 62368c4ed37af..2ce3667ec6fae 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -398,52 +398,6 @@ int usb_for_each_dev(void *data, int (*fn)(struct usb_device *, void *))
 }
 EXPORT_SYMBOL_GPL(usb_for_each_dev);
 
-struct each_hub_arg {
-	void *data;
-	int (*fn)(struct device *, void *);
-};
-
-static int __each_hub(struct usb_device *hdev, void *data)
-{
-	struct each_hub_arg *arg = (struct each_hub_arg *)data;
-	struct usb_hub *hub;
-	int ret = 0;
-	int i;
-
-	hub = usb_hub_to_struct_hub(hdev);
-	if (!hub)
-		return 0;
-
-	mutex_lock(&usb_port_peer_mutex);
-
-	for (i = 0; i < hdev->maxchild; i++) {
-		ret = arg->fn(&hub->ports[i]->dev, arg->data);
-		if (ret)
-			break;
-	}
-
-	mutex_unlock(&usb_port_peer_mutex);
-
-	return ret;
-}
-
-/**
- * usb_for_each_port - interate over all USB ports in the system
- * @data: data pointer that will be handed to the callback function
- * @fn: callback function to be called for each USB port
- *
- * Iterate over all USB ports and call @fn for each, passing it @data. If it
- * returns anything other than 0, we break the iteration prematurely and return
- * that value.
- */
-int usb_for_each_port(void *data, int (*fn)(struct device *, void *))
-{
-	struct each_hub_arg arg = {data, fn};
-
-	return usb_for_each_dev(&arg, __each_hub);
-}
-EXPORT_SYMBOL_GPL(usb_for_each_port);
-
 /**
  * usb_release_dev - free a usb device structure when all users of it are finished.
  * @dev: device that's been disconnected
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 7ccaa76a9a968..200b7b79acb56 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -875,15 +875,6 @@ extern struct usb_host_interface *usb_find_alt_setting(
 		unsigned int iface_num,
 		unsigned int alt_num);
 
-#if IS_REACHABLE(CONFIG_USB)
-int usb_for_each_port(void *data, int (*fn)(struct device *, void *));
-#else
-static inline int usb_for_each_port(void *data, int (*fn)(struct device *, void *))
-{
-	return 0;
-}
-#endif
-
 /* port claiming functions */
 int usb_hub_claim_port(struct usb_device *hdev, unsigned port1,
 		struct usb_dev_state *owner);
-- 
2.33.0

