Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1A423E2B
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Oct 2021 14:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbhJFMwu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Oct 2021 08:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhJFMwu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Oct 2021 08:52:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F2CC061749;
        Wed,  6 Oct 2021 05:50:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g10so9474325edj.1;
        Wed, 06 Oct 2021 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uaFSCyl+cHyEFqgi5ztcaVOF8EhPPHbZgq4bF8aBswg=;
        b=bzONF+1YD81iaCnIOSzpQY0hK2j7gPZMhYOJhNjrk2p609w6cy+cM7FD7ao4xj+a7Q
         4riVIoxEMGuqPPrVAFAPsM7xH3B+icu0XqF0qFg3lkvk2bWUEA25mDQajCqd/iXCb/md
         EzcTEifWyi8EIHUlTfEkfHBW3Bvizaq6ro7oFBpYyn884WZAaL8a1CC+H6MKLSUapmnf
         wDtM19JPiSpKdYal+Z8RjwGxW4gJyejk7cOvfqzFp1eKsWmRO7iEiMwkpD/AAvhmJScC
         0mCbTSFhJlHCRjLQfRpk5ffiBgGrMAc/voAdLI346txwf7e0LqE6OFlXCgaMyvqTMkeP
         n4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uaFSCyl+cHyEFqgi5ztcaVOF8EhPPHbZgq4bF8aBswg=;
        b=oON5phrEq11dBRBAMx6rPkVnS6jZWuF+AVEo0FWovVRhntyShppDPHAnqW8UsYNtPj
         6OoXYo1CaeevOfRvbIj7Fyt8GuuDY8h7dg+8I7mnd7ww63/bWEwVgcqveJCto42xkjeh
         Bs5TAE/6UdqnWbbzC6DLyXdfGsIJmtmklpGztwMhHrZPYV0h7IKdPI8cJU32QNNb9fEG
         2UM5yKaAEutascjsc6hDCjJ7mWjTfDxgA1jtyMM9ZgO7I7LRBY7Gob6jBAaUfG11Y0mj
         hRS0e3OAjBVVLF5m6sH2U+IdGCo88N++d1JgKK31CWrwnSBoP1WBNK/6vOQiZYDJvrmN
         wEPg==
X-Gm-Message-State: AOAM533b32RWEPxp0BMPRi91cj544VI0vNvGoM2aOM+pKdIH+KSfxILm
        2sC5ng4BPZ30jIAeRtUsJCbZkztkVRB5lySoA5c=
X-Google-Smtp-Source: ABdhPJw7mYXaosdY4w4BYUYEQNYUorH4f4nslmkZWqAykgwoqynTpdymnPFlEwVmRyPZjbgQKS4Ne2yyd9SAyjslPlE=
X-Received: by 2002:a50:cf4d:: with SMTP id d13mr34207091edk.50.1633524655637;
 Wed, 06 Oct 2021 05:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210924085104.44806-1-21cnbao@gmail.com> <20210924085104.44806-2-21cnbao@gmail.com>
 <87o883l9c8.mognet@arm.com> <CAGsJ_4zCYjha8E6km9fDO8gFR-_vO1Nr0=a7V-b9yLRZGGAC9g@mail.gmail.com>
 <CAGsJ_4ycKDfFY+LoaUBJ5huH8+kUsGGsC1po4DDQQPU5-ikf8A@mail.gmail.com> <20211006121858.GI174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211006121858.GI174703@worktop.programming.kicks-ass.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 7 Oct 2021 01:50:43 +1300
Message-ID: <CAGsJ_4zdr-Y5=TckNELoxgHDzNKhJuRsF5YAfEep24Ga7Y5ENg@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/3] topology: Represent clusters of CPUs within a die
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        yangyicong <yangyicong@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 7, 2021 at 1:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 06, 2021 at 11:50:35PM +1300, Barry Song wrote:
>
> > > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > > index 7cb31d959f33..fc0836f460fb 100644
> > > --- a/drivers/base/arch_topology.c
> > > +++ b/drivers/base/arch_topology.c
> > > @@ -622,7 +622,8 @@ void update_siblings_masks(unsigned int cpuid)
> > >                 if (cpuid_topo->package_id != cpu_topo->package_id)
> > >                         continue;
> > >
> > > -               if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
> > > +               if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
> > > +                   cpuid_topo->cluster_id != -1) {
> > >                         cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
> > >                         cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
> > >                 }
> > >
> >
> > Hi Peter,
> > Would you like to change this line in your tree?
>
> Can you please double check:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/next

yes. It is correct for patch 1/3, thanks!

BTW, patch2/3  is missing some benchmark data and tested-by/SOB tags, i guess
it is because you are still editing?

barry
