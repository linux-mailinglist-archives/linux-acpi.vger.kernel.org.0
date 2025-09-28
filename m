Return-Path: <linux-acpi+bounces-17379-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC85BBA6E75
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Sep 2025 12:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B04D17BF89
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Sep 2025 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78FC2D9ED0;
	Sun, 28 Sep 2025 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9BeLGNR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6C239591
	for <linux-acpi@vger.kernel.org>; Sun, 28 Sep 2025 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759053634; cv=none; b=mMWWaLknFzfz4ufwAfZg5ydN+eW6oU7SrzlUrl2jVZT6nONPQgx46IppXEe/Zn9vkMqS2M5LgGEi2MAjWKILHD815NlKIL8YpRugGplKfx6LzkrgS+no+0ACGzkid43poWR2w0upXIHGQ0kiySNn9wZ0V7czIOphPxrp+JjfXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759053634; c=relaxed/simple;
	bh=lpZBqfAeRp579qqodtHxtnY2hFmabPS+55VnBDjr9CY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxBBFcZ8XC72HbgHshgFjFjFdHPLg0bqQlyFlXLjrCxg419sceIEz3siav4ASevd4ey/DcsaWiayg+UbHns73T5rnq84vDgm0m+N+Envj41xooLbjM/scKOoCBW1yvM+3vkf6tJ4RMNUb4zTb4TRzP3YXllqqudghxZ7ZWzyq+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9BeLGNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357DBC19423
	for <linux-acpi@vger.kernel.org>; Sun, 28 Sep 2025 10:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759053634;
	bh=lpZBqfAeRp579qqodtHxtnY2hFmabPS+55VnBDjr9CY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X9BeLGNRtqhfzcbN4KWhfS/4+wSq3RBCIKzX1R+OJDIryeeQR1eldmHDs1ifEsUR7
	 O9oXY6+7qcZZJvPyxxzV0f2EUpmU8XLiIxBP6CCgUgFyxls/TSmkXNsevRwQTOjCNv
	 jL4bBGHY7L0zzCOoyn/k5I59EaRvqW2ZrQrxGlLEiq8nMmb/112oD1u8/BuxDK/Iv7
	 ZM+PUV0YbsBE730laFTJECtW5GoKUtniRJ09FAVJSW+IUyJxOeuuHCbRtuZ6Ffs2My
	 VBOVHE/LjrzUTDDCVt5Fj2epDekrpypCIKrdKRemcSAKqYVEBpkW+zSkFj3D5izY+b
	 tuFN8Q2WSvCeg==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6448968e5c0so236693eaf.3
        for <linux-acpi@vger.kernel.org>; Sun, 28 Sep 2025 03:00:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDvuPmYQSAZVrijW29YR1TD9CEHiwcirr7Pla9ekxNdk2tNZWwCt2/frqu8jznPZ5NPUHPlwpVWwZi@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpj9HRMYNxwo7phL9IOWMRDgdvT5h+XsdGjq13k/iYzP/CviNp
	thPkRtOHFG9SPg6Z66R/is08FmHRTwVIimoDaccvF6qjhSrZPhdT0AimtIcOSt0ubejd34nUnA7
	r5eIVVhGGXtN4GPc1cG7siAdU4PAT15U=
X-Google-Smtp-Source: AGHT+IGl3n98P62iKS8YJZY4xB59Ef2YOjsnG9kyTlRxR5pRd1FWIkAPO+ITPcZbkZdRZllSfPhuBvGLH5iCWo82Wgo=
X-Received: by 2002:a05:6820:178f:b0:640:309f:28e7 with SMTP id
 006d021491bc7-640309f2b3dmr3806663eaf.0.1759053633342; Sun, 28 Sep 2025
 03:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5069803.31r3eYUQgx@rafael.j.wysocki> <2264949.irdbgypaU6@rafael.j.wysocki>
 <aNiqTYZai83Yguqt@dragon>
In-Reply-To: <aNiqTYZai83Yguqt@dragon>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 28 Sep 2025 12:00:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j0v6m7uRc0vf2q0W=G8q5hOm5dr5txqTZ2=sScaLaPHg@mail.gmail.com>
X-Gm-Features: AS18NWBfpSgwRs5g1PHjN_sGEqI_qYoAejDT0zi0cDbFFspwrRrvrcawKSZr7V8
Message-ID: <CAJZ5v0j0v6m7uRc0vf2q0W=G8q5hOm5dr5txqTZ2=sScaLaPHg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] cpufreq: Make drivers using CPUFREQ_ETERNAL
 specify transition latency
To: Shawn Guo <shawnguo2@yeah.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>, 
	LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Pierre Gondois <pierre.gondois@arm.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 5:24=E2=80=AFAM Shawn Guo <shawnguo2@yeah.net> wrot=
e:
>
> On Fri, Sep 26, 2025 at 12:12:37PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit a755d0e2d41b ("cpufreq: Honour transition_latency over
> > transition_delay_us") caused platforms where cpuinfo.transition_latency
> > is CPUFREQ_ETERNAL to get a very large transition latency whereas
> > previously it had been capped at 10 ms (and later at 2 ms).
> >
> > This led to a user-observable regression between 6.6 and 6.12 as
> > described by Shawn:
> >
> > "The dbs sampling_rate was 10000 us on 6.6 and suddently becomes
> >  6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these platforms
> >  because the default transition delay was dropped [...].
> >
> >  It slows down dbs governor's reacting to CPU loading change
> >  dramatically.  Also, as transition_delay_us is used by schedutil
> >  governor as rate_limit_us, it shows a negative impact on device
> >  idle power consumption, because the device gets slightly less time
> >  in the lowest OPP."
> >
> > Evidently, the expectation of the drivers using CPUFREQ_ETERNAL as
> > cpuinfo.transition_latency was that it would be capped by the core,
> > but they may as well return a default transition latency value instead
> > of CPUFREQ_ETERNAL and the core need not do anything with it.
> >
> > Accordingly, introduce CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS and make
> > all of the drivers in question use it instead of CPUFREQ_ETERNAL.  Also
> > update the related Rust binding.
> >
> > Fixes: a755d0e2d41b ("cpufreq: Honour transition_latency over transitio=
n_delay_us")
> > Closes: https://lore.kernel.org/linux-pm/20250922125929.453444-1-shawng=
uo2@yeah.net/
> > Reported-by: Shawn Guo <shawnguo@kernel.org>
> > Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> > Cc: 6.6+ <stable@vger.kernel.org> # 6.6+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v3:
> >    * Add updates of the Rust version of cpufreq-dt and Rust binding
> >    * Update the changelog
> >    * Add tags from Mario Limonciello and Jie Zhan
> >
> > ---
> >  drivers/cpufreq/cpufreq-dt.c          |    2 +-
> >  drivers/cpufreq/imx6q-cpufreq.c       |    2 +-
> >  drivers/cpufreq/mediatek-cpufreq-hw.c |    2 +-
> >  drivers/cpufreq/rcpufreq_dt.rs        |    2 +-
> >  drivers/cpufreq/scmi-cpufreq.c        |    2 +-
> >  drivers/cpufreq/scpi-cpufreq.c        |    2 +-
> >  drivers/cpufreq/spear-cpufreq.c       |    2 +-
> >  include/linux/cpufreq.h               |    3 +++
> >  rust/kernel/cpufreq.rs                |    7 ++++---
> >  9 files changed, 14 insertions(+), 10 deletions(-)
> >
> > --- a/drivers/cpufreq/cpufreq-dt.c
> > +++ b/drivers/cpufreq/cpufreq-dt.c
> > @@ -104,7 +104,7 @@ static int cpufreq_init(struct cpufreq_p
> >
> >       transition_latency =3D dev_pm_opp_get_max_transition_latency(cpu_=
dev);
> >       if (!transition_latency)
> > -             transition_latency =3D CPUFREQ_ETERNAL;
> > +             transition_latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY=
_NS;
> >
> >       cpumask_copy(policy->cpus, priv->cpus);
> >       policy->driver_data =3D priv;
> > --- a/drivers/cpufreq/imx6q-cpufreq.c
> > +++ b/drivers/cpufreq/imx6q-cpufreq.c
> > @@ -442,7 +442,7 @@ soc_opp_out:
> >       }
> >
> >       if (of_property_read_u32(np, "clock-latency", &transition_latency=
))
> > -             transition_latency =3D CPUFREQ_ETERNAL;
> > +             transition_latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY=
_NS;
> >
> >       /*
> >        * Calculate the ramp time for max voltage change in the
> > --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> > @@ -309,7 +309,7 @@ static int mtk_cpufreq_hw_cpu_init(struc
> >
> >       latency =3D readl_relaxed(data->reg_bases[REG_FREQ_LATENCY]) * 10=
00;
> >       if (!latency)
> > -             latency =3D CPUFREQ_ETERNAL;
> > +             latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
> >
> >       policy->cpuinfo.transition_latency =3D latency;
> >       policy->fast_switch_possible =3D true;
> > --- a/drivers/cpufreq/rcpufreq_dt.rs
> > +++ b/drivers/cpufreq/rcpufreq_dt.rs
> > @@ -123,7 +123,7 @@ impl cpufreq::Driver for CPUFreqDTDriver
> >
> >          let mut transition_latency =3D opp_table.max_transition_latenc=
y_ns() as u32;
> >          if transition_latency =3D=3D 0 {
> > -            transition_latency =3D cpufreq::ETERNAL_LATENCY_NS;
> > +            transition_latency =3D cpufreq::DEFAULT_TRANSITION_LATENCY=
_NS;
> >          }
> >
> >          policy
> > --- a/drivers/cpufreq/scmi-cpufreq.c
> > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > @@ -294,7 +294,7 @@ static int scmi_cpufreq_init(struct cpuf
> >
> >       latency =3D perf_ops->transition_latency_get(ph, domain);
> >       if (!latency)
> > -             latency =3D CPUFREQ_ETERNAL;
> > +             latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
> >
> >       policy->cpuinfo.transition_latency =3D latency;
> >
> > --- a/drivers/cpufreq/scpi-cpufreq.c
> > +++ b/drivers/cpufreq/scpi-cpufreq.c
> > @@ -157,7 +157,7 @@ static int scpi_cpufreq_init(struct cpuf
> >
> >       latency =3D scpi_ops->get_transition_latency(cpu_dev);
> >       if (!latency)
> > -             latency =3D CPUFREQ_ETERNAL;
> > +             latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
> >
> >       policy->cpuinfo.transition_latency =3D latency;
> >
> > --- a/drivers/cpufreq/spear-cpufreq.c
> > +++ b/drivers/cpufreq/spear-cpufreq.c
> > @@ -182,7 +182,7 @@ static int spear_cpufreq_probe(struct pl
> >
> >       if (of_property_read_u32(np, "clock-latency",
> >                               &spear_cpufreq.transition_latency))
> > -             spear_cpufreq.transition_latency =3D CPUFREQ_ETERNAL;
> > +             spear_cpufreq.transition_latency =3D CPUFREQ_DEFAULT_TRAN=
SITION_LATENCY_NS;
> >
> >       cnt =3D of_property_count_u32_elems(np, "cpufreq_tbl");
> >       if (cnt <=3D 0) {
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -32,6 +32,9 @@
> >   */
> >
> >  #define CPUFREQ_ETERNAL                      (-1)
> > +
> > +#define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS NSEC_PER_MSEC
>
> Typo of TANSITION, should be CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS.

Yes, thanks!

Fixed already because CIs caught it yesterday.

I'm not sure how this happened though.  I must have mangled the patch
right before sending it because I had tested the whole patchset before
posting it.

> > +
> >  #define CPUFREQ_NAME_LEN             16
> >  /* Print length for names. Extra 1 space for accommodating '\n' in pri=
nts */
> >  #define CPUFREQ_NAME_PLEN            (CPUFREQ_NAME_LEN + 1)
> > --- a/rust/kernel/cpufreq.rs
> > +++ b/rust/kernel/cpufreq.rs
> > @@ -39,7 +39,8 @@ use macros::vtable;
> >  const CPUFREQ_NAME_LEN: usize =3D bindings::CPUFREQ_NAME_LEN as usize;
> >
> >  /// Default transition latency value in nanoseconds.
> > -pub const ETERNAL_LATENCY_NS: u32 =3D bindings::CPUFREQ_ETERNAL as u32=
;
> > +pub const DEFAULT_TRANSITION_LATENCY_NS: u32 =3D
> > +        bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS as u32;
> >
> >  /// CPU frequency driver flags.
> >  pub mod flags {
> > @@ -400,13 +401,13 @@ impl TableBuilder {
> >  /// The following example demonstrates how to create a CPU frequency t=
able.
> >  ///
> >  /// ```
> > -/// use kernel::cpufreq::{ETERNAL_LATENCY_NS, Policy};
> > +/// use kernel::cpufreq::{DEFAULT_TRANSITION_LATENCY_NS, Policy};
> >  ///
> >  /// fn update_policy(policy: &mut Policy) {
> >  ///     policy
> >  ///         .set_dvfs_possible_from_any_cpu(true)
> >  ///         .set_fast_switch_possible(true)
> > -///         .set_transition_latency_ns(ETERNAL_LATENCY_NS);
> > +///         .set_transition_latency_ns(DEFAULT_TRANSITION_LATENCY_NS);
> >  ///
> >  ///     pr_info!("The policy details are: {:?}\n", (policy.cpu(), poli=
cy.cur()));
> >  /// }
> >
> >
> >
>

