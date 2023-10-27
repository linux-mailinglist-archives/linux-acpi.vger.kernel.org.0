Return-Path: <linux-acpi+bounces-1066-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 425137D9E0C
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 18:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77A0282434
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A5D39847
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5dz3JOS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDDA18C0D
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 15:19:21 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59772186
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 08:19:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2800bdf888dso586428a91.1
        for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698419960; x=1699024760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W/jyxUKjs+ivpArfOLxbtvoP8jhQ6Kn3kdcGQik3464=;
        b=t5dz3JOSfKZgW8Sobzq+LJBU5J1pp60EKogyCKLZ2CwqFxpDX6CpsOZ19rrk5SBNtp
         VZTgFKZ5R13bAqMFf8EALaD+grB8h1bso+csJX7T6+BKCuMHiCKIR3oCDUge40PQv0sP
         bTv25e2d1YI2GOIV3AlzTgKqRF8XqXzmxsnQAv/QnalnMnmZ3rBMN1vxEU//CO3TN7TR
         B8RIJsvcOR6j2T6TO+ru0E6ZRim8p6dMorFviqqVC761UFld3qw0yjY0N3UbAi4ELVFm
         +33ZAaqA5OOw47zMdDFxgmAoOxKLvow315DyoO6+3mjXNO3YGRe6DmrRvwrWR79kfo8r
         mcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698419960; x=1699024760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/jyxUKjs+ivpArfOLxbtvoP8jhQ6Kn3kdcGQik3464=;
        b=kgeq10NgAFMUW58edsiL9N4EHaa7h4HGPXqljWjCHtednV8/yWk4qi1Uk59PpC3opy
         jhzZktfIKOWJZhlfBGwaeqNsf6d07hM8D3ZN7JZkYL1nPQmuEBRgcQMuRORy8eHPz+Gn
         8PBz/z2E8cT8ou20qZdFrOuTuc45wM3zSPLGWwtpnPL2Vrf1c5p83u5dCqcmcdOJs6+n
         z35LNzvUjTPUViA5rkLf7n2AOMsJTVc8P+LS5P0E55TXHZq8B7C5KanBhGKaKzKCkmHH
         pUD7jNUuKqxrUGtm1tQhqNX0NuKw+rY/uml5A1JsYd07TyO/VxdlsBYZqyjnSEi9NUK0
         l+Jg==
X-Gm-Message-State: AOJu0YyiBgBwqfLGqkC0NmpbQ6uPqQbiymdQHAy0V8oMbMbFa2svNF+B
	sZF2zgkmYFTY9eiH1cbB+jcbCi/FscXRRJlmIBNA0g==
X-Google-Smtp-Source: AGHT+IGUKBp+yhr0SGL/r8fauv9ZI3qMIv5o/cI5+TiZ/hDpbOWH1EASH2mun47zrYT67G9szswD5PDJM//8CmhEj8w=
X-Received: by 2002:a17:90b:33c8:b0:274:77b3:64d0 with SMTP id
 lk8-20020a17090b33c800b0027477b364d0mr7422882pjb.17.1698419959769; Fri, 27
 Oct 2023 08:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-2-vincent.guittot@linaro.org> <ZTuDW8lXZLQP1Ruq@gmail.com>
In-Reply-To: <ZTuDW8lXZLQP1Ruq@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 27 Oct 2023 17:19:07 +0200
Message-ID: <CAKfTPtDgUiY3COzR4xMZ80yKuK2FWNx=wnVXhRTR8vZ6JSnAoA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] topology: add a new arch_scale_freq_reference
To: Ingo Molnar <mingo@kernel.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com, 
	lukasz.luba@arm.com, ionela.voinescu@arm.com, pierre.gondois@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	conor.dooley@microchip.com, suagrfillet@gmail.com, ajones@ventanamicro.com, 
	lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Oct 2023 at 11:31, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> > --- a/include/linux/arch_topology.h
> > +++ b/include/linux/arch_topology.h
> > @@ -27,6 +27,13 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
> >
> >  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
> >
> > +DECLARE_PER_CPU(unsigned long, capacity_ref_freq);
> > +
> > +static inline unsigned long topology_get_freq_ref(int cpu)
> > +{
> > +     return per_cpu(capacity_ref_freq, cpu);
> > +}
> > +
> >  DECLARE_PER_CPU(unsigned long, arch_freq_scale);
>
> So mind naming it in a way that expresses that this is indeed a maximum
> frequency? arch_scale_ref_freq_max or so?

This does not always have to be the max frequency of the CPU but the
frequency that has been used to compute the capacity of the CPU so
it's the "reference" frequency used for computing the capacity and
that must be used to compute  the capacity for a given frequency and
the other way. That 's why I have intentionally not used freq_max

Then other similar functions start with arch_scale_freq_something

>
> Also, is there any particular concept behind naming one new symbol
> 'freq_ref', the other 'ref_freq'? If not then please standardize on one
> variant.

no particular reason. ref_freq comes from "reference frequency" but
interfaces follows arch_scale_freq_something or
topology_*_freq_something

so we should keep freq_ref to keep interfaces aligned

>
> Thanks,
>
>         Ingo

