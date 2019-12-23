Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63CA212939E
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2019 10:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfLWJ2l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Dec 2019 04:28:41 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbfLWJ2k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Dec 2019 04:28:40 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 27F3C245AD9346E61920;
        Mon, 23 Dec 2019 17:28:39 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Mon, 23 Dec 2019 17:28:29 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Pankaj Bansal" <pankaj.bansal@nxp.com>,
        Erik Schmauss <erik.schmauss@intel.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [RFC PATCH 2/2] ACPI/IORT: Workaround for IORT ID count "minus one" issue
Date:   Mon, 23 Dec 2019 17:23:17 +0800
Message-ID: <1577092997-9852-2-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1577092997-9852-1-git-send-email-guohanjun@huawei.com>
References: <1577092997-9852-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The IORT spec [0] says Number of IDs = The number of IDs in the range minus
one, it is confusing but it was written down in the first version of the
IORT spec. But the IORT ID mapping function iort_id_map() did something
wrong from the start, which bails out if:

the request ID >= the input base + number of IDs

This is wrong because it ignored the "minus one", and breaks some valid
usecases such as ID mapping to contain single device mapping without
single mapping flag set.

Pankaj Bansal proposed a solution to fix the issue [1], which bails
out if:

the request ID > the input base + number of IDs

This works as the spec defined, unfortunately some firmware didn't
minus one for the number of IDs in the range, and the propoased
solution will break those systems in this way:

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
entry's Input base + ID count, so for requester ID 0x1100 will map
to ITS 0xC4 not 0xD4 if we update '>=' to '>'.

So introduce a workaround to match the IORT's OEM information for
the broken firmware, also update the logic of the ID mapping for
firmwares report the number of IDs as the IORT spec defined, to
make the code compatible for both kinds of system.

I checked the ACPI tables in the tianocore/edk2-platforms [2], only
HiSilicon HIP07/08 did wrong, so just add HIP07/08 to the workaround
info table, if we break other platforms, we can add that later.

[0]: http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf
[1]: https://patchwork.kernel.org/patch/11292823/
[2]: https://github.com/tianocore/edk2-platforms

Cc: Pankaj Bansal <pankaj.bansal@nxp.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/arm64/iort.c | 54 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 33f7198..112b1b0 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -298,6 +298,41 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
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
+			break;
+		}
+	}
+}
+
 static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 		       u32 *rid_out)
 {
@@ -314,9 +349,21 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 		return -ENXIO;
 	}
 
-	if (rid_in < map->input_base ||
-	    (rid_in >= map->input_base + map->id_count))
-		return -ENXIO;
+	/*
+	 * IORT spec says Number of IDs = The number of IDs in the range minus
+	 * one, but the IORT code ingored the "minus one", and some firmware
+	 * did that too, so apply a workaround here to keep compatible with
+	 * both new and old versions of the firmware.
+	 */
+	if (apply_id_count_workaround) {
+		if (rid_in < map->input_base ||
+			(rid_in >= map->input_base + map->id_count))
+			return -ENXIO;
+	} else {
+		if (rid_in < map->input_base ||
+			(rid_in > map->input_base + map->id_count))
+			return -ENXIO;
+	}
 
 	*rid_out = map->output_base + (rid_in - map->input_base);
 	return 0;
@@ -1631,5 +1678,6 @@ void __init acpi_iort_init(void)
 		return;
 	}
 
+	iort_check_id_count_workaround(iort_table);
 	iort_init_platform_devices();
 }
-- 
1.7.12.4

