Return-Path: <linux-acpi+bounces-7913-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F195961D4F
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 06:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE32A1F2479A
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 04:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50E01474B5;
	Wed, 28 Aug 2024 04:06:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D364A;
	Wed, 28 Aug 2024 04:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724818001; cv=none; b=jxY6TR6JZOKsqEjATmBTxxKVzVksX06/pLAj9150Vz0FHwYBz2JT3P3tYt5MfSKG2S8NTaQjsQ6rilszjkcb+//fEquz73kxCUlueuVrKXrqv0KQZLJqWuN1fifssR3sDfkpN8QIHqSoUIoFv25unhVkR2S/SsRFFKH0+OXaPp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724818001; c=relaxed/simple;
	bh=wwf+OQyIKysNGIvd81VUp3kLMb/OOHPlnxGaSu4g1k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfUsssqo/ELFmeDDUMfP46WG1IjXp+lNnPMIaawg0at2WludyKuXSqqUI95hQS2SvmnqNwJXlMcLwSpFm19pndufhx/ItlNIDzAefJdwnvxFY+TYhmwjTpac2kURbQIRH1LuhMy9qvWXBRQQ9fKux0g496QIRXy7436c1VWLYJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3dc16d00ba6so916858b6e.0;
        Tue, 27 Aug 2024 21:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724817999; x=1725422799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5Pwrf9PAUtwtkVY34xRe125byTeFc6RM91G/i63L5Y=;
        b=KDzK5gAnjobsj+3qL9F8cRVrUgIM/Oobo+IzC3CeR1d4/n40Bwl3eNnXDDRkCFgtM7
         HzaZHMA/fzUzoFc3fG2zgwT3MSHCsdUWHf9TVNFnr4oyV7My4YIlG1Gg25D82fuwUSib
         4ml3+yrYppMoZPVqjW+VIPohKMLjPJ0QXhjH4ylF1P+bhMJOB8b5ZccaO2GsqySFUJkQ
         L0TGK6b93iYzmlWOYpdYu1/yfo+GvnajNkQK8hawbDLUhTynFp4yMXCgXRSPB9OpA8k3
         CRBekknwZo+aJVuKU0STqah+oIOnH7y223JdrL43LEdzTNGcmT9c94Y7IJhz0X5pKnvr
         3HOg==
X-Forwarded-Encrypted: i=1; AJvYcCVUIrnHj3ySF6okEhqwGHFTUXCSk5dhs6IBjdBZSJ7DRKHsz/bBlyBC588LD4i99nzlQl7voriwc4AIO+lr@vger.kernel.org, AJvYcCWXnhZAgPv71t0hH+Il6GxsB8FGpwbOzrWUDP8EH6MCc4S363j4y6Vd3gElvJgs1a35VEHwCYvHMwvH@vger.kernel.org, AJvYcCWo1h8AYzxNCmjfz8e15xCA2QxqPf1SyBNmsaQmLA4Gxwrzw0tFWUhJ2gJ8tS2RpJRb0rT+s2gtLhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvIoUAYvrTeBEfUPPZzJPedxqJZPNKGHy92SmHkPETcJR4aN7
	HyT0TiBWYvT/jz+rD8z/dgxfIa77n0tNwqJ7Lh9E51ShLgot5jKIOYRzP0Hs+6fsuY3CJ0wD2jq
	LVA2MEH2Ka/wEjIQa0YZ/+wihX5k=
X-Google-Smtp-Source: AGHT+IGCpGss4254t5HnEUDtHI1fEuWcNMuQgSKbxwLqyWSfXldzt/fwp2SUaZFhDv3SG4OhV1XUClpkzfjPY35RB6E=
X-Received: by 2002:a05:6808:1402:b0:3db:3b15:7e76 with SMTP id
 5614622812f47-3deffba7abfmr1002946b6e.47.1724817998956; Tue, 27 Aug 2024
 21:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2803b89021f991662b000f50e45dbaebdcca438a.1724729626.git.len.brown@intel.com>
 <CAJZ5v0jcOUoN6gDDFkufu8xWF-BHXaSKnXqraHsTkq8JanJXuQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jcOUoN6gDDFkufu8xWF-BHXaSKnXqraHsTkq8JanJXuQ@mail.gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Wed, 28 Aug 2024 00:06:27 -0400
Message-ID: <CAJvTdKkucaRVDZm6EVeUxwyrQexyuYd7ECUBSkpP0nC9PwzspA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Remove msleep() bloat from acpi_os_sleep()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
	Arjan van de Ven <arjan@linux.intel.com>, Todd Brandt <todd.e.brandt@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 7:29=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> First, let me add a few people who know more about timers than I do.
>
> On Tue, Aug 27, 2024 at 5:42=E2=80=AFAM Len Brown <lenb@kernel.org> wrote=
:
> >
> > From: Len Brown <len.brown@intel.com>
> >
> > Optimize acpi_os_sleep(ms) using usleep_range(floor, ceiling).
> > The floor of the range is the exact requested ms,
> > with an additional 1ms of slack for sleeps above 20ms.
> >
> > This reduces  the kernel resume time of the Dell 9300
> > to 1,124 ms from 2,471 ms.
> >
> > The ACPI AML Sleep(ms) method calls acpi_os_sleep(ms),
> > which has invoked msleep(ms) since 2013.
> >
> > But msleep(ms) is based on jiffies, and the rounding-up
> > logic to convert to jiffies on a HZ=3D250 system causes
> > msleep(5) to bloat to a minimum of a 12ms delay.
> > msleep(5) typically takes over 15ms!
> >
> > As a result, AML delay loops with small Sleep() inside
> > magnify the entire loop.  A particularly painful example
> > is ACPI support for powering-on ICL and TGL
> > thunderbolt/pcie_ports during system resume.
> >
> > Regarding jiffy-based msleep() being inexpensive
> > and hrtimer-based usleep_range() being expensive.
> > ACPI AML timer invocations are rare, and so it
> > is unlikely the hrtimer cost will be noticible,
> > or even measurable.  At the same time, the msleep()
> > timer duration bloat is significant enough to
> > be noticed by end users.
>
> I'm not sure why you are refusing to follow the implementation of
> fsleep() and Documentation/timers/timers-howto.rst and still use
> msleep() for sleep durations longer than 20 ms.

timers_howto.rst could use an update to reflect reality.

It doesn't disclose how toxic msleep actually is for small values.
msleep(1) takes 11ms on a HZ=3D250 system.

Linux/ACPI has to support any random AML Sleep(ms) call,
and sometimes we see timeout loops implemented around
an inner Sleep(1ms).  If we use msleep those loops explode
by 11x and aggregate durations that are noticed by end users.

fsleep does three things -- and none of them are a good fit
for acpi_os_sleep:

static inline void fsleep(unsigned long usecs)
{
        if (usecs <=3D 10)
                udelay(usecs);
        else if (usecs <=3D 20000)
                usleep_range(usecs, 2 * usecs);
        else
                msleep(DIV_ROUND_UP(usecs, 1000));
}

> udelay(usecs);
will never execute in the ACPI case, as the minimum delay is 1000 usec.

> usleep_range(usecs, 2 * usecs);

timers-howto.rst says this:

                        "With the introduction of a range, the scheduler is
                        free to coalesce your wakeup with any other wakeup
                        that may have happened for other reasons, or at the
                        worst case, fire an interrupt for your upper bound.=
"

But the way usleep_range works is it sets the timer for the
upper bound, and opportunistically wakes/cancels if another timer
fires after the lower bound and before the upper bound.

It calls it a "worst case" that the timer fires at the upper bound.

But when ACPI suspend/resume flows are running the only other
timer is the tick, and so the "worst case" happens effectively ALWAYS.

So when fsleep does a usleep_range(usecs, 2 * usecs), it is effectively
DOUBLING the duration of all timers 20 ms and smaller.
There may be scenarios where doing this makes sense,
but acpi_os_sleep() is not one of them.

> msleep(DIV_ROUND_UP(usecs, 1000));

msleep(50) takes 59.8ms -- a 20% penalty.
We have loops with AML Sleep(50) in the middle,
and this  code would bloat them by 20%, while
the user is waiting -- for no benefit. o
Again, there may be scenarios where doing this makes sense,
but acpi_os_sleep() is not one of them.


> Why should usleep_range() be used for 100 ms sleeps, for instance?
> This goes against the recommendation in the above document, so is
> there a particular reason?

The document doesn't say *why* msleep is recommended.
One would assume that when there are many timers, msleep
is efficient because it consolidates them to jiffy boundaries,
and if they are long duration timers, perhaps the assumption is
that they don't care so much about the additional delays?

Again, there are certainly scenarios where that makes sense,
but at the end of the day, msleep(100) takes 106 msec.

ACPI is not a heavy timer user, so the msleep efficiency justification
for making the user wait longer holds no weight.

Now that we realize that end-users notice timer bloat in acp_os_sleep,
it is clear that msleep is simply a poor choice for acpi_os_sleep.

> > Regarding usleep_range() timer coalescing.
> > It virtually never works during ACPI flows, which
> > commonly run when there are few coalescing
> > opportunities. As a result, the timers almost
> > always expire at the maximum end of their specified range.
>
> I don't think that's the main point of using a nonzero range in
> usleep_range().  AFAICS, this is about letting the timekeeping
> subsystem know how much you care about timer precision so it can
> arrange things to meet everyone's needs.

The range in usleep_range is to enable timer coalescing,
which is to reduce the number of timers firing on the system.
If it has another purpose, neither the code nor the API documentation
are forthcoming.

> > It was tempting to use usleep_range(us, us)
> > for all values of us.  But 1 ms is added to the
> > range for timers over 20ms on the reasoning that
> > the AML Sleep interface has a granularity of 1ms,
> > most costly loops use duration under 20ms inside,
> > and singular long sleeps are unlitly to notice an
> > additiona 1ms, so why not allow some coalescing...
>
> So again, why not use msleep() for sleeps longer than 20 ms?

per above.  Too slow.

> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D216263
> > Signed-off-by: Len Brown <len.brown@intel.com>
> > Suggested-by: Arjan van de Ven <arjan@linux.intel.com>
> > Tested-by: Todd Brandt <todd.e.brandt@intel.com>
> > ---
> >  drivers/acpi/osl.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > index 70af3fbbebe5..c4c76f86cd7a 100644
> > --- a/drivers/acpi/osl.c
> > +++ b/drivers/acpi/osl.c
> > @@ -607,7 +607,13 @@ acpi_status acpi_os_remove_interrupt_handler(u32 g=
si, acpi_osd_handler handler)
> >
> >  void acpi_os_sleep(u64 ms)
> >  {
> > -       msleep(ms);
> > +       u64 us =3D ms * 1000;
> > +
> > +       if (us <=3D 20000)
> > +               usleep_range(us, us);
> > +       else
> > +               usleep_range(us, us + 1000);
> > +
> >  }
> >
> >  void acpi_os_stall(u32 us)
> > --
>
> While I agree with using usleep_range() for sleeps up to 20 ms in
> acpi_os_sleep(), I disagree with the patch as is.

The measurement results do not support any form of acpi_os_sleep that
invokes any form of msleep().

Honestly, I think because of when and how acpi_os_sleep is called, we shoul=
d
consider making it yet simpler:

void acpi_os_sleep(u64 ms)
{
        u64 us =3D ms * 1000;

        usleep_range(us, us);
}

thanks,
-Len

