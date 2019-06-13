Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3147C43EDF
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2019 17:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfFMPxc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 11:53:32 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39192 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731609AbfFMJAn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jun 2019 05:00:43 -0400
Received: by mail-oi1-f180.google.com with SMTP id m202so13860644oig.6;
        Thu, 13 Jun 2019 02:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1g6oB3FULST6i6OE9lv24uix8T01HnnhiJ/rKeyqDw4=;
        b=c6A6D8X3PMh8IxprqCW0CkGwtxs1K/wqF1AZx1c6CDuOi00Fyqq+lrTSL6ahFLE69Z
         aaNAEiqV2NQW7MP63JUxmx/5FtnN85tzcHnpGby1/EOe8PUHQX6ObqWpDUnae/uQX+Rj
         MvmxngPtP7kHRT5SsDKq4be6kk35N7kfWNzIOESeMwllNt3cuh9eS7AQdI8w+86lduOG
         zlv5CdZHfP13VY5+PZQ+pdd3QAUWZF3D3r7qD+Dh/YK3NAFDLxi2qx88IjJ4khm9Z4mS
         3tHiREHXFAsS84l/vfYTMfrNq+u04Zn0pIcgDMdoHzm4VbJ/iIHmtj1sJhnFOHk0Vtam
         ehnQ==
X-Gm-Message-State: APjAAAVVCvaAbuRGqCGPJIHaqP4miXjDGczdjfrnxN//3QtFAdi3VG7V
        RkR2f6EP56bKjLVgLHLwbVN9cIwq7hWhjghCWfA=
X-Google-Smtp-Source: APXvYqzUOVNefo05/6irTTuw25aSVSyX0O6xqozipCR+QGw6ry2zj1WSBXumDuH2gMpis392X9eCnNq+bP+JjLS7oG8=
X-Received: by 2002:aca:3256:: with SMTP id y83mr2397576oiy.110.1560416442321;
 Thu, 13 Jun 2019 02:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190609111732.GA2885@amd> <007701d520c7$c397bda0$4ac738e0$@net>
 <CAJZ5v0j2pb2WxSA+S44Mr-6bpOx-P9A_T2-sDG3CiWSqLMg3sA@mail.gmail.com>
 <008f01d52178$07b3be70$171b3b50$@net> <20190613081158.GA6853@amd>
In-Reply-To: <20190613081158.GA6853@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Jun 2019 11:00:29 +0200
Message-ID: <CAJZ5v0hLPWsVzgRUT3_tZ6day6GzaxW2HWrK7RMaXLfpjwraOA@mail.gmail.com>
Subject: Re: 5.2-rc2: low framerate in flightgear, cpu not running at full
 speed, thermal related?
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Thu, Jun 13, 2019 at 10:12 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > On 2019.06.12 14:25 Rafael J. Wysocki wrote:
> > > On Wed, Jun 12, 2019 at 4:45 AM Doug Smythies <dsmythies@telus.net> wrote:
> > >>
> > >> So, currently there seems to be 3 issues in this thread
> > >> (and I am guessing a little, without definitive data):
> > >>
> > >> 1.) On your system Kernel 5.4-rc2 (or 4) defaults to the intel_pstate CPU frequency
> > >> scaling driver and the powersave governor, but kernel 4.6 defaults to the
> > >> acpi-cpufreq CPU frequency scaling driver and the ondemand governor.
> > >
> > > Which means that intel_pstate works in the active mode by default and
> > > so it uses its internal governor.
> >
> > Note sure what you mean by "internal governor"?
> > If you meant HWP (Hardware P-state), Pavel's processor doesn't have it.
> > If you meant the active powersave governor code within the driver, then agreed.
> >
> > > That governor is more performance-oriented than ondemand and it very
> > > well may cause more power to be allocated for the processor - at the
> > > expense of the GPU.
> >
> > O.K. I mainly use servers and so have no experience with possible GPU
> > verses CPU tradeoffs.
> >
> > However, I did re-do my tests measuring energy instead of CPU frequency
> > and found very little difference between the acpi-cpufreq/ondemand verses
> > intel_pstate/powersave as a function of single threaded load. Actually,
> > I did the test twice, one at 20 hertz work/sleep frequency and also
> > at 67 hertz work/sleep frequency. (Of course, Pavel's processor might
> > well have a different curve, but it is a similar vintage to mine
> > i5-2520M verses i7-2600K.) The worst difference was approximately
> > 1.1 extra processor package watts (an extra 5.5%) in the 80% to 85%
> > single threaded load range at 67 hertz work/sleep frequency for
> > the intel-pstate/powersave driver/governor.
> >
> > What am I saying? For a fixed amount of work to do per work/sleep cycle
> > (i.e. maybe per video frame related type work) while the CPU frequency Verses load
> > curves might differ, the resulting processor energy curve differs much less.
> > (i.e. the extra power for higher CPU frequency is for less time because it gets
> > the job done faster.) So, myself, I don't yet understand why only the one method
> > would have hit thermal throttling, but not the other (if indeed it
> > doesn't).
>
> It seems there are serious differences in reporting :-(. How do I
> determine which frequency CPU really runs at, in 4.6 kernel?

With that kernel (and the acpi-cpufreq driver) the only way is to run
your workload under turbostat.

> But it seems that your assumptions are incorrect for my workload.
>
> flightgear is single-threaded, and in my configuration saturates the
> CPU, because it would like to achieve higher framerate than my system
> is capable of.
>
> > Just for information: CPU frequency verses single threaded load curves
> > for the conservative governor is quite different between the two drivers.
> > (tests done in February, perhaps I should re-do and also look at energy
> > at the same time, or instead of CPU frequency.)
>
> So this might be my problem?

Not really, because you don't use the conservative governor. :-)

Generally, I agree with Doug that CPU performance scaling is unlikely
to be the source of the symptom that you are observing.

Anyway, if you did what I had said previously (ie. run intel_pstate in
the passive mode and use ondemand as the governor) and still see
reduced frame rate (with respect to 4.6), that would basically rule
CPU performance scaling out.

Cheers!
