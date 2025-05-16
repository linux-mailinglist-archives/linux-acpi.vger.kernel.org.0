Return-Path: <linux-acpi+bounces-13757-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 019D0ABA177
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 19:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF61A03B5F
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC0D24E4C7;
	Fri, 16 May 2025 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="My6CHPVv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256CE24E4C1;
	Fri, 16 May 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414627; cv=none; b=C8Rp9K/d4abK7YsucJF+VRlBRjFfQBTyOY3wkkDUEKrVH2DsGZ2gb8NxGj/WLpXGFkdGN+GWf6pvemwtIy42sDmfokfNu54BSlnPWpzfNwNaB0No6afbQlwBAhe1GtbeKOdAi+XU9o6fqjEXtxqv6yEyrSqSzmO3Jj6eVdR3ltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414627; c=relaxed/simple;
	bh=3OaLhhbnyaFRUsMl6Jn49C7vgfWOS9Skc2umIuHl5kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtXNg84k4D5bey6ZioyJqeVABsLA2w3fGQRLtyfsqg0f0PsVKKZb9q6fwXZVDNhBeEP6l6BFneOhx7nGb6oJRYA4yguzaCbp+89zpY+t6zEU0biNk456N6DiIZB62gzTALZgF/9W8kUjb61SxsBaT6VFl/V/rTbNu4oBP0gSBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=My6CHPVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09FDC4CEE4;
	Fri, 16 May 2025 16:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747414626;
	bh=3OaLhhbnyaFRUsMl6Jn49C7vgfWOS9Skc2umIuHl5kM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=My6CHPVvF21PFuSvisGrbzzRAZMex9cLcoEVbn3FfDU3JKfZBAeBcwW3CXw/y4mgO
	 C0UCscLFmYgFksVXrWZFw8PkJC2BcfKDex72q/m3VIOiSOcg7Po7JW0RnfMfYt6BfM
	 ojY5p9djPQDrZOrvKJiGO9yo80H0B7Wc8kUnsNwGFuwXVEtQ4YXcns3Zgs2zVSMhCD
	 BTBbsFmQB3LO6gYzY/NAmM56Lw/Tx/WYTsVaXLtC8zWoYmOIxg2fzr0qn/Ga7TuI3h
	 d0a9oB/dmvYjIP39pXqvnrPdx+VJ99g5IK17dGMmOKnIEcA/d2xjHu/s7NIrLMsFMr
	 5FJ1dkj4dmqEw==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3fe83c8cbdbso1132522b6e.3;
        Fri, 16 May 2025 09:57:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgVyIEa+dK0QSmO+Is50o5kWmu3MZ3CabTsR7+HAgBMDEmbnIxLs7Nb7ab3pf7to9MHFL8G0lY5AXu@vger.kernel.org, AJvYcCX62DFcNAPQd0rBi/oVw6PNQz9M+lX0eJpMlY/RayqcqzZGFpESZ019WSn8qadp4hE5kOGwYeh8jHPwSDyY@vger.kernel.org
X-Gm-Message-State: AOJu0YzmADdwJSI/bgWi46mADwGeA7pLSv6SO50llzXc8aUtob8ptFPH
	SKqdE0k1Va8MMgrRJdNOBijrx3PCclvjKOnDRNVAdc0gvA+Z0sMT2FWItg1QnVW1JA1gC3Ay23/
	yIio1U1GQszTx+fh9MpMKGuWeVjKsubs=
X-Google-Smtp-Source: AGHT+IF9rWHdjVzlKTbyipJxoGTP8OW1Szm3iv18BWWmjdNbX3F6izSpbQWRnYfinB9TUP4TEKvsLet0zFSjqEcQ8i0=
X-Received: by 2002:a05:6808:399a:b0:404:766:3129 with SMTP id
 5614622812f47-404da70a555mr2201120b6e.1.1747414625999; Fri, 16 May 2025
 09:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410165456.4173-1-W_Armin@gmx.de> <91ea8aed-5f98-4e4e-b3ee-fdc86d54f787@gmx.de>
 <CAJZ5v0jOR9=jA=8XASBpxJyXaB4TvXmxcZQWq1qUgq1J4h_tEg@mail.gmail.com>
 <90cba8fa-e6a9-4dab-a4ea-fa96d570a870@gmx.de> <c8127d88-194a-4a23-b22e-040e2c6b3e9b@gmx.de>
 <CAJZ5v0icUnepOwb87k44nAt1ZwfHp_BqSBzS-TrQWJ_4E3Ls=g@mail.gmail.com>
 <5cec046e-c495-4517-82c8-83ae3cdb63a1@gmx.de> <CAJZ5v0iEni2ie-6sCiZBfwugZ--NmJQX6=2EYKXnHwRCfpqUzQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iEni2ie-6sCiZBfwugZ--NmJQX6=2EYKXnHwRCfpqUzQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 18:56:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0grVpm8MUGYRRhC6VTRRQxvCEmzRJm27F83vJ4a-Wwjhg@mail.gmail.com>
X-Gm-Features: AX0GCFuz5tlxTSYTkGoJf924BrOs0gzXQsdXvj2unTi0EKN6a7i14_orfifvrS4
Message-ID: <CAJZ5v0grVpm8MUGYRRhC6VTRRQxvCEmzRJm27F83vJ4a-Wwjhg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: thermal: Properly support the _SCP control method
To: Armin Wolf <w_armin@gmx.de>
Cc: rui.zhang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 3:59=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Sat, May 3, 2025 at 12:29=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote=
:
> >
> > Am 28.04.25 um 14:34 schrieb Rafael J. Wysocki:
> >
> > > On Mon, Apr 28, 2025 at 2:31=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> w=
rote:
> > >> Am 27.04.25 um 00:52 schrieb Armin Wolf:
> > >>
> > >>> Am 26.04.25 um 15:12 schrieb Rafael J. Wysocki:
> > >>>
> > >>>> On Sat, Apr 26, 2025 at 1:20=E2=80=AFAM Armin Wolf <W_Armin@gmx.de=
> wrote:
> > >>>>> Am 10.04.25 um 18:54 schrieb Armin Wolf:
> > >>>>>
> > >>>>>> The ACPI specification defines an interface for the operating sy=
stem
> > >>>>>> to change the preferred cooling mode of a given ACPI thermal zon=
e.
> > >>>>>> This interface takes the form of a special ACPI control method c=
alled
> > >>>>>> _SCP (see section 11.4.13 for details) and is already supported =
by the
> > >>>>>> ACPI thermal driver.
> > >>>>>>
> > >>>>>> However this support as many issues:
> > >>>>>>
> > >>>>>>     - the kernel advertises support for the "3.0 _SCP Extensions=
"
> > >>>>>> yet the
> > >>>>>>       ACPI thermal driver does not support those extensions. Thi=
s may
> > >>>>>>       confuse the ACPI firmware.
> > >>>>>>
> > >>>>>>     - the execution of the _SCP control method happens after the=
 driver
> > >>>>>>       retrieved the trip point values. This conflicts with the A=
CPI
> > >>>>>>       specification:
> > >>>>>>
> > >>>>>>         "OSPM will automatically evaluate _ACx and _PSV objects =
after
> > >>>>>>          executing _SCP."
> > >>>>>>
> > >>>>>>     - the cooling mode is hardcoded to active cooling and cannot=
 be
> > >>>>>>       changed by the user.
> > >>>>>>
> > >>>>>> Those issues are fixed in this patch series. In the end the user
> > >>>>>> will be able to tell the ACPI firmware wether he prefers active =
or
> > >>>>>> passive cooling. This setting will also be interesting for
> > >>>>>> applications like TLP (https://linrunner.de/tlp/index.html).
> > >>>>>>
> > >>>>>> The whole series was tested on various devices supporting the _S=
CP
> > >>>>>> control method and on a device without the _SCP control method a=
nd
> > >>>>>> appears to work flawlessly.
> > >>>>> Any updates on this? I can proof that the new interface for setti=
ng
> > >>>>> the cooling mode
> > >>>>> works. Additionally the first two patches fix two issues inside t=
he
> > >>>>> underlying code
> > >>>>> itself, so having them inside the mainline tree would be benefici=
al
> > >>>>> to users.
> > >>>> Sure.
> > >>>>
> > >>>> I'm going to get to them next week, probably on Monday.
> > >>> Ok, thanks.
> > >>>
> > >>> Armin Wolf
> > >>>
> > >> I am a bit ashamed of myself but i think we need to put this patch s=
eries on hold after all :(.
> > >>
> > >> The reason of this is that i am confused by the ACPI specification r=
egarding _SCP:
> > >>
> > >>          11.1.2.1. OSPM Change of Cooling Policy
> > >>
> > >>          When OSPM changes the platform=E2=80=99s cooling policy fro=
m one cooling mode to the other, the following occurs:
> > >>
> > >>          1. OSPM notifies the platform of the new cooling mode by ru=
nning the Set Cooling Policy (_SCP) control method in all thermal zones and=
 invoking the OS-specific Set Cooling Policy interface to all participating=
 devices in each thermal zone.
> > >>
> > >>          2. Thresholds are updated in the hardware and OSPM is notif=
ied of the change.
> > >>
> > >>          3. OSPM re-evaluates the active and passive cooling tempera=
ture trip points for the zone and all devices in the zone to obtain the new=
 temperature thresholds.
> > >>
> > >> This section of the ACPI specification tells me that we need to eval=
uate the _SCP control method of all ACPI thermal zones
> > >> at the same time, yet section 11.4.13. tells me that each _SCP contr=
ol methods belongs to the individual thermal zone.

It just says "This object may exist under a thermal zone or a device"
so I don't see any contradiction.  Section 11.4.13 says where it is
located and Section 11.1.2.1 says when to evaluate it.

However, Section 11.4.13 also says "OSPM will automatically evaluate
_ACx and _PSV objects after executing _SCP" which is not arranged for
in your patch [3/3] IIUC.

Thanks!

