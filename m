Return-Path: <linux-acpi+bounces-20426-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DACD3B49E
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 18:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7702E3015AE7
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84ED322557;
	Mon, 19 Jan 2026 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kw8xMhlV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193DD322DB7
	for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842917; cv=none; b=o1Ne8NginUSWF3SQPYa3D//rtxd/ZeG24GsphvWB30teuFGFAgNl++6l6fDXeqgjMLedMSNjQDph9W7G0GJQdjLw19UZj4SuKQZU0llPIUmAhHqcVRn7bYU6w3l1E9RyAQ1nmR/s4RB279XeJgFolsJN8AKksNkSC7TR/puygfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842917; c=relaxed/simple;
	bh=d2anYrO977doMd3+9usxYOrV2QkDa/XMy9QL52xozkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OY4F1O8Pw2SvaRqeX8veDHfyuIC3BZ5TMtXktSDMH6gLcqXINzP1ymyP3pjOchCLKzMeQKhAczLw96zhTTIKG3kOZb/XoC3xf9CyRlXJKgtj9cGbRGMC1jkGFNtx8gfy8+6rlmOvkdu8yIwIad0olEWl67tx4brxmU077oldRPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kw8xMhlV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768842916; x=1800378916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d2anYrO977doMd3+9usxYOrV2QkDa/XMy9QL52xozkY=;
  b=Kw8xMhlVWUQYx+bxqYDH9yhnKkSSeRqLho5QTSmafLPg+HuoCM/xwiHf
   jyOnI60LAGene9mzjIdeyCPbNAY/VWwXV7MwC3+uAv87tJrTYw5YWb7Yq
   WWu6SGPNOqTJzShUT/uAecbamTwPGjEnHqGAh7Vl00fMu2UaVu0w8ap1K
   OP3f/I46lxhL1sbN2JizwTUtqxF6rpH3n+64nCCACknfLFeU49dkhEx2w
   dGd3yWPuMTBZVbfyDewQirp47/JXeT2KWGdKVoxRCmHlsfnfs52KqtSJo
   mDCamI6grD/WCHFSrYxBwLd+kSlfpi9+3hDQHePHS08uNEId12/apgDgb
   w==;
X-CSE-ConnectionGUID: nNs3mXjZQvim3Ok/k58WvQ==
X-CSE-MsgGUID: Jv9BLoiBSK2jbUSkwjOp6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70030223"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="70030223"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 09:15:15 -0800
X-CSE-ConnectionGUID: 82vwE6/GTxW+kKpS8ljaOA==
X-CSE-MsgGUID: xlkSYdofRk6m67TrAMAbiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="206169723"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 09:15:13 -0800
Date: Mon, 19 Jan 2026 19:15:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-acpi@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [Question] Best practice for ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
Message-ID: <aW5mn9pXYOU-3djd@smile.fi.intel.com>
References: <3bf214b9-8691-44f7-aa13-8169276a6c2b@redhat.com>
 <aWgAfsycBDc0mlFv@smile.fi.intel.com>
 <16e32f1c-8419-44cf-9da8-4c0cae6165e7@redhat.com>
 <aWjpQhGyHXXjsx2b@smile.fi.intel.com>
 <6debcd61-c60e-4436-8e31-c3210528b755@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6debcd61-c60e-4436-8e31-c3210528b755@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 15, 2026 at 03:09:53PM +0100, Ivan Vecera wrote:
> On 1/15/26 2:18 PM, Andy Shevchenko wrote:
> > On Thu, Jan 15, 2026 at 08:34:05AM +0100, Ivan Vecera wrote:
> > > On 1/14/26 9:45 PM, Andy Shevchenko wrote:
> > > > On Wed, Jan 14, 2026 at 08:19:05PM +0100, Ivan Vecera wrote:

...

> > > This is not a GPIO or Pin Control scenario. The "pins" I am referring to are
> > > clock input/output pads dedicated to frequency synchronization (Synchronous
> > > Ethernet). They carry continuous clock signals (e.g., 10MHz, 25MHz, or
> > > recovered network clock), not logic levels controllable via a GPIO
> > > subsystem.
> > > 
> > > The Hardware Setup:
> > > 
> > > Control Plane: A user configures the DPLL device (e.g., via I2C/SPI
> > > managed by standard ACPI resources/drivers). This part is standard.
> > > 
> > > Data/Clock/Signal Plane (The issue at hand): There are physical clock
> > > traces on the board connecting the Ethernet PHY directly to the DPLL.
> > > 
> > > PHY Output(s) -> DPLL Input Pin(s) (Recovered Clock)
> > > 
> > > DPLL Output Pin(s) -> PHY Input(s) (Clean Reference Clock)
> > > 
> > > Since these are purely clock signals between two peripheral devices (not
> > > connected to the CPU's GPIO controller), standard ACPI _CRS resources
> > > like GpioIo or PinFunction do not seem applicable here. To my knowledge,
> > > ACPI does not have a native "Clock Resource" descriptor for inter-device
> > > clock dependencies.
> > > 
> > > My intention with _DSD was to model this clock dependency graph, similar
> > > to how clocks and clock-names are handled in Device Tree (or how camera
> > > sensors often use _DSD to reference related components).
> > > 
> > > Does your objection regarding the "ugly hack" still stand, or is
> > > modeling these clock dependencies via _DSD properties (referencing
> > > sub-nodes) an acceptable approach in the absence of a dedicated ACPI
> > > Clock Resource?
> > 
> > Now my "ugly hack" is irrelevant, but still sounds not good.
> > I hope you have researched what has been done before [6].
> > 
> > (Please, return links to the our emails, as it helps to understand the
> >   discussion.)
> Returned.
> 
> > I.o.w. there was an attempt a few years ago to fill the gaps, one of which
> > you are mentioning here. Note that the ACPI specification gains something
> > related (but I don't remember from top of my head what exactly, please
> > refer to it directly [7]).
> > 
> > > I can provide a simple ASCII diagram of the board layout if that helps
> > > clarify the signal flow.
> > 
> > Yes, please.
> 
> In SyncE (Synchronous Ethernet) scenarios, an Ethernet controller or PHY
> is typically connected to a DPLL device that provides frequency
> synchronization, holdover, and jitter filtering.
> 
> A SyncE-capable Ethernet PHY (or controller) usually has:
> Output(s): Recovered clock signal connected to a DPLL input pin.
> Input(s): Connected to a DPLL output pin.
> 
> Example:
>      ETH controller or PHY
>     +--------------------+
> +---| rclk0              |
> |+--| rclk1    synce_ref |<-+
> ||  +--------------------+  |
> ||                          |
> ||           DPLL           |
> ||  +--------------------+  |
> |+->| ref1n              |  |
> +-->| ref3n        out1p |--+
>     +--------------------+
> 
> In DT this could look like:
>   ...
>   &dpll0 {
>     ...
>     input-pins {
>       pin@3 {
>         ...
>       };
>       pin@5 {
>         ...
>       };
>     };
>     output-pins {
>       pin@2 {
>         ...
>       };
>     };
>   };
>   &phy2 {
>     ...
>     dpll-pin-names = "rclk0", "rclk1", "synce_ref";
>     dpll-pins = <&dpll0 3 DPLL_PIN_INPUT>,
>                 <&dpll0 5 DPLL_PIN_INPUT>,
>                 <&dpll0 2 DPLL_PIN_OUTPUT>;
>     ...
>   };
> 
> For ACPI I have followed [8][9][10] to create ASL code for the following
> system (Intel GNR-D):
> 1. There is an I2C Mux (pca9546) connected to system SMBus
> 2. On the 3rd channel there is a I2C DPLL device (ZL30732) at address
>    0x70
> 3. There is 4-port NIC (E825C) on PCIe bus
> 
> [3] is sample SSDT that adds the I2C mux and the DPLL device
> [4] is sample SSDT that adds to the NICs 'dpll-pins' and
>     'dpll-pin-names' properties to 2 NICs.
> 
> The goal of the patch-set [1] is that NIC driver (ice) will be able to
> check what DPLL pins are used for its recovered clock outputs and what
> DPLL pin provides the cleaned/synchronized signal for its input.
> If so the NIC driver can report these DPLL pin IDs to the userspace
> and a user can configure/monitor these pins accordingly.

So, this is not so bad as I thought initially. Still the open question if you
studied [6][7] and learnt anything new about clocks and ACPI integration?

P.S. Currently I can consider this as Plan B if we found no other better designs.
However it would be nice to see some review from network people, such as
Andrew Lunn and Vladimir Oltean. They know much more about networking HW
topologies and they have an expertise in ACPI.

> Links:
> [1]
> https://patchwork.kernel.org/project/netdevbpf/list/?series=1040080&state=*
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dpll
> [3] https://github.com/ivecera/zl3073x-acpi/blob/main/sample1.asl
> [4] https://github.com/ivecera/zl3073x-acpi/blob/main/dpllnic.asl
> [5] https://lore.kernel.org/r/20221130164027.682898-1-niyas.sait@linaro.org
> [6] https://linaro.atlassian.net/wiki/spaces/CLIENTPC/overview
> [7] https://uefi.org/specs/ACPI/6.6/
> [8] https://github.com/UEFI/DSD-Guide/blob/main/dsd-guide.pdf
> [9] https://docs.kernel.org/firmware-guide/acpi/i2c-muxes.html
> [10]
> https://docs.kernel.org/firmware-guide/acpi/dsd/data-node-references.html

-- 
With Best Regards,
Andy Shevchenko



