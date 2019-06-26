Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E253A573BC
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2019 23:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfFZVhq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Jun 2019 17:37:46 -0400
Received: from foss.arm.com ([217.140.110.172]:41442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfFZVhe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Jun 2019 17:37:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FB1011D4;
        Wed, 26 Jun 2019 14:37:34 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.30.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F26903F246;
        Wed, 26 Jun 2019 14:37:33 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, Jeremy Linton <jeremy.linton@arm.com>,
        Hanjun Gou <gouhanjun@huawei.com>
Subject: [PATCH v5 2/4] ACPI/PPTT: Add function to return ACPI 6.3 Identical tokens
Date:   Wed, 26 Jun 2019 16:37:16 -0500
Message-Id: <20190626213718.39423-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626213718.39423-1-jeremy.linton@arm.com>
References: <20190626213718.39423-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI 6.3 adds a flag to indicate that child nodes are all
identical cores. This is useful to authoritatively determine
if a set of (possibly offline) cores are identical or not.

Since the flag doesn't give us a unique id we can generate
one and use it to create bitmaps of sibling nodes, or simply
in a loop to determine if a subset of cores are identical.

Tested-by: Hanjun Gou <gouhanjun@huawei.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/pptt.c  | 26 ++++++++++++++++++++++++++
 include/linux/acpi.h |  5 +++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 05344413f199..1e7ac0bd0d3a 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -683,3 +683,29 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
 	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
 					  ACPI_PPTT_PHYSICAL_PACKAGE);
 }
+
+/**
+ * find_acpi_cpu_topology_hetero_id() - Get a core architecture tag
+ * @cpu: Kernel logical CPU number
+ *
+ * Determine a unique heterogeneous tag for the given CPU. CPUs with the same
+ * implementation should have matching tags.
+ *
+ * The returned tag can be used to group peers with identical implementation.
+ *
+ * The search terminates when a level is found with the identical implementation
+ * flag set or we reach a root node.
+ *
+ * Due to limitations in the PPTT data structure, there may be rare situations
+ * where two cores in a heterogeneous machine may be identical, but won't have
+ * the same tag.
+ *
+ * Return: -ENOENT if the PPTT doesn't exist, or the CPU cannot be found.
+ * Otherwise returns a value which represents a group of identical cores
+ * similar to this CPU.
+ */
+int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
+{
+	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
+					  ACPI_PPTT_ACPI_IDENTICAL);
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d315d86844e4..5bcd23e5ccd6 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1303,6 +1303,7 @@ static inline int lpit_read_residency_count_address(u64 *address)
 #ifdef CONFIG_ACPI_PPTT
 int find_acpi_cpu_topology(unsigned int cpu, int level);
 int find_acpi_cpu_topology_package(unsigned int cpu);
+int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
 int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
 #else
 static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
@@ -1313,6 +1314,10 @@ static inline int find_acpi_cpu_topology_package(unsigned int cpu)
 {
 	return -EINVAL;
 }
+static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
+{
+	return -EINVAL;
+}
 static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
 {
 	return -EINVAL;
-- 
2.21.0

