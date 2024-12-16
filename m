Return-Path: <linux-acpi+bounces-10157-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DC49F3C13
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 22:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4875F16784F
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 21:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2391DDC2A;
	Mon, 16 Dec 2024 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuQEyXPv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B431D5CD7;
	Mon, 16 Dec 2024 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382023; cv=none; b=J4IuB8T3A5NHbX5ReeoleySe/4xN46iMPI2GS9M0GASBB9Jl3Ib/LX9UDolQ6IsBLzuc7c1dZrilnexYUAnhobgn3ifKFrmORIK2Sn6/KeSvqsP3C3Kf/Sro61bf6TyMBZO6jNaEGZPXoFYGhgqDPxNTh72QIyuW8PcNYesnBpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382023; c=relaxed/simple;
	bh=FWc5NdQPEYcwjuJCRpQn2DI2k635tsMlyKRv5djZXc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxgCGAjN6Vqu9CNWOmBlBYWMYQVu817LWEM4fQvexCSozV+N6fCdVG6qZUuhv39wOqsKvX0mqPpM/WeyRUzuK4Org9Uny+4cwuoJ/7Cu4WBwUz8T98TUuRaXCVlbv8Pf9CXgVyOe1WCQWsfH0mXVgAK+KSjUXzEy50E8Xgsop3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuQEyXPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7070EC4CEE0;
	Mon, 16 Dec 2024 20:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734382023;
	bh=FWc5NdQPEYcwjuJCRpQn2DI2k635tsMlyKRv5djZXc4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IuQEyXPvXKonOOTkvepkVBNlmMfiqSQcnp9g3pTh2y8sj8rJ0HflUG61JeXvzHHA7
	 yoo4F0L8oSi0mMIJ4y+pZCIgxBHAyW31astTbj+kGqVZVHdAmZuApOWnrRsnIfH6XF
	 QKz8Ap1LRrRmYs2IeNn2jLzBdxvfUI65e/c46663BBUytrYkDAlcjU3WL9kbirmuPO
	 Mha6h0CRkLqERqPIDhchLakZMYxGU1cJcnArYAzcN6SLsS44EGhTEhj152+I3yS5/G
	 c/yabSKMmZlTF8vqSLCTskZKsUrNXA0d77P7CvBrfyPwXzJQtVBpy8zz4MWHnpS3nf
	 cnWl6dL9PgKrQ==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3eb9ba53f90so1227989b6e.1;
        Mon, 16 Dec 2024 12:47:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVU8t9fRZkU8IiBGTcfr/WMgy6YOLtbR8SVEk7EcceD1hO+ac43PRghrA5g+z536cWKarA6aPEQlb69qBaL@vger.kernel.org, AJvYcCWnMNakxjB5S+iFmDl2ZGwrVv6MJcExQdpmwpA4zsJEsC4pP8XdqiMykx6qfOusFi407VL2EX/PADTC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9MLH9v8FsLBvd0wyGHPMVPql8M2FVqnuLH4tPkA0KcVtJlyWn
	D+gLt7PJxoNd7Wgx0VFcda47i8UDdztwSvR/zp16/vSEcneWvsSwEpMJTkHBorBb+LK8KEtKIJ9
	BdZqhTwfJaO2gsALljTxF7Ibnct8=
X-Google-Smtp-Source: AGHT+IG/PqLOxWQ8bMSvdSvxs245uuAzMTjbPmuXNov/t09dNQM5eGRDit9pYO8s1OU9IDNhOmX+QB/KyFhj5XZjq1I=
X-Received: by 2002:a05:6808:1902:b0:3e7:b3ce:923 with SMTP id
 5614622812f47-3ebcb317ea6mr117778b6e.23.1734382022723; Mon, 16 Dec 2024
 12:47:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
 <20241211-fix-ipu-v4-2-4102e97aceb6@chromium.org> <CAJZ5v0gmN6+y2DveaBjSqWpTRWqm9zo2t0uDdvGwnVXcdQ777A@mail.gmail.com>
 <CANiDSCtF6XoAK6t0XNcT1KjGKHJMMFw8oKr1OSS0jkLuwgL8Og@mail.gmail.com>
In-Reply-To: <CANiDSCtF6XoAK6t0XNcT1KjGKHJMMFw8oKr1OSS0jkLuwgL8Og@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 21:46:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jyLZsbPY8bF5Ya6UojZrtk_fEhWaVH48wuUDw7TkjeWw@mail.gmail.com>
Message-ID: <CAJZ5v0jyLZsbPY8bF5Ya6UojZrtk_fEhWaVH48wuUDw7TkjeWw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] ACPI: bus: implement acpi_get_physical_device_location
 when !ACPI
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 9:42=E2=80=AFPM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> Hi Rafael
>
> On Mon, 16 Dec 2024 at 21:17, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Wed, Dec 11, 2024 at 5:07=E2=80=AFPM Ricardo Ribalda <ribalda@chromi=
um.org> wrote:
> > >
> > > Provide an implementation of acpi_get_physical_device_location that c=
an
> > > be used when CONFIG_ACPI is not set.
> > >
> > > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  include/acpi/acpi_bus.h | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > > index 2b09e513ecf3..b312a72f48ad 100644
> > > --- a/include/acpi/acpi_bus.h
> > > +++ b/include/acpi/acpi_bus.h
> > > @@ -43,9 +43,6 @@ acpi_status
> > >  acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_c=
ode,
> > >                   struct acpi_buffer *status_buf);
> > >
> > > -acpi_status
> > > -acpi_get_physical_device_location(acpi_handle handle, struct acpi_pl=
d_info **pld);
> > > -
> > >  bool acpi_has_method(acpi_handle handle, char *name);
> > >  acpi_status acpi_execute_simple_method(acpi_handle handle, char *met=
hod,
> > >                                        u64 arg);
> > > @@ -60,6 +57,9 @@ bool acpi_check_dsm(acpi_handle handle, const guid_=
t *guid, u64 rev, u64 funcs);
> > >  union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_=
t *guid,
> > >                         u64 rev, u64 func, union acpi_object *argv4);
> > >  #ifdef CONFIG_ACPI
> > > +acpi_status
> > > +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pl=
d_info **pld);
> > > +
> > >  static inline union acpi_object *
> > >  acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 =
rev,
> > >                         u64 func, union acpi_object *argv4,
> > > @@ -1003,6 +1003,12 @@ static inline int unregister_acpi_bus_type(voi=
d *bus) { return 0; }
> > >
> > >  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> > >
> > > +static inline acpi_status
> > > +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pl=
d_info **pld)
> > > +{
> > > +       return AE_ERROR;
> > > +}
> >
> > I overlooked this before, sorry.
> >
> > It generally is not OK to use acpi_status and/or AE_ error codes
> > without CONFIG_ACPI and they really only should be used in
> > drivers/acpi/ (and not everywhere in there for that matter).
> >
> > So acpi_get_physical_device_location() needs to be redefined to return
> > something different from acpi_status (preferably bool) in order to be
> > used in !CONFIG_ACPI code.
>
> Shall I redefine it to
> bool acpi_get_physical_device_location(acpi_handle handle, struct
> acpi_pld_info **pld)/
>
> For both the ACPI and !ACPI cases? or just for the !ACPI?

For both cases, please.

