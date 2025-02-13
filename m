Return-Path: <linux-acpi+bounces-11147-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E270DA33E56
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 12:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF75169D68
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E9C214A62;
	Thu, 13 Feb 2025 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMG7NNJF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EA421422A;
	Thu, 13 Feb 2025 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447110; cv=none; b=k0SsreSZ3N1vb4JTBqpPYfYV8v3fST4Jyd2Axwb1DzvQnoP3HO76J/rJN4fQ5aQ+x8+vxzk/xIUDef6Y6Nw94c+fMPOZDDQaJ2fue8YhT6XysFii+FphbNuQkMzTJ4z4abwB0yia8Z/YVirmTb+PeMPbSshNrlPRnWGohKgLAzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447110; c=relaxed/simple;
	bh=mOOLLj+OAy5y5nKK1dSt8RN8ouLFYKPIqvCP4TBrOv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo1iIJc064qZYipgQCNNOwSb9GGJkMberQeJjPT/3NJ0x/ynxChe5bX1zUdcxQXBdYzWFh4y4GMgt5yBWz3coZkKTBQpf9ZbVrzzGI+pk5JIMkdepoTCG9DvbYsCk+y4iE14zL7jqxJArN3Gp6ubE+CrtOz567CG4jfTFonDDQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMG7NNJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E026C4CEE7;
	Thu, 13 Feb 2025 11:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739447110;
	bh=mOOLLj+OAy5y5nKK1dSt8RN8ouLFYKPIqvCP4TBrOv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMG7NNJFwxt/ZZSSaYrBF1pZzHuNU8g/iOuIMkgoOhoGsEl6FOH9szsYcntNMZCZI
	 lYVR9QILZyWjlvs937vrDA73/FOwFRrqhIfL2pjgcDlyPRuvgaa7hgLqwwYjPJwkcB
	 s6ju/uZy0wn9eyhjwRzrAP6I0DfHXiAWyeXOnCf2WLzlgj8+hA1usc2SrE7uGikWDz
	 vCb/a+1OYPjr4/9o/GJgd3LGYHXLnbFax6R+6BTLFsZ8Zh54HP+2VoFZKNeXNHVLsc
	 jf47WrCUnGAhvRFcTbOgfDS0gNpWWaGQjqyGMY02zyHAXY4lcY5CssrwgTqzsK7836
	 VTivT3D76IP2w==
Date: Thu, 13 Feb 2025 11:45:04 +0000
From: Will Deacon <will@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Zheng Zengkai <zhengzengkai@huawei.com>
Subject: Re: [PATCH] ACPI: GTDT: Relax sanity checking on Platform Timers
 array count
Message-ID: <20250213114503.GA11508@willie-the-truck>
References: <20250128001749.3132656-1-oliver.upton@linux.dev>
 <Z5i2j9gFB2iyN9g4@lpieralisi>
 <Z5lBMBY7XoFJmpGM@linux.dev>
 <Z6x4987CJ0zgmw3s@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6x4987CJ0zgmw3s@lpieralisi>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 12, 2025 at 11:33:27AM +0100, Lorenzo Pieralisi wrote:
> > > I think this should be fine as things stand (but see above).
> > > 
> > > It is used in:
> > > 
> > > gtdt_sbsa_gwdt_init() - just to check if there are platform timers entries
> > > 
> > > arch_timer_mem_acpi_init() - to create a temporary array to init arch mem timer
> > > 			     entries (the array is oversized because it
> > > 			     includes watchdog entries in the count)
> > > 
> > > In both cases taking the
> > > 
> > > min(cnt, gtdt->platform_timer_count);
> > > 
> > > should work AFAICS
> > 
> > It was probably worth noting in the changelog that I did this to
> > gracefully handle the reverse of this issue where we could dereference
> > platform timer entries that are within the bounds of the GTDT but exceed
> > gtdt->platform_timer_count.
> 
> Hi Oliver,
> 
> I was about to ask Catalin/Will to pick this up, don't know if you have
> time to update the changelog and send a v2 - a Link: to this thread will
> be added anyway.

I'll pick it up with the Link: tag, no need to resend.

Thanks, both!

Will

