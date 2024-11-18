Return-Path: <linux-acpi+bounces-9635-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633CD9D1084
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 13:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2424228378C
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD761990C1;
	Mon, 18 Nov 2024 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyzfDgIK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D48313A86A;
	Mon, 18 Nov 2024 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731932589; cv=none; b=mIY9kDhKDagd4n71f4n84cL5otHMa1saP7s65U3MpNkgzBUK9hLt7V7CZ9U/lrQnOjBg62cjAalFBzg8WTMjcRorNAS/qlTcFF2tYIGoFUUYgw3mnMwv2G7PPs9h/JInIUgrmoShrB/LDehp/L6eJb6NK8RFQvNfOnIbEE7+Gh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731932589; c=relaxed/simple;
	bh=2AM0Pwmwt4xkz3qrnCVJ5OXl0vU5NLafA/qx+ImQPdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbZH+YnStGIRHNAmqgmiKXuix58x2ukbdDpqhEvm5v8iAGJCuGdwo8yp5j/nGCgL+1Ih67fVC9IVST1rojC//XY2hczxGsMKkD1l/Hf6n0DXynjaKggIMCh1XQQ2Xs4Zw+yFqD7853DiqJn58KFxx/WeMO1vVp3gCqBV4aqj1GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyzfDgIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11090C4AF0B;
	Mon, 18 Nov 2024 12:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731932589;
	bh=2AM0Pwmwt4xkz3qrnCVJ5OXl0vU5NLafA/qx+ImQPdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fyzfDgIKbjhvK+J+kVEJSPZPE0hTWltrT03qI4bnCVnWPDenC+7Nunr35bkEGVsCB
	 XvHeW7XJFTq3u3u6+6r71B4P+vl2rCAmj+lLlOMWbv8fY5aY0nIRsgvopa7+zzKARj
	 /q6L9ecPR3JOgARmt+tCWPvTNxitsdrC07nAgcLukV9XTLegfu3H8cDRXTwsKMGVe4
	 GjqK+MgSuDp4omfnrvuReV9G7xdLN1IDms1prLWMm6Jo4ph2M/5Edg9zOicq5OajAj
	 jdyyiRsLnbjf7EsMrvR3X8BFeoFGVbu2XxPtI4AFkdGsyRWLuR6E2upFqgSGdHiEhF
	 s4n6jM/yt5oUw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2969ae2c99fso216444fac.3;
        Mon, 18 Nov 2024 04:23:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYafyW9fbPZ4irqytMjFHHOdw6VCIy8v2Ie+51BnhPopAzu6SoHhQ0/HpA3PgFBNr/WBcZn7cUwBNL10K9@vger.kernel.org, AJvYcCUqz9WGzokAKiflhIP8ePSOfUcTqxzh6IlAJFy94nYtH/lKFb4MkJYJ5EjKAFuR+bjR1i/+MQeQaLZy@vger.kernel.org, AJvYcCWZMpobhqWPrLIasDt8/Cmuw2wBtO91C/w6QaKUD91KYaqttiZfAQZNXBOVv8U/SPp6FPWEpKQ4JKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdgHNizxTq/4HaximmlMHVeHjUYaVoUUFCt4VQX5OO0kWs9tOc
	nKbjHym2bXh6nPWxK7PivDmWCx77A0g7xN0Lb0ra/rN2jThLILllZPMaAaWRNUgI+syn9h0j3dc
	fgo7m/OtxIH9WoSmvx6lubaIRu0k=
X-Google-Smtp-Source: AGHT+IF/kfIq3zkqlYI9Cw77TUT1DImRv+8xOHZpIef+c8mocXmFTT+UBO4/hpLxZTh0FGQVU+a0XOy6UKwWQL8uMXs=
X-Received: by 2002:a05:6871:c68c:b0:296:53e0:1e5 with SMTP id
 586e51a60fabf-29653e0729emr3949044fac.37.1731932588242; Mon, 18 Nov 2024
 04:23:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
 <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
 <60f8eac0-9144-486b-983f-4ed09101cf0a@redhat.com> <CAJZ5v0g7rpdUjrS969stJiqqtO5zG+FTr4TOxg+SYN2dPC_9jA@mail.gmail.com>
 <95f1b1f6-af16-415c-acd0-8eb1ab49746a@redhat.com>
In-Reply-To: <95f1b1f6-af16-415c-acd0-8eb1ab49746a@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Nov 2024 13:22:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jr-o8h_tVcTQ_SkiWhKn2eCj5pH=fReWoK8aPPb5Ziag@mail.gmail.com>
Message-ID: <CAJZ5v0jr-o8h_tVcTQ_SkiWhKn2eCj5pH=fReWoK8aPPb5Ziag@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in acpi_os_sleep().
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, anna-maria@linutronix.de, 
	tglx@linutronix.de, peterz@infradead.org, frederic@kernel.org, corbet@lwn.net, 
	akpm@linux-foundation.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, 
	Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Mon, Nov 18, 2024 at 1:10=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi Rafael,
>
> On 18-Nov-24 1:02 PM, Rafael J. Wysocki wrote:
> > Hi Hans,
> >
> > On Mon, Nov 18, 2024 at 12:38=E2=80=AFPM Hans de Goede <hdegoede@redhat=
.com> wrote:
> >>
> >> Hi Rafael, Len,
> >>
> >> On 18-Nov-24 12:03 PM, Rafael J. Wysocki wrote:
> >>> On Sat, Nov 16, 2024 at 12:11=E2=80=AFAM Len Brown <lenb@kernel.org> =
wrote:
> >>>>
> >>>> From: Len Brown <len.brown@intel.com>
> >>>>
> >>>> Replace msleep() with usleep_range() in acpi_os_sleep().
> >>>>
> >>>> This has a significant user-visible performance benefit
> >>>> on some ACPI flows on some systems.  eg. Kernel resume
> >>>> time of a Dell XPS-13-9300 drops from 1943ms to 1127ms (42%).
> >>>
> >>> Sure.
> >>>
> >>> And the argument seems to be that it is better to always use more
> >>> resources in a given path (ACPI sleep in this particular case) than t=
o
> >>> be somewhat inaccurate which is visible in some cases.
> >>>
> >>> This would mean that hrtimers should always be used everywhere, but t=
hey aren't.
> >>>
> >>> While I have nothing against addressing the short sleeps issue where
> >>> the msleep() inaccuracy is too large, I don't see why this requires
> >>> using a hrtimer with no slack in all cases.
> >>>
> >>> The argument seems to be that the short sleeps case is hard to
> >>> distinguish from the other cases, but I'm not sure about this.
> >>>
> >>> Also, something like this might work, but for some reason you don't
> >>> want to do it:
> >>>
> >>> if (ms >=3D 12 * MSEC_PER_SEC / HZ) {
> >>>         msleep(ms);
> >>> } else {
> >>>        u64 us =3D ms * USEC_PER_MSEC;
> >>>
> >>>       usleep_range(us, us / 8);
> >
> > Should be
> >
> >       usleep_range(us, us + us / 8);
> >
> > (I notoriously confuse this API).
>
> I see.
>
> >>> }
> >>
> >> FWIW I was thinking the same thing, that it would be good to still
> >> use msleep when the sleep is > (MSEC_PER_SEC / HZ), not sure
> >> why you added the 12 there ? Surely something like a sleep longer
> >> then 3 timerticks (I know we have NOHZ but still) would already be
> >> long enough to not worry about msleep slack ?
> >
> > The typical msleep() overhead in 6.12 appears to be 1.5 jiffy which is
> > 1.5 * MSEC_PER_SEC / HZ and I want the usleep() delta to be less than
> > this, so
> >
> > delta =3D ms / 8 <=3D 1.5 * MSEC_PER_SEC / HZ
>
> Ok, that makes sense. But this probably requires a comment explaining
> this so that when someone looks at this in the future they understand
> where the 12 comes from.

Sure.

> Where as the / 8 is just a choice right? I think it is decent choice,
> but still this is just a value you picked which should work nicely,
> right ?

Right.

I chose a power of 2 close to 10%.

> >> OTOH it is not like we will hit these ACPI acpi_os_sleep()
> >> calls multiple times per second all the time. On a normal idle
> >> system I expect there to not be that many calls (could still
> >> be a few from ACPI managed devices going into + out of
> >> runtime-pm regularly). And if don't hit acpi_os_sleep() calls
> >> multiple times per second then the chances of time coalescing
> >> are not that big anyways.
> >>
> >> Still I think that finding something middle ground between always
> >> sleeping the exact min time and the old msleep() call, as Rafael
> >> is proposing, would be good IMHO.
> >
> > Thanks for the feedback!
>
> You're welcome.
>
> Len any chance you can give Rafael's proposal a test run on the
> same Dell XPS 13 9300 and see what this means for the resume time ?
>
> If this gets close enough to your patch I think we should go with
> what Rafael is proposing.

Thanks!


> >>>> usleep_range(min, min) is used because there is scant
> >>>> opportunity for timer coalescing during ACPI flows
> >>>> related to system suspend, resume (or initialization).
> >>>>
> >>>> ie. During these flows usleep_range(min, max) is observed to
> >>>> be effectvely be the same as usleep_range(max, max).
> >>>>
> >>>> Similarly, msleep() for long sleeps is not considered because
> >>>> these flows almost never have opportunities to coalesce
> >>>> with other activity on jiffie boundaries, leaving no
> >>>> measurably benefit to rounding up to jiffie boundaries.
> >>>>
> >>>> Background:
> >>>>
> >>>> acpi_os_sleep() supports the ACPI AML Sleep(msec) operator,
> >>>> and it must not return before the requested number of msec.
> >>>>
> >>>> Until Linux-3.13, this contract was sometimes violated by using
> >>>> schedule_timeout_interruptible(j), which could return early.
> >>>>
> >>>> Since Linux-3.13, acpi_os_sleep() uses msleep(),
> >>>> which doesn't return early, but is still subject
> >>>> to long delays due to the low resolution of the jiffie clock.
> >>>>
> >>>> Linux-6.12 removed a stray jiffie from msleep: commit 4381b895f544
> >>>> ("timers: Remove historical extra jiffie for timeout in msleep()")
> >>>> The 4ms savings is material for some durations,
> >>>> but msleep is still generally too course. eg msleep(5)
> >>>> on a 250HZ system still takes 11.9ms.
> >>>>
> >>>> System resume performance of a Dell XPS 13 9300:
> >>>>
> >>>> Linux-6.11:
> >>>> msleep HZ 250   2460 ms
> >>>>
> >>>> Linux-6.12:
> >>>> msleep HZ 250   1943 ms
> >>>> msleep HZ 1000  1233 ms
> >>>> usleep HZ 250   1127 ms
> >>>> usleep HZ 1000  1130 ms
> >>>>
> >>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D216263
> >>>> Signed-off-by: Len Brown <len.brown@intel.com>
> >>>> Suggested-by: Arjan van de Ven <arjan@linux.intel.com>
> >>>> Tested-by: Todd Brandt <todd.e.brandt@intel.com>
> >>>> ---
> >>>>  drivers/acpi/osl.c | 4 +++-
> >>>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> >>>> index 70af3fbbebe5..daf87e33b8ea 100644
> >>>> --- a/drivers/acpi/osl.c
> >>>> +++ b/drivers/acpi/osl.c
> >>>> @@ -607,7 +607,9 @@ acpi_status acpi_os_remove_interrupt_handler(u32=
 gsi, acpi_osd_handler handler)
> >>>>
> >>>>  void acpi_os_sleep(u64 ms)
> >>>>  {
> >>>> -       msleep(ms);
> >>>> +       u64 us =3D ms * USEC_PER_MSEC;
> >>>> +
> >>>> +       usleep_range(us, us);
> >>>>  }
> >>>>
> >>>>  void acpi_os_stall(u32 us)
> >>>> --
> >>>> 2.43.0
> >>>>
> >>>
> >>
> >
>

