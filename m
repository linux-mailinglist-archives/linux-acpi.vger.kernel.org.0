Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D7A342616
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 20:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhCSTVV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 15:21:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:2873 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhCSTVB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Mar 2021 15:21:01 -0400
IronPort-SDR: ibulpKb3GIABbS7Bi7KocR95cMsk4LCL3GlUvOZCIhowqciLSOHe/my0bMVV3BiCv/zO8gi7DP
 4WRQBdWL8NrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="169890025"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="169890025"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 12:21:01 -0700
IronPort-SDR: C2yXUxqRIaOrkHdD4Y2mAMHnvSS/IdeN7r49FsurlKHTTqYAV11IgHbNZhpOne485s2bsoAufW
 ivkncICxRgCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="523742703"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 19 Mar 2021 12:20:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6082B78; Fri, 19 Mar 2021 21:21:11 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/1] ACPI: scan: Use unique number for instance_no
Date:   Fri, 19 Mar 2021 21:21:09 +0200
Message-Id: <20210319192109.40041-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The decrementation of acpi_device_bus_id->instance_no
in acpi_device_del() is incorrect, because it may cause
a duplicate instance number to be allocated next time
a device with the same acpi_device_bus_id is added.

Replace above mentioned approach by using IDA framework.

Fixes: e49bd2dd5a50 ("ACPI: use PNPID:instance_no as bus_id of ACPI device")
Fixes: ca9dc8d42b30 ("ACPI / scan: Fix acpi_bus_id_list bookkeeping")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: rewrote commit message once again as proposed by Rafael in v1
 drivers/acpi/internal.h |  4 +++-
 drivers/acpi/scan.c     | 32 +++++++++++++++++++++++++++-----
 include/acpi/acpi_bus.h |  1 +
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index e6a5d997241c..417eb768d710 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -9,6 +9,8 @@
 #ifndef _ACPI_INTERNAL_H_
 #define _ACPI_INTERNAL_H_
 
+#include <linux/idr.h>
+
 #define PREFIX "ACPI: "
 
 int early_acpi_osi_init(void);
@@ -98,7 +100,7 @@ extern struct list_head acpi_bus_id_list;
 
 struct acpi_device_bus_id {
 	const char *bus_id;
-	unsigned int instance_no;
+	struct ida instance_ida;
 	struct list_head node;
 };
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a184529d8fa4..4b445b169ad4 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -479,9 +479,8 @@ static void acpi_device_del(struct acpi_device *device)
 	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node)
 		if (!strcmp(acpi_device_bus_id->bus_id,
 			    acpi_device_hid(device))) {
-			if (acpi_device_bus_id->instance_no > 0)
-				acpi_device_bus_id->instance_no--;
-			else {
+			ida_simple_remove(&acpi_device_bus_id->instance_ida, device->pnp.instance_no);
+			if (ida_is_empty(&acpi_device_bus_id->instance_ida)) {
 				list_del(&acpi_device_bus_id->node);
 				kfree_const(acpi_device_bus_id->bus_id);
 				kfree(acpi_device_bus_id);
@@ -631,6 +630,20 @@ static struct acpi_device_bus_id *acpi_device_bus_id_match(const char *dev_id)
 	return NULL;
 }
 
+static int acpi_device_set_name(struct acpi_device *device,
+				struct acpi_device_bus_id *acpi_device_bus_id)
+{
+	int result;
+
+	result = ida_simple_get(&acpi_device_bus_id->instance_ida, 0, 255, GFP_KERNEL);
+	if (result < 0)
+		return result;
+
+	device->pnp.instance_no = result;
+	dev_set_name(&device->dev, "%s:%02x", acpi_device_bus_id->bus_id, result);
+	return 0;
+}
+
 int acpi_device_add(struct acpi_device *device,
 		    void (*release)(struct device *))
 {
@@ -665,7 +678,9 @@ int acpi_device_add(struct acpi_device *device,
 
 	acpi_device_bus_id = acpi_device_bus_id_match(acpi_device_hid(device));
 	if (acpi_device_bus_id) {
-		acpi_device_bus_id->instance_no++;
+		result = acpi_device_set_name(device, acpi_device_bus_id);
+		if (result)
+			goto err_unlock;
 	} else {
 		acpi_device_bus_id = kzalloc(sizeof(*acpi_device_bus_id),
 					     GFP_KERNEL);
@@ -681,9 +696,16 @@ int acpi_device_add(struct acpi_device *device,
 			goto err_unlock;
 		}
 
+		ida_init(&acpi_device_bus_id->instance_ida);
+
+		result = acpi_device_set_name(device, acpi_device_bus_id);
+		if (result) {
+			kfree(acpi_device_bus_id);
+			goto err_unlock;
+		}
+
 		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
 	}
-	dev_set_name(&device->dev, "%s:%02x", acpi_device_bus_id->bus_id, acpi_device_bus_id->instance_no);
 
 	if (device->parent)
 		list_add_tail(&device->node, &device->parent->children);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 02a716a0af5d..f28b097c658f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -233,6 +233,7 @@ struct acpi_pnp_type {
 
 struct acpi_device_pnp {
 	acpi_bus_id bus_id;		/* Object name */
+	int instance_no;		/* Instance number of this object */
 	struct acpi_pnp_type type;	/* ID type */
 	acpi_bus_address bus_address;	/* _ADR */
 	char *unique_id;		/* _UID */
-- 
2.30.2

