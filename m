Return-Path: <linux-acpi+bounces-7530-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE8694EBD5
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 13:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1A61C20EBE
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 11:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12FA17108B;
	Mon, 12 Aug 2024 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYdYs8SD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0D1170A04
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462296; cv=none; b=rprr7R209rc7zkdVjvu26u1XhGUBasYjhNH+V4CVu5LofBiJ81ws9iEJnBy0JVXlYlAIU9FT3o6S2fzqaMqmMnrZoJYqhv9odgmMSdhqPb7xhEYVZ856Pl/ZfpfRbp0PXf4hC/6+O/+3R5B8J3d5IxTQAWwZHO5ZWKURiHeBE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462296; c=relaxed/simple;
	bh=X/49iYIS0346csl1lK2vb1CESUxgarkmQ9PZVsspBM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3B3hmktThI+s4i1zkcK3dawFY6qy6tXoccYbS1qC+akFfYVqzECkK3O6Ne7gvc8M2s0XYQfgMUZLp4HAsjmAFFX30OAHYQFTxi7zUFoAki1gOeNx5pjN79GtU4wD4uUnu3ACsat+Jyl7qMbtiLhoc5ArY9ZJANOK8QzmPeZim0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYdYs8SD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB485C32782
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 11:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723462296;
	bh=X/49iYIS0346csl1lK2vb1CESUxgarkmQ9PZVsspBM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cYdYs8SD5ZnMiwfQl6x/dsmPCIRJSLZsoX0C0hApkkbgmd+0V0EGnv9QSFDs3/nff
	 3ddE+ESKjlYOPXCQgSQbOVXpJsZzIZX7hmxrQJPxKqmcphQ0N7d/4DS29FCah/mUAY
	 j2SlrY9PWAOopPM7om9BOB52rld8U++QwsYlVkUX5jzDAE/Ysyncg6o4BjhIBE0+ZK
	 nk8TvWG2VLDe4X0cwqaNXXFjaqKCYfJbXQ+sHvDF5qpMntfDJA22EN3/vmGWgiY+7O
	 Kbrvy0dEJoeaWoR/YpUpesX8BUhLIiGsIBEoHZ1kxXjYwnyxsYoXWUqARxUXE6dblQ
	 8NOLmXrqO23/A==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5bb451631so235623eaf.2
        for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 04:31:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeqWgc6BNK5ZIJX6uGmjfZIwvDv/NvuPAm1w7u/B041czlHo208rjkwnpDCHrTFCI4UIhehGz4FF7hyAzP4GGWrKj3Cd+hFSsdyQ==
X-Gm-Message-State: AOJu0YwoWyW4TVXLd2POW8ykxkwQMenXkhigkcHsFCimtJ29iSCX/Eos
	HIYIbMSa5aIg4llDJe9HAh/QJTzPPbsnOaz4dnD+tVkUlL6Vs3FhXmH3/m6ia0Rn1Mp1S3M5KPI
	mhUC+AlTbdu/09KMPfeEPH4NMl78=
X-Google-Smtp-Source: AGHT+IFcAzigGFWEQd4vRFTnck26Fpakbky/T6gnL7XhGglhD3/jNzeL5YOP5RtCcS/bEGOubPCJ8puLg3XjRaHV+6M=
X-Received: by 2002:a4a:d0ca:0:b0:5d8:2c3:f9b4 with SMTP id
 006d021491bc7-5da6868f4eemr56239eaf.1.1723462295116; Mon, 12 Aug 2024
 04:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
 <c0e5414a-ec7b-44e3-980c-e71889150767@redhat.com> <0abc1a17-e155-4587-ada9-13f9ce5f358b@redhat.com>
 <1a426f61-1454-4a77-8262-612ab1d0d265@redhat.com> <CAJZ5v0iWy6oXRJ2mxhOLyWsmgp1akVjoo0i2pqDDMOg-TvWLPA@mail.gmail.com>
 <a0f54ea3-5830-4420-b4e7-73ea8c146bcd@redhat.com>
In-Reply-To: <a0f54ea3-5830-4420-b4e7-73ea8c146bcd@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Aug 2024 13:31:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jkFrHSVE-FMaYXewYHNBpYMoBYAuJNaMLTXyUPg-HzSQ@mail.gmail.com>
Message-ID: <CAJZ5v0jkFrHSVE-FMaYXewYHNBpYMoBYAuJNaMLTXyUPg-HzSQ@mail.gmail.com>
Subject: Re: "EC: Install address space handler at the namespace root" causing
 issues for some users
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:28=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 8/8/24 7:22 PM, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Mon, Aug 5, 2024 at 2:47=E2=80=AFPM Hans de Goede <hdegoede@redhat.c=
om> wrote:
> >>
> >> Hi,
> >>
> >> On 8/5/24 1:28 PM, Hans de Goede wrote:
> >>> Hi,
> >>>
> >>> On 8/1/24 4:28 PM, Hans de Goede wrote:
> >>>> Hi,
> >>>>
> >>>> On 7/29/24 1:15 PM, Hans de Goede wrote:
> >>>>> Hi Rafael,
> >>>>>
> >>>>> There are 2 bug reports:
> >>>>>
> >>>>> 1. Brightness up/down key-presses no longer working on LG laptop (a=
cpi-video related):
> >>>>> https://lists.fedoraproject.org/archives/list/devel@lists.fedorapro=
ject.org/thread/V2KWAGZIAX4TOWPCH6A6FSIT66PR3KMZ/
> >>>>
> >>>> I have filed:
> >>>>
> >>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D2302253
> >>>>
> >>>> to track this now and an acpidump of the troublesome LG laptop
> >>>> is attached there. I have also requested dmesg output of
> >>>> a non working kernel to be attached there.
> >>>>
> >>>> As a reminder this is the bug where it has been confirmed that
> >>>> reverting "EC: Install address space handler at the namespace root"
> >>>> helps, with the caveat that there is a Thunderbolt related IRQ
> >>>> storm on the ACPI event IRQ after the revert ...
> >>>
> >>> Ok, so the bugzilla now has 2 different dmesg outputs:
> >>>
> >>> 1. 6.9.6, this kernel works without problems
> >>>
> >>> 2. 6.9.12 with the following patch you suggested on top:
> >>>
> >>> --- a/drivers/acpi/ec.c
> >>> +++ b/drivers/acpi/ec.c
> >>> @@ -1788,7 +1788,7 @@ void __init acpi_ec_dsdt_probe(void)
> >>>        * At this point, the GPE is not fully initialized, so do not t=
o
> >>>        * handle the events.
> >>>        */
> >>> -     ret =3D acpi_ec_setup(ec, NULL, true);
> >>> +     ret =3D acpi_ec_setup(ec, NULL, false);
> >>>       if (ret) {
> >>>               acpi_ec_free(ec);
> >>>               return;
> >>>
> >>> Unfortunately this does not help. dmesg shows some EC _REG errors, wh=
ich
> >>> are now (with the above diff applied) shown just before the
> >>> "Boot DSDT EC initialization complete" message, which shows that _REG=
 now
> >>> runs from acpi_ec_add() rather then before:
> >>>
> >>> [    1.007566] ACPI BIOS Error (bug): Could not resolve symbol [\_TZ.=
FN00._OFF], AE_NOT_FOUND (20230628/psargs-330)
> >>> [    1.007576] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.EREG d=
ue to previous error (AE_NOT_FOUND) (20230628/psparse-52
> >>> [    1.007580] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC._REG d=
ue to previous error (AE_NOT_FOUND) (20230628/psparse-52
> >>> [    1.007639] ACPI: EC: interrupt unblocked
> >>> [    1.007640] ACPI: EC: event unblocked
> >>> [    1.007675] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
> >>> [    1.007676] ACPI: EC: GPE=3D0x6e
> >>> [    1.007677] ACPI: \_SB_.PC00.LPCB.LGEC: Boot DSDT EC initializatio=
n complete
> >>> [    1.007679] ACPI: \_SB_.PC00.LPCB.LGEC: EC: Used to handle transac=
tions and events
> >>>
> >>> Note that the errors are from calling _REG on \_SB.PC00.LPCB.H_EC, wh=
ere as the actual
> >>> EC (and the only acpi_device on which _REG would get called for the E=
C Opregion before) is:
> >>> \_SB_.PC00.LPCB.LGEC.
> >>>
> >>> Looking at the DSDT it seems that the H_EC is not used and is leftove=
r from a copy/paste
> >>> from some reference design DSDT. Its _REG however does write to the E=
C before hitting the error
> >>> and I think that that write may be causing the issue...
> >>>
> >>> The H_EC device does have an _STA method and looking closer the troub=
lesome EREG method is
> >>> also called from _INI. So I guess that _STA is returning 0 causing _I=
NI to not run and
> >>> that is the reason why we are not seeing the same EREG errors with ke=
rnel 6.9.6 where _REG is
> >>> only called for the EC opregion on \_SB_.PC00.LPCB.LGEC and not for t=
he entire ACPI device
> >>> hierarchy as is done with >=3D 6.9.7 .
> >>>
> >>> Maybe we should only call _REG for the EC opregion on present devices=
 (and devices without
> >>> a _STA)?
> >>>
> >>> Also note that both LGEC and H_EC use the same cmd + data ports.
> >>>
> >>> I'll go and ask the reporter to retrieve the status of both LGEC and =
H_EC and then see
> >>> from there.
> >>
> >> The reporter has confirmed that of the 2 EC devices ( H_EC / LGEC ) on=
ly LGEC returns
> >> a _STA of non 0:
> >>
> >>> Here it is, with kernel 6.9.6:
> >>>
> >>> $ cat /sys/bus/acpi/devices/PNP0C09\:00/path
> >>> \_SB_.PC00.LPCB.H_EC
> >>> $ cat /sys/bus/acpi/devices/PNP0C09\:00/status
> >>> 0
> >>> $ cat /sys/bus/acpi/devices/PNP0C09\:01/path
> >>> \_SB_.PC00.LPCB.LGEC
> >>> $ cat /sys/bus/acpi/devices/PNP0C09\:01/status
> >>> 15
> >>
> >> And taking a second look at the other bug:
> >> https://bugzilla.redhat.com/show_bug.cgi?id=3D2298938
> >>
> >> That one also has 2 EC ACPI devices and the errors come from calling _=
REG on the one
> >> which is not picked as the boot_ec :
> >>
> >> jul 19 17:33:41 kernel: ACPI: EC: EC started
> >> jul 19 17:33:41 kernel: ACPI: EC: interrupt blocked
> >> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.H_E=
C.ECMD due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> >> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_TZ.FNCL due to p=
revious error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> >> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_TZ.FN00._OFF due=
 to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> >> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.H_E=
C._REG due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> >> jul 19 17:33:41 kernel: ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
> >> jul 19 17:33:41 kernel: ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used =
to handle transactions
> >>
> >> Note the H_EC vs EC0_ in the errors vs the "Boot DSDT EC used to
> >> handle transactions" message.
> >>
> >> So the issue in both cases seems to be calling _REG on an unused EC ac=
pi_device.
> >> Not sure how to best fix this though ...
> >
> > I have created an experimental acpi-ec-fixes branch:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log=
/?h=3Dacpi-ec-fixes
> >
> > for this which illustrates my idea (untested so far).
>
> Thank you. I believe that the approach taken here is good and I also
> like the code (of the current version) so you may add my:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> to all 3 patches.
>
> I have started a test Fedora 40 6.10.4 kernel build with the patches from
> the acpi-ec-fixes branch added:
>
> https://koji.fedoraproject.org/koji/taskinfo?taskID=3D121834209
>
> and I have asked the reporters of both bugs:
>
>     2298938 - Multiple ACPI errors resulting in incorrect thermal reading=
s and misleading CPU
>     2302253 - ACPI: EC: LG gram laptop brightness keys stop working with =
kernel >=3D 6.9.7
>
> to test this. I expect a good turn around time from the reporter
> of bug 2302253. So far the reporter of 2298938 is not really
> responsive (holidays?).

Thank you!

I'll send the patches to the list later today.

