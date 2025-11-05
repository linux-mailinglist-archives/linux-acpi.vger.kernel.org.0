Return-Path: <linux-acpi+bounces-18561-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1430EC3867C
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 00:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1EE3B49B8
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 23:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B9A2F3C09;
	Wed,  5 Nov 2025 23:48:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CCB2D248B;
	Wed,  5 Nov 2025 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386538; cv=none; b=PwNhs2QM5ZH5L8G8WinvMnAwk+lUAFWBQG/dXcxQvjcLZpzbXoEowxM9Z+TI2dQ8qOd0IGrnCWZSSQji4ZY4iKuuWYAgkClHGbe3icvDLxh6tda5anlEwZOR0aUZxhwmTXFO44hX3iLdpnwSpwp/2Zaqpx6oRhfx7eR0tPfcHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386538; c=relaxed/simple;
	bh=N57gavoaSd+CKGN5SfMIuLTbn6yGcxKp9axP+lNGvfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzHSoFrUQshapKeIziD9BdJEAJPa/rBA+6C1gcOdPaNByiojW96M5Uzm2kEaMnjH6kYIc5zOyG2Y11gD7uA20AjJ8aF9R3KKoVm6f1ZJ4IzXXK4H8HzKhWImDVW2bIWXm2OsZicGMTKTEirY9sntkEytyk4Cj1uyCnqommetY60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E609C4CEF5;
	Wed,  5 Nov 2025 23:48:57 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	rafael@kernel.org
Subject: [PATCH v3 2/2] acpi/hmat: Fix lockdep warning for hmem_register_resource()
Date: Wed,  5 Nov 2025 16:48:48 -0700
Message-ID: <20251105234851.81589-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105234851.81589-1-dave.jiang@intel.com>
References: <20251105234851.81589-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following lockdep splat was observed while kernel auto-online a CXL
memory region:

======================================================
WARNING: possible circular locking dependency detected
6.17.0djtest+ #53 Tainted: G        W
------------------------------------------------------
systemd-udevd/3334 is trying to acquire lock:
ffffffff90346188 (hmem_resource_lock){+.+.}-{4:4}, at: hmem_register_resource+0x31/0x50

but task is already holding lock:
ffffffff90338890 ((node_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x2e/0x70

which lock already depends on the new lock.
[..]
Chain exists of:
  hmem_resource_lock --> mem_hotplug_lock --> (node_chain).rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock((node_chain).rwsem);
                               lock(mem_hotplug_lock);
                               lock((node_chain).rwsem);
  lock(hmem_resource_lock);

The lock ordering can cause potential deadlock. There are instances
where hmem_resource_lock is taken after (node_chain).rwsem, and vice
versa.

Split out the target update section of hmat_register_target() so that
hmat_callback() only envokes that section instead of attempt to register
hmem devices that it does not need to.

Fixes: cf8741ac57ed ("ACPI: NUMA: HMAT: Register "soft reserved" memory as a
n "hmem" device")
notmuch/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Refactor to split out target device setup vs target update (Dan)
---
 drivers/acpi/numa/hmat.c | 48 ++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 1dc73d20d989..ddbdd32e79a8 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -874,28 +874,10 @@ static void hmat_register_target_devices(struct memory_target *target)
 	}
 }
 
-static void hmat_register_target(struct memory_target *target)
+static void hmat_hotplug_target(struct memory_target *target)
 {
 	int nid = pxm_to_node(target->memory_pxm);
 
-	/*
-	 * Devices may belong to either an offline or online
-	 * node, so unconditionally add them.
-	 */
-	hmat_register_target_devices(target);
-
-	/*
-	 * Register generic port perf numbers. The nid may not be
-	 * initialized and is still NUMA_NO_NODE.
-	 */
-	scoped_guard(mutex, &target_lock) {
-		if (*(u16 *)target->gen_port_device_handle) {
-			hmat_update_generic_target(target);
-			target->registered = true;
-			return;
-		}
-	}
-
 	/*
 	 * Skip offline nodes. This can happen when memory
 	 * marked EFI_MEMORY_SP, "specific purpose", is applied
@@ -906,7 +888,7 @@ static void hmat_register_target(struct memory_target *target)
 	if (nid == NUMA_NO_NODE || !node_online(nid))
 		return;
 
-	mutex_lock(&target_lock);
+	guard(mutex)(&target_lock);
 	if (!target->registered) {
 		hmat_register_target_initiators(target);
 		hmat_register_target_cache(target);
@@ -914,7 +896,29 @@ static void hmat_register_target(struct memory_target *target)
 		hmat_register_target_perf(target, ACCESS_COORDINATE_CPU);
 		target->registered = true;
 	}
-	mutex_unlock(&target_lock);
+}
+
+static void hmat_register_target(struct memory_target *target)
+{
+	/*
+	 * Devices may belong to either an offline or online
+	 * node, so unconditionally add them.
+	 */
+	hmat_register_target_devices(target);
+
+	/*
+	 * Register generic port perf numbers. The nid may not be
+	 * initialized and is still NUMA_NO_NODE.
+	 */
+	scoped_guard(mutex, &target_lock) {
+		if (*(u16 *)target->gen_port_device_handle) {
+			hmat_update_generic_target(target);
+			target->registered = true;
+			return;
+		}
+	}
+
+	hmat_hotplug_target(target);
 }
 
 static void hmat_register_targets(void)
@@ -940,7 +944,7 @@ static int hmat_callback(struct notifier_block *self,
 	if (!target)
 		return NOTIFY_OK;
 
-	hmat_register_target(target);
+	hmat_hotplug_target(target);
 	return NOTIFY_OK;
 }
 
-- 
2.51.0


