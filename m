Return-Path: <linux-acpi+bounces-7942-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB34963123
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 21:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C061F21DF0
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827C31ABEC7;
	Wed, 28 Aug 2024 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nk+licV5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hrEIAYDc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF301A2554;
	Wed, 28 Aug 2024 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874296; cv=none; b=Ibyj010R8I6zOugMiZqeap7F8V1gCLiDsGRCIgxb/KVw2rYMI5NM6LDXNDrlPspS0HZvpxCKWswXF9DhdumHcdxeFSwk48l6/edQipSBYN9+UKbGljYNsQ59FmURGpejswp6YxxDBW5swJIyPdF/ccu2vZqk9nYllEbLrUQFBis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874296; c=relaxed/simple;
	bh=b99Tvs/v4P+dXz/m/AfU2tdlp+L2gIsgBcvon+m0iBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bJdke+JiD6zmYTeTVhJbLuyi7fNYAFf5/GJ3jWKqzUr/rixoZhl4UH/dECsk0YA54eo5muTNBbJ2S2u/gPqkO545fwhBZw9SIkBUPpswaEL8KcCRofx1TjM1aconb2kVtLJLpIejtqZIYHmvEZnMYhsDeAa9JM38bD0+3XxMq6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nk+licV5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hrEIAYDc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724874292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NRxEhuyGDKNQE6r0QOp02t0+mI9ODKRljFUVuVm4U80=;
	b=Nk+licV5nKLzeEC3E3SSCwADDUhrt/PpWv0cXQSzTSH2viNkx+FQlS5O/Z+p5jl+Jl1sg/
	PuSnpuPoazz1Nk0/f0enoFI86ym8cyIO+Db602jBVYZPxQiJmSHVIquD+/MZNRRs5I2Bc/
	ljGht5inEBgLdKCG+r5Ngc/zopt8vOVqwpIWP6bXKBDFVO/CZeSMZsM9LSmydQgPQBAPeO
	DGJvxQhxhrWp6btM9yP6u0virgl8H3r5t/zGhwSdixKdYW41Xd3XsB8duYLkIhTbqZRsA9
	Yh8UzO3Jrq2WK+YJ7sAC+KR2X3AhDKjJNCvOTrpqRIJJRwI9MZvUnXQ4oBK6GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724874292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NRxEhuyGDKNQE6r0QOp02t0+mI9ODKRljFUVuVm4U80=;
	b=hrEIAYDc0cLw7h//qLxLims3JtLz4PwY6LQbGDeQ82xHyc/nsYcYGwMxkUFKvSBFzXjQkz
	osj4gHa12jar3kCA==
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Frederic
 Weisbecker <frederic@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH] ACPI: Remove msleep() bloat from acpi_os_sleep()
In-Reply-To: <CAJvTdKmpfs_nh4J0R8T=1P9WaAJ-nJ+mKj=rT3tqMpmvpUTisA@mail.gmail.com>
References: <2803b89021f991662b000f50e45dbaebdcca438a.1724729626.git.len.brown@intel.com>
 <CAJZ5v0jcOUoN6gDDFkufu8xWF-BHXaSKnXqraHsTkq8JanJXuQ@mail.gmail.com>
 <CAJvTdKkucaRVDZm6EVeUxwyrQexyuYd7ECUBSkpP0nC9PwzspA@mail.gmail.com>
 <CAJZ5v0jvYitb7DLyLkqTRv0TT=6yBHDvEvb8tJLzAOVKa3hqnQ@mail.gmail.com>
 <CAJZ5v0gxVqrASiuJq=UX9jyZsG=XvriFn2=7CPmG6-1sKbmPEQ@mail.gmail.com>
 <CAJvTdK=-ETniiwzwLYH14+TeU0kA49gvTnqyRxH7-Hc6tzTBUw@mail.gmail.com>
 <CAJvTdKmpfs_nh4J0R8T=1P9WaAJ-nJ+mKj=rT3tqMpmvpUTisA@mail.gmail.com>
Date: Wed, 28 Aug 2024 21:44:51 +0200
Message-ID: <87frqoig98.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

I try to give some input from the timer perspective and maybe it helps
to clarify which should be the proper way to go for acpi_os_sleep(). It
also identifies some problems with the current documentation and
implementation of msleep/fsleep.

Len Brown <lenb@kernel.org> writes:

> Attempting to grab all the loose ends from this discussion
> and put them into a list of 4 things:
>
> 1. Is it time to re-visit Jon's proposal to fix msleep, especially for
> small sleep values?

Lets have a deeper look to msleep() internals: msleep() uses timer list
timers. Because of the design of the timer wheel (granularity of buckets
increases with the levels) and because of the granularity of jiffies the
sleep values will be longer as specified. Let's assume we are executing
a msleep(1) on a HZ=250 system:

First msecs are mapped on jiffies, so this results in a 4ms timeout
value, as there is nothing shorter than 1 jiffie. Then the jiffie value
is handed over to timer code and msleep() adds another jiffie to the
timeout. The timeout is then 2 jiffies or 8ms. With this timeout a timer
list timer is queued. To make sure that timers will not fire early or
race with a concurrent incrementation of jiffie, timers are queued
always into the next bucket. As the timer will end up in the first level
of the timer wheel the granularity of the buckets is 1 jiffies. This
means that the timeout would be 3 jiffies in worst case.

The additional jiffie in msleep() is the historical prevention that the
sleep time is at least the specified time. This is handled by timer
wheel core code itself, so this extra jiffie could be removed. I will
provide a patch for it.

But even with this change, the worst case sleep length will be 8ms
instead of 1ms.

For comparison, see here a table with the values for all the steps
explained above taking some different msleep values. I already dropped
the addition of the extra jiffie. The granularity of the timer wheel
levels can be found at the first long comment in kernel/time/timer.c.

This is still a HZ=250 system:

msleep()   | msecs_to_jiffies() | worst case delay after | timer wheel
           |                    | enqueue (next bucket)  | level
--------------------------------------------------------------------------
1 ms       | 1 jiffie           | 2 jiffies, 8 ms        | 0
256 ms     | 64 jiffies         | 72 jiffies, 288 ms     | 1
257 ms     | 65 jiffies         | 72 jiffies, 288 ms     | 1
2048 ms    | 513 jiffies        | 576 jiffies, 2304 ms   | 2
2300 ms    | 575 jiffies        | 576 jiffies, 2304 ms   | 2
4096 ms    | 1024 jiffies       | 1088 jiffies, 4352 ms  | 2

The same values on a HZ=1000 system:

msleep()   | msecs_to_jiffies() | worst case delay after | timer wheel
           |                    | enqueue (next bucket)  | level
--------------------------------------------------------------------------
1 ms       | 1 jiffie           | 2 jiffies, 2 ms        | 0
256 ms     | 256 jiffies        | 264 jiffies, 264 ms    | 1
257 ms     | 257 jiffies        | 264 jiffies, 264 ms    | 1
2048 ms    | 2048 jiffies       | 2112 jiffies, 2112 ms  | 2
2300 ms    | 2300 jiffies       | 2304 jiffies, 2304 ms  | 2
4096 ms    | 4096 jiffies       | 4608 jiffies, 4608 ms  | 3


The documentation states, that msleep is not valid for short sleep
values. But as demonstrated with the two tables, this is not enirely
true. So the descision whether msleep() is suitable for the usecase is
not as simple as documented. It depends on the HZ configuration in
combination with the timeout value, and on the request how precise the
timeout has to be. And another important point is: hrtimers are more
expensive then timer list timers...

The documentation was originally written back in 2010 where the non
cascading timer wheel wasn't in place yet. So is has to be updated.

> 2. We agree that usleep_range() is appropriate for short acpi_os_sleep()
> due to ASL loops with small Sleep() values.
> But if we do something different for large and small values,
> where is the line between small and large?

As pointed out above - this depends on HZ and what the requirements of
the callsite are.

> fsleep anointed 20ms, but didn't document why.
> (and it made both short sleeps *and* long sleeps too slow to be useful
> here, IMO)

fsleep() just implements what the outdated documentation states. And it
adds a magic max value for usleep_range(). It seems to me, that fsleep()
somehow accidentially found the way into the kernel in 2020. As it is
now there this needs to be fixed and should take the above things into
account in some generic way.

> 3. Is usleep_range(min, max) with min= max bad?
> If it is good, why is virtually nobody else using min=max?

It's not bad to use it. It depends on your use case. If you really need
the precise sleep length, then it should be valid to use min = max.

I hope the timer information will help to find the proper solution for
acpi_os_sleep().

Thanks,

	Anna-Maria


