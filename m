Return-Path: <linux-acpi+bounces-965-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 193027D6ED4
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 16:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A43CB20BAA
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701082AB36
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsXfvXNB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F5A2D61A
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 12:54:41 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A768C1
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 05:54:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27d0a173e61so3988698a91.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 05:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698238479; x=1698843279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CPGldAWJyTZnXByR/bf8zHHVWHLwPdXuNiykPl5PWWs=;
        b=AsXfvXNB9bok6QDzbgPvuhhCwL5P6ZCRyWz+ef1Daz72BzYgRORqtgHlA2VQxbY1KR
         b0rjiI2Dex0FFRcrjwqiZnFAMN4iLFC/L46FOY3gpVRiFI0eLNmI8ksAKUhrMULbpYTx
         quwzwkE/QeHr2c/FszukPkxY3/a4vHtuQBsuwKYI7w2GKCdoYBsBJDNmjNEyW3s56Vh5
         dm6ZcS6ywljXpbZc8F/utyxLS86Xz+EkWQ8ipasGk20B2AGVns2bHssGTXktinGyOqx1
         SwihwVVJviSatJ/Qs4a9EF3XLPyQARbuLDXPEUByJkIoU/3+AJLN+/7dtkOq5pT2H2PN
         9PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238479; x=1698843279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPGldAWJyTZnXByR/bf8zHHVWHLwPdXuNiykPl5PWWs=;
        b=Igjr/k1oJTWEF1aDB3YcUD2qvyFTLUtHv66bffitIGWjDM4ICj2hryRWX1tTma0sIf
         tVWJMpcUkI6twRNUgy6eGYyYgl1otgVOA4404ohXD6MQhVKcPUeo1VeSUZKh5H2lj+dx
         2fci0nUIcvmRmyFOEzDbqX9XTDiPz+qfCYwmI0RPrK9upTAJoKfBq+6NvrKE/RX/reD2
         phHvzwy0nSMmAmf2DUm4VWd79ny7X4uzPEz6qZz8bE1zffnj1KkrdLCO681aYTRMwRa+
         HTbCNH6sEVvzc3EtJ206eItGEoXLnvAmZjjTJQKDASj986UeInXK5qHvB4mBlw8vO7Ey
         kEmA==
X-Gm-Message-State: AOJu0YwlJvWmXmkndcOl5q0buxw3R1If5SjTscLO5du80yupEgp6WxCg
	TUbNTi58ZUB9pqGo6DfUUCXK8iGGiIw1qFDgw0EUOycgO2ggD8EX
X-Google-Smtp-Source: AGHT+IGjO9L6iksEY/Hs2jEAkHI+wWRAwbfSvy8P3pgIhR7Ie6EzwW/2mIdUqJoPFBumn0d4ymRUai2wBWHygb7yBUk=
X-Received: by 2002:a17:90a:d44e:b0:27d:9b5:f28d with SMTP id
 cz14-20020a17090ad44e00b0027d09b5f28dmr12291581pjb.8.1698238478933; Wed, 25
 Oct 2023 05:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-5-vincent.guittot@linaro.org> <20231025115456.GD31201@noisy.programming.kicks-ass.net>
In-Reply-To: <20231025115456.GD31201@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 25 Oct 2023 14:54:27 +0200
Message-ID: <CAKfTPtDhRcyHQKGy0aNLXLzGJ6LS+Of7ZjeQGGGv5f5qtNxiBg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] energy_model: use a fixed reference frequency
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

On Wed, 25 Oct 2023 at 13:55, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 18, 2023 at 06:25:38PM +0200, Vincent Guittot wrote:
> > The last item of a performance domain is not always the performance point
> > that has been used to compute CPU's capacity. This can lead to different
> > target frequency compared with other part of the system like schedutil and
> > would result in wrong energy estimation.
> >
> > A new arch_scale_freq_ref() is available to return a fixed and coherent
> > frequency reference that can be used when computing the CPU's frequency
> > for an level of utilization. Use this function to get this reference
> > frequency.
> >
> > Energy model is never used without defining arch_scale_freq_ref() but
> > can be compiled. Define a default arch_scale_freq_ref() returning 0
> > in such case.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> > Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> >
> > ---
> >  include/linux/energy_model.h | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> > index b9caa01dfac4..1b0c8490d4bd 100644
> > --- a/include/linux/energy_model.h
> > +++ b/include/linux/energy_model.h
> > @@ -204,6 +204,14 @@ struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
> >       return ps;
> >  }
> >
> > +#ifndef arch_scale_freq_ref
> > +static __always_inline
> > +unsigned int arch_scale_freq_ref(int cpu)
> > +{
> > +     return 0;
> > +}
> > +#endif
>
> Hmm, did I not see the exact same thing in cpufreq.h two patches ago?

Probably, this has been added because of error returned by some
allyes/randconfig on x86

>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

