Return-Path: <linux-acpi+bounces-155-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5907AF2FC
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CF5C22817F3
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 18:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CCF47C69
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 18:31:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0FA339A0
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 18:04:47 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1931D139;
	Tue, 26 Sep 2023 11:04:46 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-57ddba5ba84so99300eaf.0;
        Tue, 26 Sep 2023 11:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751485; x=1696356285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U27hlPgGqPLU6XmNuvI90P/WMHTPv95Abz8ctFWAnKs=;
        b=csnuOAfXNSyoq7NtB5k51nuu/qtqedl7TTvdnDvQiIcfAboC19lQXriUj8/cYsHdWE
         9PM9rnxukEdK+GfGc9cQ7dC49DnEqarN5j3zmfWQtuX9jYpVDfTTWPpz6+IhouP3PbbU
         jjjwlem7ggxUJVPNo1pXnjbOJE37b7UohiNgGTgZCGMlpa0CqQbLPSG6wifRzb0tGQfw
         tGR+UFFjaOM29WdzA/bSZbOI+TL7m4UgLuOnH3Tcwo45YxV4+j5W3Cqm4gUdq2FWWTll
         CsxEtkpQqO8oLpE2ff/9ClAApNCbm4frOPJ8AjwgruK7KDSG4vVPH+nn3CCHzTeAOo9s
         8/0Q==
X-Gm-Message-State: AOJu0YyPYdAuj+lR0qEfZoOG98COfvHh6XU2U8v4j2b47yGHBOuqi3hw
	eH8k5ZJYInCVl2rnaugWn9zRVIXnM7+q7Yb/BNY=
X-Google-Smtp-Source: AGHT+IHG/F41S7ep8TIwAk2zdhu/TBrObc5YxCBJopPYiSCZKbimkloZLP0lIU9JKhvyZwX6XLgwpIELReV9MR0ZaZY=
X-Received: by 2002:a4a:e2d8:0:b0:578:c2af:45b5 with SMTP id
 l24-20020a4ae2d8000000b00578c2af45b5mr9430902oot.0.1695751485276; Tue, 26 Sep
 2023 11:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1957441.PYKUYFuaPT@kreacher> <3534976.iIbC2pHGDl@kreacher>
 <38ea14aa-ecc2-c40e-34ea-05b348158cfb@linaro.org> <CAJZ5v0iww__Kd2e8bSarXL5ugjL1zuCaXgOfzLp-VGdmHBBabQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iww__Kd2e8bSarXL5ugjL1zuCaXgOfzLp-VGdmHBBabQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Sep 2023 20:04:34 +0200
Message-ID: <CAJZ5v0gA1488TeNTHNFb0yCjfqFBe8cEWZNteBmk6m_Eo4QTsQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/13] ACPI: thermal: Collapse trip devices update functions
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 7:56=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Sep 26, 2023 at 7:18=E2=80=AFPM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 21/09/2023 19:49, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > In order to reduce code duplication, merge update_passive_devices() a=
nd
> > > update_active_devices() into one function called update_trip_devices(=
)
> > > that will be used for updating both the passive and active trip point=
s.
> > >
> > > No intentional functional impact.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >   drivers/acpi/thermal.c |   53 ++++++++++++++++++-------------------=
------------
> > >   1 file changed, 20 insertions(+), 33 deletions(-)
> > >
> > > Index: linux-pm/drivers/acpi/thermal.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-pm.orig/drivers/acpi/thermal.c
> > > +++ linux-pm/drivers/acpi/thermal.c
> > > @@ -43,6 +43,8 @@
> > >   #define ACPI_THERMAL_MAX_ACTIVE             10
> > >   #define ACPI_THERMAL_MAX_LIMIT_STR_LEN      65
> > >
> > > +#define ACPI_THERMAL_TRIP_PASSIVE    (-1)
> > > +
> > >   /*
> > >    * This exception is thrown out in two cases:
> > >    * 1.An invalid trip point becomes invalid or a valid trip point be=
comes invalid
> > > @@ -202,18 +204,25 @@ static void acpi_thermal_update_passive_
> > >               ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
> > >   }
> > >
> > > -static bool update_passive_devices(struct acpi_thermal *tz, bool com=
pare)
> > > +static bool update_trip_devices(struct acpi_thermal *tz,
> > > +                             struct acpi_thermal_trip *acpi_trip,
> > > +                             int index, bool compare)
> > >   {
> > > -     struct acpi_thermal_trip *acpi_trip =3D &tz->trips.passive.trip=
;
> > >       struct acpi_handle_list devices;
> > > +     char method[] =3D "_PSL";
> > >       acpi_status status;
> > >
> > > +     if (index !=3D ACPI_THERMAL_TRIP_PASSIVE) {
> > > +             method[1] =3D 'A';
> > > +             method[2] =3D 'L';
> > > +             method[3] =3D '0' + index;
> > > +     }
> >
> > Could be index > 9 ?
>
> I can add a check, but it will never be called with index > 9 anyway.

To be more precise, update_trip_devices() is called in two places,
acpi_thermal_init_trip() and acpi_thermal_update_trip_devices().

Both of these are called either with ACPI_THERMAL_TRIP_PASSIVE passed
as index, or from a loop over indices between 0 and
ACPI_THERMAL_MAX_ACTIVE-1 inclusive.

