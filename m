Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C865A347
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2019 20:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfF1SPH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Jun 2019 14:15:07 -0400
Received: from foss.arm.com ([217.140.110.172]:53272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfF1SPG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Jun 2019 14:15:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 694ACEBD;
        Fri, 28 Jun 2019 11:15:06 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.30.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 593263F718;
        Fri, 28 Jun 2019 11:15:06 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 2/2] arm64: topology: Use PPTT to determine if PE is a thread
Date:   Fri, 28 Jun 2019 13:14:57 -0500
Message-Id: <20190628181457.6609-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628181457.6609-1-jeremy.linton@arm.com>
References: <20190628181457.6609-1-jeremy.linton@arm.com>
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
---
 arch/arm64/kernel/topology.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 0825c4a856e3..cbbedb53cf06 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -346,11 +346,9 @@ void remove_cpu_topology(unsigned int cpu)
  */
 static int __init parse_acpi_topology(void)
 {
-	bool is_threaded;
+	int is_threaded;
 	int cpu, topology_id;
 
-	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
-
 	for_each_possible_cpu(cpu) {
 		int i, cache_id;
 
@@ -358,6 +356,10 @@ static int __init parse_acpi_topology(void)
 		if (topology_id < 0)
 			return topology_id;
 
+		is_threaded = acpi_pptt_cpu_is_thread(cpu);
+		if (is_threaded < 0)
+			is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
+
 		if (is_threaded) {
 			cpu_topology[cpu].thread_id = topology_id;
 			topology_id = find_acpi_cpu_topology(cpu, 1);
-- 
2.21.0

