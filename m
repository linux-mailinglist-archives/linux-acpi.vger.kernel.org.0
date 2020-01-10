Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F56136CC7
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2020 13:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgAJML4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Jan 2020 07:11:56 -0500
Received: from foss.arm.com ([217.140.110.172]:43574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgAJMLz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Jan 2020 07:11:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEA3D1063;
        Fri, 10 Jan 2020 04:11:54 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D40493F534;
        Fri, 10 Jan 2020 04:11:53 -0800 (PST)
Date:   Fri, 10 Jan 2020 12:11:48 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxarm@huawei.com, John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v1] ACPI/IORT: Workaround for IORT ID count "minus one"
 issue
Message-ID: <20200110121148.GA22244@e121166-lin.cambridge.arm.com>
References: <1577708824-4873-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577708824-4873-1-git-send-email-guohanjun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 30, 2019 at 08:27:04PM +0800, Hanjun Guo wrote:
> The IORT spec [0] says Number of IDs = The number of IDs in the range minus
> one, it is confusing but it was written down in the first version of the
> IORT spec. But the IORT ID mapping function iort_id_map() did something
> wrong from the start, which bails out if:
> 
> the request ID >= the input base + number of IDs
> 
> This is wrong because it ignored the "minus one", and breaks some valid
> usecases such as ID mapping to contain single device mapping without
> single mapping flag set.
> 
> Pankaj Bansal proposed a solution to fix the issue [1], which bails
> out if:
> 
> the request ID > the input base + number of IDs
> 
> This works as the spec defined, unfortunately some firmware didn't
> minus one for the number of IDs in the range, and the propoased
> solution will break those systems in this way:
> 
> PCI hostbridge mapping entry 1:
> Input base:  0x1000
> ID Count:    0x100
> Output base: 0x1000
> Output reference: 0xC4  //ITS reference
> 
> PCI hostbridge mapping entry 2:
> Input base:  0x1100
> ID Count:    0x100
> Output base: 0x2000
> Output reference: 0xD4  //ITS reference
> 
> Two mapping entries which the second entry's Input base = the first
> entry's Input base + ID count, so for requester ID 0x1100 will map
> to ITS 0xC4 not 0xD4 if we update '>=' to '>'.
> 
> So introduce a workaround to match the IORT's OEM information for
> the broken firmware, also update the logic of the ID mapping for
> firmwares report the number of IDs as the IORT spec defined, to
> make the code compatible for both kinds of system.
> 
> I checked the ACPI tables in the tianocore/edk2-platforms [2], only
> HiSilicon HIP07/08 did wrong, so just add HIP07/08 to the workaround
> info table, if we break other platforms, we can add that later.
> 
> [0]: http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf
> [1]: https://patchwork.kernel.org/patch/11292823/
> [2]: https://github.com/tianocore/edk2-platforms
> 
> Cc: Pankaj Bansal <pankaj.bansal@nxp.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>

Commit log rewritten below - please update the code (and check the
log) as per this thread discussion.

Thanks,
Lorenzo

-- >8 --
From bc766b2913008519bdb59bbc38907451e8bac0d4 Mon Sep 17 00:00:00 2001
From: Hanjun Guo <guohanjun@huawei.com>
Date: Mon, 30 Dec 2019 20:27:04 +0800
Subject: [PATCH] ACPI/IORT: Fix 'Number of IDs' handling in iort_id_map()

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
 drivers/acpi/arm64/iort.c | 55 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 33f71983e001..60eb10d46d2b 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -298,6 +298,42 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
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
 static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 		       u32 *rid_out)
 {
@@ -314,9 +350,21 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
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
@@ -1631,5 +1679,6 @@ void __init acpi_iort_init(void)
 		return;
 	}
 
+	iort_check_id_count_workaround(iort_table);
 	iort_init_platform_devices();
 }
-- 
2.17.1

