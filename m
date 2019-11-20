Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA1103402
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2019 06:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfKTFrb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Nov 2019 00:47:31 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:36754 "EHLO
        smtp.aristanetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfKTFra (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Nov 2019 00:47:30 -0500
Received: from us180.sjc.aristanetworks.com (us180.sjc.aristanetworks.com [172.25.230.4])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 2227D401873;
        Tue, 19 Nov 2019 21:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1574228848;
        bh=HnAblu8XteAJ3r4y2QIMZ1i5loQSHWwegqcw/ObDqQs=;
        h=Date:To:Subject:From:From;
        b=DSly446P+JlKIJZJNcFcN/f+FLbZrABiGSn8rcfarxhAJme1D4ay1JWR5LAgzMoWF
         DNCEoApbSPWaq8ldEGGJJ7Sef8PyN94IhSZK9ApZ3b5OqadBB52MD/uom875SfNrbW
         V7lttkKFWevm1306y87HxaUDy7QEBfsAjWV4yBndXCp/mXSg4nabdrSoNLs2uvZ6Qb
         T8lIXXWUUIgmT8SODVAubKrx7L5QQqGokAg821MtcGMxubjIfA4L7HFT2qUPkGxLq+
         iVDuuyBk5s8qR+quqQ2Ub1bW2fGFIgKTP4WH6ElBQSdg2Sm7wHU03MZ7HcU0S+Qc6U
         BG6k984r5vZxA==
Received: by us180.sjc.aristanetworks.com (Postfix, from userid 10189)
        id 0979695C0FE4; Tue, 19 Nov 2019 21:47:27 -0800 (PST)
Date:   Tue, 19 Nov 2019 21:47:27 -0800
To:     lenb@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, fruggeri@arista.com
Subject: [PATCH] ACPI: only free map once in osl.c
User-Agent: Heirloom mailx 12.5 7/5/10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20191120054728.0979695C0FE4@us180.sjc.aristanetworks.com>
From:   fruggeri@arista.com (Francesco Ruggeri)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_os_map_cleanup checks map->refcount outside of acpi_ioremap_lock
before freeing the map. This creates a race condition the can result
in the map being freed more than once.
A panic can be caused by running

for ((i=0; i<10; i++))
do
        for ((j=0; j<100000; j++))
        do
                cat /sys/firmware/acpi/tables/data/BERT >/dev/null
        done &
done

This patch makes sure that only the process that drops the reference
to 0 does the freeing.

Fixes: b7c1fadd6c2e ("ACPI: Do not use krefs under a mutex in osl.c")
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
---
 drivers/acpi/osl.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index a2e844a8e9ed..41168c027a5a 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -374,19 +374,21 @@ void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 }
 EXPORT_SYMBOL_GPL(acpi_os_map_memory);
 
-static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
+/* Must be called with mutex_lock(&acpi_ioremap_lock) */
+static unsigned long acpi_os_drop_map_ref(struct acpi_ioremap *map)
 {
-	if (!--map->refcount)
+	unsigned long refcount = --map->refcount;
+
+	if (!refcount)
 		list_del_rcu(&map->list);
+	return refcount;
 }
 
 static void acpi_os_map_cleanup(struct acpi_ioremap *map)
 {
-	if (!map->refcount) {
-		synchronize_rcu_expedited();
-		acpi_unmap(map->phys, map->virt);
-		kfree(map);
-	}
+	synchronize_rcu_expedited();
+	acpi_unmap(map->phys, map->virt);
+	kfree(map);
 }
 
 /**
@@ -406,6 +408,7 @@ static void acpi_os_map_cleanup(struct acpi_ioremap *map)
 void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
+	unsigned long refcount;
 
 	if (!acpi_permanent_mmap) {
 		__acpi_unmap_table(virt, size);
@@ -419,10 +422,11 @@ void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
 		WARN(true, PREFIX "%s: bad address %p\n", __func__, virt);
 		return;
 	}
-	acpi_os_drop_map_ref(map);
+	refcount = acpi_os_drop_map_ref(map);
 	mutex_unlock(&acpi_ioremap_lock);
 
-	acpi_os_map_cleanup(map);
+	if (!refcount)
+		acpi_os_map_cleanup(map);
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_iomem);
 
@@ -457,6 +461,7 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
 {
 	u64 addr;
 	struct acpi_ioremap *map;
+	unsigned long refcount;
 
 	if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		return;
@@ -472,10 +477,11 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
 		mutex_unlock(&acpi_ioremap_lock);
 		return;
 	}
-	acpi_os_drop_map_ref(map);
+	refcount = acpi_os_drop_map_ref(map);
 	mutex_unlock(&acpi_ioremap_lock);
 
-	acpi_os_map_cleanup(map);
+	if (!refcount)
+		acpi_os_map_cleanup(map);
 }
 EXPORT_SYMBOL(acpi_os_unmap_generic_address);
 
-- 
2.19.1


