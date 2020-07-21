Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2C7227C7F
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jul 2020 12:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgGUKGO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Jul 2020 06:06:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45802 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729026AbgGUKGM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 21 Jul 2020 06:06:12 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5547B3394BD194B73379;
        Tue, 21 Jul 2020 18:06:10 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 18:06:00 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/3] ACPI: NUMA: Remove the useless sub table pointer check
Date:   Tue, 21 Jul 2020 17:59:05 +0800
Message-ID: <1595325546-63774-3-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1595325546-63774-1-git-send-email-guohanjun@huawei.com>
References: <1595325546-63774-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In acpi_parse_entries_array(), the subtable entries (entry.hdr)
will never be NULL, so for ACPI subtable handler in struct
acpi_subtable_proc, will never handle NULL subtable entries,
remove those useless subtable pointer checks in those callback
handlers.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/numa/srat.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 5be5a97..3d430b0 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -291,8 +291,6 @@ static int __init acpi_parse_slit(struct acpi_table_header *table)
 	struct acpi_srat_x2apic_cpu_affinity *processor_affinity;
 
 	processor_affinity = (struct acpi_srat_x2apic_cpu_affinity *)header;
-	if (!processor_affinity)
-		return -EINVAL;
 
 	acpi_table_print_srat_entry(&header->common);
 
@@ -309,8 +307,6 @@ static int __init acpi_parse_slit(struct acpi_table_header *table)
 	struct acpi_srat_cpu_affinity *processor_affinity;
 
 	processor_affinity = (struct acpi_srat_cpu_affinity *)header;
-	if (!processor_affinity)
-		return -EINVAL;
 
 	acpi_table_print_srat_entry(&header->common);
 
@@ -327,8 +323,6 @@ static int __init acpi_parse_slit(struct acpi_table_header *table)
 	struct acpi_srat_gicc_affinity *processor_affinity;
 
 	processor_affinity = (struct acpi_srat_gicc_affinity *)header;
-	if (!processor_affinity)
-		return -EINVAL;
 
 	acpi_table_print_srat_entry(&header->common);
 
@@ -347,8 +341,6 @@ static int __init acpi_parse_slit(struct acpi_table_header *table)
 	struct acpi_srat_mem_affinity *memory_affinity;
 
 	memory_affinity = (struct acpi_srat_mem_affinity *)header;
-	if (!memory_affinity)
-		return -EINVAL;
 
 	acpi_table_print_srat_entry(&header->common);
 
-- 
1.7.12.4

