Return-Path: <linux-acpi+bounces-20673-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDZ6MZbteGkCuAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20673-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 17:53:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B5698019
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 17:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36B15302AC92
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CC3361652;
	Tue, 27 Jan 2026 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+3TCoob"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4534222A7E4
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531089; cv=none; b=g1m5C3su/wAgDtPmkCD4x/fBUa/wNYixB2D/ye/UdWG5kHVycGpjhhIIqgC9T3H/9kaqlyoFdXwuaMMdzYove2MJd6M1+ayWZYdHcH2UzdXgacmiCLD7dbRi0yfa1frJTrCVBbNE43U/jcSg7FA0AHhHFaRro03rFvmIEILv0Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531089; c=relaxed/simple;
	bh=Mm7PNHjxKBBGvZCLiHpXhTyu74qmhr7ObXdQIYvFD28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMXCOW15qPdlfjJZxPf6ABwGnawgmXhnK/BghQyypndO1NcoZ31v1V/xDNeOcPVfIiZeRqBjZjS7AtTeZcS5cackGrmUgMJeWFgAQsFx4LD19wFJHmROBNhCBAqHnI+a9i2w+bAf9+V/hNpWHB2+p61xAXKhgfLb0fu96qPHZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+3TCoob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7622C116C6
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769531088;
	bh=Mm7PNHjxKBBGvZCLiHpXhTyu74qmhr7ObXdQIYvFD28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O+3TCoobbGE5lbquJWvD412uX+Lo4HRrbcOe9f1+mwoTljht28W33rWU3wk9vAEk3
	 cBXngJ0WcQzZhbvWxQs2sejKrEooRb9OMfDyw8qVzsTmPUhsdNLkT/7hqYwcLKPRxh
	 URHDlFinNh+a3fGZZvkMg0RM07YLenDu92v2EXSox/v+EQfguYdFvUldHeksp6el/E
	 R5rU+qV1LnJXMnbmAwno/Fx/+SeHlV4oT/Lnes4e3QMtlIFHteZTg/waNc3SZo3OzS
	 5P1AiEbAQ6Fs2vRxQhQAylqj6fhCeWZiK+EhGkp/2wdOIjtfpNYwJLlKU6mBrLIYcm
	 yABDjHjjIIlDg==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45effa36208so184411b6e.1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 08:24:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlt27dEhjOEKKiKD5L+KGY3WlQ4vjLFqExupuDE6ro6lAy4NrXByOMLLe2ob6ueOJZAmjb/oQ/KeHy@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4KQAcSs6l/uEfUGHD4espHj2UpRIpJEFF6XJQUax1M0nwFUV
	Lx5VXaXSYx5OVrawarbvSZFzFId3Ovw2FI4+La3KSABEmy85snjE2RA05gKeKMd/iDzSHfWNo2/
	vJQHqAyALXgW4tpcA8WASMTNqH5Uzi/Q=
X-Received: by 2002:a05:6808:1904:b0:450:ccef:c01f with SMTP id
 5614622812f47-45efc65eef8mr1065605b6e.34.1769531087995; Tue, 27 Jan 2026
 08:24:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120145623.2959636-1-sumitg@nvidia.com> <20260120145623.2959636-2-sumitg@nvidia.com>
In-Reply-To: <20260120145623.2959636-2-sumitg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 17:24:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ipgGt7tetY6p0CW0jyOh9TVeWxgXpFzveTa2CaGB8ZpA@mail.gmail.com>
X-Gm-Features: AZwV_Qg_oEiNndB5ZDCW_5HqO2fNprSPJkksUv7HA7IrMkSsJk1zm9cMtY4Gyck
Message-ID: <CAJZ5v0ipgGt7tetY6p0CW0jyOh9TVeWxgXpFzveTa2CaGB8ZpA@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] cpufreq: CPPC: Add generic helpers for sysfs show/store
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20673-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46B5698019
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 3:57=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
> Add generic helper functions for u64 sysfs attributes that follow the
> common pattern of calling CPPC get/set APIs:
> - cppc_cpufreq_sysfs_show_u64(): reads value and handles -EOPNOTSUPP
> - cppc_cpufreq_sysfs_store_u64(): parses input and calls set function
>
> Add CPPC_CPUFREQ_ATTR_RW_U64() macro to generate show/store functions
> using these helpers, reducing boilerplate for simple attributes.
>
> Convert auto_act_window and energy_performance_preference_val to use
> the new macro.
>
> No functional changes.
>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 69 ++++++++++++----------------------
>  1 file changed, 25 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index 36e8a75a37f1..c95dcd7719c3 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -863,73 +863,54 @@ static ssize_t store_auto_select(struct cpufreq_pol=
icy *policy,
>         return count;
>  }
>
> -static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char =
*buf)
> +static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu,
> +                                          int (*get_func)(int, u64 *),
> +                                          char *buf)
>  {
>         u64 val;
> -       int ret;
> -
> -       ret =3D cppc_get_auto_act_window(policy->cpu, &val);
> +       int ret =3D get_func((int)cpu, &val);
>
> -       /* show "<unsupported>" when this register is not supported by cp=
c */
>         if (ret =3D=3D -EOPNOTSUPP)
>                 return sysfs_emit(buf, "<unsupported>\n");
> -
>         if (ret)
>                 return ret;
>
>         return sysfs_emit(buf, "%llu\n", val);
>  }
>
> -static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
> -                                    const char *buf, size_t count)
> +static ssize_t cppc_cpufreq_sysfs_store_u64(unsigned int cpu,
> +                                           int (*set_func)(int, u64),
> +                                           const char *buf, size_t count=
)
>  {
> -       u64 usec;
> +       u64 val;
>         int ret;
>
> -       ret =3D kstrtou64(buf, 0, &usec);
> +       ret =3D kstrtou64(buf, 0, &val);
>         if (ret)
>                 return ret;
>
> -       ret =3D cppc_set_auto_act_window(policy->cpu, usec);
> -       if (ret)
> -               return ret;
> +       ret =3D set_func((int)cpu, val);
>
> -       return count;
> +       return ret ? ret : count;
>  }
>
> -static ssize_t show_energy_performance_preference_val(struct cpufreq_pol=
icy *policy, char *buf)
> -{
> -       u64 val;
> -       int ret;
> -
> -       ret =3D cppc_get_epp_perf(policy->cpu, &val);
> -
> -       /* show "<unsupported>" when this register is not supported by cp=
c */
> -       if (ret =3D=3D -EOPNOTSUPP)
> -               return sysfs_emit(buf, "<unsupported>\n");
> -
> -       if (ret)
> -               return ret;
> -
> -       return sysfs_emit(buf, "%llu\n", val);
> +#define CPPC_CPUFREQ_ATTR_RW_U64(_name, _get_func, _set_func)          \
> +static ssize_t show_##_name(struct cpufreq_policy *policy, char *buf)  \
> +{                                                                      \
> +       return cppc_cpufreq_sysfs_show_u64(policy->cpu, _get_func, buf);\
> +}                                                                      \
> +static ssize_t store_##_name(struct cpufreq_policy *policy,            \
> +                            const char *buf, size_t count)             \
> +{                                                                      \
> +       return cppc_cpufreq_sysfs_store_u64(policy->cpu, _set_func,     \
> +                                           buf, count);                \
>  }
>
> -static ssize_t store_energy_performance_preference_val(struct cpufreq_po=
licy *policy,
> -                                                      const char *buf, s=
ize_t count)
> -{
> -       u64 val;
> -       int ret;
> +CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get_auto_act_window,
> +                        cppc_set_auto_act_window)
>
> -       ret =3D kstrtou64(buf, 0, &val);
> -       if (ret)
> -               return ret;
> -
> -       ret =3D cppc_set_epp(policy->cpu, val);
> -       if (ret)
> -               return ret;
> -
> -       return count;
> -}
> +CPPC_CPUFREQ_ATTR_RW_U64(energy_performance_preference_val,
> +                        cppc_get_epp_perf, cppc_set_epp)
>
>  cpufreq_freq_attr_ro(freqdomain_cpus);
>  cpufreq_freq_attr_rw(auto_select);
> --

It looks like this patch could be applied independently of the other
patches in the series.

Do you want me to do so?

