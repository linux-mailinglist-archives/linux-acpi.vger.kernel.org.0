Return-Path: <linux-acpi+bounces-7541-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAC094F64A
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 20:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939451F228C7
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 18:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E9B1898E6;
	Mon, 12 Aug 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYUYq1f8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F92C156;
	Mon, 12 Aug 2024 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486182; cv=none; b=W50NI0va87ur3H8DCJexQsPlR6tBnkCx2uUpI8rcAKrvFIclIkwhboAHBe6iZlfqJq3mDNiEcc5LC0W3BiJwmZgD+NnH78AruvOYlMSYXeM1giEp6hfQcmcaRMPug0tMmxMDT5k566GmEQBS93J2GKwi2hav8Ntt/60H6JvwGvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486182; c=relaxed/simple;
	bh=9Nco/hon7rAdJ043GW2g5n9ph0McNClbMFtriB8yqw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vwc8V6rsUFhEfu/ONqum1WudqEWPhUOKxGAHkSBFI1P9f2VLTKHm4VwfhkGo/zSWOuihFpM6Bcdayo5yxRu6iq8BE6GMnZrIgP1D1aR8Ia//NUDmnmzpKQ4HzXpEAOlRfjnKAsitvmRHC1T8NaixZ6JI69oxGJELqWgcNi5QINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYUYq1f8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A07DC4AF0C;
	Mon, 12 Aug 2024 18:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723486181;
	bh=9Nco/hon7rAdJ043GW2g5n9ph0McNClbMFtriB8yqw8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lYUYq1f8ZFONKZn6is9q1aGTHS2vmpp0n9IZecczNC5PifTuYJstcqMe5NRzt/exn
	 Xu0KICf6gf6MZN9cuNE9FX3S3XtBPPoCF0bZdZwkUlGu28S8zKFHGywa21cY0f9Qwy
	 T1nEephdq8vvfsvI9OUJUeufwQvd911Favc+eqEYjIEgR0wCBCP7WN+zAw9zjIgFkC
	 AYg/M9PwQciSx0TbIocy5HLYnEbt3IuheOX6AKDh8ku3ePDXpD706JIqa14JORpOyg
	 snDHjlSVlJIwxiaGM7v3HKWLRH1PzU8zYUnsbHoocMNUoe6pCnL+YTHRfxEPCTqtY4
	 hQBmg7bluZ+gg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2610c095ea1so539655fac.3;
        Mon, 12 Aug 2024 11:09:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdWtTUBmGCsjFUDI9Wo3v6SyJvM6zKfYsaMAOfm7EWYAcmyBa6jlqjI/KA7fYT2r/ndORjD8NQ+4Z0y9gP@vger.kernel.org, AJvYcCVZ+llPijb8Ko0caGbynp77FPGO9bL8QgcIWHYqxEZeTlWpEwQhMqGBEPOWTEpXC1cA9BipYONKmZo=@vger.kernel.org, AJvYcCVy1R1LUtmZtt0rPHN8k9a0fbebUxHSF2akcqm5mYlw5+NAbzBgyMBG6GLd/MUksMp9JIh+ADhLlTQcu7l3M2//UrTGqQ==@vger.kernel.org, AJvYcCW6aIpRrNPr3C0G9SV5CZfUnbN1hTZKxkDzGyAA4X1IVySzzgU6Hda+OZ1y5v5sIXzKamCgBK3hgDU9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Jk2KYh5Ro+s8+0D0lG3bXx+/nuEHXwRiD5qeMnXDO09hFK3j
	DjsO76Fz8EPXLbcdYXMNSKW7aXWNQdeWHmkCffx4M6khY+5p4QVnaHEG/J67TIgiZcLi1/YVz+J
	UxeFPKkRTVHDwvrEAGjxTT1odnY4=
X-Google-Smtp-Source: AGHT+IGhuD2uyvm5vH1uhawUMhuNtW24WtkX8uoFgGppHZT9jczvg8wzgtAS05nMQfFeOK/8wn+xlni6fNotQhGs79w=
X-Received: by 2002:a05:6871:3a22:b0:260:f1c4:2fe0 with SMTP id
 586e51a60fabf-26fcb91e745mr550967fac.10.1723486180715; Mon, 12 Aug 2024
 11:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1922131.tdWV9SEqCh@rjwysocki.net> <2242500.C4sosBPzcN@rjwysocki.net>
 <a0c639d1-4f21-47f1-bb66-92f185e828a9@gmail.com> <CAJZ5v0jDQLJWGCj73DXQe3+k+Zaq9Z71LJbFSvRjcuE85+J+mQ@mail.gmail.com>
 <1bfbbae5-42b0-4c7d-9544-e98855715294@piie.net> <CAJZ5v0h7WaBVhgvbxz1W1YX9TSY-awKJMsLm2NPkmCBsf3y0BA@mail.gmail.com>
 <CAJZ5v0jhkWXPDpQvS+sCeSsDNsSRX3NHk0nEg+MsJ=EiUR4Rgw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jhkWXPDpQvS+sCeSsDNsSRX3NHk0nEg+MsJ=EiUR4Rgw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Aug 2024 20:09:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ji_7Z-24iCO_Xxu4Zm4jgVFmR9jVp8QNiCOxzV9gqSnA@mail.gmail.com>
Message-ID: <CAJZ5v0ji_7Z-24iCO_Xxu4Zm4jgVFmR9jVp8QNiCOxzV9gqSnA@mail.gmail.com>
Subject: Re: [PATCH v1 12/17] platform/x86: acerhdf: Use the .should_bind()
 thermal zone callback
To: =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, platform-driver-x86@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000093dc97061f806562"

--00000000000093dc97061f806562
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Mon, Aug 12, 2024 at 6:15=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Aug 12, 2024 at 4:56=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Tue, Aug 6, 2024 at 12:10=E2=80=AFAM Peter K=C3=A4stle <peter@piie.n=
et> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On 01.08.24 12:14, Rafael J. Wysocki wrote:
> > > > Hi Peter,
> > > >
> > > > On Wed, Jul 31, 2024 at 10:50=E2=80=AFPM Peter K=C3=A4stle <xypiie@=
gmail.com> wrote:
> > > >>
> > > >> Hi Rafael,
> > > >>
> > > >> On 30.07.24 20:33, Rafael J. Wysocki wrote:
> > > >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >>>
> > > >>> Make the acerhdf driver use the .should_bind() thermal zone
> > > >>> callback to provide the thermal core with the information on whet=
her or
> > > >>> not to bind the given cooling device to the given trip point in t=
he
> > > >>> given thermal zone.  If it returns 'true', the thermal core will =
bind
> > > >>> the cooling device to the trip and the corresponding unbinding wi=
ll be
> > > >>> taken care of automatically by the core on the removal of the inv=
olved
> > > >>> thermal zone or cooling device.
> > > >>>
> > > >>> The previously existing acerhdf_bind() function bound cooling dev=
ices
> > > >>> to thermal trip point 0 only, so the new callback needs to return=
 'true'
> > > >>> for trip point 0.  However, it is straightforward to observe that=
 trip
> > > >>> point 0 is an active trip point and the only other trip point in =
the
> > > >>> driver's thermal zone is a critical one, so it is sufficient to r=
eturn
> > > >>> 'true' from that callback if the type of the given trip point is
> > > >>> THERMAL_TRIP_ACTIVE.
> > > >>>
> > > >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >>
> > > >> Thanks for including me on the review.
> > > >> I'm working on it, but unfortunately the refactoring of the therma=
l layer
> > > >> around gov_bang_bang.c earlier this year broke acerhdf.
> > > >
> > > > Well, sorry about that.
> > >
> > > I already fixed the main problem, which caused full malfunction of ac=
erhdf:
> > >
> > > The new functionality of .trip_crossed in the gov_bang_bang is missin=
g an
> > > initial check, whether the temperature is below the fanoff temperatur=
e
> > > (trip_point.temperature - hysteresis) and by that it did not turn the
> > > fan off.
> >
> > So IIUC this is when the fan starts in the "on" state and the thermal
> > core is expected to turn it off when the zone temperature is not in
> > fact above the trip point low temperature.
> >
> > > This then caused that the system will never heat up as much to
> > > cross the upper temperature. As a consequence it could never cross th=
e
> > > lower temperature to turn the fan off. -> Fan was locked always on.
> > > And that's obviously not what we want.
> >
> > Sure.
> >
> > > As I didn't find any API call, to ask the governor doing that for me,=
 I
> > > added an "acerhdf_init_fan()" functionality into acerhdf init functio=
n right
> > > after registering the thermal zone (and on resume from suspend) which=
 turns
> > > the fan off if the temperature is lower than the fanoff parameter.
> > > Probably not the nicest solution, but maybe the most pragmatic one wi=
thout
> > > touching the thermal layer.
> >
> > Well, this issue may not be limited to the acerhdf case, so it may be
> > good to address it in the thermal core.  There is kind of a
> > chicken-and-egg situation in there, however, because the cooling
> > device state is determined by the governor which only runs when it is
> > called, but the core doesn't know that the governor should be invoked
> > when there are no trip point crossing events.
> >
> > It may just be a matter of adding an ->update_tz() callback to the
> > bang-bang governor, let me see.

This isn't the right approach because .update_tz() is called before
checking the zone temperature for the first time, but to remedy the
issue at hand, code needs to run when the zone temperature is known to
the thermal core.

This means that the Bang-bang governor needs a .manage() callback in
addition to the .trip_crossed() one, but that callback will only need
to check if the states of cooling devices bound to the trip points
below the zone temperature need to be adjusted, and just once.

So something like in the attached patch.

--00000000000093dc97061f806562
Content-Type: text/x-patch; charset="US-ASCII"; name="thermal-gov_bang_bang-manage.patch"
Content-Disposition: attachment; 
	filename="thermal-gov_bang_bang-manage.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lzrattnx0>
X-Attachment-Id: f_lzrattnx0

LS0tCiBkcml2ZXJzL3RoZXJtYWwvZ292X2JhbmdfYmFuZy5jIHwgICA2NCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDkgaW5zZXJ0aW9u
cygrKSwgMTUgZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtcG0vZHJpdmVycy90aGVybWFsL2dv
dl9iYW5nX2JhbmcuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvdGhlcm1h
bC9nb3ZfYmFuZ19iYW5nLmMKKysrIGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC9nb3ZfYmFuZ19i
YW5nLmMKQEAgLTEzLDYgKzEzLDI4IEBACiAKICNpbmNsdWRlICJ0aGVybWFsX2NvcmUuaCIKIAor
c3RhdGljIHZvaWQgYmFuZ19iYW5nX3NldF9pbnN0YW5jZV90YXJnZXQoc3RydWN0IHRoZXJtYWxf
aW5zdGFuY2UgKmluc3RhbmNlLAorCQkJCQkgIHVuc2lnbmVkIGludCB0YXJnZXQpCit7CisJaWYg
KGluc3RhbmNlLT50YXJnZXQgIT0gMCAmJiBpbnN0YW5jZS0+dGFyZ2V0ICE9IDEgJiYKKwkgICAg
aW5zdGFuY2UtPnRhcmdldCAhPSBUSEVSTUFMX05PX1RBUkdFVCkKKwkJcHJfZGVidWcoIlVuZXhw
ZWN0ZWQgc3RhdGUgJWxkIG9mIHRoZXJtYWwgaW5zdGFuY2UgJXMgaW4gYmFuZy1iYW5nXG4iLAor
CQkJIGluc3RhbmNlLT50YXJnZXQsIGluc3RhbmNlLT5uYW1lKTsKKworCS8qCisJICogRW5hYmxl
IHRoZSBmYW4gd2hlbiB0aGUgdHJpcCBpcyBjcm9zc2VkIG9uIHRoZSB3YXkgdXAgYW5kIGRpc2Fi
bGUgaXQKKwkgKiB3aGVuIHRoZSB0cmlwIGlzIGNyb3NzZWQgb24gdGhlIHdheSBkb3duLgorCSAq
LworCWluc3RhbmNlLT50YXJnZXQgPSB0YXJnZXQ7CisJaW5zdGFuY2UtPmluaXRpYWxpemVkID0g
dHJ1ZTsKKworCWRldl9kYmcoJmluc3RhbmNlLT5jZGV2LT5kZXZpY2UsICJ0YXJnZXQ9JWxkXG4i
LCBpbnN0YW5jZS0+dGFyZ2V0KTsKKworCW11dGV4X2xvY2soJmluc3RhbmNlLT5jZGV2LT5sb2Nr
KTsKKwlpbnN0YW5jZS0+Y2Rldi0+dXBkYXRlZCA9IGZhbHNlOyAvKiBjZGV2IG5lZWRzIHVwZGF0
ZSAqLworCW11dGV4X3VubG9jaygmaW5zdGFuY2UtPmNkZXYtPmxvY2spOworfQorCiAvKioKICAq
IGJhbmdfYmFuZ19jb250cm9sIC0gY29udHJvbHMgZGV2aWNlcyBhc3NvY2lhdGVkIHdpdGggdGhl
IGdpdmVuIHpvbmUKICAqIEB0ejogdGhlcm1hbF96b25lX2RldmljZQpAQCAtNTQsMjUgKzc2LDM2
IEBAIHN0YXRpYyB2b2lkIGJhbmdfYmFuZ19jb250cm9sKHN0cnVjdCB0aGUKIAkJdHotPnRlbXBl
cmF0dXJlLCB0cmlwLT5oeXN0ZXJlc2lzKTsKIAogCWxpc3RfZm9yX2VhY2hfZW50cnkoaW5zdGFu
Y2UsICZ0ei0+dGhlcm1hbF9pbnN0YW5jZXMsIHR6X25vZGUpIHsKLQkJaWYgKGluc3RhbmNlLT50
cmlwICE9IHRyaXApCi0JCQljb250aW51ZTsKKwkJaWYgKGluc3RhbmNlLT50cmlwID09IHRyaXAp
CisJCQliYW5nX2Jhbmdfc2V0X2luc3RhbmNlX3RhcmdldChpbnN0YW5jZSwgY3Jvc3NlZF91cCk7
CisJfQorfQogCi0JCWlmIChpbnN0YW5jZS0+dGFyZ2V0ICE9IDAgJiYgaW5zdGFuY2UtPnRhcmdl
dCAhPSAxICYmCi0JCSAgICBpbnN0YW5jZS0+dGFyZ2V0ICE9IFRIRVJNQUxfTk9fVEFSR0VUKQot
CQkJcHJfZGVidWcoIlVuZXhwZWN0ZWQgc3RhdGUgJWxkIG9mIHRoZXJtYWwgaW5zdGFuY2UgJXMg
aW4gYmFuZy1iYW5nXG4iLAotCQkJCSBpbnN0YW5jZS0+dGFyZ2V0LCBpbnN0YW5jZS0+bmFtZSk7
Ci0KLQkJLyoKLQkJICogRW5hYmxlIHRoZSBmYW4gd2hlbiB0aGUgdHJpcCBpcyBjcm9zc2VkIG9u
IHRoZSB3YXkgdXAgYW5kCi0JCSAqIGRpc2FibGUgaXQgd2hlbiB0aGUgdHJpcCBpcyBjcm9zc2Vk
IG9uIHRoZSB3YXkgZG93bi4KLQkJICovCi0JCWluc3RhbmNlLT50YXJnZXQgPSBjcm9zc2VkX3Vw
OwotCi0JCWRldl9kYmcoJmluc3RhbmNlLT5jZGV2LT5kZXZpY2UsICJ0YXJnZXQ9JWxkXG4iLCBp
bnN0YW5jZS0+dGFyZ2V0KTsKLQotCQltdXRleF9sb2NrKCZpbnN0YW5jZS0+Y2Rldi0+bG9jayk7
Ci0JCWluc3RhbmNlLT5jZGV2LT51cGRhdGVkID0gZmFsc2U7IC8qIGNkZXYgbmVlZHMgdXBkYXRl
ICovCi0JCW11dGV4X3VubG9jaygmaW5zdGFuY2UtPmNkZXYtPmxvY2spOworc3RhdGljIHZvaWQg
YmFuZ19iYW5nX21hbmFnZShzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHopCit7CisJY29u
c3Qgc3RydWN0IHRoZXJtYWxfdHJpcF9kZXNjICp0ZDsKKwlzdHJ1Y3QgdGhlcm1hbF9pbnN0YW5j
ZSAqaW5zdGFuY2U7CisKKwlmb3JfZWFjaF90cmlwX2Rlc2ModHosIHRkKSB7CisJCWNvbnN0IHN0
cnVjdCB0aGVybWFsX3RyaXAgKnRyaXAgPSAmdGQtPnRyaXA7CisKKwkJaWYgKHR6LT50ZW1wZXJh
dHVyZSA+PSB0ZC0+dGhyZXNob2xkIHx8CisJCSAgICB0cmlwLT50ZW1wZXJhdHVyZSA9PSBUSEVS
TUFMX1RFTVBfSU5WQUxJRCB8fAorCQkgICAgdHJpcC0+dHlwZSA9PSBUSEVSTUFMX1RSSVBfQ1JJ
VElDQUwgfHwKKwkJICAgIHRyaXAtPnR5cGUgPT0gVEhFUk1BTF9UUklQX0hPVCkKKwkJCWNvbnRp
bnVlOworCisJCS8qCisJCSAqIElmIHRoZSBpbml0aWFsIGNvb2xpbmcgZGV2aWNlIHN0YXRlIGlz
ICJvbiIsIGJ1dCB0aGUgem9uZQorCQkgKiB0ZW1wZXJhdHVyZSBpcyBub3QgYWJvdmUgdGhlIHRy
aXAgcG9pbnQsIHRoZSBjb3JlIHdpbGwgbm90CisJCSAqIGNhbGwgYmFuZ19iYW5nX2NvbnRyb2wo
KSB1bnRpbCB0aGUgem9uZSB0ZW1wZXJhdHVyZSByZWFjaGVzCisJCSAqIHRoZSB0cmlwIHBvaW50
IHRlbXBlcmF0dXJlIHdoaWNoIG1heSBiZSBuZXZlci4gIEluIHRob3NlCisJCSAqIGNhc2VzLCBz
ZXQgdGhlIGluaXRpYWwgc3RhdGUgb2YgdGhlIGNvb2xpbmcgZGV2aWNlIHRvIDAuCisJCSAqLwor
CQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGluc3RhbmNlLCAmdHotPnRoZXJtYWxfaW5zdGFuY2VzLCB0
el9ub2RlKSB7CisJCQlpZiAoIWluc3RhbmNlLT5pbml0aWFsaXplZCAmJiBpbnN0YW5jZS0+dHJp
cCA9PSB0cmlwKQorCQkJCWJhbmdfYmFuZ19zZXRfaW5zdGFuY2VfdGFyZ2V0KGluc3RhbmNlLCAw
KTsKKwkJfQogCX0KIAogCWxpc3RfZm9yX2VhY2hfZW50cnkoaW5zdGFuY2UsICZ0ei0+dGhlcm1h
bF9pbnN0YW5jZXMsIHR6X25vZGUpCkBAIC04Miw1ICsxMTUsNiBAQCBzdGF0aWMgdm9pZCBiYW5n
X2JhbmdfY29udHJvbChzdHJ1Y3QgdGhlCiBzdGF0aWMgc3RydWN0IHRoZXJtYWxfZ292ZXJub3Ig
dGhlcm1hbF9nb3ZfYmFuZ19iYW5nID0gewogCS5uYW1lCQk9ICJiYW5nX2JhbmciLAogCS50cmlw
X2Nyb3NzZWQJPSBiYW5nX2JhbmdfY29udHJvbCwKKwkubWFuYWdlCQk9IGJhbmdfYmFuZ19tYW5h
Z2UsCiB9OwogVEhFUk1BTF9HT1ZFUk5PUl9ERUNMQVJFKHRoZXJtYWxfZ292X2JhbmdfYmFuZyk7
Cg==
--00000000000093dc97061f806562--

