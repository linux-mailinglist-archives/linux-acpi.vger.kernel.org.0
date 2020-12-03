Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EAC2CD2FD
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Dec 2020 10:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbgLCJzD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Dec 2020 04:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388619AbgLCJzD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2020 04:55:03 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AC5C061A4E
        for <linux-acpi@vger.kernel.org>; Thu,  3 Dec 2020 01:54:22 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id a1so513399ljq.3
        for <linux-acpi@vger.kernel.org>; Thu, 03 Dec 2020 01:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wEueHcV7l/ctvMvBAXQKBWYAUOQJ5GZrrhWLBwBeD4o=;
        b=rNuyqmJ5C2MhebdamXLkPH+dVt6AdIFw5GuyIWWpgzKbEhsEab0J+yt5FA89LvtYEy
         AXOv9K+LUJ5KkzCL3CzUABhpWP3EMkVFmEtzDVrsJeoPWKoYVodZK++P9LyEtM1gs4a7
         WSKRNoY913ctUeHc0ZvLRDPlvHCGFLXocy4F0xlfXtkv1WB9PaRZ2D9dhAn1ly0AF6fJ
         rrW9fi1J0Rd3cgDM2xBQcF3wwgBdqRfnP8j8pibuqGD1twuxmEscFPq+nBbh0b46jhG0
         14Ugpem3J6WbxQs3pk/bsox0x6Pv7rt28Eh/I03moh6cGtcjyKfOYH/9vbynfFzfz/sH
         wPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wEueHcV7l/ctvMvBAXQKBWYAUOQJ5GZrrhWLBwBeD4o=;
        b=SpoArhtUxx26sDmjIbEP4ZhjT7OtzsvKK177b0TcwGX6yiELzKsUVKdbRb5hWTZhJQ
         nfRxvnm1e4PPmXI6zDbO6ylOhYC66wsmeJLsOyuvJ9O9u+++/AYExidSrVFDeEgPP61u
         /GJaAbRbI4LlPxqfEwzhe0bHHuAxWBC++26CmXxU7K3oimfc3+bOswqZSUdeTelw5dm5
         LKynemRWu7agCfYfpulwTVZkG9g6IJBDYsdpAKEmit/1/Vyp52xP/z4lSFlbdZhr5Ho0
         vWybQhnrsnIc7JkGzdj30d4HGddxtZw2bJ3PyEAhGIOZ6X7tGIlSl8orAJPekiyFtWhK
         0DBg==
X-Gm-Message-State: AOAM531C2McMtlswTIO3xk7ZEIfat7mnVGllAKFITt3KgiV0kpJfsjbx
        lTyRYAr8mYHqo3uyeSyfn0k6DZm8m+9bSFmeJRo7wg==
X-Google-Smtp-Source: ABdhPJwdjaSsw7GE05hNk15bu9q/1poMmL86Ci331MBFX4yFGGVAd9RviAK5X2nqsWakHczDAvzczO+p7F7KynjSr28=
X-Received: by 2002:a2e:b8d0:: with SMTP id s16mr884517ljp.423.1606989260776;
 Thu, 03 Dec 2020 01:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
 <20201201025944.18260-3-song.bao.hua@hisilicon.com> <CAKfTPtAppZFdku6k3cA=kNYKjU5e7w4A+E3R5_m11z+jy_WCBw@mail.gmail.com>
 <f9d9c6e959e441ec94264891ae90c11d@hisilicon.com> <CAKfTPtDqpQBcjq03cJEKN99XOZdNuV560ja9S-oZzkq7BToR8w@mail.gmail.com>
 <414fbd167b214452b925ac674575f0d6@hisilicon.com> <CAKfTPtALPjSvOZ2xf9cka9R-1uqi3AHQ+GYy7asT3wfvmLqaXw@mail.gmail.com>
 <d81006facd444d8a83bd7f1e24ccf6d9@hisilicon.com> <CAKfTPtAy_5QxnbmHq1pbGRhQYJ69ULovO6CKro-KkNKNnHMveg@mail.gmail.com>
In-Reply-To: <CAKfTPtAy_5QxnbmHq1pbGRhQYJ69ULovO6CKro-KkNKNnHMveg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 3 Dec 2020 10:54:09 +0100
Message-ID: <CAKfTPtDaU9G43-8EEUP04R343_bBtomRX_iAxJUCbY6FciOKTQ@mail.gmail.com>
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

On Thu, 3 Dec 2020 at 10:39, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Thu, 3 Dec 2020 at 10:11, Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Vincent Guittot [mailto:vincent.guittot@linaro.org]
> > > Sent: Thursday, December 3, 2020 10:04 PM
> > > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > > Cc: Valentin Schneider <valentin.schneider@arm.com>; Catalin Marinas
> > > <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Rafael J. Wysocki
> > > <rjw@rjwysocki.net>; Cc: Len Brown <lenb@kernel.org>;
> > > gregkh@linuxfoundation.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
> > > Ingo Molnar <mingo@redhat.com>; Peter Zijlstra <peterz@infradead.org>; Juri
> > > Lelli <juri.lelli@redhat.com>; Dietmar Eggemann <dietmar.eggemann@arm.com>;
> > > Steven Rostedt <rostedt@goodmis.org>; Ben Segall <bsegall@google.com>; Mel
> > > Gorman <mgorman@suse.de>; Mark Rutland <mark.rutland@arm.com>; LAK
> > > <linux-arm-kernel@lists.infradead.org>; linux-kernel
> > > <linux-kernel@vger.kernel.org>; ACPI Devel Maling List
> > > <linux-acpi@vger.kernel.org>; Linuxarm <linuxarm@huawei.com>; xuwei (O)
> > > <xuwei5@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>
> > > Subject: Re: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
> > >
> > > On Wed, 2 Dec 2020 at 21:58, Song Bao Hua (Barry Song)
> > > <song.bao.hua@hisilicon.com> wrote:
> > > >
> > > > >
> > > > > Sorry. Please ignore this. I added some printk here while testing
> > > > > one numa. Will update you the data in another email.
> > > >
> > > > Re-tested in one NUMA node(cpu0-cpu23):
> > > >
> > > > g=1
> > > > Running in threaded mode with 1 groups using 40 file descriptors
> > > > Each sender will pass 100000 messages of 100 bytes
> > > > w/o: 7.689 7.485 7.485 7.458 7.524 7.539 7.738 7.693 7.568 7.674=7.5853
> > > > w/ : 7.516 7.941 7.374 7.963 7.881 7.910 7.420 7.556 7.695 7.441=7.6697
> > > > w/ but dropped select_idle_cluster:
> > > >      7.752 7.739 7.739 7.571 7.545 7.685 7.407 7.580 7.605 7.487=7.611
> > > >
> > > > g=2
> > > > Running in threaded mode with 2 groups using 40 file descriptors
> > > > Each sender will pass 100000 messages of 100 bytes
> > > > w/o: 10.127 10.119 10.070 10.196 10.057 10.111 10.045 10.164 10.162
> > > > 9.955=10.1006
> > > > w/ : 9.694 9.654 9.612 9.649 9.686 9.734 9.607 9.842 9.690 9.710=9.6878
> > > > w/ but dropped select_idle_cluster:
> > > >      9.877 10.069 9.951 9.918 9.947 9.790 9.906 9.820 9.863 9.906=9.9047
> > > >
> > > > g=3
> > > > Running in threaded mode with 3 groups using 40 file descriptors
> > > > Each sender will pass 100000 messages of 100 bytes
> > > > w/o: 15.885 15.254 15.932 15.647 16.120 15.878 15.857 15.759 15.674
> > > > 15.721=15.7727
> > > > w/ : 14.974 14.657 13.969 14.985 14.728 15.665 15.191 14.995 14.946
> > > > 14.895=14.9005
> > > > w/ but dropped select_idle_cluster:
> > > >      15.405 15.177 15.373 15.187 15.450 15.540 15.278 15.628 15.228
> > > 15.325=15.3591
> > > >
> > > > g=4
> > > > Running in threaded mode with 4 groups using 40 file descriptors
> > > > Each sender will pass 100000 messages of 100 bytes
> > > > w/o: 20.014 21.025 21.119 21.235 19.767 20.971 20.962 20.914 21.090
> > > 21.090=20.8187
> > > > w/ : 20.331 20.608 20.338 20.445 20.456 20.146 20.693 20.797 21.381
> > > 20.452=20.5647
> > > > w/ but dropped select_idle_cluster:
> > > >      19.814 20.126 20.229 20.350 20.750 20.404 19.957 19.888 20.226
> > > 20.562=20.2306
> > > >
> > >
> > > I assume that you have run this on v5.9 as previous tests.
> >
> > Yep
> >
> > > The results don't show any real benefit of select_idle_cluster()
> > > inside a node whereas this is where we could expect most of the
> > > benefit. We have to understand why we have such an impact on numa
> > > tests only.
> >
> > There is a 4-5.5% increase while g=2 and g=3.
>
> my point was with vs without select_idle_cluster() but still having a
> cluster domain level
> In this case, the diff is -0.8% for g=1 +2.2% for g=2, +3% for g=3 and
> -1.7% for g=4
>
> >
> > Regarding the huge increase in NUMA case,  at the first beginning, I suspect
> > we have wrong llc domain. For example, if cpu0's llc domain span
> > cpu0-cpu47, then select_idle_cpu() is running in wrong range while
> > it should run in cpu0-cpu23.
> >
> > But after printing the llc domain's span, I find it is completely right.
> > Cpu0's llc span: cpu0-cpu23
> > Cpu24's llc span: cpu24-cpu47
>
> Have you checked that the cluster mask was also correct ?
>
> >
> > Maybe I need more trace data to figure out if select_idle_cpu() is running
> > correctly. For example, maybe I can figure out if it is always returning -1,
> > or it returns -1 very often?
>
> yes, could be interesting to check how often select_idle_cpu return -1
>
> >
> > Or do you have any idea?
>
> tracking migration across nod could help to understand too

Also the v6 of https://lkml.org/lkml/2020/11/26/187 might also help you

>
> Vincent
> >
> >
> > >
> > > > Thanks
> > > > Barry
> >
> > Thanks
> > Barry
> >
