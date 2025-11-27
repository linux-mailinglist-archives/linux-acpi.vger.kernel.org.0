Return-Path: <linux-acpi+bounces-19324-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 217E4C8F2A1
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 16:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8B0E345997
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533903358C0;
	Thu, 27 Nov 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrlaFN+D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAA83358B8;
	Thu, 27 Nov 2025 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256073; cv=none; b=Ok4qgxOwCFvVmU44Y4kYvP1P9P53ODFLeUilt53MRFX7HR6La2lK02hJHDN0AnYs/9kRbokm73m87I1Ei9YXptEhi8cd3K4+pw1ypNV111C5uKxKmkhYTMxGwIUmUwdXg226aWcNpq+jgNURYmqcIMCs0RmJj0irPnnREsiJtFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256073; c=relaxed/simple;
	bh=ljqisYxitm41njQJO3ODA5Tj4UjflqDfTeVkqfWZ5wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk1fy71aAuE7eNR6dpl6P0QQx125+qQ6a3zjGa326ZNXsMadSA276L7O20VlY6nGw+WN9F6IVXVQbfn2ZMDo7pGyoQ+FZNBcVgPzHamfubEbapM45snYKKVFOLjsUBMgHk9Jf+BBGZqMJm9K9imN8rNDBZC/gAiewRcKUFnW144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrlaFN+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE99C4CEF8;
	Thu, 27 Nov 2025 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764256072;
	bh=ljqisYxitm41njQJO3ODA5Tj4UjflqDfTeVkqfWZ5wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrlaFN+DxhPEopF4u1BSSkEWsdgz3Zjc007UUR282fJ8vAQzbEdZjKK63IwiF8dt5
	 JXXUdSNtsKzOnEp5K9GgMfxSnGwYFDehW4B7hpuJ6hwQsUzqXfpBzEF1wmFq1LFNxD
	 FFQCgevTmbhGjxmUVl3SXTGJly3BWOLNji71u0f5FnLluk3LLuc1L7xWIXH4otX5c1
	 G431auMrbTS8eOgxpn6GdsM3l+9iA+z1rqokCx5CmjpbbjCiMbdDmAoO4+qTQTP5aZ
	 BUX+DRiINTx3Mnd3zeccaodqPpn7oRJl16g/TKtVld9UL/fR3myD5XmhVlWSfx/gMg
	 uglyXPyqSwL9A==
Date: Thu, 27 Nov 2025 15:07:47 +0000
From: Will Deacon <will@kernel.org>
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ACPI: GTDT: Correctly number platform devices for MMIO
 timers
Message-ID: <aShpQ4iDceJ7-Nzs@willie-the-truck>
References: <20251030110115.1842961-1-maz@kernel.org>
 <c1edd6cc-0542-8d22-6edc-60c619c9e162@huawei.com>
 <861plrsr1l.wl-maz@kernel.org>
 <5a742d2a-ac57-f060-913a-6bc9db1e71a2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a742d2a-ac57-f060-913a-6bc9db1e71a2@huawei.com>

Hey Hanjun,

On Fri, Nov 21, 2025 at 09:14:04PM +0800, Hanjun Guo wrote:
> On 2025/11/21 16:55, Marc Zyngier wrote:
> > On Fri, 21 Nov 2025 02:53:17 +0000,
> > Hanjun Guo <guohanjun@huawei.com> wrote:
> > > 
> > > On 2025/10/30 19:01, Marc Zyngier wrote:
> > > > Use the actual timer counter instead of the watchdog counter.
> > > > 
> > > > Fixes: 5669d92f3efa4 ("ACPI: GTDT: Generate platform devices for MMIO timers")
> > > > Reported-by: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
> > > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > > Cc: Hanjun Guo <guohanjun@huawei.com>
> > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > ---
> > > >    drivers/acpi/arm64/gtdt.c | 4 ++--
> > > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> > > > index fd995a1d3d248..8cc8af8fd408c 100644
> > > > --- a/drivers/acpi/arm64/gtdt.c
> > > > +++ b/drivers/acpi/arm64/gtdt.c
> > > > @@ -430,10 +430,10 @@ static int __init gtdt_platform_timer_init(void)
> > > >    				continue;
> > > >      			pdev = platform_device_register_data(NULL,
> > > > "gtdt-arm-mmio-timer",
> > > > -							     gwdt_count, &atm,
> > > > +							     mmio_timer_count, &atm,
> > > >    							     sizeof(atm));
> > > >    			if (IS_ERR(pdev)) {
> > > > -				pr_err("Can't register timer %d\n", gwdt_count);
> > > > +				pr_err("Can't register timer %d\n", mmio_timer_count);
> > > >    				continue;
> > > >    			}
> > > 
> > > "typo" I think :)
> > > 
> > > Acked-by: Hanjun Guo <guohanjun@huawei.com>
> > > 
> > > Will this go via ARM64 tree?
> > 
> > Is that where the ACPI updates are routed to? This fixes a patch that
> > was routed tip, so I'd have expected this to go via the same route.
> > 
> > In any case, I've added Catalin and Will on Cc.
> 
> Yes, ARM64 ACPI code merged via ARM64 tree.

Catalin and I were chatting the other day and we wondered whether it's
worth adding something to MAINTAINERS so that we get CC'd on arm64 ACPI
patches without you having to add us in manually? We wouldn't merge
anything without an Ack from somebody listed under the "ACPI FOR ARM64"
entry but it would mean that we get picked up by get_maintainer.pl.

What do you think?

I can't tell whether this would be best as an F: line under the arm64
architecture entry, or adding us as R:/M: for the ACPI/arm64 entry.

Will

