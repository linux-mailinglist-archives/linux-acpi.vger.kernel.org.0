Return-Path: <linux-acpi+bounces-1024-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD627D86CE
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 18:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C311282053
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C756E381AE
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N62rOjti"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB31D52B
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 15:13:45 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC38196
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 08:13:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b709048d8eso921494b3a.2
        for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698333223; x=1698938023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sIQNokBhQSScd068h2R0va+GxK2e4ptgRXBIV8yGO3Q=;
        b=N62rOjtivORs1dnaKyFdptn0As3ebL4e2NRp4MbtpxB9NhDjEp5XfFLDjW5wu9AikT
         v4ZEReFBnrUJnqqwDpG6EOTYtHxx3iZSge7qELAO4/Uvt/M6tPB0cCuQbRw4HPvQs8dz
         6dB9UpZt+wWSe+JfhagQGXCePRB8a/pULdL186CltT7SodHSkcsiYi5/QYd91htniKuv
         18HUO0QyHm44ye30s416GpgwfRB2jxi5uXQVNrVLSaHOqkGWlWTYooI31FEONHkgzsGa
         LRsXBkfmhFTolbfVbWPiSK+V2+oO2gTNsOQhVy5PS+HCBt44Bxii7dpGrdCRJiAbOlhs
         gUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698333223; x=1698938023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIQNokBhQSScd068h2R0va+GxK2e4ptgRXBIV8yGO3Q=;
        b=qw9VLaqE3M9F4Tk4dD0cX1+SNsoXTvhz+RK3fhX9RD6FnrC22gRVaAe1Gc+QgaQb8y
         kL4gIBNQvvWX288X390KE9bY0qwAte8Y/+z5/rE5OfbrRSilsIYNazG8jbUmc5GwoOHA
         VqG9rdbdSGhaJlDuJMCj16LilEASUU+MJYsDjBzqVNzsiR2zL8IMkRBYCCAUt8Rj8rQx
         oAk2c9REA/7SZm5vTDt/CBm+Alg4OHyGTbKG1qXLGMTpfLDaPP3pMnAzYSYfNqONRZIX
         3a+CbcGhdyCagr6SE5Bd68g3nOVdu0Olx1PdTDuJUq3xMkOiMDEfA8BRgP04eqdGNj6T
         X8bQ==
X-Gm-Message-State: AOJu0Yy0GzsGNCWLgMXkpmiLn7Wo53LKKbTL8CxDVQJ87ZKfd00TeC5A
	Iq3OfGt555JeB22U6F0p/ztsaBpSFcL5OcI30Mp7pg==
X-Google-Smtp-Source: AGHT+IHpvFfxEX2wvpX4oLmokC74kO3PgHJfv15pxMoSpuOPt/vENsjW1mHuLxZFo88vzceGkfO3QCACBcu/EM6N+5k=
X-Received: by 2002:a17:90a:1a43:b0:27d:12e1:94e0 with SMTP id
 3-20020a17090a1a4300b0027d12e194e0mr12590526pjl.36.1698333223116; Thu, 26 Oct
 2023 08:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-4-vincent.guittot@linaro.org> <f5e398f3-fbb7-4840-9084-14c8254b2118@arm.com>
In-Reply-To: <f5e398f3-fbb7-4840-9084-14c8254b2118@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 26 Oct 2023 17:13:31 +0200
Message-ID: <CAKfTPtBJRT56dL7+UW-viZuK3wKfGimQfrkvtuCQ_20g4N5LPQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] cpufreq/schedutil: use a fixed reference frequency
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, viresh.kumar@linaro.org, lenb@kernel.org, 
	robert.moore@intel.com, lukasz.luba@arm.com, ionela.voinescu@arm.com, 
	pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linuxfoundation.org, conor.dooley@microchip.com, 
	suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Oct 2023 at 22:13, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 18/10/2023 18:25, Vincent Guittot wrote:
> > cpuinfo.max_freq can change at runtime because of boost as an example. This
> > implies that the value could be different than the one that has been
> > used when computing the capacity of a CPU.
> >
> > The new arch_scale_freq_ref() returns a fixed and coherent reference
> > frequency that can be used when computing a frequency based on utilization.
> >
> > Use this arch_scale_freq_ref() when available and fallback to
> > policy otherwise.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> > Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> >
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 458d359f5991..6e4030482ae8 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -114,6 +114,28 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
> >       }
> >  }
> >
> > +/**
> > + * cpufreq_get_capacity_ref_freq - get the reference frequency of a given CPU that
>
> s/cpufreq_get_capacity_ref_freq/get_capacity_ref_freq
>
> s/of a given CPU/for a given cpufreq policy ? (of which the CPU managing
> it is used for the arch_scale_freq_ref() call in the function.
>
> > + * has been used to correlate frequency and compute capacity.
> > + * @policy: the cpufreq policy of the CPU in question.
> > + * @use_current: Fallback to current freq instead of policy->cpuinfo.max_freq.
>
> Looks like use_current does not exists as a parameter.

Thanks for the review. I'm going to apply your comments

>
> > + *
> > + * Return: the reference CPU frequency to compute a capacity.
> > + */
> > +static __always_inline
> > +unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
> > +{
> > +     unsigned int freq = arch_scale_freq_ref(policy->cpu);
> > +
> > +     if (freq)
> > +             return freq;
> > +
> > +     if (arch_scale_freq_invariant())
> > +             return policy->cpuinfo.max_freq;
> > +
> > +     return policy->cur;
> > +}
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
>
>

