Return-Path: <linux-acpi+bounces-1331-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D78DD7E41DF
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 15:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C371F214DC
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18A8CA48
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMGimtS1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA97C2DF91
	for <linux-acpi@vger.kernel.org>; Tue,  7 Nov 2023 13:08:14 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFFA171D
	for <linux-acpi@vger.kernel.org>; Tue,  7 Nov 2023 05:08:12 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-777719639adso363258185a.3
        for <linux-acpi@vger.kernel.org>; Tue, 07 Nov 2023 05:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699362491; x=1699967291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duB41CAVQAEHsTpboDBSVP82rtEMNlFgZnRIBiTx7QM=;
        b=DMGimtS1Yp4H0rIj3vrINiBqpgrN5u2ebBdh0pMroprqbhv7o/btk5o2urfC1FIge2
         0bg2FFy7j2cx588WdSwWcCVwHKkfjypUK9CNAYPZIuAj95W16/LOUiXD+WmyojcpHzul
         k9rXeiGqr5pnbISHEWlkblCSAa60X8fderwMxF9dz6XmP9WEV6NwM3IMUiNNt1v8fj7o
         JD3WPbdFfnAIl1RB36X9WRdKn8NsNPqZ84RrN1GQFTXgSKhV4Z7n7xgriCLbg0mI/5jZ
         4a6NYFskSc8waUU69ecQRRNSM47qqMXoyI+4jfBPXqy5HhBHC6pfgGgoc+PRIAyO0jYb
         z8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699362491; x=1699967291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duB41CAVQAEHsTpboDBSVP82rtEMNlFgZnRIBiTx7QM=;
        b=JbPGjKdpGRRC3khjGuZXhVGPZGJZLm9ODVx5DO/6K3pkdywD3iIgPbEfe2BePuwiuI
         Qg8sV42tC1sFvcOJFoELJTTigRT7EAAopd8VdYJGcF0gSyvWuYshTh3nTxKYAy64QyVK
         DQQCl6+fRzXhxKIiWJCT56lnCWgjzQOgl7c33/dAx5ttlQo3Sn+p4zM3mti4eFgbmYz1
         qKtk04y2tcCWW6ZOuVX11dLx0+GK40ImSIfKBdIYs+r+zyarevXKRGX9WpZkivGZZRaK
         aMzzfO9VfgLUi/XSd8bHKAVh+VNo9S6Ulgxepi4EmA8q5sy+arPt5NUSUsLAoG3neirU
         HJvw==
X-Gm-Message-State: AOJu0YyU34hlUqe8qTtp1PCzu6DvevSEh6y1M6kUyJjae2irwCpluNkn
	xlblv1v78zG9Ne22eZQ9wfkgUxWxYFIDO4LfULrM/Q==
X-Google-Smtp-Source: AGHT+IGUEs/Z9qDF9Rm5YJWKfqOOEPOokXyTpuCNs8hFPpMccS+CxR+7fkZ7Pf/btUtItisYVanaHMrqI1zvjHLhVi8=
X-Received: by 2002:a05:6214:4103:b0:66d:1624:2200 with SMTP id
 kc3-20020a056214410300b0066d16242200mr38764786qvb.13.1699362491180; Tue, 07
 Nov 2023 05:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104105907.1365392-1-vincent.guittot@linaro.org>
 <20231104105907.1365392-8-vincent.guittot@linaro.org> <20231107103808.GF18944@willie-the-truck>
 <CAKfTPtBb+qea61OH-B0L=MHJWnQMLL80EBR-nSHZtoWTbYeHhw@mail.gmail.com> <20231107120103.GA19367@willie-the-truck>
In-Reply-To: <20231107120103.GA19367@willie-the-truck>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 7 Nov 2023 14:07:58 +0100
Message-ID: <CAKfTPtA_8fN-op7FhMg=zxjD9rNEvC_Lm_x7J0BK+YCwxUF+Og@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] arm64/amu: Use capacity_ref_freq to set AMU ratio
To: Will Deacon <will@kernel.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, sudeep.holla@arm.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, viresh.kumar@linaro.org, lenb@kernel.org, 
	robert.moore@intel.com, lukasz.luba@arm.com, ionela.voinescu@arm.com, 
	pierre.gondois@arm.com, beata.michalska@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, conor.dooley@microchip.com, suagrfillet@gmail.com, 
	ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Nov 2023 at 13:01, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Nov 07, 2023 at 12:18:20PM +0100, Vincent Guittot wrote:
> > On Tue, 7 Nov 2023 at 11:38, Will Deacon <will@kernel.org> wrote:
> > >
> > > On Sat, Nov 04, 2023 at 11:59:07AM +0100, Vincent Guittot wrote:
> > > > Use the new capacity_ref_freq to set the ratio that is used by AMU =
for
> > > > computing the arch_scale_freq_capacity().
> > > > This helps to keep everything aligned using the same reference for
> > > > computing CPUs capacity.
> > > >
> > > > The default value of the ratio (stored in per_cpu(arch_max_freq_sca=
le))
> > > > ensures that arch_scale_freq_capacity() returns max capacity until =
it is
> > > > set to its correct value with the cpu capacity and capacity_ref_fre=
q.
> > > >
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > ---
> > > >  arch/arm64/kernel/topology.c  | 26 ++++++++++++++------------
> > > >  drivers/base/arch_topology.c  | 12 +++++++++++-
> > > >  include/linux/arch_topology.h |  1 +
> > > >  3 files changed, 26 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topol=
ogy.c
> > > > index 817d788cd866..615c1a20129f 100644
> > > > --- a/arch/arm64/kernel/topology.c
> > > > +++ b/arch/arm64/kernel/topology.c
> > > > @@ -82,7 +82,12 @@ int __init parse_acpi_topology(void)
> > > >  #undef pr_fmt
> > > >  #define pr_fmt(fmt) "AMU: " fmt
> > > >
> > > > -static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_sca=
le);
> > > > +/*
> > > > + * Ensure that amu_scale_freq_tick() will return SCHED_CAPACITY_SC=
ALE until
> > > > + * the CPU capacity and its associated frequency have been correct=
ly
> > > > + * initialized.
> > > > + */
> > > > +static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_sca=
le) =3D  1UL << (2 * SCHED_CAPACITY_SHIFT);
> > >
> > > This doesn't seem to match the comment? SCHED_CAPACITY_SCALE doesn't =
have
> > > the '2 *' multiplier.
> >
> > The comment in freq_inv_set_max_ratio() says:
> >
> > * We use a factor of 2 * SCHED_CAPACITY_SHIFT -> SCHED_CAPACITY_SCALE=
=C2=B2
> > * in order to ensure a good resolution for arch_max_freq_scale for
> > * very low reference frequencies (down to the KHz range which should
> > * be unlikely).
> >
> > Then there is a  "  * arch_max_freq_scale) >> SCHED_CAPACITY_SHIFT"
> > when computing the scale which brings the result back to
> > SCHED_CAPACITY_SHIFT
>
> Ah, I see; I'd not spotted that amu_scale_freq_tick() is doing some
> arithmetic on the value (it doesn't return anything because it's 'void').
> It's slightly confusing because the comment talks about SCHED_CAPACITY_SC=
ALE
> whereas all the code works on the shift, but I get it now.
>
> > > >  static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
> > > >  static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
> > > >  static cpumask_var_t amu_fie_cpus;
> > > > @@ -112,14 +117,14 @@ static inline bool freq_counters_valid(int cp=
u)
> > > >       return true;
> > > >  }
> > > >
> > > > -static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_r=
ate)
> > > > +void freq_inv_set_max_ratio(int cpu, u64 max_rate)
> > > >  {
> > > > -     u64 ratio;
> > > > +     u64 ratio, ref_rate =3D arch_timer_get_rate();
> > > >
> > > >       if (unlikely(!max_rate || !ref_rate)) {
> > > > -             pr_debug("CPU%d: invalid maximum or reference frequen=
cy.\n",
> > > > +             WARN_ONCE(1, "CPU%d: invalid maximum or reference fre=
quency.\n",
> > > >                        cpu);
> > > > -             return -EINVAL;
> > > > +             return;
> > > >       }
> > > >
> > > >       /*
> > > > @@ -139,12 +144,12 @@ static int freq_inv_set_max_ratio(int cpu, u6=
4 max_rate, u64 ref_rate)
> > > >       ratio =3D div64_u64(ratio, max_rate);
> > > >       if (!ratio) {
> > > >               WARN_ONCE(1, "Reference frequency too low.\n");
> > > > -             return -EINVAL;
> > > > +             return;
> > > >       }
> > > >
> > > > -     per_cpu(arch_max_freq_scale, cpu) =3D (unsigned long)ratio;
> > > > +     WRITE_ONCE(per_cpu(arch_max_freq_scale, cpu), (unsigned long)=
ratio);
> > >
> > > Why is WRITE_ONCE() now needed?
> >
> > the tick can already use it. We want to make sure to use either the
> > old or the new one but not an intermediate value
>
> Isn't that already the case without this patch? In other words, this shou=
ld
> be a separate change.

Currently the ratio is set in the same notifier callback before
registering the AMU function in topology_scale_freq_tick whereas there
are now done in 2 separate notifier callbacks (still for the same
event) but we don't know the order

>
> Will

