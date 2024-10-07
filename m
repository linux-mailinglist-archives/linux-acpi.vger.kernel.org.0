Return-Path: <linux-acpi+bounces-8587-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4529933F7
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2024 18:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC632854E2
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2024 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609611DDA13;
	Mon,  7 Oct 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJndyasR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150F1DC044;
	Mon,  7 Oct 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319811; cv=none; b=RBhW41lMph+ARl4gTtqFzsLARjdftSDgB5ZXN1mTrHtLJVEqceCAmJR7B/xB86xsFetTeOBgRkqZFl3BMffREwdrOGGeSfO+/xu9snLQzKL1qOFwapKUdinSFVIpCd/OOghdzZzt88hM28ZL9VLchuV7AjlZFL//NUh+97ucH2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319811; c=relaxed/simple;
	bh=09BehTu0np3k3gqErdXwoaN+dflDG4Hjj9OdiAtZCKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8HoZfiJutfXJHdawkF7ain9i8CQNLgcrKHQKc3iROJNGyjoESJubUOna20le2YgbHaoEfZdoK9UgBdEgzzZ+ldSZNqGHMhbGa4DFjfmiKBjAZEjeFh3aqk6N2ERkayL/DSYgnSrevsbYgEzsXLo6pNwISIQeoQVPHa2Ani6cxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJndyasR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1C0C4CEDC;
	Mon,  7 Oct 2024 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728319811;
	bh=09BehTu0np3k3gqErdXwoaN+dflDG4Hjj9OdiAtZCKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WJndyasRPaSEr5M6LVrQbdI8yhLSAGiITpB3WOifpBFAa3jmF3D6pe3f/cR+0Fu9k
	 jz3cZTP2NwkBRa+TV7fSgJ9umVOw+jleTK53f1Pd4Nib00dalZvadIUlSkEofy6fvx
	 Ok30FZsdnJLdeYmS5l211vZnWWGb3j2BZ1T1o1ZkMTr2z8SRYMMAJvMEKbrJi6ePK+
	 1ilBND8TkqgYEvD5Beays7tOOWRkkmzOcyXEcpMO9GucrX6LC/dFS6vpNjpzq+9j1C
	 l3OET4pvHdl/Kmi2KbWSTXnyU0qt8nOMpfEzTOlJiGeeTlXKx6jzK5O4/c4JGV4yxR
	 4G+TBU4w9Lbrw==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e3a47ae905so2556952b6e.1;
        Mon, 07 Oct 2024 09:50:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzlTRtJ1OIl4pJYLm/kcB20IoVpt9EjWHLWIpkwF7v/+JpinkttL2KlgZOgVI3MGdGDcGQHd3kYuSjL9Cz@vger.kernel.org, AJvYcCWdNkFOIgtivBi735xFHXnqArVjtFwyw9u0iFdFLW8ZmMi76PmJqcMKasWQ0wG0jSF9RL23HHuN7nUJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzwAGgOxko9IT2X9mt94FvjgYjNUyEUELSCv7NH52BonjKs0xVf
	bw7ALLPgfvtDLNA/JZ/erSHQGAmDoKIEnDXe8CZ6P8Be8QInTfWqYeRK7Pdp3isNqSMPphRcMzW
	jSdEaiTXwh0gpVu+N/aw74XJdFvc=
X-Google-Smtp-Source: AGHT+IFaFT7upksMzg738DaCBgKDPELsw4HS8xXoTN4THFVUKONlVps8/TLcsrcFU0sBFQEK6omxO4xX67Pn6G+2jOQ=
X-Received: by 2002:a05:6808:10cd:b0:3e2:7e47:fddc with SMTP id
 5614622812f47-3e3c1556afcmr7768989b6e.34.1728319810055; Mon, 07 Oct 2024
 09:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
 <CAJZ5v0gAaMLrSyva_cZBxJpzAFM3Lb_SiuTxESjAmHJLxnThGA@mail.gmail.com>
 <8291a067-cd9c-4fcf-b32d-0064f3225836@t-8ch.de> <CAJZ5v0g0sDTnt63BaK2aFR3LppzckO92svrFAenkmQh=Mpxo2w@mail.gmail.com>
In-Reply-To: <CAJZ5v0g0sDTnt63BaK2aFR3LppzckO92svrFAenkmQh=Mpxo2w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Oct 2024 18:49:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g0B8UFqYza88ahMfC-1_FzzizeS6QN=Qtt7vGv9+TK1w@mail.gmail.com>
Message-ID: <CAJZ5v0g0B8UFqYza88ahMfC-1_FzzizeS6QN=Qtt7vGv9+TK1w@mail.gmail.com>
Subject: Re: [PATCH 0/5] ACPI: battery: various cleanups
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 5:14=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Sat, Oct 5, 2024 at 9:27=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weiss=
schuh.net> wrote:
> >
> > Hi Rafael,
> >
> > On 2024-09-04 14:44:33+0200, Rafael J. Wysocki wrote:
> > > On Wed, Sep 4, 2024 at 9:13=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@w=
eissschuh.net> wrote:
> > > >
> > > > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > > > ---
> > > > Thomas Wei=C3=9Fschuh (5):
> > > >       ACPI: battery: check result of register_pm_notifier()
> > > >       ACPI: battery: allocate driver data through devm_ APIs
> > > >       ACPI: battery: initialize mutexes through devm_ APIs
> > > >       ACPI: battery: use DEFINE_SIMPLE_DEV_PM_OPS
> > > >       ACPI: battery: install notify handler through ACPI core
> > > >
> > > >  drivers/acpi/battery.c | 41 +++++++++++---------------------------=
---
> > > >  1 file changed, 11 insertions(+), 30 deletions(-)
> > > > ---
> > >
> > > Since it is a bit late in the cycle and this material does not appear
> > > to be urgent, I'd prefer to defer it until 6.12-rc1 is out.
> >
> > 6.12-rc1 is out and other patches have been queued.
> > Did this one fall through the cracks?
>
> No, it didn't.
>
> There were a couple of ACPI battery driver fixes I wanted to go in
> before this series and they are in -rc2, so I'm going to apply it now.

And now applied except for the last patch which goes against the plan
to turn the ACPI battery driver into a platform one (which it should
be in the first place).

