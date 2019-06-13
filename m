Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C731643F24
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2019 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbfFMPzL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 11:55:11 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40395 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731561AbfFMIxL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jun 2019 04:53:11 -0400
Received: by mail-ot1-f44.google.com with SMTP id x24so18192548otp.7;
        Thu, 13 Jun 2019 01:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxA2TuQ76TdBmK7s0p6DMBbnrU5zVRKKjjHLZHr3Nrw=;
        b=Yxz1PrfEwG+xwQfQrX5q9OYleNmlcuAsJPTmLfQ7gVKEvAR+96Fjki1WJPeX8bRYQl
         HuR4VQZkg7hv4n6r23V00pi6LnVo5kXHsecCxBP5tGF79PKKtJ+fXOELR7U9Xt4GRTcn
         9CibEfBsWSxilq23lhLLpqkO/T/ruOYn0f5G8II2BuQmEbATtOJRLLYf/F3ffTRGHZ3+
         gEw4dPeWEqb5pqH2RXLQrDSD+JsZVYpGJfwbV+UDkfo69J3moMWNSLxkrqg0Q69sAM0Q
         kSLwi60ID8UTSnBe7YcyTgv6x11TvRIeUGBcEvFsTOyq2cknIxdlMJhByhe54Hz5xD7r
         Zk4Q==
X-Gm-Message-State: APjAAAUi4EVEc8cS8f5ENKqe7SrlOIXGcr+dWSzNLyj01OZXWkDFETFk
        1V3VZUet3YydJfMKSltr+DlIrJWwrHJHi+RAnHjviQ==
X-Google-Smtp-Source: APXvYqyI1lj+Z+cGNfdobQgfAVNEbIpL2r7FCl8K1bHleKh5pVvYkSHmP3FF0kCptnpXUK5RHTkVoifYko+1nXHyn24=
X-Received: by 2002:a9d:5f05:: with SMTP id f5mr36455415oti.167.1560415990521;
 Thu, 13 Jun 2019 01:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190609111732.GA2885@amd> <007701d520c7$c397bda0$4ac738e0$@net>
 <CAJZ5v0j2pb2WxSA+S44Mr-6bpOx-P9A_T2-sDG3CiWSqLMg3sA@mail.gmail.com> <008f01d52178$07b3be70$171b3b50$@net>
In-Reply-To: <008f01d52178$07b3be70$171b3b50$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Jun 2019 10:52:57 +0200
Message-ID: <CAJZ5v0gRaDe6Fajdx3wqaLz9LQr6Z6iD+2yrrZeXJV+3HiAOZg@mail.gmail.com>
Subject: Re: 5.2-rc2: low framerate in flightgear, cpu not running at full
 speed, thermal related?
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 13, 2019 at 1:40 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2019.06.12 14:25 Rafael J. Wysocki wrote:
> > On Wed, Jun 12, 2019 at 4:45 AM Doug Smythies <dsmythies@telus.net> wrote:
> >>
> >> So, currently there seems to be 3 issues in this thread
> >> (and I am guessing a little, without definitive data):
> >>
> >> 1.) On your system Kernel 5.4-rc2 (or 4) defaults to the intel_pstate CPU frequency
> >> scaling driver and the powersave governor, but kernel 4.6 defaults to the
> >> acpi-cpufreq CPU frequency scaling driver and the ondemand governor.
> >
> > Which means that intel_pstate works in the active mode by default and
> > so it uses its internal governor.
>
> Note sure what you mean by "internal governor"?
> If you meant HWP (Hardware P-state), Pavel's processor doesn't have it.
> If you meant the active powersave governor code within the driver, then agreed.

That's what I mean.

> > That governor is more performance-oriented than ondemand and it very
> > well may cause more power to be allocated for the processor - at the
> > expense of the GPU.
>
> O.K. I mainly use servers and so have no experience with possible GPU
> verses CPU tradeoffs.
>
> However, I did re-do my tests measuring energy instead of CPU frequency
> and found very little difference between the acpi-cpufreq/ondemand verses
> intel_pstate/powersave as a function of single threaded load. Actually,
> I did the test twice, one at 20 hertz work/sleep frequency and also
> at 67 hertz work/sleep frequency. (Of course, Pavel's processor might
> well have a different curve, but it is a similar vintage to mine
> i5-2520M verses i7-2600K.) The worst difference was approximately
> 1.1 extra processor package watts (an extra 5.5%) in the 80% to 85%
> single threaded load range at 67 hertz work/sleep frequency for
> the intel-pstate/powersave driver/governor.

I see.  Then this shouldn't matter.

> What am I saying? For a fixed amount of work to do per work/sleep cycle
> (i.e. maybe per video frame related type work) while the CPU frequency Verses load
> curves might differ, the resulting processor energy curve differs much less.
> (i.e. the extra power for higher CPU frequency is for less time because it gets
> the job done faster.) So, myself, I don't yet understand why only the one method
> would have hit thermal throttling, but not the other (if indeed it doesn't).
> Other differences between kernel 4.6 and 5.2-rc? might explain it.

Right.

I personally doubt that any thermal throttling is involved here.

> I did all my tests on kernel 5.2-rc3, except that one example from kernel 4.4 on my
> earlier reply, so that were not other variables than CPU scaling driver and
> governor changes.
>
> > The lower-than-expected frame rate may result from that, in principle.
>
> > One way to mitigate that might be to use intel_pstate in the passive
> > mode (pass intel_pstate=passive to the kernel in the command line)
> > along with either ondemand or schedutil as the governor.
>
> The CPU frequency verses load curves for this those two governors are very similar
> for both the acpi_cpufreq and intel_cpufreq (which is the intel_pstate driver
> in passive mode) drivers.

That's what I would expect.

Cheers!
