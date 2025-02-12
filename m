Return-Path: <linux-acpi+bounces-11090-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E40A32385
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 11:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FD918850E8
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 10:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49E3207A2C;
	Wed, 12 Feb 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apDjr8av"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3791F9A83;
	Wed, 12 Feb 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356413; cv=none; b=ABTvYvJVIykOsUvigokedw/FM4PHHW6zK3IEBNfjWD1qKsur9vnt9rR9tkEqiKXfJJqA79zXGer+ga491KaqSnoIgPhhUnS4IOFH6F879NHzkAz2MnxxJiGq5w7YGWjfCGj8sV96TfSrGlW7dk7a/b383+AO3ydzqUUP+yhX3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356413; c=relaxed/simple;
	bh=JjXhB+/E2GYRT9cPPM8Yrb46y4WEBtQtoQZkMTTIIsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqoR3e9bMUA2vpedYLn13MkDciBUiYB1kIprWmTbnRt1QXkSaLYf+JKgYKQfkn7iJ35ldKNOlAup1zzJoT0Fi4zQT1CPwYZl+cF17y29j1yRFpQtZOAA2YppkSA0LSJmZud5FPaOpmAusJYcDLzr0OKgaCeQkpxsnML/txUPY+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apDjr8av; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D81C4CEDF;
	Wed, 12 Feb 2025 10:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739356413;
	bh=JjXhB+/E2GYRT9cPPM8Yrb46y4WEBtQtoQZkMTTIIsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apDjr8avlkhnXF3iYJxdGj3L2E/iuYjYY0W+1VgglUF2zyfjUBWv/QfwhUWcaktWx
	 f9zy5MauWALBXh1TzaiMxPgJc5g3WqukiknGRksl/qBTThVZopPV23wgS/UC91rcMT
	 y/gN3QnR5SLCS9sxxG+8vIxJT9FZ2OwGzBnbTURQT8aczBtFfJYvJ5mkQtfx59UXvn
	 pHMA1MLQ3ZKAPDKLMreZ7FRFiL+lASvFeKqtNzzTftT6xA9rQ1FD6csCO/Vmj0bBy4
	 2VrLr0k5JgYH3PusfRJfAiNhPBF5evGq/gRaKsEJqxPnm6BQqdXB3FAbX5H05tKNkA
	 Mr68rTFdKG2IA==
Date: Wed, 12 Feb 2025 11:33:27 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Zheng Zengkai <zhengzengkai@huawei.com>
Subject: Re: [PATCH] ACPI: GTDT: Relax sanity checking on Platform Timers
 array count
Message-ID: <Z6x4987CJ0zgmw3s@lpieralisi>
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
> 
>  - In another, the GTDT has a timer array of length 2, but only the
>    first structure falls within the length of the overall GTDT
> 
> Since cnt is the result of doing a bounds-checked walk of the platform
> timer array, both of these issues cause the sanity check to fail.
> 
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

Hi Oliver,

I was about to ask Catalin/Will to pick this up, don't know if you have
time to update the changelog and send a v2 - a Link: to this thread will
be added anyway.

Thanks,
Lorenzo

