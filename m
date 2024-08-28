Return-Path: <linux-acpi+bounces-7924-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 050B196255C
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 12:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837D61F24AD9
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 10:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEE116C686;
	Wed, 28 Aug 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZehxOREH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A916B3BA;
	Wed, 28 Aug 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842727; cv=none; b=BFe+L0mOB35hHvgnR4UeMrPUF/CdLJc3NmcuSMdjYO0j98sZNlwcBLKjxXhKXIhyD7HItzRfy7KSpNOao9dNVG6heGq9xg9aBPewT8GKxQ9ritVJU2RXimQtDE/qihTtWBcwFKshgXFGx+8mVGzsL98cVifUdQus6J9BfYXgT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842727; c=relaxed/simple;
	bh=OIBpT7G1A6RiJ6ofGKpzmk6SGifWb5wY/bnWF9rxNEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikQ7F0NEXprioHXE2rQnlyHNcD9kCfjQ+2Czm9P+ZJiMuVLEMeXClYvnTk3fNBKx3Xb1we6JiLQdzUpchFGyNcvhmE3lCTlnvyxMwkzCFzUGzB5p8dze46b5EYwXApG5Lv5ebXcpNVImqxiBTIQuVineTcSr+DK7r8E7+M8e16s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZehxOREH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEA9C4DDF6;
	Wed, 28 Aug 2024 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724842727;
	bh=OIBpT7G1A6RiJ6ofGKpzmk6SGifWb5wY/bnWF9rxNEg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZehxOREHhLCa0SBevKGBppx+iUM3bTNXLuR+uqqF7yCfPdmWIodKvxO6+yGSNySvK
	 zS+3sUjfXskN+7mzEMDiEsKFCd09fjSiJxII58YS7H87l0odp9cErtUY54ONdWLB9y
	 gulPMGIKKFtGHec1jrIrStut3rXICpwAs1Nrb1cJQk33/9lcP2b2UnnUkKKJwC3V6Z
	 JoXtaiqJYNXdyYb1kyDzlp2hzOIIxnHSJuLfFaQk3j5Qb5vuSc3/yfZFu72Lr5KemQ
	 hf/Ab4fR8g58GWIGgITiTiKxZtivsUo8Ojii1K1Qoh6V3yvooFzgb+V/JX/vLFpjuo
	 i2MrNCpyHwWgA==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db1956643bso1039849b6e.3;
        Wed, 28 Aug 2024 03:58:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUp//4MW2XLbBaDOYfYRv19bADItnye4bMCRCDX3iy94GW5LTzw/csl3rCME+KBfaV2yqwIXWlkCu7HLAAw@vger.kernel.org, AJvYcCWNv3bPen4LONuxnp8CFS5ocCSs+msfifPdRyvMFhIbtDX06qwmh3Eq47fVPyF+vHIyo2TnAaZH3uk=@vger.kernel.org, AJvYcCXtfu+l9Nvnmj1JkbBC+1nTO2wHPMTmN24Bo58TWJ6S+/OAanq4C1z5GQ0jSaK6jjguxrrNxaOIU8LL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv8bSYPIkqgvzYUT5MMxuB3fyrtk7MZoCOUUpzY0RyKZDzD0dy
	gezxsRunkEtfJ52faQzZdefNorIshbDKF9jxxnM+irQ1LXB/zMjI47Rc6fiLtB2u+wPYrRrnI9N
	QSaRIlFKxOV2d6zoJKsMdtaVGmZI=
X-Google-Smtp-Source: AGHT+IG3SvkxEZgayclDfrmuIw4l3ehFLNwM6X5vq9H3wX1oqTOY7EJMIG4Iesj6KV7Eo43ow/EXvhQMKq091rIVdGg=
X-Received: by 2002:a05:6871:b12:b0:261:86d:89e2 with SMTP id
 586e51a60fabf-273e66250e8mr18511296fac.36.1724842726154; Wed, 28 Aug 2024
 03:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2803b89021f991662b000f50e45dbaebdcca438a.1724729626.git.len.brown@intel.com>
 <CAJZ5v0jcOUoN6gDDFkufu8xWF-BHXaSKnXqraHsTkq8JanJXuQ@mail.gmail.com> <CAJvTdKkucaRVDZm6EVeUxwyrQexyuYd7ECUBSkpP0nC9PwzspA@mail.gmail.com>
In-Reply-To: <CAJvTdKkucaRVDZm6EVeUxwyrQexyuYd7ECUBSkpP0nC9PwzspA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Aug 2024 12:58:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jvYitb7DLyLkqTRv0TT=6yBHDvEvb8tJLzAOVKa3hqnQ@mail.gmail.com>
Message-ID: <CAJZ5v0jvYitb7DLyLkqTRv0TT=6yBHDvEvb8tJLzAOVKa3hqnQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Remove msleep() bloat from acpi_os_sleep()
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, 
	Todd Brandt <todd.e.brandt@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: multipart/mixed; boundary="000000000000fc8dcc0620bc3df2"

--000000000000fc8dcc0620bc3df2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 6:12=E2=80=AFAM Len Brown <lenb@kernel.org> wrote:
>
> On Tue, Aug 27, 2024 at 7:29=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > First, let me add a few people who know more about timers than I do.
> >
> > On Tue, Aug 27, 2024 at 5:42=E2=80=AFAM Len Brown <lenb@kernel.org> wro=
te:
> > >
> > > From: Len Brown <len.brown@intel.com>
> > >
> > > Optimize acpi_os_sleep(ms) using usleep_range(floor, ceiling).
> > > The floor of the range is the exact requested ms,
> > > with an additional 1ms of slack for sleeps above 20ms.
> > >
> > > This reduces  the kernel resume time of the Dell 9300
> > > to 1,124 ms from 2,471 ms.
> > >
> > > The ACPI AML Sleep(ms) method calls acpi_os_sleep(ms),
> > > which has invoked msleep(ms) since 2013.
> > >
> > > But msleep(ms) is based on jiffies, and the rounding-up
> > > logic to convert to jiffies on a HZ=3D250 system causes
> > > msleep(5) to bloat to a minimum of a 12ms delay.
> > > msleep(5) typically takes over 15ms!
> > >
> > > As a result, AML delay loops with small Sleep() inside
> > > magnify the entire loop.  A particularly painful example
> > > is ACPI support for powering-on ICL and TGL
> > > thunderbolt/pcie_ports during system resume.
> > >
> > > Regarding jiffy-based msleep() being inexpensive
> > > and hrtimer-based usleep_range() being expensive.
> > > ACPI AML timer invocations are rare, and so it
> > > is unlikely the hrtimer cost will be noticible,
> > > or even measurable.  At the same time, the msleep()
> > > timer duration bloat is significant enough to
> > > be noticed by end users.
> >
> > I'm not sure why you are refusing to follow the implementation of
> > fsleep() and Documentation/timers/timers-howto.rst and still use
> > msleep() for sleep durations longer than 20 ms.
>
> timers_howto.rst could use an update to reflect reality.

Maybe it could.

> It doesn't disclose how toxic msleep actually is for small values.
> msleep(1) takes 11ms on a HZ=3D250 system.
>
> Linux/ACPI has to support any random AML Sleep(ms) call,
> and sometimes we see timeout loops implemented around
> an inner Sleep(1ms).  If we use msleep those loops explode
> by 11x and aggregate durations that are noticed by end users.

So this is all about short sleeps.

You don't need to argue with me about short sleeps, I'm convinced.

Thus I'm going to skip all arguments regarding short sleeps going forward.

> fsleep does three things -- and none of them are a good fit
> for acpi_os_sleep:
>
> static inline void fsleep(unsigned long usecs)
> {
>         if (usecs <=3D 10)
>                 udelay(usecs);
>         else if (usecs <=3D 20000)
>                 usleep_range(usecs, 2 * usecs);
>         else
>                 msleep(DIV_ROUND_UP(usecs, 1000));
> }
>
> > udelay(usecs);
> will never execute in the ACPI case, as the minimum delay is 1000 usec.
>
> > usleep_range(usecs, 2 * usecs);
>
> timers-howto.rst says this:
>
>                         "With the introduction of a range, the scheduler =
is
>                         free to coalesce your wakeup with any other wakeu=
p
>                         that may have happened for other reasons, or at t=
he
>                         worst case, fire an interrupt for your upper boun=
d."
>
> But the way usleep_range works is it sets the timer for the
> upper bound, and opportunistically wakes/cancels if another timer
> fires after the lower bound and before the upper bound.

Yes, that's how it works.

> It calls it a "worst case" that the timer fires at the upper bound.
>
> But when ACPI suspend/resume flows are running the only other
> timer is the tick, and so the "worst case" happens effectively ALWAYS.

Arguably though, ACPI suspend/resume flows are not the only case in
which AML skeeps.

> So when fsleep does a usleep_range(usecs, 2 * usecs), it is effectively
> DOUBLING the duration of all timers 20 ms and smaller.
> There may be scenarios where doing this makes sense,
> but acpi_os_sleep() is not one of them.

It would be good to actually try this.

However, I'm not arguing that usleep_range(usecs, 2 * usecs) is
suitable for ACPI sleeps.  I'm saying that it is friendly with respect
to the timekeeping subsystem to give it a nonzero range if it is
affordable.

And I do think that it is affordable in the ACPI sleep case.

> > msleep(DIV_ROUND_UP(usecs, 1000));
>
> msleep(50) takes 59.8ms -- a 20% penalty.

I guess you mean on a HZ=3D250 system system and I guess this is a
measured number.

> We have loops with AML Sleep(50) in the middle,
> and this  code would bloat them by 20%, while
> the user is waiting -- for no benefit. o

If this happens during system suspend/resume and if this is the only
thing that is waited for (ie. nothing runs in parallel with it).

So your resume time is 20% longer than it can be in theory if every
Sleep() causes an extra timer interrupt to be programmed.  Is this
extra overhead justified?

> Again, there may be scenarios where doing this makes sense,
> but acpi_os_sleep() is not one of them.

I'm not convinced.

> > Why should usleep_range() be used for 100 ms sleeps, for instance?
> > This goes against the recommendation in the above document, so is
> > there a particular reason?
>
> The document doesn't say *why* msleep is recommended.
> One would assume that when there are many timers, msleep
> is efficient because it consolidates them to jiffy boundaries,
> and if they are long duration timers, perhaps the assumption is
> that they don't care so much about the additional delays?
>
> Again, there are certainly scenarios where that makes sense,
> but at the end of the day, msleep(100) takes 106 msec.

And is this a big deal really?  Is a user really going to notice the
6% difference and even if they do, would they care?  For one, I
wouldn't.

Arguably, it all depends on the intention of the developer who uses
the msleep(), os Sleep() in the AML case.

Do they mean "exactly 100 ms" or do they mean "at least 100 ms"?  If
the latter is the case, the whole argument is moot if not misguided.

As a side note, I generally think that if a developer puts Sleep(n) in
their code they need to assume that the sleep will be slightly longer
than n for reasons related to scheduling etc. so I don't believe that
they ever mean "exactly n".  However, they probably don't think that
it may take 3 times longer, so it is better to make that not happen.

> ACPI is not a heavy timer user, so the msleep efficiency justification
> for making the user wait longer holds no weight.
>
> Now that we realize that end-users notice timer bloat in acp_os_sleep,
> it is clear that msleep is simply a poor choice for acpi_os_sleep.

For short sleeps, yes.

For long sleeps, using an hrtimer generally ends up in programming an
extra timer interrupt unless the range is really wide, but then
msleep() gets better again.  So is the extra timer interrupt really
justified every time AML evaluates Sleep()?  And again, system
suspend/resume are not the only cases when that happens.

Honestly, I don't think so and that's why I prefer msleep() to be used
for longer sleeps even though it is "slacky".

> > > Regarding usleep_range() timer coalescing.
> > > It virtually never works during ACPI flows, which
> > > commonly run when there are few coalescing
> > > opportunities. As a result, the timers almost
> > > always expire at the maximum end of their specified range.
> >
> > I don't think that's the main point of using a nonzero range in
> > usleep_range().  AFAICS, this is about letting the timekeeping
> > subsystem know how much you care about timer precision so it can
> > arrange things to meet everyone's needs.
>
> The range in usleep_range is to enable timer coalescing,
> which is to reduce the number of timers firing on the system.

Exactly.  Which reduces the number of times a timer interrupts needs
to be programmed.  Which generally reduces overhead.

> If it has another purpose, neither the code nor the API documentation
> are forthcoming.
>
> > > It was tempting to use usleep_range(us, us)
> > > for all values of us.  But 1 ms is added to the
> > > range for timers over 20ms on the reasoning that
> > > the AML Sleep interface has a granularity of 1ms,
> > > most costly loops use duration under 20ms inside,
> > > and singular long sleeps are unlitly to notice an
> > > additiona 1ms, so why not allow some coalescing...
> >
> > So again, why not use msleep() for sleeps longer than 20 ms?
>
> per above.  Too slow.

per above, I'm not convinced.

> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D216263
> > > Signed-off-by: Len Brown <len.brown@intel.com>
> > > Suggested-by: Arjan van de Ven <arjan@linux.intel.com>
> > > Tested-by: Todd Brandt <todd.e.brandt@intel.com>
> > > ---
> > >  drivers/acpi/osl.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > > index 70af3fbbebe5..c4c76f86cd7a 100644
> > > --- a/drivers/acpi/osl.c
> > > +++ b/drivers/acpi/osl.c
> > > @@ -607,7 +607,13 @@ acpi_status acpi_os_remove_interrupt_handler(u32=
 gsi, acpi_osd_handler handler)
> > >
> > >  void acpi_os_sleep(u64 ms)
> > >  {
> > > -       msleep(ms);
> > > +       u64 us =3D ms * 1000;
> > > +
> > > +       if (us <=3D 20000)
> > > +               usleep_range(us, us);
> > > +       else
> > > +               usleep_range(us, us + 1000);
> > > +
> > >  }
> > >
> > >  void acpi_os_stall(u32 us)
> > > --
> >
> > While I agree with using usleep_range() for sleeps up to 20 ms in
> > acpi_os_sleep(), I disagree with the patch as is.
>
> The measurement results do not support any form of acpi_os_sleep that
> invokes any form of msleep().

That's a bold claim and it seems a bit unfounded.

Have you tested anything other than system suspend/resume?

Have you tested anything other than x86 laptops?

> Honestly, I think because of when and how acpi_os_sleep is called, we sho=
uld
> consider making it yet simpler:
>
> void acpi_os_sleep(u64 ms)
> {
>         u64 us =3D ms * 1000;
>
>         usleep_range(us, us);
> }

Which I obviously disagree with.

In the meantime I have checked how many users of usleep_range() use
the same value as both arguments of it and I have found 2 out of over
4000.

So now, is everyone clueless or is ACPI so special that it has to do
something different than everyone else?

And because I would actually like to see what the difference in terms
of system suspend/resume time is between the $subject patch and
something alternative that uses msleep() for longer sleeps and
generally uses nonzero ranges with usleep_range(), attached is a patch
to compare.

Thanks!

--000000000000fc8dcc0620bc3df2
Content-Type: text/x-patch; charset="US-ASCII"; name="acpi-os-sleep.patch"
Content-Disposition: attachment; filename="acpi-os-sleep.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m0dqsekn0>
X-Attachment-Id: f_m0dqsekn0

LS0tCiBkcml2ZXJzL2FjcGkvb3NsLmMgfCAgICA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKQoKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9vc2wuYwo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvYWNwaS9vc2wuYworKysgbGludXgtcG0vZHJp
dmVycy9hY3BpL29zbC5jCkBAIC02MDcsNiArNjA3LDEyIEBAIGFjcGlfc3RhdHVzIGFjcGlfb3Nf
cmVtb3ZlX2ludGVycnVwdF9oYW4KIAogdm9pZCBhY3BpX29zX3NsZWVwKHU2NCBtcykKIHsKKwlp
ZiAobXMgPD0gMjApIHsKKwkJdTY0IHVzID0gbXMgKiBVU0VDX1BFUl9NU0VDOworCisJCXVzbGVl
cF9yYW5nZSh1cywgdXMgKyB1cyAvIDgpOworCQlyZXR1cm47CisJfQogCW1zbGVlcChtcyk7CiB9
CiAK
--000000000000fc8dcc0620bc3df2--

