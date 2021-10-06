Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35F7423BC3
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Oct 2021 12:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhJFKwk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Oct 2021 06:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbhJFKwk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Oct 2021 06:52:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05F3C061755;
        Wed,  6 Oct 2021 03:50:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v18so8128785edc.11;
        Wed, 06 Oct 2021 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RnP//V6796HoXyW5g91DrP6v6JppXFbXNsT/OGvyG8=;
        b=qImZXBHHeRk0lUf6RDWqAGl5sjDtD9AeVQdko0eV+76rBlnqrSrvFl4eTYXPcOYLXb
         4HeNnlBR17kx8AMvZqVkR8LHooVlXcAQnT5ZEnUIyWaYpXOr4FxYwjRo8rgc+8DPwoCu
         CIqeNQEu6KJjCkuM20ygR8puiEeAVh0XiDzvGlK/ejb/7Uqz7RcTCcqofdrUFRR3/Mmc
         gvnMNkNTQf+iHGrNEF049FSpa9YXPUAs9F/hro+AzyS5AxtLPL6W2xg/qagAVqj9hfvo
         /5bKSDDqxluO5XrOOa+UyRSAAG6U6PTdSGd0NS/4rWq19n7Yr8UNwJt82JeRCGUvOf78
         rVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RnP//V6796HoXyW5g91DrP6v6JppXFbXNsT/OGvyG8=;
        b=sLIxSkKuy7VholT9XSOqgxKr59Cvooe+MCUPtDc5RSuOHeRofXmEOoCHhk89Lnbdf2
         l2fDiRYSAMvANE3Ldsl1AIgKWBohj8CYAF/Z3bZ8bPzRVeJIBVGyFor1ct2/H5q+lb00
         7uhCeznQQlKoZlBlE1iLvC5OzvZNWfK4BtOm+pjZ81t5kpxee6oCrc5E2C9CRXIb7deD
         XBN7bgX1/7E2gRp6hKFtFzIiWHLRxKUCKXewxLLa8iMaWfrqYSHdLPqVPzK4khW66jww
         7jMI9xzGbNugF2SZ/4Vb5v9r4Frxt7b+wqfCxKL1v40U9piZJaRHqbdiNUT2icbZqB1v
         ObSw==
X-Gm-Message-State: AOAM533Z3zdQQ9eamLlDt0fkkoT3Mc79Z/Lt+7V1gKaBB+QCVTdiAjTB
        MdRGH66yuGfDYrQkXjsCWE28bxneF+V/rL+CbNY=
X-Google-Smtp-Source: ABdhPJw75xV19FmERlZGZH9B0wc18Fupm3yUyEd9K8GKVfiJR8Cw7kDe/8ziN/hJHKheeXgJWUlFrfxi1VS71DUg3H4=
X-Received: by 2002:aa7:dd16:: with SMTP id i22mr33372235edv.167.1633517446492;
 Wed, 06 Oct 2021 03:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210924085104.44806-1-21cnbao@gmail.com> <20210924085104.44806-2-21cnbao@gmail.com>
 <87o883l9c8.mognet@arm.com> <CAGsJ_4zCYjha8E6km9fDO8gFR-_vO1Nr0=a7V-b9yLRZGGAC9g@mail.gmail.com>
In-Reply-To: <CAGsJ_4zCYjha8E6km9fDO8gFR-_vO1Nr0=a7V-b9yLRZGGAC9g@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 6 Oct 2021 23:50:35 +1300
Message-ID: <CAGsJ_4ycKDfFY+LoaUBJ5huH8+kUsGGsC1po4DDQQPU5-ikf8A@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/3] topology: Represent clusters of CPUs within a die
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
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
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        yangyicong <yangyicong@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 6, 2021 at 9:43 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Wed, Oct 6, 2021 at 5:34 AM Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> >
> > On 24/09/21 20:51, Barry Song wrote:
> > >  void update_siblings_masks(unsigned int cpuid)
> > >  {
> > >       struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
> > > @@ -617,6 +622,11 @@ void update_siblings_masks(unsigned int cpuid)
> > >               if (cpuid_topo->package_id != cpu_topo->package_id)
> > >                       continue;
> > >
> > > +             if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
> > > +                     cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
> > > +                     cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
> > > +             }
> > > +
> >
> > Hm so without cluster information (e.g. DT system), we have
> > ->cluster_id=-1, we'll essentially copy the package mask into the cluster
> > mask.
> >
> > The exposed cluster mask is still <= package mask which is sensible. Are we
> > fine with that, or do we need/want the mask to be empty in the -1 case? I'm
> > guessing userspace tools should check for either id!=-1 or if the exclusive
> > disjucntion of cluster vs package masks is non-empty.
>
> Hi Valentin,
> Yep, this is a very good question. I'd like change the code to:
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 7cb31d959f33..fc0836f460fb 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -622,7 +622,8 @@ void update_siblings_masks(unsigned int cpuid)
>                 if (cpuid_topo->package_id != cpu_topo->package_id)
>                         continue;
>
> -               if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
> +               if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
> +                   cpuid_topo->cluster_id != -1) {
>                         cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
>                         cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
>                 }
>

Hi Peter,
Would you like to change this line in your tree? Or do you want me to send
a new patchset with this small change?

> This should be consistent with Tim's patch3/3 for x86 in case
> id is BAD_APICID:
> static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
> {
>         ...
>         /* Do not match if we do not have a valid APICID for cpu: */
>         if (per_cpu(cpu_l2c_id, cpu1) == BAD_APICID)
>                 return false;
>         ...
> }

Thanks
Barry
