Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79613B1AE3
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jun 2021 15:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFWNQY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Jun 2021 09:16:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:27317 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231129AbhFWNQT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Jun 2021 09:16:19 -0400
IronPort-SDR: 2jcJcCp9hNhpkEiFztnnVl0bkV0RwiSDUdpfdnxjX3BKvH8NYzyEFiMddq3q9UdbpCM1eDzTus
 MlynW5LVJ++g==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="194398139"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="194398139"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 06:13:58 -0700
IronPort-SDR: UyzkES5Cdzl1/1lnLeF5ZRRPo1GAM47RpKllxBgKOsqDm9pRq7ImQI2/MQ4FXxqxeGEXirDGdd
 4/EIl4XDvLoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="556964242"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jun 2021 06:13:56 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] software node: Handle software node injection to an existing device properly
Date:   Wed, 23 Jun 2021 16:14:21 +0300
Message-Id: <20210623131421.15159-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The function software_node_notify() - the function that creates
and removes the symlinks between the node and the device - was
called unconditionally in device_add_software_node() and
device_remove_software_node(), but it needs to be called in
those functions only in the special case where the node is
added to a device that has already been registered.

This fixes NULL pointer dereference that happens if
device_remove_software_node() is used with device that was
never registered.

Fixes: b622b24519f5 ("software node: Allow node addition to already existing device")
Reported-and-tested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 3cc11b813f28c..d1f1a82401207 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1045,7 +1045,15 @@ int device_add_software_node(struct device *dev, const struct software_node *nod
 	}
 
 	set_secondary_fwnode(dev, &swnode->fwnode);
-	software_node_notify(dev, KOBJ_ADD);
+
+	/*
+	 * If the device has been fully registered by the time this function is
+	 * called, software_node_notify() must be called separately so that the
+	 * symlinks get created and the reference count of the node is kept in
+	 * balance.
+	 */
+	if (device_is_registered(dev))
+		software_node_notify(dev, KOBJ_ADD);
 
 	return 0;
 }
@@ -1065,7 +1073,8 @@ void device_remove_software_node(struct device *dev)
 	if (!swnode)
 		return;
 
-	software_node_notify(dev, KOBJ_REMOVE);
+	if (device_is_registered(dev))
+		software_node_notify(dev, KOBJ_REMOVE);
 	set_secondary_fwnode(dev, NULL);
 	kobject_put(&swnode->kobj);
 }
@@ -1119,8 +1128,7 @@ int software_node_notify(struct device *dev, unsigned long action)
 
 	switch (action) {
 	case KOBJ_ADD:
-		ret = sysfs_create_link_nowarn(&dev->kobj, &swnode->kobj,
-					       "software_node");
+		ret = sysfs_create_link(&dev->kobj, &swnode->kobj, "software_node");
 		if (ret)
 			break;
 
-- 
2.30.2

