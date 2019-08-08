Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5762086BBE
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2019 22:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390328AbfHHUlq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Aug 2019 16:41:46 -0400
Received: from foss.arm.com ([217.140.110.172]:38438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390148AbfHHUlq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Aug 2019 16:41:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04C6F1688;
        Thu,  8 Aug 2019 13:41:46 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.30.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F1CF03F694;
        Thu,  8 Aug 2019 13:41:45 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, rric@kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 2/2] arm64: topology: Use PPTT to determine if PE is a thread
Date:   Thu,  8 Aug 2019 15:40:07 -0500
Message-Id: <20190808204007.30110-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190808204007.30110-1-jeremy.linton@arm.com>
References: <20190808204007.30110-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI 6.3 adds a thread flag to represent if a CPU/PE is
actually a thread. Given that the MPIDR_MT bit may not
represent this information consistently on homogeneous machines
we should prefer the PPTT flag if its available.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/topology.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 0825c4a856e3..bad9c42ea825 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -340,17 +340,28 @@ void remove_cpu_topology(unsigned int cpu)
 }
 
 #ifdef CONFIG_ACPI
+static int __init acpi_cpu_is_threaded(int cpu)
+{
+	int is_threaded = acpi_pptt_cpu_is_thread(cpu);
+
+	/*
+	 * if the PPTT doesn't have thread information, assume a homogeneous
+	 * machine and return the current CPU's thread state.
+	 */
+	if (is_threaded < 0)
+		is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
+
+	return is_threaded;
+}
+
 /*
  * Propagate the topology information of the processor_topology_node tree to the
  * cpu_topology array.
  */
 static int __init parse_acpi_topology(void)
 {
-	bool is_threaded;
 	int cpu, topology_id;
 
-	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
-
 	for_each_possible_cpu(cpu) {
 		int i, cache_id;
 
@@ -358,7 +369,7 @@ static int __init parse_acpi_topology(void)
 		if (topology_id < 0)
 			return topology_id;
 
-		if (is_threaded) {
+		if (acpi_cpu_is_threaded(cpu)) {
 			cpu_topology[cpu].thread_id = topology_id;
 			topology_id = find_acpi_cpu_topology(cpu, 1);
 			cpu_topology[cpu].core_id   = topology_id;
-- 
2.21.0

