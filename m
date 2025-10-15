Return-Path: <linux-acpi+bounces-17805-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21239BDFA85
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Oct 2025 18:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A8004EA05C
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Oct 2025 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D353337694;
	Wed, 15 Oct 2025 16:30:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D389337687;
	Wed, 15 Oct 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545801; cv=none; b=G5CqGbIpE6YVT0Np6ORh1yHnYsCuTGrPjpDajtvc/hUusP0K2AmFHZtrnz4NSeDkftkZxCb0+t36eN7KUUyzslWVYjdjVfmTK+mdSfVwNYnrW8OrtNEa9ZqksGrOM7VaXoMBxZwNAMQuZVcjoo6q4fhVGRBzADa5NtrL0n7bT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545801; c=relaxed/simple;
	bh=GSXFtKanFdfOYZRoTNdsC3B5KrAnQuXQgV+M8GSSD0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S22gZmgZBVRvAb1RXs14UIUnbnUttg+3xe5iYHhGd6PCiv97oLSD4Ps4xrfkf8456f3AX7COs4FyoewXpL0h6bicDBbok9ujg1qjgJmWfo0nX65zhGYJhVgT02KiFVPEOIi/P7C6k8ghdwMdPWiXqUorBMjBLCra40i5XvqExBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D05C4CEF8;
	Wed, 15 Oct 2025 16:30:00 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	rafael@kernel.org
Subject: [PATCH v2] acpi/hmat: Fix lockdep warning for hmem_register_resource()
Date: Wed, 15 Oct 2025 09:29:57 -0700
Message-ID: <20251015162958.11249-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
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

Remove registering of target devices from the hmat_callback(). By the
time the hmat hotplug notifier is being called, there should not be
hmem targets that still need to be registered.

Fixes: cf8741ac57ed ("ACPI: NUMA: HMAT: Register "soft reserved" memory as an "hmem" device")
Link: https://lore.kernel.org/nvdimm/68e46a09c2a07_2980100f3@dwillia2-mobl4.notmuch/
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Drop target registering in hmat_callback instead. (Dan)
---
 drivers/acpi/numa/hmat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 5a36d57289b4..5084ae1688f6 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -874,7 +874,8 @@ static void hmat_register_target_devices(struct memory_target *target)
 	}
 }
 
-static void hmat_register_target(struct memory_target *target)
+static void hmat_register_target(struct memory_target *target,
+				 bool register_devices)
 {
 	int nid = pxm_to_node(target->memory_pxm);
 
@@ -882,7 +883,8 @@ static void hmat_register_target(struct memory_target *target)
 	 * Devices may belong to either an offline or online
 	 * node, so unconditionally add them.
 	 */
-	hmat_register_target_devices(target);
+	if (register_devices)
+		hmat_register_target_devices(target);
 
 	/*
 	 * Register generic port perf numbers. The nid may not be
@@ -921,7 +923,7 @@ static void hmat_register_targets(void)
 	struct memory_target *target;
 
 	list_for_each_entry(target, &targets, node)
-		hmat_register_target(target);
+		hmat_register_target(target, true);
 }
 
 static int hmat_callback(struct notifier_block *self,
@@ -939,7 +941,7 @@ static int hmat_callback(struct notifier_block *self,
 	if (!target)
 		return NOTIFY_OK;
 
-	hmat_register_target(target);
+	hmat_register_target(target, false);
 	return NOTIFY_OK;
 }
 

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.0


