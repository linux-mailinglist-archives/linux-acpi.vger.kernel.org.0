Return-Path: <linux-acpi+bounces-10861-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5232EA2333B
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jan 2025 18:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67373A66E3
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jan 2025 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F362F1F03CE;
	Thu, 30 Jan 2025 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3aXBrT1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43681EF0B7;
	Thu, 30 Jan 2025 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258626; cv=none; b=S9t6B0UOWvdnBn5pP8E2nkgY4RMsf46JFVqLBgJRhtOfVKSu42epgG+4/uWTUXSc2TpEQ3MirTpgKPGhJq+rfQSQUC0JpLB3+fGVL7c5m+UB/qo1tkFVL3wmIns5iYeebBgXr08FlXw+hOmKDBZKbBHP2aiWP0sU5LLGB/ZXb20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258626; c=relaxed/simple;
	bh=uSM1MPbvBqUgJ0jp5x1Q+m8RSmC36vz1+mKZC8DAuew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9bjemDxR/o7qBQ8liVPXVPJ97zSorL0v/WFJaiY0d1CL06D9+Yc5fZNwOPNX5dmfgyAwHy7UJYMxcbD0Cg4/tpj1/xuIWEXrIdL7lFcmxGrMPsUFksZcisTPCCtMv8ELg+hiPnT9SKrXNb/XNLs2R9Z3fxYvuHnXC0vTKtGcoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3aXBrT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766E9C4CED2;
	Thu, 30 Jan 2025 17:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738258626;
	bh=uSM1MPbvBqUgJ0jp5x1Q+m8RSmC36vz1+mKZC8DAuew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3aXBrT1xWurjBUpscuGw4PcYy9pbYV8+odimCcMebVNDWpTgDv1Cb/DfvS7o9RrW
	 7vwbI46DvKvtqWyNRqdmNUnTR1xQjxfiNGLF/QtG8BCPczGZkGvw1vfYYGG9r6JzoV
	 uMMy889mgmFWrw4CpPWuXbXjSygGQLqwAU5z1SCwefC02EfCb6VIX4D/5Lu5F3wy2F
	 RqKYGc+4Zr9tLA4nh8/jAVgtwGwNfM8Zwy7ikxu/Rdp8iSd/XP6PDr8IJm9n/nqQMa
	 tyOtbIpUAzVQp6wIoh8PR011LfVWQqyrXwOl9b28ZMutQQ7dxPI+gDtupBfewd+kwG
	 xCfLjLTn0aQ4w==
Date: Thu, 30 Jan 2025 18:37:00 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Zheng Zengkai <zhengzengkai@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: GTDT: Relax sanity checking on Platform Timers
 array count
Message-ID: <Z5u4vCwVCIhiE72I@lpieralisi>
References: <20250128001749.3132656-1-oliver.upton@linux.dev>
 <Z5i2j9gFB2iyN9g4@lpieralisi>
 <Z5lBMBY7XoFJmpGM@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5lBMBY7XoFJmpGM@linux.dev>

On Tue, Jan 28, 2025 at 12:42:24PM -0800, Oliver Upton wrote:
> Hi Lorenzo,
> 
> On Tue, Jan 28, 2025 at 11:50:55AM +0100, Lorenzo Pieralisi wrote:
> > > @@ -188,13 +188,17 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
> > >  		cnt++;
> > >  
> > >  	if (cnt != gtdt->platform_timer_count) {
> > > +		cnt = min(cnt, gtdt->platform_timer_count);
> > 
> > Thank you for reporting this.
> > 
> > There is something I need to understand.
> > 
> > What's wrong cnt (because platform_timer_valid() fails for some
> > reason on some entries whereas before the commit we
> > are fixing was applied we *were* parsing those entries) or
> > gtdt->platform_timer_count ?
> > 
> > I *guess* the issue is the following:
> > 
> > gtdt->platform_timer_count reports the number of GT blocks in the
> > GTDT not including Arm generic watchdogs, whereas cnt counts both
> > structure types (and that's what gtdt->platform_timer_count should
> > report too if it was correct).
> 
> I've seen two different issues so far:
> 
>  - In one case, the offset of the platform timer array is entirely
>    beyond the GTDT

And we were parsing it before the commit you are fixing was applied
because we weren't validating the first entry ?

That's how the loop was working before:

#define for_each_platform_timer(_g)
	for (_g = acpi_gtdt_desc.platform_timer; _g;
		_g = next_platform_timer(_g))

We were parsing the first entry and now we don't anymore (rightly so),
even with this fix applied, correct ?

>  - In another, the GTDT has a timer array of length 2, but only the
>    first structure falls within the length of the overall GTDT

Right.

> Since cnt is the result of doing a bounds-checked walk of the platform
> timer array, both of these issues cause the sanity check to fail.

Yep.

> > >  	if (platform_timer_count)
> > > -		*platform_timer_count = gtdt->platform_timer_count;
> > > +		*platform_timer_count = cnt;
> > 
> > I think this should be fine as things stand (but see above).
> > 
> > It is used in:
> > 
> > gtdt_sbsa_gwdt_init() - just to check if there are platform timers entries
> > 
> > arch_timer_mem_acpi_init() - to create a temporary array to init arch mem timer
> > 			     entries (the array is oversized because it
> > 			     includes watchdog entries in the count)
> > 
> > In both cases taking the
> > 
> > min(cnt, gtdt->platform_timer_count);
> > 
> > should work AFAICS
> 
> It was probably worth noting in the changelog that I did this to
> gracefully handle the reverse of this issue where we could dereference
> platform timer entries that are within the bounds of the GTDT but exceed
> gtdt->platform_timer_count.

Yes, that's strike three, where platform_timer_count is borked,
I understand you have not hit this one though but it seems
right to fix it the way you did.

I am just trying to understand given that we are sending the fix to
stable whether this fix can affect other broken GTDTs (or better, whether
other borked FW can affect this change) but I hope not, it should not.

> > (hard to grok though, we - as in ACPI maintainers -
> > need to clean this up).
> 
> Heh, thought this smelled a little ripe ;-) Went for the minimal fix
> first.

I am sorry you have to deal with this, the kernel is not there to
validate the firmware but on the other hand when it doesn't that's the
outcome. Apologies.

Lorenzo

