Return-Path: <linux-acpi+bounces-16413-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2473B45926
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 15:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A3E7BFF90
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 13:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8661A352FE8;
	Fri,  5 Sep 2025 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDLPRfxE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6962C17B3;
	Fri,  5 Sep 2025 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079131; cv=none; b=qjtkbVM4sCfe4LZ3yLpQcsR4op3Hwi6n+/FSOYyoL/XHO4RHJq4sqkTkyR5YnBVVA+un89VZ0niKBIgDUq92wv2GtGz0XMbaO5soZQLKBoEML52DLvEUTtsBEs6SUHJ1hJt2bc0f9J6Gnl3F1MIi7KAjNJea/ta1By/yoGKRfps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079131; c=relaxed/simple;
	bh=8jAcdpkwkSpwOdJxvwA2Vj7xEHXguZJ+MKwk0qNCAa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAKpO5mBkMT8dz6BJOKtBxtpdNh+mAGJx1tI0yYQiuyH3sLYf9CW6e0yVdCqRXhBcXqUh+dcfdvrHjX94JKawHZtPdwwBz2Nz071xhdcpWaE5xp8u2VZpYRcNdSPcniL3YeLhvkwikagMZTRqsBJsiFd5TqmA5dsJ49oEjB2Yog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDLPRfxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF52EC116B1;
	Fri,  5 Sep 2025 13:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757079131;
	bh=8jAcdpkwkSpwOdJxvwA2Vj7xEHXguZJ+MKwk0qNCAa4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YDLPRfxE+TA2Q55nxy+S45umyans+pDRvwbObVt0bW3hJ3GKjbxPrVlX07NomP+MM
	 gilJHDzfgmGFOcAFu0+loSilTzpkeDO9g9x8k2BAevsNOqWlkswrDpHfRJW58By2gZ
	 h5T2iOat+XnnhSD9UwBeQ3xYHCYi7jaP+GtkcpXBdqab/ccFdCeVstKHtgcieR/3QH
	 +KRTayLgDC1M/LhwjwPtXIccD6HoAsAvaea3u1dA7qTzCEzjxT3V+HO3EHQdCVNDFU
	 /St9BM0FbaHx4JdEUTHAM1R9DDj8M5cKZD+5HIpQks7AUiitM6xvVlMUYXsHzcS8lI
	 bWTNhY8srV4ig==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74526ca79beso1847717a34.0;
        Fri, 05 Sep 2025 06:32:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3+NXTW3ZWLTIciU/ynYdAcepa5iFgqr735GLhaWGKax/AN48Eglt3LLVEwa7o4xwRbqVYI5ngHT/Mb4ho@vger.kernel.org, AJvYcCVetlqpV4XywqBkxaXooa1lRKwsALYk/cmO/Y5h35FtE1fwXZpjSsU4tr9KtcqykIKKOs6/pLnXB+nn@vger.kernel.org, AJvYcCWVKwfzqTXQyIKLuM6pWkL+pXYky10oxMSBObEQP8zKkE78Gxbnaqpdsq9/x77xHyw8QxKR9p3E77A=@vger.kernel.org, AJvYcCXvNjedoEvIla8PbMlSm8nkUPlvvrsp7BtdxhNrLsRGrOmxkwRRCTVuOe73jKwCT9rOPYLIv8APoU1o0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzno1eoxmp07jd1M7X83eI5OgCimBs1YTDjBctGNPwNvoYmsE68
	pgbI91nuEUkzOfqynABzYrPVF780EKkPpuED5M9NFQOtMvisSXgewk6iOfRRL8lzQM7eS+RMF+k
	qPJMGnpP3uXQppdhY7dkMoPz2k0+X11c=
X-Google-Smtp-Source: AGHT+IFnE56n2ZWY3m6GFquWJS3R+4zyRWG4mn/x7Tvk/fQPvR7/F7IjMN/5eFQpLDwVxaDdPh5JX7KANJsrFqH4mJc=
X-Received: by 2002:a05:6830:378e:b0:741:a5f0:bc82 with SMTP id
 46e09a7af769-74569e53d0dmr13231613a34.17.1757079130135; Fri, 05 Sep 2025
 06:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905132413.1376220-1-zhangzihuan@kylinos.cn> <20250905132413.1376220-4-zhangzihuan@kylinos.cn>
In-Reply-To: <20250905132413.1376220-4-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 15:31:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jdJZ2upvE4KzDnc59KpMX+oqYbq=ZW=SXfwvjBctMj3Q@mail.gmail.com>
X-Gm-Features: Ac12FXwR6ToJkYo5xTTss3xr-Ox8ITso59X_uvklZva98cFgnVHnG6meS0I7mt8
Message-ID: <CAJZ5v0jdJZ2upvE4KzDnc59KpMX+oqYbq=ZW=SXfwvjBctMj3Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] cpufreq: intel_pstate: Use scope-based cleanup helper
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
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

No, sorry.  I've already said that this isn't going to work:

https://lore.kernel.org/linux-pm/CAJZ5v0gN1T5woSF0tO=3DTbAh+2-sWzxFjWyDbB7w=
G2TFCOU01iQ@mail.gmail.com/

so why are you resending it?

And making changes to it in the process without saying what they are?

Please stop adding confusion.

> ---
>  drivers/cpufreq/intel_pstate.c | 59 +++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index f366d35c5840..0b54e08f9447 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1502,9 +1502,8 @@ static void __intel_pstate_update_max_freq(struct c=
pufreq_policy *policy,
>
>  static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
>  {
> -       struct cpufreq_policy *policy __free(put_cpufreq_policy);
> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpuf=
req_cpu_get(cpudata->cpu);
>
> -       policy =3D cpufreq_cpu_get(cpudata->cpu);
>         if (!policy)
>                 return false;
>
> @@ -1695,41 +1694,49 @@ static ssize_t store_no_turbo(struct kobject *a, =
struct kobj_attribute *b,
>         return count;
>  }
>
> -static void update_qos_request(enum freq_qos_req_type type)
> +static bool intel_pstate_cpufreq_update_limits(int cpu, enum freq_qos_re=
q_type type)
>  {
>         struct freq_qos_request *req;
> -       struct cpufreq_policy *policy;
> -       int i;
> +       unsigned int freq, perf_pct;
> +       struct cpudata *data =3D all_cpu_data[cpu];
> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpuf=
req_cpu_get(cpu);
>
> -       for_each_possible_cpu(i) {
> -               struct cpudata *cpu =3D all_cpu_data[i];
> -               unsigned int freq, perf_pct;
> +       if (!policy)
> +               return false;
>
> -               policy =3D cpufreq_cpu_get(i);
> -               if (!policy)
> -                       continue;
> +       req =3D policy->driver_data;
>
> -               req =3D policy->driver_data;
> -               cpufreq_cpu_put(policy);
> +       if (!req)
> +               return false;
>
> -               if (!req)
> -                       continue;
> +       if (hwp_active)
> +               intel_pstate_get_hwp_cap(data);
>
> -               if (hwp_active)
> -                       intel_pstate_get_hwp_cap(cpu);
> +       if (type =3D=3D FREQ_QOS_MIN) {
> +               perf_pct =3D global.min_perf_pct;
> +       } else {
> +               req++;
> +               perf_pct =3D global.max_perf_pct;
> +       }
>
> -               if (type =3D=3D FREQ_QOS_MIN) {
> -                       perf_pct =3D global.min_perf_pct;
> -               } else {
> -                       req++;
> -                       perf_pct =3D global.max_perf_pct;
> -               }
> +       freq =3D DIV_ROUND_UP(data->pstate.turbo_freq * perf_pct, 100);
>
> -               freq =3D DIV_ROUND_UP(cpu->pstate.turbo_freq * perf_pct, =
100);
> +       if (freq_qos_update_request(req, freq) < 0)
> +               pr_warn("Failed to update freq constraint: CPU%d\n", cpu)=
;
>
> -               if (freq_qos_update_request(req, freq) < 0)
> -                       pr_warn("Failed to update freq constraint: CPU%d\=
n", i);
> +       return true;
> +}
> +
> +
> +static void update_qos_request(enum freq_qos_req_type type)
> +{
> +       int i;
> +
> +       for_each_possible_cpu(i) {
> +               if (!intel_pstate_cpufreq_update_limits(i, type))
> +                       continue;
>         }
> +
>  }
>
>  static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attribu=
te *b,
> --
> 2.25.1
>
>

