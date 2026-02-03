Return-Path: <linux-acpi+bounces-20831-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIqnON7ugWlAMwMAu9opvQ
	(envelope-from <linux-acpi+bounces-20831-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 13:49:34 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F7FD94FE
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 13:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D877930F96B5
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 12:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9318346797;
	Tue,  3 Feb 2026 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCWble3H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B77345CDA
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122608; cv=none; b=N2nrL71hZbod0rcfxW534tvHQQekSWOblY8jXhujFP16BiF0jpWFvVKyInilgWmtrJb24DBEZhrw48fAMpmu20k0k75eKF39gp7UiBA8hKwNNiCUJZSmZXBvD7dXf0U0TbAc5L+tyJaP5E99AZfg/hWoysm/+41zDCxXDOeq9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122608; c=relaxed/simple;
	bh=mZd/rRJm+j2XLVtDNOJg8+wal/AD+zG+qijo2HsFn3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHBHoF6eyetFuS45yQe5uGH15D1F26kUTn94E2KquK4YaQA+Ocn+lsszEhdM09io6D+mqVmO2TP72x8GBeZ0b9hopSH6gR6mfxh+ja1iq0ENo6l4TlUvPYTGIrc/ge3QM+Xu6O735FfFKaEr/SbL42Ft9PfKo7ELP6uX8RO5bvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCWble3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF98C2BCB4
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 12:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770122608;
	bh=mZd/rRJm+j2XLVtDNOJg8+wal/AD+zG+qijo2HsFn3k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UCWble3HP3lAK0/pCkoI1qYk1oTcyLbNOFK/L4g4DlAJ2jvUc2VKrLmeVyFmpw18K
	 KeGnAcXSPfs3S8haumG2/+WVfafWkWk8FawUx2WLc6JB3BiiyDNGwsCiHid7whozdS
	 uS3glrOOAMJDqXeAsX+Ii4uksIKjT747TvygdjlZ9w2NYhFBxKlhtMF6Okpk8HIMSX
	 0XwF1nxAKuQa9f6BV7scwLGoqmnv+aBTikmMfhjJfwf0+13Z3tZDYMs86A5/btpMRQ
	 pIE+WptD/Hoy8TLaP4BG5bs7fuWpBD9u85emqx4MhsS5vp+yD0DE/6LPEiS7VqzSNk
	 AkO/bcGoFgT9Q==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40970f97638so3234660fac.3
        for <linux-acpi@vger.kernel.org>; Tue, 03 Feb 2026 04:43:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtuMH06ansnhqUp8WVOmReRiLYxPoSU2oJrfH07r4uTI7NDQKICOed1A8rKfHzUbrWTQni4/GxC9m1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4nKtes/+aVYkMPjuC5AmF4szP6Va9mkZ2Wk0BT1xh4acDhdi6
	I2xCzpjYqNT6dAVvgrXcVlveehMtPrFIIVy+ud4xB2xXEt+vFKJH4xbgijKl8KVmzv9m1dqH0Zd
	Ti6kvn+SRnNDJCTPkSA9dWrjXYELpDok=
X-Received: by 2002:a05:6870:670f:b0:3e8:44ec:3416 with SMTP id
 586e51a60fabf-409a6fa44f9mr8478282fac.46.1770122607156; Tue, 03 Feb 2026
 04:43:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129104817.3752340-1-sumitg@nvidia.com> <20260129104817.3752340-5-sumitg@nvidia.com>
In-Reply-To: <20260129104817.3752340-5-sumitg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Feb 2026 13:43:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gBHrGf4TpjqV+W5YynM+9_xWpepgrOiRegSYS9CvPV1g@mail.gmail.com>
X-Gm-Features: AZwV_QjVRklFsBbxunUgZdAOD-oVH-VL28_adwBbZi1k2GS2C5NcJDp_4v584rY
Message-ID: <CAJZ5v0gBHrGf4TpjqV+W5YynM+9_xWpepgrOiRegSYS9CvPV1g@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for min/max_perf
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com, 
	zhenglifeng1@huawei.com, ionela.voinescu@arm.com, lenb@kernel.org, 
	robert.moore@intel.com, corbet@lwn.net, rdunlap@infradead.org, 
	ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com, 
	perry.yuan@amd.com, zhanjie9@hisilicon.com, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	nhartman@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20831-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 74F7FD94FE
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:49=E2=80=AFAM Sumit Gupta <sumitg@nvidia.com> wr=
ote:
>
> Add cppc_get/set_min_perf() and cppc_get/set_max_perf() APIs to read and
> write the MIN_PERF and MAX_PERF registers.
>
> Also add sysfs interfaces (min_perf, max_perf) in cppc_cpufreq driver
> to expose these controls to userspace. The sysfs values are in frequency
> (kHz) for consistency with other cpufreq sysfs files.

But this is not cpufreq and it is not consistent.

> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/cppc_acpi.c       |  44 +++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 165 +++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h       |  20 ++++
>  3 files changed, 229 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 08e62b58eb83..b2b8daab69ed 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1753,6 +1753,50 @@ int cppc_set_auto_sel(int cpu, bool enable)
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
>
> +/**
> + * cppc_get_min_perf - Read minimum performance register.
> + * @cpu: CPU from which to read register.
> + * @min_perf: Return address.
> + */
> +int cppc_get_min_perf(int cpu, u64 *min_perf)
> +{
> +       return cppc_get_reg_val(cpu, MIN_PERF, min_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_min_perf);
> +
> +/**
> + * cppc_set_min_perf - Write minimum performance register.
> + * @cpu: CPU to which to write register.
> + * @min_perf: the desired minimum performance value to be updated.
> + */
> +int cppc_set_min_perf(int cpu, u32 min_perf)
> +{
> +       return cppc_set_reg_val(cpu, MIN_PERF, min_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_min_perf);
> +
> +/**
> + * cppc_get_max_perf - Read maximum performance register.
> + * @cpu: CPU from which to read register.
> + * @max_perf: Return address.
> + */
> +int cppc_get_max_perf(int cpu, u64 *max_perf)
> +{
> +       return cppc_get_reg_val(cpu, MAX_PERF, max_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_max_perf);
> +
> +/**
> + * cppc_set_max_perf - Write maximum performance register.
> + * @cpu: CPU to which to write register.
> + * @max_perf: the desired maximum performance value to be updated.
> + */
> +int cppc_set_max_perf(int cpu, u32 max_perf)
> +{
> +       return cppc_set_reg_val(cpu, MAX_PERF, max_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_max_perf);
> +
>  /**
>   * cppc_set_enable - Set to enable CPPC on the processor by writing the
>   * Continuous Performance Control package EnableRegister field.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index 1421f30e87e4..8787185cd8b0 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -570,6 +570,35 @@ static void populate_efficiency_class(void)
>  }
>  #endif
>
> +/* Set min/max performance HW register and cache the value */
> +static int cppc_cpufreq_set_mperf_reg(struct cpufreq_policy *policy,
> +                                     u64 val, bool is_min)
> +{
> +       struct cppc_cpudata *cpu_data =3D policy->driver_data;
> +       struct cppc_perf_caps *caps =3D &cpu_data->perf_caps;
> +       unsigned int cpu =3D policy->cpu;
> +       u32 perf;
> +       int ret;
> +
> +       perf =3D clamp(val, caps->lowest_perf, caps->highest_perf);
> +
> +       ret =3D is_min ? cppc_set_min_perf(cpu, perf) :
> +                      cppc_set_max_perf(cpu, perf);
> +       if (ret) {
> +               if (ret !=3D -EOPNOTSUPP)
> +                       pr_warn("CPU%d: set %s_perf=3D%u failed (%d)\n",
> +                               cpu, is_min ? "min" : "max", perf, ret);
> +               return ret;
> +       }
> +
> +       if (is_min)
> +               cpu_data->perf_ctrls.min_perf =3D perf;
> +       else
> +               cpu_data->perf_ctrls.max_perf =3D perf;
> +
> +       return 0;
> +}
> +
>  static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>  {
>         struct cppc_cpudata *cpu_data;
> @@ -919,16 +948,152 @@ CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get=
_auto_act_window,
>  CPPC_CPUFREQ_ATTR_RW_U64(energy_performance_preference_val,
>                          cppc_get_epp_perf, cppc_set_epp)
>
> +/**
> + * show_min_perf - Show minimum performance as frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer to write the frequency value to
> + *
> + * Reads the MIN_PERF register and converts the performance value to
> + * frequency (kHz).
> + */
> +static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
> +{
> +       struct cppc_cpudata *cpu_data =3D policy->driver_data;
> +       struct cppc_perf_caps *caps =3D &cpu_data->perf_caps;
> +       u64 perf;
> +       int ret;
> +
> +       ret =3D cppc_get_min_perf(policy->cpu, &perf);
> +       if (ret =3D=3D -EOPNOTSUPP)
> +               return sysfs_emit(buf, "<unsupported>\n");
> +       if (ret)
> +               return ret;
> +
> +       /* Use lowest_perf if register is uninitialized or out of range *=
/
> +       if (perf =3D=3D 0 || perf < caps->lowest_perf)
> +               perf =3D caps->lowest_perf;
> +
> +       /* Convert performance to frequency (kHz) for user */
> +       return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(caps, perf));
> +}
> +
> +/**
> + * store_min_perf - Set minimum performance from frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer containing the frequency value
> + * @count: size of @buf
> + *
> + * Converts the user-provided frequency (kHz) to a performance value
> + * and writes it to the MIN_PERF register.
> + */
> +static ssize_t store_min_perf(struct cpufreq_policy *policy, const char =
*buf,
> +                             size_t count)
> +{
> +       struct cppc_cpudata *cpu_data =3D policy->driver_data;
> +       unsigned int freq_khz;
> +       u64 perf;
> +       int ret;
> +
> +       ret =3D kstrtouint(buf, 0, &freq_khz);
> +       if (ret)
> +               return ret;
> +
> +       /* Convert frequency (kHz) to performance value */
> +       perf =3D cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
> +
> +       /*
> +        * min_perf must be less than or equal to max_perf.
> +        * Skip check if max_perf is 0 (uninitialized).
> +        */
> +       if (cpu_data->perf_ctrls.max_perf &&
> +           perf > cpu_data->perf_ctrls.max_perf)
> +               return -EINVAL;
> +
> +       ret =3D cppc_cpufreq_set_mperf_reg(policy, perf, true);
> +       if (ret)
> +               return ret;
> +
> +       return count;
> +}
> +
> +/**
> + * show_max_perf - Show maximum performance as frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer to write the frequency value to
> + *
> + * Reads the MAX_PERF register and converts the performance value to
> + * frequency (kHz).
> + */
> +static ssize_t show_max_perf(struct cpufreq_policy *policy, char *buf)
> +{
> +       struct cppc_cpudata *cpu_data =3D policy->driver_data;
> +       struct cppc_perf_caps *caps =3D &cpu_data->perf_caps;
> +       u64 perf;
> +       int ret;
> +
> +       ret =3D cppc_get_max_perf(policy->cpu, &perf);
> +       if (ret =3D=3D -EOPNOTSUPP)
> +               return sysfs_emit(buf, "<unsupported>\n");
> +       if (ret)
> +               return ret;
> +
> +       /* Use highest_perf if register is uninitialized or out of range =
*/
> +       if (perf =3D=3D 0 || perf > caps->highest_perf)
> +               perf =3D caps->highest_perf;
> +
> +       /* Convert performance to frequency (kHz) for user */
> +       return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(caps, perf));
> +}
> +
> +/**
> + * store_max_perf - Set maximum performance from frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer containing the frequency value
> + * @count: size of @buf
> + *
> + * Converts the user-provided frequency (kHz) to a performance value
> + * and writes it to the MAX_PERF register.
> + */
> +static ssize_t store_max_perf(struct cpufreq_policy *policy, const char =
*buf,
> +                             size_t count)
> +{
> +       struct cppc_cpudata *cpu_data =3D policy->driver_data;
> +       unsigned int freq_khz;
> +       u64 perf;
> +       int ret;
> +
> +       ret =3D kstrtouint(buf, 0, &freq_khz);
> +       if (ret)
> +               return ret;
> +
> +       /* Convert frequency (kHz) to performance value */
> +       perf =3D cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
> +
> +       /* max_perf must be greater than or equal to min_perf */
> +       if (perf < cpu_data->perf_ctrls.min_perf)
> +               return -EINVAL;
> +
> +       ret =3D cppc_cpufreq_set_mperf_reg(policy, perf, false);
> +       if (ret)
> +               return ret;
> +
> +       return count;
> +}
> +
>  cpufreq_freq_attr_ro(freqdomain_cpus);
>  cpufreq_freq_attr_rw(auto_select);
>  cpufreq_freq_attr_rw(auto_act_window);
>  cpufreq_freq_attr_rw(energy_performance_preference_val);
> +cpufreq_freq_attr_rw(min_perf);
> +cpufreq_freq_attr_rw(max_perf);
>
>  static struct freq_attr *cppc_cpufreq_attr[] =3D {
>         &freqdomain_cpus,
>         &auto_select,
>         &auto_act_window,
>         &energy_performance_preference_val,
> +       &min_perf,
> +       &max_perf,
>         NULL,
>  };
>
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 3fc796c0d902..b358440cd0e2 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -174,6 +174,10 @@ extern int cppc_get_auto_act_window(int cpu, u64 *au=
to_act_window);
>  extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>  extern int cppc_get_auto_sel(int cpu, bool *enable);
>  extern int cppc_set_auto_sel(int cpu, bool enable);
> +extern int cppc_get_min_perf(int cpu, u64 *min_perf);
> +extern int cppc_set_min_perf(int cpu, u32 min_perf);
> +extern int cppc_get_max_perf(int cpu, u64 *max_perf);
> +extern int cppc_set_max_perf(int cpu, u32 max_perf);
>  extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>  extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerato=
r);
>  extern int amd_detect_prefcore(bool *detected);
> @@ -270,6 +274,22 @@ static inline int cppc_set_auto_sel(int cpu, bool en=
able)
>  {
>         return -EOPNOTSUPP;
>  }
> +static inline int cppc_get_min_perf(int cpu, u64 *min_perf)
> +{
> +       return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_min_perf(int cpu, u32 min_perf)
> +{
> +       return -EOPNOTSUPP;
> +}
> +static inline int cppc_get_max_perf(int cpu, u64 *max_perf)
> +{
> +       return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_max_perf(int cpu, u32 max_perf)
> +{
> +       return -EOPNOTSUPP;
> +}
>  static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_pe=
rf)
>  {
>         return -ENODEV;
> --
> 2.34.1
>

