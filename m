Return-Path: <linux-acpi+bounces-10641-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EBFA10FFB
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 19:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415D6188A86A
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 18:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0FB1D54E2;
	Tue, 14 Jan 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bosTIUpB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4FB1B6CF6;
	Tue, 14 Jan 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879111; cv=none; b=PhxNFcHA8H51U+oAD28WcXJlaCWdOwYMcqPWOpph4J1i/qK82ac3MhQOgkuwMdP+gTfwj3kr+j/bzJYF+izMrVRCG4GLv3FQKMJi0KFNkjMLaJ9uiZqRtMmuN5TjbecfnpaFPx9xYXGD5PElAhUqZRswj4Ns2Rk5yatqr2wFItI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879111; c=relaxed/simple;
	bh=5YKhQZlYIbOO3lSGXjWMV/yxIepJ0KVjHzBcaSlgFtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPTeeHhgFVMvApB2/rtO+lajOEmFN9srBV5VkpOhmrwQyPKfP7HV//f4dGIKmZIZOtcZmrxFf+ut973Sf6TK/DX3A6pYeWTkO4uzgWr6BhbvpAs5jD0JSsSSxJhb5PKOWmkmkxH/IdY7iejqntSe1DPQt+JSYrw6cVDVykqmux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bosTIUpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63080C4CEE5;
	Tue, 14 Jan 2025 18:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736879111;
	bh=5YKhQZlYIbOO3lSGXjWMV/yxIepJ0KVjHzBcaSlgFtg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bosTIUpBaBumIyUPwCqdbJwJ7MKwKdEbzzwJ/htu0GmuDyvqsCjDKpR93EbvcheWM
	 2PgYdvUOT9JI3/wWo3IFgGxwF8YML93dROX4rjlOmevmvdV2hLcnV5u7UYJXsh8i3Q
	 vq5/aQXwLYrgZiIpOuF2KVXnXdT9v9VyKiF04iu740iA0ThtZGzmwT8t1aSvGNOYLY
	 hHKWyTvKFBUuJI56eAX8jQ5SNIU+zX4U2RViXoITiC+lnMtq6VJG/P/BfI/nOAUFfY
	 6sr36wmEpHNsiUDpHCQ/3WTW6t1efQ9Gn9MWtIncUFNM7nlFlWapM+U1LLb/cTAQJ8
	 humtbKDgO65Cw==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eba583fbe8so1845763b6e.3;
        Tue, 14 Jan 2025 10:25:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFNEFP5Y6C29XZmVBOrpEfPfFP5g6nTMCtc3VPpWD9UQq6BTz5lllgrUWQlVHJh01BT+kKNh6FPyrJpHaT@vger.kernel.org, AJvYcCUxm9gy8AY6+LJY9LxYdl1a0lAv6k4XLPX4Bq9TWLvnH1o7AWtEP442GyMBRJKD30llnUurt6kbQVBF@vger.kernel.org, AJvYcCXSJj95h4K16RI0Jop/ChKQW0RiI13gdxGPz8Y4960KRecYSAt8RSu2f8hGd7d1vH8gDAaX23apVQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZAeJN9erZivrQckwB+gBJ31zOKuVNQ+JKIHv/84uqX0KHWZBr
	5ufCY9nMz0x85mtfCAvWhKd/dl1wpjWl20lWbQL6zOgIfBhUGWlo8QTnwIAM2Xd/CWFucMqC/V6
	pwJL4edeKtsD9j8kp23zIifxz2Aw=
X-Google-Smtp-Source: AGHT+IEQozXhSfC1eKwhP0EwUJDrlzbK1C+OQacU6wDBqCWlN/J3ZE+LDTLMIWsib/iidkeYkGW5cTR73YUrDGXYOps=
X-Received: by 2002:a05:6808:3387:b0:3ea:43b8:29f2 with SMTP id
 5614622812f47-3ef2ecfdaa6mr18753817b6e.17.1736879110607; Tue, 14 Jan 2025
 10:25:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com> <20250113122104.3870673-6-zhenglifeng1@huawei.com>
In-Reply-To: <20250113122104.3870673-6-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 19:24:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0go8y7E2kCDbPYKcwppp0iGzZb3WiKAMhcMRMf_wrUVGA@mail.gmail.com>
X-Gm-Features: AbW1kvYL2DrybG7DNEuKeeWPQadAvHPkbEkIiDVxwqPV0qSsplmSKMFYdZlC238
Message-ID: <CAJZ5v0go8y7E2kCDbPYKcwppp0iGzZb3WiKAMhcMRMf_wrUVGA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] ACPI: CPPC: Add autonomous selection ABIs
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	viresh.kumar@linaro.org, mario.limonciello@amd.com, gautham.shenoy@amd.com, 
	ray.huang@amd.com, pierre.gondois@arm.com, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com, 
	fanghao11@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 1:21=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:

This should mention the specification revision and section number(s)
for the specification material the code is based on.

> cppc_set_epp - write energy performance preference register value
>
> cppc_get_auto_act_window - read autonomous activity window register value
>
> cppc_set_auto_act_window - write autonomous activity window register valu=
e
>
> cppc_get_auto_sel - read autonomous selection enable register value,
> modified from cppc_get_auto_sel_caps()

It would be better to move the modification part into a separate patch.

> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c     | 82 ++++++++++++++++++++++++++++++++----
>  drivers/cpufreq/amd-pstate.c |  3 +-
>  include/acpi/cppc_acpi.h     | 30 +++++++++++--
>  3 files changed, 103 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 03134613311d..7bfe30f7b40f 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1568,23 +1568,89 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_c=
trls *perf_ctrls, bool enable)
>  EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>
>  /**
> - * cppc_get_auto_sel_caps - Read autonomous selection register.
> - * @cpunum : CPU from which to read register.
> - * @perf_caps : struct where autonomous selection register value is upda=
ted.
> + * cppc_set_epp() - Write the EPP register.
> + * @cpu: CPU on which to write register.
> + * @epp_val: Value to write to the EPP register.
>   */
> -int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> +int cppc_set_epp(int cpu, u64 epp_val)
>  {
> -       u64 auto_sel;
> +       if (epp_val > CPPC_ENERGY_PERF_MAX)
> +               return -EINVAL;
> +
> +       return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_epp);
> +
> +/**
> + * cppc_get_auto_act_window() - Read autonomous activity window register=
.
> + * @cpu: CPU from which to read register.
> + * @auto_act_window: Return address.

It would be good to describe the autonomous activity window encoding.

> + */
> +int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
> +{
> +       unsigned int exp;
> +       u64 val, sig;
> +       int ret;
> +
> +       ret =3D cppc_get_reg_val(cpu, AUTO_ACT_WINDOW, &val);
> +       if (ret)
> +               return ret;
> +
> +       sig =3D val & CPPC_AUTO_ACT_WINDOW_MAX_SIG;
> +       exp =3D (val >> CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE) & CPPC_AUTO_AC=
T_WINDOW_MAX_EXP;
> +       *auto_act_window =3D sig * int_pow(10, exp);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_auto_act_window);
> +
> +/**
> + * cppc_set_auto_act_window() - Write autonomous activity window registe=
r.
> + * @cpu: CPU on which to write register.
> + * @auto_act_window: usec value to write to the autonomous activity wind=
ow register.
> + */
> +int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
> +{
> +       u64 max_val =3D CPPC_AUTO_ACT_WINDOW_MAX_SIG * int_pow(10, CPPC_A=
UTO_ACT_WINDOW_MAX_EXP);
> +       int digits =3D 0;
> +       u64 val;
> +
> +       if (auto_act_window > max_val)
> +               return -EINVAL;
> +
> +       while (auto_act_window > CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH) {
> +               auto_act_window /=3D 10;
> +               digits +=3D 1;
> +       }
> +
> +       if (auto_act_window > CPPC_AUTO_ACT_WINDOW_MAX_SIG)
> +               auto_act_window =3D CPPC_AUTO_ACT_WINDOW_MAX_SIG;

It looks like this may clobber the most significant bit, or am I mistaken?

> +
> +       val =3D (digits << CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE) + auto_act_=
window;
> +
> +       return cppc_set_reg_val(cpu, AUTO_ACT_WINDOW, val);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_auto_act_window);
> +
> +/**
> + * cppc_get_auto_sel() - Read autonomous selection register.
> + * @cpu: CPU from which to read register.
> + * @enable: Return address.
> + */
> +int cppc_get_auto_sel(int cpu, bool *enable)
> +{
> +       u64 val;
>         int ret;
>
> -       ret =3D cppc_get_reg_val(cpunum, AUTO_SEL_ENABLE, &auto_sel);
> +       ret =3D cppc_get_reg_val(cpu, AUTO_SEL_ENABLE, &val);
>         if (ret)
>                 return ret;
>
> -       perf_caps->auto_sel =3D (bool)auto_sel;
> +       *enable =3D (bool)val;
> +
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
> +EXPORT_SYMBOL_GPL(cppc_get_auto_sel);
>
>  /**
>   * cppc_set_auto_sel - Write autonomous selection register.
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 66e5dfc711c0..8bc11d0618f8 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -399,6 +399,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudat=
a)
>  {
>         struct cppc_perf_caps cppc_perf;
>         u64 numerator;
> +       bool auto_sel;
>
>         int ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>         if (ret)
> @@ -420,7 +421,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudat=
a)
>         if (cppc_state =3D=3D AMD_PSTATE_ACTIVE)
>                 return 0;
>
> -       ret =3D cppc_get_auto_sel_caps(cpudata->cpu, &cppc_perf);
> +       ret =3D cppc_get_auto_sel(cpudata->cpu, &auto_sel);
>         if (ret) {
>                 pr_warn("failed to get auto_sel, ret: %d\n", ret);
>                 return 0;
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 62d368bcd9ec..325e9543e08f 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -32,6 +32,15 @@
>  #define        CMD_READ 0
>  #define        CMD_WRITE 1
>
> +#define CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE      (7)
> +#define CPPC_AUTO_ACT_WINDOW_EXP_BIT_SIZE      (3)
> +#define CPPC_AUTO_ACT_WINDOW_MAX_SIG   ((1 << CPPC_AUTO_ACT_WINDOW_SIG_B=
IT_SIZE) - 1)
> +#define CPPC_AUTO_ACT_WINDOW_MAX_EXP   ((1 << CPPC_AUTO_ACT_WINDOW_EXP_B=
IT_SIZE) - 1)
> +/* CPPC_AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127=
 when writing */
> +#define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
> +
> +#define CPPC_ENERGY_PERF_MAX   (0xFF)
> +
>  /* Each register has the folowing format. */
>  struct cpc_reg {
>         u8 descriptor;
> @@ -159,7 +168,10 @@ extern int cpc_read_ffh(int cpunum, struct cpc_reg *=
reg, u64 *val);
>  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>  extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>  extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls=
, bool enable);
> -extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *per=
f_caps);
> +extern int cppc_set_epp(int cpu, u64 epp_val);
> +extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
> +extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
> +extern int cppc_get_auto_sel(int cpu, bool *enable);
>  extern int cppc_set_auto_sel(int cpu, bool enable);
>  extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>  extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerato=
r);
> @@ -229,11 +241,23 @@ static inline int cppc_get_epp_perf(int cpunum, u64=
 *epp_perf)
>  {
>         return -EOPNOTSUPP;
>  }
> -static inline int cppc_set_auto_sel(int cpu, bool enable)
> +static inline int cppc_set_epp(int cpu, u64 epp_val)
>  {
>         return -EOPNOTSUPP;
>  }
> -static inline int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_ca=
ps *perf_caps)
> +static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window=
)
> +{
> +       return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
> +{
> +       return -EOPNOTSUPP;
> +}
> +static inline int cppc_get_auto_sel(int cpu, bool *enable)
> +{
> +       return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_auto_sel(int cpu, bool enable)
>  {
>         return -EOPNOTSUPP;
>  }
> --
> 2.33.0
>
>

