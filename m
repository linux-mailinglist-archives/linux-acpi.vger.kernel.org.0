Return-Path: <linux-acpi+bounces-20432-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E97D3B771
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 20:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 933F430066F2
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 19:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4682C2DF153;
	Mon, 19 Jan 2026 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNvj0NSA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C71271456
	for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768851772; cv=none; b=YKdIPTvdxkLnwewhNoVTMyqZvwYNFfZxhna7s46f8DGL9v6koZB9JdiYVWCIssMkAQNImFBdfAL54Hso/+AsyBlF/INvSpCwuFr+LlNZo8DQDh7psymgFL1q7AvdSY1854jLBr/uc3L91o1mJdqbvluLFVC/RTOo68QPuwTHPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768851772; c=relaxed/simple;
	bh=cTKYOKK4tAvPoOxSKrrAPbySRohzgbxa6/tpIR+ODkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCcHaTHdnZsb6Ws/RtiTmFoIMyxJ21apeHQfEArEY6Gvcmt4OrKApYrfNO4CIZRajAp6LryggCJum68HJP8+ATmOZDDsAAYpe8cA4PlHnv814oCiKbT9OqkwIa3gr3w9I0gVKjKYUpPpwSm5zpkD1WTQpwfQruE04TqZ1CJOV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNvj0NSA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768851770; x=1800387770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cTKYOKK4tAvPoOxSKrrAPbySRohzgbxa6/tpIR+ODkw=;
  b=mNvj0NSAqrE6F7Qca+fx2EnGUmiIju2jKBBFytFeom+te7dPjn7Mmq7r
   2CWr19j2a4dZq0YAm42tkFqURm0Rzpf7BFcPMqMKYXNwlIMgFX5wg+87A
   H9Jg6743nj/PrxowH0mQR8Jl1l7N+8Pj5Gsg8KEYfvIGZ3yZeZM797zOw
   WNFjfJJdJ6bdMH8WTwe7vJcSmwogK7lWn92Web8gtBRbsbGrcNrRg0Fov
   ApTnM/eCKO4adfgk3xgYV3ZXVQdjrMI0dBioqJz5CWh1wk+d6Rx66xnu7
   QzVzsnBen73nnsxVr0u1mlEZCqdCaq4eL0g7FAAeJfw4RMPdJWF/poAQw
   Q==;
X-CSE-ConnectionGUID: 9YR7bYT3RwquWQLc2E1ZLw==
X-CSE-MsgGUID: aRAKM+qvSASsZBd4WgybGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="95537569"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="95537569"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 11:42:49 -0800
X-CSE-ConnectionGUID: AK3dbKWAS/GeGY2V2PR2sA==
X-CSE-MsgGUID: 7VEJsCQITVycthWLHzssIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="205733459"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 11:42:47 -0800
Date: Mon, 19 Jan 2026 21:42:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [Question] Best practice for ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
Message-ID: <aW6JNDr0ZoBjHMeS@smile.fi.intel.com>
References: <3bf214b9-8691-44f7-aa13-8169276a6c2b@redhat.com>
 <aWgAfsycBDc0mlFv@smile.fi.intel.com>
 <16e32f1c-8419-44cf-9da8-4c0cae6165e7@redhat.com>
 <aWjpQhGyHXXjsx2b@smile.fi.intel.com>
 <6debcd61-c60e-4436-8e31-c3210528b755@redhat.com>
 <aW5mn9pXYOU-3djd@smile.fi.intel.com>
 <a7b9b269-94a2-436d-b51a-cc2ffc98ea69@lunn.ch>
 <aW5umnz8RdQiIzoi@smile.fi.intel.com>
 <97cd04f6-827b-41b6-aab6-b5850c443dbe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97cd04f6-827b-41b6-aab6-b5850c443dbe@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 08:23:30PM +0100, Ivan Vecera wrote:
> On 1/19/26 6:49 PM, Andy Shevchenko wrote:
> > On Mon, Jan 19, 2026 at 06:43:55PM +0100, Andrew Lunn wrote:

...

> > > > P.S. Currently I can consider this as Plan B if we found no other better designs.
> > > > However it would be nice to see some review from network people, such as
> > > > Andrew Lunn and Vladimir Oltean. They know much more about networking HW
> > > > topologies and they have an expertise in ACPI.
> > > 
> > > I've been reviewing the DT parts. And the DT Maintainers are also
> > > looking at the patches.
> > > 
> > > But the question being addressed here is, do we want an ACPI binding,
> > > following ACPI guidelines etc. Or is it OK to just stuff the DT
> > > binding as is into ACPI tables?  No native ACPI binding?
> > 
> > It depends. If [6] was trying to address what [7] describes in the specification
> > and if the current problem with clock fits into all this, perhaps we need to
> > finalize the work started in [6].
> > 
> > > Putting DT into ACPI seems to be accepted when there is a long
> > > established DT binding, but ACPI has nothing. Which is common for
> > > networking with SoCs and Linux driving the hardware, not firmware. But
> > > this is all new, its a new DT binding, should there also be a new ACPI
> > > binding?
> > 
> > Yeah, I understood that point. Unfortunately I'm not so fluent in the Clock
> > related parts in ACPI, and I remember that Niyas did something in the area
> > while he was working for Linaro. Personally, I was interested only in pin
> > control integration part, so I haven't ever looked into other (missing)
> > parts he tried to develop.
> 
> Hi all,
> per Rob's advice, we should reuse existing clock bindings for the
> relationship between DPLL device and network controller / phy.

Why? If ACPI gains proper concept of clocks, the usage of DT bindings will be
a hack.

> SyncE typically involves one or more clock outputs from network device
> connected to DPLL device and one output from DPLL routed back to the
> network device. The net device sends a signal received from the ethernet
> port to the DPLL. DPLL then locks on this signal, clears jitter and
> provides phase-aligned output signal back to the network device.
> 
> This setup can be defined by this simplified DT example:
> 
> &dpll0 {
> 	...
> 	#clock-cells = <1>;
> 	clock-names = "ref0";
> 	clocks = <&ethernet0 0>;
> 	...
> };
> &ethernet0 {
> 	...
> 	#clock-cells = <0>;
> 	clock-names = "synce_ref";
> 	clocks = <&dpll0 5>;
> 	...
> };
> 
> In this example ethernet0's output 0 (aka rclk) produces clock for
> dpll0's input pin named "ref0" and dpll0's 5th output produces clock for
> ethernet0's input labelled "synce_ref".
> 
> Based on [1] example this clock relationship can be represented by _DSD.
> Is it correct?

I didn't really get, is this a clock provider-consumer relations or pin
connections? If this is a pin connections, why there is no pin mux driver
for it?

> [1] https://uefi.org/specs/ACPI/6.6/06_Device_Configuration.html#dsd-device-specific-data

-- 
With Best Regards,
Andy Shevchenko



