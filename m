Return-Path: <linux-acpi+bounces-7973-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A65964D5B
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 19:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475431F22F10
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB341B6545;
	Thu, 29 Aug 2024 17:59:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209741B5824
	for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954355; cv=none; b=UHokmGOH0VfH+cd2hVssaNv/K7NAbloX+DMIL6HZV/i3/Ylbl6KXTif3xUSEaKpnIYEIDdvVYTa0U10z6UWO4vpmibb/L2mKt7h682W62QMU4kqYanhK+sYE2vOD+MgUBifz+J20ddRPrjdXJU7MG9ghY5p0YgRBUYZaJTMXy40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954355; c=relaxed/simple;
	bh=1uBP7ZtDpO7WmioTXxs7gKKRM78GV0Ri0C+m8EiT3y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWmGd3pVn8eg8kmc5Pr/+QhJWFx1u9z0tTeK10/itqrk9cSR3dlXPfB7NKu8KJzUPUZbTOZ5Dj6eUlVIH69PyDMJYBvdX0yfhXdwdDvl53FzsYqFJpPmxd3FEP6k7WU15KSzLJstHzR7peDRFPCmLYC22qk7DoTdotuCI6z/r6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 636061477;
	Thu, 29 Aug 2024 10:59:38 -0700 (PDT)
Received: from bogus (unknown [10.57.87.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E3D83F762;
	Thu, 29 Aug 2024 10:59:10 -0700 (PDT)
Date: Thu, 29 Aug 2024 18:58:56 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Miao Wang <shankerwangmiao@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>, Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] ACPI: introduce acpi_arch_init
Message-ID: <20240829175856.GA936920@bogus>
References: <20240808-intro-acpi-arch-init-v3-1-ba510859baff@gmail.com>
 <64bd9991-61a9-5cb5-60fe-941cb4171290@huawei.com>
 <4EC8AF0D-321F-437B-93C6-E597E4D4BB34@gmail.com>
 <ZtCbLIfCklb5kQN1@bogus>
 <CAJZ5v0hXW+oH6KkJiXP7mtg2rgvgy85D_x6snckaA=cw9iFy6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hXW+oH6KkJiXP7mtg2rgvgy85D_x6snckaA=cw9iFy6Q@mail.gmail.com>

On Thu, Aug 29, 2024 at 06:42:16PM +0200, Rafael J. Wysocki wrote:
> On Thu, Aug 29, 2024 at 6:00 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Aug 28, 2024 at 04:40:29AM +0800, Miao Wang wrote:
> > >
> > >
> > > > 2024年8月8日 17:43，Hanjun Guo <guohanjun@huawei.com> 写道：
> > > >
> > > > On 2024/8/8 17:00, Miao Wang via B4 Relay wrote:
> > > >> From: Miao Wang <shankerwangmiao@gmail.com>
> > > >> To avoid arch-specific code in general ACPI initialization flow,
> > > >> we introduce a weak symbol acpi_arch_init. Currently, arm64 can
> > > >> utillize this to insert its specific flow. In the future,
> > > >> other architectures can also have chance to define their own
> > > >> arch-specific acpi initialization process if necessary.
> > > >> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> > > >> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > > >> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > >> ---
> > > >> Changes from v1
> > > >> - Change acpi_arch_init from a static inline stub to a weak function
> > > >>   according to Haijun Guo's advice
> > > >> ---
> > > >> Changes from v2:
> > > >> - Add __init attribute to the weak acpi_arch_init stub
> > > >> - Link to v2: https://lore.kernel.org/r/20240807-intro-acpi-arch-init-v2-1-9231e23a7721@gmail.com
> > > >
> > > > Thanks for the quick update,
> > > >
> > > > Acked-by: Hanjun Guo <guohanjun@huawei.com>
> > >
> > > Hi, all. I wonder whether this patch is good to be applied or
> > > any improvement is needed.
> > >
> >
> > LGTM. Rafael, do you want to take this via your tree or arm64(need your ack)
> > once you are happy with the change ?
> 
> Actually, I'd prefer the RISCV ACPI changes to land first:
> 
> https://lore.kernel.org/linux-acpi/20240812005929.113499-1-sunilvl@ventanamicro.com/
> 
> and then it can be consolidated to use acpi_arch_init() in both places.
> 
> I'm going to move the RISCV material to linux-next on Monday, but I'd
> prefer to defer the consolidation to the 6.13 cycle (after 6.12-rc1 is
> out).

Makes sense, thanks!

-- 
Regards,
Sudeep

