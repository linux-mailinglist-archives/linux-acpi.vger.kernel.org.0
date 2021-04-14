Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9397C35EED8
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Apr 2021 10:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhDNHyo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Apr 2021 03:54:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:14888 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231773AbhDNHyo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Apr 2021 03:54:44 -0400
IronPort-SDR: 4ATP3Qw3fKUM3dXekhWRU+yt9osC1Wq4EPkMuwNWhQY3V83ToxX5xEWzEMlza9C1McIr0j/lvz
 zNCyarmgXvsg==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="192464777"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="192464777"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 00:54:23 -0700
IronPort-SDR: 5bmzrv8VKf7pRh8hYbaN4SopfadCf6F+GYPl3OPs1BMJVECIQpZ0GkQDBwbLr7leGovQjFwi+t
 W+ga6pAX5Kbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="521905132"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Apr 2021 00:54:21 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] software node: Allow node addition to already existing device
Date:   Wed, 14 Apr 2021 10:54:38 +0300
Message-Id: <20210414075438.64547-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If the node is added to an already exiting device, the node
needs to be also linked to the device separately.

This will make sure the reference count is kept in balance
also when the node is injected to a device afterwards.

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Fixes: e68d0119e328 ("software node: Introduce device_add_software_node()")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 740333629b420..3cc11b813f28c 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1045,6 +1045,7 @@ int device_add_software_node(struct device *dev, const struct software_node *nod
 	}
 
 	set_secondary_fwnode(dev, &swnode->fwnode);
+	software_node_notify(dev, KOBJ_ADD);
 
 	return 0;
 }
@@ -1118,8 +1119,8 @@ int software_node_notify(struct device *dev, unsigned long action)
 
 	switch (action) {
 	case KOBJ_ADD:
-		ret = sysfs_create_link(&dev->kobj, &swnode->kobj,
-					"software_node");
+		ret = sysfs_create_link_nowarn(&dev->kobj, &swnode->kobj,
+					       "software_node");
 		if (ret)
 			break;
 
-- 
2.30.2

