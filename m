Return-Path: <linux-acpi+bounces-7965-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86799964A2C
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 17:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABE21C23737
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 15:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC491B29B5;
	Thu, 29 Aug 2024 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MlbTH8aE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Evby9xhJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D171AE020;
	Thu, 29 Aug 2024 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945823; cv=none; b=Tc+xm1PijzMxbuTzhrIwVmeqJFlfHJVBghNIEYwuPt+Pvh4m4bFR1AK77rsdXQVOe5ECUE7OaL5IRRGA507UqTAsv5ksWLD9ZSER65ckI2wd33o6pQoGv4bTxNRM9lcNboxRgfgQigw2DF2TKMH2a68l/19ipSn8oX/n14D98Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945823; c=relaxed/simple;
	bh=uNMSD59SIdrbcpakpTpWGElsEhFT76kgcDZpVA4jhVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fljGx4ktdrmP0dh2LEKiWlChvpNhq78YOlor3SH7GEawrwUVpqoP1dL1AEvbjAPWcJfJrP8u1e4mudaJLA7FaDvw+EkGTSa6edfdO+K8xQx/4cuOxgH9GEP6obhjgNz/PE2POt6b8zNSKMqVC69a0y4d57JNfluqPKzeOQIggrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MlbTH8aE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Evby9xhJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724945820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BpuW8ERx6pekJ0kb9zGktKKn7BCYgNyQb7nanzclB/w=;
	b=MlbTH8aERbLDsllOgpy55rlb+UvAliHBidCVJ0keQBP/S99pjGa3WM/dBC2iQa+nwl2NXW
	O6iY0+mzezokE1CYLx63U6RqZz+v9qkIB2u+7cg+F7x+FWBrhDNHxz2EWS2EeCFKX72xU7
	WSAdVWfymE8LYTK9Y9yQjjk4FLJ8TdVNuAxVbdDEHSbREXSMhVMaQF/GpBcOIBjSqZZkr1
	Ofcdrf1+Mb9r7OY5x3hcdw+/h5McJipmsyiLQRJ4upkH0Kw3ZW4JqqdRpALaUq7EX8lizl
	LpStVSXSykFIJJEunSyWhUBDCzYqEWYx298tL6B4Hbh+RjwdCRS6SfGHxcvZmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724945820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BpuW8ERx6pekJ0kb9zGktKKn7BCYgNyQb7nanzclB/w=;
	b=Evby9xhJRWcmm0x5YSARZIjI7ynYWux5KuIUH2kzFqD1LNDXSKgSuOZCxHcBtcB1aJBrr7
	n0WMFhioNpsxkaAQ==
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Frederic
 Weisbecker <frederic@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH] ACPI: Remove msleep() bloat from acpi_os_sleep()
In-Reply-To: <CAJZ5v0gTfhTQ4AMZ+ukuJZEG=RRo-wbPsf7NPbWA0snDeA5ivQ@mail.gmail.com>
References: <2803b89021f991662b000f50e45dbaebdcca438a.1724729626.git.len.brown@intel.com>
 <CAJZ5v0jcOUoN6gDDFkufu8xWF-BHXaSKnXqraHsTkq8JanJXuQ@mail.gmail.com>
 <CAJvTdKkucaRVDZm6EVeUxwyrQexyuYd7ECUBSkpP0nC9PwzspA@mail.gmail.com>
 <CAJZ5v0jvYitb7DLyLkqTRv0TT=6yBHDvEvb8tJLzAOVKa3hqnQ@mail.gmail.com>
 <CAJZ5v0gxVqrASiuJq=UX9jyZsG=XvriFn2=7CPmG6-1sKbmPEQ@mail.gmail.com>
 <CAJvTdK=-ETniiwzwLYH14+TeU0kA49gvTnqyRxH7-Hc6tzTBUw@mail.gmail.com>
 <CAJvTdKmpfs_nh4J0R8T=1P9WaAJ-nJ+mKj=rT3tqMpmvpUTisA@mail.gmail.com>
 <87frqoig98.fsf@somnus>
 <CAJZ5v0gTfhTQ4AMZ+ukuJZEG=RRo-wbPsf7NPbWA0snDeA5ivQ@mail.gmail.com>
Date: Thu, 29 Aug 2024 17:36:59 +0200
Message-ID: <878qwf9w84.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

"Rafael J. Wysocki" <rafael@kernel.org> writes:

[...]

> The main difficulty is that acpi_os_sleep() really works on behalf of
> AML code (it is called when the Sleep() operator is evaluated in AML)
> and it is hard to say what behavior is intended there.
>
> We know that the msleep() precision is not sufficient at least in some
> cases (for example, a high-count loop in AML that sleeps for 5 ms in
> every iteration), but we don't really know what precision is needed.
>
> IMV it generally is reasonable to assume that firmware developers
> would not expect the exact sleep time (and the ACPI specification is
> not very precise regarding this either), but they wouldn't also expect
> sleep times much longer (in relative terms) than requested.  So
> roughly speaking they probably assume something between t and t + t/4,
> where t is the requested sleep time in milliseconds, regardless of the
> HZ value.
>
> Also, you said above that hrtimers were more expensive than the timer
> wheel timers, which we all agree with, but it is not clear to me what
> exactly the difference is.  For example, if there is a loop of 1000
> iterations in AML that each sleep for 5 ms, how much more overhead
> from using hrtimers would be there relative to using timer-wheel
> timers?

The general differences are:
- hrtimers are using a rbtree instead of hasing, which is more expensive
- in case the new hrtimer is the new first hrtimer, hardware has to be
  programmed, which is expensive too
- the timer wheel uses batching. hrtimers not. They might get an
  own interrupt for every hrtimer when they do not have the exact same
  expiry time.
- because of the above it is a lot more expensive to use hrtimers when
  hrtimers are cancelled and requeued with a new expiry time (like
  e.g. network timeouts do it)

It's hard to measure, because it depends... I briefly talked to Thomas
and his opinion is, that there is an overhead but it should be in a
range of ok.

> Generally speaking, Len's idea of using usleep_range() for all sleep
> lengths in acpi_os_sleep() is compelling because it leads to simple
> code, but it is not clear to me how much more it would cost relative
> to msleep() (or what issues it may provoke for that matter) and what
> delta value to use in there.  One idea is to derive the delta from the
> sleep length (say, take 1/4 of it like I did above), but the
> counter-argument is that this would cause the loops in AML in question
> to take measurably more time and there may be no real reason for it.

I created a patch for fsleep() - only complie tested - which should make
sure that the slack is maximum 25%. What do you think about it? Might it
be helpful?

---8<---
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -78,15 +78,36 @@ static inline void ssleep(unsigned int s
 	msleep(seconds * 1000);
 }
 
-/* see Documentation/timers/timers-howto.rst for the thresholds */
+/**
+ * fsleep - flexible sleep which autoselects the best mechanism
+ * @usecs:	requested sleep duration in microseconds
+ *
+ * flseep() selects the best mechanism that will provide maximum 25% slack
+ * to the requested sleep duration. Therefore it uses:
+ *
+ * - udelay() loop for sleep durations <= 10 microseconds to avoid hrtimer
+ *   overhead for really short sleep durations.
+ *
+ * - usleep_range() for sleep durations which would lead with the usage of
+ *   msleep() to a slack larger than 25%. This depends on the granularity of
+ *   jiffies.
+ *
+ * - msleep() for all other sleep durations.
+ *
+ * Note: When CONFIG_HIGH_RES_TIMERS is not set, all sleeps are processed with
+ * the granularity of jiffies and the slack might exceed 25% especially for
+ * short sleep durations.
+ */
 static inline void fsleep(unsigned long usecs)
 {
+	const unsigned int max_slack_shift = 2;
+
 	if (usecs <= 10)
 		udelay(usecs);
-	else if (usecs <= 20000)
-		usleep_range(usecs, 2 * usecs);
+	else if (usecs < ((TICK_NSEC << max_slack_shift) / NSEC_PER_USEC))
+		usleep_range(usecs, usecs + (usecs >> max_slack_shift));
 	else
-		msleep(DIV_ROUND_UP(usecs, 1000));
+		msleep(DIV_ROUND_UP(usecs, USEC_PER_MSEC));
 }
 
 #endif /* defined(_LINUX_DELAY_H) */
---8<----

Thanks,

	Anna-Maria


