Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3E2444274
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 14:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhKCNg1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 09:36:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:37203 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231131AbhKCNg0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Nov 2021 09:36:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="231341668"
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="231341668"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 06:33:49 -0700
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="497592341"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 06:33:47 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 277CA207B6;
        Wed,  3 Nov 2021 15:33:45 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1miGP0-002lah-N3; Wed, 03 Nov 2021 15:34:06 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com
Subject: [PATCH 2/3] ACPI: Get acpi_device's parent from the parent field
Date:   Wed,  3 Nov 2021 15:34:05 +0200
Message-Id: <20211103133406.659542-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
References: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
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

Luckily struct acpi_device has a parent field already. Use that field to
get the parent instead of relying on acpi_get_parent().

Fixes: 002eb6ad0751 ("printk: track/limit recursion")
Cc: stable@vger.kernel.org # v5.15 and up
Depends-on: ("ACPI: Make acpi_fwnode_handle safer")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e312ebaed8db4..7403ee2816eb8 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1089,16 +1089,12 @@ struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode)
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
+		struct acpi_device *device = to_acpi_device_node(fwnode);
 
-			if (!acpi_bus_get_device(parent_handle, &adev))
-				return acpi_fwnode_handle(adev);
-		}
+		return acpi_fwnode_handle(device->parent);
 	}
 
 	return NULL;
-- 
2.30.2

