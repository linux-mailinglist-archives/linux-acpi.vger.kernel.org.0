Return-Path: <linux-acpi+bounces-2296-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19B980D4CC
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 18:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C692B214DE
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133724F1E5;
	Mon, 11 Dec 2023 17:58:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB5193;
	Mon, 11 Dec 2023 09:58:12 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d9db92bd71so600219a34.1;
        Mon, 11 Dec 2023 09:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317491; x=1702922291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXbiTpVzJfHRl7QZFMGmf1sW13oDT9FBF5f3B7KPSvc=;
        b=AZLuqQHAZbxrleryKoiCa7ycnnmw1g7zBi3m56KgedN562h66X4iIHoeDHcreTH3L7
         naAPTlkORp5uZxqi3KijuaFI1dJbRokHtO70Rom/mxKxEyJUgrZSxcejxdkvPbFDfeC/
         uz78wbaPSfHc+vWdFt1ZMlHyT/eOX6aIhN3lxPeTHNBImwxclVlcyT+eL5NfHTsl2+pM
         Ky8KUIHhkPwsoS0wOi98seZFvjSSs/hAkb1I9Rwwgf5EKMUmRGbn6ICITAtZdRsIzsAH
         p3Dikz61fe51hM8p2RSBkKmpzeZt7R23po+EPt/biQXQpP5fsY04xkLkKXssXdxmJ+7C
         tFLA==
X-Gm-Message-State: AOJu0YzZLDV5C6xY0Y7FwDaYknR0tqSxHkxWjFKi9Q6Qok9pNTnnkvDY
	fRK5sO4z9OM2gqNRNHeDUamcI27p6wynd3wRBlE=
X-Google-Smtp-Source: AGHT+IEB8tbPHG0hpmSXtZbQPu9rCKTmgzM9oTofWHtCzQfwuRW4mAEhOhvFbMf7e2/laCNphcPlfM/B7FB2AK0pBlo=
X-Received: by 2002:a05:6871:2284:b0:1fb:648:5207 with SMTP id
 sd4-20020a056871228400b001fb06485207mr9545202oab.2.1702317491331; Mon, 11 Dec
 2023 09:58:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1880915.tdWV9SEqCh@kreacher> <8315317.T7Z3S40VBb@kreacher> <03944e4e-d57d-4442-b38d-e36e20cb5ae3@linaro.org>
In-Reply-To: <03944e4e-d57d-4442-b38d-e36e20cb5ae3@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Dec 2023 18:58:00 +0100
Message-ID: <CAJZ5v0hwLcL9UKQs7WA=hb2v31eEY83rv-bQVgSv_EV9AidYZA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] thermal: Drop redundant and confusing
 device_is_registered() checks
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 6:39=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 08/12/2023 20:19, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Multiple places in the thermal subsystem (most importantly, sysfs
> > attribute callback functions) check if the given thermal zone device is
> > still registered in order to return early in case the device_del() in
> > thermal_zone_device_unregister() has run already.
> >
> > However, after thermal_zone_device_unregister() has been made wait for
> > all of the zone-related activity to complete before returning, it is
> > not necessary to do that any more, because all of the code holding a
> > reference to the thermal zone device object will be waited for even if
> > it does not do anything special to enforce this.
> >
> > Accordingly, drop all of the device_is_registered() checks that are now
> > redundant and get rid of the zone locking that is not necessary any mor=
e
> > after dropping them.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> [ ... ]
>
> > @@ -132,11 +120,6 @@ trip_point_temp_store(struct device *dev
> >
> >       mutex_lock(&tz->lock);
> >
> > -     if (!device_is_registered(dev)) {
> > -             ret =3D -ENODEV;
> > -             goto unlock;
> > -     }
> > -
> >       trip =3D &tz->trips[trip_id];
> >
> >       if (temp !=3D trip->temperature) {
> > @@ -162,23 +145,12 @@ trip_point_temp_show(struct device *dev,
> >                    char *buf)
> >   {
> >       struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> > -     int trip_id, temp;
> > +     int trip_id;
> >
> >       if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) !=3D =
1)
> >               return -EINVAL;
> >
> > -     mutex_lock(&tz->lock);
> > -
> > -     if (!device_is_registered(dev)) {
> > -             mutex_unlock(&tz->lock);
> > -             return -ENODEV;
> > -     }
> > -
> > -     temp =3D tz->trips[trip_id].temperature;
> > -
> > -     mutex_unlock(&tz->lock);
> > -
> > -     return sprintf(buf, "%d\n", temp);
> > +     return sprintf(buf, "%d\n", tz->trips[trip_id].temperature);
>
> Without the lock, could the trip_temp_store() make the value change
> while we read it?

The lock doesn't change that, because the write can occur before
dropping the lock and the printf() and reading an int is atomic on all
architectures supported by Linux.

