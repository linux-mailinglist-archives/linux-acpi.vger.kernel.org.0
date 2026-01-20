Return-Path: <linux-acpi+bounces-20438-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE873D3BD0C
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 02:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1432430096B6
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 01:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB40519E97B;
	Tue, 20 Jan 2026 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cqyGLnHH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5ED1D9A5F;
	Tue, 20 Jan 2026 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873386; cv=none; b=hcNNsS0Mv7MahjofHOc4p/qQaQ9/s54Ow2SeD+p1z518HNQHjad5+eiaUfXPUPJmFiufRz1zknlvQP6/B0f6UkYOgvMx2JeO1KQFt9oQHK804r2psmEubQFqfFAJBIsjte5fnoJNKlj3wOLF61xgb2tLWdhScagRZevaz2+pc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873386; c=relaxed/simple;
	bh=u55t6BJyB+ERcjcXZCyKg4mk+LHTiawCnFEdY7ZdWDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl7Jry92LBlp9rptOzjB9MvvYizjwJQ1HyW2+Mrzq/uo1gx/+b7B66zZHpvVLfD8IV/gG1YWXShr3Y29eYE1JQ+uc9dmTkF2n/Qtvm0ZzOfxMvnUQU+Qc5VDWLidBy4Onnejlj6XdPqStWhHv83TVB8NZDSd5UczBoIHny0pGMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cqyGLnHH; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768873376; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=mVvKRLVKSjhaQcags76jcWsC1thBrEbjjf7dY/EVH18=;
	b=cqyGLnHHCti97+a6xYMIU/SJsQ75fKaM7LpVxculQcO0VfeJDe4Z96DUQARyH8k7pQoEgg1bsxTW6nc1V8wgtP9rele2NtGEJsa6u9Q13f3udnidp7nYANw81+sWvKsKO/UYGz6qOXIoySMMG2uQecFbDV4NqLanZAgV9yChUt0=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WxSNHXZ_1768873375 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Jan 2026 09:42:55 +0800
Date: Tue, 20 Jan 2026 09:42:55 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI/PPTT: Check total CPU numbers when a CPU can't
 be found in PPTT table
Message-ID: <aW7dnymr6yXFRTDp@U-2FWC9VHC-2323.local>
References: <20260116072943.26322-1-feng.tang@linux.alibaba.com>
 <aWpCpecZr7o0qIw2@bogus>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWpCpecZr7o0qIw2@bogus>

On Fri, Jan 16, 2026 at 01:52:37PM +0000, Sudeep Holla wrote:
> On Fri, Jan 16, 2026 at 03:29:43PM +0800, Feng Tang wrote:
> > There was a bug that kernel printed error message:
> > " ACPI PPTT: PPTT table found, but unable to locate core 1 (1)"
> > and later on the kernel met issues when building up scheduler domain.
> > 
> > Debug showed the kernel actually brought up all 8 CPUs successfully
> > (MADT and other table worked fine), while the PPTT table was broken
> > as it only had 4 CPUs in total.
> > 
> > Add check for number of CPU of PPTT table against system CPU number,
> > and warn if they are not equal, to help debugging similar issues.
> > 
> > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
[...]
> > +		cpu = (struct acpi_pptt_processor *)entry;
> > +		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry, len);
> > +		if (cpu->header.type == ACPI_PPTT_TYPE_PROCESSOR &&
> > +		    (cpu->flags & ACPI_PPTT_ACPI_LEAF_NODE))
> > +			nr_pptt_cpus++;
> > +	}
> > +
> > +	if (nr_pptt_cpus != num_possible_cpus())
> 
> This is going to be tricky. I recall some config option that sets all
> `NR_CPUS` as possible. In short it will break if that is enabled.

Thanks for the info.

> > +		pr_warn("The number of CPUs (%d) in PPTT table doesn't match system's CPU count (%d)!\n",
> > +			nr_pptt_cpus, num_possible_cpus());
> > +
> > +	checked = true;
> > +}
> > +
> >  /**
> >   * topology_get_acpi_cpu_tag() - Find a unique topology value for a feature
> >   * @table: Pointer to the head of the PPTT table
> > @@ -565,6 +602,9 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
> >  	}
> >  	pr_warn_once("PPTT table found, but unable to locate core %d (%d)\n",
> >  		    cpu, acpi_cpu_id);
> 
> I was expecting the above log will be improved to just say possible mismatch
> with cpu count.
 
Yep. it should be more explicite about the source.

> > +
> > +	/* Check whether PPTT table's CPU count match with system count */
> > +	pptt_verify_cpu_count(table);
> 
> Today it is a request to check the CPU count; tomorrow it will be something
> else in the PPTT. Where do we draw the line on PPTT validation in the kernel?

I had similar concern, so I listed all items in orignal patch for check.

> These issues ultimately need to be fixed in firmware, and the firmware
> should not depend on the kernel to precisely identify what is wrong in
> the PPTT tables.

Ideally yes. But upon the sad experience of raising issue to BIOS vendor or
engineers, the more precise info, the sooner it gets solved and not refused. 

Thanks,
Feng

