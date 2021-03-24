Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091C7347392
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Mar 2021 09:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhCXIY6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Mar 2021 04:24:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233279AbhCXIYf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Mar 2021 04:24:35 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12O84a9e015447;
        Wed, 24 Mar 2021 04:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fHuUKtBn4Yt5wJ2PKfMDk877YRMmyOAp6ogWVerc3rY=;
 b=mDg5UuS5BGxWNCT4fs/sPaU9IQ2Io8KOOvZnH0mcIo7K5nkRtaSOrFz6SOzBkcQInOFS
 vgIFk8HdrfdfysfUqU71y/mF2w1jZ2Z+SvadoapbesLkA3tj9sNcm9s6s/BQa9vXAasK
 4L3TgZy+KhFex4sdSGk89j5x0fANDjXbsJaU+C4uTf1V5QwGF4AozUUouMJWSeSgb8FK
 4Kyb7ovSL/0l/x8439rQXeCsjfVr2YhR1RJ28HsN5Jxu4HoXiuJjqcN5xhG8ts+xNyKm
 wCJLwIU3lm46rverH95o0M8EPF4cy1tWgsi5SBtQnHnAJrZpX3hmJS3W5h4yguqVfiVa yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fsm7u6c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 04:24:18 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12O84mBL016402;
        Wed, 24 Mar 2021 04:24:17 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fsm7u6b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 04:24:17 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12O8OEw6022227;
        Wed, 24 Mar 2021 08:24:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 37d9bpt5cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 08:24:14 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12O8OCVC45416950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 08:24:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E901A4053;
        Wed, 24 Mar 2021 08:24:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6380CA4040;
        Wed, 24 Mar 2021 08:24:10 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.165.64])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Mar 2021 08:24:10 +0000 (GMT)
Date:   Wed, 24 Mar 2021 10:24:08 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        David Hildenbrand <david@redhat.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        x86 Maintainers <x86@kernel.org>
Subject: Re: [PATCH] ACPI: tables: x86: Reserve memory occupied by ACPI tables
Message-ID: <YFr3KMhW0ajHzeH4@linux.ibm.com>
References: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <YE5dJ6U3nPWsXY4D@linux.ibm.com>
 <CAJZ5v0g1H6hCVbAAFajhn0AYRMU4GkZOqggOB6LVdgFx_vfwOA@mail.gmail.com>
 <3236337.DtqTXxM43S@kreacher>
 <YFMAdIVn2hpTHfBq@linux.ibm.com>
 <CAJZ5v0g_y3X2Ps+ipBg702Q_RR3cm4gKBJoPqjazHXaisKGc4g@mail.gmail.com>
 <CAJZ5v0iump7nVKfyu7S23-n=gQFx5d2MKejrnT6yFak7L9V11g@mail.gmail.com>
 <YFWxbzN92XcXNl95@linux.ibm.com>
 <4650320.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4650320.31r3eYUQgx@kreacher>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_05:2021-03-23,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240062
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 23, 2021 at 08:26:52PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The following problem has been reported by George Kennedy:
> 
>  Since commit 7fef431be9c9 ("mm/page_alloc: place pages to tail
>  in __free_pages_core()") the following use after free occurs
>  intermittently when ACPI tables are accessed.
> 
>  BUG: KASAN: use-after-free in ibft_init+0x134/0xc49
>  Read of size 4 at addr ffff8880be453004 by task swapper/0/1
>  CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc1-7a7fd0d #1
>  Call Trace:
>   dump_stack+0xf6/0x158
>   print_address_description.constprop.9+0x41/0x60
>   kasan_report.cold.14+0x7b/0xd4
>   __asan_report_load_n_noabort+0xf/0x20
>   ibft_init+0x134/0xc49
>   do_one_initcall+0xc4/0x3e0
>   kernel_init_freeable+0x5af/0x66b
>   kernel_init+0x16/0x1d0
>   ret_from_fork+0x22/0x30
> 
>  ACPI tables mapped via kmap() do not have their mapped pages
>  reserved and the pages can be "stolen" by the buddy allocator.
> 
> Apparently, on the affected system, the ACPI table in question is
> not located in "reserved" memory, like ACPI NVS or ACPI Data, that
> will not be used by the buddy allocator, so the memory occupied by
> that table has to be explicitly reserved to prevent the buddy
> allocator from using it.
> 
> In order to address this problem, rearrange the initialization of the
> ACPI tables on x86 to locate the initial tables earlier and reserve
> the memory occupied by them.
> 
> The other architectures using ACPI should not be affected by this
> change.
> 
> Link: https://lore.kernel.org/linux-acpi/1614802160-29362-1-git-send-email-george.kennedy@oracle.com/
> Reported-by: George Kennedy <george.kennedy@oracle.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

FWIW:
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/x86/kernel/acpi/boot.c |   25 ++++++++++++-------------
>  arch/x86/kernel/setup.c     |    8 +++-----
>  drivers/acpi/tables.c       |   42 +++++++++++++++++++++++++++++++++++++++---
>  include/linux/acpi.h        |    9 ++++++++-
>  4 files changed, 62 insertions(+), 22 deletions(-)
> 
> Index: linux-pm/arch/x86/kernel/acpi/boot.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/acpi/boot.c
> +++ linux-pm/arch/x86/kernel/acpi/boot.c
> @@ -1554,10 +1554,18 @@ void __init acpi_boot_table_init(void)
>  	/*
>  	 * Initialize the ACPI boot-time table parser.
>  	 */
> -	if (acpi_table_init()) {
> +	if (acpi_locate_initial_tables())
>  		disable_acpi();
> -		return;
> -	}
> +	else
> +		acpi_reserve_initial_tables();
> +}
> +
> +int __init early_acpi_boot_init(void)
> +{
> +	if (acpi_disabled)
> +		return 1;
> +
> +	acpi_table_init_complete();
>  
>  	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
>  
> @@ -1570,18 +1578,9 @@ void __init acpi_boot_table_init(void)
>  		} else {
>  			printk(KERN_WARNING PREFIX "Disabling ACPI support\n");
>  			disable_acpi();
> -			return;
> +			return 1;
>  		}
>  	}
> -}
> -
> -int __init early_acpi_boot_init(void)
> -{
> -	/*
> -	 * If acpi_disabled, bail out
> -	 */
> -	if (acpi_disabled)
> -		return 1;
>  
>  	/*
>  	 * Process the Multiple APIC Description Table (MADT), if present
> Index: linux-pm/arch/x86/kernel/setup.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/setup.c
> +++ linux-pm/arch/x86/kernel/setup.c
> @@ -1045,6 +1045,9 @@ void __init setup_arch(char **cmdline_p)
>  
>  	cleanup_highmap();
>  
> +	/* Look for ACPI tables and reserve memory occupied by them. */
> +	acpi_boot_table_init();
> +
>  	memblock_set_current_limit(ISA_END_ADDRESS);
>  	e820__memblock_setup();
>  
> @@ -1136,11 +1139,6 @@ void __init setup_arch(char **cmdline_p)
>  
>  	early_platform_quirks();
>  
> -	/*
> -	 * Parse the ACPI tables for possible boot-time SMP configuration.
> -	 */
> -	acpi_boot_table_init();
> -
>  	early_acpi_boot_init();
>  
>  	initmem_init();
> Index: linux-pm/include/linux/acpi.h
> ===================================================================
> --- linux-pm.orig/include/linux/acpi.h
> +++ linux-pm/include/linux/acpi.h
> @@ -222,10 +222,14 @@ void __iomem *__acpi_map_table(unsigned
>  void __acpi_unmap_table(void __iomem *map, unsigned long size);
>  int early_acpi_boot_init(void);
>  int acpi_boot_init (void);
> +void acpi_boot_table_prepare (void);
>  void acpi_boot_table_init (void);
>  int acpi_mps_check (void);
>  int acpi_numa_init (void);
>  
> +int acpi_locate_initial_tables (void);
> +void acpi_reserve_initial_tables (void);
> +void acpi_table_init_complete (void);
>  int acpi_table_init (void);
>  int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
>  int __init acpi_table_parse_entries(char *id, unsigned long table_size,
> @@ -814,9 +818,12 @@ static inline int acpi_boot_init(void)
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
> @@ -780,7 +780,7 @@ acpi_status acpi_os_table_override(struc
>  }
>  
>  /*
> - * acpi_table_init()
> + * acpi_locate_initial_tables()
>   *
>   * find RSDP, find and checksum SDT/XSDT.
>   * checksum all tables, print SDT/XSDT
> @@ -788,7 +788,7 @@ acpi_status acpi_os_table_override(struc
>   * result: sdt_entry[] is initialized
>   */
>  
> -int __init acpi_table_init(void)
> +int __init acpi_locate_initial_tables(void)
>  {
>  	acpi_status status;
>  
> @@ -803,9 +803,45 @@ int __init acpi_table_init(void)
>  	status = acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
>  	if (ACPI_FAILURE(status))
>  		return -EINVAL;
> -	acpi_table_initrd_scan();
>  
> +	return 0;
> +}
> +
> +void __init acpi_reserve_initial_tables(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ACPI_MAX_TABLES; i++) {
> +		struct acpi_table_desc *table_desc = &initial_tables[i];
> +		u64 start = table_desc->address;
> +		u64 size = table_desc->length;
> +
> +		if (!start || !size)
> +			break;
> +
> +		pr_info("Reserving %4s table memory at [mem 0x%llx-0x%llx]\n",
> +			table_desc->signature.ascii, start, start + size - 1);
> +
> +		memblock_reserve(start, size);
> +	}
> +}
> +
> +void __init acpi_table_init_complete(void)
> +{
> +	acpi_table_initrd_scan();
>  	check_multiple_madt();
> +}
> +
> +int __init acpi_table_init(void)
> +{
> +	int ret;
> +
> +	ret = acpi_locate_initial_tables();
> +	if (ret)
> +		return ret;
> +
> +	acpi_table_init_complete();
> +
>  	return 0;
>  }
>  
> 
> 
> 

-- 
Sincerely yours,
Mike.
