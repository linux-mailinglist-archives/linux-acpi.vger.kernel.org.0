Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7DE13A920
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2020 13:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgANMTc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Jan 2020 07:19:32 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45564 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbgANMTb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Jan 2020 07:19:31 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4C8371514FD2988328EA;
        Tue, 14 Jan 2020 20:19:30 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 14 Jan 2020 20:19:24 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Pankaj Bansal" <pankaj.bansal@nxp.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Tyler Baicar" <baicar@os.amperecomputing.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2] ACPI/IORT: Fix 'Number of IDs' handling in iort_id_map()
Date:   Tue, 14 Jan 2020 20:14:11 +0800
Message-ID: <1579004051-48797-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The IORT specification [0] (Section 3, table 4, page 9) defines the
'Number of IDs' as 'The number of IDs in the range minus one'.

However, the IORT ID mapping function iort_id_map() treats the 'Number
of IDs' field as if it were the full IDs mapping count, with the
following check in place to detect out of boundary input IDs:

InputID >= Input base + Number of IDs

This check is flawed in that it considers the 'Number of IDs' field as
the full number of IDs mapping and disregards the 'minus one' from
the IDs count.

The correct check in iort_id_map() should be implemented as:

InputID > Input base + Number of IDs

this implements the specification correctly but unfortunately it breaks
existing firmwares that erroneously set the 'Number of IDs' as the full
IDs mapping count rather than IDs mapping count minus one.

e.g.

PCI hostbridge mapping entry 1:
Input base:  0x1000
ID Count:    0x100
Output base: 0x1000
Output reference: 0xC4  //ITS reference

PCI hostbridge mapping entry 2:
Input base:  0x1100
ID Count:    0x100
Output base: 0x2000
Output reference: 0xD4  //ITS reference

Two mapping entries which the second entry's Input base = the first
entry's Input base + ID count, so for InputID 0x1100 and with the
correct InputID check in place in iort_id_map() the kernel would map
the InputID to ITS 0xC4 not 0xD4 as it would be expected.

Therefore, to keep supporting existing flawed firmwares, introduce a
workaround that instructs the kernel to use the old InputID range check
logic in iort_id_map(), so that we can support both firmwares written
with the flawed 'Number of IDs' logic and the correct one as defined in
the specifications.

[0]: http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf

Reported-by: Pankaj Bansal <pankaj.bansal@nxp.com>
Link: https://lore.kernel.org/linux-acpi/20191215203303.29811-1-pankaj.bansal@nxp.com/
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Pankaj Bansal <pankaj.bansal@nxp.com>
Cc: Will Deacon <will@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
---

v1->v2:
 - Update the commit log and title by Lorenzo;
 - Update the code and log suggested by Robin and Lorenzo;

RFC->v1:
 - Print warning when matched the workaround info, suggested by Pankaj;

 drivers/acpi/arm64/iort.c | 57 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 33f7198..6078064 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -298,6 +298,59 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
 	return status;
 }
 
+struct iort_workaround_oem_info {
+	char oem_id[ACPI_OEM_ID_SIZE + 1];
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
+	u32 oem_revision;
+};
+
+static bool apply_id_count_workaround;
+
+static struct iort_workaround_oem_info wa_info[] __initdata = {
+	{
+		.oem_id		= "HISI  ",
+		.oem_table_id	= "HIP07   ",
+		.oem_revision	= 0,
+	}, {
+		.oem_id		= "HISI  ",
+		.oem_table_id	= "HIP08   ",
+		.oem_revision	= 0,
+	}
+};
+
+static void __init
+iort_check_id_count_workaround(struct acpi_table_header *tbl)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
+		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
+		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
+		    wa_info[i].oem_revision == tbl->oem_revision) {
+			apply_id_count_workaround = true;
+			pr_warn(FW_BUG "ID count for ID mapping entry is wrong, applying workaround\n");
+			break;
+		}
+	}
+}
+
+static inline u32 iort_get_map_max(struct acpi_iort_id_mapping *map)
+{
+	u32 map_max = map->input_base + map->id_count;
+
+	/*
+	 * The IORT specification revision D (Section 3, table 4, page 9) says
+	 * Number of IDs = The number of IDs in the range minus one, but the
+	 * IORT code ignored the "minus one", and some firmware did that too,
+	 * so apply a workaround here to keep compatible with both the spec
+	 * compliant and non-spec compliant firmwares.
+	 */
+	if (apply_id_count_workaround)
+		map_max--;
+
+	return map_max;
+}
+
 static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 		       u32 *rid_out)
 {
@@ -314,8 +367,7 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 		return -ENXIO;
 	}
 
-	if (rid_in < map->input_base ||
-	    (rid_in >= map->input_base + map->id_count))
+	if (rid_in < map->input_base || rid_in > iort_get_map_max(map))
 		return -ENXIO;
 
 	*rid_out = map->output_base + (rid_in - map->input_base);
@@ -1631,5 +1683,6 @@ void __init acpi_iort_init(void)
 		return;
 	}
 
+	iort_check_id_count_workaround(iort_table);
 	iort_init_platform_devices();
 }
-- 
1.7.12.4

