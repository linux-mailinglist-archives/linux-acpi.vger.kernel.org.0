Return-Path: <linux-acpi+bounces-15828-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AEFB2B94B
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 08:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07561889B5C
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 06:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD7622A808;
	Tue, 19 Aug 2025 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ao/TUpzo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9A138B;
	Tue, 19 Aug 2025 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584305; cv=none; b=KfOQgPlivi6USLvAV1Cs+MJ7lj6EYGJW5XhWs5rkZCLYG4t15+x82h7DWxADxlyMDMtvj7IzPDul+kFv5Q548zYxQA4xcupMX1JMdoNKk+OBtgjNp96g82amNRbnEFqEnQUJtcINmE51JP/BCWav1rnehPZbq/DrSpoXP0fY86s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584305; c=relaxed/simple;
	bh=csN9gHgo3L9lRWJe0nMxew2Yzmsh9jwnHiRF0xA4jCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7etEPt6Gvl/FHtN9g1UZ4JUW2ZQt/wYKTHuwV6j1/0JZxIhAySgpt47LbpLPRriTTAvwMN1/Y+HrSx2wE1Iasu2rC6dTxAiCUetV259Q6mcUrJiNRiN52Uz3AuCGkK8xyFWaPdj/cKRi3Kp01j7NNSq6KFsGNhuHBoTbLlnlPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ao/TUpzo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755584304; x=1787120304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=csN9gHgo3L9lRWJe0nMxew2Yzmsh9jwnHiRF0xA4jCc=;
  b=Ao/TUpzomJGE8epFk4Iz1faiBpf3H9+qGHq6FhJCPyS4UkeSjlvTGU50
   78ON5DXwlhs8R8Cl1hfmxBfg47S7f/5LEpE5EqAvv9xlcY3xCXJlqQqrO
   oPqoeSd3i36dO2aqR4IIZMupD943V6iG6Ifs93wCTsD/y11MGHz9YLTjz
   sazX20zYjimsMhFU1D8rejMlGuXF7JWnAAcqdjMKNIFF0JrwX+EGd9upe
   h5aHRy29BEj0TzVt13OEyPOAjfHojqZmvoT+HO2bgIxRlXs42bpMithf+
   56utq8KdWwwyGVbzGml6P17eHhDXehmmjpG/EMIqF76HY2Q2AmkoluGj8
   A==;
X-CSE-ConnectionGUID: Mb4NyWvcRX2pS4QOyHIJ4Q==
X-CSE-MsgGUID: Zk6RNbq4RKqrfvjq+9VKqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="69269370"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="69269370"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 23:18:17 -0700
X-CSE-ConnectionGUID: hANu7aKkT32cGu5lWMasrQ==
X-CSE-MsgGUID: A6xUup3sQIaFVavzb7OEnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="198787477"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 18 Aug 2025 23:18:15 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 6C12B93; Tue, 19 Aug 2025 08:18:13 +0200 (CEST)
Date: Tue, 19 Aug 2025 08:18:13 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, westeri@kernel.org,
	andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
	brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Program debounce when finding GPIO
Message-ID: <20250819061813.GJ476609@black.igk.intel.com>
References: <20250818015219.3604648-1-superm1@kernel.org>
 <20250818045538.GH476609@black.igk.intel.com>
 <08dd199e-0e7d-44b8-b980-5fde226cd636@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08dd199e-0e7d-44b8-b980-5fde226cd636@kernel.org>

On Mon, Aug 18, 2025 at 01:03:48PM -0500, Mario Limonciello wrote:
> On 8/17/25 11:55 PM, Mika Westerberg wrote:
> > Hi,
> > 
> > On Sun, Aug 17, 2025 at 08:52:07PM -0500, Mario Limonciello (AMD) wrote:
> > > When soc-button-array looks up the GPIO to use it calls acpi_find_gpio()
> > > which will parse _CRS.
> > > 
> > > acpi_find_gpio.cold (drivers/gpio/gpiolib-acpi-core.c:953)
> > > gpiod_find_and_request (drivers/gpio/gpiolib.c:4598 drivers/gpio/gpiolib.c:4625)
> > > gpiod_get_index (drivers/gpio/gpiolib.c:4877)
> > > 
> > > The GPIO is setup basically, but the debounce information is discarded.
> > > The platform will assert what debounce should be in _CRS, so program it
> > > at the time it's available.
> > 
> > The spec says for GpioInt():
> > 
> >    DebounceTimeout is an optional argument specifying the debounce wait
> >    time, in hundredths of milliseconds. The bit field name _DBT is
> >    automatically created to refer to this portion of the resource
> >    descriptor.
> > 
> > I was not sure but wanted to check that if it is left out, does ACPICA fill
> > it with 0? If yes (I would expect so) then this is fine.
> 
> Yeah AFAICT you're right.  The ACPI resource is zero'ed out, so if the field
> was empty it should default to zero.

Okay good.

Then from my perspective,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> > 
> > > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > > ---
> > > v4:
> > 
> > You missed "v4" in the $subject.
> 
> Whoops, thanks.  If there ends up being a reason to spin I'll send the next
> one as a v5.
> 
> > 
> > >   * Just add a direct call instead
> > >   * drop tag
> > >   * update commit message
> > > ---
> > >   drivers/gpio/gpiolib-acpi-core.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
> > > index 12b24a717e43f..6388e8e363dee 100644
> > > --- a/drivers/gpio/gpiolib-acpi-core.c
> > > +++ b/drivers/gpio/gpiolib-acpi-core.c
> > > @@ -944,6 +944,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
> > >   	bool can_fallback = acpi_can_fallback_to_crs(adev, con_id);
> > >   	struct acpi_gpio_info info;
> > >   	struct gpio_desc *desc;
> > > +	int ret;
> > >   	desc = __acpi_find_gpio(fwnode, con_id, idx, can_fallback, &info);
> > >   	if (IS_ERR(desc))
> > > @@ -957,6 +958,11 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
> > >   	acpi_gpio_update_gpiod_flags(dflags, &info);
> > >   	acpi_gpio_update_gpiod_lookup_flags(lookupflags, &info);
> > > +	/* ACPI uses hundredths of milliseconds units */
> > > +	ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
> > > +	if (ret)
> > > +		return ERR_PTR(ret);
> > > +
> > >   	return desc;
> > >   }
> > > -- 
> > > 2.43.0

