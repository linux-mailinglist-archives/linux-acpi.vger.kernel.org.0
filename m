Return-Path: <linux-acpi+bounces-16932-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9367BB579F8
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 14:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F3B160DC5
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 12:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2752A30103C;
	Mon, 15 Sep 2025 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMnLf5Ah"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B2F2F28EF
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938155; cv=none; b=SmAELYWjcPF74V0uFpWZt7C/sJfWRuOa5Cz6lHmGzo9m1QktTQvaDZA+0NDscq8GAORHCOviqBu1zznGDNDPteuEQX8hi5CgAl1+jKWma8yrhJ3iwP6xwKWWNAHbReYGMsZgKCzPgfXjzpsbC0gd/ECNaVvX+R0sX7w2MusCTTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938155; c=relaxed/simple;
	bh=Teeh8KcQNzuIsJXPFF4rs0mxS9J90+7VxVkbhpr7iiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqI2fOcS/JMzP/efBiTQKg3jhzZ4xxPE9il0id/xU/jjfZe3yXAoybilL8VVukP+Ct9CNLUNi06d8UrJsFGiEOo1jaJwpk9hTKnfPDXYQBdeyebd1Xgk/XUFMld/SjuP03bVBcXMLgSW+jSNDLsc91QtcPo0se0w7jpu9+UcEMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMnLf5Ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC1CC4AF09
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 12:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757938154;
	bh=Teeh8KcQNzuIsJXPFF4rs0mxS9J90+7VxVkbhpr7iiE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fMnLf5AhvoQxAWsQ2XNQoYFXf8uDuEkEAyf+n46BRdVlbMgtVgrBN3bL8x77mKiGR
	 2hR4eGOPagtAFZlmolRGZ2jb7WW0rQG6Bmr6ydcQvl0u2fahtpt4bp63rYvv94MOMV
	 dpCEz3AZG2FZxdH8AVWgEhjgaFaUA7/om0vP13sN1ks/U+CyRzEIB+Zq0Jti4LLODY
	 mn+SZbsKkriY1LRkttyfZSneLvuH6cwbbCdM8G6XuaAivN+/LnnnDYlKNnjjnLrH4F
	 4+bxWCiwHug/iUMU4eP9Hk0Sy4sPe/0sFL9zhpqp0LnKVWdn8PuH4P/bh7qh7UdN6E
	 NXAawDeLs7cBg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6219b29ed57so1525484eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 05:09:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMADzgo+sEFenDFgMTVw1uNkaTudOvd4s0haYJO2Ty3N917m58WALQOXbgh8yskkcpwu1nVSEEf5xU@vger.kernel.org
X-Gm-Message-State: AOJu0YxivEcPJAueJG9NWM4bmcgNt2wTZfRj+BVb7qkx29s119N7XW9L
	xZ63cpyYMmFSlXuho28OcEsD219ChL40aLaX2N8S+y1u6gcCbhpfOBsvJxT8DMQW6nIgnf28Qzr
	KFq1oBtzlZ3cjA2I0VJ8pGBu9L4m2fM8=
X-Google-Smtp-Source: AGHT+IHWVj7BbTDa433wRQXaT2JQvW3m4j1w+ikKLeCXzEnVOLyCvrMszDlpf3M5BCYVACy6h58yQCmNDWHvWpCDBiA=
X-Received: by 2002:a05:6820:2d87:b0:61e:68b9:cb0d with SMTP id
 006d021491bc7-621b2c31ebdmr6904407eaf.0.1757938153953; Mon, 15 Sep 2025
 05:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5046661.31r3eYUQgx@rafael.j.wysocki> <5017964.GXAFRqVoOG@rafael.j.wysocki>
 <aMfyqjZZwozuRmW_@kekkonen.localdomain>
In-Reply-To: <aMfyqjZZwozuRmW_@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Sep 2025 14:09:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g98Tt43y-jCS4Vn9hhv1HtcjcyeOkSv21zswhpxc0TRg@mail.gmail.com>
X-Gm-Features: Ac12FXxdXXSBMo-UKdgHRtY55N_mZMFYhdOIYWa7Dl1VzzRLET2kLzV8rtE2wCg
Message-ID: <CAJZ5v0g98Tt43y-jCS4Vn9hhv1HtcjcyeOkSv21zswhpxc0TRg@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] ACPI: property: Fix buffer properties extraction
 for subnodes
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Mon, Sep 15, 2025 at 1:04=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Fri, Sep 12, 2025 at 09:39:52PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The ACPI handle passed to acpi_extract_properties() as the first
> > argument represents the ACPI namespace scope in which to look for
> > objects returning buffers associated with buffer properties.
> >
> > For _DSD objects located immediately under ACPI devices, this handle is
> > the same as the handle of the device object holding the _DSD, but for
> > data-only subnodes it is not so.
> >
> > First of all, data-only subnodes are represented by objects that
> > cannot hold other objects in their scopes (like control methods).
> > Therefore a data-only subnode handle cannot be used for completing
> > relative pathname segments, so the current code in
> > in acpi_nondev_subnode_extract() passing a data-only subnode handle
> > to acpi_extract_properties() is invalid.
> >
> > Moreover, a data-only subnode of device A may be represented by an
> > object located in the scope of device B (which kind of makes sense,
> > for instance, if A is a B's child).  In that case, the scope in
> > question would be the one of device B.  In other words, the scope
> > mentioned above is the same as the scope used for subnode object
> > lookup in acpi_nondev_subnode_extract().
> >
> > Accordingly, rearrange that function to use the same scope for the
> > extraction of properties and subnode object lookup.
> >
> > Fixes: 103e10c69c61 ("ACPI: property: Add support for parsing buffer pr=
operty UUID")
>
> I believe the commit introducing this is
> 99db5ff7fe0b4e1657423d7bbe2aa8f655dd02d1 .

No, it isn't.  Prior to commit 103e10c69c61, scope was not passed to
acpi_extract_properties().

> > Cc: 6.0+ <stable@vger.kernel.org> # 6.0+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/property.c |   30 +++++++++++-------------------
> >  1 file changed, 11 insertions(+), 19 deletions(-)
> >
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -83,6 +83,7 @@ static bool acpi_nondev_subnode_extract(
> >                                       struct fwnode_handle *parent)
> >  {
> >       struct acpi_data_node *dn;
> > +     acpi_handle scope =3D NULL;
> >       bool result;
> >
> >       if (acpi_graph_ignore_port(handle))
> > @@ -98,27 +99,18 @@ static bool acpi_nondev_subnode_extract(
> >       INIT_LIST_HEAD(&dn->data.properties);
> >       INIT_LIST_HEAD(&dn->data.subnodes);
> >
> > -     result =3D acpi_extract_properties(handle, desc, &dn->data);
> > +     /*
> > +      * The scope for the completion of relative pathname segments and
> > +      * subnode object lookup is the one of the namespace node (device=
)
> > +      * containing the object that has returned the package.  That is,=
 it's
> > +      * the scope of that object's parent device.
> > +      */
> > +     if (handle)
> > +             acpi_get_parent(handle, &scope);
> >
> > -     if (handle) {
> > -             acpi_handle scope;
> > -             acpi_status status;
> > -
> > -             /*
> > -              * The scope for the subnode object lookup is the one of =
the
> > -              * namespace node (device) containing the object that has
> > -              * returned the package.  That is, it's the scope of that
> > -              * object's parent.
> > -              */
> > -             status =3D acpi_get_parent(handle, &scope);
> > -             if (ACPI_SUCCESS(status)
> > -                 && acpi_enumerate_nondev_subnodes(scope, desc, &dn->d=
ata,
> > -                                                   &dn->fwnode))
> > -                     result =3D true;
> > -     } else if (acpi_enumerate_nondev_subnodes(NULL, desc, &dn->data,
> > -                                               &dn->fwnode)) {
> > +     result =3D acpi_extract_properties(scope, desc, &dn->data);
> > +     if (acpi_enumerate_nondev_subnodes(scope, desc, &dn->data, &dn->f=
wnode))
> >               result =3D true;
> > -     }
> >
> >       if (result) {
> >               dn->handle =3D handle;
> >
> >
>
> --

