Return-Path: <linux-acpi+bounces-13749-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130B7AB9E15
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 16:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4244A7303
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 14:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0222B9BC;
	Fri, 16 May 2025 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqXUM76C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720913C914;
	Fri, 16 May 2025 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404002; cv=none; b=e1ndgB1BOngG03aiy3uqJiD3G3oP3EXedm7LDCYynIyuiJScGMc+qqWXVLoJeg7O6nA/V3z0eaQdY+MQkmFgRqEysyoGz5sb+8XMjmzF165NkCLhwXfkWCHq7m5xmPXzuAQnzrc6k5UB0MoiEspux7jfCX3rQon598987UEK/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404002; c=relaxed/simple;
	bh=cAAxj3VIHsb/RHbhTSuyqVeXLwMGaaW13nUMLc/ifRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZShFp55nyeio7D32eS52lIoyibufpHd0TtM+8/bpa9pSSNlc04qHB0rva6WxwiF8CRqcoViDeS49jLjsYx7bC1D+6AfYjtCwL5xrm+qO/uePh+auzb9Nuu0fS7xlWFc9cIkO/Luzz6PrcQ0mhNF3XPUb0d7XJGJo5Tlibj7I2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqXUM76C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618FCC4CEF0;
	Fri, 16 May 2025 14:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747404002;
	bh=cAAxj3VIHsb/RHbhTSuyqVeXLwMGaaW13nUMLc/ifRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FqXUM76C/RCk9Q6n9uLmSyDbBnbrQT7xGq67/JSL5zfuEeBGrO65fYixuqrNiZKiL
	 koB3/nROcKZ/xkrFzRFkcNi2eW0bZo/8xQYY3EEwsc3dxiT/L4Oz4W0u3aL7VOsRBR
	 E2tQ5qa1pC3zicy3XkUvMx6vhR3yBYVU3F5IzQCsWtCC0L4zjTAxN7Hw5SSt9V7YqY
	 9ufQWcA5kFOyJFDxXqEtMpx2GqRTsHeKI770eBDT/MfIIv/wlKxiqvVs6DivK/MdQB
	 0/L/AAhzAdP6dPSarXMIdN/qJgbEKnelTTvRTCbPc4YPSVzWr1JN3B69GRcTL+fbyX
	 erdXhYXFEE4xw==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f6ef597120so25076136d6.0;
        Fri, 16 May 2025 07:00:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVj6JvzTw+S877xxyovY9QQHDFyD3+R7+saPOBMOQ9bAyU2uyv97TFL0dHsbhU9spMaV2MZ/j+jHYR+@vger.kernel.org, AJvYcCWASO7MJjr1+rUAbQxmRNWOmG9xM+tQhGC5tB69k1WoElNqc0gU3XOBEvqaMy+CYFivqJjTUK1fr1VUUFGd@vger.kernel.org
X-Gm-Message-State: AOJu0YyRkPoH7jhHCQstERDHJPiA3+gk6Jn/s1YQZ9jhS+JW+oid20ZA
	wSTbySwIi9HxtD1wFTK+P4zoG7wPvb0l183Q+xlWEY8IGeqqf3yUnHpYcLq55G0Ui/bSvLYL6nz
	FoYPCehPDJb0xaXiDIX4fIAc9uQJ5rWg=
X-Google-Smtp-Source: AGHT+IGCaEqmHct54r+z+95DzCBK0b16hrHKsiRpqvUe6lFxqwKhw45rVCDiIO4wP3AjOqfp7W4i8C6QQ6xkVsBE1uE=
X-Received: by 2002:a05:6808:ec6:b0:3f8:bbf3:3a18 with SMTP id
 5614622812f47-404cd76d68dmr3628570b6e.16.1747403990708; Fri, 16 May 2025
 06:59:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410165456.4173-1-W_Armin@gmx.de> <91ea8aed-5f98-4e4e-b3ee-fdc86d54f787@gmx.de>
 <CAJZ5v0jOR9=jA=8XASBpxJyXaB4TvXmxcZQWq1qUgq1J4h_tEg@mail.gmail.com>
 <90cba8fa-e6a9-4dab-a4ea-fa96d570a870@gmx.de> <c8127d88-194a-4a23-b22e-040e2c6b3e9b@gmx.de>
 <CAJZ5v0icUnepOwb87k44nAt1ZwfHp_BqSBzS-TrQWJ_4E3Ls=g@mail.gmail.com> <5cec046e-c495-4517-82c8-83ae3cdb63a1@gmx.de>
In-Reply-To: <5cec046e-c495-4517-82c8-83ae3cdb63a1@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 15:59:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iEni2ie-6sCiZBfwugZ--NmJQX6=2EYKXnHwRCfpqUzQ@mail.gmail.com>
X-Gm-Features: AX0GCFvyonuB3A8V3mhlAQGODrstKShjPWWsik2ViHrGTerYyk9mStsg130MMVg
Message-ID: <CAJZ5v0iEni2ie-6sCiZBfwugZ--NmJQX6=2EYKXnHwRCfpqUzQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: thermal: Properly support the _SCP control method
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 3, 2025 at 12:29=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 28.04.25 um 14:34 schrieb Rafael J. Wysocki:
>
> > On Mon, Apr 28, 2025 at 2:31=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wro=
te:
> >> Am 27.04.25 um 00:52 schrieb Armin Wolf:
> >>
> >>> Am 26.04.25 um 15:12 schrieb Rafael J. Wysocki:
> >>>
> >>>> On Sat, Apr 26, 2025 at 1:20=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> =
wrote:
> >>>>> Am 10.04.25 um 18:54 schrieb Armin Wolf:
> >>>>>
> >>>>>> The ACPI specification defines an interface for the operating syst=
em
> >>>>>> to change the preferred cooling mode of a given ACPI thermal zone.
> >>>>>> This interface takes the form of a special ACPI control method cal=
led
> >>>>>> _SCP (see section 11.4.13 for details) and is already supported by=
 the
> >>>>>> ACPI thermal driver.
> >>>>>>
> >>>>>> However this support as many issues:
> >>>>>>
> >>>>>>     - the kernel advertises support for the "3.0 _SCP Extensions"
> >>>>>> yet the
> >>>>>>       ACPI thermal driver does not support those extensions. This =
may
> >>>>>>       confuse the ACPI firmware.
> >>>>>>
> >>>>>>     - the execution of the _SCP control method happens after the d=
river
> >>>>>>       retrieved the trip point values. This conflicts with the ACP=
I
> >>>>>>       specification:
> >>>>>>
> >>>>>>         "OSPM will automatically evaluate _ACx and _PSV objects af=
ter
> >>>>>>          executing _SCP."
> >>>>>>
> >>>>>>     - the cooling mode is hardcoded to active cooling and cannot b=
e
> >>>>>>       changed by the user.
> >>>>>>
> >>>>>> Those issues are fixed in this patch series. In the end the user
> >>>>>> will be able to tell the ACPI firmware wether he prefers active or
> >>>>>> passive cooling. This setting will also be interesting for
> >>>>>> applications like TLP (https://linrunner.de/tlp/index.html).
> >>>>>>
> >>>>>> The whole series was tested on various devices supporting the _SCP
> >>>>>> control method and on a device without the _SCP control method and
> >>>>>> appears to work flawlessly.
> >>>>> Any updates on this? I can proof that the new interface for setting
> >>>>> the cooling mode
> >>>>> works. Additionally the first two patches fix two issues inside the
> >>>>> underlying code
> >>>>> itself, so having them inside the mainline tree would be beneficial
> >>>>> to users.
> >>>> Sure.
> >>>>
> >>>> I'm going to get to them next week, probably on Monday.
> >>> Ok, thanks.
> >>>
> >>> Armin Wolf
> >>>
> >> I am a bit ashamed of myself but i think we need to put this patch ser=
ies on hold after all :(.
> >>
> >> The reason of this is that i am confused by the ACPI specification reg=
arding _SCP:
> >>
> >>          11.1.2.1. OSPM Change of Cooling Policy
> >>
> >>          When OSPM changes the platform=E2=80=99s cooling policy from =
one cooling mode to the other, the following occurs:
> >>
> >>          1. OSPM notifies the platform of the new cooling mode by runn=
ing the Set Cooling Policy (_SCP) control method in all thermal zones and i=
nvoking the OS-specific Set Cooling Policy interface to all participating d=
evices in each thermal zone.
> >>
> >>          2. Thresholds are updated in the hardware and OSPM is notifie=
d of the change.
> >>
> >>          3. OSPM re-evaluates the active and passive cooling temperatu=
re trip points for the zone and all devices in the zone to obtain the new t=
emperature thresholds.
> >>
> >> This section of the ACPI specification tells me that we need to evalua=
te the _SCP control method of all ACPI thermal zones
> >> at the same time, yet section 11.4.13. tells me that each _SCP control=
 methods belongs to the individual thermal zone.
> >>
> >> The reason why i am concerned by this is because Windows adheres to se=
ction 11.1.2.1. and only exposes this setting
> >> as a global tunable. This might cause device manufacturers to depend o=
n this behavior and lead to strange things
> >> should two thermal zones have different _SCP settings.
> >>
> >> I will ask the UEFI mailing list which behavior is expected by the ACP=
I specification. Until then i suggest that
> >> we put this patch series on hold.
> > Sure, no problem.
> >
> > Please resend it when you think it is good to go.
> >
> > Thanks!
>
> Alright, the UEFI mailing list gave no response, so i am kind of stuck.
>
> It seems that many firmware implementation only have a single cooling pol=
icy register which is set by all _SCP control methods inside the whole syst=
em.
> The reason for this seems to be that Windows treats this setting as globa=
l, but the ACPI specification seemingly does not directly mandate this.
>
> Do you think we should take the risk and allow users to control each _SCP=
 instance manually?

No, I don't.

Doing things that are not done in Windows with ACPI objects is
generally asking for trouble unless there is a specific use case and
there is high confidence that it is actually going to work.

At least to begin with, I wouldn't do it.

> Apart from that the first two patches should be safe, so you can still pi=
ck them.

Done.

> Only the last patch needs some more work.

OK

Thanks!

