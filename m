Return-Path: <linux-acpi+bounces-17750-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D373EBDBB5F
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Oct 2025 00:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6DC18A6D29
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Oct 2025 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692BD187554;
	Tue, 14 Oct 2025 22:54:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDDF17A305;
	Tue, 14 Oct 2025 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760482473; cv=none; b=LbA7buyG22vfFHqqNtOUXy0vVHVaHJOWU1XalC8JzgeURshrr8tvdNtwm8M19Rny+unJbOl9N+p7vXZx7fMilnPTthdlsfUaXo+C/NPyIj/T9F3UFHFlXwThRECQRjzLSFu/SQODuM69vRodHN4fcDXOqUE3pYa3uxtnrGDGTG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760482473; c=relaxed/simple;
	bh=Eaw+QU5vhaHi+5xYUVnUTpSyuKHE4vIJbktJ0ZtgiUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSgjV8IM1HPJqhWJFqHJM59p1Pz8s354VU+LyIT+H6qco0cyB58Wo5zfUQSh497qBDicAvd41ixfD9yRK8uzuA824oyXViPrZ3gg+GVEhQKHoR47Xgk4b685MDuAQpeTO6TjhrYk9Dci7IaOj9IGNvESykUw2M7hjrrjUdkC90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 926CB1A32;
	Tue, 14 Oct 2025 15:54:21 -0700 (PDT)
Received: from [192.168.20.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E989F3F66E;
	Tue, 14 Oct 2025 15:54:24 -0700 (PDT)
Message-ID: <57719c05-6470-40c8-8ecf-daa4ad1006da@arm.com>
Date: Tue, 14 Oct 2025 17:54:14 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: PPTT: Dump PPTT table when error detected
To: Feng Tang <feng.tang@linux.alibaba.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, James Morse <james.morse@arm.com>
References: <20251014085154.59557-1-feng.tang@linux.alibaba.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20251014085154.59557-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/14/25 3:51 AM, Feng Tang wrote:
> There was warning message about PPTT table:
> "ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
> and it in turn caused scheduler warnings when building up the system.
> It took a while to root cause the problem be related a broken PPTT
> table which has wrong cache information.
> 
> To speedup debugging similar issues, dump the PPTT table when there
> is warning about it.
> 
> The dumped info on a ARM server is like:
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


This is an interesting idea, particularly if the dump is smarter and 
acts like a linter, but i'm not sure the output right now would have 
helped with the original problem. In that respect simply sprinkling a 
lot of pr_debug information around during the parsing might be more 
helpful to understand the context around parse errors.

I was under the impression doing that was frowned on, as I ended up 
removing quite a number of them during the initial reviews.


I wonder if simply print_hex_dump'ing the table on certain errors with 
some acpi=debug like option is just as useful. Particularly if someone 
writes a better userspace pptt pretty printer, since the iasl output 
isn't helpful to understand the tree relationships.


>      ...
> 
>  From it, we can see the processor/cache info and the hierarchy relation
> between them.
> 
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---
>   drivers/acpi/pptt.c | 75 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 75 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 54676e3d82dd..e7b48a77a12f 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -498,6 +498,79 @@ static void acpi_pptt_warn_missing(void)
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
> @@ -534,6 +607,8 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>   	}
>   	pr_warn_once("PPTT table found, but unable to locate core %d (%d)\n",
>   		    cpu, acpi_cpu_id);
> +
> +	acpi_dump_pptt_table(table);
>   	return -ENOENT;
>   }
>   


