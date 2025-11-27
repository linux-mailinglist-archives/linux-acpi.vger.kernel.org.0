Return-Path: <linux-acpi+bounces-19313-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580FC8EC18
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 15:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A873AAAE8
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 14:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602783328F2;
	Thu, 27 Nov 2025 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJW+4vYz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410C823717F;
	Thu, 27 Nov 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764253804; cv=none; b=We+MNiyPmEPugDHqXedCafxtMNtPaSX95YNNtVh4+fu4ZAHHsVTRJosIHJnCStTlCGreTzG+ncJ3kz90DcpANXxhxEyfLoycRGWbK6O3Ota49XMFueIdRkhW4DIQKa1u6Hw3LxeRAIkVlzbWUc/KUwlunxA9OD2YwxnC61MZing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764253804; c=relaxed/simple;
	bh=wV3E8BYGDfNKefQX/rsj0hZUZjUWd8J11Hu9YUDDBXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2Phw3BwEozXEzos/ZTJ9VZJyhw2RSSfdIXmtoszy4og8GKSKpcl4BdHmnqip4C99tSEsGWW6/diR0wSe8H28JBSwhAD/pLlXwQJ2AM60Gc8JYS25hLSKafeHZ+nQyk5AvEWBo9IkdhqHfQvhirVNhrCKXlIR0SRpZ8vhSz8SpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJW+4vYz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764253802; x=1795789802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wV3E8BYGDfNKefQX/rsj0hZUZjUWd8J11Hu9YUDDBXM=;
  b=hJW+4vYzFHlSnaa/O7xpKIL9/UEMsq/np1XVKO0SxYCx0tIOpBIWgxF+
   5O0Y5B0MnyRYTZS6nwZ9hHK5VuwfpgA4s4PvwykXICIg90kcem+ytzHhf
   J43535xRHyP3YXdouIcy8Y4+iMXfYftV0YwTalBoQGq5JCplYnX1HqTqR
   67iznbEhDTGFgNyeaQm7KKYXBXfZ8RHSrqUuDImhoM05w2NFFYaks0oMP
   8YN1Vum9PweIT9AQin6j53IN2fp4q8yafdphptP3Mc9X/EM4dXnsUWxXF
   tDS7A/A8AJkIMpeyn1HKTLBCzrUtMwYsgW6fr7WZ8Sx4ld4tN5iW6PmxL
   Q==;
X-CSE-ConnectionGUID: FcsgSA8JRKeNq0dwqrmEhQ==
X-CSE-MsgGUID: 6k26OwAMSkGOiQ5mReHcrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="77662590"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="77662590"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 06:30:01 -0800
X-CSE-ConnectionGUID: A4KmkT6hSRCb9jEmqznsow==
X-CSE-MsgGUID: K4CHSgcNSc+gBla+AVuQ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="198188135"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 06:29:56 -0800
Date: Thu, 27 Nov 2025 16:29:54 +0200
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
Message-ID: <aShgYukPRfDkq_Z0@smile.fi.intel.com>
References: <20251125023639.2416546-1-lei.xue@mediatek.com>
 <20251125023639.2416546-3-lei.xue@mediatek.com>
 <CAD++jL=h4ZEgrjgGOfgFyAXBM7EL91ZD-La82UQ7GPOXv8h9WQ@mail.gmail.com>
 <aScwaxBG53dnZ4a4@lpieralisi>
 <aSdBu-B9mwU2-1_S@smile.fi.intel.com>
 <aSgipbe75hrwhTD7@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSgipbe75hrwhTD7@lpieralisi>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 27, 2025 at 11:06:29AM +0100, Lorenzo Pieralisi wrote:
> On Wed, Nov 26, 2025 at 08:06:51PM +0200, Andy Shevchenko wrote:

[...]

> > > I also assume/hope that we don't want to add a "reg-names" _DSD property either
> > > in ACPI to deal with this seamlessly in DT/ACPI (that was done for
> > > "interrupt-names"):
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/firmware-guide/acpi/enumeration.rst?h=v6.18-rc7#n188
> > 
> > Hmm... Why not?
> 
> What's the policy there ?

> Half of the ACPI bindings for an interrupt
> descriptor are defined in the ACPI specs (ie _CRS) and the other half
> (ie "interrupt-names") is documented in the Linux kernel (or are we
> documenting this elsewhere ?) ?

Yeah, nobody pursued ACPI specification updates / addendum to make it fully
official. _De facto_ we have established practice for GPIOs enumeration
(as most used resources in the OSes), Linux official for PWM, I²C muxes,
multi-functional HW (such as Diolan DLN-2, LJCA), Microsoft defined for
so called "USB hardwired" devices, Linux defined for LEDs and GPIO keys,
sensor mount matrix as per "most used" cases + DT analogue works just
because we have agnostic APIs in IIO to retrieve that. There are maybe
more, but don't remember

So, I think the practical "policies" are that:
- if it's defined in ACPI spec, we use the spec
- if there is Microsoft addendum, we rely on what Windows does
- WMI, EFI, and other "windoze"-like vendor defined cases
- if it makes sense, we establish practice from Linux perspective
- the rest, every vendor does what it does

That said, for the first two we expect OEMs to follow, for the third one
depends, but there are established WMI calls and other more or less "standard"
interfaces, so like the first two.

For the fourth one (Linux) we do, but living in the expectation that some or
more vendors fall to the fifth category and we might need to support that if
we want their HW work in Linux.

> Or we are saying that "interrupt-names" properties are added by kernel
> code _only_ (through software nodes, to make parsing seamless between DT
> and ACPI) based on hardcoded name values in drivers ?

No, the idea behind software nodes is to "fix" the FW nodes in case the FW
description can not be modified (and that might well happen to even DT in some
cases AFAIH). So, if some driver hard codes "interrupt-names" we expect that
new versions of the FW that support the HW that needs the property will be
amended accordingly.

"interrupt-names" has been established for ACPI to support a separate SMB alert
interrupt. However, I haven't heard any development of that IRL (for real
devices in ACPI environment).

> I don't think I can grok any example of the latter in the mainline.
> 
> I am asking because I'd need to add something similar shortly to make parsing
> of platform devices created out of ACPI static tables easier (I guess we
> can postpone discussion till I post the code but I thought I'd ask).

Oh, I can go ahead and tell you, try to avoid that. Why?! Whatever,
indeed, please Cc me to that, I will be glad to study the case and
try to be helpful.

(Have you considered DT overlays instead? There is a big pending support for
 that for _ACPI_ platforms.)

> Are we going to do the same for "reg-names" ?

If it makes sense and we expect some vendor to follow that _in ACPI_,
why not?

> Most importantly, what is DT maintainers stance on the matter ?

AFAIK They don't care as long as there is a schema provided, accepted and
used in DT, if it's ACPI-only thing, then it most likely should be done
in ACPI-like way (see above the first two / three items: spec, MS, WMI/EFI).

> > > I am sorry I have got more questions than answers here - it would be good
> > > to understand where the line is drawn when it comes to OF/ACPI and fwnode
> > > heuristics compatibility.

-- 
With Best Regards,
Andy Shevchenko



