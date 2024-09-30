Return-Path: <linux-acpi+bounces-8502-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0824298AC3F
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 20:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AA11C21161
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 18:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2560E198850;
	Mon, 30 Sep 2024 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MigAfGeN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3CB198825;
	Mon, 30 Sep 2024 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721638; cv=none; b=ObHiHjggqY1hlkDkflcYap2/DujJx10nkAyGhqEXmmGwDZ4EyLyjBApdmBUrwxFlbiqwQKsOVm4tUDk7RxnkHYunI191W4uSiJM1aPFQBybvrlOth49Q7f6rz1UjJIhQbKM41dVnnUBISPw+kRYKKxxd0wvn6pfvfVuDhnduCQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721638; c=relaxed/simple;
	bh=Tpus15b1Imrb92OUZ4FSuJL0suSCTuwC6k7motjoHvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoiNBOt5Krbrx8MimC6uo0Gs7XBKG7bJZ3cYNGElWX9MOWPfxNe2mvw1V6zNzzWPFTBrvVZhXulcy36Ri3xPLzh/bCZQgxg2jH/4TeCeE9hSMWcYHzIwFVeem0yHxkK920pT2jLs8FiE7UQ2oH+gknOmEjSuIbPdQE1d+kVJDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MigAfGeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E74FC4CECF;
	Mon, 30 Sep 2024 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727721637;
	bh=Tpus15b1Imrb92OUZ4FSuJL0suSCTuwC6k7motjoHvM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MigAfGeNqespvU26jr6+2ciyCwCQjB8vy17cnc6wrdLrQrpxYp884iYUv5riNa5TX
	 CeRMc39EIncYfy2iFttk0+tDCBEx8dzw8mmO+j790t5U5KGzoOOUD3x/V36feIdMAL
	 OiiRoluD/9jiEtdRvu7+OCCL5mQM45Y4lXm+w/bh+tiNj5gkdq4pVIyHJgQlf2L1mn
	 Y4ZOTnfTI5t+7ck44R874iR8gzRdeqHHhzvgqzzajwHazmfs679SGSiyjuikQuOUbY
	 oarR1vEGODWOj9Cd7kJIAw9JL2GGVx+x3/Ncg7qT4SEND9eSkobWEYs3Aqa/yn+hYm
	 iQ5/Rk+Hwxs+g==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e033e37bc9so1764872b6e.0;
        Mon, 30 Sep 2024 11:40:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUr1PceEI6ghbB3GdvsMbFMHR6AePB8axpn8WZ8ej3CwZfTIKLNUjMZQErVY5moHoE1x6WDq/BF@vger.kernel.org, AJvYcCWhZ7IKYsni3HT4QTFkLOTkm8YehovW3BKn8iehtxJjUk0n4NDnLzTikhckGSz8FPVPptDpbn1L4d6/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60IY8od8tOysNJw09ynd0yqmQPvhhyKdLMQfW0utVhPemGkQ5
	PkLTZeZmg6BY17gvXdyBGtPiIlz2ufewGXWMXFs4TPWIjbn/Ld7zIbpuHO1NlSUGaPvaI9ILs+u
	L7vqIaoEnzz48gLp4FA65/aBGp5c=
X-Google-Smtp-Source: AGHT+IGOb55Zjx+VFE4BTMtZ3AvKCCsJh5OXO7lU1MLd8nXvXPYIbxWdB7/ZupwyiY5se8rPEwAMWkBehOp/EtsVidY=
X-Received: by 2002:a05:6808:2e90:b0:3e2:8698:5a74 with SMTP id
 5614622812f47-3e39395c3cemr8501936b6e.5.1727721636789; Mon, 30 Sep 2024
 11:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927141606.66826-1-hdegoede@redhat.com> <20240927141606.66826-2-hdegoede@redhat.com>
 <2f45a6ac-5bb7-4954-adb5-3bf706363062@molgen.mpg.de> <d69af7ad-244d-45e8-ad7e-4a3ebf30d04d@redhat.com>
 <CAJZ5v0gxSz-aeoDqhp1dS5g6aoDXSn8ZwYB0TuN7SU2Sbar8ow@mail.gmail.com> <50273312-f158-4afe-b03e-bc6239a549aa@redhat.com>
In-Reply-To: <50273312-f158-4afe-b03e-bc6239a549aa@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Sep 2024 20:40:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ihA7gSK8_uN3ChnnCzTx+kSJdR=uHVRfeq=oiV0Gguag@mail.gmail.com>
Message-ID: <CAJZ5v0ihA7gSK8_uN3ChnnCzTx+kSJdR=uHVRfeq=oiV0Gguag@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI: resource: Loosen the Asus E1404GAB DMI match to
 also cover the E1404GA
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>, 
	Ben Mayo <benny1091@gmail.com>, Tamim Khan <tamim@fusetak.com>, linux-acpi@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 2:20=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 30-Sep-24 2:18 PM, Rafael J. Wysocki wrote:
> > On Mon, Sep 30, 2024 at 12:56=E2=80=AFPM Hans de Goede <hdegoede@redhat=
.com> wrote:
> >>
> >> Hi,
> >>
> >> On 30-Sep-24 12:42 PM, Paul Menzel wrote:
> >>> Dear Hans,
> >>>
> >>>
> >>> Thank you for your patch.
> >>>
> >>> Am 27.09.24 um 16:16 schrieb Hans de Goede:
> >>>> Like other Asus Vivobooks, the Asus Vivobook Go E1404GA has a DSDT
> >>>> describing IRQ 1 as ActiveLow, while the kernel overrides to Edge_Hi=
gh.
> >>>>
> >>>>      $ sudo dmesg | grep DMI:.*BIOS
> >>>>      [    0.000000] DMI: ASUSTeK COMPUTER INC. Vivobook Go E1404GA_E=
1404GA/E1404GA, BIOS E1404GA.302 08/23/2023
> >>>>      $ sudo cp /sys/firmware/acpi/tables/DSDT dsdt.dat
> >>>>      $ iasl -d dsdt.dat
> >>>>      $ grep -A 30 PS2K dsdt.dsl | grep IRQ -A 1
> >>>>                  IRQ (Level, ActiveLow, Exclusive, )
> >>>>                      {1}
> >>>>
> >>>> There already is an entry in the irq1_level_low_skip_override[] DMI =
match
> >>>> table for the "E1404GAB", change this to match on "E1404GA" to cover
> >>>> the E1404GA model as well (DMI_MATCH() does a substring match).
> >>>
> >>> Ah, good to know. Thank you for fixing it.
> >>>
> >>>> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> >>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219224
> >>>> Cc: Tamim Khan <tamim@fusetak.com>
> >>>> Cc: stable@vger.kernel.org
> >>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>> ---
> >>>> Note this patch replaces Paul Menzel's patch which added a new entry
> >>>> for the "E1404GA", instead of loosening the "E1404GAB" match:
> >>>> https://lore.kernel.org/linux-acpi/20240911081612.3931-1-pmenzel@mol=
gen.mpg.de/
> >>>> ---
> >>>>   drivers/acpi/resource.c | 4 ++--
> >>>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> >>>> index 1ff251fd1901..dfe108e2ccde 100644
> >>>> --- a/drivers/acpi/resource.c
> >>>> +++ b/drivers/acpi/resource.c
> >>>> @@ -504,10 +504,10 @@ static const struct dmi_system_id irq1_level_l=
ow_skip_override[] =3D {
> >>>>           },
> >>>>       },
> >>>>       {
> >>>> -        /* Asus Vivobook Go E1404GAB */
> >>>> +        /* Asus Vivobook Go E1404GA* */
> >>>
> >>> I guess people are going to grep for the model, if something does not=
 work, so maybe the known ones should listed. I know it=E2=80=99s not optim=
al, as the comments are very likely be incomplete, but it=E2=80=99s better =
than than not having it listed, in my opinion.
> >>
> >> That is a valid point, OTOH I don't think we want to take patches late=
r just to update
> >> the comment if more models show up.
> >>
> >> I guess we could change the comment to:
> >>
> >>                 /* Asus Vivobook Go E1404GA / E1404GAB */
> >>
> >> Rafael any preference from you here ?   (1)
> >
> > Not really.
>
> Ok, then my vote goes to keeping this as is. So if you're happy
> with this series please merge it as is.

Now queued up as 6.12-rc2 material, thanks!

