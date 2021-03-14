Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DFE33A791
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Mar 2021 20:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhCNTAe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 14 Mar 2021 15:00:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233389AbhCNTAR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 14 Mar 2021 15:00:17 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12EIj1KF115094;
        Sun, 14 Mar 2021 15:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=f16MiEbctRaM0zTifjfSRrk84brFs+UDrg5JRN0XZ6c=;
 b=be/KXiBJcKhGOWCQuVxsXF2KbHR0B+8gsReCmbzpiMqnRoiaHfCnwCkBKCoJih0xxp5N
 l2+56ZD1HyKo19dwcQp2FddjyWnnSQkpX6JkxhK5fCLfJEMyYZKuPflf2HR1L8mRbvbi
 LHSbIFtNkU/YBb4uLdMRUzECGs4kyjOnW3mgssoiDMQO9SJIBKL1BWYANX03G350Tl7v
 bv0RyMTgORtPH0qxWDhUjT92eQrrVOHpAkIdSPCif3TIHGVU+fEjixfPZuwJIghegv5h
 3Au/CzlplhBuNAd7CkRhcFPNoUqvxWbR2IvN/GoT4amQS7QbT8sFcbrb2bC5Q//61XGE 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 379r1p05sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 15:00:04 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12EJ03id008980;
        Sun, 14 Mar 2021 15:00:03 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 379r1p05r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 15:00:03 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12EIw8HD020073;
        Sun, 14 Mar 2021 19:00:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 378n18h50g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 19:00:00 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12EIxgNb35848672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Mar 2021 18:59:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B103A4040;
        Sun, 14 Mar 2021 18:59:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E8D7A404D;
        Sun, 14 Mar 2021 18:59:54 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.23.212])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 14 Mar 2021 18:59:54 +0000 (GMT)
Date:   Sun, 14 Mar 2021 20:59:51 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
Message-ID: <YE5dJ6U3nPWsXY4D@linux.ibm.com>
References: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <9c3bc1b2-bb8d-194d-6faf-e4d7d346dc9b@oracle.com>
 <CAJZ5v0j8udd0R6A1wwpNvZL5Dr1pRcdiZr2if5y50o7OkHOMqg@mail.gmail.com>
 <1ae44491-4404-6873-4ee6-6cf58c1ae6fb@redhat.com>
 <CAJZ5v0gC+60n0-UkMw8h5JPBc6grQtD1ambSOCAHV2HLm886yQ@mail.gmail.com>
 <CAJZ5v0g_ztenDY-ER6A0fKD-ZHhLfF3zQdRYYxQb5jSXudd8xQ@mail.gmail.com>
 <e8593eae-40b8-bc9a-78db-529d28d2be88@redhat.com>
 <YEkgP0G94uQBGDa9@linux.ibm.com>
 <0d05364c-4881-d78a-9721-bd15f5eb822b@redhat.com>
 <CAJZ5v0jOpNJrOt5xn-1YkSB9Q15NZS2cxmsGKAU945YNbs+hOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jOpNJrOt5xn-1YkSB9Q15NZS2cxmsGKAU945YNbs+hOw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-14_10:2021-03-12,2021-03-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103140143
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 11, 2021 at 04:36:31PM +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david@redhat.com> wrote:
> > >
> > > There is some care that should be taken to make sure we get the order
> > > right, but I don't see a fundamental issue here.
> 
> Me neither.
> 
> > > If I understand correctly, Rafael's concern is about changing the parts of
> > > ACPICA that should be OS agnostic, so I think we just need another place to
> > > call memblock_reserve() rather than acpi_tb_install_table_with_override().
> 
> Something like this.
> 
> There is also the problem that memblock_reserve() needs to be called
> for all of the tables early enough, which will require some reordering
> of the early init code.
> 
> > > Since the reservation should be done early in x86::setup_arch() (and
> > > probably in arm64::setup_arch()) we might just have a function that parses
> > > table headers and reserves them, similarly to how we parse the tables
> > > during KASLR setup.
> 
> Right.

I've looked at it a bit more and we do something like the patch below that
nearly duplicates acpi_tb_parse_root_table() which is not very nice.
Besides, reserving ACPI tables early and then calling acpi_table_init()
(and acpi_tb_parse_root_table() again would mean doing the dance with
early_memremap() twice for no good reason.

I believe the most effective way to deal with this would be to have a
function that does parsing, reservation and installs the tables supplied by
the firmware which can be called really early and then another function
that overrides tables if needed a some later point.

--------------------------------------------------------------

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d883176ef2ce..48bcb1c355ad 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -910,6 +910,8 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
+	acpi_reserve_tables();
+
 	if (efi_enabled(EFI_BOOT))
 		efi_memblock_x86_reserve_range();
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index e2d0046799a2..6cb5bcf3fb49 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -133,6 +133,9 @@ void
 acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
 				    u8 override, u32 *table_index);
 
+acpi_physical_address
+acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size);
+
 acpi_status acpi_tb_parse_root_table(acpi_physical_address rsdp_address);
 
 acpi_status
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 4b9b329a5a92..2ad3c08915d4 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -14,10 +14,6 @@
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbutils")
 
-/* Local prototypes */
-static acpi_physical_address
-acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size);
-
 #if (!ACPI_REDUCED_HARDWARE)
 /*******************************************************************************
  *
@@ -162,7 +158,7 @@ struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index)
  *
  ******************************************************************************/
 
-static acpi_physical_address
+acpi_physical_address
 acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
 {
 	u64 address64;
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index e48690a006a4..e4b721bada04 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -23,6 +23,9 @@
 #include <linux/security.h>
 #include "internal.h"
 
+#include "acpica/aclocal.h"
+#include "acpica/actables.h"
+
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
 #include CONFIG_ACPI_CUSTOM_DSDT_FILE
 #endif
@@ -809,6 +812,107 @@ int __init acpi_table_init(void)
 	return 0;
 }
 
+void __init acpi_reserve_tables(void)
+{
+	u32 i, table_count, table_entry_size, length;
+	acpi_physical_address rsdp_address, address;
+	struct acpi_table_header *table, *hdr;
+	struct acpi_table_rsdp *rsdp;
+	u8 *table_entry;
+
+	rsdp_address = acpi_os_get_root_pointer();
+	if (!rsdp_address) {
+		pr_debug("%s: no rsdp_address\n", __func__);
+		return;
+	}
+
+	/* Map the entire RSDP and extract the address of the RSDT or XSDT */
+	rsdp = acpi_os_map_memory(rsdp_address, sizeof(struct acpi_table_rsdp));
+	if (!rsdp) {
+		pr_debug("%s: can't map rsdp\n", __func__);
+		return;
+	}
+
+	memblock_reserve(rsdp_address, sizeof(struct acpi_table_rsdp));
+
+	/* Use XSDT if present and not overridden. Otherwise, use RSDT */
+	if ((rsdp->revision > 1) &&
+	    rsdp->xsdt_physical_address && !acpi_gbl_do_not_use_xsdt) {
+		address = (acpi_physical_address)rsdp->xsdt_physical_address;
+		table_entry_size = ACPI_XSDT_ENTRY_SIZE;
+	} else {
+		address = (acpi_physical_address)rsdp->rsdt_physical_address;
+		table_entry_size = ACPI_RSDT_ENTRY_SIZE;
+	}
+
+	/*
+	 * It is not possible to map more than one entry in some environments,
+	 * so unmap the RSDP here before mapping other tables
+	 */
+	acpi_os_unmap_memory(rsdp, sizeof(struct acpi_table_rsdp));
+
+	/* Map the RSDT/XSDT table header to get the full table length */
+
+	table = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
+	if (!table) {
+		pr_debug("%s: can't map [RX]SDT header\n", __func__);
+		return;
+	}
+
+	/*
+	 * Validate length of the table, and map entire table.
+	 * Minimum length table must contain at least one entry.
+	 */
+	length = table->length;
+	acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
+
+	if (length < (sizeof(struct acpi_table_header) + table_entry_size)) {
+		pr_debug("Invalid table length 0x%X in RSDT/XSDT", length);
+		return;
+	}
+
+	memblock_reserve(address, length);
+
+	table = acpi_os_map_memory(address, length);
+	if (!table) {
+		pr_debug("%s: can't map [RX]SDT table\n", __func__);
+		return;
+	}
+
+	/* Get the number of entries and pointer to first entry */
+	table_count = (u32)((table->length - sizeof(struct acpi_table_header)) /
+			    table_entry_size);
+	table_entry = ACPI_ADD_PTR(u8, table, sizeof(struct acpi_table_header));
+
+	/* reserve tables pointed from the RSDT/XSDT */
+	for (i = 0; i < table_count; i++, table_entry += table_entry_size) {
+
+		/* Get the table physical address (32-bit for RSDT, 64-bit for XSDT) */
+
+		address =
+		    acpi_tb_get_root_table_entry(table_entry, table_entry_size);
+
+		/* Skip NULL entries in RSDT/XSDT */
+
+		if (!address)
+			continue;
+
+		hdr = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
+		if (!hdr) {
+			pr_debug("%s: can't map %d header\n", __func__, i);
+			continue;
+		}
+
+		memblock_reserve(address, hdr->length);
+
+		/* FIXME: parse FADT and reserve embedded there tables */
+
+		acpi_os_unmap_memory(hdr, sizeof(struct acpi_table_header));
+	}
+
+	acpi_os_unmap_memory(table, length);
+}
+
 static int __init acpi_parse_apic_instance(char *str)
 {
 	if (!str)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9f432411e988..d8688e4b6726 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -226,6 +226,8 @@ void acpi_boot_table_init (void);
 int acpi_mps_check (void);
 int acpi_numa_init (void);
 
+void acpi_reserve_tables(void);
+
 int acpi_table_init (void);
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
 int __init acpi_table_parse_entries(char *id, unsigned long table_size,

-- 
Sincerely yours,
Mike.
