Return-Path: <linux-acpi+bounces-17751-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3DEBDC0CB
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Oct 2025 03:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 690C44E2879
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Oct 2025 01:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7EB2FE07B;
	Wed, 15 Oct 2025 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BjURgWTK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1052FE050;
	Wed, 15 Oct 2025 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493013; cv=none; b=QTw7EWtOvO3Mk5CgdwY4EQew7xtIC28QVCruJsKqznhb9zxWhYYICbtEtjWUOp231Gm5iz4pAEEnzDT8bYZyjUYuc4cyTSHsLIiSozFOVnH1pjbaIBYVmbHG5XivI2CjI6G/0+xG7ttyHLtb2ubVHF0bMtlTNFrfeKrQBaKeQZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493013; c=relaxed/simple;
	bh=ijCKe4cIqp2rlkrgBZNR1tNtabcL5ICVuw8UpMdII7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tt1tOGazQTharrL8cRGQfLXgxj4Hfb18E6UUOSWcj5TDKYJzCVs+lj8Ctqi0/7Okzg7F8za7r8hqb43tA+vzQXBTDpRjLZnAsdylAc23KiA9gUws+o947nW6uhXGy5zOBbzP5ncY0IG+P/n1wMT1bEJ05T26RKOmlETifCPdGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BjURgWTK; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760493002; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=X/dvc3pb2WVMgVgSmvfaCUP+dTZcCk02WA6lJvblp08=;
	b=BjURgWTKoBBOJmTCcBzEHG4VblKVrI7AOp0Z3n/8PcXoK+nNmNRGDvD33oNMyWY5glQPKHI+M5i4yBtrKNRoqFJfQcqqz3pWDRLf4Eaqx+RqpYTXnC1wz/ZkrSW4PyEPugeEHBXo2oxwe/KX361HxX+2OoKUPXDA2DpSRH9NpqU=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WqEIwAh_1760493001 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Oct 2025 09:50:01 +0800
Date: Wed, 15 Oct 2025 09:50:01 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH] ACPI: PPTT: Dump PPTT table when error detected
Message-ID: <aO79yXdNQwRQTxPM@U-2FWC9VHC-2323.local>
References: <20251014085154.59557-1-feng.tang@linux.alibaba.com>
 <57719c05-6470-40c8-8ecf-daa4ad1006da@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57719c05-6470-40c8-8ecf-daa4ad1006da@arm.com>

Hi Linton,

Thanks for the prompt review!

On Tue, Oct 14, 2025 at 05:54:14PM -0500, Jeremy Linton wrote:
> Hi,
> 
> On 10/14/25 3:51 AM, Feng Tang wrote:
> > There was warning message about PPTT table:
> > "ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
> > and it in turn caused scheduler warnings when building up the system.
> > It took a while to root cause the problem be related a broken PPTT
> > table which has wrong cache information.
> > 
> > To speedup debugging similar issues, dump the PPTT table when there
> > is warning about it.
> > 
> > The dumped info on a ARM server is like:
> > 
> >      ACPI PPTT: Processors:
> >      P[  0][0x0024]: parent=0x0000 acpi_proc_id=  0 num_res=1 flags=0x11(package)
> >      P[  1][0x005a]: parent=0x0024 acpi_proc_id=  0 num_res=1 flags=0x12()
> >      P[  2][0x008a]: parent=0x005a acpi_proc_id=  0 num_res=3 flags=0x1a(leaf)
> >      P[  3][0x00f2]: parent=0x005a acpi_proc_id=  1 num_res=3 flags=0x1a(leaf)
> >      P[  4][0x015a]: parent=0x005a acpi_proc_id=  2 num_res=3 flags=0x1a(leaf)
> >      ...
> >      ACPI PPTT: Caches:
> >      C[   0][0x0072]: flags=0x7f next_level=0x0000 size=0x4000000  sets=65536  way=16 attribute=0xa  line_size=64
> >      C[   1][0x00aa]: flags=0x7f next_level=0x00da size=0x10000    sets=256    way=4  attribute=0x4  line_size=64
> >      C[   2][0x00c2]: flags=0x7f next_level=0x00da size=0x10000    sets=256    way=4  attribute=0x2  line_size=64
> >      C[   3][0x00da]: flags=0x7f next_level=0x0000 size=0x100000   sets=2048   way=8  attribute=0xa  line_size=64
> 
> 
> This is an interesting idea, particularly if the dump is smarter and acts
> like a linter, but i'm not sure the output right now would have helped with
> the original problem.

I would say yes :). If the patch was in, it would print out N CPU core info,
while the platform actually has 2N CPUs, which made it obvious that the PPTT
table was broken and needed firmware team's fix.

> In that respect simply sprinkling a lot of pr_debug
> information around during the parsing might be more helpful to understand
> the context around parse errors.
> 
> I was under the impression doing that was frowned on, as I ended up removing
> quite a number of them during the initial reviews.

Completely understand. I believe some of the removed stuff can help our case.
A big parf of my job is debuging and fixing bugs, so personally I appreciate
more debug info :)

> 
> I wonder if simply print_hex_dump'ing the table on certain errors with some
> acpi=debug like option is just as useful. Particularly if someone writes a
> better userspace pptt pretty printer, since the iasl output isn't helpful to
> understand the tree relationships.

When I met the issue, I have zero knowledge of PPTT table, and I manually
parse the PPTT table in /sys/firmware/acpi/table/PPTT when a printed ACPI
spec :) So I think this kind of global dumping can help engineers who are
not familiar with PPTT table.

Thanks,
Feng

> 
> >      ...
> > 
> >  From it, we can see the processor/cache info and the hierarchy relation
> > between them.
> > 
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> > ---
> >   drivers/acpi/pptt.c | 75 +++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 75 insertions(+)
> > 
> > diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> > index 54676e3d82dd..e7b48a77a12f 100644
> > --- a/drivers/acpi/pptt.c
> > +++ b/drivers/acpi/pptt.c
> > @@ -498,6 +498,79 @@ static void acpi_pptt_warn_missing(void)
> >   	pr_warn_once("No PPTT table found, CPU and cache topology may be inaccurate\n");
> >   }
> > +static void acpi_dump_pptt_table(struct acpi_table_header *table_hdr)
> > +{
> > +	struct acpi_subtable_header *entry, *entry_start;
> > +	unsigned long end;
> > +	struct acpi_pptt_processor *cpu;
> > +	struct acpi_pptt_cache *cache;
> > +	u32 entry_sz, i;
> > +	u8 len;
> > +	static bool dumped;
> > +
> > +	/* PPTT table could be pretty big, no need to dump it twice */
> > +	if (dumped)
> > +		return;
> > +	dumped = true;
> > +
> > +	end = (unsigned long)table_hdr + table_hdr->length;
> > +	entry_start = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
> > +			     sizeof(struct acpi_table_pptt));
> > +
> > +	pr_info("Processors:\n");
> > +	entry_sz = sizeof(struct acpi_pptt_processor);
> > +	entry = entry_start;
> > +	i = 0;
> > +	while ((unsigned long)entry + entry_sz <= end) {
> > +		len = entry->length;
> > +		if (!len) {
> > +			pr_warn("Invalid zero length subtable\n");
> > +			return;
> > +		}
> > +
> > +		cpu = (struct acpi_pptt_processor *)entry;
> > +		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry, len);
> > +
> > +		if (cpu->header.type != ACPI_PPTT_TYPE_PROCESSOR)
> > +			continue;
> > +
> > +		printk(KERN_INFO "P[%3d][0x%04lx]: parent=0x%04x acpi_proc_id=%3d num_res=%d flags=0x%02x(%s%s%s)\n",
> > +			i++, (unsigned long)cpu - (unsigned long)table_hdr,
> > +			cpu->parent, cpu->acpi_processor_id,
> > +			cpu->number_of_priv_resources, cpu->flags,
> > +			cpu->flags & ACPI_PPTT_PHYSICAL_PACKAGE ? "package" : "",
> > +			cpu->flags & ACPI_PPTT_ACPI_LEAF_NODE ? "leaf" : "",
> > +			cpu->flags & ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD ? ", thread" : ""
> > +			);
> > +
> > +	}
> > +
> > +	pr_info("Caches:\n");
> > +	entry_sz = sizeof(struct acpi_pptt_cache);
> > +	entry = entry_start;
> > +	i = 0;
> > +	while ((unsigned long)entry + entry_sz <= end) {
> > +		len = entry->length;
> > +		if (!len) {
> > +			pr_warn("Invalid zero length subtable\n");
> > +			return;
> > +		}
> > +
> > +		cache = (struct acpi_pptt_cache *)entry;
> > +		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry, len);
> > +
> > +		if (cache->header.type != ACPI_PPTT_TYPE_CACHE)
> > +			continue;
> > +
> > +		printk(KERN_INFO "C[%4d][0x%04lx]: flags=0x%02x next_level=0x%04x size=0x%-8x sets=%-6d way=%-2d attribute=0x%-2x line_size=%d\n",
> > +			i++, (unsigned long)cache - (unsigned long)table_hdr,
> > +			cache->flags, cache->next_level_of_cache, cache->size,
> > +			cache->number_of_sets, cache->associativity,
> > +			cache->attributes, cache->line_size
> > +			);
> > +	}
> > +}
> > +
> >   /**
> >    * topology_get_acpi_cpu_tag() - Find a unique topology value for a feature
> >    * @table: Pointer to the head of the PPTT table
> > @@ -534,6 +607,8 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
> >   	}
> >   	pr_warn_once("PPTT table found, but unable to locate core %d (%d)\n",
> >   		    cpu, acpi_cpu_id);
> > +
> > +	acpi_dump_pptt_table(table);
> >   	return -ENOENT;
> >   }

