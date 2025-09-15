Return-Path: <linux-acpi+bounces-16966-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4D0B58600
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 22:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6723B313A
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 20:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A39028E5F3;
	Mon, 15 Sep 2025 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtOEXYBX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EC728D8DA;
	Mon, 15 Sep 2025 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967829; cv=none; b=Evsu9SW9o+Nftk+mf5+K42VlPq7uf70QhpWBbOIWPvXf51rOoCvFuTcU5TdzHCA4ROL5J7Adh1UT9RtSUsCyFl1iDU7oxL/NOPcvJiGFCLWxQYxWbyGGWybgk6S0VaVthDh9MkAH4ejk4YElBZ6jAp4n1ztFdqcHyRaVGX9+9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967829; c=relaxed/simple;
	bh=+fk+yzu0v7lzLaGvdy1dpx0lSgxuC3N33GL3d4ddVDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVRLOXNsxyptrXk2Rzz1w8dLPsFywxie8xeWF+mrcf4unmCrHnxPAVJMMeKZ9eYBMhzJEG5aYuiXsMEqofuqkBeWhhHz0isMo4nwdGzRKoF2kCHFGi8Y5anXX/m+nuec9GwLlwB/mC8EeXL+YNmn/ATolwOGZmGShD6cA/i50Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtOEXYBX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757967827; x=1789503827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+fk+yzu0v7lzLaGvdy1dpx0lSgxuC3N33GL3d4ddVDI=;
  b=mtOEXYBXAqNyv3xfWWsdxhsuYlgHbci7raln8ivpSOictw/6Fi6+hRnD
   K5XtFPReb6en/gx92dZ85+Vll9EJf6RAxyQLpw+8tQoolemFDKGv/UY/m
   ebanzdP5Z9sT9XT8ZZcCLlGwpkf1B3TdkI0JK/i09aLa9nBghQnJtiz3P
   PFT/5zVtphFIkXRNmGFtk24LRBzn1ZYebRn+lHnUwsfXh2hdCNbyfFrSS
   pOgkeDqtY68I60vDvLMDH7N7LwnyCCYlElYZe0NB+KPSxkpuW8TRKwqbo
   oWsz/6f8mNHCWnX4Q0SuRNIhP+cQ9L+nyVGmTsG0BS14Hsho71QO26JNY
   w==;
X-CSE-ConnectionGUID: KPaK9XeXSBCTAhS9ux+PIw==
X-CSE-MsgGUID: jmACBGqETSerkxWEK6X+6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="71604979"
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="71604979"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 13:23:46 -0700
X-CSE-ConnectionGUID: HwHBMwhxT6i8ey8PVoghiA==
X-CSE-MsgGUID: fvvoia38SwSPL5PEQAZBnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="205713397"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.113])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 13:23:44 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id DA65A11F785;
	Mon, 15 Sep 2025 23:23:41 +0300 (EEST)
Date: Mon, 15 Sep 2025 23:23:41 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/4] ACPI: property: Add code comments explaining what
 is going on
Message-ID: <aMh1zTYm-YJmG-5i@kekkonen.localdomain>
References: <5046661.31r3eYUQgx@rafael.j.wysocki>
 <2243680.irdbgypaU6@rafael.j.wysocki>
 <aMf5ZNW9t_6tfsjy@kekkonen.localdomain>
 <CAJZ5v0ivX3s=pChGZ_+zeUswJgMPDH2Wi_cGeATyh+M9Tb0LYw@mail.gmail.com>
 <CAJZ5v0jVeSrDO6hrZhKgRZrH=FpGD4vNUjFD8hV9WwN9TLHjzQ@mail.gmail.com>
 <aMhSPQZxYB61wVYe@kekkonen.localdomain>
 <CAJZ5v0iAG8PfeejzL3wUsW4b_9oakgAVi2vOQbvLkB7=rU85=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iAG8PfeejzL3wUsW4b_9oakgAVi2vOQbvLkB7=rU85=g@mail.gmail.com>

Hi Rafael,

On Mon, Sep 15, 2025 at 08:05:34PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Mon, Sep 15, 2025 at 7:52 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Mon, Sep 15, 2025 at 07:12:44PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Sep 15, 2025 at 2:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > Hi Sakari,
> > > >
> > > > On Mon, Sep 15, 2025 at 1:32 PM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > >
> > > > > Hi Rafael,
> > > > >
> > > > > On Fri, Sep 12, 2025 at 09:40:58PM +0200, Rafael J. Wysocki wrote:
> > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > >
> > > > > > In some places in the ACPI device properties handling code, it is
> > > > > > unclear why the code is what it is.  Some assumptions are not documented
> > > > > > and some pieces of code are based on experience that is not mentioned
> > > > > > anywhere.
> > > > > >
> > > > > > Add code comments explaining these things.
> > > > > >
> > > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > ---
> > > > > >  drivers/acpi/property.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++--
> > > > > >  1 file changed, 49 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > --- a/drivers/acpi/property.c
> > > > > > +++ b/drivers/acpi/property.c
> > > > > > @@ -108,7 +108,18 @@ static bool acpi_nondev_subnode_extract(
> > > > > >       if (handle)
> > > > > >               acpi_get_parent(handle, &scope);
> > > > > >
> > > > > > +     /*
> > > > > > +      * Extract properties from the _DSD-equivalent package pointed to by
> > > > > > +      * desc and use scope (if not NULL) for the completion of relative
> > > > > > +      * pathname segments.
> > > > > > +      *
> > > > > > +      * The extracted properties will be held in the new data node dn.
> > > > > > +      */
> > > > > >       result = acpi_extract_properties(scope, desc, &dn->data);
> > > > > > +     /*
> > > > > > +      * Look for subnodes in the _DSD-equivalent package pointed to by desc
> > > > > > +      * and create child nodes of dn if there are any.
> > > > > > +      */
> > > > > >       if (acpi_enumerate_nondev_subnodes(scope, desc, &dn->data, &dn->fwnode))
> > > > > >               result = true;
> > > > > >
> > > > > > @@ -153,6 +164,12 @@ static bool acpi_nondev_subnode_ok(acpi_
> > > > > >       acpi_handle handle;
> > > > > >       acpi_status status;
> > > > > >
> > > > > > +     /*
> > > > > > +      * If the scope is unknown, the _DSD-equivalent package being parsed
> > > > > > +      * was embedded in an outer _DSD-equivalent package as a result of
> > > > > > +      * direct evaluation of an object pointed to by a reference.  In that
> > > > > > +      * case, using a pathname as the target object pointer is invalid.
> > > > > > +      */
> > > > > >       if (!scope)
> > > > > >               return false;
> > > > > >
> > > > > > @@ -172,6 +189,10 @@ static bool acpi_add_nondev_subnodes(acp
> > > > > >       bool ret = false;
> > > > > >       int i;
> > > > > >
> > > > > > +     /*
> > > > > > +      * Every element in the links package is expected to represent a link
> > > > > > +      * to a non-device node in a tree containing device-specific data.
> > > > > > +      */
> > > > > >       for (i = 0; i < links->package.count; i++) {
> > > > > >               union acpi_object *link, *desc;
> > > > > >               acpi_handle handle;
> > > > > > @@ -182,22 +203,48 @@ static bool acpi_add_nondev_subnodes(acp
> > > > > >               if (link->package.count != 2)
> > > > > >                       continue;
> > > > > >
> > > > > > -             /* The first one must be a string. */
> > > > > > +             /* The first one (the key) must be a string. */
> > > > > >               if (link->package.elements[0].type != ACPI_TYPE_STRING)
> > > > > >                       continue;
> > > > > >
> > > > > > -             /* The second one may be a string, a reference or a package. */
> > > > > > +             /*
> > > > > > +              * The second one (the target) may be a string, a reference or
> > > > > > +              * a package.
> > > > > > +              */
> > > > > >               switch (link->package.elements[1].type) {
> > > > > >               case ACPI_TYPE_STRING:
> > > > > > +                     /*
> > > > > > +                      * The string is expected to be a full pathname or a
> > > > > > +                      * pathname segment relative to the given scope.  That
> > > > > > +                      * pathname is expected to point to an object returning
> > > > > > +                      * a package that contains _DSD-equivalent information.
> > > > > > +                      */
> > > > > >                       result = acpi_nondev_subnode_ok(scope, link, list,
> > > > > >                                                        parent);
> > > > > >                       break;
> > > > > >               case ACPI_TYPE_LOCAL_REFERENCE:
> > > > >
> > > > > I think you get ACPI_TYPE_LOCAL_REFERENCE only when you evaluate a
> > > > > reference to a device object.
> > > >
> > > > If it is so, the code below is just dead because the target here is
> > > > expected to be a named object (not a device), in which case it would
> > > > just be better to delete this code.
> > >
> > > Well, unless there's a bug in the ACPI tables attempting to add a
> > > reference to a device as a data-only subnode.  Of course, this won't
> > > work, but printing a message in that case may help.
> > >
> > > > Is this what you mean?
> > >
> > > I think it is and you are right: Referencing a named object will cause
> > > that object to be evaluated automatically and its return data to be
> > > embedded into the return package at the location of the reference.
> > >
> > > So I think that this piece is confusing and I'm going to get rid of it.
> >
> > Sounds reasonable. Maybe this change would be worth its own patch?
> 
> Yes, it would.
> 
> > The DSD guide indeed requires the target evaluates to a package object
> > while a device object does not. The ACPICA doesn't document this behaviour
> > (or at least I'm not aware of it), which is probably why we have this code
> > here.
> 
> This is what generally happens when AML is evaluated.
> 
> For instance, on SMP platforms, each CPU object is expected to contain
> multiple named objects like _CST, _CPC, _PSS etc.  Typically, each of
> these objects returns the same data for every CPU and typically, there
> is one internal named object referred to by, say, _CST for each CPU.
> Had references been returned in such cases, that wouldn't have worked.

Conceivably, ACPICA could offer an evaluation function similar to
acpi_evaluate_object_typed() that simply wouldn't resolve references. I'm
not saying we should try to change existing behaviour elsewhere.

I don't really have an opinion how to address this, just that this is a
possibility as well.

-- 
Kind regards,

Sakari Ailus

