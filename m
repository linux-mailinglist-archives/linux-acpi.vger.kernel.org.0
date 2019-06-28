Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A34B5990F
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2019 13:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfF1LQD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Jun 2019 07:16:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbfF1LQC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Jun 2019 07:16:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1387CF0C2C2BFCEE44C6;
        Fri, 28 Jun 2019 19:16:01 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 28 Jun 2019 19:15:50 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH RFC 2/3] arm64: mark all the GICC nodes in MADT as possible cpu
Date:   Fri, 28 Jun 2019 19:13:11 +0800
Message-ID: <1561720392-45907-3-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1561720392-45907-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1561720392-45907-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We set 'cpu_possible_mask' based on the enabled GICC node in MADT. If
the GICC node is disabled, we will skip initializing the kernel data
structure for that CPU.

To support CPU hotplug, we need to initialize some CPU related data
structure in advance. This patch mark all the GICC nodes as possible CPU
and only these enabled GICC nodes as present CPU.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 arch/arm64/kernel/setup.c |  2 +-
 arch/arm64/kernel/smp.c   | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index ec75d20..a82d0c2 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -391,7 +391,7 @@ static int __init topology_init(void)
 	for_each_online_node(i)
 		register_one_node(i);
 
-	for_each_possible_cpu(i) {
+	for_each_online_cpu(i) {
 		struct cpu *cpu = &per_cpu(cpu_data.cpu, i);
 		cpu->hotpluggable = 1;
 		register_cpu(cpu, i);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 7aa9471..854d32c 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -534,16 +534,14 @@ struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu)
 {
 	u64 hwid = processor->arm_mpidr;
 
-	if (!(processor->flags & ACPI_MADT_ENABLED)) {
-		pr_debug("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
-		return;
-	}
-
 	if (hwid & ~MPIDR_HWID_BITMASK || hwid == INVALID_HWID) {
 		pr_err("skipping CPU entry with invalid MPIDR 0x%llx\n", hwid);
 		return;
 	}
 
+	if (!(processor->flags & ACPI_MADT_ENABLED))
+		pr_debug("disabled CPU entry with 0x%llx MPIDR\n", hwid);
+
 	if (is_mpidr_duplicate(cpu_count, hwid)) {
 		pr_err("duplicate CPU MPIDR 0x%llx in MADT\n", hwid);
 		return;
@@ -764,7 +762,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		if (err)
 			continue;
 
-		set_cpu_present(cpu, true);
+		if ((cpu_madt_gicc[cpu].flags & ACPI_MADT_ENABLED))
+			set_cpu_present(cpu, true);
 		numa_store_cpu_info(cpu);
 	}
 }
-- 
1.7.12.4

