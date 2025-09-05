Return-Path: <linux-acpi+bounces-16431-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3895EB463C8
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 21:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E1D3A9CC3
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C441527F4CA;
	Fri,  5 Sep 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqXRFlbg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B31F13D539;
	Fri,  5 Sep 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101204; cv=none; b=HQLWaBz9odOIaBNwYCy9/M8SA7ArlmNDp3YrfXwG8t03XJp0IXukdgIz6vR5YNjjhxtJdtiHA5NhQoZ28Uz2bov/jo7S7KV2drpUSq8V1+sWP0b35Ynm29T1iUQYFW8ek4eUI+cpFSwgRq5FN+gRf1IfKjgaUdTaRZcymBmF+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101204; c=relaxed/simple;
	bh=EW5E1DsoS/eP0Xpaway7kFwsFpD+pL719m9UghXWG4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJ9MW9S1Bucs/Y8uU2NzLIo+eSBpnSOfPMFsL5BXAXI7TPNGTcSXpHZ0xdBihfFZgESeXZXT8k9rL8Z+82l7q7LRvuI5f1pJ1du45k1ZOnseJwKRkZK73chnjgfwv5lJIF7ep3ZBIu8KPNROuWwL43yCQN2H0s8S2tmUiPDj420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqXRFlbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E43FC113CF;
	Fri,  5 Sep 2025 19:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757101204;
	bh=EW5E1DsoS/eP0Xpaway7kFwsFpD+pL719m9UghXWG4E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZqXRFlbgP5QwPcBxU6eNLL/08iwuclbpMhHj5f112VJ0D0CRs+uAOZZt9/eSU+oYH
	 FOKxLZNfYfeCUuY691CYi9oaDczKB9oJxUx3sRU+YTC0hMmU7aj7i6icx+GswFUP2R
	 IFwTEwP7LFbGxUg/I7SAjo0DENXd43ZHbeobRhQywFakWAs9/enQGWBOfoAuIelFBb
	 wogoGak56kUdv1oV5wP9PLMDQRhAVNRB8Qk4NYGffSXcIWD99Y+pR+l0VNOqodu/Yf
	 429lN+Si30NngrGAeTbmA/uuc+3zujKhmh+809qGxXm2EsqsYlM68fd6X/hgvyGAM6
	 l4P6r3BqgQXRw==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-746da717f35so679040a34.1;
        Fri, 05 Sep 2025 12:40:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKz24fSshaE6gjI+SrChkXvqsPDHYXGm9btTUI6SFpyk1LPU/OkpetJmqj6wu164Ejr8NxDWRxfoZRKsPz@vger.kernel.org, AJvYcCVyEYvKlQhdFnPgUwDXJr13V68kDlM/vkMAiyzK5StcmXXR/uHHRkCvQvz+30lMvJaq6exXWOeCF4sB@vger.kernel.org, AJvYcCWvxis1k5vmf0pLQ4Kp2wdPIUNb9wFKT8FszOL7tARj6+iFMbOJmhAu0HdC9txleYJYOVEB7otFxhc=@vger.kernel.org, AJvYcCXmFTC+zDKmsHhH+n9ftfnp7SAeWTkjQ6c8NzRJ6Lb9jzmEmATWVBbPM3RBiYt03wVeakQQYJ50uFpOBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2b03tZ6prJESMGoacEpczhN1Q+homgw1oPMBLihhhxmqYttK
	82TTBkrw/3BJuOh4c9wixaomQ+v8mqNoNkTbJdwFNZ+uWOReVUR5IUhUmsz/+xVfsy0Fq09BEGY
	aXA81U/yT4eNuvQA8+XrWVt3So5bRGFI=
X-Google-Smtp-Source: AGHT+IEWhcvcPUmMTXw08ZtZH4mqK1uKC0R7GjcFC8PVlsyyD61c2ek06n5Ch8ecLJvX8w2zR6AjPrAE5CMEF+OJ57Q=
X-Received: by 2002:a05:6830:700a:b0:74b:f9de:34dd with SMTP id
 46e09a7af769-74bf9de3edfmr235939a34.15.1757101203180; Fri, 05 Sep 2025
 12:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905132413.1376220-1-zhangzihuan@kylinos.cn> <20250905132413.1376220-5-zhangzihuan@kylinos.cn>
In-Reply-To: <20250905132413.1376220-5-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 21:39:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jvskvxgUhxKJLN89A+s7Mruz1_tewHZfKgC7sUGLi9cw@mail.gmail.com>
X-Gm-Features: Ac12FXws29Av_URAHgjbe1keBVsNp0-87UjpP4EeoBVUVvSgtWfWbkUI32D7vRk
Message-ID: <CAJZ5v0jvskvxgUhxKJLN89A+s7Mruz1_tewHZfKgC7sUGLi9cw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] PM / devfreq: Use scope-based cleanup helper
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

On Fri, Sep 5, 2025 at 3:25=E2=80=AFPM Zihuan Zhang <zhangzihuan@kylinos.cn=
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
>  drivers/devfreq/governor_passive.c | 60 +++++++++++-------------------
>  1 file changed, 22 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governo=
r_passive.c
> index 953cf9a1e9f7..5afaea39377e 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -80,24 +80,23 @@ static int get_target_freq_with_cpufreq(struct devfre=
q *devfreq,
>         struct devfreq_passive_data *p_data =3D
>                                 (struct devfreq_passive_data *)devfreq->d=
ata;
>         struct devfreq_cpu_data *parent_cpu_data;
> -       struct cpufreq_policy *policy;
>         unsigned long cpu, cpu_cur, cpu_min, cpu_max, cpu_percent;
>         unsigned long dev_min, dev_max;
>         unsigned long freq =3D 0;
>         int ret =3D 0;
>
>         for_each_online_cpu(cpu) {

I'd rather move the code in this loop to a separate function in the
first place and then do a __free()-based simplification of it.  I'd
suggest doing each step in a separate patch to avoid mistakes.

> -               policy =3D cpufreq_cpu_get(cpu);
> +               struct cpufreq_policy *policy __free(put_cpufreq_policy) =
=3D
> +                       cpufreq_cpu_get(cpu);
> +
>                 if (!policy) {
>                         ret =3D -EINVAL;
>                         continue;
>                 }
>
>                 parent_cpu_data =3D get_parent_cpu_data(p_data, policy);
> -               if (!parent_cpu_data) {
> -                       cpufreq_cpu_put(policy);
> +               if (!parent_cpu_data)
>                         continue;
> -               }
>
>                 /* Get target freq via required opps */
>                 cpu_cur =3D parent_cpu_data->cur_freq * HZ_PER_KHZ;
> @@ -106,7 +105,6 @@ static int get_target_freq_with_cpufreq(struct devfre=
q *devfreq,
>                                         devfreq->opp_table, &cpu_cur);
>                 if (freq) {
>                         *target_freq =3D max(freq, *target_freq);
> -                       cpufreq_cpu_put(policy);
>                         continue;
>                 }
>
> @@ -121,7 +119,6 @@ static int get_target_freq_with_cpufreq(struct devfre=
q *devfreq,
>                 freq =3D dev_min + mult_frac(dev_max - dev_min, cpu_perce=
nt, 100);
>
>                 *target_freq =3D max(freq, *target_freq);
> -               cpufreq_cpu_put(policy);
>         }
>
>         return ret;
> @@ -255,8 +252,6 @@ static int cpufreq_passive_register_notifier(struct d=
evfreq *devfreq)
>                         =3D (struct devfreq_passive_data *)devfreq->data;
>         struct device *dev =3D devfreq->dev.parent;
>         struct opp_table *opp_table =3D NULL;
> -       struct devfreq_cpu_data *parent_cpu_data;
> -       struct cpufreq_policy *policy;
>         struct device *cpu_dev;
>         unsigned int cpu;
>         int ret;
> @@ -273,37 +268,34 @@ static int cpufreq_passive_register_notifier(struct=
 devfreq *devfreq)
>         }
>
>         for_each_possible_cpu(cpu) {

And analogously here.  I'd use separate two patches for updating this code.

> -               policy =3D cpufreq_cpu_get(cpu);
> -               if (!policy) {
> -                       ret =3D -EPROBE_DEFER;
> -                       goto err;
> -               }
> +               struct cpufreq_policy *policy __free(put_cpufreq_policy) =
=3D
> +                       cpufreq_cpu_get(cpu);
>
> -               parent_cpu_data =3D get_parent_cpu_data(p_data, policy);
> -               if (parent_cpu_data) {
> -                       cpufreq_cpu_put(policy);
> +               if (!policy)
> +                       return -EPROBE_DEFER;
> +
> +               struct devfreq_cpu_data *initial_parent_cpu_data =3D
> +                       get_parent_cpu_data(p_data, policy);
> +
> +               if (initial_parent_cpu_data)
>                         continue;
> -               }
>
> -               parent_cpu_data =3D kzalloc(sizeof(*parent_cpu_data),
> -                                               GFP_KERNEL);
> -               if (!parent_cpu_data) {
> -                       ret =3D -ENOMEM;
> -                       goto err_put_policy;
> -               }
> +               struct devfreq_cpu_data *parent_cpu_data __free(kfree) =
=3D
> +                       kzalloc(sizeof(*parent_cpu_data), GFP_KERNEL);
> +
> +               if (!parent_cpu_data)
> +                       return -ENOMEM;
>
>                 cpu_dev =3D get_cpu_device(cpu);
>                 if (!cpu_dev) {
>                         dev_err(dev, "failed to get cpu device\n");
> -                       ret =3D -ENODEV;
> -                       goto err_free_cpu_data;
> +                       return -ENODEV;
>                 }
>
>                 opp_table =3D dev_pm_opp_get_opp_table(cpu_dev);
>                 if (IS_ERR(opp_table)) {
>                         dev_err(dev, "failed to get opp_table of cpu%d\n"=
, cpu);
> -                       ret =3D PTR_ERR(opp_table);
> -                       goto err_free_cpu_data;
> +                       return PTR_ERR(opp_table);
>                 }
>
>                 parent_cpu_data->dev =3D cpu_dev;
> @@ -313,8 +305,8 @@ static int cpufreq_passive_register_notifier(struct d=
evfreq *devfreq)
>                 parent_cpu_data->min_freq =3D policy->cpuinfo.min_freq;
>                 parent_cpu_data->max_freq =3D policy->cpuinfo.max_freq;
>
> -               list_add_tail(&parent_cpu_data->node, &p_data->cpu_data_l=
ist);
> -               cpufreq_cpu_put(policy);
> +               list_add_tail(&(no_free_ptr(parent_cpu_data)->node,
> +                       &p_data->cpu_data_list);
>         }
>
>         mutex_lock(&devfreq->lock);
> @@ -324,14 +316,6 @@ static int cpufreq_passive_register_notifier(struct =
devfreq *devfreq)
>                 dev_err(dev, "failed to update the frequency\n");
>
>         return ret;
> -
> -err_free_cpu_data:
> -       kfree(parent_cpu_data);
> -err_put_policy:
> -       cpufreq_cpu_put(policy);
> -err:
> -
> -       return ret;
>  }
>
>  static int devfreq_passive_notifier_call(struct notifier_block *nb,
> --

