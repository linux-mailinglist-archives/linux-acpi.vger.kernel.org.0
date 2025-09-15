Return-Path: <linux-acpi+bounces-16956-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBFBB58437
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 20:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EA27A94E4
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 18:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B80C27D77A;
	Mon, 15 Sep 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4KpjLbq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D22276045
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959546; cv=none; b=U2U8xtechdabfv+WQfkx84LS6OxvIASaPdxK/CpAeGq4ek52IPpL6O0IPNikfBUfzlAneDF6R3z/p+yfuxODLozl9StlaU+HuWvjFuAS1flkbV6hspwuUGp/RznjUSjeazoA76CkLunuNA9gXw0kqlPwuAzZ6b7P450Xz1SfSq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959546; c=relaxed/simple;
	bh=KaHs9H79igOzz5DG7HCVzqRefh3hSnWZpPs2XMjBIZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzJEavnxX3GheJMsNIaRqC3NJv3IZPH+6nuLCBuJx8Kb1PUx/JytsBGBvZ4fEAvftn96Y9A95caDK3ywoleAzF5hTFqfhSmXD0GLSFhJzhueMhT2uZXOJ9BiQv4Wmj8bV1wGUxunUwr4yVeiWhbQ9rLC3TMh8Wl5TuevWuO9hjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4KpjLbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE345C4CEF1
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 18:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757959546;
	bh=KaHs9H79igOzz5DG7HCVzqRefh3hSnWZpPs2XMjBIZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g4KpjLbqx31jLhD923f0mY+v4YHZCOkMswSAkqSfyYUE5dPBfnmAMLIP1yM3kidfz
	 oz8pt0WwGgJhSk4dWWJgPm2TvC0dP9GowxDCdqsUScB3/eIe85Gy5nkNY9BOLJVptf
	 6li9NZkji4PFaunTLNbml+AwEzDpDWHUQQLQ2X2SVOg2UsWWv9syBdUqZ0IOgZAWAX
	 r9rSrfZkneRL5BwzyhptVP8wo5px+m1k3mqOMoO9UNqOrSxQVa+T+OmcBMqx/kyuzb
	 uGlsTS/wEakCehdNAwzdS+irSP19U9varIYZhKOxJr+4cXSyDQjx4Ui/XPCz0dlbgz
	 otkWMupHjY/KA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-62344ae5bacso791123eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 11:05:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWduyR0CNakRqkvCheNI/CiOsB1QLJ07olpsc2ij50tJlbTfKlU5AKAbCPCp4kslxtD4NI2IweexHVk@vger.kernel.org
X-Gm-Message-State: AOJu0YxL/zRv430cg3xt8MXJA9pecIW3ZkNVsOj1VE2eA/zFBu9k3+Ru
	s7qdvqQJSfdO6ELPFCj9Uhd8bFkrQcYQxv/vzcKUdZCP01ZsqLcoxFab08CF4kUyG06FBjxY/I+
	00ZEudI6JWSf5OcRyh1eqrvMdHEkUpL0=
X-Google-Smtp-Source: AGHT+IE5z4L5y2+SXHun7uzV1DSTnQd8k1nuBntT8CHm4nvoEvWOAePm/emftEEH5UTVFzp5jRZtijuDolugjf2W/g4=
X-Received: by 2002:a05:6820:6ac4:b0:61b:9bfa:593c with SMTP id
 006d021491bc7-621b2f4a501mr8746336eaf.3.1757959545272; Mon, 15 Sep 2025
 11:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5046661.31r3eYUQgx@rafael.j.wysocki> <2243680.irdbgypaU6@rafael.j.wysocki>
 <aMf5ZNW9t_6tfsjy@kekkonen.localdomain> <CAJZ5v0ivX3s=pChGZ_+zeUswJgMPDH2Wi_cGeATyh+M9Tb0LYw@mail.gmail.com>
 <CAJZ5v0jVeSrDO6hrZhKgRZrH=FpGD4vNUjFD8hV9WwN9TLHjzQ@mail.gmail.com> <aMhSPQZxYB61wVYe@kekkonen.localdomain>
In-Reply-To: <aMhSPQZxYB61wVYe@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Sep 2025 20:05:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iAG8PfeejzL3wUsW4b_9oakgAVi2vOQbvLkB7=rU85=g@mail.gmail.com>
X-Gm-Features: AS18NWAZGJjROcAlFCHIK_GdZCQYG1yBXybMRruB_9ZDHpzYaMN5EpHyD4fon5w
Message-ID: <CAJZ5v0iAG8PfeejzL3wUsW4b_9oakgAVi2vOQbvLkB7=rU85=g@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] ACPI: property: Add code comments explaining what
 is going on
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Mon, Sep 15, 2025 at 7:52=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Sep 15, 2025 at 07:12:44PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Sep 15, 2025 at 2:27=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > Hi Sakari,
> > >
> > > On Mon, Sep 15, 2025 at 1:32=E2=80=AFPM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Hi Rafael,
> > > >
> > > > On Fri, Sep 12, 2025 at 09:40:58PM +0200, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > In some places in the ACPI device properties handling code, it is
> > > > > unclear why the code is what it is.  Some assumptions are not doc=
umented
> > > > > and some pieces of code are based on experience that is not menti=
oned
> > > > > anywhere.
> > > > >
> > > > > Add code comments explaining these things.
> > > > >
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >  drivers/acpi/property.c |   51 +++++++++++++++++++++++++++++++++=
+++++++++++++--
> > > > >  1 file changed, 49 insertions(+), 2 deletions(-)
> > > > >
> > > > > --- a/drivers/acpi/property.c
> > > > > +++ b/drivers/acpi/property.c
> > > > > @@ -108,7 +108,18 @@ static bool acpi_nondev_subnode_extract(
> > > > >       if (handle)
> > > > >               acpi_get_parent(handle, &scope);
> > > > >
> > > > > +     /*
> > > > > +      * Extract properties from the _DSD-equivalent package poin=
ted to by
> > > > > +      * desc and use scope (if not NULL) for the completion of r=
elative
> > > > > +      * pathname segments.
> > > > > +      *
> > > > > +      * The extracted properties will be held in the new data no=
de dn.
> > > > > +      */
> > > > >       result =3D acpi_extract_properties(scope, desc, &dn->data);
> > > > > +     /*
> > > > > +      * Look for subnodes in the _DSD-equivalent package pointed=
 to by desc
> > > > > +      * and create child nodes of dn if there are any.
> > > > > +      */
> > > > >       if (acpi_enumerate_nondev_subnodes(scope, desc, &dn->data, =
&dn->fwnode))
> > > > >               result =3D true;
> > > > >
> > > > > @@ -153,6 +164,12 @@ static bool acpi_nondev_subnode_ok(acpi_
> > > > >       acpi_handle handle;
> > > > >       acpi_status status;
> > > > >
> > > > > +     /*
> > > > > +      * If the scope is unknown, the _DSD-equivalent package bei=
ng parsed
> > > > > +      * was embedded in an outer _DSD-equivalent package as a re=
sult of
> > > > > +      * direct evaluation of an object pointed to by a reference=
.  In that
> > > > > +      * case, using a pathname as the target object pointer is i=
nvalid.
> > > > > +      */
> > > > >       if (!scope)
> > > > >               return false;
> > > > >
> > > > > @@ -172,6 +189,10 @@ static bool acpi_add_nondev_subnodes(acp
> > > > >       bool ret =3D false;
> > > > >       int i;
> > > > >
> > > > > +     /*
> > > > > +      * Every element in the links package is expected to repres=
ent a link
> > > > > +      * to a non-device node in a tree containing device-specifi=
c data.
> > > > > +      */
> > > > >       for (i =3D 0; i < links->package.count; i++) {
> > > > >               union acpi_object *link, *desc;
> > > > >               acpi_handle handle;
> > > > > @@ -182,22 +203,48 @@ static bool acpi_add_nondev_subnodes(acp
> > > > >               if (link->package.count !=3D 2)
> > > > >                       continue;
> > > > >
> > > > > -             /* The first one must be a string. */
> > > > > +             /* The first one (the key) must be a string. */
> > > > >               if (link->package.elements[0].type !=3D ACPI_TYPE_S=
TRING)
> > > > >                       continue;
> > > > >
> > > > > -             /* The second one may be a string, a reference or a=
 package. */
> > > > > +             /*
> > > > > +              * The second one (the target) may be a string, a r=
eference or
> > > > > +              * a package.
> > > > > +              */
> > > > >               switch (link->package.elements[1].type) {
> > > > >               case ACPI_TYPE_STRING:
> > > > > +                     /*
> > > > > +                      * The string is expected to be a full path=
name or a
> > > > > +                      * pathname segment relative to the given s=
cope.  That
> > > > > +                      * pathname is expected to point to an obje=
ct returning
> > > > > +                      * a package that contains _DSD-equivalent =
information.
> > > > > +                      */
> > > > >                       result =3D acpi_nondev_subnode_ok(scope, li=
nk, list,
> > > > >                                                        parent);
> > > > >                       break;
> > > > >               case ACPI_TYPE_LOCAL_REFERENCE:
> > > >
> > > > I think you get ACPI_TYPE_LOCAL_REFERENCE only when you evaluate a
> > > > reference to a device object.
> > >
> > > If it is so, the code below is just dead because the target here is
> > > expected to be a named object (not a device), in which case it would
> > > just be better to delete this code.
> >
> > Well, unless there's a bug in the ACPI tables attempting to add a
> > reference to a device as a data-only subnode.  Of course, this won't
> > work, but printing a message in that case may help.
> >
> > > Is this what you mean?
> >
> > I think it is and you are right: Referencing a named object will cause
> > that object to be evaluated automatically and its return data to be
> > embedded into the return package at the location of the reference.
> >
> > So I think that this piece is confusing and I'm going to get rid of it.
>
> Sounds reasonable. Maybe this change would be worth its own patch?

Yes, it would.

> The DSD guide indeed requires the target evaluates to a package object
> while a device object does not. The ACPICA doesn't document this behaviou=
r
> (or at least I'm not aware of it), which is probably why we have this cod=
e
> here.

This is what generally happens when AML is evaluated.

For instance, on SMP platforms, each CPU object is expected to contain
multiple named objects like _CST, _CPC, _PSS etc.  Typically, each of
these objects returns the same data for every CPU and typically, there
is one internal named object referred to by, say, _CST for each CPU.
Had references been returned in such cases, that wouldn't have worked.

