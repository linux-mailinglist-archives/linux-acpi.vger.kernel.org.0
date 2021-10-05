Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10F24221F0
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 11:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhJEJRn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 05:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbhJEJRm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Oct 2021 05:17:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D578C061745;
        Tue,  5 Oct 2021 02:15:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id l7so52316484edq.3;
        Tue, 05 Oct 2021 02:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQoQa0JVYcpFPninq3MwQJ4t+aAurhAVS0gRpy1OuAU=;
        b=cHHreZie46eyV5UQtcWlPvVeR30gireFFCtLNqpyM6w/hfFeWPQYoCbPA8MNgUaivk
         jPfib+ImaKHk7EAJjapC/H1QZ68Ju4MWfx4Zd0sz7mc5yvGCGl5stcicc2b2thfblidY
         zcvyJBTpNo0qU2QZ9qBCOKgPAD8MwQ59E5bd5QtVHfFUPwru63B8iIsAJMH2AW3AkfTv
         PnjyXsg/vLcwxrkGpDCD6G5MBh4VIceNliXAnSb61DLivBaKv9I7q512+aFZVwh/nnk7
         hgIpU8D2/zg8VYS5WF4KyjKF7kX/vUJCLmMn2gSxeN1XSPMwHDUrjFDEyxBqJ8vJwa2M
         r8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQoQa0JVYcpFPninq3MwQJ4t+aAurhAVS0gRpy1OuAU=;
        b=Q7KCYbTNg3nq/6H0UvZi5tr0IMOU/wwMotT7+FEdqPPaZa1jCeRAA4b9WWjmue6iut
         Xoh5AFCSoLYl6XFCqkvNxLW3JV3pU9q/6OsvnJEb7IiEM3hbAVn+ssTlVaf3GWX+5NEJ
         CQ79UV3oCXrzpJYac/bb542iylK12dNHiC+n6JCuVYUN7N5mqpIkvUBHK/749xYkQewE
         7RLcuI3/9RcDwzJKk1xE7ZyPoOJ5hCZkxQUuv9jVHbg1teYKcqWepnk2cQ1dr30WxHIb
         VmlzlYDqhE6pYQCMacZa9/1qcDCxEWumIhB+KVK9O8GG1udB1YLj9STQ6Cj38SzqB8UH
         7FUw==
X-Gm-Message-State: AOAM5321Dv5+/AA92sftTq7BrpL5GiGZl5lpUInPitVA3jvUkklnem0T
        rbCq8BpC2XKRb3zJgX8eGCNR6Gm12QLQhL02JPg=
X-Google-Smtp-Source: ABdhPJy0htbluxxNvz1ROazf3bigM3/dNQVFayzx6fX2/fS4wVV0G7Ocw0rMmwj2gcGhjTIQRMODZgczu3OzDmJYpMA=
X-Received: by 2002:a50:cd87:: with SMTP id p7mr24668925edi.294.1633425350348;
 Tue, 05 Oct 2021 02:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210924085104.44806-1-21cnbao@gmail.com> <CAGsJ_4yW72mktbWjRfE9ngXoq9oXBXyAd_TPjKBNdGiRSoh9LA@mail.gmail.com>
 <CAKfTPtAtfJRFBbo+kBCYf42hxcc2iP8kkmg3Wcr5aW7Rnf=rfw@mail.gmail.com>
 <YVch0/R9PHzUwqea@hirez.programming.kicks-ass.net> <ece8838d112840bf26adbb09f653babcf298eb28.camel@linux.intel.com>
 <20211005075001.GJ4323@worktop.programming.kicks-ass.net>
In-Reply-To: <20211005075001.GJ4323@worktop.programming.kicks-ass.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 5 Oct 2021 22:15:39 +1300
Message-ID: <CAGsJ_4xZD0sG0Df666f0bvHOzuPMjnw0dN_mArER5k1pJ6LPLw@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/3] Represent cluster topology and enable load
 balance between clusters
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Cc: Len Brown" <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, msys.mizuma@gmail.com,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        yangyicong <yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 5, 2021 at 8:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Oct 01, 2021 at 04:22:46PM -0700, Tim Chen wrote:
> > On Fri, 2021-10-01 at 16:57 +0200, Peter Zijlstra wrote:
>
> > > The one questino I have is, do we want default y?
> >
> > I also agree that default y is preferable.
>
> I'll change at least the x86 one to:
>
>         default y
>         depends on SMP
>
> > > The one nit I have is the Kconfig text, I'm not really sure that's
> > > clarifying what a cluster is.
> >
> > Do you have a preference of a different name other than cluster?
> > Or simply better documentation on what a cluster is for ARM64
> > and x86 in Kconfig?
>
> Yes, better wording as to what a cluster is. Currently the x86 and arm64
> ones actually differ:
>
> x86:
>         help
>          Cluster scheduler support improves the CPU scheduler's decision
>          making when dealing with machines that have clusters of CPUs
>          sharing L2 cache. If unsure say N here.
>
> arm64:
>         help
>           Cluster scheduler support improves the CPU scheduler's decision
>           making when dealing with machines that have clusters(sharing internal
>           bus or sharing LLC cache tag). If unsure say N here.
>
>
> (also, all this stuff being replicated across arch/*/Kconfig seems
> unfortunate)

perhaps worth a separate patchset to do some cleanup so that SCHED_MC,
SCHED_SMT etc
won't be replicated in different architectures. Right now, this kind
of Kconfig option is copied
everywhere. I am seeing SCHED_SMT in all of
arch/arm/Kconfig
arch/arm64/Kconfig
arch/ia64/Kconfig
arch/mips/Kconfig
arch/powerpc/Kconfig
arch/s390/Kconfig
arch/sparc/Kconfig
arch/x86/Kconfig
...

Is it a better way to move them to a common Kconfig and let the architectures to
declare things like ARCH_HAVE_SMT?

Thanks
Barry
