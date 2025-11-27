Return-Path: <linux-acpi+bounces-19330-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4570EC8F5D2
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 16:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A153C4E8091
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26400313266;
	Thu, 27 Nov 2025 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYpXrYRb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE21A283FDD;
	Thu, 27 Nov 2025 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258847; cv=none; b=tKTVQs8sqzq1jSfjWk+cFbENoI4+18USWl6gGXXKygXnbToegOmFYEsnGjFW9MYsygffOFLg6b0+E3go0oc8+REwMCoNttBMekFJK1lKfM5OdFA3NN4cZMUaa6gnFnFgb/HW1JmRXAQe8QBLLzhPi25xEs0o3WK2phRQwlXIe8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258847; c=relaxed/simple;
	bh=XZh8Am0flcWfvfawgkFuAwpjKDq4TvWS83SNiDd6NuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xmsdi8/DoPgHMRsKV2TA6j/hdbODh36flonfJpmRG0b5gcx7RSVbcTcHWSghCuuFqZMJ4mV3PiMmn2qM+SmhTOgpgh9rVbV18tiqycIf73e3ZtF2M92XKXCDJ/vVedyvsQCxZdKZI3FQk7tERcr/+WG0bAaJGpkUbvB1di/Oick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYpXrYRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E5FC4CEF8;
	Thu, 27 Nov 2025 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764258845;
	bh=XZh8Am0flcWfvfawgkFuAwpjKDq4TvWS83SNiDd6NuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYpXrYRbASFQ/9C7rRjqhxSeT8JnwjTbo4WJZiENuT7AhCcej8OJBAsDWtVvVmn5i
	 +UtH1RmYTAlvNsvN6yCy0IJyC8UNmxTRoWVYCTJdUB+5v2A5idsCX2R2CE8MFBaqKR
	 w3cF4GwCXK/hTW2vp0Fnoi29iGXNwjOjDK4KBFKiBQoNSbUAWkIYMRKHgDuN1ONAck
	 QP8rn/5x9NVcW2CNY+Juz82e3owgEu2GOj0w/J/l60+dhxszr0VU6bwF1J1WHn6QCE
	 2mAsHwIsZKFZiT9oDVPtPWrySL9normVU7tUlcJXeYLk+A351eDTpTLrCKX8XYTcgy
	 b/aMZxFMxgwYg==
Date: Thu, 27 Nov 2025 16:53:55 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linusw@kernel.org>, Lei Xue <lei.xue@mediatek.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	yong.mao@mediatek.com, qingliang.li@mediatek.com,
	Fred-WY.Chen@mediatek.com, ot_cathy.xu@mediatek.com,
	ot_shunxi.zhang@mediatek.com, ot_yaoy.wang@mediatek.com,
	ot_ye.wang@mediatek.com, linux-acpi@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH 2/3] pinctrl: mediatek: Add acpi support
Message-ID: <aSh0EyGm9ZHAc3dN@lpieralisi>
References: <20251125023639.2416546-1-lei.xue@mediatek.com>
 <20251125023639.2416546-3-lei.xue@mediatek.com>
 <CAD++jL=h4ZEgrjgGOfgFyAXBM7EL91ZD-La82UQ7GPOXv8h9WQ@mail.gmail.com>
 <aScwaxBG53dnZ4a4@lpieralisi>
 <aSdBu-B9mwU2-1_S@smile.fi.intel.com>
 <aSgipbe75hrwhTD7@lpieralisi>
 <aShgYukPRfDkq_Z0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aShgYukPRfDkq_Z0@smile.fi.intel.com>

On Thu, Nov 27, 2025 at 04:29:54PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 27, 2025 at 11:06:29AM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Nov 26, 2025 at 08:06:51PM +0200, Andy Shevchenko wrote:
> 
> [...]
> 
> > > > I also assume/hope that we don't want to add a "reg-names" _DSD property either
> > > > in ACPI to deal with this seamlessly in DT/ACPI (that was done for
> > > > "interrupt-names"):
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/firmware-guide/acpi/enumeration.rst?h=v6.18-rc7#n188
> > > 
> > > Hmm... Why not?
> > 
> > What's the policy there ?
> 
> > Half of the ACPI bindings for an interrupt
> > descriptor are defined in the ACPI specs (ie _CRS) and the other half
> > (ie "interrupt-names") is documented in the Linux kernel (or are we
> > documenting this elsewhere ?) ?
> 
> Yeah, nobody pursued ACPI specification updates / addendum to make it fully
> official. _De facto_ we have established practice for GPIOs enumeration
> (as most used resources in the OSes), Linux official for PWM, I²C muxes,
> multi-functional HW (such as Diolan DLN-2, LJCA), Microsoft defined for
> so called "USB hardwired" devices, Linux defined for LEDs and GPIO keys,
> sensor mount matrix as per "most used" cases + DT analogue works just
> because we have agnostic APIs in IIO to retrieve that. There are maybe
> more, but don't remember
> 
> So, I think the practical "policies" are that:
> - if it's defined in ACPI spec, we use the spec
> - if there is Microsoft addendum, we rely on what Windows does
> - WMI, EFI, and other "windoze"-like vendor defined cases
> - if it makes sense, we establish practice from Linux perspective
> - the rest, every vendor does what it does
> 
> That said, for the first two we expect OEMs to follow, for the third one
> depends, but there are established WMI calls and other more or less "standard"
> interfaces, so like the first two.
> 
> For the fourth one (Linux) we do, but living in the expectation that some or
> more vendors fall to the fifth category and we might need to support that if
> we want their HW work in Linux.
> 
> > Or we are saying that "interrupt-names" properties are added by kernel
> > code _only_ (through software nodes, to make parsing seamless between DT
> > and ACPI) based on hardcoded name values in drivers ?
> 
> No, the idea behind software nodes is to "fix" the FW nodes in case the FW
> description can not be modified (and that might well happen to even DT in some
> cases AFAIH). So, if some driver hard codes "interrupt-names" we expect that
> new versions of the FW that support the HW that needs the property will be
> amended accordingly.
> 
> "interrupt-names" has been established for ACPI to support a separate SMB alert
> interrupt. However, I haven't heard any development of that IRL (for real
> devices in ACPI environment).
> 
> > I don't think I can grok any example of the latter in the mainline.
> > 
> > I am asking because I'd need to add something similar shortly to make parsing
> > of platform devices created out of ACPI static tables easier (I guess we
> > can postpone discussion till I post the code but I thought I'd ask).
> 
> Oh, I can go ahead and tell you, try to avoid that. Why?! Whatever,
> indeed, please Cc me to that, I will be glad to study the case and
> try to be helpful.
> 
> (Have you considered DT overlays instead? There is a big pending support for
>  that for _ACPI_ platforms.)

Long story short: we do need to create platform devices out of static
table (eg ARM64 IORT) entries. Current code parses the table entries and
try to map the devices IRQs (ie acpi_register_gsi()) when the platform
device is created. Now, the interrupt controller that device IRQ's is
routed to might not have probed yet. We have to defer probing and later,
when the platform driver probes, map the IRQ.

Issue is: for OF nodes and ACPI devices, behind the platform device
firmware node there is a standard firmware object, so implementing
fwnode_irq_get() is trivial. For the devices I am talking about,
the data providing GSI info (hwirq, trigger/polarity) is static
table specific, so the idea was to stash that data and embed it in
fwnode_static along with a irq_get() fwnode_operations function
specific to that piece of data so that device drivers can actually do:

fwnode_irq_get()

on the fwnode _seamlessly_ (if you still do wonder: those platform
devices created out of static table entries in ACPI in OF are
of_node(s)).

There is a less convoluted solution (that is what some platform
drivers in ACPI do today), that is, we pass the static table
data in pdev->dev.platform_data and each platform_driver parses it differently.

That works but that also means the in the respective device drivers
OF and ACPI IRQ (and MMIO) parsing differ (which is not necessarily
a problem I just have to rewrite them all).

Now - when it comes to "interrupt-names". Some of the device drivers
I mention do:

eg platform_get_irq_byname_optional()

that expects the IRQ to be mapped and stored in a named platform device resource.

That's easy in DT - for two reasons:

(1) "interrupt-names"
(2) standard properties behind the of_node

how to do that for fwnodes that aren't backed by either OF nodes or ACPI
devices (that do use "interrupt-names" _DSD property) is a question.

Mind, the "interrupt-names" thing is a detail in the whole mechanism.

DT overlays to represent in ACPI those static table entries ?

I vividly remember the days ACPI for ARM64 was being merged - that's what
our crystal ball predicted :)

This delayed IRQ mapping notwithstanding, I read what you wrote and took
note. The worry is, this fwnode_*() (on ACPI nodes) interface trickling
into subsystems where it should not (ie PCI, clocks, regulators) - hopefully
the respective maintainers are keeping an eye on it.

Thanks,
Lorenzo

> > Are we going to do the same for "reg-names" ?
> 
> If it makes sense and we expect some vendor to follow that _in ACPI_,
> why not?
> 
> > Most importantly, what is DT maintainers stance on the matter ?
> 
> AFAIK They don't care as long as there is a schema provided, accepted and
> used in DT, if it's ACPI-only thing, then it most likely should be done
> in ACPI-like way (see above the first two / three items: spec, MS, WMI/EFI).
> 
> > > > I am sorry I have got more questions than answers here - it would be good
> > > > to understand where the line is drawn when it comes to OF/ACPI and fwnode
> > > > heuristics compatibility.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

