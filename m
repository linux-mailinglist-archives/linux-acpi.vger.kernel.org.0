Return-Path: <linux-acpi+bounces-963-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3187D6ED1
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 16:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C400280F58
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2189927706
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mztaV7iF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7A22D61A
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 12:52:01 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7999B189
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 05:51:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27d3ede72f6so4947633a91.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698238319; x=1698843119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RvB5kqMmUp8d1e0rOJcbxAUMfkyNt35m6Sgeu0KyMRI=;
        b=mztaV7iFjr0+5+COhpsmf/wpHvLbAoF3+yaQhER4ju9cFd5PIAgaSI87l1o5WgdKbZ
         8JBs6uTfZJgVViQhPANmAHneT69Ecs2M990ESuDG9IzOsxqpe6pGrXXOtvH9w10xn939
         s/8xu2BERIpPvVf+8pWEvx4eZg6lE6pPJB+7ZFlPAodS4AthzJg5CU7H3LclrK6FqXM2
         2lNZx0xGnT8F0p0ZbDxCMi8mCgbgV9sz+DmE0S/myMlYxRRTTbsWXD/FLTkeIts3ty7r
         Sbna1S2/HrBgJGNnW7zFh8qd9BqDhcKgPyUSfnmOksnSDwToT66lwDXmiOtS9Pnk47eq
         42jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238319; x=1698843119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvB5kqMmUp8d1e0rOJcbxAUMfkyNt35m6Sgeu0KyMRI=;
        b=NJEnXc3O9oATWtkQ19MKy+HC4bnqoUGmUixYL0HGTJWmT6MMD5so/dYBmP+jms21z8
         93wfGIO0UhrlPtkIb66aLXPiYnM4ZUF4x177Pxaz+0UbKRfxnxBqZQYpGEU1Mfca7rnI
         LenvYlDBJREUu8itZ8P3FS+X3P4B98a64YFDVJ0kWwTIUmntaR9hBhVAK8RnlPdCiCI+
         ElKGv795s/YiRLrrq77kSlH6dqIRN2J8KMZt2kFO5HBAzn2cTirtxT9F5PX9jLcsc5DY
         nlzcfmS924Ru8MRNCz3yGukh9TuGnxor/XieeAAmgIjBTv7YoLktUcD8dDmIbrYcgoh/
         WDIw==
X-Gm-Message-State: AOJu0YwR/0a0OxnKlKiNm/KuVtayUwFGN30kmovips6x+cWMI4dM3tSe
	H78HiVg3bNAKk7JfF1lyOgAMdyq9ZpdNJ1XxUNgg0Q==
X-Google-Smtp-Source: AGHT+IHijcqV2IeYBlPNx3nDgeekbmnpc78OqqMTYbjFqpHUU23WlyO9HzPiT25aLo3D0rYXf7TXF9N6YnljdscPOco=
X-Received: by 2002:a17:90a:800b:b0:26d:43f0:7ce4 with SMTP id
 b11-20020a17090a800b00b0026d43f07ce4mr14485024pjn.8.1698238318938; Wed, 25
 Oct 2023 05:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-4-vincent.guittot@linaro.org> <20231025115324.GC31201@noisy.programming.kicks-ass.net>
In-Reply-To: <20231025115324.GC31201@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 25 Oct 2023 14:51:47 +0200
Message-ID: <CAKfTPtDqFy-1dXH51JJ28XdH452K4ACrC3gr-v212s5-hH9RBw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] cpufreq/schedutil: use a fixed reference frequency
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, viresh.kumar@linaro.org, lenb@kernel.org, 
	robert.moore@intel.com, lukasz.luba@arm.com, ionela.voinescu@arm.com, 
	pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linuxfoundation.org, conor.dooley@microchip.com, 
	suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Oct 2023 at 13:53, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 18, 2023 at 06:25:37PM +0200, Vincent Guittot wrote:
>
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
> Hmm, what should x86 do here? I know it mostly doesn't use these things,
> but would it make sense to stick the base frequency in ?

get_capacity_ref_freq() should return the frequency that is used as
the reference for the max compute capacity.

On Arm64, we have seen some inconsistency especially because we use
the energy model, we compute the CPU's capacity at boot and we can
have different compute capacity in our system whereas x86 always uses
SCHED_CAPACITY_SCALE even on hybrid system if I'm not wrong

So I was not sure that this will make any difference for x86 platform

>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

