Return-Path: <linux-acpi+bounces-18567-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66143C3869D
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 00:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04851A222C9
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 23:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0622F60A7;
	Wed,  5 Nov 2025 23:51:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4ED2F3C3E;
	Wed,  5 Nov 2025 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386680; cv=none; b=OA31D3vVLEBO7jZt5iNhauhqIYPp5comcWSaSJHsMdAdNWrGHq0vnO1bai2m9KeUjSq7ikaLQZNBOKYWrpIpAG0TD1Z/IxmSXDMEH3fegNSXohXsFEBBMYAYN4RP6DIzcjS/fyDUlBj6S9KGUXRcpV6N5jLCgCTO3ln53WKBXnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386680; c=relaxed/simple;
	bh=2LM8SY3cqjZrEBYQzbkSKLgYyJ2VgvVpuRCKNzYVqfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0/BDAXJvMjaGYEzWLk5WPJQpu7qfNj3n8oHjsz+IyVEJaAIil022zkR9ujohtywpSomnr4kMmMBpQ8ppwjqljNIEcBS4qd1JQPLyDdZNLVSO5OKrbgozJpPEdX5V1vgEmC+lQSZ8y5cVvvpdk5N9Frn6N0zqQSLrualxCspG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EAEC4CEF5;
	Wed,  5 Nov 2025 23:51:19 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	rafael@kernel.org
Subject: [RESEND PATCH v4 2/2] acpi/hmat: Fix lockdep warning for hmem_register_resource()
Date: Wed,  5 Nov 2025 16:51:15 -0700
Message-ID: <20251105235115.85062-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105235115.85062-1-dave.jiang@intel.com>
References: <20251105235115.85062-1-dave.jiang@intel.com>
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

Fixes: cf8741ac57ed ("ACPI: NUMA: HMAT: Register "soft reserved" memory as an "hmem" device")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Fix fixes tag. (Jonathan)
- Refactor hmat_hotplug_target(). (Jonathan)
---
 drivers/acpi/numa/hmat.c | 47 ++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 1dc73d20d989..d10cbe93c3a7 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -874,10 +874,33 @@ static void hmat_register_target_devices(struct memory_target *target)
 	}
 }
 
-static void hmat_register_target(struct memory_target *target)
+static void hmat_hotplug_target(struct memory_target *target)
 {
 	int nid = pxm_to_node(target->memory_pxm);
 
+	/*
+	 * Skip offline nodes. This can happen when memory
+	 * marked EFI_MEMORY_SP, "specific purpose", is applied
+	 * to all the memory in a proximity domain leading to
+	 * the node being marked offline / unplugged, or if
+	 * memory-only "hotplug" node is offline.
+	 */
+	if (nid == NUMA_NO_NODE || !node_online(nid))
+		return;
+
+	guard(mutex)(&target_lock);
+	if (target->registered)
+		return;
+
+	hmat_register_target_initiators(target);
+	hmat_register_target_cache(target);
+	hmat_register_target_perf(target, ACCESS_COORDINATE_LOCAL);
+	hmat_register_target_perf(target, ACCESS_COORDINATE_CPU);
+	target->registered = true;
+}
+
+static void hmat_register_target(struct memory_target *target)
+{
 	/*
 	 * Devices may belong to either an offline or online
 	 * node, so unconditionally add them.
@@ -896,25 +919,7 @@ static void hmat_register_target(struct memory_target *target)
 		}
 	}
 
-	/*
-	 * Skip offline nodes. This can happen when memory
-	 * marked EFI_MEMORY_SP, "specific purpose", is applied
-	 * to all the memory in a proximity domain leading to
-	 * the node being marked offline / unplugged, or if
-	 * memory-only "hotplug" node is offline.
-	 */
-	if (nid == NUMA_NO_NODE || !node_online(nid))
-		return;
-
-	mutex_lock(&target_lock);
-	if (!target->registered) {
-		hmat_register_target_initiators(target);
-		hmat_register_target_cache(target);
-		hmat_register_target_perf(target, ACCESS_COORDINATE_LOCAL);
-		hmat_register_target_perf(target, ACCESS_COORDINATE_CPU);
-		target->registered = true;
-	}
-	mutex_unlock(&target_lock);
+	hmat_hotplug_target(target);
 }
 
 static void hmat_register_targets(void)
@@ -940,7 +945,7 @@ static int hmat_callback(struct notifier_block *self,
 	if (!target)
 		return NOTIFY_OK;
 
-	hmat_register_target(target);
+	hmat_hotplug_target(target);
 	return NOTIFY_OK;
 }
 
-- 
2.51.1


