Return-Path: <linux-acpi+bounces-20440-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF209D3C0A1
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 08:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12287506A60
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 07:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808B6392B98;
	Tue, 20 Jan 2026 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfcsNb1p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1486393418
	for <linux-acpi@vger.kernel.org>; Tue, 20 Jan 2026 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893460; cv=none; b=mB1YmsZcOuyJ4D75dHIxiH+LjzMc4KxMvnQl9cJxpbX07Cx5XVxOqPntZsblId1Tf8QG2mWJZguUVEpvDSmqGTKyJWQHZnULFaYlnfwluzafP6oMhS/83+ibq+0PVgF91LYl3Zc87pZMeLNWIoE0syslLcCB+ZCD3R9Ke0jlofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893460; c=relaxed/simple;
	bh=oFGiauM+fL0lN7CNGsCtcoZlg2R2JgHv/2P57X9EG+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asWb9tsPRt22SYDOxnSRwmN5PpIBItQqUYhCIKmzegyW2FY43CyEVbk9VDLUZ97FuUCAP6T2aq2TRauMxGdNUHRpJYYUEd/CpB9RDHXSa1A/TmIHOXE2eHTdL/qz2RUSM8dOgrKa4Qg/LM9gBc9umeydoR5E1Czbo09lAsXiTT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfcsNb1p; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768893451; x=1800429451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oFGiauM+fL0lN7CNGsCtcoZlg2R2JgHv/2P57X9EG+o=;
  b=JfcsNb1p7L3wxhM00tUbmV2netng2AZ4/LDpmrv5Zb6aSZ7j04lZHuzu
   To4mjczvsbpYbSXSd0JY4bgvRoSsMhx66gYbTWvDk5Ba8kn+kXYYMi1OP
   FIWuehrJNDDUYXyOirm9oyRe/KyZqDJhDa0aPQIMbP3Fud3nXbfVRUnEa
   6h7sIKsJMyYd3ddlSckzntlGqAX2H3ICC5sKvbDYAbun/wDfjGBdeZTGZ
   6afhxrIb4VRTLHsLYdSQVOywUiNPi9PvjYil/sZzWZIziNE9E5yfyT2j1
   N0ZNTnGcOonejA5GKCUfLIuMjNDnQzd2v4Y+Pv5TybV/eOcxWZSPbg7RV
   Q==;
X-CSE-ConnectionGUID: +l4eyvP1SvOCDH59S6E7DA==
X-CSE-MsgGUID: KroAKqn5Q3OpbD3L/GQ4uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70182248"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70182248"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:17:28 -0800
X-CSE-ConnectionGUID: MGGvQrXCQR6jiuT4yDrpJg==
X-CSE-MsgGUID: WUd5Pr4HQ16zCFDB5AZf+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205844502"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:17:27 -0800
Date: Tue, 20 Jan 2026 09:17:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [Question] Best practice for ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
Message-ID: <aW8sAyChG3hpycwp@smile.fi.intel.com>
References: <6debcd61-c60e-4436-8e31-c3210528b755@redhat.com>
 <aW5mn9pXYOU-3djd@smile.fi.intel.com>
 <a7b9b269-94a2-436d-b51a-cc2ffc98ea69@lunn.ch>
 <aW5umnz8RdQiIzoi@smile.fi.intel.com>
 <97cd04f6-827b-41b6-aab6-b5850c443dbe@redhat.com>
 <aW6JNDr0ZoBjHMeS@smile.fi.intel.com>
 <00bc45f8-8847-4f64-b140-790a2567e6bc@redhat.com>
 <aW6UBBvFHP_gEg-V@smile.fi.intel.com>
 <CAD++jLkD3QX4CgEaDsS=4yMzc632Hk3DjYrSangoEbCrcV9JBg@mail.gmail.com>
 <9861f9da-5f5e-4b2a-ab3f-6ac1a3faebdd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9861f9da-5f5e-4b2a-ab3f-6ac1a3faebdd@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 06:39:31AM +0100, Ivan Vecera wrote:
> On 1/20/26 12:34 AM, Linus Walleij wrote:
> > On Mon, Jan 19, 2026 at 9:28 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

(...)

> > > > > > Based on [1] example this clock relationship can be represented by _DSD.
> > > > > > Is it correct?
> > > > > 
> > > > > I didn't really get, is this a clock provider-consumer relations or pin
> > > > > connections? If this is a pin connections, why there is no pin mux driver
> > > > > for it?
> > > > 
> > > > In fact this should be dpll provider-consumer schema. Consumer (e.g.
> > > > net device, phy...) uses (consumes) DPLL service (frequency
> > > > synchronization, ...) and DPLL device provides such service.
> > > > 
> > > > Note that the pin in this context is DPLL pin not pin related to pinctrl
> > > > or so...
> > > 
> > > Right, so these are pins with special functions, which are not GPIO like.
> > > But pin mux is not only about GPIO, that's the nice part of it.
> > > 
> > > +Cc: Linus for his view on this issue.
> > 
> > In theory a pin controller can be instantiated in any random driver that
> > controls a few pins of its own to the outside world, just like we have a few
> > few-pin GPIO chips here and there such as for USB serial adapters.
> > 
> > In practice nobody does this, they have some driver-local way of handling
> > pins and mux them around for their special use case.
> > 
> > Graphic cards or audio would be an example. Much custom muxing
> > happening there I think.
> > 
> > I have no strong opinion on the subject, it's up to the driver author I think.
> > 
> > ACPI aspects I can't talk about because I don't understand them...
> > 
> > Hope this helps!
> 
> I think we might be getting sidetracked by the specific subsystems
> (pinctrl/GPIO/Clock).

Yes, and this happens due to the DT point of view as far as I understood their
preferences. If it's modeled as clock inputs and outputs we should consider the
same in ACPI, otherwise it will be custom hack on top of the (agreed) way of
solving the issue.

Nature of the connection (and hence the responsible subsystem in the software)
is the key here. Until we fully understand what's this, we can't properly model
it.

> The core problem I am trying to solve is modeling the linkage between
> the two devices. The NIC acts as a consumer that needs to "know" about
> the DPLL (the supplier) in the ACPI table.
> 
> We need a way to tell the NIC driver: "Here is a handle to the DPLL

"handle to device" in ACPI assumes the Device() object somewhere in
the namespace. This is what you have in the ASL example.

> device you are connected to, and here are the specific resource IDs
> (pins) you are wired to. So a user (userspace) can monitor/configure
> such DPLL inputs and outputs using DPLL Netlink API."
> 
> Regardless of whether the underlying signal is a clock or a logic level,
> the immediate requirement is simply resolving this cross-device dependency
> so the NIC can identify these resources and report their IDs into userspace.

Yes, but "simply" not always means "the best" in the long-term. As I said,
your proposed idea doesn't contradict ACPI concepts, the problem is that
it may lead to custom solution for the specific hardware and next one will
create their own N + 1 way of solving the same issue.

One note nevertheless, instead of "reg" property the ACPI has concept of _ADR
method. We even have acpi_get_local_address() helper for that.

-- 
With Best Regards,
Andy Shevchenko



