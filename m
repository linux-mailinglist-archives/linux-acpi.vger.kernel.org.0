Return-Path: <linux-acpi+bounces-20451-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMbYC0y9cGkRZgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20451-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 12:49:32 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CC456441
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 12:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A30A7055D8
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 13:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9002642DFE6;
	Tue, 20 Jan 2026 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhXb1qhU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B53DA7C5
	for <linux-acpi@vger.kernel.org>; Tue, 20 Jan 2026 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915868; cv=none; b=eztjbmrwOYteBNu8vi8ptGoRPyrGVgFt5nrKzha3+MtzD3byEofnoiLbLHCTQtYNBXA4Z4cATB0jl7Fr3rgWI8mmTVavz/+5bSVz9xMk1Mwkzqnvy/4ZryKugAWdgYfAZaieev2Fnlk2SjfKxjmDZk9HaSwZVAJTYfPgUEuI5Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915868; c=relaxed/simple;
	bh=K0muwfFcrFuu0cK4ER9Us6HYSeK+OV5htB8fao5HxUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azrLXtoVdi7u0WnRk2TBYjq/1x177Mi1baio7inMGAJagzKE/P2H70t2fnHmAj5S7AjD/Nwo/ea/L9hKAqx+gSkRnp8rY9WgEsHjxWIWP7ddpOo3U8xd8151LtILK1oVORPPGe/fSyKIOn1KPEPQjmo+p/YWcSo/EE7dK1YPiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhXb1qhU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768915863; x=1800451863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=K0muwfFcrFuu0cK4ER9Us6HYSeK+OV5htB8fao5HxUA=;
  b=dhXb1qhU4yRz353dC7izwz1zbPLpiTvGUw9be+EY0aNfp7fwuj0dtrJF
   +KKlOT2IQD7FzAqrbayFjDO8c2C6rJCNXQNxjU9I+2QPaBDD0YAc5ReaQ
   qU/fQ7LScOgnqE79sWSMq+6Zb9l150U90iZ6H38sPh9LJgu7nmoy1kNdY
   ZiwbJt5GhJT7BCOq1yxsizlIuX7b3jhp0MWBISnqMmTbqo915ibK0YAOZ
   L8v+DfzJOauz18466Edh4HUxZatOzSicV/6Tf/qRQOgwHXEEupiajuAmA
   7eUjOJ0d5LNY4CdA4iVzecTD6AzvxZCmtoh0ZU0O+wNdxSBoxghGuTe3w
   A==;
X-CSE-ConnectionGUID: BTrD75juRmak2Q2B8czrHA==
X-CSE-MsgGUID: HC6f+E2xRI6pzQupmDSXDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="81232419"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="81232419"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:31:03 -0800
X-CSE-ConnectionGUID: tkJHdEecSjWuqcb03eytgA==
X-CSE-MsgGUID: 3yDdCyUxTFywkdyTVygDNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205362834"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.240])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:31:02 -0800
Date: Tue, 20 Jan 2026 15:30:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>, Linus Walleij <linusw@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [Question] Best practice for ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
Message-ID: <aW-Dk7-g5x03RKBT@smile.fi.intel.com>
References: <a7b9b269-94a2-436d-b51a-cc2ffc98ea69@lunn.ch>
 <aW5umnz8RdQiIzoi@smile.fi.intel.com>
 <97cd04f6-827b-41b6-aab6-b5850c443dbe@redhat.com>
 <aW6JNDr0ZoBjHMeS@smile.fi.intel.com>
 <00bc45f8-8847-4f64-b140-790a2567e6bc@redhat.com>
 <aW6UBBvFHP_gEg-V@smile.fi.intel.com>
 <CAD++jLkD3QX4CgEaDsS=4yMzc632Hk3DjYrSangoEbCrcV9JBg@mail.gmail.com>
 <9861f9da-5f5e-4b2a-ab3f-6ac1a3faebdd@redhat.com>
 <aW8sAyChG3hpycwp@smile.fi.intel.com>
 <CAJZ5v0j7hHgs_XEmNm=RKU8d09DMumN+nycfK+xDu-cNVZZOjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j7hHgs_XEmNm=RKU8d09DMumN+nycfK+xDu-cNVZZOjQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-20451-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: F3CC456441
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 01:30:57PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 20, 2026 at 8:17 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Jan 20, 2026 at 06:39:31AM +0100, Ivan Vecera wrote:
> > > On 1/20/26 12:34 AM, Linus Walleij wrote:
> > > > On Mon, Jan 19, 2026 at 9:28 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:

(...)

> > > > > > > > Based on [1] example this clock relationship can be represented by _DSD.
> > > > > > > > Is it correct?
> > > > > > >
> > > > > > > I didn't really get, is this a clock provider-consumer relations or pin
> > > > > > > connections? If this is a pin connections, why there is no pin mux driver
> > > > > > > for it?
> > > > > >
> > > > > > In fact this should be dpll provider-consumer schema. Consumer (e.g.
> > > > > > net device, phy...) uses (consumes) DPLL service (frequency
> > > > > > synchronization, ...) and DPLL device provides such service.
> > > > > >
> > > > > > Note that the pin in this context is DPLL pin not pin related to pinctrl
> > > > > > or so...
> > > > >
> > > > > Right, so these are pins with special functions, which are not GPIO like.
> > > > > But pin mux is not only about GPIO, that's the nice part of it.
> > > > >
> > > > > +Cc: Linus for his view on this issue.
> > > >
> > > > In theory a pin controller can be instantiated in any random driver that
> > > > controls a few pins of its own to the outside world, just like we have a few
> > > > few-pin GPIO chips here and there such as for USB serial adapters.
> > > >
> > > > In practice nobody does this, they have some driver-local way of handling
> > > > pins and mux them around for their special use case.
> > > >
> > > > Graphic cards or audio would be an example. Much custom muxing
> > > > happening there I think.
> > > >
> > > > I have no strong opinion on the subject, it's up to the driver author I think.
> > > >
> > > > ACPI aspects I can't talk about because I don't understand them...
> > > >
> > > > Hope this helps!
> > >
> > > I think we might be getting sidetracked by the specific subsystems
> > > (pinctrl/GPIO/Clock).
> >
> > Yes, and this happens due to the DT point of view as far as I understood their
> > preferences. If it's modeled as clock inputs and outputs we should consider the
> > same in ACPI, otherwise it will be custom hack on top of the (agreed) way of
> > solving the issue.
> >
> > Nature of the connection (and hence the responsible subsystem in the software)
> > is the key here. Until we fully understand what's this, we can't properly model
> > it.
> >
> > > The core problem I am trying to solve is modeling the linkage between
> > > the two devices. The NIC acts as a consumer that needs to "know" about
> > > the DPLL (the supplier) in the ACPI table.
> > >
> > > We need a way to tell the NIC driver: "Here is a handle to the DPLL
> >
> > "handle to device" in ACPI assumes the Device() object somewhere in
> > the namespace. This is what you have in the ASL example.
> >
> > > device you are connected to, and here are the specific resource IDs
> > > (pins) you are wired to. So a user (userspace) can monitor/configure
> > > such DPLL inputs and outputs using DPLL Netlink API."
> > >
> > > Regardless of whether the underlying signal is a clock or a logic level,
> > > the immediate requirement is simply resolving this cross-device dependency
> > > so the NIC can identify these resources and report their IDs into userspace.
> >
> > Yes, but "simply" not always means "the best" in the long-term. As I said,
> > your proposed idea doesn't contradict ACPI concepts, the problem is that
> > it may lead to custom solution for the specific hardware and next one will
> > create their own N + 1 way of solving the same issue.
> 
> And no one will ship the requisite data in the firmware.
> 
> > One note nevertheless, instead of "reg" property the ACPI has concept of _ADR
> > method. We even have acpi_get_local_address() helper for that.
> 
> It's not exactly that.  _ADR is for device lookup on self-enumerable
> buses, and I'm not sure if that's the use case here.

Ah, thanks for chiming in. Indeed, 6.1.1. "_ADR (Address)" specifies that.
Although we have some (mis)uses of _ADR in the cases when it corresponds
to 'reg', exempli gratia the I²C mux ASL requires _ADR while I²C bus (behind
the mux) is arguably self-enumerable.

-- 
With Best Regards,
Andy Shevchenko



