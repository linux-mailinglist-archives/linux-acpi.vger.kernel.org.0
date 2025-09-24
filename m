Return-Path: <linux-acpi+bounces-17281-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FEFB9B0A4
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Sep 2025 19:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CD218939A3
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Sep 2025 17:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0E030DED9;
	Wed, 24 Sep 2025 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVAWPHOD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50351D63C5
	for <linux-acpi@vger.kernel.org>; Wed, 24 Sep 2025 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734579; cv=none; b=kp+b/HGgny0+WDL3CWAZmwkQvrAgyA5snvl0YT0KMRkLB6XRJMHLywIaqKbj4foIWzu1h/o4lnLCVWRV3ohHKKwaC6PgSmmNwaH6q36SqVS41LihGSIltaSUyLrW2IwZkX3yD2JPb/qqxTknBb8vX/AaUrFGCGmArn8IGYM2ujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734579; c=relaxed/simple;
	bh=sXJibV3RmNGOhqObd8QqcATRLnEMoRYEVOmX31QC4Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsUmY2G3mXTaGjLu5mPbUZY9CNAAsXD6dGYggmmh0Mg4WmJC3YwqVOMwlFgHu3oILmJieNvboe0wz2ql+7EUnqZ9Phxnefv8WYlgLjwcNmQ681zOtp5wSUpdpvu7hg8o6w/ZTZGXIfSwzJ4lWPLUoujpiyA7Dj66g/tQk0XF8vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVAWPHOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A89C4CEE7
	for <linux-acpi@vger.kernel.org>; Wed, 24 Sep 2025 17:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758734579;
	bh=sXJibV3RmNGOhqObd8QqcATRLnEMoRYEVOmX31QC4Sc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BVAWPHODi1axhiE4Mo3YbB9AGxpOV/QnaWXMhDzDtea9XudNXnI/7mQsmhLi6UvH3
	 7Q1+qvYLRJr3mducAsm7CmPa5OueboXr+a/K3WFXqlkUaDAGGhiT1tfl/OAKCraKdP
	 scEjtE1CtePBstbEYtiKxBNBbCTuHk1AtcpvBGjmaOIRLgdGrjaER+/aQR7FWP44BX
	 fUuhWj7AMY0iQ1k17SnV+gtvr7fNcT91g2lXyc5SlmkzCvXa+EZNwYnJKbm5vBuJtm
	 3o4n9yEA1ceMDWCqsqUpDGW+QDufBGsPwCgi97ds5nUZ755qga4NlaiIIFy4NIK4kc
	 HLuVZuG5qZp/g==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-78d21d5c75cso51373a34.0
        for <linux-acpi@vger.kernel.org>; Wed, 24 Sep 2025 10:22:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaK5dJL3LyRZ8WPEvTg/mBLKhUCiANr+ERZrZbXbDNXe+JeUWXGjdE7jynTKl5Ub7nVkAR2E1AjI4g@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr5sVXny2CKnfiHrTO+Tl1X2STfscTUXJYUeJHoGLKwp/mmZZ+
	vGyvtMfTr9jnypTvCPAiBEytZZ12fNNp9n37xarT/lbOwSFxY+o/8YpP3HSu3i4x5iXMFJY+bRV
	eROlIQa5eO5PrmwrCclqTPfB7maMyebY=
X-Google-Smtp-Source: AGHT+IFsMJ1GbtbudIup8+r+It8AAZGhqVNeJM6Wnrm04PoSZJSQFSxD8VXScqwc6mYrXE6DFbLEz1uXw0MdJn8pzrI=
X-Received: by 2002:a05:6830:25c4:b0:79f:19f:805 with SMTP id
 46e09a7af769-7a03b18de32mr333521a34.7.1758734578673; Wed, 24 Sep 2025
 10:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0htRTTj1QEEmhxBDxYA8oXkg_KP5YrfwyngELDY+Ns1EQ@mail.gmail.com>
 <20250924141047.1477743-1-luogf2025@163.com>
In-Reply-To: <20250924141047.1477743-1-luogf2025@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Sep 2025 19:22:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iVPCtPjyyNeNM2uuJYZbMwJQxYEXA7=50dtB+q=6rQ6Q@mail.gmail.com>
X-Gm-Features: AS18NWDwD2U5p9nKVv3jyqUp9kOCnH64Z1J9L4w236z92ASoL7kdw9C3Qa91Q5M
Message-ID: <CAJZ5v0iVPCtPjyyNeNM2uuJYZbMwJQxYEXA7=50dtB+q=6rQ6Q@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: battery: prevent sysfs_add_battery re-entry on
 rapid events
To: GuangFei Luo <luogf2025@163.com>
Cc: rafael@kernel.org, dan.carpenter@linaro.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:11=E2=80=AFPM GuangFei Luo <luogf2025@163.com> wr=
ote:
>
> > On Wed, Sep 24, 2025 at 12:38=E2=80=AFAM GuangFei Luo <luogf2025@163.co=
m> wrote:
> > >
> > > > On Tuesday, September 23, 2025 7:12:03 PM CEST Rafael J. Wysocki wr=
ote:
> > > > > On Tue, Sep 23, 2025 at 6:14=E2=80=AFPM GuangFei Luo <luogf2025@1=
63.com> wrote:
> > > > > >
> > > > > > The functions battery_hook_add_battery(), battery_hook_remove_b=
attery(),
> > > > > > and sysfs_remove_battery() already acquire locks, so their inte=
rnal
> > > > > > accesses are safe.
> > > > >
> > > > > In fact, there are two locks in use, battery->sysfs_lock and
> > > > > hook_mutex.  The latter is used for managing hooks and the former=
 is
> > > > > only used by sysfs_remove_battery(), so it only prevents that fun=
ction
> > > > > from racing with another instance of itself.
> > > > >
> > > > > I would suggest using battery->sysfs_lock for protecting battery-=
>bat
> > > > > in general.
> > > > >
> > > > > > acpi_battery_refresh() does check battery->bat, but its child
> > > > > > functions (sysfs_add_battery() and sysfs_remove_battery()) alre=
ady
> > > > > > handle locking.
> > > > >
> > > > > What locking?  Before the $subject patch, sysfs_add_battery() doe=
sn't
> > > > > do any locking at all AFAICS.
> > > > >
> > > > > > In acpi_battery_notify(), battery->bat has no lock. However, th=
e
> > > > > > check of battery->bat is at the very end of the function. Durin=
g
> > > > > > earlier calls, battery->bat has already been protected by locks=
, so
> > > > > > re-entry will not cause issues.
> > > > >
> > > > > All of the battery->bat checks and the code depending on them nee=
d to
> > > > > go under the same lock.  I'd use battery->sysfs_lock for this as
> > > > > already mentioned above.
> > > >
> > > > So my (untested) version of this fix is appended.
> > > >
> > > > Note that it explicitly prevents acpi_battery_notify() from racing =
with
> > > > addition/removal, PM notifications, and resume.
> > > >
> > > > ---
> > > >  drivers/acpi/battery.c |   36 +++++++++++++++++++++++-------------
> > > >  1 file changed, 23 insertions(+), 13 deletions(-)
> > > >
> > > > --- a/drivers/acpi/battery.c
> > > > +++ b/drivers/acpi/battery.c
> > > > @@ -92,7 +92,7 @@ enum {
> > > >
> > > >  struct acpi_battery {
> > > >       struct mutex lock;
> > > > -     struct mutex sysfs_lock;
> > > > +     struct mutex update_lock;
> > > >       struct power_supply *bat;
> > > >       struct power_supply_desc bat_desc;
> > > >       struct acpi_device *device;
> > > > @@ -904,15 +904,12 @@ static int sysfs_add_battery(struct acpi
> > > >
> > > >  static void sysfs_remove_battery(struct acpi_battery *battery)
> > > >  {
> > > > -     mutex_lock(&battery->sysfs_lock);
> > > > -     if (!battery->bat) {
> > > > -             mutex_unlock(&battery->sysfs_lock);
> > > > +     if (!battery->bat)
> > > >               return;
> > > > -     }
> > > > +
> > > >       battery_hook_remove_battery(battery);
> > > >       power_supply_unregister(battery->bat);
> > > >       battery->bat =3D NULL;
> > > > -     mutex_unlock(&battery->sysfs_lock);
> > > >  }
> > > >
> > > >  static void find_battery(const struct dmi_header *dm, void *privat=
e)
> > > > @@ -1072,6 +1069,9 @@ static void acpi_battery_notify(acpi_han
> > > >
> > > >       if (!battery)
> > > >               return;
> > > > +
> > > > +     guard(mutex)(&battery->update_lock);
> > > > +
> > > >       old =3D battery->bat;
> > > >       /*
> > > >        * On Acer Aspire V5-573G notifications are sometimes trigger=
ed too
> > > > @@ -1094,21 +1094,22 @@ static void acpi_battery_notify(acpi_han
> > > >  }
> > > >
> > > >  static int battery_notify(struct notifier_block *nb,
> > > > -                            unsigned long mode, void *_unused)
> > > > +                       unsigned long mode, void *_unused)
> > > >  {
> > > >       struct acpi_battery *battery =3D container_of(nb, struct acpi=
_battery,
> > > >                                                   pm_nb);
> > > > -     int result;
> > > >
> > > > -     switch (mode) {
> > > > -     case PM_POST_HIBERNATION:
> > > > -     case PM_POST_SUSPEND:
> > > > +     if (mode =3D=3D PM_POST_SUSPEND || mode =3D=3D PM_POST_HIBERN=
ATION) {
> > > > +             guard(mutex)(&battery->update_lock);
> > > > +
> > > >               if (!acpi_battery_present(battery))
> > > >                       return 0;
> > > >
> > > >               if (battery->bat) {
> > > >                       acpi_battery_refresh(battery);
> > > >               } else {
> > > > +                     int result;
> > > > +
> > > >                       result =3D acpi_battery_get_info(battery);
> > > >                       if (result)
> > > >                               return result;
> > > > @@ -1120,7 +1121,6 @@ static int battery_notify(struct notifie
> > > >
> > > >               acpi_battery_init_alarm(battery);
> > > >               acpi_battery_get_state(battery);
> > > > -             break;
> > > >       }
> > > >
> > > >       return 0;
> > > > @@ -1198,6 +1198,8 @@ static int acpi_battery_update_retry(str
> > > >  {
> > > >       int retry, ret;
> > > >
> > > > +     guard(mutex)(&battery->update_lock);
> > > > +
> > > >       for (retry =3D 5; retry; retry--) {
> > > >               ret =3D acpi_battery_update(battery, false);
> > > >               if (!ret)
> > > > @@ -1230,7 +1232,7 @@ static int acpi_battery_add(struct acpi_
> > > >       if (result)
> > > >               return result;
> > > >
> > > > -     result =3D devm_mutex_init(&device->dev, &battery->sysfs_lock=
);
> > > > +     result =3D devm_mutex_init(&device->dev, &battery->update_loc=
k);
> > > >       if (result)
> > > >               return result;
> > > >
> > > > @@ -1262,6 +1264,8 @@ fail_pm:
> > > >       device_init_wakeup(&device->dev, 0);
> > > >       unregister_pm_notifier(&battery->pm_nb);
> > > >  fail:
> > > > +     guard(mutex)(&battery->update_lock);
> > > > +
> > > >       sysfs_remove_battery(battery);
> > > >
> > > >       return result;
> > > > @@ -1281,6 +1285,9 @@ static void acpi_battery_remove(struct a
> > > >
> > > >       device_init_wakeup(&device->dev, 0);
> > > >       unregister_pm_notifier(&battery->pm_nb);
> > > > +
> > > > +     guard(mutex)(&battery->update_lock);
> > > > +
> > > >       sysfs_remove_battery(battery);
> > > >  }
> > > >
> > > > @@ -1297,6 +1304,9 @@ static int acpi_battery_resume(struct de
> > > >               return -EINVAL;
> > > >
> > > >       battery->update_time =3D 0;
> > > > +
> > > > +     guard(mutex)(&battery->update_lock);
> > > > +
> > > >       acpi_battery_update(battery, true);
> > > >       return 0;
> > > >  }
> > >
> > > Thanks for the detailed explanation and the updated version of the fi=
x.
> > >
> > > I will test your suggested changes on my platform.
> > > After verification, I will send a v7 based on your suggestion.
> >
> > Please just verify and I'll add a changelog and subject to the patch
> > and submit it.
> >
> > Thanks!
>
> I have tested your updated patch on my laptop with battery hot-plug scena=
rios.
> Everything looks normal and I did not observe any issues.

Thanks for the confirmation!

