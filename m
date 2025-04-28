Return-Path: <linux-acpi+bounces-13334-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 758ABA9F0D2
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 14:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA38F169E0C
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 12:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20773268FFF;
	Mon, 28 Apr 2025 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIghiR4Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAAE27468;
	Mon, 28 Apr 2025 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843669; cv=none; b=g19VnPQAU/FPY43gqBs7fkZHJ8FOhCTzQqRO7coXiI8jZV1nyO+uxIe1IaazpImip++zdfKijrrsa9jDrWnTNMQzdy41OMBIknDhzwsre3gR/hbtIbDbKRJ7dOJtGRRbj+qZ+46VSKzV8sKNaj+InCh/LpoD7z3pLgA4NGxoUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843669; c=relaxed/simple;
	bh=NKc8ZCzJZ7NITJPJfImZlXsOiViyMsKyA+eTROpw87Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqNM5LZEVJvXUZKOQdlnzFbEUFIsDnEzpGT0FofEs8qWJFke8gANocgdD5Jzer2Wp3aGknn1cxvCRfwKkX4PVbj66rzriyzBX/FaHh/QRuzOc68E0GRfp9bpDzeXyfGto/lb58/Na+krMUP/yhKjntA2QWTs859q/9tf0UWrFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIghiR4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591CAC4CEED;
	Mon, 28 Apr 2025 12:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745843668;
	bh=NKc8ZCzJZ7NITJPJfImZlXsOiViyMsKyA+eTROpw87Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sIghiR4YWR+E1DcrQmsz+rnKdHkyZcgKKBcnWmYuWRtqWWjZKVY6vdX+nG7Q5UNWo
	 jJUehEIul6D4GJmt1mgT+3LS3edb/6cYErtv13aVYL197B9wzX2ZzRcaDwb66Hv7BT
	 aClRfzQCDE4Yar8szWhBKERirytKaVt6Dsr7vZoASlZOk6wAjG/pMU8wq6Kigk3Fb6
	 lVX8tXikZEWm7wTknkXbX8EitJoP2hoh+/EqrrFXuUNTnBcwUEeOM88XRonmFUcXl2
	 dC0HFcQqCzUS69Wm5ipuYzMUs2Hg6VzWSQM9Cr6UH5rkT+qhGdvAYIsoXGYMc/IjD9
	 4otv54VH/XyMQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso2927008fac.2;
        Mon, 28 Apr 2025 05:34:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2scHsLb/dkMkES5ViUNI3nHknRZVJmgXotFBf8BiXvZq/Oj0ITX4Jb9y8dFYsp77yw32qRAw/HfbNbNoY@vger.kernel.org, AJvYcCXV+pPNM4dtqk5REfYTsbZEzRpDkqW2rff30QU9j6H2IZHMZaYVZnhMZuL1PAYClBpe8xpBn2jOZrvy@vger.kernel.org
X-Gm-Message-State: AOJu0YzuWzrUmR/MSJtwJc42N1XxRRPpNqIfJITj8mqLBoxG9SLZg+Lg
	cZWAzFk4lIshyY2iDyTXAu13tOfPhVP5/pNGqNcy7+uNDCBzXjD+3ZryHXiScvamb6zSywvFX0o
	u/d9o6HatBrIgOYoMu1gZop/MTK4=
X-Google-Smtp-Source: AGHT+IFNEZ5ivL/NUoE8XiDVTQCnbdzfu3WoSYX4lGIWuq/8qvBFXe/oGdW9gBPjHQ7ZI07CcJxdZQHIFBFbZZT5Fj0=
X-Received: by 2002:a05:6870:e9a8:b0:2d4:ef88:97af with SMTP id
 586e51a60fabf-2d99d74a83amr6463039fac.3.1745843667594; Mon, 28 Apr 2025
 05:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410165456.4173-1-W_Armin@gmx.de> <91ea8aed-5f98-4e4e-b3ee-fdc86d54f787@gmx.de>
 <CAJZ5v0jOR9=jA=8XASBpxJyXaB4TvXmxcZQWq1qUgq1J4h_tEg@mail.gmail.com>
 <90cba8fa-e6a9-4dab-a4ea-fa96d570a870@gmx.de> <c8127d88-194a-4a23-b22e-040e2c6b3e9b@gmx.de>
In-Reply-To: <c8127d88-194a-4a23-b22e-040e2c6b3e9b@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 Apr 2025 14:34:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0icUnepOwb87k44nAt1ZwfHp_BqSBzS-TrQWJ_4E3Ls=g@mail.gmail.com>
X-Gm-Features: ATxdqUHIALPW_giNL7fhS3JuuYpIFazdKvHscUDTAsPtuO9-ofl2vLctGoEqwTo
Message-ID: <CAJZ5v0icUnepOwb87k44nAt1ZwfHp_BqSBzS-TrQWJ_4E3Ls=g@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: thermal: Properly support the _SCP control method
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 2:31=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 27.04.25 um 00:52 schrieb Armin Wolf:
>
> > Am 26.04.25 um 15:12 schrieb Rafael J. Wysocki:
> >
> >> On Sat, Apr 26, 2025 at 1:20=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wr=
ote:
> >>> Am 10.04.25 um 18:54 schrieb Armin Wolf:
> >>>
> >>>> The ACPI specification defines an interface for the operating system
> >>>> to change the preferred cooling mode of a given ACPI thermal zone.
> >>>> This interface takes the form of a special ACPI control method calle=
d
> >>>> _SCP (see section 11.4.13 for details) and is already supported by t=
he
> >>>> ACPI thermal driver.
> >>>>
> >>>> However this support as many issues:
> >>>>
> >>>>    - the kernel advertises support for the "3.0 _SCP Extensions"
> >>>> yet the
> >>>>      ACPI thermal driver does not support those extensions. This may
> >>>>      confuse the ACPI firmware.
> >>>>
> >>>>    - the execution of the _SCP control method happens after the driv=
er
> >>>>      retrieved the trip point values. This conflicts with the ACPI
> >>>>      specification:
> >>>>
> >>>>        "OSPM will automatically evaluate _ACx and _PSV objects after
> >>>>         executing _SCP."
> >>>>
> >>>>    - the cooling mode is hardcoded to active cooling and cannot be
> >>>>      changed by the user.
> >>>>
> >>>> Those issues are fixed in this patch series. In the end the user
> >>>> will be able to tell the ACPI firmware wether he prefers active or
> >>>> passive cooling. This setting will also be interesting for
> >>>> applications like TLP (https://linrunner.de/tlp/index.html).
> >>>>
> >>>> The whole series was tested on various devices supporting the _SCP
> >>>> control method and on a device without the _SCP control method and
> >>>> appears to work flawlessly.
> >>> Any updates on this? I can proof that the new interface for setting
> >>> the cooling mode
> >>> works. Additionally the first two patches fix two issues inside the
> >>> underlying code
> >>> itself, so having them inside the mainline tree would be beneficial
> >>> to users.
> >> Sure.
> >>
> >> I'm going to get to them next week, probably on Monday.
> >
> > Ok, thanks.
> >
> > Armin Wolf
> >
> I am a bit ashamed of myself but i think we need to put this patch series=
 on hold after all :(.
>
> The reason of this is that i am confused by the ACPI specification regard=
ing _SCP:
>
>         11.1.2.1. OSPM Change of Cooling Policy
>
>         When OSPM changes the platform=E2=80=99s cooling policy from one =
cooling mode to the other, the following occurs:
>
>         1. OSPM notifies the platform of the new cooling mode by running =
the Set Cooling Policy (_SCP) control method in all thermal zones and invok=
ing the OS-specific Set Cooling Policy interface to all participating devic=
es in each thermal zone.
>
>         2. Thresholds are updated in the hardware and OSPM is notified of=
 the change.
>
>         3. OSPM re-evaluates the active and passive cooling temperature t=
rip points for the zone and all devices in the zone to obtain the new tempe=
rature thresholds.
>
> This section of the ACPI specification tells me that we need to evaluate =
the _SCP control method of all ACPI thermal zones
> at the same time, yet section 11.4.13. tells me that each _SCP control me=
thods belongs to the individual thermal zone.
>
> The reason why i am concerned by this is because Windows adheres to secti=
on 11.1.2.1. and only exposes this setting
> as a global tunable. This might cause device manufacturers to depend on t=
his behavior and lead to strange things
> should two thermal zones have different _SCP settings.
>
> I will ask the UEFI mailing list which behavior is expected by the ACPI s=
pecification. Until then i suggest that
> we put this patch series on hold.

Sure, no problem.

Please resend it when you think it is good to go.

Thanks!

