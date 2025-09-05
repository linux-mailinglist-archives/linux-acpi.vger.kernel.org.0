Return-Path: <linux-acpi+bounces-16432-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AD5B463E4
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 21:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDD03B4352
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 19:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0372135D7;
	Fri,  5 Sep 2025 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9qmJFw1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2991E55A;
	Fri,  5 Sep 2025 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101616; cv=none; b=bhcsTvN08m6K1gYjbTWdut/RFcnhYxRtIrdUFke4+Szyb2auuprzgpwm0d/3hnIiS+2NamV3bleU50/1+aNYBtuZrNHcDK3UQiGaF0cCBLMDd2hHFuGtq7B70yvZt3zRm2rQjVHuUchyIRRHf3XNUEcTZ1Rw1KeNzRHv9LH3NOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101616; c=relaxed/simple;
	bh=H8MVjkz4o17difHvr2cD8D+8FZU1fUcKjhpmn4rwijw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdL+FXdXaV4Vxv2rgURKF2t1691RLE4C4e51qrtP2E70rrprfSrDEJLYKVsOBcfc63Y49tsj4kNvFjtTY5BaZS5VyV/XEru6mx2QEKL+GE9XV1/NXHF/Uv/8+28pO25p3ahOKIz81N58Byk52Rhex83GnDQAye1GiUSF1JfCvNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9qmJFw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548FBC4CEFD;
	Fri,  5 Sep 2025 19:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757101616;
	bh=H8MVjkz4o17difHvr2cD8D+8FZU1fUcKjhpmn4rwijw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G9qmJFw1HIMkEhpfwD6F7o3JbvpRO1V95WZ/oUz3+r2CZmbDws6CbBgur6Wekx+qi
	 ldlGPU37Uj/fIsJfq8C0T5mwgtAEI7Vqo36+np24YoWw6Q+UqAD0c8vsYKdD1WmilJ
	 I5H7EyGxJaGj6hrAng2kuUlTjEtq88UjwDYdjemQkTgF2roSvOtH1g1Vers9Vmn/8H
	 hFTpK0+yBM6BJf93iSTpneRiwZTgqB03L5VCqcDIKq1c7x0wnA4m2OtzWFieeGFXd2
	 UYnynJnuCo/OhHIYLgJZetquSD940EGwlIBAqodji7zBapVVl2I0pI39J7QYdGVk0c
	 YFNdRZkp+5nBw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-61bf9ef4cc0so1504532eaf.0;
        Fri, 05 Sep 2025 12:46:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlApuecRYOSAKujtolI5t41KBULgOai196UHtAyH8Lyuw3Wpr4ePMpVvWugsN/BTd2cRNWHosQBCGEfqJw@vger.kernel.org, AJvYcCVz65MaQFbPFT6bDVbFcc9JE1ZZklCtf/+p9fxInyMsAIMsX2X6YH/aOpD2XT0XyEa23HfYS6rSjo8=@vger.kernel.org, AJvYcCWhtLKgt9nRXwikPAE3Erg/ML44bLMJzbadQUDCNGbj2YD6OuHEscsU7z6s5RbAQsT/E5JKNoned0Vv@vger.kernel.org, AJvYcCXhyZwRL+VFnghEngsCXpSnXYdycazofSlZ6vO7Ah5A7iLMC4HHjljrKg9Mga56e21iumMcVbm4n6KKhg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5HyrX1RPVPTjUVTgnoRb8P1sTB1djd6Usn2Y6vGdpM8A+30Yp
	KmYAqp5E6LygVhTjWPE7amIg90+CKETa0BTxIRRJD5QdrGmDbmoLKaLwVl6wfD/6igs9X8jvMs4
	xx8+XmP/4ubc3Wks+jTTMRjY9t9nLxSk=
X-Google-Smtp-Source: AGHT+IEKuvslbgpS+jFT9kCZO9ZHrI6mBjYptsMiCaePE1pyVsHfodMLw3nmAqVy7Bw/fuUlRNZZYUO91WEjIayPMsY=
X-Received: by 2002:a05:6820:548:b0:621:71c3:eab8 with SMTP id
 006d021491bc7-62171c3ecffmr1197889eaf.3.1757101615563; Fri, 05 Sep 2025
 12:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905132413.1376220-1-zhangzihuan@kylinos.cn> <20250905132413.1376220-7-zhangzihuan@kylinos.cn>
In-Reply-To: <20250905132413.1376220-7-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 21:46:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0izu1_xVe_pGeJiXZqEXLxg_o30NkEjMiwzDgeU4mOGmA@mail.gmail.com>
X-Gm-Features: Ac12FXylOWQRbtZy4tXGis9fcvrx9xAWhEYFwKXiKvA-TbpGOjwSaXBXEfvwt6M
Message-ID: <CAJZ5v0izu1_xVe_pGeJiXZqEXLxg_o30NkEjMiwzDgeU4mOGmA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] PM: EM: Use scope-based cleanup helper
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
>  kernel/power/energy_model.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index ea7995a25780..5ec63b3e7d85 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -451,7 +451,6 @@ static void
>  em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state =
*table)
>  {
>         struct em_perf_domain *pd =3D dev->em_pd;
> -       struct cpufreq_policy *policy;
>         int found =3D 0;
>         int i, cpu;
>
> @@ -465,7 +464,7 @@ em_cpufreq_update_efficiencies(struct device *dev, st=
ruct em_perf_state *table)
>                 return;
>         }
>
> -       policy =3D cpufreq_cpu_get(cpu);
> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpuf=
req_cpu_get(cpu);
>         if (!policy) {
>                 dev_warn(dev, "EM: Access to CPUFreq policy failed\n");
>                 return;
> @@ -479,8 +478,6 @@ em_cpufreq_update_efficiencies(struct device *dev, st=
ruct em_perf_state *table)
>                         found++;
>         }
>
> -       cpufreq_cpu_put(policy);
> -
>         if (!found)
>                 return;
>

The above changes are fine now and can be a separate patch.

> @@ -787,21 +784,19 @@ static void em_check_capacity_update(void)
>
>         /* Check if CPUs capacity has changed than update EM */
>         for_each_possible_cpu(cpu) {

But I'd prefer the code in this loop to be moved into a separate
function, in a separate patch, before the __free()-based
simplification of it.

> -               struct cpufreq_policy *policy;
>                 struct em_perf_domain *pd;
>                 struct device *dev;
>
>                 if (cpumask_test_cpu(cpu, cpu_done_mask))
>                         continue;
>
> -               policy =3D cpufreq_cpu_get(cpu);
> +               struct cpufreq_policy *policy __free(put_cpufreq_policy) =
=3D cpufreq_cpu_get(cpu);
>                 if (!policy) {
>                         pr_debug("Accessing cpu%d policy failed\n", cpu);
>                         schedule_delayed_work(&em_update_work,
>                                               msecs_to_jiffies(1000));
>                         break;
>                 }
> -               cpufreq_cpu_put(policy);
>
>                 dev =3D get_cpu_device(cpu);
>                 pd =3D em_pd_get(dev);
> --

