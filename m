Return-Path: <linux-acpi+bounces-11273-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A41AA3A75A
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 20:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93833176C7A
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 19:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0657F2356B8;
	Tue, 18 Feb 2025 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBjICclE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49691F584F;
	Tue, 18 Feb 2025 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906609; cv=none; b=pwBs2ttKW2W0JudLehA7nTiKHkKX+B3HvynF2PndpCyUDxq12zQ1nvd+cyYW9piD2ofYjBsQqUhTKiXdjkCloO9qRHOezULN5NHVL+yY5OXQD4eGd9WRlAWuTZUZ5tZD+lDnXRNzTMLKiijiSMRRuh+qA9r9yxUUaclT3ZgpyOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906609; c=relaxed/simple;
	bh=tHGA5G2WYkatnmKUK3lUU0vRU387uRxbNlWbdsK5rwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Shifk4dB9Ra4mkFj3C6w0ffoiitU/biZJdQ1GZnNk3BAJ/Q/Qu7Jwhf8/RdGQU1ZxBSNCkJvW501cbLUgHl6v8Bkt86t5OvIZtqtGLLkEHaLlmW+MAH/VWzp6oq9YZsLQ5LXiMcEt/fqBda/ZgU6IvnkvGbvSt8swAF5iLw7YL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBjICclE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F610C4CEEE;
	Tue, 18 Feb 2025 19:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739906609;
	bh=tHGA5G2WYkatnmKUK3lUU0vRU387uRxbNlWbdsK5rwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OBjICclEAhuFsYzZQCfh187X4A70ZB8kLhlGB+G0Y1WH52H1IVUzEefn3Yr47eVzD
	 SRCMzEexqdZQKEQDRkNQd05L5cnaPhfvHF7iBXIoRaAHKU59bKop6m/vjg5FIw9yaq
	 CemDgQZneYRRgnQCG6eFr9+Q4ya7+dcrDxZZAoyrTeZxwQ9v4mfA8xJSw3/kY2KYuw
	 wWA3MAaso2buF5NziFfkUx0EqYV8hQXGpshjYnV3PeyUoYeIL5u2b7yTGTkxd/M1PX
	 SOyARhe5rafluU1t/PdE80Q+y0wcP8OQTC04wtwMR48UIsqdCtOcg35iQ9NPMQ5a+W
	 aKmBt9T9L4pGQ==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f3e0498beaso55035b6e.1;
        Tue, 18 Feb 2025 11:23:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUydrDvMsjlG0S5RSi/SGB0HJHyud9/73NldlGgxh1LjchF7xxaSrxRoD+/KvZSrQ2JxmA12o1HzmfE@vger.kernel.org, AJvYcCV2EvD4F2b8wX+PBWPRkzlPlDDdsX6dS5krwOxtEQYsTOytuOS19TAsZ8oIKdEgEJd+Qa4sdcDnoa0=@vger.kernel.org, AJvYcCVz4ni+AQ5ZntpEs4sANscnw1xQRk+h1/S5ENwcKqQ9/8CwoBBeR8VpNK4S7ONrfrjyNxmZxC3K8kfx/m8=@vger.kernel.org, AJvYcCWZhiLzhIq8Rov14dLShZTZJ77KIzuciU4seJ1VFlVFHZPepGrlyfop0pi9hrQuVRPn64CSlYo2+rUCPWVV@vger.kernel.org, AJvYcCWdyjueOjhCKGL1Da03mtQPBpG6wREcNobR7jLCTEWlUl1Gf7rDQtdwxFP0WKY29AdNp+eB6BFNqh/T@vger.kernel.org
X-Gm-Message-State: AOJu0YzFY/guWF5YHN284cEA9+g22sgajlJfdKvQZlIslWox2ZvH8S+s
	MAs4GOAYHLxxnUxg32L56Q/SM92k8kCqUQgVrn9/2wux14V9BtXSMxeoeNrh/6JLOuOZlFwW8Vp
	fe25i76PjMw9aKZT45HHRrNvIXGc=
X-Google-Smtp-Source: AGHT+IFnQSrEOQ5XyF8kcORbR22aIZWDMKNGLzVsGwRAAbFTPsjQg/3r9VLhR4uCpNrzjbTL59N8kAtr10x5ERBjPf4=
X-Received: by 2002:a05:6808:188b:b0:3f4:9e6:fb7 with SMTP id
 5614622812f47-3f40eefb38fmr790244b6e.1.1739906608509; Tue, 18 Feb 2025
 11:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211103737.447704-1-sumitg@nvidia.com> <20250211104428.dibsnxmkiluzixvz@vireshk-i7>
 <b45d0d81-e4f7-474e-a146-0075a6145cc2@huawei.com> <868d4c2a-583a-4cbb-a572-d884090a7134@nvidia.com>
 <8d5e0035-d8fe-49ef-bda5-f5881ff96657@huawei.com> <94bdab73-adc4-4b43-9037-5639f23e3d1e@nvidia.com>
In-Reply-To: <94bdab73-adc4-4b43-9037-5639f23e3d1e@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 20:23:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iAg6HFROHctYQwW=V9XiV8p3XVYgeKUcX4qBgfwQK6Ow@mail.gmail.com>
X-Gm-Features: AWEUYZnjK1GpyeSViY75mprA6AS3e808U82IVCn4oReC-_uewxJCKtkO01zA8nA
Message-ID: <CAJZ5v0iAg6HFROHctYQwW=V9XiV8p3XVYgeKUcX4qBgfwQK6Ow@mail.gmail.com>
Subject: Re: [Patch 0/5] Support Autonomous Selection mode in cppc_cpufreq
To: Sumit Gupta <sumitg@nvidia.com>, "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, rafael@kernel.org, lenb@kernel.org, 
	robert.moore@intel.com, corbet@lwn.net, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	sashal@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com, 
	sanjayc@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:09=E2=80=AFAM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
>
>
> On 12/02/25 16:22, zhenglifeng (A) wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On 2025/2/11 22:08, Sumit Gupta wrote:
> >>
> >>
> >>>
> >>> On 2025/2/11 18:44, Viresh Kumar wrote:
> >>>> On 11-02-25, 16:07, Sumit Gupta wrote:
> >>>>> This patchset supports the Autonomous Performance Level Selection m=
ode
> >>>>> in the cppc_cpufreq driver. The feature is part of the existing CPP=
C
> >>>>> specification and already present in Intel and AMD specific pstate
> >>>>> cpufreq drivers. The patchset adds the support in generic acpi cppc
> >>>>> cpufreq driver.
> >>>>
> >>>> Is there an overlap with:
> >>>>
> >>>> https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@hu=
awei.com/
> >>>>
> >>>> ?
> >>>
> >>> Ha, it looks like we're doing something very similar.
> >>>
> >>
> >> Hi Viresh,
> >>
> >> Thank you for pointing to [1].
> >>
> >> There seems to be some common points about updating the 'energy_perf'
> >> and 'auto_sel' registers for autonomous mode but the current patchset
> >> has more comprehensive changes to support Autonomous mode with the
> >> cppc_cpufreq driver.
> >>
> >> The patches in [1]:
> >> 1) Make the cpc register read/write API=E2=80=99s generic and improves=
 error
> >>     handling for 'CPC_IN_PCC'.
> >> 2) Expose sysfs under 'cppc_cpufreq_attr' to update 'auto_select',
> >>     'auto_act_window' and 'epp' registers.
> >>
> >> The current patch series:
> >> 1) Exposes sysfs under 'cppc_attrs' to keep CPC registers together.
> >> 2) Updates existing API=E2=80=99s to use new registers and creates new=
 API
> >>     with similar semantics to get all perf_ctrls.
> >> 3) Renames some existing API=E2=80=99s for clarity.
> >> 4) Use these existing API=E2=80=99s from acpi_cppc sysfs to update the=
 CPC
> >>     registers used in Autonomous mode:
> >>     'auto_select', 'epp', 'min_perf', 'max_perf' registers.
> >> 5) Add separate 'cppc_cpufreq_epp' instance of the 'cppc_cpufreq'
> >>     driver to apply different limit and policy for Autonomous mode.
> >>     Having it separate will avoid confusion between SW and HW mode.
> >>     Also, it will be easy to scale and add new features in future
> >>     without interference. Similar approach is used in Intel and AMD
> >>     pstate drivers.
> >>
> >> Please share inputs about the preferred approach.
> >>
> >> Best Regards,
> >> Sumit Gupta
> >>
> >> [1] https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@=
huawei.com/
> >>
> >>
> >
> > Hi Sumit,
> >
> > Thanks for upstreaming this.
> >
> > I think the changes to cppc_acpi in this patchset is inappropriate.
> >
> > 1) cppc_attrs are common sysfs for any system that supports CPPC. That
> > means, these interfaces would appear even if the cpufreq driver has alr=
eady
> > managing it, e.g. amd-pstate and cppc_cpufreq. This would create multip=
le
> > interfaces to modify the same CPPC regs, which may probably introduce
> > concurrency and data consistency issues. Instead, exposing the interfac=
es
> > under cppc_cpufreq_attr decouples the write access to CPPC regs.
> >
>
> Hi Lifeng,
>
> I think its more appropriate to keep all the CPC registers together
> instead of splitting the read only registers to the acpi_cppc sysfs
> and read/write registers to the cpufreq sysfs.
>
> Only the EPP register is written from Intel and AMD.
>   $ grep cpufreq_freq_attr_rw drivers/cpufreq/* | grep -v scaling
>   drivers/cpufreq/acpi-cpufreq.c:cpufreq_freq_attr_rw(cpb);
>
> drivers/cpufreq/amd-pstate.c:cpufreq_freq_attr_rw(energy_performance_pref=
erence);
>
> drivers/cpufreq/intel_pstate.c:cpufreq_freq_attr_rw(energy_performance_pr=
eference);
>
> We are currently updating four registers and there can be more in
> future like 'auto_act_window' update attribute in [1].
> Changed to make this conditional with 'ifdef CONFIG_ACPI_CPPC_CPUFREQ'
> to not create attributes for Intel/AMD.
>
>   +++ b/drivers/acpi/cppc_acpi.c
>   @@ static struct attribute *cppc_attrs[] =3D {
>           &lowest_freq.attr,
>   +#ifdef CONFIG_ACPI_CPPC_CPUFREQ
>           &max_perf.attr,
>           &min_perf.attr,
>           &perf_limited.attr,
>           &auto_activity_window.attr,
>           &energy_perf.attr,
>   +#endif
>
> > 2) It's inappropriate to call cpufreq_cpu_get() in cppc_acpi. This file
> > currently provides interfaces for cpufreq drivers to use. It has no ABI
> > dependency on cpufreq at the moment.
> >
>
> cpufreq_cpu_get() is already used by multiple non-cpufreq drivers.
> So, don't think its a problem.
>   $ grep -inr "=3D cpufreq_cpu_get(.*;" drivers/*| grep -v "cpufreq/"|wc =
-l
>   10
>
> > Apart from the changes to cppc_acpi, I think the whole patchset in [1] =
can
> > be independent to this patchset. In other words, adding the
> > cppc_cpufreq_epp_driver could be standalone to discuss. I think combini=
ng
> > the use of ->setpolicy() and setting EPP could be a use case? Could you
> > explain more on the motivation of adding a new cppc_cpufreq_epp_driver?
> >
>
> With 'cppc_cpufreq_epp_driver', we provide an easy option to boot all
> CPU's in auto mode with right epp and policy min/max equivalent of
> {min|max}_perf. The mode can be found clearly with scaling_driver node.
> Separating the HW and SW mode based on driver instance also
> makes it easy to scale later.
> Advanced users can program sysfs to switch individual CPU's in and out
> of the HW mode. We can update policy min/max values accordingly.
> In this case, there can be some CPU's in SW mode with epp driver
> instance. But a separate instance will be more convenient for the
> users who want all CPU's either in HW mode or in SW mode than having
> to explicitly set all the values correctly.

There seems to be some quite fundamental disagreement on how this
should be done, so I'm afraid I cannot do much about it ATM.

Please agree on a common approach and come back to me when you are ready.

Sending two concurrent patchsets under confusingly similar names again
and again isn't particularly helpful.

Thanks!

