Return-Path: <linux-acpi+bounces-16949-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D6AB5831F
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 19:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C3B174782
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A92BDC00;
	Mon, 15 Sep 2025 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJpk6FSz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB7A27BF7E
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956377; cv=none; b=cKOeV11ZGkEEzlo/6v9XfOr1HgpTo6l+bYexlJtLmuN7tHuE8TIpNQX32flwJxHgBmOnDZeCDYCi7aRxNOFbattIg2UrwtpwsGa/hyoytFLXcRVjdTu7Nr3ZdDnZwAMttlSSiav0LNiIDYtIQuEVLL8+XJigCyRgIAD4gxDUsho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956377; c=relaxed/simple;
	bh=dHvDu3BEKKM6FZFaRlIA/1toY7ShEYyxM3AFgC8nWMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQ8JjJLGe51JqhsEoaVXNKFMbHgscFARoWkjETsJ+xOvppt3JOP4ocu0kvs6o7mG9Fp2I8KYa4Li2T2EwUleWMJH66g4iDZHPNbGcbA8u595lxF8zBWMa3q9Ve1IFjvRq7dnUtB4WKPf0bUPpgR8ONhV7hb+biXg7u7cJVDOA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJpk6FSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B77FC4CEFB
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757956377;
	bh=dHvDu3BEKKM6FZFaRlIA/1toY7ShEYyxM3AFgC8nWMc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dJpk6FSzG33/Ss4UayRsJU5QleJZ+aShqOVJY9aBJI6ssIyFm3ideH9MxdLJqSdf+
	 TPQ9pU3yra2+VTBgobGePzzyW0qvF1C3nd3E+TwEJUaYZIMYtnf/6Zhh8KrlPHAjIU
	 PTMgVRFRv/VckePP904OH7vQnlfCS7MlUot9mfycpR9jeuR42hYwKlY/XVsj4YYvhL
	 Y1kYJNDWJfqybnVuM3l8AmPFR+xfhRZoU+X3VdAIYoIKRKeCYJW2ShFdvKggX15tny
	 9pqLgDlj6jCTOJpbZ8L+ZFYLJiO9X+pWOueK+NsxoEfOAoClbd98W1g0o+kaNlQH5o
	 J/Y1xOykAIcEA==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-750b77699b4so3604186a34.2
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 10:12:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YwSC/1liSUXCHI/zu4AQrBSg8m28tCRYthx8BKl6KcEO5KECLpU
	ZHSFCfiBtt5IvaefjOdFrcJ3IiVyzZu1uTfoK/dA0NJ1C9HEHVhPzxTSvpVxKCYRhmNo5ZuWMfr
	Lo6eaCETmcNsRN1kGKx29v6Yj65basNM=
X-Google-Smtp-Source: AGHT+IHd79cdshzJ0D6tpC5eharQYiXb+c8UdqghtPkSkexY5HELhe+EcOIevDZx7R1eFBDRRWCYHXYEOutpDkpMFm8=
X-Received: by 2002:a05:6830:6d18:b0:741:bf2f:ee88 with SMTP id
 46e09a7af769-753555c1d2emr6545244a34.24.1757956376496; Mon, 15 Sep 2025
 10:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5046661.31r3eYUQgx@rafael.j.wysocki> <2243680.irdbgypaU6@rafael.j.wysocki>
 <aMf5ZNW9t_6tfsjy@kekkonen.localdomain> <CAJZ5v0ivX3s=pChGZ_+zeUswJgMPDH2Wi_cGeATyh+M9Tb0LYw@mail.gmail.com>
In-Reply-To: <CAJZ5v0ivX3s=pChGZ_+zeUswJgMPDH2Wi_cGeATyh+M9Tb0LYw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Sep 2025 19:12:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jVeSrDO6hrZhKgRZrH=FpGD4vNUjFD8hV9WwN9TLHjzQ@mail.gmail.com>
X-Gm-Features: AS18NWC7POBZLxda5KJcClSvrdCilWFVCcWuqfT-qIMnkR8VmajjAHMIaUt-gU8
Message-ID: <CAJZ5v0jVeSrDO6hrZhKgRZrH=FpGD4vNUjFD8hV9WwN9TLHjzQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] ACPI: property: Add code comments explaining what
 is going on
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 2:27=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi Sakari,
>
> On Mon, Sep 15, 2025 at 1:32=E2=80=AFPM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Fri, Sep 12, 2025 at 09:40:58PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > In some places in the ACPI device properties handling code, it is
> > > unclear why the code is what it is.  Some assumptions are not documen=
ted
> > > and some pieces of code are based on experience that is not mentioned
> > > anywhere.
> > >
> > > Add code comments explaining these things.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/acpi/property.c |   51 +++++++++++++++++++++++++++++++++++++=
+++++++++--
> > >  1 file changed, 49 insertions(+), 2 deletions(-)
> > >
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -108,7 +108,18 @@ static bool acpi_nondev_subnode_extract(
> > >       if (handle)
> > >               acpi_get_parent(handle, &scope);
> > >
> > > +     /*
> > > +      * Extract properties from the _DSD-equivalent package pointed =
to by
> > > +      * desc and use scope (if not NULL) for the completion of relat=
ive
> > > +      * pathname segments.
> > > +      *
> > > +      * The extracted properties will be held in the new data node d=
n.
> > > +      */
> > >       result =3D acpi_extract_properties(scope, desc, &dn->data);
> > > +     /*
> > > +      * Look for subnodes in the _DSD-equivalent package pointed to =
by desc
> > > +      * and create child nodes of dn if there are any.
> > > +      */
> > >       if (acpi_enumerate_nondev_subnodes(scope, desc, &dn->data, &dn-=
>fwnode))
> > >               result =3D true;
> > >
> > > @@ -153,6 +164,12 @@ static bool acpi_nondev_subnode_ok(acpi_
> > >       acpi_handle handle;
> > >       acpi_status status;
> > >
> > > +     /*
> > > +      * If the scope is unknown, the _DSD-equivalent package being p=
arsed
> > > +      * was embedded in an outer _DSD-equivalent package as a result=
 of
> > > +      * direct evaluation of an object pointed to by a reference.  I=
n that
> > > +      * case, using a pathname as the target object pointer is inval=
id.
> > > +      */
> > >       if (!scope)
> > >               return false;
> > >
> > > @@ -172,6 +189,10 @@ static bool acpi_add_nondev_subnodes(acp
> > >       bool ret =3D false;
> > >       int i;
> > >
> > > +     /*
> > > +      * Every element in the links package is expected to represent =
a link
> > > +      * to a non-device node in a tree containing device-specific da=
ta.
> > > +      */
> > >       for (i =3D 0; i < links->package.count; i++) {
> > >               union acpi_object *link, *desc;
> > >               acpi_handle handle;
> > > @@ -182,22 +203,48 @@ static bool acpi_add_nondev_subnodes(acp
> > >               if (link->package.count !=3D 2)
> > >                       continue;
> > >
> > > -             /* The first one must be a string. */
> > > +             /* The first one (the key) must be a string. */
> > >               if (link->package.elements[0].type !=3D ACPI_TYPE_STRIN=
G)
> > >                       continue;
> > >
> > > -             /* The second one may be a string, a reference or a pac=
kage. */
> > > +             /*
> > > +              * The second one (the target) may be a string, a refer=
ence or
> > > +              * a package.
> > > +              */
> > >               switch (link->package.elements[1].type) {
> > >               case ACPI_TYPE_STRING:
> > > +                     /*
> > > +                      * The string is expected to be a full pathname=
 or a
> > > +                      * pathname segment relative to the given scope=
.  That
> > > +                      * pathname is expected to point to an object r=
eturning
> > > +                      * a package that contains _DSD-equivalent info=
rmation.
> > > +                      */
> > >                       result =3D acpi_nondev_subnode_ok(scope, link, =
list,
> > >                                                        parent);
> > >                       break;
> > >               case ACPI_TYPE_LOCAL_REFERENCE:
> >
> > I think you get ACPI_TYPE_LOCAL_REFERENCE only when you evaluate a
> > reference to a device object.
>
> If it is so, the code below is just dead because the target here is
> expected to be a named object (not a device), in which case it would
> just be better to delete this code.

Well, unless there's a bug in the ACPI tables attempting to add a
reference to a device as a data-only subnode.  Of course, this won't
work, but printing a message in that case may help.

> Is this what you mean?

I think it is and you are right: Referencing a named object will cause
that object to be evaluated automatically and its return data to be
embedded into the return package at the location of the reference.

So I think that this piece is confusing and I'm going to get rid of it.

Thanks!

