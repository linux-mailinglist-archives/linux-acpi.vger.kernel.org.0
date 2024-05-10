Return-Path: <linux-acpi+bounces-5758-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961D48C29C2
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 20:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94BB1C20D38
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 18:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900C822F19;
	Fri, 10 May 2024 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n18zncT8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D80208B6;
	Fri, 10 May 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365049; cv=none; b=Kg+tKbl+5JGhrHKuZzzTTPnYHOfXwvjemmxgrQClzkURGrBAMyOcA3pst+5WMnFMUBKZtE0qELld5EMP/ziZaQBu38jsyZ8oZoXNwETakMHo+/uNpxmlJSc38HkSTlCci8QcvnQ9aiqT7bShyfQs0eSFVMtVxQd2/3PHs5C6KUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365049; c=relaxed/simple;
	bh=82edhdM9zJGPnwaQI49iZK5qejVGqXEpbziYfMdrOh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDKJlkaj3WN/L56BMdJLT3m4B3DiMM5ya2xIn3oRVdODsfMAtkElyrH7ROo/psMeWBuzLiBfY1Y0M8o9TZLRoiD/rQec9Zh6rCCkKk057o4+irGye8diXS5Np4SaKmKqZsrOGqDklkk+zkBkuQzysPSEDClmTJZWSjk34U4hl6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n18zncT8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715365048; x=1746901048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=82edhdM9zJGPnwaQI49iZK5qejVGqXEpbziYfMdrOh4=;
  b=n18zncT8y7jiBgNUS0tyJrVGD22ELWtzc0uj7yBD4bbZOScK/EmCVpI8
   Tj0hbzj5cRn6qZEfIy2R60JKWALkZCoUP50iiYfHEkPxxMg8EpoT5Ix2c
   nbzz9ZH+4J8cgPUf0H2PPGSkAzRqB89WXRI9x3KEBu0flUb6/7P6YjbgL
   Lp/BvWhK3gsentiMeiK+b6X798uidPrwwPByP7R1jEocHUeRoNGl1/Ptr
   A/nFpWIQpkI/0hWDWFtJUZog1gsT90INn049yw/ZxSIQ9HMcMcKsKJLKh
   ubI2cwhMGP7eXtCrbjKgVRuHHvp66MTdzH6obFWOLc7DQKSabClRBr++0
   Q==;
X-CSE-ConnectionGUID: acMC0syhSx+CotKoHkrXaw==
X-CSE-MsgGUID: uuXXv1FSQjCPu2C1qt1Hbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="28845655"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="28845655"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 11:17:27 -0700
X-CSE-ConnectionGUID: Usd77N0wQbmu4BCB6hjg+w==
X-CSE-MsgGUID: R6TJp3ZcQ4yn3Tde2JPziw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="60545626"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 11:17:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s5Uo6-00000006DJA-07o7;
	Fri, 10 May 2024 21:17:22 +0300
Date: Fri, 10 May 2024 21:17:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Armin Wolf <W_Armin@gmx.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 1/2] ACPI: EC: Install address space handler at the
 namespace root
Message-ID: <Zj5ksaCzhSGN2FpE@smile.fi.intel.com>
References: <5787281.DvuYhMxLoT@kreacher>
 <4926735.31r3eYUQgx@kreacher>
 <ac04c433-b0ac-4b82-b8eb-98ac16f872d8@gmx.de>
 <CAJZ5v0g_NjGHRvhm-N5vQFnOsqnxExSq99v8n_B_6ANoaCga0w@mail.gmail.com>
 <568291fc-fd79-4f08-9eb7-aed7f5a32345@gmx.de>
 <Zj5ZdcQeaTo9ImT4@smile.fi.intel.com>
 <0cdf0af6-851b-4781-83fe-99320c35544f@amd.com>
 <Zj5eZKgpg3LFpne8@smile.fi.intel.com>
 <CAJZ5v0geYUx6G_ZnTX7+BjEbkqdSovdwriMHBoBXMyvrPjqFmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0geYUx6G_ZnTX7+BjEbkqdSovdwriMHBoBXMyvrPjqFmg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 10, 2024 at 08:06:11PM +0200, Rafael J. Wysocki wrote:
> On Fri, May 10, 2024 at 7:50 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, May 10, 2024 at 12:40:05PM -0500, Mario Limonciello wrote:
> > > On 5/10/2024 12:29, Andy Shevchenko wrote:
> > > > On Fri, May 10, 2024 at 06:52:41PM +0200, Armin Wolf wrote:
> > > > > Am 10.05.24 um 18:41 schrieb Rafael J. Wysocki:
> > > > > > On Fri, May 10, 2024 at 6:10 PM Armin Wolf <W_Armin@gmx.de> wrote:
> > > > > > > Am 10.05.24 um 16:03 schrieb Rafael J. Wysocki:
> > > > > > >
> > > > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > > >
> > > > > > > > It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Lenovo
> > > > > > > > IdeaPad Pro 5 due to a missing address space handler for the EC address
> > > > > > > > space:
> > > > > > > >
> > > > > > > >     ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [EmbeddedControl] (20230628/evregion-130)
> > > > > > > >
> > > > > > > > This happens because the EC driver only registers the EC address space
> > > > > > > > handler for operation regions defined in the EC device scope of the
> > > > > > > > ACPI namespace while the operation region being accessed by the _DSM
> > > > > > > > in question is located beyond that scope.
> > > > > > > >
> > > > > > > > To address this, modify the ACPI EC driver to install the EC address
> > > > > > > > space handler at the root of the ACPI namespace.
> > > > > > > >
> > > > > > > > Note that this change is consistent with some examples in the ACPI
> > > > > > > > specification in which EC operation regions located outside the EC
> > > > > > > > device scope are used (for example, see Section 9.17.15 in ACPI 6.5),
> > > > > > > > so the current behavior of the EC driver is arguably questionable.
> > > > > > > Hi,
> > > > > > >
> > > > > > > the patch itself looks good to me, but i wonder what happens if multiple
> > > > > > > ACPI EC devices are present. How would we handle such a situation?
> > > > > > I'm wondering if this is a theoretical question or do you have any
> > > > > > existing or planned systems in mind?
> > > > > >
> > > > > > ec_read(), ec_write() and ec_transaction() use only the first EC that
> > > > > > has been found anyway.
> > > > >
> > > > > Its a theoretical question, i do not know of any systems which have more than
> > > > > one ACPI EC device.
> > > >
> > > > The specification is clear about this case in the "ACPI Embedded Controller
> > > > Interface Specification":
> > > >
> > > >   "The ACPI standard supports multiple embedded controllers in a system,
> > > >    each with its own resources. Each embedded controller has a flat
> > > >    byte-addressable I/O space, currently defined as 256 bytes."
> > > >
> > > > However, I haven't checked deeper, so it might be a leftover in the documentation.
> > > >
> > > > The OperationRegion() has no reference to the EC (or in general, device) which
> > > > we need to speak to. The only possibility to declare OpRegion() for the second+
> > > > EC is to use vendor specific RegionSpace, AFAIU. So, even if ACPI specification
> > > > supports 2+ ECs, it doesn't support OpRegion():s for them under the same
> > > > RegionSpace.
> > > >
> > > > That said, the commit message might be extended to summarize this, but at
> > > > the same time I see no way how this series can break anything even in 2+ ECs
> > > > environments.
> > >
> > > It's deviating from the patch, but in practice /why/ would you even want to
> > > have a design with two ECs?  In general that is going to mean a much more
> > > complex state machine with synchronizing the interaction between both of
> > > them and the host.
> > >
> > > Understanding the benefit of such a design might make it easier to
> > > hypothesize impacts.
> >
> > First that comes to my mind (but hypothetical), is the separate CPU/EC add-on
> > cards. If the main firmware somehow supports all of these add-on platforms,
> > it might need to handle 2+ ECs.
> >
> > Again, it might be ACPI specification issue. For instance, the cited piece
> > doesn't tell about 16-bit EC accesses.
> 
> IMV this is a matter of what is testable.
> 
> We can only seriously say that we support 1 EC in the system, because
> that's what we can test.
> 
> Now, the specification allows (theoretically) multiple ECs to be
> supported which does not mean that it will ever be done in practice
> and it also does not mean that this is a good idea.

I briefly read the all mentions of the "Embedded Controller" in the
specification and like 98% implies that the only one is per system. I believe
the specification may be corrected to remove ambiguous plural forms in a couple
(or a few) places. In any case it's a question to ASWG.

-- 
With Best Regards,
Andy Shevchenko



