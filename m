Return-Path: <linux-acpi+bounces-20149-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD66D0D7E2
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 16:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7699A301FF9B
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEBE2F1FD2;
	Sat, 10 Jan 2026 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qLy248qy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122062222A1;
	Sat, 10 Jan 2026 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057492; cv=none; b=ZPRGIODnIzU6sH6G+GJ4U+3Wy1cdL09x7rMO+YzVr5InNothtqtb/5yddzWHCeiXY8yXOzQIOBOxG0KC9gJ3gnijQD4eu4qTlnEy0Kwz6k77NuWLIYoTmV3W0LLhm3xi1zEiUHem0bvn/48mj1KpUClUcARtiWT8gsxulmbe7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057492; c=relaxed/simple;
	bh=Cg3dgvnwe6Sw2xAkBFyw7/b5S+/7Ve42HZriXkS8pJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8a03+slPjirKEfK2RsN1vcSZY/POh7jaXMkyVzT4lHvAGpsvcYuvPGwux4rYPvCGn4Xx604Hf1H3wjvMgQnpbVIjpV9bSZ05yuzL565jWTpBIp+2eJljNg+GiL6zqYjSQd88BwQe+RXv+0X5NXTKsIkFGunSY9vb2e2+W5xuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qLy248qy; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768057481; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=7h52ii2peL3Gr2WplyoUJnkpYTBA9Kvd7a2TmhKZvU0=;
	b=qLy248qywQn7hqzz4KomkHdGiIy5iaCPdWdHKUyrjkDtwLtWqEB454bU2er1RBLwsEOOjDw1kQ8u2X6RweI49WW9s1Zjrb9NSbT/0hNu0wmQKRsnZqJSfHQ40IKBvxPvG+rEz+N4Ge4tulATiRGe0cmPTpwzI6NB5bl+1FZT6PU=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wwk9lTz_1768057479 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 10 Jan 2026 23:04:40 +0800
Date: Sat, 10 Jan 2026 23:04:38 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Hanjun Guo <guohanjun@huawei.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	James Morse <james.morse@arm.com>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
Message-ID: <aWJqhuhuQUAKMDpF@U-2FWC9VHC-2323.local>
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
 <8358233d-cfcd-451f-319a-f7b27743faa1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8358233d-cfcd-451f-319a-f7b27743faa1@huawei.com>

Hi Hanjun,

Thanks for the review!

On Sat, Jan 10, 2026 at 12:29:43PM +0800, Hanjun Guo wrote:
> Hi Feng Tang,
> 
> On 2025/12/31 18:49, Feng Tang wrote:
> > There was warning message about PPTT table:
> > 
> > 	"ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
> > 
> > and it in turn caused scheduler warnings when building up the system.
> > It took a while to root cause the problem be related a broken PPTT
> > table which has wrong cache information.
> > 
> > To speedup debugging similar issues, dump the PPTT table, which makes
> > the warning more noticeable and helps bug hunting.
> 
> Agreed, I think it was useful for debugging.
> 
> > 
> > The dumped info format on a ARM server is like:
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
> >      ...
> > 
> > It provides a global and straightforward view of the hierarchy of the
> > processor and caches info of the platform, and from the offset info
> > (the 3rd column), the child-parent relation could be checked.
> > 
> > With this, the root cause of the original issue was pretty obvious,
> > that there were some caches items missing which caused the issue when
> > building up scheduler domain.
> 
> Just a discussion, can we just dump the raw PPTT table via acpidump
> in user space when we meet the problem? With the raw PPTT table, we
> can go though the content to see if we have problems.

Good point! We can use iasl to decode the PPTT table. And this dump
is still useful as:
* when enabling new silicon or new firmware (APCI tables), sometimes it
  can't make to boot to user space when the issue happens.
* This dump shows the processor and cache items separately and cleanly,
  while the P[]/C[] index imply the numbers. In an 128 core product ARM
  sever, the print with this patch is about 500 line, while the acpidump
  is about 10,000 lines and harder to parse.

> 
> > 
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> > ---
> > Changelog:
> > 
> >    v2
> >    * rebase againt 6.19 and refine the commit log
> > 
> >   drivers/acpi/pptt.c | 75 +++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 75 insertions(+)
> > 
> > diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> > index de5f8c018333..e00abedcd786 100644
> > --- a/drivers/acpi/pptt.c
> > +++ b/drivers/acpi/pptt.c
> > @@ -529,6 +529,79 @@ static void acpi_pptt_warn_missing(void)
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
> 
> pr_info() please.

Will change.
 
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
> 
> Same here.

Yes.

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
> > @@ -565,6 +638,8 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
> >   	}
> >   	pr_warn_once("PPTT table found, but unable to locate core %d (%d)\n",
> >   		    cpu, acpi_cpu_id);
> > +
> > +	acpi_dump_pptt_table(table);
> 
> I think it would be good to dump it as needed, as a debug feature.

Makes sense to me. Should I add a kernel config option or a module
parameter for it, or just change the pr_info to pr_debug (it's in
a unlikely error path)?

Thanks,
Feng

> Thanks
> Hanjun

