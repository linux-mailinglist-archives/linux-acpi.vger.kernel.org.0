Return-Path: <linux-acpi+bounces-20435-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28207D3B851
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 21:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCA7E3031991
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 20:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9F92DF138;
	Mon, 19 Jan 2026 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GplQujvF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5613E27E05F
	for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 20:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854539; cv=none; b=qZjDZ2hg5JuSYNr9c0H+wvS09AmuJP09FkaeUxRpTnfHwxQ4zL6vece9o30o1JS9NIi5ZbpCr3xistc6xHn7ns3sJOePaZ3C2OHF+0jWtlaqkcar1M4WN89tf1+l0vNxx/63T9VRgBNvqW1VDNndX3FWb3Zyniy50MTe4qK04aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854539; c=relaxed/simple;
	bh=QR48XEfAJCXCuI8VkYVg+GsMj1yxEFb17Bkj3N8BgNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocv0k1jayvLvmNhvJt0FDGLVTI0j/moldjouznMXntUrlHGs8/Bd6v/WJ1++h8g9016AIvRhq4cBgwf5+8QrD8QLvBjkSUZQOYBtEQcdYy0aBmDnkyU0S21foWtcQJsuD2IVXb+W264i0KUwctOsyeLRy7CBDcLbzZhmIYwXQMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GplQujvF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768854537; x=1800390537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QR48XEfAJCXCuI8VkYVg+GsMj1yxEFb17Bkj3N8BgNg=;
  b=GplQujvF+dP6588PPOV7GTO8CP2xjOtdxPJdlu5vIpW5yDNOfrU3zK1h
   XnDgZ6yLIG6F941G3FaROuVh8hZmBzGmWeqzj+Slaww7On76RFM49J/eO
   M8s43zyBLI3hZqE0a43kZBbR02JMx+bnLt3At+D54tPH2zlter0+N6zP5
   Zbdgv+D4iUBpUjsBYR45OgGI4X9wqWJl8itzMw865pOii2pft+oSCsxgA
   a8D/Veo42wBz6BX2LT6VRvrI7XrBs1SbdUve6NFt1WGiASeuFK3mIUhXW
   Z/cQWRWWstCHuoQrQFc1myh4KfPPMjJYKrPrNsWrRRUgeTFv2PprvDz4/
   g==;
X-CSE-ConnectionGUID: kroA5T1OQVeR0dDsTXtcPQ==
X-CSE-MsgGUID: XrbPVi0OQ3yWvtzdZpcMoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73694633"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="73694633"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 12:28:57 -0800
X-CSE-ConnectionGUID: W5WIiUNuQTSvJ5GmIyjb0A==
X-CSE-MsgGUID: tskSzh7mSsK5g/3VuMd/Cw==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 12:28:54 -0800
Date: Mon, 19 Jan 2026 22:28:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ivan Vecera <ivecera@redhat.com>, Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [Question] Best practice for ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
Message-ID: <aW6UBBvFHP_gEg-V@smile.fi.intel.com>
References: <aWgAfsycBDc0mlFv@smile.fi.intel.com>
 <16e32f1c-8419-44cf-9da8-4c0cae6165e7@redhat.com>
 <aWjpQhGyHXXjsx2b@smile.fi.intel.com>
 <6debcd61-c60e-4436-8e31-c3210528b755@redhat.com>
 <aW5mn9pXYOU-3djd@smile.fi.intel.com>
 <a7b9b269-94a2-436d-b51a-cc2ffc98ea69@lunn.ch>
 <aW5umnz8RdQiIzoi@smile.fi.intel.com>
 <97cd04f6-827b-41b6-aab6-b5850c443dbe@redhat.com>
 <aW6JNDr0ZoBjHMeS@smile.fi.intel.com>
 <00bc45f8-8847-4f64-b140-790a2567e6bc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00bc45f8-8847-4f64-b140-790a2567e6bc@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 08:55:40PM +0100, Ivan Vecera wrote:
> On 1/19/26 8:42 PM, Andy Shevchenko wrote:
> > On Mon, Jan 19, 2026 at 08:23:30PM +0100, Ivan Vecera wrote:
> > > On 1/19/26 6:49 PM, Andy Shevchenko wrote:
> > > > On Mon, Jan 19, 2026 at 06:43:55PM +0100, Andrew Lunn wrote:

...

> > > > > > P.S. Currently I can consider this as Plan B if we found no other better designs.
> > > > > > However it would be nice to see some review from network people, such as
> > > > > > Andrew Lunn and Vladimir Oltean. They know much more about networking HW
> > > > > > topologies and they have an expertise in ACPI.
> > > > > 
> > > > > I've been reviewing the DT parts. And the DT Maintainers are also
> > > > > looking at the patches.
> > > > > 
> > > > > But the question being addressed here is, do we want an ACPI binding,
> > > > > following ACPI guidelines etc. Or is it OK to just stuff the DT
> > > > > binding as is into ACPI tables?  No native ACPI binding?
> > > > 
> > > > It depends. If [6] was trying to address what [7] describes in the specification
> > > > and if the current problem with clock fits into all this, perhaps we need to
> > > > finalize the work started in [6].
> > > > 
> > > > > Putting DT into ACPI seems to be accepted when there is a long
> > > > > established DT binding, but ACPI has nothing. Which is common for
> > > > > networking with SoCs and Linux driving the hardware, not firmware. But
> > > > > this is all new, its a new DT binding, should there also be a new ACPI
> > > > > binding?
> > > > 
> > > > Yeah, I understood that point. Unfortunately I'm not so fluent in the Clock
> > > > related parts in ACPI, and I remember that Niyas did something in the area
> > > > while he was working for Linaro. Personally, I was interested only in pin
> > > > control integration part, so I haven't ever looked into other (missing)
> > > > parts he tried to develop.
> > > 
> > > per Rob's advice, we should reuse existing clock bindings for the
> > > relationship between DPLL device and network controller / phy.
> > 
> > Why? If ACPI gains proper concept of clocks, the usage of DT bindings will be
> > a hack.
> 
> I have been wanting to propose a new consumer / supplier schema for
> dpll-pins [1] but it was advised to use existing clock-binding schema to
> represent this relationships.
> 
> > > SyncE typically involves one or more clock outputs from network device
> > > connected to DPLL device and one output from DPLL routed back to the
> > > network device. The net device sends a signal received from the ethernet
> > > port to the DPLL. DPLL then locks on this signal, clears jitter and
> > > provides phase-aligned output signal back to the network device.
> > > 
> > > This setup can be defined by this simplified DT example:
> > > 
> > > &dpll0 {
> > > 	...
> > > 	#clock-cells = <1>;
> > > 	clock-names = "ref0";
> > > 	clocks = <&ethernet0 0>;
> > > 	...
> > > };
> > > &ethernet0 {
> > > 	...
> > > 	#clock-cells = <0>;
> > > 	clock-names = "synce_ref";
> > > 	clocks = <&dpll0 5>;
> > > 	...
> > > };
> > > 
> > > In this example ethernet0's output 0 (aka rclk) produces clock for
> > > dpll0's input pin named "ref0" and dpll0's 5th output produces clock for
> > > ethernet0's input labelled "synce_ref".
> > > 
> > > Based on [1] example this clock relationship can be represented by _DSD.
> > > Is it correct?
> > 
> > I didn't really get, is this a clock provider-consumer relations or pin
> > connections? If this is a pin connections, why there is no pin mux driver
> > for it?
> 
> In fact this should be dpll provider-consumer schema. Consumer (e.g.
> net device, phy...) uses (consumes) DPLL service (frequency
> synchronization, ...) and DPLL device provides such service.
> 
> Note that the pin in this context is DPLL pin not pin related to pinctrl
> or so...

Right, so these are pins with special functions, which are not GPIO like.
But pin mux is not only about GPIO, that's the nice part of it.

+Cc: Linus for his view on this issue.

-- 
With Best Regards,
Andy Shevchenko



