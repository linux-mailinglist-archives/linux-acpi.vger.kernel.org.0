Return-Path: <linux-acpi+bounces-12564-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B83A76AC3
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 17:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FB6188504E
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 15:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C121322E;
	Mon, 31 Mar 2025 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AidjD9Ys"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D2126C05
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433804; cv=none; b=jAVNQ37Gw4nOgpilfF2KRRT0S5kM3JSk4se4AqBSDPp5nrJcJDTJ6TOLbbpIJOk1LAL7ezSrQqrayQtB/VI/2pNhGFR80UBphZnjkjGu9juZTUcYrFbj4TkotQESyi9gSQNwyR+9/5Hj53ZH/JLnn1r+I9JDCIcJjH122Z48yVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433804; c=relaxed/simple;
	bh=lysHCRulRzSWnieO95MbulBsgdi7c5cZ747lQATUr04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugzyyFkyeW9Py2FohbdWPO54yAlWPwECQBhWVZGyN8bTld9AkgVLYUaiRew1KU5VXcWUDIcqjQch6gLMXITuXMlcbF63WBvuE0S419EDdCDOwLC6Jq8acNJOA2vstAs23AMB03s5B+wRCWgRS1xru2moHTu6xYZ3kcu2X+Xd0Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AidjD9Ys; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743433803; x=1774969803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lysHCRulRzSWnieO95MbulBsgdi7c5cZ747lQATUr04=;
  b=AidjD9Ys+FioMhMzAes+y7ja02bsoZyp49Pt6Cj6DENvjBcWBgdwrIEB
   vUnRwfdNbXHpHIkeJLYP8DIdqw0WZ1WXURaDQzXNoZVUf5/lmjARZvoHc
   gPfJoia6051VL8x7xKy09chh5S3AX5DdKpjKNqGzPAFRaY3L+ojY8WHTD
   4uoEuioLSGH2dDYHGrrBtDNEGj1AnWWAOf3rgyVpYWKPN3kWtsaW24cUD
   YBPsbUUT8EBH439+Fuvos7fALL68PIufueQP4L1ltJdzpAVR2G7rv7dk0
   efpBGIDkw9WrXa9B9EXZI5ZWnk/WNmSoWjhAmP3fnGrrT0rnzpsAddnFg
   A==;
X-CSE-ConnectionGUID: E8PY1UGGSAihYsu+ecTKSg==
X-CSE-MsgGUID: lvBAtoZQSR62KKbn+TjuFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44638003"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="44638003"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 08:10:02 -0700
X-CSE-ConnectionGUID: QEwCLu5LRoejPCn65eQGVg==
X-CSE-MsgGUID: +NqJHdN9QcWNGCBe7I8WwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="157033882"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 08:10:01 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 53B1011F9AC;
	Mon, 31 Mar 2025 18:09:58 +0300 (EEST)
Date: Mon, 31 Mar 2025 15:09:58 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] ACPI: property: Fix REF STR... reference parsing
Message-ID: <Z-qwRpddAZ9Upi6r@kekkonen.localdomain>
References: <20250331121836.2495903-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0jGCaJLTka57nB6mx4VDxZJUBVBbGV=7HdKKpf+7jCvjw@mail.gmail.com>
 <Z-qaOXTRS7z_He62@kekkonen.localdomain>
 <CAJZ5v0gaDSAS6rgKxtOVgz+kSYVNvG2--o9kR40BKt5Z6Barog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gaDSAS6rgKxtOVgz+kSYVNvG2--o9kR40BKt5Z6Barog@mail.gmail.com>

Hi Rafael,

On Mon, Mar 31, 2025 at 05:00:52PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Mon, Mar 31, 2025 at 3:35 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Mon, Mar 31, 2025 at 03:19:07PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Mar 31, 2025 at 2:18 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Restore parsing of ACPI data node references consisting of a device node
> > > > reference followed by one or more child data node names.
> > > >
> > > > Fixes: 9880702d123f ("ACPI: property: Support using strings in reference properties")
> > > > Cc: stable@vger.kernel.org # for 6.8 and later
> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > ---
> > > > Hi Rafael,
> > > >
> > > > It seems that support for REF STR... references got accidentally removed
> > > > when pure STR reference were added. The former are documented in
> > > > Documentation/firmware-guide/acpi/dsd/graph.rst .
> > >
> > > It would be good to provide an ASL example that is not parsed as
> > > expected before the change and will be parsed correctly after it.
> > >
> > > Admittedly, I can't quite recall the history leading to the above
> > > commit, but this paragraphs is present in its changelog:
> > >
> > > "Also remove the mechanism allowing data nodes to be referenced
> > >  indirectly, with the help of an object reference pointing to the
> > >  "ancestor" device and a path relative to it (this mechanism is not
> > >  expected to be in use in any production platform firmware in the field)."
> > >
> > > so the change in question appears to be intentional rather than accidental.
> >
> > Right. This still continues to be documented in
> > Documentation/firmware-guide/acpi/dsd/graph.rst as noted in my previous
> > e-mail. A sample ASL snippet is can also be found in the same file. I only
> > noticed this when I tried to use such references.
> >
> > The other option indeed is to change the documentation and hope no-one
> > depends on it.
> 
> I thought that this was the original plan.

I wasn't aware of the plan. But given that no-one has complained yet,
there's a fair chance no-one will. I can post patches to switch to
string-only references.

-- 
Sakari Ailus

