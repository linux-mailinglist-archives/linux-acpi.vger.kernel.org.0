Return-Path: <linux-acpi+bounces-16331-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408D3B42255
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 15:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9753A57FA
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 13:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487022FB61A;
	Wed,  3 Sep 2025 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtV1vxk9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D872618;
	Wed,  3 Sep 2025 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907130; cv=none; b=dXU1Uq/RGcUSaPC/RSE4b/uNd/YgKjV40lv/5nd50GHCGF4ursOkLw2dYR10JmGH9ELS/9aQoFVQVxOvkmL2QF/SVbUIfWBLNtZDuQB9MFZnf3abunhLyrRL1BDaw1B05Fzji+2CVyhgkQFmo8zyjB79QHKVKiLBmCtfbdyLUy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907130; c=relaxed/simple;
	bh=6Bp49XvIiL/gpcZUSJHbjfPDkjkxFuVv8aVM1mwkppM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncAJg4mfq0B75xF6ONlw6yYpPHFicpTUwi5+8AUqGNztUzbLLIzi1c6+pYc2XDCwNG3X0DghGma7SFpKdj6GOemgMfd5eHGxcyDfhXyXk010qvfe1FeBHi/i4I3GIW78b1XGex6QSNEYjF5dW31UpT47ByoCVuLH3vml7iO4g4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtV1vxk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88B2C4CEFE;
	Wed,  3 Sep 2025 13:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756907129;
	bh=6Bp49XvIiL/gpcZUSJHbjfPDkjkxFuVv8aVM1mwkppM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EtV1vxk9Knh7vuhM8x4HkCnMMQg77LBHWAZjfHt0hykdAtk0J7zkljpn1dRo8ALRy
	 nJBjQbGoGlt335lc6Yejbwt37hjTv6p8SfDTunaRiW2oQzHQJq0rlhZtQ1LRmN6+mL
	 IGnwxZAwUAyqQhCdqcZjg6unlXq+oHZaIHgAwNaLEtGxgemHO0ZOaXw9RabH2oRHjO
	 1NAsUX1pvy8xvLLbjRFOhcQ7OcGTcv3rYRTxHcZtSDX9/AS365g+6AYkmZe7Gug6n+
	 egQHkiSWI1KySu6kre/fm/A9KyjZ9fyn2Wecsk4AkYcdc4XAKirge13OlUIx7BdFSr
	 JLHu0DYRXsxWw==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74382048b8cso4085416a34.3;
        Wed, 03 Sep 2025 06:45:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7mEeVQ8ID3EM2uvimvABgR5DEJPM8H2+TKiJl624j3/toRsNvUWGtgSHTmfrEsc3D4ft0bkMecAA=@vger.kernel.org, AJvYcCUNH1JaNwu50mHa7UCnsmuTy/zwyQtfKvQh2I1RkQ94Jqbbl/jBzs2vfLAlQIJwoZ7kocx47mh2YvQFqg==@vger.kernel.org, AJvYcCUPKgNgUxsgKTXeiA/XKh7oZDWbwHcmPo+SG5IzKakbFRGBWWIoWr901e58It41NatomCCR2VLKheVF@vger.kernel.org, AJvYcCUnpH0fe9ODPV8mftWp7RgSL+qnQYEayKq0cQPQ5YvYAo7DuPgOfYfmXbzi4lPGzLax1XCIxSB8kJaGy2mX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3oF7TQS+N82BAXvSkGK32/PGxbanOKNRFcyl1bUiqAbtcZGOv
	NUKvPIQhUkoKV9Nxv+hwgUhqhlWxn0ELbNxREK0AZlm6k5CdbzjFI3ht69oecG8dfMTjK8q+dTk
	jgFRnJidB0YPLW1krR0ceZDDLKDM0FOI=
X-Google-Smtp-Source: AGHT+IFj7tJ0lfFEWygwFa+BeDrtHlIidd3MSLvzw4pQoHyU3fN8psDlEaELWcEJ9+cmnisQYq8U5lt0bInRpr2lJAs=
X-Received: by 2002:a05:6830:6682:b0:745:9ba6:d32c with SMTP id
 46e09a7af769-7459ba6d61bmr1062886a34.2.1756907128976; Wed, 03 Sep 2025
 06:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903131733.57637-1-zhangzihuan@kylinos.cn> <20250903131733.57637-8-zhangzihuan@kylinos.cn>
In-Reply-To: <20250903131733.57637-8-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Sep 2025 15:45:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hirWzWZiLbAXPWB58SQv3CAW95iHLnsqs=i2twVCcmwg@mail.gmail.com>
X-Gm-Features: Ac12FXwBQmIxy8zPXuaWqJJ1Bp0qaxbUEME_ozpvMpdmoYPanY06xkhRVAoy8ys
Message-ID: <CAJZ5v0hirWzWZiLbAXPWB58SQv3CAW95iHLnsqs=i2twVCcmwg@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] powercap: dtpm_cpu: Use scope-based cleanup helper
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

On Wed, Sep 3, 2025 at 3:18=E2=80=AFPM Zihuan Zhang <zhangzihuan@kylinos.cn=
> wrote:
>
> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
> annotation for policy references. This reduces the risk of reference
> counting mistakes and aligns the code with the latest kernel style.
>
> No functional change intended.
>
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/powercap/dtpm_cpu.c | 30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 99390ec1481f..f76594185fa2 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -144,19 +144,17 @@ static int update_pd_power_uw(struct dtpm *dtpm)
>  static void pd_release(struct dtpm *dtpm)
>  {
>         struct dtpm_cpu *dtpm_cpu =3D to_dtpm_cpu(dtpm);
> -       struct cpufreq_policy *policy;
>
>         if (freq_qos_request_active(&dtpm_cpu->qos_req))
>                 freq_qos_remove_request(&dtpm_cpu->qos_req);
>
> -       policy =3D cpufreq_cpu_get(dtpm_cpu->cpu);
> -       if (policy) {
> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D
> +               cpufreq_cpu_get(dtpm_cpu->cpu);
> +
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
> @@ -192,7 +190,6 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>  static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>  {
>         struct dtpm_cpu *dtpm_cpu;
> -       struct cpufreq_policy *policy;
>         struct em_perf_state *table;
>         struct em_perf_domain *pd;
>         char name[CPUFREQ_NAME_LEN];
> @@ -202,21 +199,19 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *p=
arent)
>         if (dtpm_cpu)
>                 return 0;
>
> -       policy =3D cpufreq_cpu_get(cpu);
> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D
> +               cpufreq_cpu_get(cpu);
> +
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
> @@ -239,7 +234,6 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *par=
ent)
>         if (ret < 0)
>                 goto out_dtpm_unregister;

So this change kind of goes against another recommendation given in cleanup=
.h:

 * Lastly, given that the benefit of cleanup helpers is removal of
 * "goto", and that the "goto" statement can jump between scopes, the
 * expectation is that usage of "goto" and cleanup helpers is never
 * mixed in the same function. I.e. for a given routine, convert all
 * resources that need a "goto" cleanup to scope-based cleanup, or
 * convert none of them.

>
> -       cpufreq_cpu_put(policy);
>         return 0;
>
>  out_dtpm_unregister:
> @@ -251,8 +245,6 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *par=
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

