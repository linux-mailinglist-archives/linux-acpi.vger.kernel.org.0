Return-Path: <linux-acpi+bounces-19296-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FC4C8B61A
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 19:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D62C3B33CB
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 18:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184F63112AB;
	Wed, 26 Nov 2025 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRxok7sA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AB830F537;
	Wed, 26 Nov 2025 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764180422; cv=none; b=tdrw1y45qxaMBrEM50CGcgdRZk+9u9X8FAT2MiaNV7HHuPUhpIe24jTKJOouLWga+UaU3v7UnYjzut8vPsI8KbskDRm4ULkz0ZwAxbuRAGPSBGUhn0qE1S7PfMjlQOiukPfGB7hLw0ni9KzpZCX2Xdq3SAJpV4sbdnXCPhWfBwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764180422; c=relaxed/simple;
	bh=fpreomXscmd29Nf7GvLFFoVBmW/YcChjeyGOtyWFESE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHRbTgMrRIG78lm8NYfnNGSHSzA0h0hDtm7S102jCotA5ejjPVGIff+p7INyUXy4GB2AXqXKV6GjGZ4xI605SRgpcbR8PRB5BWOppGtUX37cgbTf8kMIEWa/1kYGLYBQI6/2t7JpizR7HXLovIzHcK02OB7gaO8yAE1nXrDKYVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRxok7sA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764180420; x=1795716420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fpreomXscmd29Nf7GvLFFoVBmW/YcChjeyGOtyWFESE=;
  b=SRxok7sA3GDc2mhXAScxBwjv4ZgVOiIeSt95dhcq+KXddR2UqxJIMqWT
   jY8vNFIuXM316t8iUq2UgNDet0IpRDJ25ah7+i8Xxq+Viv540K/KjkO0L
   zBYC+3p5Hdr61DrgYgetqhPbP2EOp9fCgbeUztK1kGk91bXe3DHhbyJdD
   D1cPouDY7ri3XX5AIHcVjdqZoSR3L+reQ10Qj9pT5e65qC85axjp89wz8
   01ZJwQK1fk3q7VPXV6JFdqVvAOKoumIBk9Pw323X6gPwytWsH5r4DbgOR
   QomYRAduvXJYB7QwUpRbk6foUx03q6Zm4l66d0f4PVZ+R4cqj6BpDWAtZ
   A==;
X-CSE-ConnectionGUID: OdlHI+FmQxSlzzYGVvr39g==
X-CSE-MsgGUID: At4CwU4kQ2G9Of1mvBY9rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="76854530"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="76854530"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 10:06:59 -0800
X-CSE-ConnectionGUID: QQtrAVAUQd6HIc4PNcExKQ==
X-CSE-MsgGUID: uD08JMkDQquY5+IBIGflSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="198116036"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 10:06:54 -0800
Date: Wed, 26 Nov 2025 20:06:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
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
Message-ID: <aSdBu-B9mwU2-1_S@smile.fi.intel.com>
References: <20251125023639.2416546-1-lei.xue@mediatek.com>
 <20251125023639.2416546-3-lei.xue@mediatek.com>
 <CAD++jL=h4ZEgrjgGOfgFyAXBM7EL91ZD-La82UQ7GPOXv8h9WQ@mail.gmail.com>
 <aScwaxBG53dnZ4a4@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aScwaxBG53dnZ4a4@lpieralisi>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 05:52:59PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Nov 26, 2025 at 10:10:15AM +0100, Linus Walleij wrote:
> > On Tue, Nov 25, 2025 at 3:36 AM Lei Xue <lei.xue@mediatek.com> wrote:
> > 
> > > Add acpi support in the common part of pinctrl driver. Parsing

ACPI

> > > hardware base addresses and irq number to initialize eint

IRQ

> > > accroding to the acpi table data.

ACPI

> > > Signed-off-by: Lei Xue <lei.xue@mediatek.com>
> > 
> > I'd ideally like Andy and the ARM64 ACPI maintainers look on
> > this. (Added to To:) and CC linux-acpi@vger.kernel.org.
> > 
> > I'm not aware of the best way to deal with ACPI in combined drivers
> > but things like this:
> > 
> > > -               hw->base[i] = devm_platform_ioremap_resource_byname(pdev,
> > > -                                       hw->soc->base_names[i]);
> > > +               hw->base[i] = is_of_node(fwnode)
> > > +                       ? devm_platform_ioremap_resource_byname(pdev, hw->soc->base_names[i])
> > > +                       : devm_platform_get_and_ioremap_resource(pdev, i, NULL);
> > 
> > Just look really quirky, I think there are better ways to go about
> > this and sometimes the ACPI maintainers give some good
> > pushback about the firmware as well.

Agree. It looks fragile.
I believe the best approach is to have fwnode_iomap_byname() and if required
add a quirk to have a software node with names.

> How are pdev->resource initialized ? For OF I suppose the names come from
> "reg-names" (that don't exist in ACPI, yet), for ACPI I assume they come
> from a _CRS (and you can't tag them by name for the reason above) ?

We always can hardcode the names if required in quirks via software nodes.
GPIO has even special data types for that (struct acpi_gpio_mapping).

> I assume that in ACPI the _CRS resource order is foolproof against the
> variaty of SOCs this code has to deal with.

Yeah, that's what we have with GPIOs in a few drivers, the hardcoded quirks.

> I also assume/hope that we don't want to add a "reg-names" _DSD property either
> in ACPI to deal with this seamlessly in DT/ACPI (that was done for
> "interrupt-names"):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/firmware-guide/acpi/enumeration.rst?h=v6.18-rc7#n188

Hmm... Why not?

> I am sorry I have got more questions than answers here - it would be good
> to understand where the line is drawn when it comes to OF/ACPI and fwnode
> heuristics compatibility.

-- 
With Best Regards,
Andy Shevchenko



