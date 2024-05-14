Return-Path: <linux-acpi+bounces-5805-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 014858C5BBE
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 21:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C4628236F
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECAC180A6C;
	Tue, 14 May 2024 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omaIkWh3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B31E4B3;
	Tue, 14 May 2024 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715715662; cv=none; b=HFeOSzivJPkTB4UtLOD+dOwYVCX+Oam1oKPwokn9xtL5UKlEpDacyrAsAauYZZwn6BWbITqLdr0OojFuEcUJizmwzbe5AOH8JU+ov64uvVraorWxTD/nAvs8mLBqIlwZYdfX6hV/gEkHqsVJ4FxzRkc8vkhdIGR4k01t4Dy0dTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715715662; c=relaxed/simple;
	bh=j+cUGMP5kQgyzZQMeS0V8yHYwX7kfAWF9rEuq7DXtwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/REVIrMX2gdi/wSyWQV1ASUkJWOkVXuqeHpcjNzZ17WAKyMm/FV7nyvcBM9SddcKv9acRprVu6MAW/MfNEF99g0/5HxXeMbJA1kBwQYd11MAg9bCVV4uf4Ox8cjDpJQZkMukptuxDPwIqfh8BsPaigq+3KgjkvXIMD/MB8azbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omaIkWh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F295C2BD10;
	Tue, 14 May 2024 19:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715715662;
	bh=j+cUGMP5kQgyzZQMeS0V8yHYwX7kfAWF9rEuq7DXtwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=omaIkWh31blQ1EPJRY+DZmqpwaQ3QRh1C9CCDxJE+0hW/EAX94M2pW8kYhq5CDP7h
	 HeWvW2v48FdAlRBE8l0NraPpkxXDeTIzk33Du9YrscOCbFxWBlClS2+wnDCyEus5x4
	 EYyS8K2eckzFsHuO/0DHQXq7CYShsNP78CEvxcGFb7aROwvM12AzeMKKh0vt/guKZT
	 CG8MrIqaH4EdiFtzVkTCO5uWLJD+dCyONWhtjyANOnHg58LUTaz2co40AmBM1G7M6t
	 1DozhpP/xmLlTe77uFWWuMDn16BOM23f3cLBEq5YVFwEJ4M+UisNCCTxkNSCftUu/m
	 9bAyZ+hZG+Xog==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b2dd35212fso311043eaf.3;
        Tue, 14 May 2024 12:41:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkr4WpXZQRfFS1g4LxOllWTZFYx1DFcIpSdEVv2UFd1lzxLWCwvboYukL0ZUxSuVlht/joh8QDnf/hQgsveCwYTr2Ofu/Xt3/0WBjpxXX4tVDz31xiC3kQ/S+bYN6LlY41G7tQBI4HBA==
X-Gm-Message-State: AOJu0Yw8TiFM5iMD7Pu+Kzke7tDbLeA3RFLAWF0olbR6iR1NOWo2QEug
	BNAiZbkLhJ8Ri1Y/Wy40M5OHabBFX8kw+EJxl5ZSKZ17v6QbDSMZkXLhz8uouZGWIRsUh2z7LhG
	CeHH6xymvCHquN6WUTfkYORDIwTI=
X-Google-Smtp-Source: AGHT+IGXo5FmbVNFSk/3E+cdx+qoRf1FqUPAbrGEeYodPgbnNJKYpP/GRVr/89T3kH7CcnQClqqp44P4aqupgGZAoGM=
X-Received: by 2002:a05:6870:2891:b0:229:e46d:763a with SMTP id
 586e51a60fabf-241722e009bmr17019816fac.0.1715715661334; Tue, 14 May 2024
 12:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5787281.DvuYhMxLoT@kreacher> <4926735.31r3eYUQgx@kreacher>
 <ac04c433-b0ac-4b82-b8eb-98ac16f872d8@gmx.de> <CAJZ5v0g_NjGHRvhm-N5vQFnOsqnxExSq99v8n_B_6ANoaCga0w@mail.gmail.com>
 <568291fc-fd79-4f08-9eb7-aed7f5a32345@gmx.de> <Zj5ZdcQeaTo9ImT4@smile.fi.intel.com>
 <22937f20-93fd-4ae2-a5cb-31e5a477ac37@gmx.de> <CAJZ5v0iC_DNTj38eCPywgG3v_pkOVOhY9itdgX09AJ7U3yRB4Q@mail.gmail.com>
 <0107bd7c-b4d5-40d3-9147-ed06e1c1f430@redhat.com>
In-Reply-To: <0107bd7c-b4d5-40d3-9147-ed06e1c1f430@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 May 2024 21:40:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gARWrS+x2EeWjYA2o3H7NkEtYE65C0DsSTGj0N=8uv-g@mail.gmail.com>
Message-ID: <CAJZ5v0gARWrS+x2EeWjYA2o3H7NkEtYE65C0DsSTGj0N=8uv-g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ACPI: EC: Install address space handler at the
 namespace root
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sat, May 11, 2024 at 4:22=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi Rafael, Armin, et. al.,
>
> On 5/10/24 8:00 PM, Rafael J. Wysocki wrote:
> > On Fri, May 10, 2024 at 7:39=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wro=
te:
> >>
> >> Am 10.05.24 um 19:29 schrieb Andy Shevchenko:
> >>
> >>> On Fri, May 10, 2024 at 06:52:41PM +0200, Armin Wolf wrote:
> >>>> Am 10.05.24 um 18:41 schrieb Rafael J. Wysocki:
> >>>>> On Fri, May 10, 2024 at 6:10=E2=80=AFPM Armin Wolf <W_Armin@gmx.de>=
 wrote:
> >>>>>> Am 10.05.24 um 16:03 schrieb Rafael J. Wysocki:
> >>>>>>
> >>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>>>
> >>>>>>> It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on L=
enovo
> >>>>>>> IdeaPad Pro 5 due to a missing address space handler for the EC a=
ddress
> >>>>>>> space:
> >>>>>>>
> >>>>>>>     ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [=
EmbeddedControl] (20230628/evregion-130)
> >>>>>>>
> >>>>>>> This happens because the EC driver only registers the EC address =
space
> >>>>>>> handler for operation regions defined in the EC device scope of t=
he
> >>>>>>> ACPI namespace while the operation region being accessed by the _=
DSM
> >>>>>>> in question is located beyond that scope.
> >>>>>>>
> >>>>>>> To address this, modify the ACPI EC driver to install the EC addr=
ess
> >>>>>>> space handler at the root of the ACPI namespace.
> >>>>>>>
> >>>>>>> Note that this change is consistent with some examples in the ACP=
I
> >>>>>>> specification in which EC operation regions located outside the E=
C
> >>>>>>> device scope are used (for example, see Section 9.17.15 in ACPI 6=
.5),
> >>>>>>> so the current behavior of the EC driver is arguably questionable=
.
> >>>>>> Hi,
> >>>>>>
> >>>>>> the patch itself looks good to me, but i wonder what happens if mu=
ltiple
> >>>>>> ACPI EC devices are present. How would we handle such a situation?
> >>>>> I'm wondering if this is a theoretical question or do you have any
> >>>>> existing or planned systems in mind?
> >>>>>
> >>>>> ec_read(), ec_write() and ec_transaction() use only the first EC th=
at
> >>>>> has been found anyway.
> >>>> Its a theoretical question, i do not know of any systems which have =
more than
> >>>> one ACPI EC device.
> >>> The specification is clear about this case in the "ACPI Embedded Cont=
roller
> >>> Interface Specification":
> >>>
> >>>   "The ACPI standard supports multiple embedded controllers in a syst=
em,
> >>>    each with its own resources. Each embedded controller has a flat
> >>>    byte-addressable I/O space, currently defined as 256 bytes."
> >>>
> >>> However, I haven't checked deeper, so it might be a leftover in the d=
ocumentation.
> >>>
> >>> The OperationRegion() has no reference to the EC (or in general, devi=
ce) which
> >>> we need to speak to. The only possibility to declare OpRegion() for t=
he second+
> >>> EC is to use vendor specific RegionSpace, AFAIU. So, even if ACPI spe=
cification
> >>> supports 2+ ECs, it doesn't support OpRegion():s for them under the s=
ame
> >>> RegionSpace.
> >>>
> >>> That said, the commit message might be extended to summarize this, bu=
t at
> >>> the same time I see no way how this series can break anything even in=
 2+ ECs
> >>> environments.
> >>
> >> Consider the following execution flow when the second EC probes:
> >>
> >> 1. acpi_install_address_space_handler_no_reg() fails with AE_ALREADY_E=
XISTS since the first EC
> >> has already installed a handler at ACPI_ROOT_OBJECT.
> >>
> >> 2. ec_install_handlers() fails with -ENODEV.
> >>
> >> 3. acpi_ec_setup() fails with -ENODEV.
> >>
> >> 4. acpi_ec_add() fails with -ENODEV.
> >>
> >> 5. Probe of seconds EC fails with -ENODEV.
> >>
> >> This might cause problems if the second EC is supposed to for example =
handle EC query events.
> >> Of course if we only support a single EC, then this situation cannot h=
appen.
> >
> > This is kind of moot though until a system with 2 ECs is available.
> > It is hard to say whether or not it is supported until it can be
> > tested.
>
> I do not believe that this is as theoretical as it sounds though.
> If the ECDT and the DSDT disagree on the EC-s command_addr or
> data_addr, then the check to re-use the boot_ec acpi_ec object
> (struct acpi_ec *boot_ec) in acpi_ec_add() around line 1644:
>
>                 if (boot_ec && ec->command_addr =3D=3D boot_ec->command_a=
ddr &&
>                     ec->data_addr =3D=3D boot_ec->data_addr) {
>
> will fail and the separately allocated acpi_ec which "ec" points to at th=
is
> point will be kept around (rather then free-ed and replaced with the boot=
_ec).

Good point.

> And then when the below line runs on the newly allocated ec:
>
>         ret =3D acpi_ec_setup(ec, device, true);
>
> the newly allocated ec obj does not have EC_FLAGS_EC_HANDLER_INSTALLED se=
t in
> ec->flags so this acpi_ec_setup() call will call
>
>                status =3D acpi_install_address_space_handler_no_reg(ec->h=
andle,
>                                                                   ACPI_AD=
R_SPACE_EC,
>                                                                   &acpi_e=
c_space_handler,
>                                                                   NULL, e=
c);
>
> A second time. Now the above is from the old code and if we currently hit=
 this
> then the boot_ec acpi_install_address_space_handler_no_reg() call will ha=
ve been
> done with:
>
>         ec->handle =3D ACPI_ROOT_OBJECT
>
> and the second call for the not boot_ec matching DSDT EC will use the han=
dle from
> the DSDT EC.

If I'm not mistaken, this can be addressed by using ACPI_ROOT_OBJECT
to install the EC address space handler for first_ec only and
ec->handler for the other EC devices found in the ACPI namespace.

This actually is the case when ECDT is present and so (for consistency
and to address the issue leading to the $subject patch) it can be done
when there's no ECDT either.

Note that first_ec is only set once and never cleared (it would be
cleared during the EC driver removal if it were not equal to boot_ec,
but the latter is always the case AFAICS), so there can be only one ec
object with the address equal to first_ec.

> Given how much quirks we have to deal with ECDT vs DSDT EC mismatches I'm=
 pretty sure
> that there is hw out there were we hit this path and atm we essentially t=
reat that
> as 2 ECs routing any OpRegion calls outside of the scope of the DSDT EC h=
andle
> to the boot_ec object and OpRegion calls any under the scope of the DSDT =
EC handle
> to the regular "ec" object allocated in acpi_ec_add()
>
> For such buggy hardware the old behavior can be preserved by passing whic=
h handle
> to use for the acpi_install_address_space_handler_no_reg() call to acpi_e=
c_setup()
> and pass ec->handle, rather then ACPI_ROOT_OBJECT when not re-using
> the boot_ec in acpi_ec_add().
>
> I think preserving the old behavior when we hit such buggy hw is the best=
 thing
> to do here. While at it we should probably also start logging a warning w=
hen
> we hit this code path.

Yes, that would be useful IMV.

> This does mean that we also need to keep acpi_ec.address_space_handler_ho=
lder
> around for when unregistering the opregion handler.

Well, see above.

Thanks!

