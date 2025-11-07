Return-Path: <linux-acpi+bounces-18677-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38147C41848
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 21:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6215188E47D
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 20:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F838303A2F;
	Fri,  7 Nov 2025 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MK4ExjfM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C32FCC10
	for <linux-acpi@vger.kernel.org>; Fri,  7 Nov 2025 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546133; cv=none; b=rfU3GqNny/R0oA9RrKRbl4PeqTXDfC7sTF2XPoj9n98I50wxG1K/b2BU3WF/2c89iieyw331MCS5G14EGYL4iLdOaeLi8kw/SQQAsFeulxc1Gx8zzvA/G04g6t7EQ1aszejEjAxmjAaCU6pG+ilaXOhwYedHCc+Y6yVGBgKXhf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546133; c=relaxed/simple;
	bh=szesQpSM5oo7OsiDU5UKtOwtIL9eGv7CnUXjP7KFeos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUaoVVpMiDKi4Sj+Hu8y8NNFVYqOdoC4ysudb5rsO7NsqanGRvoL+9igdtgvoSXrZtK15OK1qtiRQ0N40ySpX2fklzAM2k1dD6wObKesiG/eUKXrIiuf1lBDCOFslU/1H4wI8bldVQIFTXOQyQDzJm03Ryy3EyeAB5DV4iFIxaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MK4ExjfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBBFC4AF0D
	for <linux-acpi@vger.kernel.org>; Fri,  7 Nov 2025 20:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762546133;
	bh=szesQpSM5oo7OsiDU5UKtOwtIL9eGv7CnUXjP7KFeos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MK4ExjfMOWhtxaY36/EOJRaYXFbTHV0SGPpxdCQJWplE4xG4HgiJ/ylwJc787Sksa
	 z4vyAEvMqm8NrQX0OlAizkMW8wjEZuNS5Wp+5v1eINEQeTr/blBsc7Dp74Ss+XFGm8
	 ZP1vf2pa6AmEiaf541pEAg1rJiD2UJua1uBPdy34Z4A95X4npaz4LhFWjqwfhFnZig
	 XS16qV7a8Numgked/F2/VWMeyKLyvY5hZhj9WSzJIhZ6vCWdvnFQOjkBEy59h3YFPM
	 PslUlvQWGzFdNo/n3EMnmg0yoii6ECsU+V8Obkcrp0Zd7XhalC2zIu801ciyFm7KuX
	 XWI6a6XH/tzRw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-656cd6c1c5eso487100eaf.0
        for <linux-acpi@vger.kernel.org>; Fri, 07 Nov 2025 12:08:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzoHusSB35nIL/m+jcFQQ7i/H/HPYdYOEGkYJmvL46smrzEzQzIoXZm2P3e6JPDqK7bK/FEGTDMmDP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3gvHYVeQMZKBczLNARvUZiNu9tM2yeQTZfaTQpdSwNif68QVo
	b1uL/M0Q/Iopd9aKVHwCiCD0SjnCt+/OkTOoZZYgeVVT07aIEATsUikA+Fms4fKFRi8LEn59Jql
	nPQrwD0A2R/g7PlWZg9sWwBHKOq7jgXA=
X-Google-Smtp-Source: AGHT+IGA04jm71Ij9xeQJEzJY7AxE62iCGgrrBQyNvtjVXE70OmsxBr7+clNSkaS9F9EzCSb46Qp9YHiGNZGj0RJ2fQ=
X-Received: by 2002:a05:6820:16a6:b0:656:8360:3906 with SMTP id
 006d021491bc7-656d8ea527dmr426344eaf.8.1762546131960; Fri, 07 Nov 2025
 12:08:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105113844.4086250-5-sumitg@nvidia.com> <202511061802.lIq09jwh-lkp@intel.com>
 <be696cb5-7d0d-44f6-970b-e417c2f89a8e@nvidia.com>
In-Reply-To: <be696cb5-7d0d-44f6-970b-e417c2f89a8e@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 21:08:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j8bQm+00+m75rmpKpm8yVumvYsWzCdYyCPwksnebY__A@mail.gmail.com>
X-Gm-Features: AWmQ_bnyTo8wfwCEW9lyu_1xYl179djStUEiTR_5ulbMLWD8CjXHhBWwog1DvlU
Message-ID: <CAJZ5v0j8bQm+00+m75rmpKpm8yVumvYsWzCdYyCPwksnebY__A@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] ACPI: CPPC: add APIs and sysfs interface for min/max_perf
To: Sumit Gupta <sumitg@nvidia.com>
Cc: kernel test robot <lkp@intel.com>, rafael@kernel.org, viresh.kumar@linaro.org, 
	lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net, 
	pierre.gondois@arm.com, zhenglifeng1@huawei.com, rdunlap@infradead.org, 
	ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com, 
	perry.yuan@amd.com, ionela.voinescu@arm.com, zhanjie9@hisilicon.com, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, linux-tegra@vger.kernel.org, 
	treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com, 
	ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com, 
	bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 11:00=E2=80=AFAM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
>
> On 06/11/25 16:00, kernel test robot wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > Hi Sumit,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on rafael-pm/linux-next]
> > [also build test WARNING on rafael-pm/bleeding-edge linus/master v6.18-=
rc4 next-20251106]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/cpuf=
req-CPPC-Add-generic-helpers-for-sysfs-show-store/20251105-194715
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git linux-next
> > patch link:    https://lore.kernel.org/r/20251105113844.4086250-5-sumit=
g%40nvidia.com
> > patch subject: [PATCH v4 4/8] ACPI: CPPC: add APIs and sysfs interface =
for min/max_perf
> > config: riscv-defconfig (https://download.01.org/0day-ci/archive/202511=
06/202511061802.lIq09jwh-lkp@intel.com/config)
> > compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project=
 d2625a438020ad35330cda29c3def102c1687b1b)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20251106/202511061802.lIq09jwh-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202511061802.lIq09jwh-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >>> Warning: drivers/cpufreq/cppc_cpufreq.c:954 function parameter 'polic=
y' not described in 'show_min_perf'
> >>> Warning: drivers/cpufreq/cppc_cpufreq.c:954 function parameter 'buf' =
not described in 'show_min_perf'
> >>> Warning: drivers/cpufreq/cppc_cpufreq.c:976 function parameter 'polic=
y' not described in 'store_min_perf'
> >>> Warning: drivers/cpufreq/cppc_cpufreq.c:976 function parameter 'buf' =
not described in 'store_min_perf'
> >>> Warning: drivers/cpufreq/cppc_cpufreq.c:976 function parameter 'count=
' not described in 'store_min_perf'
> >>> Warning: drivers/cpufreq/cppc_cpufreq.c:1003 function parameter 'poli=
cy' not described in 'show_max_perf'
> >>> Warning: drivers/cpufreq/cppc_cpufreq.c:1003 function parameter 'buf'=
 not described in 'show_max_perf'
> >>> Warning: drivers/cpufreq/cppc_cpufreq.c:1025 function parameter 'poli=
cy' not described in 'store_max_perf'
> >>> Warning: drivers/cpufreq/cppc_cpufreq.c:1025 function parameter 'buf'=
 not described in 'store_max_perf'
> >>> Warning: drivers/cpufreq/cppc_cpufreq.c:1025 function parameter 'coun=
t' not described in 'store_max_perf'
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
>
>
> Thank you for the report.
> Below change to comments seem to be fixing this warning.

So can you please send a new version of this patch with the changes
below folded in?

> -------------------------------------------------------
>    /**
>    * show_min_perf - Show minimum performance as frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer to write the frequency value to
>    *
>    * Reads the MIN_PERF register and converts the performance value to
>    * frequency (kHz) for user-space consumption.
> @@ -1117,6 +1119,9 @@ static ssize_t show_min_perf(struct cpufreq_policy
> *policy, char *buf)
>
>   /**
>    * store_min_perf - Set minimum performance from frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer to write the frequency value to
> + * @count: size of @buf
>    *
>    * Converts the user-provided frequency (kHz) to a performance value
>    * and writes it to the MIN_PERF register.
> @@ -1144,6 +1149,8 @@ static ssize_t store_min_perf(struct
> cpufreq_policy *policy, const char *buf, si
>
>   /**
>    * show_max_perf - Show maximum performance as frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer to write the frequency value to
>    *
>    * Reads the MAX_PERF register and converts the performance value to
>    * frequency (kHz) for user-space consumption.
> @@ -1166,6 +1173,9 @@ static ssize_t show_max_perf(struct cpufreq_policy
> *policy, char *buf)
>
>   /**
>    * store_max_perf - Set maximum performance from frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer to write the frequency value to
> + * @count: size of @buf
> -------------------------------------------------------

As for the whole series, I generally need ARM folks to review it and
tell me that it is fine.

Thanks!

