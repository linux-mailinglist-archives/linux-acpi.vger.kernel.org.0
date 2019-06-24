Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE96351AA0
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2019 20:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfFXSdz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jun 2019 14:33:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:29906 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfFXSdz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jun 2019 14:33:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 11:33:55 -0700
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="184212692"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 11:33:54 -0700
Subject: [PATCH v4 02/10] acpi/numa/hmat: Skip publishing target info for
 nodes with no online memory
From:   Dan Williams <dan.j.williams@intel.com>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, peterz@infradead.org,
        vishal.l.verma@intel.com, ard.biesheuvel@linaro.org,
        tglx@linutronix.de, linux-acpi@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 11:19:37 -0700
Message-ID: <156140037770.2951909.3387200938880485927.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

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
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/numa/hmat.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 96b7d39a97c6..2c220cb7b620 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -96,9 +96,6 @@ static __init void alloc_memory_target(unsigned int mem_pxm)
 {
 	struct memory_target *target;
 
-	if (pxm_to_node(mem_pxm) == NUMA_NO_NODE)
-		return;
-
 	target = find_mem_target(mem_pxm);
 	if (target)
 		return;
@@ -588,6 +585,17 @@ static __init void hmat_register_targets(void)
 	struct memory_target *target;
 
 	list_for_each_entry(target, &targets, node) {
+		int nid = pxm_to_node(target->memory_pxm);
+
+		/*
+		 * Skip offline nodes. This can happen when memory
+		 * marked EFI_MEMORY_SP, "specific purpose", is applied
+		 * to all the memory in a promixity domain leading to
+		 * the node being marked offline / unplugged, or if
+		 * memory-only "hotplug" node is offline.
+		 */
+		if (nid == NUMA_NO_NODE || !node_online(nid))
+			continue;
 		hmat_register_target_initiators(target);
 		hmat_register_target_perf(target);
 	}

