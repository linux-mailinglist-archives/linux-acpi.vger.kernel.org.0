Return-Path: <linux-acpi+bounces-16327-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5FDB4216D
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 15:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE4717B1B5
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 13:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14DC3019D9;
	Wed,  3 Sep 2025 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPpEcytq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07072FFDD4;
	Wed,  3 Sep 2025 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905823; cv=none; b=cHcT5ZZyWghWLptabLn/RmmCDgMZ08XUwd9vvVEf/wpIysUDflRkePAeScBdNsDgYu1r2UwVnvKRTwxuQaN+ytXnjlgsw4oV8n3cUwNOJpP+SX7GzS/Bm3mcOOJI+ytuJl+uKmohAyXAWSex2J0C0mcQLXY7GYLLGEFakT+cGFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905823; c=relaxed/simple;
	bh=MNOCIHc890ZPbX81TBDONhDZg01sJ8IBrTS7pqPoFeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0xEeXBx+lTdhvy85GCcnlHmlmn+SnzFCjo1RQnwFdg3xidFLTwrNpgvkFrUEp4K5Fb7qbr426drBynbODc9Qx/cz5dEulqZ+5E7Ru7dazXvthYixwsaK/2v79Nr2mSrYMyWJ9PRdVbt0YquQiQC8iosdx4XOzULMkGYcNqTrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPpEcytq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FCDC113D0;
	Wed,  3 Sep 2025 13:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756905823;
	bh=MNOCIHc890ZPbX81TBDONhDZg01sJ8IBrTS7pqPoFeY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FPpEcytq9aWkc1yFeTV1Dy+aeuNeBTemmC5rC27NFDjKUzH1CdxdIHWINCnqSpQyg
	 6MPLBsnw4Z3tl5OS0ltj5etYNac8uIjuz057aJvwNe7lsvbnOqQCUi7M0eY+x7Vomw
	 frmLXLUfAZ6jPOjoGriyx9qMonLn3SEcX8AaAM5ZthdTfJD2zjQ2JB4v7ZtP1YTj0j
	 fCyX+AMirTsv/3c/wKdQzNdS98pJ6I4a+2bvdurMP4V39HcMssOqRBF0XMA94wFTpD
	 KowDCNR2fY9SpRavGHLrK4UyT5J/cdzwLBNrLagEGm3KeNl0fk8EyVO2a1R5JfvG/D
	 2ScWj8Uimqryg==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-74381e207a0so4667534a34.0;
        Wed, 03 Sep 2025 06:23:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgKQCKKh35RC6A2xe/c/IanAwGWNxQliXQmGWgvlb2+BTE9tsQ7mIduDMZ32ZlbRd5HqWku/sPPIFY@vger.kernel.org, AJvYcCVW3ubXcao7F+PVelt88jtP+OKHQ3kuaGwG+zMxDrvIB6UMjhgbjDxKLGs7TZzB1SeLWFlEXRWyE3UShQ==@vger.kernel.org, AJvYcCXgCU88MjdALd9DB+HQ32ARlHfSFb4IIkeWpTejddvBawfslt0oHJsvkv4S1IBWCtvbRn/cg5ZcW58=@vger.kernel.org, AJvYcCXi7ppFDia+tDf9J636Dju3SLCd/50qT4v7OGC8Hj4qLf+js/sr4CfSchNC0tKQGiNhtNvovIMf5XtdMEvI@vger.kernel.org
X-Gm-Message-State: AOJu0YyAt26jvQIMXFpbheHfL68LR+wetvn+cnQulqgljUalkUmhrajs
	aRPxcrNeu8plMtJ6rTcx8xQOF6LSYpgFE+InSiXaYz+3zC2mve0PPuKmPdcj8hVEpPugNA3dlKp
	sJd2JNUzC0jTdaQhAaAOmnaWwCHZWg+M=
X-Google-Smtp-Source: AGHT+IF/Rvddiz3lwXC8DDW9/+npOMEcse4CHEj2QqCzERRaclrypAQPOhyZw11rYQSZDwxHFmim9Y4Gnx4KJlOQneM=
X-Received: by 2002:a05:6830:411c:b0:73b:2617:87f1 with SMTP id
 46e09a7af769-74569edcb41mr7583799a34.28.1756905822245; Wed, 03 Sep 2025
 06:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903131733.57637-1-zhangzihuan@kylinos.cn> <20250903131733.57637-3-zhangzihuan@kylinos.cn>
In-Reply-To: <20250903131733.57637-3-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Sep 2025 15:23:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j5O4Q72P-OLiR4RK4g8E5joi_gu_O4HZymh9hJvy551g@mail.gmail.com>
X-Gm-Features: Ac12FXyUy2bB6YBuDXd6gAvqnfWCJZTJ2jsW3Zhm6c3o2d27uMS2JyeGNtCLZcI
Message-ID: <CAJZ5v0j5O4Q72P-OLiR4RK4g8E5joi_gu_O4HZymh9hJvy551g@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] ACPI: processor: thermal: Use scope-based
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
>  drivers/acpi/processor_thermal.c | 37 ++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_th=
ermal.c
> index 1219adb11ab9..5043f17d27b7 100644
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
> @@ -93,9 +88,23 @@ static int cpufreq_get_cur_state(unsigned int cpu)
>         return reduction_step(cpu);
>  }
>
> +static long long cpufreq_get_max_freq(unsigned int cpu)
> +{
> +       long long max_freq;
> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D
> +               cpufreq_cpu_get(cpu);
> +
> +       if (!policy)
> +               return -EINVAL;
> +
> +       max_freq =3D (policy->cpuinfo.max_freq *
> +               (100 - reduction_step(cpu) * cpufreq_thermal_reduction_pc=
tg)) / 100;
> +
> +       return max_freq;
> +}
> +
>  static int cpufreq_set_cur_state(unsigned int cpu, int state)
>  {
> -       struct cpufreq_policy *policy;
>         struct acpi_processor *pr;
>         unsigned long max_freq;
>         int i, ret;
> @@ -120,14 +129,10 @@ static int cpufreq_set_cur_state(unsigned int cpu, =
int state)
>                 if (unlikely(!freq_qos_request_active(&pr->thermal_req)))
>                         continue;
>
> -               policy =3D cpufreq_cpu_get(i);
> -               if (!policy)
> -                       return -EINVAL;
> -
> -               max_freq =3D (policy->cpuinfo.max_freq *
> -                           (100 - reduction_step(i) * cpufreq_thermal_re=
duction_pctg)) / 100;
> +               max_freq =3D cpufreq_get_max_freq(cpu);
>
> -               cpufreq_cpu_put(policy);
> +               if (max_freq =3D=3D -EINVAL)
> +                       return -EINVAL;

Please also move the code below to the new function so it does not
need to return a value.

>
>                 ret =3D freq_qos_update_request(&pr->thermal_req, max_fre=
q);
>                 if (ret < 0) {
> --

