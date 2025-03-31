Return-Path: <linux-acpi+bounces-12566-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0164CA76BA2
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 18:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99AB166C1B
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62642147F8;
	Mon, 31 Mar 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUbLFtWQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA412144DD
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743437438; cv=none; b=nEHqSBOJ2r8pcbjp1hrfB7JNXZUKjIUQCevX0+RYzDeY4DN/rtIUS8XVGm5KMrKJJdnD8cBvIeOY+0OH1QBnZE1NvYgpaLtOzXMPS71jfHMIUmyak3qHz5rx4WNqgrvOPeW01jjo2i2H/3cIgd/QAbic1udizP3KVwwLm34anpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743437438; c=relaxed/simple;
	bh=dXIMTscsMuNwRN2N0ikcd8eHLE90/VIO+xbosdWWSo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5hxv/ZCTTzmZwL5mL1KWQBKqALGkzbGBsTUxYh39IA2oQshT+IzHlkZYcEQzZyxP0u7Fbjxc6kWv/C8uhTD8sUbqYvBuxZLOERMOih38eTxmRZ4JswCh00gFQXUvaa7ddknkrO4VlXm6il9zmGBBB4kwsfAKfdZiYSejAdu/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUbLFtWQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743437437; x=1774973437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dXIMTscsMuNwRN2N0ikcd8eHLE90/VIO+xbosdWWSo0=;
  b=kUbLFtWQRRu7Kln3trHz2Q4teCto+anfLIoxrzKSSUc9yvAB1pppMFcq
   6xxP2nx8qzRPtk/eV5O1QW/efSDnvYRcDbwjy3yVBv1ol/RGGEW3t1Bz4
   vzDNAxbDQ25QE/AAnutAVJWoP+rila2DgPgxa8ShXkDF3ywzXnorkfRt4
   j6qAPVr0RB27/Y13zO0GoY/1MWHTpvUfUMZOo3HCFBkokwGsPo2/4crMb
   d26SAwJtaIlA1+SkY1GitSKXhdKdTAVA3if/AMLze/zvG2CQUlzqKN4fS
   aGVZJhbg18eFqH3sPnuNprT8idzoyNY+mtceJCtSqtr2dm0s0nBW4eLtZ
   w==;
X-CSE-ConnectionGUID: aFpCBAPOTMKonSBElQXKvA==
X-CSE-MsgGUID: vVLfccg0RNqxeBc8DfMIJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44888029"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="44888029"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 09:10:37 -0700
X-CSE-ConnectionGUID: 5jet1xJgRfWEQa+MX+oDbQ==
X-CSE-MsgGUID: kCNoIly5Qs2IOp1JU3xakQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="125883197"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 09:10:35 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 7345511FC9E;
	Mon, 31 Mar 2025 19:10:32 +0300 (EEST)
Date: Mon, 31 Mar 2025 16:10:32 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] ACPI: property: Fix REF STR... reference parsing
Message-ID: <Z-q-ePJeM4XzeffL@kekkonen.localdomain>
References: <20250331121836.2495903-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0jGCaJLTka57nB6mx4VDxZJUBVBbGV=7HdKKpf+7jCvjw@mail.gmail.com>
 <Z-qaOXTRS7z_He62@kekkonen.localdomain>
 <CAJZ5v0gaDSAS6rgKxtOVgz+kSYVNvG2--o9kR40BKt5Z6Barog@mail.gmail.com>
 <Z-qwRpddAZ9Upi6r@kekkonen.localdomain>
 <CAJZ5v0i=h1AQm5LVDj4m6X+oEh=3AQ=jMAMr+p6=K13AP73C9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i=h1AQm5LVDj4m6X+oEh=3AQ=jMAMr+p6=K13AP73C9w@mail.gmail.com>

Hi Rafael,

On Mon, Mar 31, 2025 at 05:35:50PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Mon, Mar 31, 2025 at 5:10 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Mon, Mar 31, 2025 at 05:00:52PM +0200, Rafael J. Wysocki wrote:
> > > Hi Sakari,
> > >
> > > On Mon, Mar 31, 2025 at 3:35 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Hi Rafael,
> > > >
> > > > On Mon, Mar 31, 2025 at 03:19:07PM +0200, Rafael J. Wysocki wrote:
> > > > > On Mon, Mar 31, 2025 at 2:18 PM Sakari Ailus
> > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > >
> > > > > > Restore parsing of ACPI data node references consisting of a device node
> > > > > > reference followed by one or more child data node names.
> > > > > >
> > > > > > Fixes: 9880702d123f ("ACPI: property: Support using strings in reference properties")
> > > > > > Cc: stable@vger.kernel.org # for 6.8 and later
> > > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > > ---
> > > > > > Hi Rafael,
> > > > > >
> > > > > > It seems that support for REF STR... references got accidentally removed
> > > > > > when pure STR reference were added. The former are documented in
> > > > > > Documentation/firmware-guide/acpi/dsd/graph.rst .
> > > > >
> > > > > It would be good to provide an ASL example that is not parsed as
> > > > > expected before the change and will be parsed correctly after it.
> > > > >
> > > > > Admittedly, I can't quite recall the history leading to the above
> > > > > commit, but this paragraphs is present in its changelog:
> > > > >
> > > > > "Also remove the mechanism allowing data nodes to be referenced
> > > > >  indirectly, with the help of an object reference pointing to the
> > > > >  "ancestor" device and a path relative to it (this mechanism is not
> > > > >  expected to be in use in any production platform firmware in the field)."
> > > > >
> > > > > so the change in question appears to be intentional rather than accidental.
> > > >
> > > > Right. This still continues to be documented in
> > > > Documentation/firmware-guide/acpi/dsd/graph.rst as noted in my previous
> > > > e-mail. A sample ASL snippet is can also be found in the same file. I only
> > > > noticed this when I tried to use such references.
> > > >
> > > > The other option indeed is to change the documentation and hope no-one
> > > > depends on it.
> > >
> > > I thought that this was the original plan.
> >
> > I wasn't aware of the plan. But given that no-one has complained yet,
> > there's a fair chance no-one will. I can post patches to switch to
> > string-only references.
> 
> I think that it should be sufficient to update the documentation so it
> does not describe the indirect mechanism mentioned in the changelog of
> commit 9880702d123f, shouldn't it?

I'd think so.

The REF+STR data node references actually go back to
Documentation/firmware-guide/acpi/dsd/data-node-references.rst merged in
2018 and their documented use includes LEDs (besides graphs) as well. Just
FYI though.

-- 
Sakari Ailus

