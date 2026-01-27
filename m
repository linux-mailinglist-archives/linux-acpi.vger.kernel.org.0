Return-Path: <linux-acpi+bounces-20688-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFZULoUdeWkQvgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20688-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 21:18:13 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 666F99A4B3
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 21:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A2B43041BF9
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 20:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF9F36EAB6;
	Tue, 27 Jan 2026 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW70FeFZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890D36EAA7
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769545063; cv=none; b=uJo39JtPqovGLCTQdUDhftCUaU9NNg+3ZXJ2AhDlaa4xptqeqgf1dj2iWb9oj4QJk5CmJFdyaFs8siMIkeF4GYmrSv2MaF7qIYPXMCiGZIg9TtrMLeRfzBRXl55DX8Z4fixsnuqRzVvPMe9P25zvgd1XeBsuefC7EHQreP8FIIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769545063; c=relaxed/simple;
	bh=a33Hqp1gxCbHs3ozHKcUQHsfvseir6CgyC/3r5RJM6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbVRhnEH/0DeniMAxp7iGa2ZJbfwbP+uXtsne/G8LcpsDDhKPol+Q0DtiQlRtRlFa8/DysSBGbl3FrzH2qqE1uY2IlpjnbtwYna5HakXf2fTckJk4Gyn9LkJaVnhhOvedXlbOUjz2wemAD/Lr2H0xrIWY02aEXRYLXjvuu1P3K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW70FeFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D23FC19422
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 20:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769545063;
	bh=a33Hqp1gxCbHs3ozHKcUQHsfvseir6CgyC/3r5RJM6I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HW70FeFZrSJ5tBsfLLlIAQhEzhETh6tGJ8tsLmA0yCoS3laS0upD795WkBN21W5zq
	 B8ciEbjNYs6hbdNNW+kVuQ5z5T3eDTRzjv7tC8n/3yakZRq6PJpEGuuQ4XZnWsBw0T
	 wAWDeOfbJz8Re4DdBwfr7/KuHsJ/IfMgGS2JWa+lCgBEGGWu3M6s5a90nnzE/aqx52
	 3XussOr8obvtKWz4Ei2gYzEA4AloJKZNuC+UC8qLC0xdwkigb0x+Y3K38uttqKiwhL
	 72aArRFqF+7eQd8x+V9XAiuTuAeJEbRYqpKmrbXk5EKag7XV0oWkPchUkwUUpCsSF7
	 /bPfKndaxVoJQ==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-662f482180aso401268eaf.2
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 12:17:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQLdQRsNMMKjz7MPgfTdwxyItHtrI2BxTRNEpD/+bBsZC8yW1TpFqVc9AiRcRgE9L8amlMy7Lqr8Nb@vger.kernel.org
X-Gm-Message-State: AOJu0YxXVUVAaGViq11W0Ljk0voog3KQeQYWqpufsDDt9WKzTgFbrR7U
	9OvlxOrteZoMXlT6KohkaGYrHUBAX1jMXA7TFydRL+iNSr3EvNSkBaTjhmMCjLw4nyshT0Prw9h
	sTOkTO5Faqj3tAoY5EnL4BJNDZpR+2pA=
X-Received: by 2002:a4a:cf16:0:b0:662:f6b4:8c4e with SMTP id
 006d021491bc7-662f6b48e48mr773192eaf.80.1769545062036; Tue, 27 Jan 2026
 12:17:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120145623.2959636-1-sumitg@nvidia.com> <20260120145623.2959636-2-sumitg@nvidia.com>
 <CAJZ5v0ipgGt7tetY6p0CW0jyOh9TVeWxgXpFzveTa2CaGB8ZpA@mail.gmail.com> <6be02e54-dd4a-4d8f-b2ee-291da63b0bf2@nvidia.com>
In-Reply-To: <6be02e54-dd4a-4d8f-b2ee-291da63b0bf2@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 21:17:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j8Z3dUZUuUUZPiGthN7yg03yDpWARGJLE8U2fCeUK8Qw@mail.gmail.com>
X-Gm-Features: AZwV_QhFFimFgohPagii-2LtTrRkBzebBcIWZn4w-qFlB50tTtELmDGXQrkWWSI
Message-ID: <CAJZ5v0j8Z3dUZUuUUZPiGthN7yg03yDpWARGJLE8U2fCeUK8Qw@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] cpufreq: CPPC: Add generic helpers for sysfs show/store
To: Sumit Gupta <sumitg@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, pierre.gondois@arm.com, 
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
	TAGGED_FROM(0.00)[bounces-20688-lists,linux-acpi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 666F99A4B3
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 8:01=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
>
> On 27/01/26 21:54, Rafael J. Wysocki wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, Jan 20, 2026 at 3:57=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com>=
 wrote:
> >> Add generic helper functions for u64 sysfs attributes that follow the
> >> common pattern of calling CPPC get/set APIs:
> >> - cppc_cpufreq_sysfs_show_u64(): reads value and handles -EOPNOTSUPP
> >> - cppc_cpufreq_sysfs_store_u64(): parses input and calls set function
> >>
> >> Add CPPC_CPUFREQ_ATTR_RW_U64() macro to generate show/store functions
> >> using these helpers, reducing boilerplate for simple attributes.
> >>
> >> Convert auto_act_window and energy_performance_preference_val to use
> >> the new macro.
> >>
> >> No functional changes.
> >>
> >> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> >> ---
> >>   drivers/cpufreq/cppc_cpufreq.c | 69 ++++++++++++--------------------=
--
> >>   1 file changed, 25 insertions(+), 44 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpu=
freq.c
> >> index 36e8a75a37f1..c95dcd7719c3 100644
> >> --- a/drivers/cpufreq/cppc_cpufreq.c
> >> +++ b/drivers/cpufreq/cppc_cpufreq.c
> >> @@ -863,73 +863,54 @@ static ssize_t store_auto_select(struct cpufreq_=
policy *policy,
> >>          return count;
> >>   }
> >>
> >> -static ssize_t show_auto_act_window(struct cpufreq_policy *policy, ch=
ar *buf)
> >> +static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu,
> >> +                                          int (*get_func)(int, u64 *)=
,
> >> +                                          char *buf)
> >>   {
> >>          u64 val;
> >> -       int ret;
> >> -
> >> -       ret =3D cppc_get_auto_act_window(policy->cpu, &val);
> >> +       int ret =3D get_func((int)cpu, &val);
> >>
> >> -       /* show "<unsupported>" when this register is not supported by=
 cpc */
> >>          if (ret =3D=3D -EOPNOTSUPP)
> >>                  return sysfs_emit(buf, "<unsupported>\n");
> >> -
> >>          if (ret)
> >>                  return ret;
> >>
> >>          return sysfs_emit(buf, "%llu\n", val);
> >>   }
> >>
> >> -static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
> >> -                                    const char *buf, size_t count)
> >> +static ssize_t cppc_cpufreq_sysfs_store_u64(unsigned int cpu,
> >> +                                           int (*set_func)(int, u64),
> >> +                                           const char *buf, size_t co=
unt)
> >>   {
> >> -       u64 usec;
> >> +       u64 val;
> >>          int ret;
> >>
> >> -       ret =3D kstrtou64(buf, 0, &usec);
> >> +       ret =3D kstrtou64(buf, 0, &val);
> >>          if (ret)
> >>                  return ret;
> >>
> >> -       ret =3D cppc_set_auto_act_window(policy->cpu, usec);
> >> -       if (ret)
> >> -               return ret;
> >> +       ret =3D set_func((int)cpu, val);
> >>
> >> -       return count;
> >> +       return ret ? ret : count;
> >>   }
> >>
> >> -static ssize_t show_energy_performance_preference_val(struct cpufreq_=
policy *policy, char *buf)
> >> -{
> >> -       u64 val;
> >> -       int ret;
> >> -
> >> -       ret =3D cppc_get_epp_perf(policy->cpu, &val);
> >> -
> >> -       /* show "<unsupported>" when this register is not supported by=
 cpc */
> >> -       if (ret =3D=3D -EOPNOTSUPP)
> >> -               return sysfs_emit(buf, "<unsupported>\n");
> >> -
> >> -       if (ret)
> >> -               return ret;
> >> -
> >> -       return sysfs_emit(buf, "%llu\n", val);
> >> +#define CPPC_CPUFREQ_ATTR_RW_U64(_name, _get_func, _set_func)        =
  \
> >> +static ssize_t show_##_name(struct cpufreq_policy *policy, char *buf)=
  \
> >> +{                                                                    =
  \
> >> +       return cppc_cpufreq_sysfs_show_u64(policy->cpu, _get_func, buf=
);\
> >> +}                                                                    =
  \
> >> +static ssize_t store_##_name(struct cpufreq_policy *policy,          =
  \
> >> +                            const char *buf, size_t count)           =
  \
> >> +{                                                                    =
  \
> >> +       return cppc_cpufreq_sysfs_store_u64(policy->cpu, _set_func,   =
  \
> >> +                                           buf, count);              =
  \
> >>   }
> >>
> >> -static ssize_t store_energy_performance_preference_val(struct cpufreq=
_policy *policy,
> >> -                                                      const char *buf=
, size_t count)
> >> -{
> >> -       u64 val;
> >> -       int ret;
> >> +CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get_auto_act_window,
> >> +                        cppc_set_auto_act_window)
> >>
> >> -       ret =3D kstrtou64(buf, 0, &val);
> >> -       if (ret)
> >> -               return ret;
> >> -
> >> -       ret =3D cppc_set_epp(policy->cpu, val);
> >> -       if (ret)
> >> -               return ret;
> >> -
> >> -       return count;
> >> -}
> >> +CPPC_CPUFREQ_ATTR_RW_U64(energy_performance_preference_val,
> >> +                        cppc_get_epp_perf, cppc_set_epp)
> >>
> >>   cpufreq_freq_attr_ro(freqdomain_cpus);
> >>   cpufreq_freq_attr_rw(auto_select);
> >> --
> > It looks like this patch could be applied independently of the other
> > patches in the series.
> >
> > Do you want me to do so?
>
> Yes, this patch is independent and can be applied.

Applied as 6.20 material, thanks!

