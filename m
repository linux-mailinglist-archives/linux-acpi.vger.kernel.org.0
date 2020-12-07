Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440E62D14BB
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 16:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgLGPaX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 10:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGPaX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 10:30:23 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0956C061749
        for <linux-acpi@vger.kernel.org>; Mon,  7 Dec 2020 07:29:42 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w13so5978297lfd.5
        for <linux-acpi@vger.kernel.org>; Mon, 07 Dec 2020 07:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1r4BkfM1HxSBgbqgEiz4060IqRLxOtaIkE30fzvcseQ=;
        b=wVcfbZmQN8la4Jkx+hhD8kP0G/xuJhBB3azFfRHFy4lhCNBOP9f/c/dGdcz/GFg6Tc
         KRtHM8XiulNddoIo91/5BatfKpCzcyOO5puiBlLsrH2QrDTLjyRrSP3RlF1orsg9TNH0
         Qp9QHimSX2UCutumFvi8/AyLXBEw2TCuodjMNTb/ZVO+TkejLbtYjq/y0Zif3RPXImGg
         Zr531Hv5fVanoktew8FUP8xdwBU1WIkktroBTC/VMr2/hlEpCg8eV3OOxsKVceNrOa1f
         ADSa/jTqWBi9a4jyyVd0XpU34VU/SFsDqARbaCvBtIhSfnUdelkC/09wWpbMfElwGJ7Q
         GH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1r4BkfM1HxSBgbqgEiz4060IqRLxOtaIkE30fzvcseQ=;
        b=US+M3fw4VAgeR91vUACEjohMW9rKI1TDYBOV06nm2cX+4ryYAVgDcalPFiW3AMDYsB
         Kbl8FMoC/Ha1yOqALNBfMcUvQTe9K3ffQKuROAGtsXer8C6WEj8ZuFJFd+BZwxFLOuwz
         nsWuWNisUCVeNSWRlJRHnW4obzhvesa7EyhoLWJMsKMrRe/n+5hlSrSmlRp3t3ZwuCdY
         PAWU7yBngYrWtTfy3/WWOu7iLUqv1qwIteijfLeNpfPcTBCMi+0+9fLDvquEQobXkS0y
         Mxbw8FIn2IxZ1U7pvmLaK3qD2vV+vV75ePfkJD2FHM5qrY3bRj9TZC69O+0+t/+q5E/o
         AZuQ==
X-Gm-Message-State: AOAM533BiU5hI+Tlhymay3ilI68sHChY3Cg98pJwdp/VQA6XIFlhuQoY
        1cx2//FqQzBH7UIugoBU8O5Tm16TCG3MvMfo0dV28w==
X-Google-Smtp-Source: ABdhPJxLzZW3MxYCggTrCcg+jYpgykLQlUaYsw5wv6HqDpuMkEuJ7tXJhfC//kvcPMlBsUAJqPWyWIq0t3ha7XtWxwA=
X-Received: by 2002:a19:cc91:: with SMTP id c139mr9247647lfg.31.1607354981132;
 Mon, 07 Dec 2020 07:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
 <20201201025944.18260-3-song.bao.hua@hisilicon.com> <CAKfTPtAppZFdku6k3cA=kNYKjU5e7w4A+E3R5_m11z+jy_WCBw@mail.gmail.com>
 <f9d9c6e959e441ec94264891ae90c11d@hisilicon.com> <CAKfTPtDqpQBcjq03cJEKN99XOZdNuV560ja9S-oZzkq7BToR8w@mail.gmail.com>
 <414fbd167b214452b925ac674575f0d6@hisilicon.com> <CAKfTPtALPjSvOZ2xf9cka9R-1uqi3AHQ+GYy7asT3wfvmLqaXw@mail.gmail.com>
 <d81006facd444d8a83bd7f1e24ccf6d9@hisilicon.com> <CAKfTPtAy_5QxnbmHq1pbGRhQYJ69ULovO6CKro-KkNKNnHMveg@mail.gmail.com>
 <b6bfb636b1404d3c827e2ba2034e6822@hisilicon.com>
In-Reply-To: <b6bfb636b1404d3c827e2ba2034e6822@hisilicon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 7 Dec 2020 16:29:29 +0100
Message-ID: <CAKfTPtCs5G4wRSuQzfb8wnkNcUDEb7zTdFK2ZY+kpLnZrHFQ0g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Cc: Len Brown" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 7 Dec 2020 at 10:59, Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Vincent Guittot [mailto:vincent.guittot@linaro.org]
> > Sent: Thursday, December 3, 2020 10:39 PM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>; Catalin Marinas
> > <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Rafael J. Wysocki
> > <rjw@rjwysocki.net>; Cc: Len Brown <lenb@kernel.org>;
> > gregkh@linuxfoundation.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
> > Ingo Molnar <mingo@redhat.com>; Peter Zijlstra <peterz@infradead.org>; Juri
> > Lelli <juri.lelli@redhat.com>; Dietmar Eggemann <dietmar.eggemann@arm.com>;
> > Steven Rostedt <rostedt@goodmis.org>; Ben Segall <bsegall@google.com>; Mel
> > Gorman <mgorman@suse.de>; Mark Rutland <mark.rutland@arm.com>; LAK
> > <linux-arm-kernel@lists.infradead.org>; linux-kernel
> > <linux-kernel@vger.kernel.org>; ACPI Devel Maling List
> > <linux-acpi@vger.kernel.org>; Linuxarm <linuxarm@huawei.com>; xuwei (O)
> > <xuwei5@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>
> > Subject: Re: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
> >
> > On Thu, 3 Dec 2020 at 10:11, Song Bao Hua (Barry Song)
> > <song.bao.hua@hisilicon.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Vincent Guittot [mailto:vincent.guittot@linaro.org]
> > > > Sent: Thursday, December 3, 2020 10:04 PM
> > > > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > > > Cc: Valentin Schneider <valentin.schneider@arm.com>; Catalin Marinas
> > > > <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Rafael J. Wysocki
> > > > <rjw@rjwysocki.net>; Cc: Len Brown <lenb@kernel.org>;
> > > > gregkh@linuxfoundation.org; Jonathan Cameron
> > <jonathan.cameron@huawei.com>;
> > > > Ingo Molnar <mingo@redhat.com>; Peter Zijlstra <peterz@infradead.org>; Juri
> > > > Lelli <juri.lelli@redhat.com>; Dietmar Eggemann
> > <dietmar.eggemann@arm.com>;
> > > > Steven Rostedt <rostedt@goodmis.org>; Ben Segall <bsegall@google.com>; Mel
> > > > Gorman <mgorman@suse.de>; Mark Rutland <mark.rutland@arm.com>; LAK
> > > > <linux-arm-kernel@lists.infradead.org>; linux-kernel
> > > > <linux-kernel@vger.kernel.org>; ACPI Devel Maling List
> > > > <linux-acpi@vger.kernel.org>; Linuxarm <linuxarm@huawei.com>; xuwei (O)
> > > > <xuwei5@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>
> > > > Subject: Re: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
> > > >
> > > > On Wed, 2 Dec 2020 at 21:58, Song Bao Hua (Barry Song)
> > > > <song.bao.hua@hisilicon.com> wrote:
> > > > >
> > > > > >
> > > > > > Sorry. Please ignore this. I added some printk here while testing
> > > > > > one numa. Will update you the data in another email.
> > > > >
> > > > > Re-tested in one NUMA node(cpu0-cpu23):
> > > > >
> > > > > g=1
> > > > > Running in threaded mode with 1 groups using 40 file descriptors
> > > > > Each sender will pass 100000 messages of 100 bytes
> > > > > w/o: 7.689 7.485 7.485 7.458 7.524 7.539 7.738 7.693 7.568 7.674=7.5853
> > > > > w/ : 7.516 7.941 7.374 7.963 7.881 7.910 7.420 7.556 7.695 7.441=7.6697
> > > > > w/ but dropped select_idle_cluster:
> > > > >      7.752 7.739 7.739 7.571 7.545 7.685 7.407 7.580 7.605 7.487=7.611
> > > > >
> > > > > g=2
> > > > > Running in threaded mode with 2 groups using 40 file descriptors
> > > > > Each sender will pass 100000 messages of 100 bytes
> > > > > w/o: 10.127 10.119 10.070 10.196 10.057 10.111 10.045 10.164 10.162
> > > > > 9.955=10.1006
> > > > > w/ : 9.694 9.654 9.612 9.649 9.686 9.734 9.607 9.842 9.690 9.710=9.6878
> > > > > w/ but dropped select_idle_cluster:
> > > > >      9.877 10.069 9.951 9.918 9.947 9.790 9.906 9.820 9.863 9.906=9.9047
> > > > >
> > > > > g=3
> > > > > Running in threaded mode with 3 groups using 40 file descriptors
> > > > > Each sender will pass 100000 messages of 100 bytes
> > > > > w/o: 15.885 15.254 15.932 15.647 16.120 15.878 15.857 15.759 15.674
> > > > > 15.721=15.7727
> > > > > w/ : 14.974 14.657 13.969 14.985 14.728 15.665 15.191 14.995 14.946
> > > > > 14.895=14.9005
> > > > > w/ but dropped select_idle_cluster:
> > > > >      15.405 15.177 15.373 15.187 15.450 15.540 15.278 15.628 15.228
> > > > 15.325=15.3591
> > > > >
> > > > > g=4
> > > > > Running in threaded mode with 4 groups using 40 file descriptors
> > > > > Each sender will pass 100000 messages of 100 bytes
> > > > > w/o: 20.014 21.025 21.119 21.235 19.767 20.971 20.962 20.914 21.090
> > > > 21.090=20.8187
> > > > > w/ : 20.331 20.608 20.338 20.445 20.456 20.146 20.693 20.797 21.381
> > > > 20.452=20.5647
> > > > > w/ but dropped select_idle_cluster:
> > > > >      19.814 20.126 20.229 20.350 20.750 20.404 19.957 19.888 20.226
> > > > 20.562=20.2306
> > > > >
> > > >
> > > > I assume that you have run this on v5.9 as previous tests.
> > >
> > > Yep
> > >
> > > > The results don't show any real benefit of select_idle_cluster()
> > > > inside a node whereas this is where we could expect most of the
> > > > benefit. We have to understand why we have such an impact on numa
> > > > tests only.
> > >
> > > There is a 4-5.5% increase while g=2 and g=3.
> >
> > my point was with vs without select_idle_cluster() but still having a
> > cluster domain level
> > In this case, the diff is -0.8% for g=1 +2.2% for g=2, +3% for g=3 and
> > -1.7% for g=4
> >
> > >
> > > Regarding the huge increase in NUMA case,  at the first beginning, I suspect
> > > we have wrong llc domain. For example, if cpu0's llc domain span
> > > cpu0-cpu47, then select_idle_cpu() is running in wrong range while
> > > it should run in cpu0-cpu23.
> > >
> > > But after printing the llc domain's span, I find it is completely right.
> > > Cpu0's llc span: cpu0-cpu23
> > > Cpu24's llc span: cpu24-cpu47
> >
> > Have you checked that the cluster mask was also correct ?
> >
> > >
> > > Maybe I need more trace data to figure out if select_idle_cpu() is running
> > > correctly. For example, maybe I can figure out if it is always returning -1,
> > > or it returns -1 very often?
> >
> > yes, could be interesting to check how often select_idle_cpu return -1
> >
> > >
> > > Or do you have any idea?
> >
> > tracking migration across nod could help to understand too
>
> I set a bootargs mem=4G to do swapping test before working on cluster
> scheduler issue. but I forgot to remove the parameter.
>
> The huge increase on across-numa case can only be reproduced while
> i use this mem=4G cmdline which means numa1 has no memory.
> After removing the limitation, I can't reproduce the huge increase
> for two NUMAs any more.

Ok. Make more sense

>
> Guess select_idle_cluster() somehow workaround an scheduler issue
> for numa without memory.
>
> >
> > Vincent
> > >
> > >
>
> Thanks
> Barry
>
