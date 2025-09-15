Return-Path: <linux-acpi+bounces-16970-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2422B58625
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 22:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7619A48697B
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 20:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078529D288;
	Mon, 15 Sep 2025 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oq0qEIQy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F89E1DE4EF;
	Mon, 15 Sep 2025 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757969030; cv=none; b=bj5f1YEAb0OnmT8VoNaBLuRKWvbGS/tRyNT8etVRP4nyD4UDWwYVsapwCiG0YGUZ91WQpNivAv43bcdW9viDEyB0yFKUPge4PADMs+GtRn6IghQQALm2h2LTJiVGWj54c0JcpLvFesw7pPSVnkUs1+QzFqlBC+9w3TgzNqfGMWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757969030; c=relaxed/simple;
	bh=695R1vYPpuNbJl9CF6lG6ZpeSbRULXA1ysOWwkZk+Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STC6TwbWo37mG2sWNR9d2skCFdubPMlcciNi46P2pTY9h6CE1uUEiGNf17v/tpLqAy9+77khU500tDOVd9ZVZYxGpCWEfMWavq56xk7NZOwxFK8XdB7H/IOKCYmRvry0Pq3jBjQWpMm+4m9d/yy0BZXOGULsEgU0KtVZDlc5VGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oq0qEIQy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757969030; x=1789505030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=695R1vYPpuNbJl9CF6lG6ZpeSbRULXA1ysOWwkZk+Zc=;
  b=Oq0qEIQyUYzbdMIXEflb3QEc7Zc5NLungdVX7qmr8eyysJnAISpKsdKu
   4U5+SYkrjVxvVmjPbpx6nh/v956m0mVq7HNXJyrmaWuZPDWoJeHiKkrGt
   wajRdwvyDmaLQVGDoBIf8kz26ex9Q/Pol9ocFOYOqbQ9STzfKvKg0jC0W
   xhfwyC5OdrrU+gxPRG0I+KUJw3ntvaY1sKMOZQVQXeF9GpJ0MYjtlhmDn
   L7b0fLIfIeznewfxuo66pZalgeVN+kqORjvuuCq4TTGGo34whNxDS7M71
   peEJmoLE02365MB6jLM8d8vvzXMwvvInfa2g7KeIxbu4ACxjm7qB0cvvI
   g==;
X-CSE-ConnectionGUID: jbpGcfHOQkmEhFK7cuZSeQ==
X-CSE-MsgGUID: Lw4m9LMwTXChQVFb4JrlaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="59933382"
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="59933382"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 13:43:49 -0700
X-CSE-ConnectionGUID: 2ASxq904TqqAYH4tClBQlQ==
X-CSE-MsgGUID: 4l9LuPNtQdesDyif1WLEwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="179898705"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.113])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 13:43:47 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 645A911F785;
	Mon, 15 Sep 2025 23:43:44 +0300 (EEST)
Date: Mon, 15 Sep 2025 23:43:44 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 3/4] ACPI: property: Do not pass NULL handles to
 acpi_attach_data()
Message-ID: <aMh6gJtQcRgqgYd6@kekkonen.localdomain>
References: <5046661.31r3eYUQgx@rafael.j.wysocki>
 <3014880.e9J7NaK4W3@rafael.j.wysocki>
 <aMf9YRHA8jRgMPAr@kekkonen.localdomain>
 <CAJZ5v0hPjWHwSSc9cTdC76RypWGPUYrkqw+W3Vb52uy_UJpk9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hPjWHwSSc9cTdC76RypWGPUYrkqw+W3Vb52uy_UJpk9A@mail.gmail.com>

Hi Rafael,

On Mon, Sep 15, 2025 at 02:57:31PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Mon, Sep 15, 2025 at 1:50 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Fri, Sep 12, 2025 at 09:42:55PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > In certain circumstances, the ACPI handle of a data-only node may be
> > > NULL, in which case it does not make sense to attempt to attach that
> > > node to an ACPI namespace object, so update the code to avoid attempts
> > > to do so.
> > >
> > > This prevents confusing and unuseful error messages from being printed.
> > >
> > > Also document the fact that the ACPI handle of a data-only node may be
> > > NULL, and when that happens, in a code comment.
> > >
> > > In addition, make acpi_add_nondev_subnodes() print a diagnostic message
> > > for each data-only node with an unknown ACPI namespace scope.
> > >
> > > Fixes: 1d52f10917a7 ("ACPI: property: Tie data nodes to acpi handles")
> > > Cc: 6.0+ <stable@vger.kernel.org> # 6.0+
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/acpi/property.c |   12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -124,6 +124,10 @@ static bool acpi_nondev_subnode_extract(
> > >               result = true;
> > >
> > >       if (result) {
> > > +             /*
> > > +              * This will be NULL if the desc package is embedded in an outer
> > > +              * _DSD-equivalent package and its scope cannot be determined.
> > > +              */
> >
> > I think indeed this happens in particular when when references to
> > non-device nodes; there's no handle because when you get is basically a
> > dynamically allocated copy of a node.
> 
> I know for a fact that this happens, that's why I'm adding the comment here.

I wanted to say it could be helpful to have this written in the comment.

> 
> > >               dn->handle = handle;
> > >               dn->data.pointer = desc;
> > >               list_add_tail(&dn->sibling, list);
> > > @@ -245,6 +249,8 @@ static bool acpi_add_nondev_subnodes(acp
> > >                        * strings because there is no way to build full
> > >                        * pathnames out of them.
> > >                        */
> > > +                     acpi_handle_info(scope, "Unknown namespace scope of node %s\n",
> > > +                                      link->package.elements[0].string.pointer);
> > >                       desc = &link->package.elements[1];
> > >                       result = acpi_nondev_subnode_extract(desc, NULL, link,
> > >                                                            list, parent);
> > > @@ -408,6 +414,9 @@ static void acpi_untie_nondev_subnodes(s
> > >       struct acpi_data_node *dn;
> > >
> > >       list_for_each_entry(dn, &data->subnodes, sibling) {
> > > +             if (!dn->handle)
> > > +                     continue;
> > > +
> > >               acpi_detach_data(dn->handle, acpi_nondev_subnode_tag);
> > >
> > >               acpi_untie_nondev_subnodes(&dn->data);
> > > @@ -422,6 +431,9 @@ static bool acpi_tie_nondev_subnodes(str
> > >               acpi_status status;
> > >               bool ret;
> > >
> > > +             if (!dn->handle)
> > > +                     continue;
> > > +
> > >               status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
> > >               if (ACPI_FAILURE(status) && status != AE_ALREADY_EXISTS) {
> > >                       acpi_handle_err(dn->handle, "Can't tag data node\n");
> > >
> > >
> > >
> >

-- 
Kind regards,

Sakari Ailus

