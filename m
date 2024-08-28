Return-Path: <linux-acpi+bounces-7945-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6609631C6
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 22:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF64285654
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 20:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5951ABED5;
	Wed, 28 Aug 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDCxxbhR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1315749A;
	Wed, 28 Aug 2024 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876980; cv=none; b=dfRR8nbkvkkbsV6osDLDkty8VsoNx+n7HGqLuC7ryJ7udzNbv5t4z7O1h+qIwAG4LnPEOgb3rO44un9CYm1hDhqZpRTaTI2IdKhMSjDTK6eCExtxqYAhg/guFIXhfAJxzRn5V4nrVSRSZP8Hfdc+z6Tco5lAoim/wKQQY2YJfxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876980; c=relaxed/simple;
	bh=azla9j7SvfXf5E/LUqTju1Q975rI+Hm7+VD9P/FTuZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orw6eDNeY5mA9/eCu1YlvpHSAj2e525bYJNuQNRRRmfn35UJniJBRyBelgXx8eLYEM31eakIfEpg+5mz/7vraOUlduSCFZZHLz9eN+ovxubIc6b1PX32bVa1v9Ujhy+JrWz0ip3fxNrFuoKVnXN5arpXPRW1nG4GwjRkW75paQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDCxxbhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC71C4CEC4;
	Wed, 28 Aug 2024 20:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724876979;
	bh=azla9j7SvfXf5E/LUqTju1Q975rI+Hm7+VD9P/FTuZo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tDCxxbhR/tcblt5YNnWwIljVgXJjWEVHfashkX0mupaPy6BogB36ASk9TOqV6Tclv
	 vkrJANfvzMNB7dQgkY2La8kI0fD4SdkGrvr5zWioQz+lRVx7y/BmBLbX66rEbIjnN9
	 S9CDh24cuzNWGz8FFvA+nd325bEP5KudgoqijbCRyWYG37evBslhPSBdSst/fDuJhz
	 KIha/B1XUiiSxkoL/hWVwFAV9iL572IZO7ji6K/qQdgiR9oplAfwcE9ArRVTnQjteb
	 6HlvgcB3J3zQ7BX5vag/h6qLbautx1cUQ/XgbnI2/3/Kmo41VgNP2LMc5zyBclaKHw
	 TRoTqpnPdYsWg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5de8ca99d15so2864200eaf.0;
        Wed, 28 Aug 2024 13:29:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwwXGAipcaC1BTB6ianIdYi0juEmFvXQ+eUTpUR96WacjWt4Pbjx8tz68LAEzbp/O3HdBTN1Fs6YqL@vger.kernel.org, AJvYcCVVAefjz+JY0YTVcI2N6TeguA4rJSeJZISo1SxwmysvX2iucxTBEsZpcSziNtdvPfW42aQ/XRjveh4CxpHC@vger.kernel.org, AJvYcCXVBaMn2gKWjnnRSRIhyaX+dAaXxHtSAwP8f+T8uOi1Xf/mYjI4bdTH99PNjZD8L6734ezjT6zf6xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbYJzGpW10CZFYkeZF7BckzUmK1TRbH/Nd9ce1jMp4MRERvyQ5
	EZeledoO98hqRWUcpMRa1XF3ZHvzFxpsuuIKwdvpMW5xJX0+dXj1FOYUNJdBVXdYk24+YU28PaX
	fIZnTChot5t71imONIImWoRiq/+8=
X-Google-Smtp-Source: AGHT+IHdxhwilfNMZYk5jyWDcmblg73Gl4saFCoHc4TM5Oii1pF4Pnt87+a6kg5n8RG0mV517MK6bTRTPjPHiCXMBzk=
X-Received: by 2002:a05:6820:22a6:b0:5c6:9320:53a3 with SMTP id
 006d021491bc7-5df97f88e20mr1100040eaf.4.1724876978849; Wed, 28 Aug 2024
 13:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2803b89021f991662b000f50e45dbaebdcca438a.1724729626.git.len.brown@intel.com>
 <CAJZ5v0jcOUoN6gDDFkufu8xWF-BHXaSKnXqraHsTkq8JanJXuQ@mail.gmail.com>
 <CAJvTdKkucaRVDZm6EVeUxwyrQexyuYd7ECUBSkpP0nC9PwzspA@mail.gmail.com>
 <CAJZ5v0jvYitb7DLyLkqTRv0TT=6yBHDvEvb8tJLzAOVKa3hqnQ@mail.gmail.com>
 <CAJZ5v0gxVqrASiuJq=UX9jyZsG=XvriFn2=7CPmG6-1sKbmPEQ@mail.gmail.com>
 <CAJvTdK=-ETniiwzwLYH14+TeU0kA49gvTnqyRxH7-Hc6tzTBUw@mail.gmail.com>
 <CAJvTdKmpfs_nh4J0R8T=1P9WaAJ-nJ+mKj=rT3tqMpmvpUTisA@mail.gmail.com> <87frqoig98.fsf@somnus>
In-Reply-To: <87frqoig98.fsf@somnus>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Aug 2024 22:29:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gTfhTQ4AMZ+ukuJZEG=RRo-wbPsf7NPbWA0snDeA5ivQ@mail.gmail.com>
Message-ID: <CAJZ5v0gTfhTQ4AMZ+ukuJZEG=RRo-wbPsf7NPbWA0snDeA5ivQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Remove msleep() bloat from acpi_os_sleep()
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 28, 2024 at 9:44=E2=80=AFPM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> Hi,
>
> I try to give some input from the timer perspective and maybe it helps
> to clarify which should be the proper way to go for acpi_os_sleep(). It
> also identifies some problems with the current documentation and
> implementation of msleep/fsleep.
>
> Len Brown <lenb@kernel.org> writes:
>
> > Attempting to grab all the loose ends from this discussion
> > and put them into a list of 4 things:
> >
> > 1. Is it time to re-visit Jon's proposal to fix msleep, especially for
> > small sleep values?
>
> Lets have a deeper look to msleep() internals: msleep() uses timer list
> timers. Because of the design of the timer wheel (granularity of buckets
> increases with the levels) and because of the granularity of jiffies the
> sleep values will be longer as specified. Let's assume we are executing
> a msleep(1) on a HZ=3D250 system:
>
> First msecs are mapped on jiffies, so this results in a 4ms timeout
> value, as there is nothing shorter than 1 jiffie. Then the jiffie value
> is handed over to timer code and msleep() adds another jiffie to the
> timeout. The timeout is then 2 jiffies or 8ms. With this timeout a timer
> list timer is queued. To make sure that timers will not fire early or
> race with a concurrent incrementation of jiffie, timers are queued
> always into the next bucket. As the timer will end up in the first level
> of the timer wheel the granularity of the buckets is 1 jiffies. This
> means that the timeout would be 3 jiffies in worst case.
>
> The additional jiffie in msleep() is the historical prevention that the
> sleep time is at least the specified time. This is handled by timer
> wheel core code itself, so this extra jiffie could be removed. I will
> provide a patch for it.
>
> But even with this change, the worst case sleep length will be 8ms
> instead of 1ms.
>
> For comparison, see here a table with the values for all the steps
> explained above taking some different msleep values. I already dropped
> the addition of the extra jiffie. The granularity of the timer wheel
> levels can be found at the first long comment in kernel/time/timer.c.
>
> This is still a HZ=3D250 system:
>
> msleep()   | msecs_to_jiffies() | worst case delay after | timer wheel
>            |                    | enqueue (next bucket)  | level
> -------------------------------------------------------------------------=
-
> 1 ms       | 1 jiffie           | 2 jiffies, 8 ms        | 0
> 256 ms     | 64 jiffies         | 72 jiffies, 288 ms     | 1
> 257 ms     | 65 jiffies         | 72 jiffies, 288 ms     | 1
> 2048 ms    | 513 jiffies        | 576 jiffies, 2304 ms   | 2
> 2300 ms    | 575 jiffies        | 576 jiffies, 2304 ms   | 2
> 4096 ms    | 1024 jiffies       | 1088 jiffies, 4352 ms  | 2
>
> The same values on a HZ=3D1000 system:
>
> msleep()   | msecs_to_jiffies() | worst case delay after | timer wheel
>            |                    | enqueue (next bucket)  | level
> -------------------------------------------------------------------------=
-
> 1 ms       | 1 jiffie           | 2 jiffies, 2 ms        | 0
> 256 ms     | 256 jiffies        | 264 jiffies, 264 ms    | 1
> 257 ms     | 257 jiffies        | 264 jiffies, 264 ms    | 1
> 2048 ms    | 2048 jiffies       | 2112 jiffies, 2112 ms  | 2
> 2300 ms    | 2300 jiffies       | 2304 jiffies, 2304 ms  | 2
> 4096 ms    | 4096 jiffies       | 4608 jiffies, 4608 ms  | 3
>
>
> The documentation states, that msleep is not valid for short sleep
> values. But as demonstrated with the two tables, this is not enirely
> true. So the descision whether msleep() is suitable for the usecase is
> not as simple as documented. It depends on the HZ configuration in
> combination with the timeout value, and on the request how precise the
> timeout has to be. And another important point is: hrtimers are more
> expensive then timer list timers...
>
> The documentation was originally written back in 2010 where the non
> cascading timer wheel wasn't in place yet. So is has to be updated.
>
> > 2. We agree that usleep_range() is appropriate for short acpi_os_sleep(=
)
> > due to ASL loops with small Sleep() values.
> > But if we do something different for large and small values,
> > where is the line between small and large?
>
> As pointed out above - this depends on HZ and what the requirements of
> the callsite are.
>
> > fsleep anointed 20ms, but didn't document why.
> > (and it made both short sleeps *and* long sleeps too slow to be useful
> > here, IMO)
>
> fsleep() just implements what the outdated documentation states. And it
> adds a magic max value for usleep_range(). It seems to me, that fsleep()
> somehow accidentially found the way into the kernel in 2020. As it is
> now there this needs to be fixed and should take the above things into
> account in some generic way.
>
> > 3. Is usleep_range(min, max) with min=3D max bad?
> > If it is good, why is virtually nobody else using min=3Dmax?
>
> It's not bad to use it. It depends on your use case. If you really need
> the precise sleep length, then it should be valid to use min =3D max.
>
> I hope the timer information will help to find the proper solution for
> acpi_os_sleep().

Yes, it is useful, thank you!

The main difficulty is that acpi_os_sleep() really works on behalf of
AML code (it is called when the Sleep() operator is evaluated in AML)
and it is hard to say what behavior is intended there.

We know that the msleep() precision is not sufficient at least in some
cases (for example, a high-count loop in AML that sleeps for 5 ms in
every iteration), but we don't really know what precision is needed.

IMV it generally is reasonable to assume that firmware developers
would not expect the exact sleep time (and the ACPI specification is
not very precise regarding this either), but they wouldn't also expect
sleep times much longer (in relative terms) than requested.  So
roughly speaking they probably assume something between t and t + t/4,
where t is the requested sleep time in milliseconds, regardless of the
HZ value.

Also, you said above that hrtimers were more expensive than the timer
wheel timers, which we all agree with, but it is not clear to me what
exactly the difference is.  For example, if there is a loop of 1000
iterations in AML that each sleep for 5 ms, how much more overhead
from using hrtimers would be there relative to using timer-wheel
timers?

Generally speaking, Len's idea of using usleep_range() for all sleep
lengths in acpi_os_sleep() is compelling because it leads to simple
code, but it is not clear to me how much more it would cost relative
to msleep() (or what issues it may provoke for that matter) and what
delta value to use in there.  One idea is to derive the delta from the
sleep length (say, take 1/4 of it like I did above), but the
counter-argument is that this would cause the loops in AML in question
to take measurably more time and there may be no real reason for it.

Thanks!

