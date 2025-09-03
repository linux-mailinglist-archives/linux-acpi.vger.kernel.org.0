Return-Path: <linux-acpi+bounces-16311-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 164CDB41CB2
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 13:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9236B1BA6788
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 11:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144AD2F5331;
	Wed,  3 Sep 2025 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqEv+pAy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90112F3C0A;
	Wed,  3 Sep 2025 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756897662; cv=none; b=qt6n6ydyS628wpeLf01+ZN4iBhgajl7yt8838ebPoKJml4bknlh8sTvYo1bV1gFq1lBPNt+XMvGLt29GAV0hjMrrNwEWirWpSoYgBBirfNJ3ojEkDllyLL2I3whDpOECFXFDbwKO17IGZY/VLVvv+R3kbSxIugw+mxmbStZEycU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756897662; c=relaxed/simple;
	bh=I5jJC5YsqDheZourzIns4HynVHdhk9fmj1JJIPP/qj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGN/cYquAmqyTAD9c8ZfHnzCHSv1bTzdJGwdjzUGbRtjCKHBLPsVsTionnEn3q+nDz8AttTMqiw7Um4JtNz8T2ho8CkQKFY6g0lK5/d4j5BApGEMw4MRUtHXMczzsqKNMsqX3zqSLTfHw61xouLGWEr8bMusKl1TVX53sGP7ktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqEv+pAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2DBC116C6;
	Wed,  3 Sep 2025 11:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756897661;
	bh=I5jJC5YsqDheZourzIns4HynVHdhk9fmj1JJIPP/qj8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fqEv+pAyAzyDrwpa5ycGv/vldrUVHpTuiDwGvEU2O6hGAiipiQXkldusw4kvuf6Ta
	 cyV691K7HV2CSSp8RoFgEXQf84IwuC16kmYKwmqprM4hACuabw/Z49bNoigh1mbEVi
	 lfVSk0I2yERql792+nQOshGycv64BeF9PB3eQ5nWjt+fGlrVe/cR9xNBoxCPamJrks
	 yVsq4p2oAGuZ5xkOC8mK0WErUxsBMrB2HOYx2elO7r0rSGI9RKr76w6rqsVHTkCBqv
	 Yq7iI8uXw1FkSRxTENbSKEf2moleyaF/1d2WgigF4GfkMeRbER5SxoiWsyCxL1V2R/
	 ofS+YYpOUUEJQ==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7459de59821so150469a34.1;
        Wed, 03 Sep 2025 04:07:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj0Y0dprgvS1emlIgqMZ0jXlQ3NB50ScXDFT+itF84+5qh8XTsS285gghVwJNgYAOsotjfyqvwQg4=@vger.kernel.org, AJvYcCUsaCZz+5zJEX4snl0XQ/Yz4A9gakD1q22bJ5VhlA57wBixgbDaaApVWIqxhQ/c9FpaSsSAGu6woqCq@vger.kernel.org, AJvYcCWqMz0BlqVcSkdKRbWhKrTwLsjvaqoJyKTMGdNMDsAp3vlCUVARfECjIG7Zgb7iUu0Al+9LiJBKwlnSlg==@vger.kernel.org, AJvYcCX83Y8guLBHNoz+nd6cRrTd6UbYj8xh43YIGn28VV3XzXmVqAzu6XBJGh+852zXCbkrkSiYJWmDalKV2S/y@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUywI4fMtmPe6+nodFf7V5y8l7pu5UFHJHRj3sLewdR19hlgm
	A/q+sI7GYcCVKacQoUood/Gd9De6kvtFM8A6qZamw9dcLswTlNbnciaGpfVyg9fi80WGcyAHrDH
	vzZF1TKWMxjlq/9xXqgYdnGne6RccIog=
X-Google-Smtp-Source: AGHT+IFm2i7E3heNFR05VvLVwsYMlRgIplk+0JGJpDoA3hxcK7mnkmts5Dorpw2CJryu3vWJY1lQqzZJZSMnb+GSebY=
X-Received: by 2002:a05:6830:2642:b0:745:508c:455c with SMTP id
 46e09a7af769-74569dc34b9mr7242918a34.8.1756897660735; Wed, 03 Sep 2025
 04:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901085748.36795-1-zhangzihuan@kylinos.cn> <20250901085748.36795-3-zhangzihuan@kylinos.cn>
In-Reply-To: <20250901085748.36795-3-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Sep 2025 13:07:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jxHQ3fBk_fSwg7QYsePvUyh=FDteyO+8F8oGfUwX2E9A@mail.gmail.com>
X-Gm-Features: Ac12FXxXhqpwDXjodHxvBBGUiHE126LWfl3UmWuK-7WK82DNR_r2zpKQkeauJig
Message-ID: <CAJZ5v0jxHQ3fBk_fSwg7QYsePvUyh=FDteyO+8F8oGfUwX2E9A@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] ACPI: processor: thermal: Use scope-based
 cleanup helper
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
>  drivers/acpi/processor_thermal.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_th=
ermal.c
> index 1219adb11ab9..3c8b57df9619 100644
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
> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpuf=
req_cpu_get(cpu);
>
>         if (!acpi_processor_cpufreq_init)
>                 return 0;
>
> -       policy =3D cpufreq_cpu_get(cpu);
> -       if (policy) {
> -               cpufreq_cpu_put(policy);
> -               return 1;
> -       }
> -       return 0;
> +       return !!policy;
>  }
>
>  static int cpufreq_get_max_state(unsigned int cpu)
> @@ -95,7 +90,6 @@ static int cpufreq_get_cur_state(unsigned int cpu)
>
>  static int cpufreq_set_cur_state(unsigned int cpu, int state)
>  {
> -       struct cpufreq_policy *policy;
>         struct acpi_processor *pr;
>         unsigned long max_freq;
>         int i, ret;
> @@ -111,6 +105,9 @@ static int cpufreq_set_cur_state(unsigned int cpu, in=
t state)
>          * frequency.
>          */
>         for_each_online_cpu(i) {

I would still prefer the code below to be moved to a separate function
that would be called in each step of the for_each_online_cpu() loop.

> +               struct cpufreq_policy *policy __free(put_cpufreq_policy) =
=3D
> +                       cpufreq_cpu_get(i);
> +
>                 if (topology_physical_package_id(i) !=3D
>                     topology_physical_package_id(cpu))
>                         continue;
> @@ -120,15 +117,12 @@ static int cpufreq_set_cur_state(unsigned int cpu, =
int state)
>                 if (unlikely(!freq_qos_request_active(&pr->thermal_req)))
>                         continue;
>
> -               policy =3D cpufreq_cpu_get(i);
>                 if (!policy)
>                         return -EINVAL;
>
>                 max_freq =3D (policy->cpuinfo.max_freq *
>                             (100 - reduction_step(i) * cpufreq_thermal_re=
duction_pctg)) / 100;
>
> -               cpufreq_cpu_put(policy);
> -
>                 ret =3D freq_qos_update_request(&pr->thermal_req, max_fre=
q);
>                 if (ret < 0) {
>                         pr_warn("Failed to update thermal freq constraint=
: CPU%d (%d)\n",
> --
> 2.25.1
>
>

