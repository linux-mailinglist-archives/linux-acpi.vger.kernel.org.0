Return-Path: <linux-acpi+bounces-16255-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5547BB3EAC2
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 17:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F6D4825FA
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1E635337C;
	Mon,  1 Sep 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHSscyxU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC62FB625;
	Mon,  1 Sep 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739838; cv=none; b=A/qhr+VQVBEhhcc9FTXrma/nuKUt/SsC8Oa/2m/DKGxkcn+TQBIIbmfTInQ33JWQ0wzarNn9H777EXcRf0YGV0Q6dPwu18chEv6e6IVQwuliQGwP77vQgmDvN5OXHHhKkbL9CIkdg5UgRMTHoS4CRglEYE6oos5mUgXpg4OMx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739838; c=relaxed/simple;
	bh=5weQGGRb22PrjCyP/g4zxlVoFtpKwJSJ+1zX1sG+Ceo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMdK436whRxs/eRlRQXd4ZbALenInxJWtcorA+TeM/SgsNUuMaHkQkJFcID8EBLNSR4Y9J2QAL/Li4/kwa0vxfRvg67c6FQk+BVpr/jVK9fueaCCP1OnojL/DlWSrBY/yxdPsZi0tYbMYrHQJQHvifnjVAUS9/vxtDMlqfAwAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHSscyxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DE0C4CEF4;
	Mon,  1 Sep 2025 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756739837;
	bh=5weQGGRb22PrjCyP/g4zxlVoFtpKwJSJ+1zX1sG+Ceo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fHSscyxUBqa2PrUEAJYH4gjbe394x6UINLLLJtU3No/ch07okasdYpPcLQVZ4fQdz
	 QQVpadnQL9+K/Bpr7PRPb1lji/ueyUJo0Nz3wjlJnIDs6gj2K0bIoBRm5dUqa4DnzM
	 DY2h8b80jorHneNn39SEcsZRb6GHqyX/EXJ0F/BwtNCV5dmP3SHyX9yn+TVbM49IPg
	 gJX0lOPTuzPnXXKhNhXoblUzf/66Yb6hsnXIc36xlN9G/S8hlUTrrtuZhlzHc+/YLr
	 6Fj48VcKspQFdxqqBYoze3u/d/wGFeYtGEBYBk9/cEEhhvcPXXMosbjDG8tSDIKFer
	 oYp4KruBpNFcA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-315a7547f26so1830791fac.0;
        Mon, 01 Sep 2025 08:17:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXIHZ+dieROt+4aTrx1PcQHg7nlIYAk95nHDLmbgbllnv2cmG6mrjfHDF7dMKOFYn2e9VPb5z8RJLo@vger.kernel.org, AJvYcCVQNIvOWLC6VJy/BXPyCiYqIOIff9qvM1NtaWw/Fp/9VZ9UctTh8eZYMr7EXvWZj7EgyB+HphMNcxUsQkop@vger.kernel.org, AJvYcCVyd/p9aEv8bXqzH8DDjtnOHnnDgkBLAQrnaSMATHE8m93ZEpVDiiEtF6pYxJpV40tsFWwCe+yjX1kFbA==@vger.kernel.org, AJvYcCWbLVBPEqVfF5Fvncp2sAWSNlfd2X/1xg3EqRLpUzHFRdkCtmsFaaV5bBRZH1rCTVLJkAVfp5E37H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCFGC8VefGHUYvWSPcvdPQw8F6nwwAI5NC+dgnHQDtKRQll5Ta
	wejVDFDIrJHv2w8YOR4qbZwUa5tqskm50f5AKdAwMEZrRK2a8Uhi1XOWSctju/uJKFAt/0aSyeM
	2ioVdTEQCuKCAbQvIwuGmM6xAYMTCaGA=
X-Google-Smtp-Source: AGHT+IEqozTSDrtoR1W72zJmy9Z1LH1mlLFPdwzpw5V1Yv8IGBwtb8EBAZercDEFewoqAI3YKrAtdKI2Ii3KK+l5mg4=
X-Received: by 2002:a05:6870:9b09:b0:30b:b123:b6c9 with SMTP id
 586e51a60fabf-319630e13fbmr3523480fac.12.1756739836982; Mon, 01 Sep 2025
 08:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901085748.36795-1-zhangzihuan@kylinos.cn> <20250901085748.36795-4-zhangzihuan@kylinos.cn>
In-Reply-To: <20250901085748.36795-4-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Sep 2025 17:17:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hu48NrMr6Vkjn_UyHywJMx7F5N6yWf2LiXxykZF79EKA@mail.gmail.com>
X-Gm-Features: Ac12FXy28aQLAZnDRwhZh3hbZ0aFKhCyHW17tDgFwo0nHMN5cP-adgYEeM5GYyY
Message-ID: <CAJZ5v0hu48NrMr6Vkjn_UyHywJMx7F5N6yWf2LiXxykZF79EKA@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] cpufreq: intel_pstate: Use scope-based cleanup helper
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
>  drivers/cpufreq/intel_pstate.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index f366d35c5840..4abc1ef2d2b0 100644
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

The structure of the code is intentional here and there's no reason to
change it.

