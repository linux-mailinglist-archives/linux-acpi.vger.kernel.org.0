Return-Path: <linux-acpi+bounces-20126-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2472D0CF21
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 05:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C72C130155AC
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 04:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D968231AF3B;
	Sat, 10 Jan 2026 04:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QOyYQ+G4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B7A17B505;
	Sat, 10 Jan 2026 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768019390; cv=none; b=uAvl/wauUGHhrLFjOBYME4LodmI8Dtue6sl9f9TaX8mncXi+m/sqe/xx6+BjWX/lYFTjvSB10n0omCIH8ZcZCNddnkWNWr21tJUKhP20auvcMxjFIx0mxSglry/hENs2mzhAsDHjubjEvtNVREYLyJKz11FmX5kUycCyCZUZy2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768019390; c=relaxed/simple;
	bh=2cCHJcWGBWHtYjIGJjGRsknOtqERh0tEXCLdd4NYe38=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kRD83iWATSbvYS2iKkcfNPQpTdltPoFg1SvAgc3x1ybsa3f/IJz9dwN2475rNj4uv1HpNZrGKzQfh7JUaN8pBCMRSmvbJCugpzlz2dmYibVRnlKB2O/l9Ba5xXzjwZQV6cPee3hzcIhlIEd2IFZLBc0Lma09WDk0I2TOWGJ9OAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QOyYQ+G4; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zbZ4OHfuwSEuF2x5uGchz90sNBEHgmMVonxAZmVeTig=;
	b=QOyYQ+G4zj/JaSKSnxcaRd0dqSLSd9PJ4JB1gdHTZJNYQ+ba0kBHOG4kR7+EwWBCkwgFpSp8b
	MveSjUV/NtpyyOyF9myz3hSKquUiL9FcTdTtS+cZEjMfojzSWdAnAVxYo0zs7Paw7MSBEMz1jyf
	3ZcS2LM/w6nWZ29bZJ1MkIs=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dp5Dp3z3YzpStX;
	Sat, 10 Jan 2026 12:26:18 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id AFCEE40538;
	Sat, 10 Jan 2026 12:29:44 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 10 Jan 2026 12:29:43 +0800
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
To: Feng Tang <feng.tang@linux.alibaba.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Jeremy Linton
	<jeremy.linton@arm.com>, James Morse <james.morse@arm.com>
CC: Joanthan Cameron <Jonathan.Cameron@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <8358233d-cfcd-451f-319a-f7b27743faa1@huawei.com>
Date: Sat, 10 Jan 2026 12:29:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Hi Feng Tang,

On 2025/12/31 18:49, Feng Tang wrote:
> There was warning message about PPTT table:
> 
> 	"ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
> 
> and it in turn caused scheduler warnings when building up the system.
> It took a while to root cause the problem be related a broken PPTT
> table which has wrong cache information.
> 
> To speedup debugging similar issues, dump the PPTT table, which makes
> the warning more noticeable and helps bug hunting.

Agreed, I think it was useful for debugging.

> 
> The dumped info format on a ARM server is like:
> 
>      ACPI PPTT: Processors:
>      P[  0][0x0024]: parent=0x0000 acpi_proc_id=  0 num_res=1 flags=0x11(package)
>      P[  1][0x005a]: parent=0x0024 acpi_proc_id=  0 num_res=1 flags=0x12()
>      P[  2][0x008a]: parent=0x005a acpi_proc_id=  0 num_res=3 flags=0x1a(leaf)
>      P[  3][0x00f2]: parent=0x005a acpi_proc_id=  1 num_res=3 flags=0x1a(leaf)
>      P[  4][0x015a]: parent=0x005a acpi_proc_id=  2 num_res=3 flags=0x1a(leaf)
>      ...
>      ACPI PPTT: Caches:
>      C[   0][0x0072]: flags=0x7f next_level=0x0000 size=0x4000000  sets=65536  way=16 attribute=0xa  line_size=64
>      C[   1][0x00aa]: flags=0x7f next_level=0x00da size=0x10000    sets=256    way=4  attribute=0x4  line_size=64
>      C[   2][0x00c2]: flags=0x7f next_level=0x00da size=0x10000    sets=256    way=4  attribute=0x2  line_size=64
>      C[   3][0x00da]: flags=0x7f next_level=0x0000 size=0x100000   sets=2048   way=8  attribute=0xa  line_size=64
>      ...
> 
> It provides a global and straightforward view of the hierarchy of the
> processor and caches info of the platform, and from the offset info
> (the 3rd column), the child-parent relation could be checked.
> 
> With this, the root cause of the original issue was pretty obvious,
> that there were some caches items missing which caused the issue when
> building up scheduler domain.

Just a discussion, can we just dump the raw PPTT table via acpidump
in user space when we meet the problem? With the raw PPTT table, we
can go though the content to see if we have problems.

> 
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---
> Changelog:
> 
>    v2
>    * rebase againt 6.19 and refine the commit log
> 
>   drivers/acpi/pptt.c | 75 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 75 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index de5f8c018333..e00abedcd786 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -529,6 +529,79 @@ static void acpi_pptt_warn_missing(void)
>   	pr_warn_once("No PPTT table found, CPU and cache topology may be inaccurate\n");
>   }
>   
> +static void acpi_dump_pptt_table(struct acpi_table_header *table_hdr)
> +{
> +	struct acpi_subtable_header *entry, *entry_start;
> +	unsigned long end;
> +	struct acpi_pptt_processor *cpu;
> +	struct acpi_pptt_cache *cache;
> +	u32 entry_sz, i;
> +	u8 len;
> +	static bool dumped;
> +
> +	/* PPTT table could be pretty big, no need to dump it twice */
> +	if (dumped)
> +		return;
> +	dumped = true;
> +
> +	end = (unsigned long)table_hdr + table_hdr->length;
> +	entry_start = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
> +			     sizeof(struct acpi_table_pptt));
> +
> +	pr_info("Processors:\n");
> +	entry_sz = sizeof(struct acpi_pptt_processor);
> +	entry = entry_start;
> +	i = 0;
> +	while ((unsigned long)entry + entry_sz <= end) {
> +		len = entry->length;
> +		if (!len) {
> +			pr_warn("Invalid zero length subtable\n");
> +			return;
> +		}
> +
> +		cpu = (struct acpi_pptt_processor *)entry;
> +		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry, len);
> +
> +		if (cpu->header.type != ACPI_PPTT_TYPE_PROCESSOR)
> +			continue;
> +
> +		printk(KERN_INFO "P[%3d][0x%04lx]: parent=0x%04x acpi_proc_id=%3d num_res=%d flags=0x%02x(%s%s%s)\n",

pr_info() please.

> +			i++, (unsigned long)cpu - (unsigned long)table_hdr,
> +			cpu->parent, cpu->acpi_processor_id,
> +			cpu->number_of_priv_resources, cpu->flags,
> +			cpu->flags & ACPI_PPTT_PHYSICAL_PACKAGE ? "package" : "",
> +			cpu->flags & ACPI_PPTT_ACPI_LEAF_NODE ? "leaf" : "",
> +			cpu->flags & ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD ? ", thread" : ""
> +			);
> +
> +	}
> +
> +	pr_info("Caches:\n");
> +	entry_sz = sizeof(struct acpi_pptt_cache);
> +	entry = entry_start;
> +	i = 0;
> +	while ((unsigned long)entry + entry_sz <= end) {
> +		len = entry->length;
> +		if (!len) {
> +			pr_warn("Invalid zero length subtable\n");
> +			return;
> +		}
> +
> +		cache = (struct acpi_pptt_cache *)entry;
> +		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry, len);
> +
> +		if (cache->header.type != ACPI_PPTT_TYPE_CACHE)
> +			continue;
> +
> +		printk(KERN_INFO "C[%4d][0x%04lx]: flags=0x%02x next_level=0x%04x size=0x%-8x sets=%-6d way=%-2d attribute=0x%-2x line_size=%d\n",

Same here.

> +			i++, (unsigned long)cache - (unsigned long)table_hdr,
> +			cache->flags, cache->next_level_of_cache, cache->size,
> +			cache->number_of_sets, cache->associativity,
> +			cache->attributes, cache->line_size
> +			);
> +	}
> +}
> +
>   /**
>    * topology_get_acpi_cpu_tag() - Find a unique topology value for a feature
>    * @table: Pointer to the head of the PPTT table
> @@ -565,6 +638,8 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>   	}
>   	pr_warn_once("PPTT table found, but unable to locate core %d (%d)\n",
>   		    cpu, acpi_cpu_id);
> +
> +	acpi_dump_pptt_table(table);

I think it would be good to dump it as needed, as a debug feature.

Thanks
Hanjun

