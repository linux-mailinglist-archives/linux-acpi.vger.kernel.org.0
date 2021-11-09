Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3599044AC75
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Nov 2021 12:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245675AbhKILWR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Nov 2021 06:22:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:59381 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245674AbhKILWQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Nov 2021 06:22:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="256106669"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="256106669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 03:19:28 -0800
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="451859128"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 03:19:26 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id D6C7F206C1;
        Tue,  9 Nov 2021 13:19:24 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1mkPA7-006pNL-Rx; Tue, 09 Nov 2021 13:19:35 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH 1/2] ACPI: Get acpi_device's parent from the parent field
Date:   Tue,  9 Nov 2021 13:19:34 +0200
Message-Id: <20211109111935.1627406-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109111935.1627406-1-sakari.ailus@linux.intel.com>
References: <20211109111935.1627406-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Printk modifier %pfw is used to print the full path of the device name.
This is obtained device by device until a device no longer has a parent.

On ACPI getting the parent fwnode is done by calling acpi_get_parent()
which tries to down() a semaphore. But local IRQs are now disabled in
vprintk_store() before the mutex is acquired. This is obviously a problem.

Luckily struct device, embedded in struct acpi_device, has a parent field
already. Use that field to get the parent instead of relying on
acpi_get_parent().

Fixes: 3bd32d6a2ee6 ("lib/vsprintf: Add %pfw conversion specifier for printing fwnode names")
Cc: stable@vger.kernel.org # v5.5+
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e312ebaed8db4..dc97711ba8081 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1089,16 +1089,14 @@ struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode)
 	if (is_acpi_data_node(fwnode)) {
 		/* All data nodes have parent pointer so just return that */
 		return to_acpi_data_node(fwnode)->parent;
-	} else if (is_acpi_device_node(fwnode)) {
-		acpi_handle handle, parent_handle;
+	}
 
-		handle = to_acpi_device_node(fwnode)->handle;
-		if (ACPI_SUCCESS(acpi_get_parent(handle, &parent_handle))) {
-			struct acpi_device *adev;
+	if (is_acpi_device_node(fwnode)) {
+		struct device *dev =
+			to_acpi_device_node(fwnode)->dev.parent;
 
-			if (!acpi_bus_get_device(parent_handle, &adev))
-				return acpi_fwnode_handle(adev);
-		}
+		if (dev)
+			return acpi_fwnode_handle(to_acpi_device(dev));
 	}
 
 	return NULL;
-- 
2.30.2

