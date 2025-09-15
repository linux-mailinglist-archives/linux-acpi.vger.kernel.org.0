Return-Path: <linux-acpi+bounces-16954-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D82B583FF
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 19:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B49C16C1C1
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 17:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD2128B400;
	Mon, 15 Sep 2025 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwUc5kcN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CD45C96;
	Mon, 15 Sep 2025 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958725; cv=none; b=iP7xLt4YTE+NGqVOfhW7KqPaW+Vr1BiVag9YTm/pYHwmnS27NGNZ+9ZbGETOUSsvO8D5aWLtGbNTgTLJV3SWu90CIKE4XjRTS6LSyxzZOoL2tjZYpzgr6ycNnrFB5mPgP+1nPrf8xa5wrWqppSdxhB0+qFtW+U8QJ+c9oObsl7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958725; c=relaxed/simple;
	bh=NU+TKvEvde8dfyNg/eYCd/pOhIAzHUbKhhLR1unR06g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2m5CrPNFcJ8K/IrW8PjkOzxrpjZIh51LODbEp5f6FkTGCNs6hd7Mhc1igL1JS9dx6AIwpjzbflSTjhSsazDT8biNEO7iACIOohIjLwkJDKx//EhSQi01D0lvPGRECxDxTUxq8qN8NsEJXP977GSc//P0GdB9nv2l19NihHbVnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwUc5kcN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757958724; x=1789494724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NU+TKvEvde8dfyNg/eYCd/pOhIAzHUbKhhLR1unR06g=;
  b=iwUc5kcNo2t2Z1bdRWRenvPbGiiWt2/geyweN0pMwNs9TofKH45H1CJg
   sjtuaABJUQNL3NSeKDaT7bUGwwGUWL6zDbgT5xf+Qj8uoDl+XTBiOEQR/
   o4xmN/PJS2lBdgfw0TJ6didDbG+hPOEpueetfumnWrTJrxmwBQBAkAJD+
   dAMqDzOEL8iRF95HC/zLi65qwUnQ1yJwBzQdU1jUrcwthS+QQaKR1mrmy
   XuBx57qhD4VuSrbYWKAyXFn603kGvdLapnq8szxQDiDqAptlrHLWxCncU
   iuYDDcC++ixFrnJnZC2pF9vMXXYJQJizmij+EX+3VYH28QYixoL1fstEY
   g==;
X-CSE-ConnectionGUID: +LU7x6YBTQ6t/34xB6o24Q==
X-CSE-MsgGUID: BC7ETP1kTvKBDQsWdLRgwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="64045148"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="64045148"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 10:52:03 -0700
X-CSE-ConnectionGUID: p1TAoOGIS7+NWPc1DhIsMw==
X-CSE-MsgGUID: Qw5OfQ+xS+6o7Lgh/VoUlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="174254944"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.113])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 10:52:01 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id B102411F785;
	Mon, 15 Sep 2025 20:51:57 +0300 (EEST)
Date: Mon, 15 Sep 2025 20:51:57 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/4] ACPI: property: Add code comments explaining what
 is going on
Message-ID: <aMhSPQZxYB61wVYe@kekkonen.localdomain>
References: <5046661.31r3eYUQgx@rafael.j.wysocki>
 <2243680.irdbgypaU6@rafael.j.wysocki>
 <aMf5ZNW9t_6tfsjy@kekkonen.localdomain>
 <CAJZ5v0ivX3s=pChGZ_+zeUswJgMPDH2Wi_cGeATyh+M9Tb0LYw@mail.gmail.com>
 <CAJZ5v0jVeSrDO6hrZhKgRZrH=FpGD4vNUjFD8hV9WwN9TLHjzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jVeSrDO6hrZhKgRZrH=FpGD4vNUjFD8hV9WwN9TLHjzQ@mail.gmail.com>

Hi Rafael,

On Mon, Sep 15, 2025 at 07:12:44PM +0200, Rafael J. Wysocki wrote:
> On Mon, Sep 15, 2025 at 2:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > Hi Sakari,
> >
> > On Mon, Sep 15, 2025 at 1:32 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Fri, Sep 12, 2025 at 09:40:58PM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > In some places in the ACPI device properties handling code, it is
> > > > unclear why the code is what it is.  Some assumptions are not documented
> > > > and some pieces of code are based on experience that is not mentioned
> > > > anywhere.
> > > >
> > > > Add code comments explaining these things.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/acpi/property.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 49 insertions(+), 2 deletions(-)
> > > >
> > > > --- a/drivers/acpi/property.c
> > > > +++ b/drivers/acpi/property.c
> > > > @@ -108,7 +108,18 @@ static bool acpi_nondev_subnode_extract(
> > > >       if (handle)
> > > >               acpi_get_parent(handle, &scope);
> > > >
> > > > +     /*
> > > > +      * Extract properties from the _DSD-equivalent package pointed to by
> > > > +      * desc and use scope (if not NULL) for the completion of relative
> > > > +      * pathname segments.
> > > > +      *
> > > > +      * The extracted properties will be held in the new data node dn.
> > > > +      */
> > > >       result = acpi_extract_properties(scope, desc, &dn->data);
> > > > +     /*
> > > > +      * Look for subnodes in the _DSD-equivalent package pointed to by desc
> > > > +      * and create child nodes of dn if there are any.
> > > > +      */
> > > >       if (acpi_enumerate_nondev_subnodes(scope, desc, &dn->data, &dn->fwnode))
> > > >               result = true;
> > > >
> > > > @@ -153,6 +164,12 @@ static bool acpi_nondev_subnode_ok(acpi_
> > > >       acpi_handle handle;
> > > >       acpi_status status;
> > > >
> > > > +     /*
> > > > +      * If the scope is unknown, the _DSD-equivalent package being parsed
> > > > +      * was embedded in an outer _DSD-equivalent package as a result of
> > > > +      * direct evaluation of an object pointed to by a reference.  In that
> > > > +      * case, using a pathname as the target object pointer is invalid.
> > > > +      */
> > > >       if (!scope)
> > > >               return false;
> > > >
> > > > @@ -172,6 +189,10 @@ static bool acpi_add_nondev_subnodes(acp
> > > >       bool ret = false;
> > > >       int i;
> > > >
> > > > +     /*
> > > > +      * Every element in the links package is expected to represent a link
> > > > +      * to a non-device node in a tree containing device-specific data.
> > > > +      */
> > > >       for (i = 0; i < links->package.count; i++) {
> > > >               union acpi_object *link, *desc;
> > > >               acpi_handle handle;
> > > > @@ -182,22 +203,48 @@ static bool acpi_add_nondev_subnodes(acp
> > > >               if (link->package.count != 2)
> > > >                       continue;
> > > >
> > > > -             /* The first one must be a string. */
> > > > +             /* The first one (the key) must be a string. */
> > > >               if (link->package.elements[0].type != ACPI_TYPE_STRING)
> > > >                       continue;
> > > >
> > > > -             /* The second one may be a string, a reference or a package. */
> > > > +             /*
> > > > +              * The second one (the target) may be a string, a reference or
> > > > +              * a package.
> > > > +              */
> > > >               switch (link->package.elements[1].type) {
> > > >               case ACPI_TYPE_STRING:
> > > > +                     /*
> > > > +                      * The string is expected to be a full pathname or a
> > > > +                      * pathname segment relative to the given scope.  That
> > > > +                      * pathname is expected to point to an object returning
> > > > +                      * a package that contains _DSD-equivalent information.
> > > > +                      */
> > > >                       result = acpi_nondev_subnode_ok(scope, link, list,
> > > >                                                        parent);
> > > >                       break;
> > > >               case ACPI_TYPE_LOCAL_REFERENCE:
> > >
> > > I think you get ACPI_TYPE_LOCAL_REFERENCE only when you evaluate a
> > > reference to a device object.
> >
> > If it is so, the code below is just dead because the target here is
> > expected to be a named object (not a device), in which case it would
> > just be better to delete this code.
> 
> Well, unless there's a bug in the ACPI tables attempting to add a
> reference to a device as a data-only subnode.  Of course, this won't
> work, but printing a message in that case may help.
> 
> > Is this what you mean?
> 
> I think it is and you are right: Referencing a named object will cause
> that object to be evaluated automatically and its return data to be
> embedded into the return package at the location of the reference.
> 
> So I think that this piece is confusing and I'm going to get rid of it.

Sounds reasonable. Maybe this change would be worth its own patch?

The DSD guide indeed requires the target evaluates to a package object
while a device object does not. The ACPICA doesn't document this behaviour
(or at least I'm not aware of it), which is probably why we have this code
here.

-- 
Kind regards,

Sakari Ailus

