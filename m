Return-Path: <linux-acpi+bounces-7538-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2178194F341
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 18:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CE4B26B71
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 16:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECD1186E47;
	Mon, 12 Aug 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlihnudZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C4178CE4;
	Mon, 12 Aug 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479331; cv=none; b=CneO0CLJO6/wql+IJ1bs7gW5O7WoYJ6LzIGDXROX1jrYDgsIQmW1p8DG662hcyQXSv9/ifEVIT7lPX0fqoFQ4z5iQm6TR5d5HQ79HKnPSWJWDhEahxIXmiVuYf4emZA4p3NHTzWDy1jvarKOZJj3Ow1JT7ammoLwXdDQBuXtUUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479331; c=relaxed/simple;
	bh=FXU/8xpGS7N7Ct6IUeq+sFomUk74NPVC6PhpukgJwRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWefSe5C8Go7OPsSLin/hvpsg71FACbqoMjwZFcI3WA8I/sgGCvEqnfJ1hF0QWnpk467aBOwpySV8NscE5ASQEuBM3gvzy65ZxeGFE5NENUh9p5B4ISRBd73gqhKI88zAG93B1hQPbXzPb6A/q4QgT0VWYk5C9eHF6GbZOoGufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlihnudZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5847AC4AF13;
	Mon, 12 Aug 2024 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723479331;
	bh=FXU/8xpGS7N7Ct6IUeq+sFomUk74NPVC6PhpukgJwRk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KlihnudZuTv9cpXfe96eNKfVEPmOng45vkObG30ml52F3E5KOp/CBVNT1QN+gQUpa
	 FC/TuEpGnN6uPMBbIJ/EFC0QAQZvths2NthxZhlYCHszACIWSBSd9kUlLrNsT0Vnpt
	 rUnxAvMq7KfdBY3sPQCNlZJXqyzUKA4Y7octlwfDrvuCXFwWPdPdO2LIfVkpOuTXqZ
	 CR0JIFQGvPhHUVK/3jOcFUxhG4vwu8Sk7cofmEDUvHzrJf6+ExuNpu0h9+JXAE4nbv
	 T6UtHIU1+F1L0VRy7dQKkduT0gnpZuQd78hoNz/SSAmPjn3mWmIok1/Me7XBAuN3Vx
	 oXhgYk0+DUo7A==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2610c095ea1so523438fac.3;
        Mon, 12 Aug 2024 09:15:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEHvS6F97iy0Ldru2b/AHUpHqfsh0Qe59nENhvrMG9zPsjB8JSMYbNfkKTWnq0Hae44ANY0/i33fVbSxkYV3fS3xeXSQ==@vger.kernel.org, AJvYcCVJ0snLdxdX0ojuqgtM8QFN00vbKZLCvmwOsz6BScM1mbMsNr/tQWOFSiseBOFnul4jykePzNlHaNp34jY9@vger.kernel.org, AJvYcCVPRFHPffWIkJgOKHeNZ0By3PwSl1TUsfr15tmuiS+sDyzwzktZjIGKqOv6HlxMrsFiFpcIh9OCERI=@vger.kernel.org, AJvYcCWBYBSYSKbaiBcX/Js7mTfDEaB5w9OCC/OCT9AaAzA0qWwW04b+hGXecYGQH4lBU2qRBYeHUxm8aiG8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrnu3WqP1tSlunTQaY4L9L8GbxuS2dBEVnEYOR0s94zxo9i4Vv
	8Bbdkcg/eaod3plhjW7CTSFMnzQu1Mlda0l9t5xV+R7R37N0vQUFqtZuXA+YodH9XlRieIGUp/L
	dRNseb7GVn3VKOUX6kejEKC+sW6I=
X-Google-Smtp-Source: AGHT+IE6EYKECy8N5xFps5quuYLLghxanQBI/gHzk6v2PNmlvk3nHrEpxbvT//VG51y0yY6GTykKEc0xs5iyQycwT9A=
X-Received: by 2002:a05:6871:780c:b0:254:d417:351f with SMTP id
 586e51a60fabf-26fcb6524bbmr425975fac.1.1723479330560; Mon, 12 Aug 2024
 09:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1922131.tdWV9SEqCh@rjwysocki.net> <2242500.C4sosBPzcN@rjwysocki.net>
 <a0c639d1-4f21-47f1-bb66-92f185e828a9@gmail.com> <CAJZ5v0jDQLJWGCj73DXQe3+k+Zaq9Z71LJbFSvRjcuE85+J+mQ@mail.gmail.com>
 <1bfbbae5-42b0-4c7d-9544-e98855715294@piie.net> <CAJZ5v0h7WaBVhgvbxz1W1YX9TSY-awKJMsLm2NPkmCBsf3y0BA@mail.gmail.com>
In-Reply-To: <CAJZ5v0h7WaBVhgvbxz1W1YX9TSY-awKJMsLm2NPkmCBsf3y0BA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Aug 2024 18:15:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jhkWXPDpQvS+sCeSsDNsSRX3NHk0nEg+MsJ=EiUR4Rgw@mail.gmail.com>
Message-ID: <CAJZ5v0jhkWXPDpQvS+sCeSsDNsSRX3NHk0nEg+MsJ=EiUR4Rgw@mail.gmail.com>
Subject: Re: [PATCH v1 12/17] platform/x86: acerhdf: Use the .should_bind()
 thermal zone callback
To: =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, platform-driver-x86@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000046c273061f7ecda5"

--00000000000046c273061f7ecda5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Mon, Aug 12, 2024 at 4:56=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Aug 6, 2024 at 12:10=E2=80=AFAM Peter K=C3=A4stle <peter@piie.net=
> wrote:
> >
> > Hi Rafael,
> >
> > On 01.08.24 12:14, Rafael J. Wysocki wrote:
> > > Hi Peter,
> > >
> > > On Wed, Jul 31, 2024 at 10:50=E2=80=AFPM Peter K=C3=A4stle <xypiie@gm=
ail.com> wrote:
> > >>
> > >> Hi Rafael,
> > >>
> > >> On 30.07.24 20:33, Rafael J. Wysocki wrote:
> > >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>>
> > >>> Make the acerhdf driver use the .should_bind() thermal zone
> > >>> callback to provide the thermal core with the information on whethe=
r or
> > >>> not to bind the given cooling device to the given trip point in the
> > >>> given thermal zone.  If it returns 'true', the thermal core will bi=
nd
> > >>> the cooling device to the trip and the corresponding unbinding will=
 be
> > >>> taken care of automatically by the core on the removal of the invol=
ved
> > >>> thermal zone or cooling device.
> > >>>
> > >>> The previously existing acerhdf_bind() function bound cooling devic=
es
> > >>> to thermal trip point 0 only, so the new callback needs to return '=
true'
> > >>> for trip point 0.  However, it is straightforward to observe that t=
rip
> > >>> point 0 is an active trip point and the only other trip point in th=
e
> > >>> driver's thermal zone is a critical one, so it is sufficient to ret=
urn
> > >>> 'true' from that callback if the type of the given trip point is
> > >>> THERMAL_TRIP_ACTIVE.
> > >>>
> > >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>
> > >> Thanks for including me on the review.
> > >> I'm working on it, but unfortunately the refactoring of the thermal =
layer
> > >> around gov_bang_bang.c earlier this year broke acerhdf.
> > >
> > > Well, sorry about that.
> >
> > I already fixed the main problem, which caused full malfunction of acer=
hdf:
> >
> > The new functionality of .trip_crossed in the gov_bang_bang is missing =
an
> > initial check, whether the temperature is below the fanoff temperature
> > (trip_point.temperature - hysteresis) and by that it did not turn the
> > fan off.
>
> So IIUC this is when the fan starts in the "on" state and the thermal
> core is expected to turn it off when the zone temperature is not in
> fact above the trip point low temperature.
>
> > This then caused that the system will never heat up as much to
> > cross the upper temperature. As a consequence it could never cross the
> > lower temperature to turn the fan off. -> Fan was locked always on.
> > And that's obviously not what we want.
>
> Sure.
>
> > As I didn't find any API call, to ask the governor doing that for me, I
> > added an "acerhdf_init_fan()" functionality into acerhdf init function =
right
> > after registering the thermal zone (and on resume from suspend) which t=
urns
> > the fan off if the temperature is lower than the fanoff parameter.
> > Probably not the nicest solution, but maybe the most pragmatic one with=
out
> > touching the thermal layer.
>
> Well, this issue may not be limited to the acerhdf case, so it may be
> good to address it in the thermal core.  There is kind of a
> chicken-and-egg situation in there, however, because the cooling
> device state is determined by the governor which only runs when it is
> called, but the core doesn't know that the governor should be invoked
> when there are no trip point crossing events.
>
> It may just be a matter of adding an ->update_tz() callback to the
> bang-bang governor, let me see.

Attached is a patch doing that - and one more change to invoke this
callback during thermal zone resume.

It should apply to 6.11-rc3 (without any of the thermal core changes
in linux-next or on the list).

If I'm not mistaken, this should address the issue above.

> > >> This needs some debugging and refactoring.  I think I can finish it =
on
> > >> upcoming weekend.
> > >
> > > Thank you!
> >
> > I'll need some more time to check why other features of acerhdf broke:
> > * interval cannot be changed to longer than one second.
> >    No idea yet, do you have any idea?
>
> No, I don't, but I'll have a look.

This may be related to the way in which round_jiffies() is used by
thermal_set_delay_jiffies() in the thermal core.  I think it should
call round_jiffies_relative() instead, so you may try to replace
round_jiffies() with round_jiffies_relative() in
thermal_set_delay_jiffies() and see if that helps.

> >  Maybe I'll simply drop this
> >    functionality, as there's no big overhead by polling every second.
>
> No, there isn't, but anyway it would be good to know why this does not
> work as expected any more.
>
> > * changing /sys/module/acerhdf/parameters/{fanon,fanoff} at runtime
> >    to change the trip point settings stopped working.  This needs some
> >    restructuring using module_param_cb callbacks.
>
> I'll have a look at this too.

So acerhdf_check_param() updates the trips table, but it is only
called from interval_set_uint(), so it will only trigger when the
interval module param is updated AFAICS.

Apart from this, it is not sufficient to update the original trips
table passed to register_thermal_zone_device_with_trips() because the
core makes a copy of it and does not use the original one any more
after zone registration.

What you need is to either mark the trip point as writable (set
THERMAL_TRIP_FLAG_RW_TEMP and THERMAL_TRIP_FLAG_RW_HYST for it in
flags), but that will not engage the fanon/fanoff sanity check in the
driver, or add callbacks for setting trip temperature and hysteresis
to the thermal zone operations and hook them up to the module
parameters.  However, you'd need to restore .set_trip_hyst() for this
which was removed because it was unused.

Thanks!

--00000000000046c273061f7ecda5
Content-Type: text/x-patch; charset="US-ASCII"; name="thermal-gov_bamg_bang-update_tz.patch"
Content-Disposition: attachment; 
	filename="thermal-gov_bamg_bang-update_tz.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lzr67jnq0>
X-Attachment-Id: f_lzr67jnq0

LS0tCiBkcml2ZXJzL3RoZXJtYWwvZ292X2JhbmdfYmFuZy5jIHwgICAzNCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgIHwg
ICAgMyArKy0KIGluY2x1ZGUvbGludXgvdGhlcm1hbC5oICAgICAgICAgfCAgICAxICsKIDMgZmls
ZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKSW5kZXg6IGxpbnV4
LXBtL2RyaXZlcnMvdGhlcm1hbC9nb3ZfYmFuZ19iYW5nLmMKPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgt
cG0ub3JpZy9kcml2ZXJzL3RoZXJtYWwvZ292X2JhbmdfYmFuZy5jCisrKyBsaW51eC1wbS9kcml2
ZXJzL3RoZXJtYWwvZ292X2JhbmdfYmFuZy5jCkBAIC03OSw4ICs3OSw0MiBAQCBzdGF0aWMgdm9p
ZCBiYW5nX2JhbmdfY29udHJvbChzdHJ1Y3QgdGhlCiAJCXRoZXJtYWxfY2Rldl91cGRhdGUoaW5z
dGFuY2UtPmNkZXYpOwogfQogCitzdGF0aWMgdm9pZCBiYW5nX2JhbmdfdXBkYXRlX3R6KHN0cnVj
dCB0aGVybWFsX3pvbmVfZGV2aWNlICp0eiwKKwkJCQllbnVtIHRoZXJtYWxfbm90aWZ5X2V2ZW50
IHJlYXNvbikKK3sKKwlzdHJ1Y3QgdGhlcm1hbF9pbnN0YW5jZSAqaW5zdGFuY2U7CisKKwlsb2Nr
ZGVwX2Fzc2VydF9oZWxkKCZ0ei0+bG9jayk7CisKKwlpZiAocmVhc29uICE9IFRIRVJNQUxfVFpf
QklORF9DREVWICYmIHJlYXNvbiAhPSBUSEVSTUFMX1RaX1JFU1VNRSkKKwkJcmV0dXJuOworCisJ
bGlzdF9mb3JfZWFjaF9lbnRyeShpbnN0YW5jZSwgJnR6LT50aGVybWFsX2luc3RhbmNlcywgdHpf
bm9kZSkgeworCQljb25zdCBzdHJ1Y3QgdGhlcm1hbF90cmlwICp0cmlwID0gaW5zdGFuY2UtPnRy
aXA7CisKKwkJaWYgKGluc3RhbmNlLT5pbml0aWFsaXplZCkKKwkJCWNvbnRpbnVlOworCisJCS8q
CisJCSAqIElmIHRoZSBpbml0aWFsIGNvb2xpbmcgZGV2aWNlIHN0YXRlIGlzICJvbiIsIGJ1dCB0
aGUgem9uZQorCQkgKiB0ZW1wZXJhdHVyZSBpcyBub3QgYWJvdmUgdGhlIHRyaXAgcG9pbnQsIHRo
ZSBjb3JlIHdpbGwgbm90CisJCSAqIGNhbGwgYmFuZ19iYW5nX2NvbnRyb2woKSB1bnRpbCB0aGUg
em9uZSB0ZW1wZXJhdHVyZSByZWFjaGVzCisJCSAqIHRoZSB0cmlwIHBvaW50IHRlbXBlcmF0dXJl
IHdoaWNoIG1heSBiZSBuZXZlci4gIEluIHRob3NlCisJCSAqIGNhc2VzLCBzZXQgdGhlIGluaXRp
YWwgc3RhdGUgb2YgdGhlIGNvb2xpbmcgZGV2aWNlIHRvIDAuCisJCSAqLworCQlpZiAodHotPnRl
bXBlcmF0dXJlIDwgdHJpcC0+dGVtcGVyYXR1cmUpCisJCQliYW5nX2JhbmdfY29udHJvbCh0eiwg
dHJpcCwgMCk7CisKKwkJaW5zdGFuY2UtPmluaXRpYWxpemVkID0gdHJ1ZTsKKwl9CisKKwlsaXN0
X2Zvcl9lYWNoX2VudHJ5KGluc3RhbmNlLCAmdHotPnRoZXJtYWxfaW5zdGFuY2VzLCB0el9ub2Rl
KQorCQl0aGVybWFsX2NkZXZfdXBkYXRlKGluc3RhbmNlLT5jZGV2KTsKK30KKwogc3RhdGljIHN0
cnVjdCB0aGVybWFsX2dvdmVybm9yIHRoZXJtYWxfZ292X2JhbmdfYmFuZyA9IHsKIAkubmFtZQkJ
PSAiYmFuZ19iYW5nIiwKIAkudHJpcF9jcm9zc2VkCT0gYmFuZ19iYW5nX2NvbnRyb2wsCisJLnVw
ZGF0ZV90egk9IGJhbmdfYmFuZ191cGRhdGVfdHosCiB9OwogVEhFUk1BTF9HT1ZFUk5PUl9ERUNM
QVJFKHRoZXJtYWxfZ292X2JhbmdfYmFuZyk7CkluZGV4OiBsaW51eC1wbS9kcml2ZXJzL3RoZXJt
YWwvdGhlcm1hbF9jb3JlLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtcG0ub3JpZy9kcml2ZXJzL3Ro
ZXJtYWwvdGhlcm1hbF9jb3JlLmMKKysrIGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC90aGVybWFs
X2NvcmUuYwpAQCAtMTcxMSw3ICsxNzExLDggQEAgc3RhdGljIHZvaWQgdGhlcm1hbF96b25lX2Rl
dmljZV9yZXN1bWUocwogCiAJdGhlcm1hbF9kZWJ1Z190el9yZXN1bWUodHopOwogCXRoZXJtYWxf
em9uZV9kZXZpY2VfaW5pdCh0eik7Ci0JX190aGVybWFsX3pvbmVfZGV2aWNlX3VwZGF0ZSh0eiwg
VEhFUk1BTF9FVkVOVF9VTlNQRUNJRklFRCk7CisJdGhlcm1hbF9nb3Zlcm5vcl91cGRhdGVfdHoo
dHosIFRIRVJNQUxfVFpfUkVTVU1FKTsKKwlfX3RoZXJtYWxfem9uZV9kZXZpY2VfdXBkYXRlKHR6
LCBUSEVSTUFMX1RaX1JFU1VNRSk7CiAKIAljb21wbGV0ZSgmdHotPnJlc3VtZSk7CiAJdHotPnJl
c3VtaW5nID0gZmFsc2U7CkluZGV4OiBsaW51eC1wbS9pbmNsdWRlL2xpbnV4L3RoZXJtYWwuaAo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09Ci0tLSBsaW51eC1wbS5vcmlnL2luY2x1ZGUvbGludXgvdGhlcm1hbC5oCisrKyBs
aW51eC1wbS9pbmNsdWRlL2xpbnV4L3RoZXJtYWwuaApAQCAtNTUsNiArNTUsNyBAQCBlbnVtIHRo
ZXJtYWxfbm90aWZ5X2V2ZW50IHsKIAlUSEVSTUFMX1RaX0JJTkRfQ0RFViwgLyogQ29vbGluZyBk
ZXYgaXMgYmluZCB0byB0aGUgdGhlcm1hbCB6b25lICovCiAJVEhFUk1BTF9UWl9VTkJJTkRfQ0RF
ViwgLyogQ29vbGluZyBkZXYgaXMgdW5iaW5kIGZyb20gdGhlIHRoZXJtYWwgem9uZSAqLwogCVRI
RVJNQUxfSU5TVEFOQ0VfV0VJR0hUX0NIQU5HRUQsIC8qIFRoZXJtYWwgaW5zdGFuY2Ugd2VpZ2h0
IGNoYW5nZWQgKi8KKwlUSEVSTUFMX1RaX1JFU1VNRSwgLyogVGhlcm1hbCB6b25lIHJlc3VtZSBh
ZnRlciBzeXN0ZW0gc2xlZXAgKi8KIH07CiAKIC8qKgo=
--00000000000046c273061f7ecda5--

