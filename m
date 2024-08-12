Return-Path: <linux-acpi+bounces-7537-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA20094F0E5
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 16:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A5428130E
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 14:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213E3180032;
	Mon, 12 Aug 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBXNt2Qw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31B74B5AE;
	Mon, 12 Aug 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474619; cv=none; b=Gh6y6WeEXginb2iDe1AKR6jsw5Kdawc6JuNSlbcqhHgZRH+MJUArzYwKlIXs+4E8PJpRb0paKGqQofgcZrAj/ryob78sWdMeonXjB+WehNvzu4JENqjt7fa2dC3CC8Mo1jS93T0sQgk7iYtjSAL++h9LCqt2apRIkinNoJVU6Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474619; c=relaxed/simple;
	bh=gYja+bKnoU1elwDEv2H33a0ckvKaofOh364DJ6P7IWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrVOM6s7EdqbbDRbm2PbF6h3j/gff3WI1rwmxjFhUW53J02qT9dQeFiDWcOgJ/1u883vghHEl0jN/4aFNzD3fBy8NHTCHbPBJ7X7IRvjoqjnDfBxUjI957fJv27tRKcX1Q7m4of3+E4BwYAz86f/pD3C+33BkgGa7+Mw2kbj2RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBXNt2Qw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD31C4AF0D;
	Mon, 12 Aug 2024 14:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723474618;
	bh=gYja+bKnoU1elwDEv2H33a0ckvKaofOh364DJ6P7IWM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DBXNt2QwsMoLDJ2k7Sx3jL8Cj9Zvvw5f1Sa21zqeDIPDbRngiBhdUVfO9wQQLd3BP
	 Q+ZvaF1pds72N/z2DaU8/qRTc8yevzYmvwO/xStEc7m/m9tkfJ0mmx0z098vouUUbV
	 AeLoF8Be6zbJVlt4x0/1v+lcBCZAAX3p4XSsb8ak096pM/jRDqmqqMbUpySrqXhNOa
	 8PuijyCwwMOWjtGglNcw7Qd/uk3wLn38SuAV026b5nKX4SZp9TtGICW2Sa1ts0dwjC
	 Y9CsUt9fM2uY8F0JJ599TsbCOiI9SsX5h9Y92VSGphny6SsZhhcz4kNrOmFagQMaLd
	 7WPyD1isSblgQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ce3accb2c4so175895eaf.0;
        Mon, 12 Aug 2024 07:56:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2FfSEBKSKT2Bwa1NehrC9x8yWBI3ee9vzRuXYiL3sflP3t3LiXmCVgW4hNEqX4CXmCuFrEmDO0tAAffJaxfT2I9Y/yw==@vger.kernel.org, AJvYcCVH0aFqgd+gvmPQihlmKCjP7qaGdCvseOSeB7EAirzoVMuNbrlHk0xX0mFduZeuh32GbltoXglCeO+Q@vger.kernel.org, AJvYcCXJEw+8O9JxIfRILQBt8/5hKEGxAQ+En9iipG1k4Oo33CEQAQDh6XkhPCC6cm81GOjpXe9+aqeHrUNMDQs/@vger.kernel.org, AJvYcCXe3TdU5kO7pXG2Sursi7Kd9l/dVUOXT8T0Uoz3Tp13mYZ+WETG/lVMCZ+0XCMCqbpTIkIDIexDUzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOrRYW6WClf6x0C+2/lymGxv4aPMMPp5+Qoi53rQi/6wMoN9bj
	32gVzu7/p1aJURnr350G7g3lF8ZvBR7V/NOIIe01agcg2Y7vViLCsppuj/2MkfHUYJF/1Lg8Y1n
	Uar+wLTN0az4MxeuKYAryk2vysvo=
X-Google-Smtp-Source: AGHT+IEvpNMCaVCeqgsKh2myI6K5gJ6ugM0u04cIc0V8K1ItbUxYpSM9mDlBt+1qzqleUQcsXNMBLt2IsfOsdW5BGEM=
X-Received: by 2002:a4a:8311:0:b0:5d8:5a15:146b with SMTP id
 006d021491bc7-5da68308df7mr402770eaf.0.1723474617943; Mon, 12 Aug 2024
 07:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1922131.tdWV9SEqCh@rjwysocki.net> <2242500.C4sosBPzcN@rjwysocki.net>
 <a0c639d1-4f21-47f1-bb66-92f185e828a9@gmail.com> <CAJZ5v0jDQLJWGCj73DXQe3+k+Zaq9Z71LJbFSvRjcuE85+J+mQ@mail.gmail.com>
 <1bfbbae5-42b0-4c7d-9544-e98855715294@piie.net>
In-Reply-To: <1bfbbae5-42b0-4c7d-9544-e98855715294@piie.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Aug 2024 16:56:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h7WaBVhgvbxz1W1YX9TSY-awKJMsLm2NPkmCBsf3y0BA@mail.gmail.com>
Message-ID: <CAJZ5v0h7WaBVhgvbxz1W1YX9TSY-awKJMsLm2NPkmCBsf3y0BA@mail.gmail.com>
Subject: Re: [PATCH v1 12/17] platform/x86: acerhdf: Use the .should_bind()
 thermal zone callback
To: =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Tue, Aug 6, 2024 at 12:10=E2=80=AFAM Peter K=C3=A4stle <peter@piie.net> =
wrote:
>
> Hi Rafael,
>
> On 01.08.24 12:14, Rafael J. Wysocki wrote:
> > Hi Peter,
> >
> > On Wed, Jul 31, 2024 at 10:50=E2=80=AFPM Peter K=C3=A4stle <xypiie@gmai=
l.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >> On 30.07.24 20:33, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Make the acerhdf driver use the .should_bind() thermal zone
> >>> callback to provide the thermal core with the information on whether =
or
> >>> not to bind the given cooling device to the given trip point in the
> >>> given thermal zone.  If it returns 'true', the thermal core will bind
> >>> the cooling device to the trip and the corresponding unbinding will b=
e
> >>> taken care of automatically by the core on the removal of the involve=
d
> >>> thermal zone or cooling device.
> >>>
> >>> The previously existing acerhdf_bind() function bound cooling devices
> >>> to thermal trip point 0 only, so the new callback needs to return 'tr=
ue'
> >>> for trip point 0.  However, it is straightforward to observe that tri=
p
> >>> point 0 is an active trip point and the only other trip point in the
> >>> driver's thermal zone is a critical one, so it is sufficient to retur=
n
> >>> 'true' from that callback if the type of the given trip point is
> >>> THERMAL_TRIP_ACTIVE.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Thanks for including me on the review.
> >> I'm working on it, but unfortunately the refactoring of the thermal la=
yer
> >> around gov_bang_bang.c earlier this year broke acerhdf.
> >
> > Well, sorry about that.
>
> I already fixed the main problem, which caused full malfunction of acerhd=
f:
>
> The new functionality of .trip_crossed in the gov_bang_bang is missing an
> initial check, whether the temperature is below the fanoff temperature
> (trip_point.temperature - hysteresis) and by that it did not turn the
> fan off.

So IIUC this is when the fan starts in the "on" state and the thermal
core is expected to turn it off when the zone temperature is not in
fact above the trip point low temperature.

> This then caused that the system will never heat up as much to
> cross the upper temperature. As a consequence it could never cross the
> lower temperature to turn the fan off. -> Fan was locked always on.
> And that's obviously not what we want.

Sure.

> As I didn't find any API call, to ask the governor doing that for me, I
> added an "acerhdf_init_fan()" functionality into acerhdf init function ri=
ght
> after registering the thermal zone (and on resume from suspend) which tur=
ns
> the fan off if the temperature is lower than the fanoff parameter.
> Probably not the nicest solution, but maybe the most pragmatic one withou=
t
> touching the thermal layer.

Well, this issue may not be limited to the acerhdf case, so it may be
good to address it in the thermal core.  There is kind of a
chicken-and-egg situation in there, however, because the cooling
device state is determined by the governor which only runs when it is
called, but the core doesn't know that the governor should be invoked
when there are no trip point crossing events.

It may just be a matter of adding an ->update_tz() callback to the
bang-bang governor, let me see.

> >> This needs some debugging and refactoring.  I think I can finish it on
> >> upcoming weekend.
> >
> > Thank you!
>
> I'll need some more time to check why other features of acerhdf broke:
> * interval cannot be changed to longer than one second.
>    No idea yet, do you have any idea?

No, I don't, but I'll have a look.

>  Maybe I'll simply drop this
>    functionality, as there's no big overhead by polling every second.

No, there isn't, but anyway it would be good to know why this does not
work as expected any more.

> * changing /sys/module/acerhdf/parameters/{fanon,fanoff} at runtime
>    to change the trip point settings stopped working.  This needs some
>    restructuring using module_param_cb callbacks.

I'll have a look at this too.

> > I'll be offline next week, so I'll go back to this material in two
> > weeks or so anyway.
>
> I still need some time to fix the remaining part anyhow.  Once this is
> done, I'll check your latest patch series and send my acerhdf rework for
> review / submission.

Sure.

In the meantime, I have resent the series including the acerhdf
change, but it is the same as before.

Thanks!

