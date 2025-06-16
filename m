Return-Path: <linux-acpi+bounces-14379-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD3DADA7C4
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 07:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C044B16B461
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 05:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9F71ACEDC;
	Mon, 16 Jun 2025 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9N4NHKg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F01C84A5
	for <linux-acpi@vger.kernel.org>; Mon, 16 Jun 2025 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750052468; cv=none; b=NESBzhHa0ZHR/5g4Io86PTdtUaG4kKe+kN7NzLrhh18QAfQvRayIq7JhzH+MHuFI/7HJz7d8RRoArP4SIPi0Vw7Ov8v4FmV6MK7kRfuurF7j+2t5d6dJr3VGDlL5tBEjGYedYEgEmCicQe/1Cy3YNA6HNcvWwER+tuRuZCWO65s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750052468; c=relaxed/simple;
	bh=nFzTrIe8YwFRLzt2khmCsihAib98C6I0waGFl3Tvi+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHIWmpJw4gINqzhYvq0NUA9Qlto1ZFENrufFqJei16gTj5lpaXwun+7mdtawrPjWzgK94bJXQOUwjI3WKYJakmRbR8bjvduXtvZeJ9M0fqk6nms8jE2LZbXLUzXocaiiTzZzGF4SfyvA+ONR8L1EODco9UXG7lQdXa38vTX0uN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9N4NHKg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750052466; x=1781588466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nFzTrIe8YwFRLzt2khmCsihAib98C6I0waGFl3Tvi+k=;
  b=g9N4NHKgZ2hfyPPkgsltlvmw5ewMVU2SEtta0imnTQDrAFNijv26ddu0
   SMdCyzPv7wi2jCGd60ejgl0rHw8eZJ3T/vUL47ZWTy9a0BJBBMsnIaXcN
   2gYy4vXsWLn6GgCSC9H4u0HDXCWcnDgiBfpQ7hwWKDfbte6sqQSyBtGUY
   MPzF+ZmY009icNQmt6gYzKzN01Kl7OZTa6kEsvqmPl1/+iVeMUQbbUupu
   roG03izDmtKR8+FNr3topnyj4Am/sAo1gaAjsnXt9BRggUjQUnanuqgsU
   DIyxMY5qEqP5glK36V1LE8HT7yk6unoseEvTuwuQbzyVtm6/WoESme440
   g==;
X-CSE-ConnectionGUID: e/3S6TXnR7GqxC5byZr9DQ==
X-CSE-MsgGUID: ZB9JEN2pQ720v3mbrzOdkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="55859309"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="55859309"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 22:41:05 -0700
X-CSE-ConnectionGUID: zDPbbPjqRGq/mIk+4kKG/A==
X-CSE-MsgGUID: pshUV8xhTLCEFhxy4f0WxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="179380925"
Received: from agladkov-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 22:41:04 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id E9BA01211D5;
	Mon, 16 Jun 2025 08:41:01 +0300 (EEST)
Date: Mon, 16 Jun 2025 05:41:01 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] ACPI: property: Fix REF STR... reference parsing
Message-ID: <aE-ubboedATIo8kC@kekkonen.localdomain>
References: <20250331121836.2495903-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0jGCaJLTka57nB6mx4VDxZJUBVBbGV=7HdKKpf+7jCvjw@mail.gmail.com>
 <Z-qaOXTRS7z_He62@kekkonen.localdomain>
 <CAJZ5v0gaDSAS6rgKxtOVgz+kSYVNvG2--o9kR40BKt5Z6Barog@mail.gmail.com>
 <Z-qwRpddAZ9Upi6r@kekkonen.localdomain>
 <CAJZ5v0i=h1AQm5LVDj4m6X+oEh=3AQ=jMAMr+p6=K13AP73C9w@mail.gmail.com>
 <Z-q-ePJeM4XzeffL@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-q-ePJeM4XzeffL@kekkonen.localdomain>

On Mon, Mar 31, 2025 at 04:10:32PM +0000, Sakari Ailus wrote:
> Hi Rafael,
> 
> On Mon, Mar 31, 2025 at 05:35:50PM +0200, Rafael J. Wysocki wrote:
> > Hi Sakari,
> > 
> > On Mon, Mar 31, 2025 at 5:10 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Mon, Mar 31, 2025 at 05:00:52PM +0200, Rafael J. Wysocki wrote:
> > > > Hi Sakari,
> > > >
> > > > On Mon, Mar 31, 2025 at 3:35 PM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > >
> > > > > Hi Rafael,
> > > > >
> > > > > On Mon, Mar 31, 2025 at 03:19:07PM +0200, Rafael J. Wysocki wrote:
> > > > > > On Mon, Mar 31, 2025 at 2:18 PM Sakari Ailus
> > > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > > >
> > > > > > > Restore parsing of ACPI data node references consisting of a device node
> > > > > > > reference followed by one or more child data node names.
> > > > > > >
> > > > > > > Fixes: 9880702d123f ("ACPI: property: Support using strings in reference properties")
> > > > > > > Cc: stable@vger.kernel.org # for 6.8 and later
> > > > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > > > ---
> > > > > > > Hi Rafael,
> > > > > > >
> > > > > > > It seems that support for REF STR... references got accidentally removed
> > > > > > > when pure STR reference were added. The former are documented in
> > > > > > > Documentation/firmware-guide/acpi/dsd/graph.rst .
> > > > > >
> > > > > > It would be good to provide an ASL example that is not parsed as
> > > > > > expected before the change and will be parsed correctly after it.
> > > > > >
> > > > > > Admittedly, I can't quite recall the history leading to the above
> > > > > > commit, but this paragraphs is present in its changelog:
> > > > > >
> > > > > > "Also remove the mechanism allowing data nodes to be referenced
> > > > > >  indirectly, with the help of an object reference pointing to the
> > > > > >  "ancestor" device and a path relative to it (this mechanism is not
> > > > > >  expected to be in use in any production platform firmware in the field)."
> > > > > >
> > > > > > so the change in question appears to be intentional rather than accidental.
> > > > >
> > > > > Right. This still continues to be documented in
> > > > > Documentation/firmware-guide/acpi/dsd/graph.rst as noted in my previous
> > > > > e-mail. A sample ASL snippet is can also be found in the same file. I only
> > > > > noticed this when I tried to use such references.
> > > > >
> > > > > The other option indeed is to change the documentation and hope no-one
> > > > > depends on it.
> > > >
> > > > I thought that this was the original plan.
> > >
> > > I wasn't aware of the plan. But given that no-one has complained yet,
> > > there's a fair chance no-one will. I can post patches to switch to
> > > string-only references.
> > 
> > I think that it should be sufficient to update the documentation so it
> > does not describe the indirect mechanism mentioned in the changelog of
> > commit 9880702d123f, shouldn't it?
> 
> I'd think so.
> 
> The REF+STR data node references actually go back to
> Documentation/firmware-guide/acpi/dsd/data-node-references.rst merged in
> 2018 and their documented use includes LEDs (besides graphs) as well. Just
> FYI though.

Oops. I missed Laurent's comments while replying the previous time. I'll
send v2 soon.

-- 
Sakari Ailus

