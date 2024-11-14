Return-Path: <linux-acpi+bounces-9586-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFE99C894D
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 12:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34915B246FB
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 11:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EBE1F8F09;
	Thu, 14 Nov 2024 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPsx23Lr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFEA1DB52A;
	Thu, 14 Nov 2024 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584425; cv=none; b=LcmzaRe8t8IONhC/xGRR0S830zcC3irmyUiG/IHSgxG4wP79GltH7K5Ps7Ay+JJ6dPFtDrl5nxItOvaopA53H9E185tQ5iBzHJ2jbobkOhQkr92nw27M2QoGkgsn3QGeBAli7WPLMoMtdKqc9pbZUSN7oMYz0+zhDufmgmlPr/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584425; c=relaxed/simple;
	bh=lP/tC+cl5qn/SaXmZkrXXa800OFcG9TJeVUyx/Oo7wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GF3sX11SO3LdpkP0E3m2wJQR8e3U02occIHpOMGkqzfJAUhvcCNMzBVPz0Vsbp/eZB3ONeGfWHOgWQPJHc50tFQABzraNIh6SlgBnCa/AwXlbre0lmWDj6XEkQn0ZiQX+JHAsXh/wanHVkOF8I1pBy+1eZ0lXfkU/nquQFiH77Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPsx23Lr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68856C4CED6;
	Thu, 14 Nov 2024 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731584425;
	bh=lP/tC+cl5qn/SaXmZkrXXa800OFcG9TJeVUyx/Oo7wU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mPsx23LrV4kROLL30LKSSR7Xfu1hz/EQvpf4nKDMtB32kgzC7NgS1lq8Mcdv5ii/p
	 a1Rw8/5hZuuWAvIMRQkWHbghPvXq5KXxwyoEHI2rFiw+QvE1Jllee55D6vQD+YrhKr
	 TTFwAqiARKWi20Xj2iLMNrz2RB7Uh/v2kqb5UBehsk/AlOZtO6ZRKDxeKCCtDj5r0h
	 pWOKrhWBK0RWZLwbP3R0INQDstTytyc2hp+jbeCKvVvqgat4HWkkuISZorAVtZxVBJ
	 MxSKR/W4ZVO5AARiQv8I5Ha16M233RX6Ljyv6hqgAHPYjn15uiJSPUncoWY3C73zM7
	 7BCOZMPHMsnzg==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e602a73ba1so277716b6e.2;
        Thu, 14 Nov 2024 03:40:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWfLa8W84jFhBKsgcD8DWRar9WbeyOCigeNoGmMfhd1VAOo0ab1KlwqOfZwoPkmvUc+PWiDgiDODLb@vger.kernel.org, AJvYcCXpEIwsLFujVi1IzGLJNudYIpo3twWwf3bBn4ispOPyGjnkx4oIVPF9FMq6y1xTpgkddB5g7/DT4ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpsFpkfWpEjG4gzcPfS/2ewu8Ia+dSaE7G3KjNdIIfLzRt3/7t
	DjzRYurjWiYeiYauy6L+OMhGcvoyqP91HvrHVHlJjmljUqLEN+f6Sc/yFII2kKOYcSzrwoqIfA/
	ZLpWUcOvF6C/kx3jshawrzSBFaTI=
X-Google-Smtp-Source: AGHT+IGUlVWgHSxO+vUZHmTdY6VJOXcimDCfh3EldsUraKygCotwRIkBOepc8G+hyRbuxYsm1pkXBC4Ytj5BWZRNsCQ=
X-Received: by 2002:a05:6808:210b:b0:3e5:fc09:7f51 with SMTP id
 5614622812f47-3e7b0a6ecb1mr6112007b6e.9.1731584424656; Thu, 14 Nov 2024
 03:40:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d8da45d7-0a98-41c9-a9a8-49043caaa7af@stanley.mountain>
In-Reply-To: <d8da45d7-0a98-41c9-a9a8-49043caaa7af@stanley.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Nov 2024 12:40:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hrdiKwUfMU9G3HGqfm7xRTtjVM4T9=bWU1d-SMwCWUqg@mail.gmail.com>
Message-ID: <CAJZ5v0hrdiKwUfMU9G3HGqfm7xRTtjVM4T9=bWU1d-SMwCWUqg@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge 447/448] drivers/thermal/testing/zone.c:333
 tt_zone_add_trip() error: uninitialized symbol 'tt_zone'.
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org, devel@acpica.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 9:01=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it bleeding-edge
> head:   d1bf954af846f66ac2ea07b2457b4a089a009c08
> commit: 498ea32432db6f2a0bce88fd521e529a58a370c4 [447/448] thermal: testi=
ng: Use DEFINE_FREE() and __free() to simplify code
> config: x86_64-randconfig-161-20241113 (https://download.01.org/0day-ci/a=
rchive/20241114/202411140825.w4TfKdbS-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51=
eccf88f5321e7c60591c5546b254b6afab99)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202411140825.w4TfKdbS-lkp@intel.com/
>
> New smatch warnings:
> drivers/thermal/testing/zone.c:333 tt_zone_add_trip() error: uninitialize=
d symbol 'tt_zone'.
> drivers/thermal/testing/zone.c:333 tt_zone_add_trip() error: uninitialize=
d symbol 'tt_zone'.
>
> Old smatch warnings:
> drivers/thermal/testing/zone.c:188 tt_add_tz() error: uninitialized symbo=
l 'tt_work'.
> drivers/thermal/testing/zone.c:240 tt_del_tz() error: uninitialized symbo=
l 'tt_work'.
> drivers/thermal/testing/zone.c:335 tt_zone_add_trip() error: uninitialize=
d symbol 'tt_trip'.
> drivers/thermal/testing/zone.c:390 tt_zone_register_tz() error: uninitial=
ized symbol 'trips'.
>
> vim +/tt_zone +333 drivers/thermal/testing/zone.c
>
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  331  int tt_zone_add_trip(co=
nst char *arg)
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  332  {
> 498ea32432db6f Rafael J. Wysocki 2024-11-10 @333        struct tt_thermal=
_zone *tt_zone __free(put_tt_zone);
>
> These __free() pointers need to be initialized to NULL otherwise it leads=
 to an
> uninitialized variable when we return before they're assigned.

Good point.

I've fixed this particular one in the tree and I'll send a patch to
fix the other cases later today.

Thanks!

> f6a034f2df426e Rafael J. Wysocki 2024-08-22  334        struct tt_work *t=
t_work __free(kfree);
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  335        struct tt_trip *t=
t_trip __free(kfree);
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  336        int id;
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  337
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  338        tt_work =3D kzall=
oc(sizeof(*tt_work), GFP_KERNEL);
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  339        if (!tt_work)
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  340                return -E=
NOMEM;
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  341
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  342        tt_trip =3D kzall=
oc(sizeof(*tt_trip), GFP_KERNEL);
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  343        if (!tt_trip)
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  344                return -E=
NOMEM;
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  345
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  346        tt_zone =3D tt_ge=
t_tt_zone(arg);
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  347        if (IS_ERR(tt_zon=
e))
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  348                return PT=
R_ERR(tt_zone);
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  349
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  350        id =3D ida_alloc(=
&tt_zone->ida, GFP_KERNEL);
> 498ea32432db6f Rafael J. Wysocki 2024-11-10  351        if (id < 0)
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  352                return id=
;
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  353
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  354        tt_trip->trip.typ=
e =3D THERMAL_TRIP_ACTIVE;
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  355        tt_trip->trip.tem=
perature =3D THERMAL_TEMP_INVALID;
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  356        tt_trip->trip.fla=
gs =3D THERMAL_TRIP_FLAG_RW;
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  357        tt_trip->id =3D i=
d;
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  358
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  359        guard(tt_zone)(tt=
_zone);
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  360
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  361        list_add_tail(&tt=
_trip->list_node, &tt_zone->trips);
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  362        tt_zone->num_trip=
s++;
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  363
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  364        INIT_WORK(&tt_wor=
k->work, tt_zone_add_trip_work_fn);
> 498ea32432db6f Rafael J. Wysocki 2024-11-10  365        tt_work->tt_zone =
=3D no_free_ptr(tt_zone);
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  366        tt_work->tt_trip =
=3D no_free_ptr(tt_trip);
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  367        schedule_work(&(n=
o_free_ptr(tt_work)->work));
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  368
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  369        return 0;
> f6a034f2df426e Rafael J. Wysocki 2024-08-22  370  }
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>

