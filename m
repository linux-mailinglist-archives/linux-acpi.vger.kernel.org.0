Return-Path: <linux-acpi+bounces-20384-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00074D24B56
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 14:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02740300500E
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 13:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D639E6D3;
	Thu, 15 Jan 2026 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPtyn0ro"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261CE399A57
	for <linux-acpi@vger.kernel.org>; Thu, 15 Jan 2026 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483144; cv=none; b=gRu61GSoKqoJ3EQDC23MM44AtTWll69TfmxmNiygv0ibFf6PpsHSK/MeIt7LKC31xHP6OJSDYK2y4j/pqBWetSsyRwu7OUji8SKdEAFxSA3Azlu4oD4G9GqEu8FirSZIRi6qgsdUwp4aRFI2pirsnS8ssmebMrej14tNRbHl8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483144; c=relaxed/simple;
	bh=WyiccDxbq/Lh9Op2t6oNqSvvxaDNyc8EPEYQ8jO6S1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B37VtjbBo62zfVT7TdrGRFVjk1Z0F3VpwEvRVA3Y25Ir55KXKkRvY802/ccEJRVZQGQ5Xzn2DMwjjqOsNmENIYgaYeTzQr+HalW9pmbddQt8/isxZwX2MzPYQBDdVKdUFX7W+NqlGXmETyeBRhNWO58ykfZzlVI+BGfmH+OmePM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPtyn0ro; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768483143; x=1800019143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WyiccDxbq/Lh9Op2t6oNqSvvxaDNyc8EPEYQ8jO6S1Y=;
  b=aPtyn0ropgpfvVjmbP1yZjw1Mrcscnt54lPYjzYma5dh++PzJBrUO1AB
   TUsv4MqMo839VdTyPtnpjzjIX/7+zew0PVD1AtEsIAwrOZmljQcplooHb
   /WbaUf3V6Lu5fq1xRM6QGNa9SO0mCG1/6Lkh75gbLpaBilPw7vP3EVXAp
   jQD0tMct2QBz7KMfjcxU4c3p9AddS4IvLkYz+FFAzI79/bF3hvHtjtvUn
   LV1ueKDtxAqw76QD53egxK81kmAQLg5FpByk7cBBFQYm8DJOU7L0sJVor
   kk8fXUvEjxhiyLqRlh2QDd4kIyjFVcbpWl8x08wmZDNstlIcblWnBekZw
   A==;
X-CSE-ConnectionGUID: q/cech9AR5Wkuchul2Sq7A==
X-CSE-MsgGUID: JXXAJycdRu6HbbMgZ4Ybuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="73630774"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="73630774"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 05:19:02 -0800
X-CSE-ConnectionGUID: nfvfANVsQ4WyRPTDx+Qbtw==
X-CSE-MsgGUID: eiLzUOo0SpygDbZxDUquRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="204097197"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.216])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 05:19:00 -0800
Date: Thu, 15 Jan 2026 15:18:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-acpi@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [Question] Best practice for ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
Message-ID: <aWjpQhGyHXXjsx2b@smile.fi.intel.com>
References: <3bf214b9-8691-44f7-aa13-8169276a6c2b@redhat.com>
 <aWgAfsycBDc0mlFv@smile.fi.intel.com>
 <16e32f1c-8419-44cf-9da8-4c0cae6165e7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16e32f1c-8419-44cf-9da8-4c0cae6165e7@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 15, 2026 at 08:34:05AM +0100, Ivan Vecera wrote:

> thank you for the honest feedback.

You're welcome!

> I suspect I might have described the
> topology poorly in my previous email, leading to a misunderstanding
> regarding the nature of the "pins".

Quite possible.

> On 1/14/26 9:45 PM, Andy Shevchenko wrote:
> > On Wed, Jan 14, 2026 at 08:19:05PM +0100, Ivan Vecera wrote:
> > 
> > > I would like to ask for your opinion regarding an ACPI implementation
> > > detail for a patch-set I currently have on the netdev mailing list [1].
> > > ...
> > > Question:
> > > Is reusing the DT binding definitions within ACPI _DSD (to allow unified
> > > fwnode property parsing) the recommended approach for this type of
> > > device relationship?
> > 
> > TL;DR: Seems to me you are pretty much doing an ugly hack and yes, you violate
> > the existing ACPI resources. More details below.
> > 
> > > Or should I define strictly ACPI-specific bindings/objects, considering
> > > that the DT bindings for this feature are also new and currently under
> > > review?
> > > 
> > > I want to ensure I am not violating any ACPI abstraction layers by
> > > relying too heavily on the DT-style representation in _DSD.
> > > 
> > > Thanks for your guidance.
> > 
> > First of all, if I understood the HW topology right — it has an I²C muxer
> > which has a channel connected to DPLL, which among other functions provides
> > some kind of GPIO/pin muxing facility — (correct me, if I'm wrong), the
> > irrelevant to ACPI hack is an avoidance of having proper GPIO controller
> > driver / description provided with likely pin control and pin muxing
> > flavours, which is missing (hence drivers/pinctrl/... should be and it should
> > be described in DT).
> 
> This is not a GPIO or Pin Control scenario. The "pins" I am referring to are
> clock input/output pads dedicated to frequency synchronization (Synchronous
> Ethernet). They carry continuous clock signals (e.g., 10MHz, 25MHz, or
> recovered network clock), not logic levels controllable via a GPIO
> subsystem.
> 
> The Hardware Setup:
> 
> Control Plane: A user configures the DPLL device (e.g., via I2C/SPI
> managed by standard ACPI resources/drivers). This part is standard.
> 
> Data/Clock/Signal Plane (The issue at hand): There are physical clock
> traces on the board connecting the Ethernet PHY directly to the DPLL.
> 
> PHY Output(s) -> DPLL Input Pin(s) (Recovered Clock)
> 
> DPLL Output Pin(s) -> PHY Input(s) (Clean Reference Clock)
> 
> Since these are purely clock signals between two peripheral devices (not
> connected to the CPU's GPIO controller), standard ACPI _CRS resources
> like GpioIo or PinFunction do not seem applicable here. To my knowledge,
> ACPI does not have a native "Clock Resource" descriptor for inter-device
> clock dependencies.
> 
> My intention with _DSD was to model this clock dependency graph, similar
> to how clocks and clock-names are handled in Device Tree (or how camera
> sensors often use _DSD to reference related components).
> 
> Does your objection regarding the "ugly hack" still stand, or is
> modeling these clock dependencies via _DSD properties (referencing
> sub-nodes) an acceptable approach in the absence of a dedicated ACPI
> Clock Resource?

Now my "ugly hack" is irrelevant, but still sounds not good.
I hope you have researched what has been done before [6].

(Please, return links to the our emails, as it helps to understand the
 discussion.)

I.o.w. there was an attempt a few years ago to fill the gaps, one of which
you are mentioning here. Note that the ACPI specification gains something
related (but I don't remember from top of my head what exactly, please
refer to it directly [7]).

> I can provide a simple ASCII diagram of the board layout if that helps
> clarify the signal flow.

Yes, please.

> > Second, ACPI provides the _CRS resources specifically for pin configuration,
> > pin control (pin muxing as well). In case it's related those resources must
> > be used. The caveat, however, the Linux kernel has not yet implemented the
> > glue layer between ACPICA and pin control subsystem (see [5] for more).
> > 
> > It might be that I didn't get the picture correctly, but it smells badly to me.
> > In any case, I would like to help you and I'm open to more details about this
> > case.

[1]: <please return them>
...
[6]: https://linaro.atlassian.net/wiki/spaces/CLIENTPC/overview
[7]: https://uefi.org/specs/ACPI/6.6/


-- 
With Best Regards,
Andy Shevchenko



