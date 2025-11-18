Return-Path: <linux-acpi+bounces-19038-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F1AC6B312
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 19:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0FE84E1B5D
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A4A3612C3;
	Tue, 18 Nov 2025 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwpjIZJF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C52D8DD9;
	Tue, 18 Nov 2025 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490199; cv=none; b=O/kwXQGjxUywlGFIpp1SPVq0XKYeff1pQsVwsGVjN9+Z0mOfdsQ7zPh0357T4m6DH2RilmX2XgtqchiyRdY0YAOenwbsiA4hf5zqybWpuwbaSbLd9e9bHd27GRpNd63CgrspNPkcPiLJIad2XA7TfBgPfuEYcFtdvlSQlCfs014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490199; c=relaxed/simple;
	bh=WXpde3I3zaXheZWx6lWcPOXt/U0zDpDyP/UbwVUmI6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIU+CmzHxjFxUwsQNr52/TMG8p/4QvQo8KaelUxtgLpc0L2kaKodXp4KDb1fNkWIFLnfsnV/VPStFhbCjSXqvLiXjlcA/A9qC7lIJxxO4OgB+82l6VmucYPpYHFL9WnCd51I7v+iMCpSEpcRUpanp17fd2FqzuSW//hNNO2S7z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BwpjIZJF; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763490198; x=1795026198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WXpde3I3zaXheZWx6lWcPOXt/U0zDpDyP/UbwVUmI6w=;
  b=BwpjIZJF7ltvug2pFIilzlgH/0z4EwyrE++5HSyw8fL4AurVLoXZJJoB
   0uUQ6dyPJTusrhSH225EbmB2EJF0dL2DsN8KOyCBkjP3cDviaAhCMoHVf
   B37yQkV6MmmY2cK364JdGwv63z8y5M3B3sp7zkTv0iGq93wNwN82AkE8K
   yTaDEK2XFSCua5K6pP5OCKaFud816Q/eZ6V6LcD+qHckEjlY11HD+zgrM
   PS1/7S05A9xh6Zn2mfC+N5qJxOEPv0BQ1qZmW6hVjwndTbaHTfoe8/dyT
   W/jCaLIP1djUBJFjvtR5pCGVQgCV+UxjX2q11P55YmfnaRVdTYTEHOMTS
   g==;
X-CSE-ConnectionGUID: xEHlCz6iRz29c2u0WAZG9A==
X-CSE-MsgGUID: bxBsn2fbTImWD2pByyESng==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65461494"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65461494"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:23:18 -0800
X-CSE-ConnectionGUID: 9wGB4C9fSg+wAzZS53TMow==
X-CSE-MsgGUID: jAmTz7+0RGWMsuap5ZGYuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="195960814"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:23:13 -0800
Date: Tue, 18 Nov 2025 20:23:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v4 04/10] gpio: swnode: don't use the swnode's name as
 the key for GPIO lookup
Message-ID: <aRy5j12cdNy6iL2x@ashevche-desk.local>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-4-6461800b6775@linaro.org>
 <aRyf7qDdHKABppP8@opensource.cirrus.com>
 <CAMRc=MfD7ZbwU4akkCJNgmRPwgSOqSVi2-L2dJDOBHrfdD-yZw@mail.gmail.com>
 <aRy31U8EQA1DO/R6@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRy31U8EQA1DO/R6@opensource.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 18, 2025 at 06:15:49PM +0000, Charles Keepax wrote:
> On Tue, Nov 18, 2025 at 07:01:24PM +0100, Bartosz Golaszewski wrote:
> > On Tue, Nov 18, 2025 at 5:34 PM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > > On Mon, Nov 03, 2025 at 10:35:24AM +0100, Bartosz Golaszewski wrote:

...

> > > One small problem is this does break drivers/spi/spi-cs42l43.c.
> > 
> > I'd say it's a big problem. :)
> > 
> > > That driver has to register some swnodes to specify some GPIO
> > > chip selects due to some squiffy ACPI from Windows land. Currently
> > > it relies on the sw node being called cs42l43-pinctrl to match
> > > the driver.
> > 
> > What is the problem exactly? The "cs42l43-pinctrl" swnode is
> > associated with a GPIO device I suppose? Does it not find it? I'd need
> > some more information in order to figure out a way to fix it.
> 
> Yeah doesn't find the GPIO device. Apologies the background is
> fairly lenghty here but to give a high level summary. The cs42l43
> is an audio CODEC but it has a SPI controller on it, in some
> configurations there are a couple of speaker amps connected to
> this SPI controller. For Window reasons this SPI controller isn't
> properly represented in ACPI, so we have to depend on a couple
> magic properties and then use software nodes to register the
> speaker amps. However, as part of this we need to register a
> cs-gpios property for the chip selects used by the amps.
> 
> This chip select gpios property is where the problem happens, we
> need to refer to the gpio/pinctrl driver of the cs42l43, but
> software nodes only seem to allow referring to other software
> nodes.

Interestingly that Bart's series from where this patch came has more patches
targeting exactly this scenario, i.e. to allow to refer any type of fwnode from
swnode. Maybe we need those too and something on top?

> Previously this worked as we gave the node the same name
> as the real driver, which meant it found the real driver.
> However, after switching to look up by fwnode, it is looking for
> a gpio controller attached to the software node.
> 
> static const struct software_node cs42l43_gpiochip_swnode = {
> 	/* Previously matched the driver name for the pinctrl driver */
> 	.name	=  "cs42l43-pinctrl",
> };
> 
> static const struct software_node_ref_args cs42l43_cs_refs[] = {
> 	/* This needs to point to the genuine pinctrl driver? */
> 	SOFTWARE_NODE_REFERENCE(&cs42l43_gpiochip_swnode, 0, GPIO_ACTIVE_LOW),
> 	/* This is a mark that indicates the native chip select is used*/
> 	SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),
> };
> 
> The bit that is unclear to me is how we get that software node
> property to point to the real pinctrl driver rather than the
> dummy software node. I think maybe we need to add a SW node as a
> secondary node on the pinctrl driver itself and link to that?
> 
> Also happy from my side to spend some time working on this as I
> am not convinced what the driver is doing now is totally legit.

-- 
With Best Regards,
Andy Shevchenko



