Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA23212308
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Jul 2020 14:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgGBMRk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Jul 2020 08:17:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51610 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgGBMRj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2020 08:17:39 -0400
Received: from 89-64-84-242.dynamic.chello.pl (89.64.84.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 6d37b7b0716e4b45; Thu, 2 Jul 2020 14:17:37 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dan Williams <dan.j.williams.korg@gmail.com>
Subject: [PATCH 3/3] ACPI: OSL: Clean up the removal of unused memory mappings
Date:   Thu, 02 Jul 2020 14:14:05 +0200
Message-ID: <3982287.opqQOJBojm@kreacher>
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

Fold acpi_os_map_cleanup_deferred() into acpi_os_map_remove() and
pass the latter to INIT_RCU_WORK() in acpi_os_drop_map_ref() to make
the code more straightforward.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 816d9f8ac6b6..6ad8cb05f672 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -377,18 +377,16 @@ void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 }
 EXPORT_SYMBOL_GPL(acpi_os_map_memory);
 
-static void acpi_os_map_remove(struct acpi_ioremap *map)
+static void acpi_os_map_remove(struct work_struct *work)
 {
+	struct acpi_ioremap *map = container_of(to_rcu_work(work),
+						struct acpi_ioremap,
+						track.rwork);
+
 	acpi_unmap(map->phys, map->virt);
 	kfree(map);
 }
 
-static void acpi_os_map_cleanup_deferred(struct work_struct *work)
-{
-	acpi_os_map_remove(container_of(to_rcu_work(work), struct acpi_ioremap,
-					track.rwork));
-}
-
 /* Must be called with mutex_lock(&acpi_ioremap_lock) */
 static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
 {
@@ -397,7 +395,7 @@ static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
 
 	list_del_rcu(&map->list);
 
-	INIT_RCU_WORK(&map->track.rwork, acpi_os_map_cleanup_deferred);
+	INIT_RCU_WORK(&map->track.rwork, acpi_os_map_remove);
 	queue_rcu_work(system_wq, &map->track.rwork);
 }
 
-- 
2.26.2




