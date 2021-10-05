Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1729042218F
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 11:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhJEJDT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 05:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbhJEJDP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Oct 2021 05:03:15 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937F7C061745;
        Tue,  5 Oct 2021 02:01:25 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r18so75549290edv.12;
        Tue, 05 Oct 2021 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/JMF5PTsagU14rl507p5qWSZ3mM5KtFOO51GywSxPU=;
        b=AgzMTQCdSGhueF/1Vku2VVCQvMkX1w2lASdLwkcvyKN9nslYhrB3l0Rd3kb/WJNYgJ
         oEu2wyCs+w8oIAiXMG71gC4bwPPEMp8rmu0SfrVqNcqMl9nwxasPTGlgiP605s4o46vH
         MnYby3KILQT1lSSsien8SfS9KZPreY8zA4PpR6cP2O3MkFNNki34mAYSnqVt3+mFY30G
         y0gLxKuWOaya69iNl+Sac8+WeFVsRPkFYUYoXgde1k183rb3fyU8AXl3AsWrevcZpeKt
         IeghNIcXTb0LJ3xTJb+xWboS/o1YGKU61vBgLgW1wDMBJpA99sHTTGIfvzPoUeba4VdI
         IwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/JMF5PTsagU14rl507p5qWSZ3mM5KtFOO51GywSxPU=;
        b=LrNY30MSjWt63VKIgX//xY21Kjsju1vCEalkvroIGE4IAoXFtL9x/kGng27X/OeLen
         Zo0MJnEgJvgFY3W14nG43g38VxdbykHVnIX+Q/30Ddhh8v3L4gSxMU2Ctue/Hu1om6iu
         K2r0wC7qiorF/AsysuZlB6z3MybZAZHByA9ugHUn3tGyQY3qpwsq6JML/VRDOAMtljlL
         Ta/JbpB3T6zMyMhMwP4zMaVuQmKmw/TmgkINvqhVSrW4xRdZ6sc6QB9P7BLl513r9WKS
         Ob7M97NJbHy67amQps75Hf4b/I1dvG5WMJzNUTdSfimitl+i88Wmmyf1Z0HzwU6k3yK7
         2ZYA==
X-Gm-Message-State: AOAM533AyoXfRInS4FtOBj5goC9FGjHHzx8gvFZu5VW0qHgAD5WPz7eK
        5V3WxSOSJpFLHzRHO/ktjcczgyaQfiFwpHeuNpE=
X-Google-Smtp-Source: ABdhPJzvEYz126Iu0CSKlra6VcZQZlIZX3t91YvaGBVmeME/sdr1XkEAPCmMYK0mh5WQ9pbJhfC0TNGsTUWjykTcIK0=
X-Received: by 2002:a50:cd87:: with SMTP id p7mr24590483edi.294.1633424480610;
 Tue, 05 Oct 2021 02:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210924085104.44806-1-21cnbao@gmail.com> <20210924085104.44806-3-21cnbao@gmail.com>
 <20211005073544.GI4323@worktop.programming.kicks-ass.net>
In-Reply-To: <20211005073544.GI4323@worktop.programming.kicks-ass.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 5 Oct 2021 22:01:09 +1300
Message-ID: <CAGsJ_4zCCKmyV7SpwCjwqiMj5Cch=CMd_np71uSXdqeGhZjRRg@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/3] scheduler: Add cluster scheduler level in core
 and related Kconfig for ARM64
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        yangyicong <yangyicong@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 5, 2021 at 8:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Sep 24, 2021 at 08:51:03PM +1200, Barry Song wrote:
> > From: Barry Song <song.bao.hua@hisilicon.com>
> >
>
> >
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
>
> That is not a valid SoB pattern. The first SoB should be the author, the
> last SoB should be the one sending the patch, in this case both are
> Barry. What's Yicong's contribution in all this?

Yicong made the benchmarks of SPECrate and collected the result data which
is in the commit log. I am not quite sure what is the best tag for
him. Is Tested-by
appropriate in this case?

Thanks
barry
