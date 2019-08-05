Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B02B481F1D
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2019 16:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfHEOaC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Aug 2019 10:30:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:21116 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728863AbfHEOaC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Aug 2019 10:30:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 07:30:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="185333627"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 05 Aug 2019 07:30:00 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Rafael Wysocki <rafael@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 3/3] acpi/hmat: Skip publishing target info for nodes with no online memory
Date:   Mon,  5 Aug 2019 08:27:06 -0600
Message-Id: <20190805142706.22520-4-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190805142706.22520-1-keith.busch@intel.com>
References: <20190805142706.22520-1-keith.busch@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

There are multiple scenarios where the HMAT may contain information
about proximity domains that are not currently online. Rather than fail
to report any HMAT data just elide those offline domains.

If and when those domains are later onlined they can be added to the
HMEM reporting at that point.

This was found while testing EFI_MEMORY_SP support which reserves
"specific purpose" memory from the general allocation pool. If that
reservation results in an empty numa-node then the node is not marked
online leading a spurious:

    "acpi/hmat: Ignoring HMAT: Invalid table"

...result for HMAT parsing.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/hmat/hmat.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index f86fe7130736..8f9a28a870b0 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -108,9 +108,6 @@ static __init void alloc_memory_target(unsigned int mem_pxm)
 {
 	struct memory_target *target;
 
-	if (pxm_to_node(mem_pxm) == NUMA_NO_NODE)
-		return;
-
 	target = find_mem_target(mem_pxm);
 	if (target)
 		return;
@@ -618,7 +615,16 @@ static void hmat_register_target_perf(struct memory_target *target)
 
 static void hmat_register_target(struct memory_target *target)
 {
-	if (!node_online(pxm_to_node(target->memory_pxm)))
+	int nid = pxm_to_node(target->memory_pxm);
+
+	/*
+	 * Skip offline nodes. This can happen when memory
+	 * marked EFI_MEMORY_SP, "specific purpose", is applied
+	 * to all the memory in a promixity domain leading to
+	 * the node being marked offline / unplugged, or if
+	 * memory-only "hotplug" node is offline.
+	 */
+	if (nid == NUMA_NO_NODE || !node_online(nid))
 		return;
 
 	mutex_lock(&target_lock);
-- 
2.14.4

