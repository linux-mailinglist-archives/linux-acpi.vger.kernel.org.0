Return-Path: <linux-acpi+bounces-16941-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DDFB57C1A
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 14:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB61D1887737
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8275B30C37E;
	Mon, 15 Sep 2025 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWTasVeA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79630C374
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941064; cv=none; b=N7wvTEVyqbVxCrjLzZR7h5sO3B2FhOG/ArrJ1pldh3hYCe9a6Fv23HWK/X/e20kE189ygnRK95Q8/CDp1k4rpmlpxlrAWZytXREk9GYBd8VDh+/2bS0SBvVKwOzF9cubMlMOKSLnGoTjnk7xYO9DR7DvBifgriB0G9fM3bjM6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941064; c=relaxed/simple;
	bh=ulKSlbeY89urU1NmlWnfV3YU5EPXs0DX1UXGa+Q3K/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDQVBnYVIpz6k0yI0VloqsKhtp+wcJ0AOo6BC4wS73rAfYo9d24p+1tFf75bdEgZI6klGkRRkemVYlLQ8ZayRFyYJafPSJYwUnUHds2xCGpgmloddV77agD2ddIr0/uC4b2JCGYlLqJlwMLPs7kt4Q+nmbtSO5BEy+JC/1UfVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWTasVeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9228C4CEF7
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757941063;
	bh=ulKSlbeY89urU1NmlWnfV3YU5EPXs0DX1UXGa+Q3K/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PWTasVeAwjIJpvCr4aq+9o8kk72ibHJdBhz14LuBZV9TMtDX0XIJuL9gs9bI8GSRc
	 eentuAy2E9jzun7pkw0W8vtSSE9rsqnSvCntDpJ2PbCOqroRmSkEIs3Umvvh9Z/+Dt
	 KJQQQw71bPOioZBxnvdaNMyDwc2pKE/CfSmtlOA1hZREZMwVQQds+sSWxSaWKe1rfM
	 8BgShY36KaF4XCh9quBcJ2Ejs3T9YoEAJ+PYBxDcoA233qKVzzPypx7VtuGULU58Lm
	 7rkLWmuUDW7hEHXHW9WVF+vpLMthy4VgLONe1fys9C0yhg9X+suHVhwk211gQRsFIq
	 6BFpG5qD4r41Q==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-750b77699b4so3360616a34.2
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 05:57:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHM84wsJKYHF/Xe1LMBUXMVaMXrMzTp7WNXBvrXEBPgtdI2ba0nVqLERRrHRFCEobUqbqYGR/C/FH/@vger.kernel.org
X-Gm-Message-State: AOJu0YwilLeB+ENXTeP4ajou5/zNNIOtjnXPgQ2crkxdDweGtIfS8Q3b
	dpThnZA9x8XduzzzyfIl5DbFB2+Yfx2exDAu/nq5f+4heni2nil9AwZrF+BfwsrRPsK6TAKtKwH
	kWWFubBONOlz0oGkfsj9YDPkQQC6DhF4=
X-Google-Smtp-Source: AGHT+IH7eC7ap1vbLWJ7LIJn9DDB9jGF1thqKBpffYH7okiwBW8idpEX+LHY5pmbjHOwMv51qdMfNTswXtyjOv0I/eo=
X-Received: by 2002:a05:6808:1b28:b0:43b:7a77:6b8 with SMTP id
 5614622812f47-43b8da333f0mr5451545b6e.47.1757941063218; Mon, 15 Sep 2025
 05:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5046661.31r3eYUQgx@rafael.j.wysocki> <3014880.e9J7NaK4W3@rafael.j.wysocki>
 <aMf9YRHA8jRgMPAr@kekkonen.localdomain>
In-Reply-To: <aMf9YRHA8jRgMPAr@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Sep 2025 14:57:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hPjWHwSSc9cTdC76RypWGPUYrkqw+W3Vb52uy_UJpk9A@mail.gmail.com>
X-Gm-Features: Ac12FXzO3bE6mspFRW59O99bQ_5MIBbj6Q82vloHhMMUd9RwBdaCC0UsMUE0CUE
Message-ID: <CAJZ5v0hPjWHwSSc9cTdC76RypWGPUYrkqw+W3Vb52uy_UJpk9A@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] ACPI: property: Do not pass NULL handles to acpi_attach_data()
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Mon, Sep 15, 2025 at 1:50=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Fri, Sep 12, 2025 at 09:42:55PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > In certain circumstances, the ACPI handle of a data-only node may be
> > NULL, in which case it does not make sense to attempt to attach that
> > node to an ACPI namespace object, so update the code to avoid attempts
> > to do so.
> >
> > This prevents confusing and unuseful error messages from being printed.
> >
> > Also document the fact that the ACPI handle of a data-only node may be
> > NULL, and when that happens, in a code comment.
> >
> > In addition, make acpi_add_nondev_subnodes() print a diagnostic message
> > for each data-only node with an unknown ACPI namespace scope.
> >
> > Fixes: 1d52f10917a7 ("ACPI: property: Tie data nodes to acpi handles")
> > Cc: 6.0+ <stable@vger.kernel.org> # 6.0+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/property.c |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -124,6 +124,10 @@ static bool acpi_nondev_subnode_extract(
> >               result =3D true;
> >
> >       if (result) {
> > +             /*
> > +              * This will be NULL if the desc package is embedded in a=
n outer
> > +              * _DSD-equivalent package and its scope cannot be determ=
ined.
> > +              */
>
> I think indeed this happens in particular when when references to
> non-device nodes; there's no handle because when you get is basically a
> dynamically allocated copy of a node.

I know for a fact that this happens, that's why I'm adding the comment here=
.

> >               dn->handle =3D handle;
> >               dn->data.pointer =3D desc;
> >               list_add_tail(&dn->sibling, list);
> > @@ -245,6 +249,8 @@ static bool acpi_add_nondev_subnodes(acp
> >                        * strings because there is no way to build full
> >                        * pathnames out of them.
> >                        */
> > +                     acpi_handle_info(scope, "Unknown namespace scope =
of node %s\n",
> > +                                      link->package.elements[0].string=
.pointer);
> >                       desc =3D &link->package.elements[1];
> >                       result =3D acpi_nondev_subnode_extract(desc, NULL=
, link,
> >                                                            list, parent=
);
> > @@ -408,6 +414,9 @@ static void acpi_untie_nondev_subnodes(s
> >       struct acpi_data_node *dn;
> >
> >       list_for_each_entry(dn, &data->subnodes, sibling) {
> > +             if (!dn->handle)
> > +                     continue;
> > +
> >               acpi_detach_data(dn->handle, acpi_nondev_subnode_tag);
> >
> >               acpi_untie_nondev_subnodes(&dn->data);
> > @@ -422,6 +431,9 @@ static bool acpi_tie_nondev_subnodes(str
> >               acpi_status status;
> >               bool ret;
> >
> > +             if (!dn->handle)
> > +                     continue;
> > +
> >               status =3D acpi_attach_data(dn->handle, acpi_nondev_subno=
de_tag, dn);
> >               if (ACPI_FAILURE(status) && status !=3D AE_ALREADY_EXISTS=
) {
> >                       acpi_handle_err(dn->handle, "Can't tag data node\=
n");
> >
> >
> >
>
> --
> Kind regards,
>
> Sakari Ailus

