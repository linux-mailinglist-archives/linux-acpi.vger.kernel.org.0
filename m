Return-Path: <linux-acpi+bounces-1746-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 788027F491E
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 15:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7218BB21044
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D864C4E619
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76E219D;
	Wed, 22 Nov 2023 05:34:35 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1d542f05b9aso1068626fac.1;
        Wed, 22 Nov 2023 05:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700660075; x=1701264875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIuQT6P2ZqLebzsy5/CEWAZOpDUd4LYipSd432nJBas=;
        b=FfhaYFQb2E5MCtLx7LDJhGNFPfXZmjfWe88ovaU+BFKOraA+hvBskXgxJdcmBEGRzr
         +RIj3FP2Pw84NWm653ilJC5N1fUTcoEIj9EtSd6tW720AQmDkzGw5cc+4MdM9nBXQpRV
         d7eh8P+RLuG+hc0GRPuNY55P1TF09IFl8SMUmOQRJZXd4PKJeBfZf7CtZJ88EkUVlz4O
         GSQad33xq3BJ+yjJ2+CiOM+VkKmbE6cEsqS9aDQFOVBWyuLZbKJQc9oRpu+4vQcAgHhG
         n1NsBAxnpM6Gk+aupmLj0j0RY7dUwCOK6HiCHYiSfKWo8bYnbdbQGcbC8hOMV6FN7jDO
         WWfQ==
X-Gm-Message-State: AOJu0YwjUWrd2FKp/HQlJo9SyG8460y3/Uk6V4VE04nRc9neg6RHc8hM
	k45z34kdW4IUGaaaTP5/0Fi61MiKUR+nMzGGYTc=
X-Google-Smtp-Source: AGHT+IHO4Xc/rF2fQLAzIZemKE6Z8t/9X8s1KCk8lA4m3Pr02O8bIkVAxEJWoFXpmxzQdjnG7AHL7y/Vw4yarOuAN4M=
X-Received: by 2002:a05:6871:724a:b0:1e9:8ab9:11ca with SMTP id
 ml10-20020a056871724a00b001e98ab911camr3149747oac.3.1700660075045; Wed, 22
 Nov 2023 05:34:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109183322.28039-1-sumitg@nvidia.com> <20231109183322.28039-2-sumitg@nvidia.com>
 <CAJZ5v0jEXYP-V93XJ02cZ8UbMwKei2E27Sc0He0WnKvNXpUECg@mail.gmail.com> <7b4f8911-90ef-8419-78dc-c2bffe9b9a3f@nvidia.com>
In-Reply-To: <7b4f8911-90ef-8419-78dc-c2bffe9b9a3f@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Nov 2023 14:34:24 +0100
Message-ID: <CAJZ5v0g-f8MSyu5Y83c7WvdpAjq9mWBBD9XqMKzZ1rUGmML-+w@mail.gmail.com>
Subject: Re: [Patch v6 1/2] ACPI: thermal: Add Thermal fast Sampling Period
 (_TFP) support
To: Sumit Gupta <sumitg@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com, lenb@kernel.org, 
	lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com, 
	linux-acpi@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	treding@nvidia.com, jonathanh@nvidia.com, bbasu@nvidia.com, 
	sanjayc@nvidia.com, ksitaraman@nvidia.com, srikars@nvidia.com, 
	jbrasen@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 1:55=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
>
>
> On 22/11/23 01:29, Rafael J. Wysocki wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Thu, Nov 9, 2023 at 7:34=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> =
wrote:
> >>
> >> From: Jeff Brasen <jbrasen@nvidia.com>
> >>
> >> Add support of "Thermal fast Sampling Period (_TFP)" for Passive cooli=
ng.
> >> As per [1], _TFP overrides the "Thermal Sampling Period (_TSP)" if bot=
h
> >> are present in a Thermal zone.
> >>
> >> [1] ACPI Specification 6.4 - section 11.4.17. _TFP (Thermal fast Sampl=
ing
> >>      Period)"
> >>
> >> Signed-off-by: Jeff Brasen <jbrasen@nvidia.com>
> >> Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
> >> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> >> ---
> >>   drivers/acpi/thermal.c | 12 +++++++++---
> >>   1 file changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> >> index f74d81abdbfc..3b75eb2260d7 100644
> >> --- a/drivers/acpi/thermal.c
> >> +++ b/drivers/acpi/thermal.c
> >> @@ -90,7 +90,7 @@ struct acpi_thermal_passive {
> >>          struct acpi_thermal_trip trip;
> >>          unsigned long tc1;
> >>          unsigned long tc2;
> >> -       unsigned long tsp;
> >> +       unsigned long delay;
> >>   };
> >>
> >>   struct acpi_thermal_active {
> >> @@ -404,11 +404,17 @@ static bool passive_trip_params_init(struct acpi=
_thermal *tz)
> >>
> >>          tz->trips.passive.tc2 =3D tmp;
> >>
> >> +       status =3D acpi_evaluate_integer(tz->device->handle, "_TFP", N=
ULL, &tmp);
> >> +       if (ACPI_SUCCESS(status)) {
> >> +               tz->trips.passive.delay =3D tmp;
> >> +               return true;
> >> +       }
> >> +
> >>          status =3D acpi_evaluate_integer(tz->device->handle, "_TSP", =
NULL, &tmp);
> >>          if (ACPI_FAILURE(status))
> >>                  return false;
> >>
> >> -       tz->trips.passive.tsp =3D tmp;
> >> +       tz->trips.passive.delay =3D tmp * 100;
> >>
> >>          return true;
> >>   }
> >> @@ -904,7 +910,7 @@ static int acpi_thermal_add(struct acpi_device *de=
vice)
> >>
> >>          acpi_trip =3D &tz->trips.passive.trip;
> >>          if (acpi_thermal_trip_valid(acpi_trip)) {
> >> -               passive_delay =3D tz->trips.passive.tsp * 100;
> >> +               passive_delay =3D tz->trips.passive.delay;
> >>
> >>                  trip->type =3D THERMAL_TRIP_PASSIVE;
> >>                  trip->temperature =3D acpi_thermal_temp(tz, acpi_trip=
->temp_dk);
> >> --
> >
> > So does the second patch in the series really depend on this one?
> >
> > If not, I can apply it I think.
>
> Yes, this patch can be applied independently. Thank you!

OK, applied as 6.8 material (with some changelog edits), thanks!

