Return-Path: <linux-acpi+bounces-727-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ED47CDBED
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148581C20B8A
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F0035894
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1514F8F
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 11:48:40 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB016F7;
	Wed, 18 Oct 2023 04:48:38 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6bf106fb6a0so1341691a34.0;
        Wed, 18 Oct 2023 04:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697629718; x=1698234518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3q/Z+37O+9hSuiBMjYzeMo3yjEqRFNG+vOZC6JSJYCk=;
        b=rjmXQj+VKCCXNMW6V0kk7Ar+BaUrkWwSvYAa09g1J6ZvS4GfnGnyZ/Zlz2BhHa0pc5
         V0S1/rFjMz36B91DYk01v5VRFWNr5PmCHdyYEiNCuCKriGP+YnvJSJFCDxKej1UIQox2
         x6MVhFU4Bl6VirF4NF6auA5SUcwaTpVUfGGE09nxuALVioqcvZOWHUK7/NZaOZLGG9ms
         dOhOXafpFvUkfNd4P+c1ZbOWoD/BV+4TrZxA1UexObsi7PgrO/17U8wz6ky+FKEDFJNo
         eZE9+3Pmry4Z0ynQmMVsQ87u/373WP5sFzBjktnwkXCArrWMjvp91MeRwPIt7SqooSeq
         zvdw==
X-Gm-Message-State: AOJu0YzGYl4j9yDoCpVj7vwPsqRXkdvqIvPggsSSoXVrgajxPqWWKRdT
	1tlky4GdNzvHsUab58ZAl652IfsTqBzxoJuXvGA=
X-Google-Smtp-Source: AGHT+IESrE+6/GTLq2QJSvPquuCaryzdi+XZnUeLv45RGCYYAQTFj7ea1gj6QMAde8TamdCZzR3hvWU7zPLpmSaq9Jw=
X-Received: by 2002:a4a:ee97:0:b0:57c:6e35:251e with SMTP id
 dk23-20020a4aee97000000b0057c6e35251emr5173160oob.1.1697629718123; Wed, 18
 Oct 2023 04:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231014105426.26389-1-sumitg@nvidia.com> <20231014105426.26389-2-sumitg@nvidia.com>
In-Reply-To: <20231014105426.26389-2-sumitg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Oct 2023 13:48:27 +0200
Message-ID: <CAJZ5v0jm5h9qeZdnLDp9qUMT-31FOWMBERMzhFzgFsmt9QX78g@mail.gmail.com>
Subject: Re: [Patch v5 1/2] ACPI: thermal: Add Thermal fast Sampling Period
 (_TFP) support
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	bbasu@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com, 
	srikars@nvidia.com, jbrasen@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 12:54=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wr=
ote:
>
> From: Jeff Brasen <jbrasen@nvidia.com>
>
> Add support of "Thermal fast Sampling Period (_TFP)" for Passive cooling.
> As per [1], _TFP overrides the "Thermal Sampling Period (_TSP)" if both
> are present in a Thermal zone.
>
> [1] ACPI Specification 6.4 - section 11.4.17. _TFP (Thermal fast Sampling
>     Period)"
>
> Signed-off-by: Jeff Brasen <jbrasen@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/thermal.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index d98ff69303b3..a91e3d566858 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -90,7 +90,7 @@ struct acpi_thermal_passive {
>         struct acpi_thermal_trip trip;
>         unsigned long tc1;
>         unsigned long tc2;
> -       unsigned long tsp;
> +       unsigned long passive_delay;

This is a passive trip structure anyway, so the "passive_" prefix is
redundant here.  "delay" alone would be fine.

>  };
>
>  struct acpi_thermal_active {
> @@ -404,11 +404,16 @@ static bool passive_trip_params_init(struct acpi_th=
ermal *tz)
>
>         tz->trips.passive.tc2 =3D tmp;
>
> -       status =3D acpi_evaluate_integer(tz->device->handle, "_TSP", NULL=
, &tmp);
> -       if (ACPI_FAILURE(status))
> -               return false;
> +       status =3D acpi_evaluate_integer(tz->device->handle, "_TFP", NULL=
, &tmp);
> +       if (ACPI_FAILURE(status)) {
> +               status =3D acpi_evaluate_integer(tz->device->handle, "_TS=
P", NULL, &tmp);
> +               if (ACPI_FAILURE(status))
> +                       return false;
>
> -       tz->trips.passive.tsp =3D tmp;
> +               tz->trips.passive.passive_delay =3D tmp * 100;
> +       } else {
> +               tz->trips.passive.passive_delay =3D tmp;
> +       }

I would prefer the if () statement above to be structured the other
way around, that is

 status =3D ...
 if (ACPI_SUCCESS(status)) {
        tz->trips.passive.delay =3D tmp;
        return true;
}

status =3D ...
if (ACPI_FAILURE(status))
         return false;

etc.

>
>         return true;
>  }
> @@ -904,7 +909,7 @@ static int acpi_thermal_add(struct acpi_device *devic=
e)
>
>         acpi_trip =3D &tz->trips.passive.trip;
>         if (acpi_thermal_trip_valid(acpi_trip)) {
> -               passive_delay =3D tz->trips.passive.tsp * 100;
> +               passive_delay =3D tz->trips.passive.passive_delay;
>
>                 trip->type =3D THERMAL_TRIP_PASSIVE;
>                 trip->temperature =3D acpi_thermal_temp(tz, acpi_trip->te=
mp_dk);
> --
> 2.17.1
>

