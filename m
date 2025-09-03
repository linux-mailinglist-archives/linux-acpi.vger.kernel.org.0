Return-Path: <linux-acpi+bounces-16312-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEFEB41D3B
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 13:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DA16801A6
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 11:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD82FB63C;
	Wed,  3 Sep 2025 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpjrJSUQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85732C178E;
	Wed,  3 Sep 2025 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899811; cv=none; b=g6MvAxaCQWMutv1kHOlar6rZf7EBsFHXrm5e6sCxWr7QteToLUGVT4v5PfZxYfgyTE6a1VK2mcms95GFs9tVNRGkLXsGIWDfBJZl+yHsvMQ5wKAsjHqQsB6Fx9SNVfzgXeT1j6Kjq8sImuNc93d6JvjrIbPE3kLa8J00vKlMy6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899811; c=relaxed/simple;
	bh=vKQkkEhiJ1pWIqj+5+l0nwZXdLd03e23W2MiNNRAENI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=La3q3jRIuIMf9xvlEYXYDekNcLTUfbNq2eFsVTnfcQ9R9bXcV7tzQCeiVAX5H16dTsDmrNxe20BWaKNStytQ/nGgwxUeyF9ici8OYymGYrMYbR46kCeLfK1eAfr0P9aXnr0J/WgHRhU3/Kfnmp8I+mqB6cuHMlPu97OLsNTkln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpjrJSUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E255C4CEFC;
	Wed,  3 Sep 2025 11:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756899811;
	bh=vKQkkEhiJ1pWIqj+5+l0nwZXdLd03e23W2MiNNRAENI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZpjrJSUQT1mjo/GMosxVE9BlKGzz1qGPGvR96j4+cgvYWF0u5LAVlwLWXP3ABf9xh
	 emKGoXYpzikhccqTWnXBUrcQPaehl9+DjtD8mRrCZAUG0qMfiELP4YWuYF1/F3FhRs
	 aW14nUDCO+/AYANfE36disnrS+dbIk61uVm2aK4DwbZr4D6ZklHcUzH8AB5VT4ETkI
	 oemvw0KIyTt5h9EWGtcRYHX1XymPMBJ5M8rR/7taIhWazv9RCHjo2E6MQK1ZSFsIft
	 KMXYcw8DilfLBcBV9GtUI2eD4qkQH6J3a3mK4SaX7Nes6EUJ273H+CqQgGGZuh4kFd
	 y6ffvET3JkSjQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-61e334007dbso1481080eaf.0;
        Wed, 03 Sep 2025 04:43:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwvme+Cl2Of/GPNFGfBWeldeni0Ho+HqTzWfM7sK3d+EyfDNZV1kwOCzHOGc5qekfXtd156iVZvKo=@vger.kernel.org, AJvYcCX3o0eOscC7e1Z++/CM0MTTF8PyuH8H4n8mBd2Fn9PWuZe0P52i5zB+saTxTqPFCwqIL+G7664TuEv3@vger.kernel.org, AJvYcCXYv7Wk69UNWBeHoXryolRSW3jwobLFlPpmIyCpJiYE3e7Ogl8Fl1qHox0ijyOwhhMgTeTt+Nq3PhVQ2u8p@vger.kernel.org, AJvYcCXgokYL2tcGj4ZmPVQ+TL+VmvaHYP76h+Jdoydzf9SeIVmk3f4yicheFYxc7dJp/YnyYN4lKgo37BTGjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDfXuiKxHHIz27p/n/rdIuFjKQkETzm2KQRf8xfuqjnIWnUK1R
	b0ZZFXuBAbEFpWqHrH651oC+f/Zxv2QkkgdAM7hY5tdFUS2cKfaIrM1qr8PQIk39ow/wRe7P8p5
	/hk7Y178fIaPpII7Ukw2lPd85gfnuBiw=
X-Google-Smtp-Source: AGHT+IFudXZ/fyz4UQ3WH+8GjEXukDIGbLh/LZigzEMBTf0gXA3YZsKNByr0Anw/wDvM05EPCnSrOq7ywW0PFfzffo4=
X-Received: by 2002:a05:6820:1694:b0:619:7d9b:3f0b with SMTP id
 006d021491bc7-61e33740f82mr7219508eaf.5.1756899810069; Wed, 03 Sep 2025
 04:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901085748.36795-1-zhangzihuan@kylinos.cn> <20250901085748.36795-10-zhangzihuan@kylinos.cn>
In-Reply-To: <20250901085748.36795-10-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Sep 2025 13:43:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gwpefQt8VJ3XUyFy7u7rFhvPT=sXqG-1gHobw=1NgJpw@mail.gmail.com>
X-Gm-Features: Ac12FXwdhTUIKZ7oynz9F8Wzgqo7R3jPRBfEv1CLslQcvLPWz0YXuuodu9R2gpg
Message-ID: <CAJZ5v0gwpefQt8VJ3XUyFy7u7rFhvPT=sXqG-1gHobw=1NgJpw@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] powercap: dtpm_cpu: Use scope-based cleanup helper
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Thierry Reding <thierry.reding@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Ben Horgan <ben.horgan@arm.com>, 
	zhenglifeng <zhenglifeng1@huawei.com>, Zhang Rui <rui.zhang@intel.com>, 
	Len Brown <lenb@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Beata Michalska <beata.michalska@arm.com>, 
	Fabio Estevam <festevam@gmail.com>, Pavel Machek <pavel@kernel.org>, Sumit Gupta <sumitg@nvidia.com>, 
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 10:58=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
> annotation for policy references. This reduces the risk of reference
> counting mistakes and aligns the code with the latest kernel style.
>
> No functional change intended.
>
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/powercap/dtpm_cpu.c | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 99390ec1481f..5e18438782f8 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -144,19 +144,15 @@ static int update_pd_power_uw(struct dtpm *dtpm)
>  static void pd_release(struct dtpm *dtpm)
>  {
>         struct dtpm_cpu *dtpm_cpu =3D to_dtpm_cpu(dtpm);
> -       struct cpufreq_policy *policy;
> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpuf=
req_cpu_get(dtpm_cpu->cpu);
>
>         if (freq_qos_request_active(&dtpm_cpu->qos_req))
>                 freq_qos_remove_request(&dtpm_cpu->qos_req);
>
> -       policy =3D cpufreq_cpu_get(dtpm_cpu->cpu);

Since policy is not needed earlier, you may as well declare it here.

> -       if (policy) {
> +       if (policy)
>                 for_each_cpu(dtpm_cpu->cpu, policy->related_cpus)
>                         per_cpu(dtpm_per_cpu, dtpm_cpu->cpu) =3D NULL;
>
> -               cpufreq_cpu_put(policy);
> -       }
> -
>         kfree(dtpm_cpu);
>  }
>
> @@ -192,7 +188,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>  static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>  {
>         struct dtpm_cpu *dtpm_cpu;
> -       struct cpufreq_policy *policy;
> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpuf=
req_cpu_get(cpu);
>         struct em_perf_state *table;
>         struct em_perf_domain *pd;
>         char name[CPUFREQ_NAME_LEN];
> @@ -202,21 +198,16 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *p=
arent)
>         if (dtpm_cpu)
>                 return 0;
>
> -       policy =3D cpufreq_cpu_get(cpu);

Ditto.

>         if (!policy)
>                 return 0;
>
>         pd =3D em_cpu_get(cpu);
> -       if (!pd || em_is_artificial(pd)) {
> -               ret =3D -EINVAL;
> -               goto release_policy;
> -       }
> +       if (!pd || em_is_artificial(pd))
> +               return -EINVAL;
>
>         dtpm_cpu =3D kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
> -       if (!dtpm_cpu) {
> -               ret =3D -ENOMEM;
> -               goto release_policy;
> -       }
> +       if (!dtpm_cpu)
> +               return -ENOMEM;
>
>         dtpm_init(&dtpm_cpu->dtpm, &dtpm_ops);
>         dtpm_cpu->cpu =3D cpu;
> @@ -239,7 +230,6 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *par=
ent)
>         if (ret < 0)
>                 goto out_dtpm_unregister;
>
> -       cpufreq_cpu_put(policy);
>         return 0;
>
>  out_dtpm_unregister:
> @@ -251,8 +241,6 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *par=
ent)
>                 per_cpu(dtpm_per_cpu, cpu) =3D NULL;
>         kfree(dtpm_cpu);
>
> -release_policy:
> -       cpufreq_cpu_put(policy);
>         return ret;
>  }
>
> --

