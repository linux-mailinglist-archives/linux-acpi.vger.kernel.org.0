Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D436421230A
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Jul 2020 14:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgGBMRl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Jul 2020 08:17:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61654 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbgGBMRk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2020 08:17:40 -0400
Received: from 89-64-84-242.dynamic.chello.pl (89.64.84.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id f46b72aa3731b82c; Thu, 2 Jul 2020 14:17:38 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dan Williams <dan.j.williams.korg@gmail.com>
Subject: [PATCH 2/3] ACPI: OSL: Use deferred unmapping in acpi_os_unmap_iomem()
Date:   Thu, 02 Jul 2020 14:13:46 +0200
Message-ID: <2719764.LIfMOkZlBL@kreacher>
In-Reply-To: <22474080.3crLlKV2y5@kreacher>
References: <22474080.3crLlKV2y5@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

There is no reason (knwon to me) why any of the existing users of
acpi_os_unmap_iomem() would need to wait for the unused memory
mappings left by it to actually go away, so use the deferred
unmapping of ACPI memory introduced previously in that function.

While at it, fold __acpi_os_unmap_iomem() back into
acpi_os_unmap_iomem(), which has become a simple wrapper around it,
and make acpi_os_unmap_memory() call the latter.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c | 72 ++++++++++++++--------------------------------
 1 file changed, 22 insertions(+), 50 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5c56f084e8b0..816d9f8ac6b6 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -390,31 +390,32 @@ static void acpi_os_map_cleanup_deferred(struct work_struct *work)
 }
 
 /* Must be called with mutex_lock(&acpi_ioremap_lock) */
-static bool acpi_os_drop_map_ref(struct acpi_ioremap *map, bool defer)
+static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
 {
 	if (--map->track.refcount)
-		return true;
+		return;
 
 	list_del_rcu(&map->list);
 
-	if (defer) {
-		INIT_RCU_WORK(&map->track.rwork, acpi_os_map_cleanup_deferred);
-		queue_rcu_work(system_wq, &map->track.rwork);
-	}
-	return defer;
-}
-
-static void acpi_os_map_cleanup(struct acpi_ioremap *map)
-{
-	if (!map)
-		return;
-
-	synchronize_rcu_expedited();
-	acpi_os_map_remove(map);
+	INIT_RCU_WORK(&map->track.rwork, acpi_os_map_cleanup_deferred);
+	queue_rcu_work(system_wq, &map->track.rwork);
 }
 
-static void __ref __acpi_os_unmap_iomem(void __iomem *virt, acpi_size size,
-					bool defer)
+/**
+ * acpi_os_unmap_iomem - Drop a memory mapping reference.
+ * @virt: Start of the address range to drop a reference to.
+ * @size: Size of the address range to drop a reference to.
+ *
+ * Look up the given virtual address range in the list of existing ACPI memory
+ * mappings, drop a reference to it and if there are no more active references
+ * to it, queue it up for later removal.
+ *
+ * During early init (when acpi_permanent_mmap has not been set yet) this
+ * routine simply calls __acpi_unmap_table() to get the job done.  Since
+ * __acpi_unmap_table() is an __init function, the __ref annotation is needed
+ * here.
+ */
+void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
 
@@ -431,31 +432,9 @@ static void __ref __acpi_os_unmap_iomem(void __iomem *virt, acpi_size size,
 		WARN(true, PREFIX "%s: bad address %p\n", __func__, virt);
 		return;
 	}
-	if (acpi_os_drop_map_ref(map, defer))
-		map = NULL;
+	acpi_os_drop_map_ref(map);
 
 	mutex_unlock(&acpi_ioremap_lock);
-
-	acpi_os_map_cleanup(map);
-}
-
-/**
- * acpi_os_unmap_iomem - Drop a memory mapping reference.
- * @virt: Start of the address range to drop a reference to.
- * @size: Size of the address range to drop a reference to.
- *
- * Look up the given virtual address range in the list of existing ACPI memory
- * mappings, drop a reference to it and unmap it if there are no more active
- * references to it.
- *
- * During early init (when acpi_permanent_mmap has not been set yet) this
- * routine simply calls __acpi_unmap_table() to get the job done.  Since
- * __acpi_unmap_table() is an __init function, the __ref annotation is needed
- * here.
- */
-void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
-{
-	__acpi_os_unmap_iomem(virt, size, false);
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_iomem);
 
@@ -463,17 +442,10 @@ EXPORT_SYMBOL_GPL(acpi_os_unmap_iomem);
  * acpi_os_unmap_memory - Drop a memory mapping reference.
  * @virt: Start of the address range to drop a reference to.
  * @size: Size of the address range to drop a reference to.
- *
- * Look up the given virtual address range in the list of existing ACPI memory
- * mappings, drop a reference to it and if there are no more active references
- * to it, queue it up for later removal.
- *
- * During early init (when acpi_permanent_mmap has not been set yet) this
- * routine behaves like acpi_os_unmap_iomem().
  */
 void __ref acpi_os_unmap_memory(void *virt, acpi_size size)
 {
-	__acpi_os_unmap_iomem((void __iomem *)virt, size, true);
+	acpi_os_unmap_iomem((void __iomem *)virt, size);
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
 
@@ -518,7 +490,7 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
 		mutex_unlock(&acpi_ioremap_lock);
 		return;
 	}
-	acpi_os_drop_map_ref(map, true);
+	acpi_os_drop_map_ref(map);
 
 	mutex_unlock(&acpi_ioremap_lock);
 }
-- 
2.26.2




