Return-Path: <linux-acpi+bounces-9665-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EB29D2C6D
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A49B2B2954C
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C101D0E10;
	Tue, 19 Nov 2024 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVNjpaM7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2121D0438;
	Tue, 19 Nov 2024 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036423; cv=none; b=TAVaclVcGnCpJq7/OqAdN45DFECab75AUr4y+AOEMxMCD+jZDUL1Q5HNx7qBLQWuJYFbXbNXqA80cRx8HXf6OSYyYxZXlZP5KXYsxP5cWFWvps+rpGol4u18Tc52yivKFK0UigfReESaq3b8wzy8zga3zaKHva7h6K1bxNHMAeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036423; c=relaxed/simple;
	bh=1oAj6JYNDJa3GWhLbj+143GK5p0QwScJoOz363V4lVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIm54zGtapo8GEzYBjlsv4kuXvwOmQrNZroNP+R1siXV2Gma3JWq+4Oji3mZi/JBOJPygukUIR9HqTndcsyVOOXY97q1MlToutl1frkSsqCOzV8Cxy5pdn7Xy6p+OdLiU2Ae2pjvsqA+AC7ZqAB+7HBxHLIj0FlFvAgOXO7vUTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVNjpaM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C64C4CED7;
	Tue, 19 Nov 2024 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732036423;
	bh=1oAj6JYNDJa3GWhLbj+143GK5p0QwScJoOz363V4lVU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GVNjpaM7UIqXjoWH3ukR1LOYAzkx+xFrQf1VPUy+lm/EHCtYlzN6KUWpEfFCgk2ro
	 N9C1lLQsFDkuMo/Zo5XMG6R4UzEVH/kULr8pMQLQriSQPwdLDx4fAsx6MVeIr4SzCY
	 oDcvVjL849PUxK2o/gqcAYDb1PoXjjZCmhwVkMYyBmdhyvkj3Zip59mk8jfQSm0uti
	 8QUzAwvFChWEsGMllxbdky4S/oehT6gAbUVtHTG9bQ+2QeE2WT+iNP2sOewriNMvAm
	 sl1fc6SwyB3noagKtXvdYCFYLkzw1//FSSlptxkgbV75ScYjKv/QKZfhvgBXEa27Fc
	 /iMMbkZqw/ClQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29680f21217so786905fac.1;
        Tue, 19 Nov 2024 09:13:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCB/A19B7SnoEye7PLoj6epmYM08C+IDo9ausVJABN1K9aNou2DIjxbpNirKa1BGGiDpR/X+eVNHFONZkg@vger.kernel.org, AJvYcCVCeciKcnN1UAfZgZ2THSfDnPvKnSGAy+ET435KOuqyr6RkHrWaDp3iEdhn/QYhH4Pbo3piv41hx9He@vger.kernel.org, AJvYcCWDRuucWr9a+gwMr45AgrfSh1itPtHZY9/zpZlxwyNADWHc7uUJhx476Z4eOqCaELhhc4R6zCUA/hI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/FwH/XPxAM9Thiu0W5/MhyKJCMFkX+i6bSDOs5rK7R4yBkzeW
	UnHKusqNcn5lYCH1+2KkwBwkrzZe3NWdMW2d79GscdVS1ynaPHZ2KXCTnMPV3DIAPbpLdT72wza
	RFSs1O6wLnJ5xaehY2bhs/d60Pfo=
X-Google-Smtp-Source: AGHT+IHxvAFHjEK3r2BPEeFAjJMdHTLIuHKdoSpreVZimMd/tuX2SshSM6X/4zX1/ERuEvvAfuAOm27ubAvqhHgXm8Y=
X-Received: by 2002:a05:6870:3929:b0:296:c2a6:cb27 with SMTP id
 586e51a60fabf-296c2a6f8acmr2234069fac.24.1732036422686; Tue, 19 Nov 2024
 09:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13636465.uLZWGnKmhe@rjwysocki.net> <2285569.iZASKD2KPV@rjwysocki.net>
 <ZzyqMmzMaCHqE+9m@BLRRASHENOY1.amd.com>
In-Reply-To: <ZzyqMmzMaCHqE+9m@BLRRASHENOY1.amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Nov 2024 18:13:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i48ph7Qa9ZRwJu6EEh_1Rs9xmsHw9KqdO6zH6RyJFrsg@mail.gmail.com>
Message-ID: <CAJZ5v0i48ph7Qa9ZRwJu6EEh_1Rs9xmsHw9KqdO6zH6RyJFrsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpuidle: Change :enter_dead() driver callback
 return type to void
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	x86 Maintainers <x86@kernel.org>, Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gautham,

On Tue, Nov 19, 2024 at 4:09=E2=80=AFPM Gautham R. Shenoy
<gautham.shenoy@amd.com> wrote:
>
> Hello Rafael,
>
> On Fri, Nov 15, 2024 at 10:00:25PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > After a previous change, cpuidle_play_dead(), which is the only caller
> > of idle state :enter_dead() callbacks, ignores their return values, so
> > they may as well be void.
> >
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> > ---
> >
> > v1 -> v2: New patch
> >
> > Interestingly enough, the only user of :enter_dead() idle state callbac=
ks
> > in the current mainline turns out to be ACPI idle.
>
> For that matter, the only user of cpuidle_play_dead() is the
> native_play_dead(). Was that always the case?

At least as long ago as of 4.20.

> Some of the other architectures select the deepest available idle
> state at boot time, and enter that state when a CPU is offlined.

That's fine as long as the state to use is already known at that time.

> In any case I am ok with this.
>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> --
> Thanks and Regards
> gautham.
> >
> > ---
> >  drivers/acpi/processor_idle.c |    7 ++-----
> >  include/linux/cpuidle.h       |    2 +-
> >  2 files changed, 3 insertions(+), 6 deletions(-)
> >
> > Index: linux-pm/include/linux/cpuidle.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/include/linux/cpuidle.h
> > +++ linux-pm/include/linux/cpuidle.h
> > @@ -61,7 +61,7 @@ struct cpuidle_state {
> >                       struct cpuidle_driver *drv,
> >                       int index);
> >
> > -     int (*enter_dead) (struct cpuidle_device *dev, int index);
> > +     void (*enter_dead) (struct cpuidle_device *dev, int index);
> >
> >       /*
> >        * CPUs execute ->enter_s2idle with the local tick or entire time=
keeping
> > Index: linux-pm/drivers/acpi/processor_idle.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/acpi/processor_idle.c
> > +++ linux-pm/drivers/acpi/processor_idle.c
> > @@ -578,7 +578,7 @@ static void __cpuidle acpi_idle_do_entry
> >   * @dev: the target CPU
> >   * @index: the index of suggested state
> >   */
> > -static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
> > +static void acpi_idle_play_dead(struct cpuidle_device *dev, int index)
> >  {
> >       struct acpi_processor_cx *cx =3D per_cpu(acpi_cstate[index], dev-=
>cpu);
> >
> > @@ -591,11 +591,8 @@ static int acpi_idle_play_dead(struct cp
> >               else if (cx->entry_method =3D=3D ACPI_CSTATE_SYSTEMIO) {
> >                       io_idle(cx->address);
> >               } else
> > -                     return -ENODEV;
> > +                     return;
> >       }
> > -
> > -     /* Never reached */
> > -     return 0;
> >  }
> >
> >  static __always_inline bool acpi_idle_fallback_to_c1(struct acpi_proce=
ssor *pr)
> >
> >
> >
>

