Return-Path: <linux-acpi+bounces-7167-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47E3942F99
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 15:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEBC28AC1E
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 13:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326231B0139;
	Wed, 31 Jul 2024 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzcDc3U0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7D1AC43E;
	Wed, 31 Jul 2024 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430887; cv=none; b=g/d1VJ6zC0wAcfEJSOUb92M7yAj3RIzd69q+Rwc82aCFMND75fTL/Mq/ai0NG5S935dl9ZfrY9VRGDukS2PSqAip0b+N32t9FNj6gwBnNcnw9TLFRvrE1IcxwSKxFM9SBcwdGMrB6mHtuPfWgA3G0cc62rxv0GIX009pFkH+pzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430887; c=relaxed/simple;
	bh=FOc4xL6cnBZKwU0x9lOVB7wH6Wc39+KLGPTn8baEj/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8+FlIxpkMoQH5zYrnTetoyAEn7HcBCOqFsOk0jnnxNc3nBM4PGT6FBKgdYX8VNPEwroE7F4T8u2eAtStNQfrJXWreH+AwO6v/ioXKlOaqLZPMQxPZHg8ErZnC3GjhPea1fE8HcQkhLStsJ4DqjWos+5SdBm8KrRbbLTLlTI8t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzcDc3U0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC24C4AF0C;
	Wed, 31 Jul 2024 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722430886;
	bh=FOc4xL6cnBZKwU0x9lOVB7wH6Wc39+KLGPTn8baEj/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OzcDc3U09RWMQOUwMgxccj1jmTf8CVPmpN6QlzMqPndDDuzOT+V00yOwRv/8VCC+C
	 xwWFOs+ytJ9CWmc6Mp30fEzzBdPTAYQDPBZtltVy0l1tLMu7TzMbkCgbliN+zuQCIs
	 7jXvFyO+RipEZgx7g9UPH84Z7xh/MCjFUJh1JQIYM2nw4D9vjHIfjf0BegNbwXEyuB
	 jliJBcnqnL23sfjuDtEZXu0onWDAScTwvYqQw2V3Lm2ygpVTKYAk/G/sMKlJa9q7Cv
	 Cm+zT4sTqa2Rf0+H30xqwRUO+O+MqUeuDfyfS42GFkorx0xOZ9tOOPFbEDnRvRIMx3
	 jawUBB+7KeaFw==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70937ddca68so369972a34.1;
        Wed, 31 Jul 2024 06:01:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXk1TOH8y+K7HTb62R1f9cAXYK+DX+0YF//Twdupnb9VaR6uLa+W9OZRqtqeP1zHAJaOMoqcUa/5Ji/M4knz6nKpyfuPXGKTZBNxvtBnf15bBT32z5TBdZLMNiUkezKhvk5OzxCLyfwgwVsQ0gt/6OSlaTm+KAcOG5qyKCIhzxn3PKr1fPkvjY/G6qFa5oFPE5wDRRuupjphON1
X-Gm-Message-State: AOJu0YyaI6mwQW0jx3t/Djjpldr9QQd/BoO+WAV0L7/OvYPtbfCln1Ch
	Gy86PMQp95hMARnEdIwPW/PNJrt73uDNO2vfxXyPjrDKYPBoVkzyvZ6lUIHWlv5m+22le0mUOug
	BS6lWlQhWv1WIzT0AehdyeEkE1jw=
X-Google-Smtp-Source: AGHT+IHR7XEcFHPLksjQmwAtEeWHPpKDjYfRSPpiwZBjHMhkVK9+8QlLG6b+zqiWDqo4DwOtnaRCEolaJ1S/c+wwanM=
X-Received: by 2002:a05:6871:e2d0:b0:261:934:873d with SMTP id
 586e51a60fabf-264be1e0f03mr11838413fac.5.1722430885754; Wed, 31 Jul 2024
 06:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1922131.tdWV9SEqCh@rjwysocki.net> <9002154.VV5PYv0bhD@rjwysocki.net>
 <ZqoxXdQRxhfr5cHY@shredder.mtl.com>
In-Reply-To: <ZqoxXdQRxhfr5cHY@shredder.mtl.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jul 2024 15:01:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h7T27fcL5-Wp5cjxi7mqKVh3_jk-8KwXPGWRbO31sm7Q@mail.gmail.com>
Message-ID: <CAJZ5v0h7T27fcL5-Wp5cjxi7mqKVh3_jk-8KwXPGWRbO31sm7Q@mail.gmail.com>
Subject: Re: [PATCH v1 13/17] mlxsw: core_thermal: Use the .should_bind()
 thermal zone callback
To: Ido Schimmel <idosch@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:43=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Tue, Jul 30, 2024 at 08:34:45PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make the mlxsw core_thermal driver use the .should_bind() thermal zone
> > callback to provide the thermal core with the information on whether or
> > not to bind the given cooling device to the given trip point in the
> > given thermal zone.  If it returns 'true', the thermal core will bind
> > the cooling device to the trip and the corresponding unbinding will be
> > taken care of automatically by the core on the removal of the involved
> > thermal zone or cooling device.
> >
> > It replaces the .bind() and .unbind() thermal zone callbacks (in 3
> > places) which assumed the same trip points ordering in the driver
> > and in the thermal core (that may not be true any more in the
> > future).  The .bind() callbacks used loops over trip point indices
> > to call thermal_zone_bind_cooling_device() for the same cdev (once
> > it had been verified) and all of the trip points, but they passed
> > different 'upper' and 'lower' values to it for each trip.
> >
> > To retain the original functionality, the .should_bind() callbacks
> > need to use the same 'upper' and 'lower' values that would be used
> > by the corresponding .bind() callbacks when they are about about to
>
> Nit: s/about about/about/

Yes, thanks!

> > return 'true'.  To that end, the 'priv' field of each trip is set
> > during the thermal zone initialization to point to the corresponding
> > 'state' object containing the maximum and minimum cooling states of
> > the cooling device.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Please see more comments below, but this patch is going to conflict with
> the series at [1] which is currently under review. How do you want to
> handle that?
>
> https://lore.kernel.org/netdev/cover.1722345311.git.petrm@nvidia.com/

I may be missing something, but I don't see conflicts between this
patch and the series above that would be hard to resolve at merge
time.

Anyway, I'll try to apply the above series locally and merge it with
this patch, thanks for the heads up!

> > ---
> >
> > This patch only depends on patch [09/17].
> >
> > ---
> >  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  121 +++++-------=
---------
> >  1 file changed, 34 insertions(+), 87 deletions(-)
> >
> > Index: linux-pm/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
> > +++ linux-pm/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
> > @@ -165,52 +165,22 @@ static int mlxsw_get_cooling_device_idx(
> >       return -ENODEV;
> >  }
> >
> > -static int mlxsw_thermal_bind(struct thermal_zone_device *tzdev,
> > -                           struct thermal_cooling_device *cdev)
> > +static bool mlxsw_thermal_should_bind(struct thermal_zone_device *tzde=
v,
> > +                                   const struct thermal_trip *trip,
> > +                                   struct thermal_cooling_device *cdev=
,
> > +                                   struct cooling_spec *c)
> >  {
> >       struct mlxsw_thermal *thermal =3D thermal_zone_device_priv(tzdev)=
;
> > -     struct device *dev =3D thermal->bus_info->dev;
> > -     int i, err;
> > +     const struct mlxsw_cooling_states *state =3D trip->priv;
> >
> >       /* If the cooling device is one of ours bind it */
> >       if (mlxsw_get_cooling_device_idx(thermal, cdev) < 0)
> > -             return 0;
> > +             return false;
> >
> > -     for (i =3D 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
> > -             const struct mlxsw_cooling_states *state =3D &thermal->co=
oling_states[i];
> > +     c->upper =3D state->max_state;
> > +     c->lower =3D state->min_state;
> >
> > -             err =3D thermal_zone_bind_cooling_device(tzdev, i, cdev,
> > -                                                    state->max_state,
> > -                                                    state->min_state,
> > -                                                    THERMAL_WEIGHT_DEF=
AULT);
> > -             if (err < 0) {
> > -                     dev_err(dev, "Failed to bind cooling device to tr=
ip %d\n", i);
> > -                     return err;
> > -             }
> > -     }
> > -     return 0;
> > -}
> > -
> > -static int mlxsw_thermal_unbind(struct thermal_zone_device *tzdev,
> > -                             struct thermal_cooling_device *cdev)
> > -{
> > -     struct mlxsw_thermal *thermal =3D thermal_zone_device_priv(tzdev)=
;
> > -     struct device *dev =3D thermal->bus_info->dev;
> > -     int i;
> > -     int err;
> > -
> > -     /* If the cooling device is our one unbind it */
> > -     if (mlxsw_get_cooling_device_idx(thermal, cdev) < 0)
> > -             return 0;
> > -
> > -     for (i =3D 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
> > -             err =3D thermal_zone_unbind_cooling_device(tzdev, i, cdev=
);
> > -             if (err < 0) {
> > -                     dev_err(dev, "Failed to unbind cooling device\n")=
;
> > -                     return err;
> > -             }
> > -     }
> > -     return 0;
> > +     return true;
> >  }
> >
> >  static int mlxsw_thermal_get_temp(struct thermal_zone_device *tzdev,
> > @@ -239,59 +209,29 @@ static struct thermal_zone_params mlxsw_
> >       .no_hwmon =3D true,
> >  };
> >
> > -static struct thermal_zone_device_ops mlxsw_thermal_ops =3D {
> > -     .bind =3D mlxsw_thermal_bind,
> > -     .unbind =3D mlxsw_thermal_unbind,
> > -     .get_temp =3D mlxsw_thermal_get_temp,
> > -};
>
> Is there a reason to move 'mlxsw_thermal_ops' below?

Not really, it can stay here.

> > -
> > -static int mlxsw_thermal_module_bind(struct thermal_zone_device *tzdev=
,
> > -                                  struct thermal_cooling_device *cdev)
> > +static bool mlxsw_thermal_module_should_bind(struct thermal_zone_devic=
e *tzdev,
> > +                                          const struct thermal_trip *t=
rip,
> > +                                          struct thermal_cooling_devic=
e *cdev,
> > +                                          struct cooling_spec *c)
> >  {
> >       struct mlxsw_thermal_module *tz =3D thermal_zone_device_priv(tzde=
v);
> >       struct mlxsw_thermal *thermal =3D tz->parent;
> > -     int i, j, err;
> > +     const struct mlxsw_cooling_states *state =3D trip->priv;
>
> Please place it between 'tz' and 'thermal'. Networking code tries to
> maintain reverse xmas tree ordering for local variables.

I will.

Thanks for the comments!

