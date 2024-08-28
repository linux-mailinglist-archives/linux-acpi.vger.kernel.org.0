Return-Path: <linux-acpi+bounces-7926-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F99628C1
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 15:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C831C2122E
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 13:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8947178399;
	Wed, 28 Aug 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoKrnfFe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9B16BE35;
	Wed, 28 Aug 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852131; cv=none; b=GL8Tj4wfsAuDowBuWFp/T/hwfaSG1Ww3CuE5xKkWhQdfoAP5DYSMvF9fANmYnho/7FvnaCdpO687H+VKhqRU3VUnh/YxZqrAp4EMoXRSwo7JrawOYFRvRkfOLcWoznfYGxq5ydqGW/rxh9LGNwj6PXfK9QAlZMzHGakHIiDPfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852131; c=relaxed/simple;
	bh=hb8ivNeFPyAij0EIKV0xA4CtdUN4vdwVdI3d4INdBLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0/BXy259xrdmSlgTUmRUnJ064C+EVKNuq0F48pkMVhLt3eqzAkA58mXZULWThcNh/i3M/KEPiXErqfMOWfZySpf0bR5qKqpsGErcfICDaXAT+G7n5+MWLJg6EVP/+etNNKHObyXrKP7dY9xtCa/57Lo0xWdc4uGTZRQXzknees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoKrnfFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A686C51EEF;
	Wed, 28 Aug 2024 13:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724852131;
	bh=hb8ivNeFPyAij0EIKV0xA4CtdUN4vdwVdI3d4INdBLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UoKrnfFeeyuEb0VHx4AuPeoinLMhdjdvVTK44V0QyxGePe4czkdb9zF3oYSdmBomj
	 f2W6ivRw0y/MYa8ViWZDUlL84VcxGd99qKa544Bp+WthvEF6XVgyNb+Fgb9Hbew/aS
	 q8nfWI4cplklpyCCV3S2Qf6Ki8VF5kowg/9Oj+JZT53HRFk82e/a757r61GQqG50b9
	 VTBt6bkQkEkVllbGYraUlEgiHaHTeqAhFmsHKhEuhramNso/hzHmFWyhAuSjvHRtPV
	 iFCm3IIbgwBNvzbsTw6SLSNNQuN+/8KEtggZsLvs7lFC+bh0IkS+zIrUbdt+dRaZ8P
	 SoCSvXhIwbJKA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-27032e6dbf2so4290038fac.1;
        Wed, 28 Aug 2024 06:35:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXQcS6a0mo5V2pb9Nx0MHmaX+GleNRMVVXRKt2T5dXoXbSgoLY1DKHi8uQsxR9tOAfKCu0xXprhSty@vger.kernel.org, AJvYcCVKOtyGLWLEQFGqFw4NpWaIags7vKqRBYgq+zs9tLE2CfCg9LNlodXsqjFJfmaJuIhsEId4UXP2+ixAsn3Z@vger.kernel.org, AJvYcCXJ04GtfZ61e3XWvsEZfFPxrId1vcPg0mYqI++O9EUv4tHVvsEtdZp1OfWzBfcj2hGrwC62X7iCNEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykaVtMFKOCiVO3EmY5UL38u8o3Btx5NUnY23++zfHqmod+NdGy
	7LxkjfMB+MoinK9Y+A3qZJjV5L9a54H94dF2td7QTD1QPsEtEz/J7oi68ciUApnzaC3dwgQNypp
	8q4PWp23BsTZyCZ3AVJDRMsbKvMg=
X-Google-Smtp-Source: AGHT+IETmWZY8t+lmbkR74cl6UbZGgBGOoxMRK8SeLAxqV4G/3UE+2wPnGqQngjPp233gHccxvtic7bRPaNhsaA15wM=
X-Received: by 2002:a05:6870:e310:b0:259:ae64:9234 with SMTP id
 586e51a60fabf-273e64d7798mr17601995fac.13.1724852130425; Wed, 28 Aug 2024
 06:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2803b89021f991662b000f50e45dbaebdcca438a.1724729626.git.len.brown@intel.com>
 <CAJZ5v0jcOUoN6gDDFkufu8xWF-BHXaSKnXqraHsTkq8JanJXuQ@mail.gmail.com>
 <CAJvTdKkucaRVDZm6EVeUxwyrQexyuYd7ECUBSkpP0nC9PwzspA@mail.gmail.com> <CAJZ5v0jvYitb7DLyLkqTRv0TT=6yBHDvEvb8tJLzAOVKa3hqnQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jvYitb7DLyLkqTRv0TT=6yBHDvEvb8tJLzAOVKa3hqnQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Aug 2024 15:35:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gxVqrASiuJq=UX9jyZsG=XvriFn2=7CPmG6-1sKbmPEQ@mail.gmail.com>
Message-ID: <CAJZ5v0gxVqrASiuJq=UX9jyZsG=XvriFn2=7CPmG6-1sKbmPEQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Remove msleep() bloat from acpi_os_sleep()
To: Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
	Arjan van de Ven <arjan@linux.intel.com>, Todd Brandt <todd.e.brandt@intel.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:58=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Wed, Aug 28, 2024 at 6:12=E2=80=AFAM Len Brown <lenb@kernel.org> wrote=
:
> >
> > On Tue, Aug 27, 2024 at 7:29=E2=80=AFAM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > First, let me add a few people who know more about timers than I do.
> > >
> > > On Tue, Aug 27, 2024 at 5:42=E2=80=AFAM Len Brown <lenb@kernel.org> w=
rote:
> > > >
> > > > From: Len Brown <len.brown@intel.com>
> > > >
> > > > Optimize acpi_os_sleep(ms) using usleep_range(floor, ceiling).
> > > > The floor of the range is the exact requested ms,
> > > > with an additional 1ms of slack for sleeps above 20ms.
> > > >
> > > > This reduces  the kernel resume time of the Dell 9300
> > > > to 1,124 ms from 2,471 ms.
> > > >
> > > > The ACPI AML Sleep(ms) method calls acpi_os_sleep(ms),
> > > > which has invoked msleep(ms) since 2013.
> > > >
> > > > But msleep(ms) is based on jiffies, and the rounding-up
> > > > logic to convert to jiffies on a HZ=3D250 system causes
> > > > msleep(5) to bloat to a minimum of a 12ms delay.
> > > > msleep(5) typically takes over 15ms!
> > > >
> > > > As a result, AML delay loops with small Sleep() inside
> > > > magnify the entire loop.  A particularly painful example
> > > > is ACPI support for powering-on ICL and TGL
> > > > thunderbolt/pcie_ports during system resume.
> > > >
> > > > Regarding jiffy-based msleep() being inexpensive
> > > > and hrtimer-based usleep_range() being expensive.
> > > > ACPI AML timer invocations are rare, and so it
> > > > is unlikely the hrtimer cost will be noticible,
> > > > or even measurable.  At the same time, the msleep()
> > > > timer duration bloat is significant enough to
> > > > be noticed by end users.
> > >
> > > I'm not sure why you are refusing to follow the implementation of
> > > fsleep() and Documentation/timers/timers-howto.rst and still use
> > > msleep() for sleep durations longer than 20 ms.
> >
> > timers_howto.rst could use an update to reflect reality.
>
> Maybe it could.
>
> > It doesn't disclose how toxic msleep actually is for small values.
> > msleep(1) takes 11ms on a HZ=3D250 system.
> >
> > Linux/ACPI has to support any random AML Sleep(ms) call,
> > and sometimes we see timeout loops implemented around
> > an inner Sleep(1ms).  If we use msleep those loops explode
> > by 11x and aggregate durations that are noticed by end users.
>
> So this is all about short sleeps.
>
> You don't need to argue with me about short sleeps, I'm convinced.
>
> Thus I'm going to skip all arguments regarding short sleeps going forward=
.
>
> > fsleep does three things -- and none of them are a good fit
> > for acpi_os_sleep:
> >
> > static inline void fsleep(unsigned long usecs)
> > {
> >         if (usecs <=3D 10)
> >                 udelay(usecs);
> >         else if (usecs <=3D 20000)
> >                 usleep_range(usecs, 2 * usecs);
> >         else
> >                 msleep(DIV_ROUND_UP(usecs, 1000));
> > }
> >
> > > udelay(usecs);
> > will never execute in the ACPI case, as the minimum delay is 1000 usec.
> >
> > > usleep_range(usecs, 2 * usecs);
> >
> > timers-howto.rst says this:
> >
> >                         "With the introduction of a range, the schedule=
r is
> >                         free to coalesce your wakeup with any other wak=
eup
> >                         that may have happened for other reasons, or at=
 the
> >                         worst case, fire an interrupt for your upper bo=
und."
> >
> > But the way usleep_range works is it sets the timer for the
> > upper bound, and opportunistically wakes/cancels if another timer
> > fires after the lower bound and before the upper bound.
>
> Yes, that's how it works.
>
> > It calls it a "worst case" that the timer fires at the upper bound.
> >
> > But when ACPI suspend/resume flows are running the only other
> > timer is the tick, and so the "worst case" happens effectively ALWAYS.
>
> Arguably though, ACPI suspend/resume flows are not the only case in
> which AML skeeps.
>
> > So when fsleep does a usleep_range(usecs, 2 * usecs), it is effectively
> > DOUBLING the duration of all timers 20 ms and smaller.
> > There may be scenarios where doing this makes sense,
> > but acpi_os_sleep() is not one of them.
>
> It would be good to actually try this.
>
> However, I'm not arguing that usleep_range(usecs, 2 * usecs) is
> suitable for ACPI sleeps.  I'm saying that it is friendly with respect
> to the timekeeping subsystem to give it a nonzero range if it is
> affordable.
>
> And I do think that it is affordable in the ACPI sleep case.
>
> > > msleep(DIV_ROUND_UP(usecs, 1000));
> >
> > msleep(50) takes 59.8ms -- a 20% penalty.
>
> I guess you mean on a HZ=3D250 system system and I guess this is a
> measured number.
>
> > We have loops with AML Sleep(50) in the middle,
> > and this  code would bloat them by 20%, while
> > the user is waiting -- for no benefit. o
>
> If this happens during system suspend/resume and if this is the only
> thing that is waited for (ie. nothing runs in parallel with it).
>
> So your resume time is 20% longer than it can be in theory if every
> Sleep() causes an extra timer interrupt to be programmed.  Is this
> extra overhead justified?
>
> > Again, there may be scenarios where doing this makes sense,
> > but acpi_os_sleep() is not one of them.
>
> I'm not convinced.
>
> > > Why should usleep_range() be used for 100 ms sleeps, for instance?
> > > This goes against the recommendation in the above document, so is
> > > there a particular reason?
> >
> > The document doesn't say *why* msleep is recommended.
> > One would assume that when there are many timers, msleep
> > is efficient because it consolidates them to jiffy boundaries,
> > and if they are long duration timers, perhaps the assumption is
> > that they don't care so much about the additional delays?
> >
> > Again, there are certainly scenarios where that makes sense,
> > but at the end of the day, msleep(100) takes 106 msec.
>
> And is this a big deal really?  Is a user really going to notice the
> 6% difference and even if they do, would they care?  For one, I
> wouldn't.
>
> Arguably, it all depends on the intention of the developer who uses
> the msleep(), os Sleep() in the AML case.
>
> Do they mean "exactly 100 ms" or do they mean "at least 100 ms"?  If
> the latter is the case, the whole argument is moot if not misguided.
>
> As a side note, I generally think that if a developer puts Sleep(n) in
> their code they need to assume that the sleep will be slightly longer
> than n for reasons related to scheduling etc. so I don't believe that
> they ever mean "exactly n".  However, they probably don't think that
> it may take 3 times longer, so it is better to make that not happen.
>
> > ACPI is not a heavy timer user, so the msleep efficiency justification
> > for making the user wait longer holds no weight.
> >
> > Now that we realize that end-users notice timer bloat in acp_os_sleep,
> > it is clear that msleep is simply a poor choice for acpi_os_sleep.
>
> For short sleeps, yes.
>
> For long sleeps, using an hrtimer generally ends up in programming an
> extra timer interrupt unless the range is really wide, but then
> msleep() gets better again.  So is the extra timer interrupt really
> justified every time AML evaluates Sleep()?  And again, system
> suspend/resume are not the only cases when that happens.
>
> Honestly, I don't think so and that's why I prefer msleep() to be used
> for longer sleeps even though it is "slacky".

That being said, I've read the thread mentioned in timers-howto.rst
and it turns out to be interesting in the context of this patch.

So Jon attempted to reimplement msleep() with the help of hrtimers and
it basically worked except that it broke USB mouse hotplug for Andrew.
IIUC, this issue was the reason why that patch was not applied.

But this appears to mean that there are no fundamental objections to
using hrtimers for long sleeps even though it is still recommended to
use msleep() in that case.  So it all boils down to the question: If a
sleep is relatively long, say 100 ms or longer, why exactly is
msleep(delay) more suitable for it than usleep_range(delay, delay +
delta), where delta is of the order of 1 jiffy?

I get that msleep() is based on tick and so it does not require an
extra hrtimer (which leads to programming an additional timer
interrupt in many cases), but is it worth the trouble of checking the
delay and using msleep() instead of usleep_range() if the sleep is
long enough?

I'm not sure now TBH.

