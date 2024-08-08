Return-Path: <linux-acpi+bounces-7448-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3545094C398
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 19:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585AB1C21A2A
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681571917C4;
	Thu,  8 Aug 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXsSUWV5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434D191466
	for <linux-acpi@vger.kernel.org>; Thu,  8 Aug 2024 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137792; cv=none; b=MpVQesG6qASAGUjB2hjw4sbnds320HjFbrE3PNk6ygEsuPmpeNCDneotOj8IyEDXozH89Okg1TlSH1g3Gw07/I2hOtMX2YzNijrN0XX0Y71+oDBevjArZg0apX5AGS/oyyxr0ULlLUcQCyXmnJXjZJQ0l17e/mgMcQJkeSMo2I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137792; c=relaxed/simple;
	bh=A7fsvuhow4T7hZcrQYpNcDiXV/1pt0IjkLl5tmM+33A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYYX0vjXIsFgUXZuQ8oCA6i7v2ocSGD6r5Z2Vq9KbB7kD6NMMU7Z+bCb2pn/t1zELZg9P5LGGuVe92D0iZP+HiRvQuCVYCJOIUvI6YmkTBj3YSSF2kBV375rtK1o7aWRuG1ems8wGpjnnBH5sNuW/Q04Z9p44n/XZu6fyD6mtS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXsSUWV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D47C4AF12
	for <linux-acpi@vger.kernel.org>; Thu,  8 Aug 2024 17:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723137791;
	bh=A7fsvuhow4T7hZcrQYpNcDiXV/1pt0IjkLl5tmM+33A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BXsSUWV5z/JDIyToe2xTB22AgRa1DdJGFiuji7u7AfbyMpQMzKQcIaR5Z4VDurW/f
	 A9u/N8fnkR1ywYIs5gWzE1sUMqE2Z/L3814itkEUk8qelbHBDZvpH8HRf8VgATx46z
	 6xDPbJj/H4sjv+0dMMCZJUBR61VLk6i5UqUCd4X2+J7K2t5oKSq58jCmb18eFKZagJ
	 4RhTeHAwPODKqGBj09vjHHvnBZg6pzTJwJe6u7h2RWOpStMN2ZXfBBvtTGxVFTbYzj
	 AMlXt6qqJkT4Hl3Ep1ndcdcbVQ5Ve6QTgVU7nlm6BqOpch6sEkHGHniMwkCbMJ+Q9V
	 V/2B1LxQvX4Bw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5d5bafd2c42so59432eaf.2
        for <linux-acpi@vger.kernel.org>; Thu, 08 Aug 2024 10:23:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfWvInhM4jiI0D3XDsz48SBpZbMp4GImNBnGkvfwHTIVd2YnjtIJOKPE+XfhtowR3Uyxb11jdn9Q+jYrV8qUh53Wlpovc7nzrEaA==
X-Gm-Message-State: AOJu0YyQ0Myg78dQw9qvn+oOWDi8L4C0VoHAn2jCmtLacPFfBKHfi/tj
	kPG7PxJ9vGFLegEvzhPmpWn5PxbqY1NLTMXkH3xePYl6MLxtHMeDCMv8gW70E7SwTDiX77lBNx9
	0GBBP4RtsL7YIrKgi0yWHEjqR+lc=
X-Google-Smtp-Source: AGHT+IEoNKWNOD7v7jZz4vxbSUKYabNjKq2vXds40bWsAE2L7ytMJqBHISt7MMdl0yaF/kfl5NHzlaK5g8vkynrUQng=
X-Received: by 2002:a4a:a787:0:b0:5c7:b587:40a7 with SMTP id
 006d021491bc7-5d855afd7bemr1731456eaf.1.1723137791000; Thu, 08 Aug 2024
 10:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
 <c0e5414a-ec7b-44e3-980c-e71889150767@redhat.com> <0abc1a17-e155-4587-ada9-13f9ce5f358b@redhat.com>
 <1a426f61-1454-4a77-8262-612ab1d0d265@redhat.com>
In-Reply-To: <1a426f61-1454-4a77-8262-612ab1d0d265@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Aug 2024 19:22:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iWy6oXRJ2mxhOLyWsmgp1akVjoo0i2pqDDMOg-TvWLPA@mail.gmail.com>
Message-ID: <CAJZ5v0iWy6oXRJ2mxhOLyWsmgp1akVjoo0i2pqDDMOg-TvWLPA@mail.gmail.com>
Subject: Re: "EC: Install address space handler at the namespace root" causing
 issues for some users
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 5, 2024 at 2:47=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi,
>
> On 8/5/24 1:28 PM, Hans de Goede wrote:
> > Hi,
> >
> > On 8/1/24 4:28 PM, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 7/29/24 1:15 PM, Hans de Goede wrote:
> >>> Hi Rafael,
> >>>
> >>> There are 2 bug reports:
> >>>
> >>> 1. Brightness up/down key-presses no longer working on LG laptop (acp=
i-video related):
> >>> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproje=
ct.org/thread/V2KWAGZIAX4TOWPCH6A6FSIT66PR3KMZ/
> >>
> >> I have filed:
> >>
> >> https://bugzilla.redhat.com/show_bug.cgi?id=3D2302253
> >>
> >> to track this now and an acpidump of the troublesome LG laptop
> >> is attached there. I have also requested dmesg output of
> >> a non working kernel to be attached there.
> >>
> >> As a reminder this is the bug where it has been confirmed that
> >> reverting "EC: Install address space handler at the namespace root"
> >> helps, with the caveat that there is a Thunderbolt related IRQ
> >> storm on the ACPI event IRQ after the revert ...
> >
> > Ok, so the bugzilla now has 2 different dmesg outputs:
> >
> > 1. 6.9.6, this kernel works without problems
> >
> > 2. 6.9.12 with the following patch you suggested on top:
> >
> > --- a/drivers/acpi/ec.c
> > +++ b/drivers/acpi/ec.c
> > @@ -1788,7 +1788,7 @@ void __init acpi_ec_dsdt_probe(void)
> >        * At this point, the GPE is not fully initialized, so do not to
> >        * handle the events.
> >        */
> > -     ret =3D acpi_ec_setup(ec, NULL, true);
> > +     ret =3D acpi_ec_setup(ec, NULL, false);
> >       if (ret) {
> >               acpi_ec_free(ec);
> >               return;
> >
> > Unfortunately this does not help. dmesg shows some EC _REG errors, whic=
h
> > are now (with the above diff applied) shown just before the
> > "Boot DSDT EC initialization complete" message, which shows that _REG n=
ow
> > runs from acpi_ec_add() rather then before:
> >
> > [    1.007566] ACPI BIOS Error (bug): Could not resolve symbol [\_TZ.FN=
00._OFF], AE_NOT_FOUND (20230628/psargs-330)
> > [    1.007576] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.EREG due=
 to previous error (AE_NOT_FOUND) (20230628/psparse-52
> > [    1.007580] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC._REG due=
 to previous error (AE_NOT_FOUND) (20230628/psparse-52
> > [    1.007639] ACPI: EC: interrupt unblocked
> > [    1.007640] ACPI: EC: event unblocked
> > [    1.007675] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
> > [    1.007676] ACPI: EC: GPE=3D0x6e
> > [    1.007677] ACPI: \_SB_.PC00.LPCB.LGEC: Boot DSDT EC initialization =
complete
> > [    1.007679] ACPI: \_SB_.PC00.LPCB.LGEC: EC: Used to handle transacti=
ons and events
> >
> > Note that the errors are from calling _REG on \_SB.PC00.LPCB.H_EC, wher=
e as the actual
> > EC (and the only acpi_device on which _REG would get called for the EC =
Opregion before) is:
> > \_SB_.PC00.LPCB.LGEC.
> >
> > Looking at the DSDT it seems that the H_EC is not used and is leftover =
from a copy/paste
> > from some reference design DSDT. Its _REG however does write to the EC =
before hitting the error
> > and I think that that write may be causing the issue...
> >
> > The H_EC device does have an _STA method and looking closer the trouble=
some EREG method is
> > also called from _INI. So I guess that _STA is returning 0 causing _INI=
 to not run and
> > that is the reason why we are not seeing the same EREG errors with kern=
el 6.9.6 where _REG is
> > only called for the EC opregion on \_SB_.PC00.LPCB.LGEC and not for the=
 entire ACPI device
> > hierarchy as is done with >=3D 6.9.7 .
> >
> > Maybe we should only call _REG for the EC opregion on present devices (=
and devices without
> > a _STA)?
> >
> > Also note that both LGEC and H_EC use the same cmd + data ports.
> >
> > I'll go and ask the reporter to retrieve the status of both LGEC and H_=
EC and then see
> > from there.
>
> The reporter has confirmed that of the 2 EC devices ( H_EC / LGEC ) only =
LGEC returns
> a _STA of non 0:
>
> > Here it is, with kernel 6.9.6:
> >
> > $ cat /sys/bus/acpi/devices/PNP0C09\:00/path
> > \_SB_.PC00.LPCB.H_EC
> > $ cat /sys/bus/acpi/devices/PNP0C09\:00/status
> > 0
> > $ cat /sys/bus/acpi/devices/PNP0C09\:01/path
> > \_SB_.PC00.LPCB.LGEC
> > $ cat /sys/bus/acpi/devices/PNP0C09\:01/status
> > 15
>
> And taking a second look at the other bug:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2298938
>
> That one also has 2 EC ACPI devices and the errors come from calling _REG=
 on the one
> which is not picked as the boot_ec :
>
> jul 19 17:33:41 kernel: ACPI: EC: EC started
> jul 19 17:33:41 kernel: ACPI: EC: interrupt blocked
> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.H_EC.E=
CMD due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_TZ.FNCL due to prev=
ious error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_TZ.FN00._OFF due to=
 previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.H_EC._=
REG due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> jul 19 17:33:41 kernel: ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
> jul 19 17:33:41 kernel: ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to =
handle transactions
>
> Note the H_EC vs EC0_ in the errors vs the "Boot DSDT EC used to
> handle transactions" message.
>
> So the issue in both cases seems to be calling _REG on an unused EC acpi_=
device.
> Not sure how to best fix this though ...

I have created an experimental acpi-ec-fixes branch:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=
=3Dacpi-ec-fixes

for this which illustrates my idea (untested so far).

The underlying observation is that _REG only needs to be evaluated for
EC operation regions located in the scopes of ACPI device objects
representing valid devices, so it is better to do it for each of these
objects individually in acpi_bus_attach().

For the EC itself, it is better to do what was done before the
$subject commit, so evaluate _REG for the EC operation regions in the
EC scope (including the "orphan" _REG).

Accordingly, commit 0e6b6dedf168 ("Revert "ACPI: EC: Evaluate orphan
_REG under EC device") is reverted, acpi_execute_reg_methods() is
modified to take an additional depth argument and it is called for
each device object representing a valid device with that argument
equal to 1.

