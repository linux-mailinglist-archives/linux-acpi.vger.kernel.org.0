Return-Path: <linux-acpi+bounces-16438-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED658B46488
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 22:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4805C70CB
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 20:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEA2281351;
	Fri,  5 Sep 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIKc5zt2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4A52472A4;
	Fri,  5 Sep 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103459; cv=none; b=P0zEBIuNjCWsawEENSMocYkyKtd98NLTalO7IR6kSLABZrhlI90QmCeKbYGNBPjos7t8ad3q7BDvA2iWGLPzcFpJtgG1vxjteGejUh1VEyozYZVJDDoTl7pMEqCESCDhAwaSyfq5TsXbG8lkljo5NRF0F+UPU9BWl++aVaKx4f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103459; c=relaxed/simple;
	bh=VCWnUGzPf6mLuDmms/YZCG2llaFLvKJwA1gnXCCbRdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOUO0m7vCBcbqM44yiOHQESKRCp4tdJ6id8+gMrinGrE1+hrgCXSodgzPqQb3VLz6ZLM0iSNerlbQcTzq9WRyKJRf0N861lhjc7rrjJTmRC3Bsa2E4Uw9209d/tnBaD+mCw8LzfqZw+5FKMQqt1J+EkIdRfd74XPX3HyxPdFU+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIKc5zt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C78C19424;
	Fri,  5 Sep 2025 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757103458;
	bh=VCWnUGzPf6mLuDmms/YZCG2llaFLvKJwA1gnXCCbRdk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uIKc5zt24/XZwP7JYEqTfBfFRmX6Wk9YHD8HxEi0IvUGCXmYhq0zMpSm8supQ0Fb5
	 iJGS/xoCTwpWx6B21zvCyX58JiG6wKZeHnfKV9PrzdFD8g77UCWMhwV/+VxR8kAvlQ
	 yPVyT4akXZx6QFmh+sC2ZrMWYx9v4XhPjX4ZqEzVtRypqr58ssUWkgaJb/JjbHDIS4
	 Q06psN5PW+ZumYVyodesqKh7Uj5j1bR2yhf3Z/vTbdtMhbmMxPQZsd1C7tcDa8a8kX
	 RxRMOqOPKJoPYzcqOhn1uU/Cd9d8rzzAEwXshP6QHtlDLuGvIqnZfJzgThdRl7C/Wq
	 nxK2iLAKYjwYQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-61bd4ad64c7so801135eaf.0;
        Fri, 05 Sep 2025 13:17:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUraKzGHcjXYxM1x/+9H6tiER1I4b50o6C7rUX/4wtqzr/VOG9IGoSfNrhGWomA7QzUlxwix5GfGIZm@vger.kernel.org, AJvYcCVzPIiU1SNvKJUtQ7YeeoPzVxX8J3LFk/kijiUVPzVkeIPTZs21lE3YeABzKz60w9gIDNdsdUoF6YA=@vger.kernel.org, AJvYcCW33R3KoX3K4Z9WBena+05xnJDAfGRhXR2g/Wowh0HXWGpPiCqW+hzlMAqNPF9F88GHzcIRhzhUO2CIUQ==@vger.kernel.org, AJvYcCWeIQnyZ7xMarkvd48XpvBIVuEdVJfUwZ26Pr1xRpgQxQ/Z0BY8p9NaRaBsro6l1EQw7aA+SAa2AX6r4Bkz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxup4JkUgMLv2/to1UB8LLZENstzPjwt63ZTbRR96PJDlopYiIe
	CQWuKrqR0CD/5cFOCPYxe9c6F+LeuqbayCBOvLK1ZJs48u/6jo3MCVzJaCJ8/0nSzAe1UKOD7X1
	lfCdSUaQJfhS1zwtBXVQQa1ifj4vdEc0=
X-Google-Smtp-Source: AGHT+IEfq1HNckIyyDDXquy0XLtyGZg1XWmotG9HdXFUDIR4D+v0h/9IrUo3g6diO4+f6WOXTRuaooZELa2e+VnSV5o=
X-Received: by 2002:a05:6820:809:b0:61f:f932:8d64 with SMTP id
 006d021491bc7-61ff9329264mr2455383eaf.1.1757103457768; Fri, 05 Sep 2025
 13:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905132413.1376220-1-zhangzihuan@kylinos.cn> <20250905132413.1376220-3-zhangzihuan@kylinos.cn>
In-Reply-To: <20250905132413.1376220-3-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 22:17:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iTdgM5BBi2ysiJxfA2c=MQ0fjLsEvVct9stxomvEe=4Q@mail.gmail.com>
X-Gm-Features: Ac12FXw3PBjsIjj4AtBsEfmKTR7PfZEmevzc6Jwe0zbtA2TuWwqukJr66Nf1sL8
Message-ID: <CAJZ5v0iTdgM5BBi2ysiJxfA2c=MQ0fjLsEvVct9stxomvEe=4Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] ACPI: processor: thermal: Use scope-based cleanup helper
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
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

On Fri, Sep 5, 2025 at 3:24=E2=80=AFPM Zihuan Zhang <zhangzihuan@kylinos.cn=
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
>  drivers/acpi/processor_thermal.c | 52 +++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_th=
ermal.c
> index 1219adb11ab9..460713d1414a 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -62,19 +62,14 @@ static int phys_package_first_cpu(int cpu)
>         return 0;
>  }
>
> -static int cpu_has_cpufreq(unsigned int cpu)
> +static bool cpu_has_cpufreq(unsigned int cpu)
>  {
> -       struct cpufreq_policy *policy;
> -
>         if (!acpi_processor_cpufreq_init)
>                 return 0;
>
> -       policy =3D cpufreq_cpu_get(cpu);
> -       if (policy) {
> -               cpufreq_cpu_put(policy);
> -               return 1;
> -       }
> -       return 0;
> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpuf=
req_cpu_get(cpu);
> +
> +       return policy !=3D NULL;
>  }
>
>  static int cpufreq_get_max_state(unsigned int cpu)

The changes above are fine and can be sent as a separate patch.

> @@ -93,12 +88,31 @@ static int cpufreq_get_cur_state(unsigned int cpu)
>         return reduction_step(cpu);
>  }
>
> +static bool cpufreq_update_thermal_limit(unsigned int cpu, struct acpi_p=
rocessor *pr)
> +{
> +       unsigned long max_freq;
> +       int ret;
> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpuf=
req_cpu_get(cpu);
> +
> +       if (!policy)
> +               return false;
> +
> +       max_freq =3D (policy->cpuinfo.max_freq *
> +               (100 - reduction_step(cpu) * cpufreq_thermal_reduction_pc=
tg)) / 100;
> +
> +       ret =3D freq_qos_update_request(&pr->thermal_req, max_freq);
> +       if (ret < 0) {
> +               pr_warn("Failed to update thermal freq constraint: CPU%d =
(%d)\n",
> +         pr->id, ret);
> +       }

But this silently fixes a bug in the original code which needs to be
documented with a Fixes: tag (and it would be better to fix the bug
separately before the using the __free()-based cleanup TBH) and
introduces some whitespace breakage.

> +
> +       return true;
> +}
> +
>  static int cpufreq_set_cur_state(unsigned int cpu, int state)
>  {
> -       struct cpufreq_policy *policy;
>         struct acpi_processor *pr;
> -       unsigned long max_freq;
> -       int i, ret;
> +       int i;
>
>         if (!cpu_has_cpufreq(cpu))
>                 return 0;
> @@ -120,20 +134,8 @@ static int cpufreq_set_cur_state(unsigned int cpu, i=
nt state)
>                 if (unlikely(!freq_qos_request_active(&pr->thermal_req)))
>                         continue;
>
> -               policy =3D cpufreq_cpu_get(i);
> -               if (!policy)
> +               if (!cpufreq_update_thermal_limit(i, pr))
>                         return -EINVAL;
> -
> -               max_freq =3D (policy->cpuinfo.max_freq *
> -                           (100 - reduction_step(i) * cpufreq_thermal_re=
duction_pctg)) / 100;
> -
> -               cpufreq_cpu_put(policy);
> -
> -               ret =3D freq_qos_update_request(&pr->thermal_req, max_fre=
q);
> -               if (ret < 0) {
> -                       pr_warn("Failed to update thermal freq constraint=
: CPU%d (%d)\n",
> -                               pr->id, ret);
> -               }
>         }
>         return 0;
>  }
> --

