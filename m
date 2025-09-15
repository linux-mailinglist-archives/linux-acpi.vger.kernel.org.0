Return-Path: <linux-acpi+bounces-16938-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D55B57B08
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 14:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCC13B0C79
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 12:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2533A3081DC;
	Mon, 15 Sep 2025 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+ob66qH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD09305947
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939249; cv=none; b=WMeMdovdp8R3zw5GxdXSgQOm9ZeJ13G468PIZ5prcGD0twp8hGB9mh7jaHn5TY8KyUI3f2kAUEeo4EvWzGsqoS/5PZmVhVTNFPAlowKcwed0Df1cYu0RvD53gS6gdDB19IGdsQsGTAjHAVvfGoVSznp5DKTtLjzkvat3A8lJpCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939249; c=relaxed/simple;
	bh=RKSFfbGcm2+n1SCMDWQaq5ACjOkXSXR1Jz63OUPhNfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDmOKD80ggfMXukJdnVivP2ErEsngajZNWQdNW5XDAXfhdQA7k6eCpj08imqCRSWWLXi33RVD7suqMfj1LIXUOjQAxN9b1EFbVl7BkKAA6LEMWWTJa32434BL50UFy/zg0kBUAwvPdbpOPG8i/jG28VQ8cjtlnKYnYVwyxTi5vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+ob66qH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F56C4CEF7
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 12:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757939248;
	bh=RKSFfbGcm2+n1SCMDWQaq5ACjOkXSXR1Jz63OUPhNfM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A+ob66qH4G+RiPsMouyZ5yVLpNRcaWRSfrN0JHItby5Nx32HQJKVMFpufp8bCiN+H
	 HHWXz7ykSBwsYzci3WA3D2vnJeyAubXAAKGu74fU3vwg1kVgii7Wg7exCp1btpRVuF
	 qFeOyZ53c8MrI3fv6Swli6tpfZ+wpRt7OZOOGInyRp2syDGQjHOfhBiMhu48yA2A+C
	 zZVUbxYc7kZDYWneUG0xHsHWKHyrVQzAwke74zv3sR0bibZVP2zval6r9QBwFs0pON
	 gjW5ML/Kq1xcLaxGvH9GZs4UK8/KAGj5R+1ZH5h4LvPWbSkBfw7Mwhmq3jP/O2/LQS
	 JQS317YVnozEA==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-746d3b0f7e5so3622323a34.2
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 05:27:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVckmeV5u0TWYoDv/AnjKxb7Q9mMifrZ8BEyNvpZhTbZElHZBSIYqfwyZx5sHR2tpDnstyHeso8dmVl@vger.kernel.org
X-Gm-Message-State: AOJu0YxSA5G1OYchsmpWxM0BgUy/E48ENNUV4oib/l3y2r0Taa1z3ZL8
	wsro9MkSHbU/OsVejfFAcwO2pG4LqZ5Ors+myz84smqFmDGB+xXDvoqsXvobZ0o1XQGTFdLRNzz
	xQt2J8dVcSohFgpJvH4AsIEODxfRh3GE=
X-Google-Smtp-Source: AGHT+IE6ypWT+o/QQu9xqx/WP436dtT20oqRYRBRCgFJc4RydutPS+oW2mY6jvB84KZ0v4Ij//flGQtF3v2+iHlI8tI=
X-Received: by 2002:a05:6830:82e6:b0:745:4b08:eea9 with SMTP id
 46e09a7af769-753552da33dmr8165646a34.30.1757939247951; Mon, 15 Sep 2025
 05:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5046661.31r3eYUQgx@rafael.j.wysocki> <2243680.irdbgypaU6@rafael.j.wysocki>
 <aMf5ZNW9t_6tfsjy@kekkonen.localdomain>
In-Reply-To: <aMf5ZNW9t_6tfsjy@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Sep 2025 14:27:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ivX3s=pChGZ_+zeUswJgMPDH2Wi_cGeATyh+M9Tb0LYw@mail.gmail.com>
X-Gm-Features: Ac12FXx8LSrrunyBiiNznOMNT6WX1PRcGZM1xU20-IJwBea6kXIXAWmzsDfB5iA
Message-ID: <CAJZ5v0ivX3s=pChGZ_+zeUswJgMPDH2Wi_cGeATyh+M9Tb0LYw@mail.gmail.com>
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

On Mon, Sep 15, 2025 at 1:32=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Fri, Sep 12, 2025 at 09:40:58PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > In some places in the ACPI device properties handling code, it is
> > unclear why the code is what it is.  Some assumptions are not documente=
d
> > and some pieces of code are based on experience that is not mentioned
> > anywhere.
> >
> > Add code comments explaining these things.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/property.c |   51 +++++++++++++++++++++++++++++++++++++++=
+++++++--
> >  1 file changed, 49 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -108,7 +108,18 @@ static bool acpi_nondev_subnode_extract(
> >       if (handle)
> >               acpi_get_parent(handle, &scope);
> >
> > +     /*
> > +      * Extract properties from the _DSD-equivalent package pointed to=
 by
> > +      * desc and use scope (if not NULL) for the completion of relativ=
e
> > +      * pathname segments.
> > +      *
> > +      * The extracted properties will be held in the new data node dn.
> > +      */
> >       result =3D acpi_extract_properties(scope, desc, &dn->data);
> > +     /*
> > +      * Look for subnodes in the _DSD-equivalent package pointed to by=
 desc
> > +      * and create child nodes of dn if there are any.
> > +      */
> >       if (acpi_enumerate_nondev_subnodes(scope, desc, &dn->data, &dn->f=
wnode))
> >               result =3D true;
> >
> > @@ -153,6 +164,12 @@ static bool acpi_nondev_subnode_ok(acpi_
> >       acpi_handle handle;
> >       acpi_status status;
> >
> > +     /*
> > +      * If the scope is unknown, the _DSD-equivalent package being par=
sed
> > +      * was embedded in an outer _DSD-equivalent package as a result o=
f
> > +      * direct evaluation of an object pointed to by a reference.  In =
that
> > +      * case, using a pathname as the target object pointer is invalid=
.
> > +      */
> >       if (!scope)
> >               return false;
> >
> > @@ -172,6 +189,10 @@ static bool acpi_add_nondev_subnodes(acp
> >       bool ret =3D false;
> >       int i;
> >
> > +     /*
> > +      * Every element in the links package is expected to represent a =
link
> > +      * to a non-device node in a tree containing device-specific data=
.
> > +      */
> >       for (i =3D 0; i < links->package.count; i++) {
> >               union acpi_object *link, *desc;
> >               acpi_handle handle;
> > @@ -182,22 +203,48 @@ static bool acpi_add_nondev_subnodes(acp
> >               if (link->package.count !=3D 2)
> >                       continue;
> >
> > -             /* The first one must be a string. */
> > +             /* The first one (the key) must be a string. */
> >               if (link->package.elements[0].type !=3D ACPI_TYPE_STRING)
> >                       continue;
> >
> > -             /* The second one may be a string, a reference or a packa=
ge. */
> > +             /*
> > +              * The second one (the target) may be a string, a referen=
ce or
> > +              * a package.
> > +              */
> >               switch (link->package.elements[1].type) {
> >               case ACPI_TYPE_STRING:
> > +                     /*
> > +                      * The string is expected to be a full pathname o=
r a
> > +                      * pathname segment relative to the given scope. =
 That
> > +                      * pathname is expected to point to an object ret=
urning
> > +                      * a package that contains _DSD-equivalent inform=
ation.
> > +                      */
> >                       result =3D acpi_nondev_subnode_ok(scope, link, li=
st,
> >                                                        parent);
> >                       break;
> >               case ACPI_TYPE_LOCAL_REFERENCE:
>
> I think you get ACPI_TYPE_LOCAL_REFERENCE only when you evaluate a
> reference to a device object.

If it is so, the code below is just dead because the target here is
expected to be a named object (not a device), in which case it would
just be better to delete this code.

Is this what you mean?

> > +                     /*
> > +                      * The reference is expected to point to an objec=
t
> > +                      * returning a package that contains _DSD-equival=
ent
> > +                      * information.
> > +                      */
> >                       handle =3D link->package.elements[1].reference.ha=
ndle;
> >                       result =3D acpi_nondev_subnode_data_ok(handle, li=
nk, list,
> >                                                            parent);
> >                       break;
> >               case ACPI_TYPE_PACKAGE:
>
> And similarly, the result of an evaluation here is a package when a
> reference points to a name object (i.e. a data node).

Well, I'm not sure how this remark is related to the new comment below.

Do you mean that this always happens when a reference is used in ASL
to point to the target here?

But the comment would still be valid in that case, wouldn't it?

> > +                     /*
> > +                      * This happens when the target package is embedd=
ed
> > +                      * within the links package as a result of direct
> > +                      * evaluation of an object pointed to by a refere=
nce.
> > +                      *
> > +                      * The target package is expected to contain _DSD=
-
> > +                      * equivalent information, but the scope in which=
 it
> > +                      * is located in the original AML is unknown.  Th=
us
> > +                      * it cannot contain pathname segments represente=
d as
> > +                      * strings because there is no way to build full
> > +                      * pathnames out of them.
> > +                      */
> >                       desc =3D &link->package.elements[1];
> >                       result =3D acpi_nondev_subnode_extract(desc, NULL=
, link,
> >                                                            list, parent=
);
> >
>
> --

