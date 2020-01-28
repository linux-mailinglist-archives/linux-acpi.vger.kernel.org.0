Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD98814B36D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 12:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgA1LSP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 06:18:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbgA1LSP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 06:18:15 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5445E80CD9755AA250CC;
        Tue, 28 Jan 2020 19:18:10 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 28 Jan 2020 19:18:02 +0800
From:   John Garry <john.garry@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <jeremy.linton@arm.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <guohanjun@huawei.com>, <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 1/2] ACPI/PPTT: Add acpi_pptt_get_package_info() API
Date:   Tue, 28 Jan 2020 19:14:18 +0800
Message-ID: <1580210059-199540-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPI PPTT ID structure (see 6.2 spec, section 5.2.29.3) allows the
vendor to provide an identifier (or vendor specific part number) for a
particular processor hierarchy node structure. That may be a processor
identifier for a processor node, or some chip identifier for a processor
package node.

In some circumstances it can be useful to learn the SoC package identifiers
in the system. An example is in [0], where the userspace perf tool needs
to know the SoC identifier for certain per-SoC event matching. So for this
purpose, add an API to get ID structure members for a processor package
node index, which may be used by some driver to expose this info to
userspace.

The ID structure table has a number of fields, which are left open to
interpretation per implementation. However the spec does provide reference
examples of how the fields could be used. As such, just provide the
table fields directly in the API, which the caller may interpret (probably
as per spec example).

https://lore.kernel.org/linux-arm-kernel/1579876505-113251-6-git-send-email-john.garry@huawei.com/

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/acpi/pptt.c  | 81 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h | 13 +++++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index f31544d3656e..ea4ed6300d0b 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -760,3 +760,84 @@ int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
 	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
 					  ACPI_PPTT_ACPI_IDENTICAL);
 }
+
+/**
+ * acpi_pptt_get_package_info() - Get processor package information
+ * @index: Index into processor package
+ * @info: Pointer to structure to fill in processor package info
+ *
+ * For a particular processor package index, fill in the acpi_pptt_package_info
+ * structure.
+ *
+ * Return: -ENOENT if the PPTT or processor package index doesn't exist,
+ *	   -EINVAL for invalid arguments, 0 for success.
+ */
+int acpi_pptt_get_package_info(int index, struct acpi_pptt_package_info *info)
+{
+	struct acpi_subtable_header *entry;
+	struct acpi_table_header *table;
+	unsigned long table_end;
+	acpi_status status;
+	int ret, count = 0;
+
+	if (!info)
+		return -EINVAL;
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		acpi_pptt_warn_missing();
+		return -ENOENT;
+	}
+
+	table_end = (unsigned long)table + table->length;
+	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table,
+			     sizeof(struct acpi_table_pptt));
+
+	ret = -ENOENT;
+	while (entry) {
+		struct acpi_pptt_processor *cpu_node;
+
+		cpu_node = (struct acpi_pptt_processor *)entry;
+
+		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
+		    cpu_node->flags & ACPI_PPTT_PHYSICAL_PACKAGE) {
+			int cnt = cpu_node->number_of_priv_resources;
+			int i;
+
+			for (i = 0; i < cnt; i++) {
+				struct acpi_subtable_header *r;
+
+				r = acpi_get_pptt_resource(table, cpu_node, i);
+
+				if (r->type == ACPI_PPTT_TYPE_ID &&
+				    count == index) {
+					struct acpi_pptt_id *id;
+
+					id = (struct acpi_pptt_id *)r;
+					info->LEVEL_2_ID =
+						le64_to_cpu(id->level2_id);
+					info->vendor_id =
+						le32_to_cpu(id->vendor_id);
+
+					ret = 0;
+					goto out;
+				}
+
+				if (r->type == ACPI_PPTT_TYPE_ID)
+					count++;
+			}
+		}
+
+		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
+				     entry->length);
+		if ((unsigned long)entry >= table_end)
+			break;
+	}
+
+out:
+	acpi_put_table(table);
+
+	return ret;
+
+}
+EXPORT_SYMBOL_GPL(acpi_pptt_get_package_info);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0f37a7d5fa77..0a911a298731 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1268,13 +1268,26 @@ static inline int lpit_read_residency_count_address(u64 *address)
 }
 #endif
 
+struct acpi_pptt_package_info {
+	u64 LEVEL_2_ID;
+	u32 vendor_id;
+};
+
 #ifdef CONFIG_ACPI_PPTT
 int acpi_pptt_cpu_is_thread(unsigned int cpu);
 int find_acpi_cpu_topology(unsigned int cpu, int level);
 int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
 int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
+int acpi_pptt_get_package_info(int index, struct acpi_pptt_package_info *info);
 #else
+static inline int acpi_pptt_get_package_info(int index,
+					     struct acpi_pptt_package_info *info);
+{
+	return -EINVAL;
+
+}
+
 static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
 {
 	return -EINVAL;
-- 
2.17.1

