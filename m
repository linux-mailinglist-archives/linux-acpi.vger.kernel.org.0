Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084D334003D
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Mar 2021 08:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhCRH0S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Mar 2021 03:26:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229643AbhCRH0F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Mar 2021 03:26:05 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12I74Grw127826;
        Thu, 18 Mar 2021 03:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=39qE1+Q9YzejXDldNd7bWv8SQaFFWVJAWhnKLQRTtI8=;
 b=GX4LClXA0ladm+7Zp3/YQgVdxdogk5l8+nwharDDDrFZluObJ6KqVwOtS/S1+Fia8Y+U
 F2a79++zmvqJFKW3rLF7vC1cXQFrWirdV5yI6WWAAdg9a84ZtJFsF8GeC+SFk1QSG5gz
 ICktmgQo0k/x2f98I/jY5/snnEK+xUH0K80MIQ7ITFfdrBk5msiatxX0TqmEh3Cw/bRK
 GUw/3JjLST9YuBlzLIfTLbLeC+ipmp4OqoMTpa40zjVIpqKHCfAYYNFpnMe7zJwe2E7J
 AZFJEMkwrmXUsPAVWPm0XVFTPv/Mq4oDCHYzBPQwgDJPhgK08eHvWZMSJW1yRSFLRdZn BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37c10229g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 03:25:51 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12I74h8U129969;
        Thu, 18 Mar 2021 03:25:50 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37c10229fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 03:25:50 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12I7M0tc009886;
        Thu, 18 Mar 2021 07:25:47 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 378n18acpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 07:25:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12I7PS9q28639632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 07:25:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49DBC4C046;
        Thu, 18 Mar 2021 07:25:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EB6B4C040;
        Thu, 18 Mar 2021 07:25:43 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.165.64])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 18 Mar 2021 07:25:42 +0000 (GMT)
Date:   Thu, 18 Mar 2021 09:25:40 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Robert Moore <robert.moore@intel.com>,
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
Message-ID: <YFMAdIVn2hpTHfBq@linux.ibm.com>
References: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <YE5dJ6U3nPWsXY4D@linux.ibm.com>
 <CAJZ5v0g1H6hCVbAAFajhn0AYRMU4GkZOqggOB6LVdgFx_vfwOA@mail.gmail.com>
 <3236337.DtqTXxM43S@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3236337.DtqTXxM43S@kreacher>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_02:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103180052
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 17, 2021 at 09:14:37PM +0100, Rafael J. Wysocki wrote:
> On Monday, March 15, 2021 5:19:29 PM CET Rafael J. Wysocki wrote:
> > On Sun, Mar 14, 2021 at 8:00 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > On Thu, Mar 11, 2021 at 04:36:31PM +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david@redhat.com> wrote:
> > > > > >
> > > > > > There is some care that should be taken to make sure we get the order
> > > > > > right, but I don't see a fundamental issue here.
> > > >
> > > > Me neither.
> > > >
> > > > > > If I understand correctly, Rafael's concern is about changing the parts of
> > > > > > ACPICA that should be OS agnostic, so I think we just need another place to
> > > > > > call memblock_reserve() rather than acpi_tb_install_table_with_override().
> > > >
> > > > Something like this.
> > > >
> > > > There is also the problem that memblock_reserve() needs to be called
> > > > for all of the tables early enough, which will require some reordering
> > > > of the early init code.
> > > >
> > > > > > Since the reservation should be done early in x86::setup_arch() (and
> > > > > > probably in arm64::setup_arch()) we might just have a function that parses
> > > > > > table headers and reserves them, similarly to how we parse the tables
> > > > > > during KASLR setup.
> > > >
> > > > Right.
> > >
> > > I've looked at it a bit more and we do something like the patch below that
> > > nearly duplicates acpi_tb_parse_root_table() which is not very nice.
> > 
> > It looks to me that the code need not be duplicated (see below).
> > 
> > > Besides, reserving ACPI tables early and then calling acpi_table_init()
> > > (and acpi_tb_parse_root_table() again would mean doing the dance with
> > > early_memremap() twice for no good reason.
> > 
> > That'd be simply inefficient which is kind of acceptable to me to start with.
> > 
> > And I changing the ACPICA code can be avoided at least initially, it
> > by itself would be a good enough reason.
> > 
> > > I believe the most effective way to deal with this would be to have a
> > > function that does parsing, reservation and installs the tables supplied by
> > > the firmware which can be called really early and then another function
> > > that overrides tables if needed a some later point.
> > 
> > I agree that this should be the direction to go into.
> 
> So maybe something like the patch below?
> 
> I'm not sure if acpi_boot_table_prepare() gets called early enough, though.

To be 100% safe it should be called before e820__memblock_setup(). It is
possible to call memblock_reserve() at any time, even before the actual
memory is detected as long as all reservations fit into the static array
that currently has 128 entries on x86.

As e820__memblock_setup() essentially enables memblock allocations,
theoretically the memory occupied by ACPI tables can be allocated even in
x86::setup_arch() unless it is reserved before e820__memblock_setup().

> Also this still may not play well with initrd-based table overrides. Erik, do
> you have any insights here?
> 
> And ia64 needs to be updated too.

I think arm64 as well.

> ---
>  arch/x86/kernel/acpi/boot.c |   12 +++++++++---
>  arch/x86/kernel/setup.c     |    3 +++
>  drivers/acpi/tables.c       |   24 +++++++++++++++++++++---
>  include/linux/acpi.h        |    9 +++++++--
>  4 files changed, 40 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/arch/x86/kernel/acpi/boot.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/acpi/boot.c
> +++ linux-pm/arch/x86/kernel/acpi/boot.c
> @@ -1541,7 +1541,7 @@ static const struct dmi_system_id acpi_d
>   *	...
>   */
>  
> -void __init acpi_boot_table_init(void)
> +void __init acpi_boot_table_prepare(void)
>  {
>  	dmi_check_system(acpi_dmi_table);
>  
> @@ -1554,10 +1554,16 @@ void __init acpi_boot_table_init(void)
>  	/*
>  	 * Initialize the ACPI boot-time table parser.
>  	 */
> -	if (acpi_table_init()) {
> +	if (acpi_table_prepare())
>  		disable_acpi();
> +}
> +
> +void __init acpi_boot_table_init(void)
> +{
> +	if (acpi_disabled)
>  		return;
> -	}
> +
> +	acpi_table_init();
>  
>  	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
>  
> Index: linux-pm/arch/x86/kernel/setup.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/setup.c
> +++ linux-pm/arch/x86/kernel/setup.c
> @@ -1070,6 +1070,9 @@ void __init setup_arch(char **cmdline_p)
>  	/* preallocate 4k for mptable mpc */
>  	e820__memblock_alloc_reserved_mpc_new();
>  
> +	/* Look for ACPI tables and reserve memory occupied by them. */
> +	acpi_boot_table_prepare();
> +
>  #ifdef CONFIG_X86_CHECK_BIOS_CORRUPTION
>  	setup_bios_corruption_check();
>  #endif
> Index: linux-pm/include/linux/acpi.h
> ===================================================================
> --- linux-pm.orig/include/linux/acpi.h
> +++ linux-pm/include/linux/acpi.h
> @@ -222,11 +222,13 @@ void __iomem *__acpi_map_table(unsigned
>  void __acpi_unmap_table(void __iomem *map, unsigned long size);
>  int early_acpi_boot_init(void);
>  int acpi_boot_init (void);
> +void acpi_boot_table_prepare (void);
>  void acpi_boot_table_init (void);

Not related to this patch, but it feels to me like there are too many
acpi_boot_something() :)

>  int acpi_mps_check (void);
>  int acpi_numa_init (void);
>  
> -int acpi_table_init (void);
> +int acpi_table_prepare (void);
> +void acpi_table_init (void);
>  int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
>  int __init acpi_table_parse_entries(char *id, unsigned long table_size,
>  			      int entry_id,
> @@ -814,9 +816,12 @@ static inline int acpi_boot_init(void)
>  	return 0;
>  }
>  
> +static inline void acpi_boot_table_prepare(void)
> +{
> +}
> +
>  static inline void acpi_boot_table_init(void)
>  {
> -	return;
>  }
>  
>  static inline int acpi_mps_check(void)
> Index: linux-pm/drivers/acpi/tables.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/tables.c
> +++ linux-pm/drivers/acpi/tables.c
> @@ -788,9 +788,10 @@ acpi_status acpi_os_table_override(struc
>   * result: sdt_entry[] is initialized
>   */
>  
> -int __init acpi_table_init(void)
> +int __init acpi_table_prepare(void)
>  {
>  	acpi_status status;
> +	int i;
>  
>  	if (acpi_verify_table_checksum) {
>  		pr_info("Early table checksum verification enabled\n");
> @@ -803,12 +804,29 @@ int __init acpi_table_init(void)
>  	status = acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
>  	if (ACPI_FAILURE(status))
>  		return -EINVAL;
> -	acpi_table_initrd_scan();
>  
> -	check_multiple_madt();
> +	for (i = 0; i < ACPI_MAX_TABLES; i++) {
> +		struct acpi_table_desc *table_desc = &initial_tables[i];
> +
> +		if (!table_desc->address || !table_desc->length)
> +			break;
> +
> +		pr_info("Reserving %4s table memory at [0x%llx - 0x%llx]\n",
> +			table_desc->signature.ascii, table_desc->address,
> +			table_desc->address + table_desc->length - 1);
> +
> +		memblock_reserve(table_desc->address, table_desc->length);
> +	}
> +
>  	return 0;
>  }
>  
> +void __init acpi_table_init(void)
> +{
> +	acpi_table_initrd_scan();
> +	check_multiple_madt();
> +}
> +
>  static int __init acpi_parse_apic_instance(char *str)
>  {
>  	if (!str)
> 
> 
> 

-- 
Sincerely yours,
Mike.
