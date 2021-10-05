Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B338423240
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 22:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhJEUp0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 16:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbhJEUp0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Oct 2021 16:45:26 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AA2C061753;
        Tue,  5 Oct 2021 13:43:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f9so1525576edx.4;
        Tue, 05 Oct 2021 13:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Og2M5waf4fA2uPXVR7x75f+2DQk+Er2YOKkUnKX3nZk=;
        b=ap2vC8X6KAv1QHqhkz2q8YofK57fi+puC8XosK5Nz10ZYlMruG5LLHwPvClyBQpMWm
         8berVuZXF7txYIkit8yuznvzVaI7C5Ow7olHViNWKOyjE1GPlrb/sEujo/OeYcpMl0yW
         MGc36PE5YBgGXJINGW+BwkKb5gAXA54fzGFdXkIYFvAG+LRXz6brZlhNz6Onv6ydLvPA
         M1TbBxjrpifn65fpmH8mxNkDUY/1J/M2fyK2AKDW0b1wpD9gYXodLEHKlntCWBUDgknL
         yl+rJICcXGUvjFf6Cs7+U754p4ffpaW1FLQULNv0meKZUU91HvWYgH0yiQIxMZeBSLcY
         EZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Og2M5waf4fA2uPXVR7x75f+2DQk+Er2YOKkUnKX3nZk=;
        b=rhumTp6UJyJII+Nocf6isD35feiC6s4nGHv4PU40qDPV3BWOdt1hMNioCMh0BvIK4q
         ixEnopPyHd7Po4majZPrOfYDXbLXyU4q20LWP5wgTLZGFUmlaTGgWXydmJAjz6u0g94q
         zf+6FxhqannxHHP37A2atp1O5XVJYoFYeB0KJe1qRW4gYCFboKyvftwuZ7vDpKSs9asT
         8DtoX0BDDN8xT21woXWQ7xgpWLJeE/JeDjak3QqPtAbzPwGRgSm228boIGjksmbtujPN
         Cy/6vRMWxZISb2lMnGDODveoFHa6A0/7uQrzzgYm8HPcJr60w67O3sMmC9bMZkSk2g/H
         /yfQ==
X-Gm-Message-State: AOAM531LRHTj/4q96TC8unNBQJOSfdKKKQagFoTMs4ajcpYkSxmgeeqk
        pOvHi1TkwJxobJJhO6vbfcS/EQ1l62OcZCrmc6U=
X-Google-Smtp-Source: ABdhPJwy6b5QSPhwn9KbIlfOEPHwI/1HnWTI9L+Y+T7NDIRuCf954BxzRKe+Af1JsOXVAXjVYwbdF768KuUur7Usvb8=
X-Received: by 2002:a17:906:280f:: with SMTP id r15mr26029552ejc.559.1633466613592;
 Tue, 05 Oct 2021 13:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210924085104.44806-1-21cnbao@gmail.com> <20210924085104.44806-2-21cnbao@gmail.com>
 <87o883l9c8.mognet@arm.com>
In-Reply-To: <87o883l9c8.mognet@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 6 Oct 2021 09:43:22 +1300
Message-ID: <CAGsJ_4zCYjha8E6km9fDO8gFR-_vO1Nr0=a7V-b9yLRZGGAC9g@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/3] topology: Represent clusters of CPUs within a die
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Wed, Oct 6, 2021 at 5:34 AM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 24/09/21 20:51, Barry Song wrote:
> >  void update_siblings_masks(unsigned int cpuid)
> >  {
> >       struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
> > @@ -617,6 +622,11 @@ void update_siblings_masks(unsigned int cpuid)
> >               if (cpuid_topo->package_id != cpu_topo->package_id)
> >                       continue;
> >
> > +             if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
> > +                     cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
> > +                     cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
> > +             }
> > +
>
> Hm so without cluster information (e.g. DT system), we have
> ->cluster_id=-1, we'll essentially copy the package mask into the cluster
> mask.
>
> The exposed cluster mask is still <= package mask which is sensible. Are we
> fine with that, or do we need/want the mask to be empty in the -1 case? I'm
> guessing userspace tools should check for either id!=-1 or if the exclusive
> disjucntion of cluster vs package masks is non-empty.

Hi Valentin,
Yep, this is a very good question. I'd like change the code to:
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 7cb31d959f33..fc0836f460fb 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -622,7 +622,8 @@ void update_siblings_masks(unsigned int cpuid)
                if (cpuid_topo->package_id != cpu_topo->package_id)
                        continue;

-               if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
+               if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
+                   cpuid_topo->cluster_id != -1) {
                        cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
                        cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
                }

This should be consistent with Tim's patch3/3 for x86 in case
id is BAD_APICID:
static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
{
        ...
        /* Do not match if we do not have a valid APICID for cpu: */
        if (per_cpu(cpu_l2c_id, cpu1) == BAD_APICID)
                return false;
        ...
}

Thanks
Barry
