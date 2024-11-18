Return-Path: <linux-acpi+bounces-9633-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 220A69D104F
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 13:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB0BB24AED
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E012A1993B4;
	Mon, 18 Nov 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTq/Hf/E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B118A13A89A;
	Mon, 18 Nov 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931347; cv=none; b=F0xiKZqcKi52U2hE+voRHJLjUD+4Qopr2alTKz2jxcaLagaVEKJ0ItW78dbjRSU8LdfP6Q1ZplttWqfsWlvFmc+EK8XjM+AF3xemEgPvFrkq/1826Wr5G8DXOXRH+EjJdBTNozhQePyw8NRQocTqMlcv2FqYwse+FC899zidcW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931347; c=relaxed/simple;
	bh=XBmgI6TDU/mR4ArEFIj28zigoB/CovEq29qq81umX3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuSZptlimlx2w10We8bODGHBsjIeJL002z6xoo3JROyjL0yTSuUMbdCPkyQc+hvF9oboQltzQOvHcIEDwkeP6bI9V3RTlcLU+F4kG0ua9rJi6Mt6Zv80NmzyJKpm8qaKE+ngvkpdLKc3n2/Qj1qy7YGzMEFS9Yzhg8V0Umo6q5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTq/Hf/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4937FC4CECC;
	Mon, 18 Nov 2024 12:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731931347;
	bh=XBmgI6TDU/mR4ArEFIj28zigoB/CovEq29qq81umX3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UTq/Hf/EuDsE061eNv5MY5Z2bJp+//haKSi2wPSrCxInmZz7hahI7665y9wXxkqfP
	 DMEMp3HyYAE/R3XduSKKuch3O2gyD40PHx3DCzkIUE/DYtDELOBoaiJTMYxPVutZb2
	 MVM5cjBhN9ieOMLT9zK6/CVFmk8V5vNLiIx7DzhchaG+F353RSEbWskCUD6mwIpDa3
	 Gr7aF27KvUCfZcWua7WE01kQQn9TaPimknNmu6L5IUV0DMBDwkDLPIGxWGD4oOsDQQ
	 G+gc+o//17wlCy+sFundFgduSmhj58lLDqy4FuVpKejzXg8fwmf6l7swHduvMF1SEI
	 80WG1amDZuRzw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ebc349204cso669418eaf.3;
        Mon, 18 Nov 2024 04:02:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTbXXBTIcllQKimCKNDvE+k8MxzE5bTAlV2S4fdLXlYUChY0rnrEejxyjisSoS4F/Q4oAcDVBG9Dr1@vger.kernel.org, AJvYcCUqC2v6OJpOSffLm4hi3H3sBXGUDTJwTTt8Sch7t4W0eqwu0O57iM14duKp/cPcnR+dXrq6t/iDTaVASijd@vger.kernel.org, AJvYcCXl/wRPtrFGCFQ2KLqx6rMJ5QtpEs2lShpNpGDpglvrgmUOlMkj3WMQmQzQUCYm92jAus+Qhp/n86c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO2vcerPZOxyNN15c5OA5uI/6xl7gkHXBAwunoquPwCYRwNNY0
	Odk/hPCAuo9ASbll0RvIDhRSsTtCCj9mP03kIFw2tI24KZRD12hyMhJU4QHeJUFrYJn9lH+aFV9
	v15zHmXcRa8AJvWNsNGsrPYqrLDs=
X-Google-Smtp-Source: AGHT+IHxJmyQyYd1n8NKOTSh5nN/mr3YoqQpjm+RBjMocVnGXAPrDJAtXVvcc2O+H3FDbhrGwJb7n9U5YpAtDtk2G9E=
X-Received: by 2002:a05:6870:5d8f:b0:277:c28c:147e with SMTP id
 586e51a60fabf-2962de0ba2amr9868261fac.21.1731931346557; Mon, 18 Nov 2024
 04:02:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
 <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com> <60f8eac0-9144-486b-983f-4ed09101cf0a@redhat.com>
In-Reply-To: <60f8eac0-9144-486b-983f-4ed09101cf0a@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Nov 2024 13:02:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g7rpdUjrS969stJiqqtO5zG+FTr4TOxg+SYN2dPC_9jA@mail.gmail.com>
Message-ID: <CAJZ5v0g7rpdUjrS969stJiqqtO5zG+FTr4TOxg+SYN2dPC_9jA@mail.gmail.com>
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

On Mon, Nov 18, 2024 at 12:38=E2=80=AFPM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi Rafael, Len,
>
> On 18-Nov-24 12:03 PM, Rafael J. Wysocki wrote:
> > On Sat, Nov 16, 2024 at 12:11=E2=80=AFAM Len Brown <lenb@kernel.org> wr=
ote:
> >>
> >> From: Len Brown <len.brown@intel.com>
> >>
> >> Replace msleep() with usleep_range() in acpi_os_sleep().
> >>
> >> This has a significant user-visible performance benefit
> >> on some ACPI flows on some systems.  eg. Kernel resume
> >> time of a Dell XPS-13-9300 drops from 1943ms to 1127ms (42%).
> >
> > Sure.
> >
> > And the argument seems to be that it is better to always use more
> > resources in a given path (ACPI sleep in this particular case) than to
> > be somewhat inaccurate which is visible in some cases.
> >
> > This would mean that hrtimers should always be used everywhere, but the=
y aren't.
> >
> > While I have nothing against addressing the short sleeps issue where
> > the msleep() inaccuracy is too large, I don't see why this requires
> > using a hrtimer with no slack in all cases.
> >
> > The argument seems to be that the short sleeps case is hard to
> > distinguish from the other cases, but I'm not sure about this.
> >
> > Also, something like this might work, but for some reason you don't
> > want to do it:
> >
> > if (ms >=3D 12 * MSEC_PER_SEC / HZ) {
> >         msleep(ms);
> > } else {
> >        u64 us =3D ms * USEC_PER_MSEC;
> >
> >       usleep_range(us, us / 8);

Should be

      usleep_range(us, us + us / 8);

(I notoriously confuse this API).

> > }
>
> FWIW I was thinking the same thing, that it would be good to still
> use msleep when the sleep is > (MSEC_PER_SEC / HZ), not sure
> why you added the 12 there ? Surely something like a sleep longer
> then 3 timerticks (I know we have NOHZ but still) would already be
> long enough to not worry about msleep slack ?

The typical msleep() overhead in 6.12 appears to be 1.5 jiffy which is
1.5 * MSEC_PER_SEC / HZ and I want the usleep() delta to be less than
this, so

delta =3D ms / 8 <=3D 1.5 * MSEC_PER_SEC / HZ

> And I assume the usleep_range(us, us / 8); is a typo ? Ma can
> never be less then max, maybe you meant: usleep_range(us, us + 8) ?

No, please see above.

> OTOH it is not like we will hit these ACPI acpi_os_sleep()
> calls multiple times per second all the time. On a normal idle
> system I expect there to not be that many calls (could still
> be a few from ACPI managed devices going into + out of
> runtime-pm regularly). And if don't hit acpi_os_sleep() calls
> multiple times per second then the chances of time coalescing
> are not that big anyways.
>
> Still I think that finding something middle ground between always
> sleeping the exact min time and the old msleep() call, as Rafael
> is proposing, would be good IMHO.

Thanks for the feedback!


> >> usleep_range(min, min) is used because there is scant
> >> opportunity for timer coalescing during ACPI flows
> >> related to system suspend, resume (or initialization).
> >>
> >> ie. During these flows usleep_range(min, max) is observed to
> >> be effectvely be the same as usleep_range(max, max).
> >>
> >> Similarly, msleep() for long sleeps is not considered because
> >> these flows almost never have opportunities to coalesce
> >> with other activity on jiffie boundaries, leaving no
> >> measurably benefit to rounding up to jiffie boundaries.
> >>
> >> Background:
> >>
> >> acpi_os_sleep() supports the ACPI AML Sleep(msec) operator,
> >> and it must not return before the requested number of msec.
> >>
> >> Until Linux-3.13, this contract was sometimes violated by using
> >> schedule_timeout_interruptible(j), which could return early.
> >>
> >> Since Linux-3.13, acpi_os_sleep() uses msleep(),
> >> which doesn't return early, but is still subject
> >> to long delays due to the low resolution of the jiffie clock.
> >>
> >> Linux-6.12 removed a stray jiffie from msleep: commit 4381b895f544
> >> ("timers: Remove historical extra jiffie for timeout in msleep()")
> >> The 4ms savings is material for some durations,
> >> but msleep is still generally too course. eg msleep(5)
> >> on a 250HZ system still takes 11.9ms.
> >>
> >> System resume performance of a Dell XPS 13 9300:
> >>
> >> Linux-6.11:
> >> msleep HZ 250   2460 ms
> >>
> >> Linux-6.12:
> >> msleep HZ 250   1943 ms
> >> msleep HZ 1000  1233 ms
> >> usleep HZ 250   1127 ms
> >> usleep HZ 1000  1130 ms
> >>
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D216263
> >> Signed-off-by: Len Brown <len.brown@intel.com>
> >> Suggested-by: Arjan van de Ven <arjan@linux.intel.com>
> >> Tested-by: Todd Brandt <todd.e.brandt@intel.com>
> >> ---
> >>  drivers/acpi/osl.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> >> index 70af3fbbebe5..daf87e33b8ea 100644
> >> --- a/drivers/acpi/osl.c
> >> +++ b/drivers/acpi/osl.c
> >> @@ -607,7 +607,9 @@ acpi_status acpi_os_remove_interrupt_handler(u32 g=
si, acpi_osd_handler handler)
> >>
> >>  void acpi_os_sleep(u64 ms)
> >>  {
> >> -       msleep(ms);
> >> +       u64 us =3D ms * USEC_PER_MSEC;
> >> +
> >> +       usleep_range(us, us);
> >>  }
> >>
> >>  void acpi_os_stall(u32 us)
> >> --
> >> 2.43.0
> >>
> >
>

