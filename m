Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7328C573BB
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2019 23:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfFZVhe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Jun 2019 17:37:34 -0400
Received: from foss.arm.com ([217.140.110.172]:41430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfFZVhd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Jun 2019 17:37:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37E27D6E;
        Wed, 26 Jun 2019 14:37:33 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.30.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2587D3F246;
        Wed, 26 Jun 2019 14:37:33 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, Jeremy Linton <jeremy.linton@arm.com>,
        Hanjun Gou <gouhanjun@huawei.com>
Subject: [PATCH v5 1/4] ACPI/PPTT: Modify node flag detection to find last IDENTICAL
Date:   Wed, 26 Jun 2019 16:37:15 -0500
Message-Id: <20190626213718.39423-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626213718.39423-1-jeremy.linton@arm.com>
References: <20190626213718.39423-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPI specification implies that the IDENTICAL flag should be
set on all non leaf nodes where the children are identical.
This means that we need to be searching for the last node with
the identical flag set rather than the first one.

Since this flag is also dependent on the table revision, we
need to add a bit of extra code to verify the table revision,
and the next node's state in the traversal. Since we want to
avoid function pointers here, lets just special case
the IDENTICAL flag.

Tested-by: Hanjun Gou <gouhanjun@huawei.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/pptt.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index b72e6afaa8fb..05344413f199 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -432,17 +432,40 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
 	}
 }
 
+static bool flag_identical(struct acpi_table_header *table_hdr,
+			   struct acpi_pptt_processor *cpu)
+{
+	struct acpi_pptt_processor *next;
+
+	/* heterogeneous machines must use PPTT revision > 1 */
+	if (table_hdr->revision < 2)
+		return false;
+
+	/* Locate the last node in the tree with IDENTICAL set */
+	if (cpu->flags & ACPI_PPTT_ACPI_IDENTICAL) {
+		next = fetch_pptt_node(table_hdr, cpu->parent);
+		if (!(next && next->flags & ACPI_PPTT_ACPI_IDENTICAL))
+			return true;
+	}
+
+	return false;
+}
+
 /* Passing level values greater than this will result in search termination */
 #define PPTT_ABORT_PACKAGE 0xFF
 
-static struct acpi_pptt_processor *acpi_find_processor_package_id(struct acpi_table_header *table_hdr,
-								  struct acpi_pptt_processor *cpu,
-								  int level, int flag)
+static struct acpi_pptt_processor *acpi_find_processor_tag(struct acpi_table_header *table_hdr,
+							   struct acpi_pptt_processor *cpu,
+							   int level, int flag)
 {
 	struct acpi_pptt_processor *prev_node;
 
 	while (cpu && level) {
-		if (cpu->flags & flag)
+		/* special case the identical flag to find last identical */
+		if (flag == ACPI_PPTT_ACPI_IDENTICAL) {
+			if (flag_identical(table_hdr, cpu))
+				break;
+		} else if (cpu->flags & flag)
 			break;
 		pr_debug("level %d\n", level);
 		prev_node = fetch_pptt_node(table_hdr, cpu->parent);
@@ -480,8 +503,8 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
 
 	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
 	if (cpu_node) {
-		cpu_node = acpi_find_processor_package_id(table, cpu_node,
-							  level, flag);
+		cpu_node = acpi_find_processor_tag(table, cpu_node,
+						   level, flag);
 		/*
 		 * As per specification if the processor structure represents
 		 * an actual processor, then ACPI processor ID must be valid.
-- 
2.21.0

