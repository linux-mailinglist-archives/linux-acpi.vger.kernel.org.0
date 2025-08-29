Return-Path: <linux-acpi+bounces-16172-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FCEB3B360
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 08:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B217B3A81C5
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 06:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BEA23D2B2;
	Fri, 29 Aug 2025 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DY+dr7/5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1574723B60A
	for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448996; cv=none; b=Sybkx2cMtwTaZES6D7YX5gRhqar8zfUbLM+OCOpp0n6O6G5N9/0s6G3wReUkX8A6ltlVKcZq3bMH7Vkf/tNTIYEFJC/bChqjtTBD/qRYaspnCkhwfD60VMVCtoHIAlLDYRSFpgE2ry04XZ0imCZf1bgu+yUqvK0v/TUJXPpHMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448996; c=relaxed/simple;
	bh=tGwSjGcSe128TtD7AHOwtP4PhJjbYMmvmFE0Ow3n7qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gwp3UmFxIhaKtUZRkrzmkhKfaahX7R7mbtpAQNNoMiILFSuNdGm86oUlDLnPmsiPaioqlLxO0QY8cDu+9hqE7FFdbFHJKc6HrK1CHkX1dfopI9SfpzGmNhbPwy6qknCEUdUSIG/54WpyKj+Yy5u1xLMXbNRkp76bDvNjTTkLc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DY+dr7/5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-246aef91e57so24136255ad.1
        for <linux-acpi@vger.kernel.org>; Thu, 28 Aug 2025 23:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756448994; x=1757053794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CokGLX1/yeX4DJMWAz1LmKt9I3G7o4FsQeoqSBuvVPY=;
        b=DY+dr7/5AYifsOB2jkD7YJAsc3EkrlaD87ZXXamuk9eRkkMJ9bpnQ9NtXMZ/m51IKQ
         W/hX2Lw6m0Rt0MhX1aPSSTW9JLm86s5TQ2RzZMEmZ6dh+fP2B/0WD9sedlLY6U8vdemg
         vgJUR7AoHH7XBq150ld8OwdWMrwMMWJaGceCKAQYyBPtm8a0Smyv6A0n34uMtGDaORO2
         4mlx/LccHp7VeojfM7fpq5uP73YyvyuPTazRWuYKAV0afPy8ZOr5NJXQbO3+97peg41E
         17fE3BWXly2lo/ybsuFDeSDci0+y8pU02yXE3h2KSXlPDpZfYhFvtBGsh6qu/Oee6ZBB
         Xd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756448994; x=1757053794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CokGLX1/yeX4DJMWAz1LmKt9I3G7o4FsQeoqSBuvVPY=;
        b=P+ftn59/zHGjj3Tr7kvOmyfln4EezLm0ihCrkT++ouNukHPCy9H+HncM3LYBsHwMjV
         ItUZUBB45r/lUte82+xWVApAq6mnGIThCspfuHxmcb5imIZp5yYiOaCAGXXNic2dZuCp
         k4yX+moROc/OSGMvOmVndAbIOKc4T2IOxJy9dYcwmthE6yRZHgAgkAHzgrjyoPVkAkWq
         UtgiocAgMrg6K8xJl0lp0njzPI5+66lwftAYuUzWhMmhecY8Yme3y43w+jNBbnVK3Dui
         pdQyhwaYMn8te3Nv4GPjB9/c/sZEyTQbeVInuO3SdJV2ZtgYxvU3GRLWrDKcjYfB6Rry
         zk5A==
X-Forwarded-Encrypted: i=1; AJvYcCXxjVyq/p7iVPckDalyLxxJWTa+ZoWzCnpILlbY7aE6ZPUWuuKuBmgxuk1zHUdU4E8MwTTfa0Czdvyv@vger.kernel.org
X-Gm-Message-State: AOJu0YyyIQTHZ8pASUcCfHkgSsZqHjm87YdgZap2X8wiKl+wM/KIiLu/
	5O2VZVPBH+Wvs+ceyHrFg4/mGPNAyPPbyZgZEM6KKQfhRcK4YT3/0xTaeuvH8Lb84eE=
X-Gm-Gg: ASbGncs/XxWRpNp2tTzueUsHBuv8mmsmykDPUdNGZfmZHbkWfZxhe8rmTw1DtEXXHGa
	nAVj9IrMMfxLEK7/1HVpHcYlgHKVQjr7FUy0BW7dHZTTJEIspYgmeBWYwUWRLlT8vhOS0NhZ/5e
	uUudHGXTRl7MGbzpDXCWiiZOLOPLJySFTopbofyimbTCPrAFhRZJda+dX/iMfxcXZTp73nx24/3
	3iOwvjCRF5pLcwduKJdfdsA8dtMI4YBMiWJyF61z65dtDITi17xLxnMR0R+9f1bxwZVR9odGQnt
	kkcjM5v9nx43IS8Sh7nYrLYgW7YhNBU8zKshguDSLvf4nDNK5DVoACZQTyewS/8G4pz4mbgjMsc
	eoyrWEaGfzRTWE/+kXTo7+e9G
X-Google-Smtp-Source: AGHT+IFbX3s0aoe3pqEivfWfaakWxvchfFFbfgXfyIlcOqslqMMZIBk7FeaK/V2UaSwtVV106XuK4Q==
X-Received: by 2002:a17:902:ec89:b0:245:fa00:6e25 with SMTP id d9443c01a7336-2462ef1ea0bmr386065885ad.28.1756448994426;
        Thu, 28 Aug 2025 23:29:54 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903705be3sm14571325ad.18.2025.08.28.23.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 23:29:53 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:59:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Markus Mayer <mmayer@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	zhenglifeng <zhenglifeng1@huawei.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Zhang Rui <rui.zhang@intel.com>,
	Len Brown <lenb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Beata Michalska <beata.michalska@arm.com>,
	Fabio Estevam <festevam@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Sumit Gupta <sumitg@nvidia.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>, linux-pm@vger.kernel.org,
	x86@kernel.org, kvm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev, linux-omap@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/18] cpufreq: tegra186: Use
 __free(put_cpufreq_policy) for policy reference
Message-ID: <20250829062951.ximauv2so442q4gv@vireshk-i7>
References: <20250827023202.10310-1-zhangzihuan@kylinos.cn>
 <20250827023202.10310-12-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827023202.10310-12-zhangzihuan@kylinos.cn>

On 27-08-25, 10:31, Zihuan Zhang wrote:
> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
> annotation for policy references. This reduces the risk of reference
> counting mistakes and aligns the code with the latest kernel style.
> 
> No functional change intended.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/tegra186-cpufreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
> index cbabb726c664..4d71e262a729 100644
> --- a/drivers/cpufreq/tegra186-cpufreq.c
> +++ b/drivers/cpufreq/tegra186-cpufreq.c
> @@ -105,7 +105,7 @@ static unsigned int tegra186_cpufreq_get(unsigned int cpu)
>  {
>  	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
>  	struct tegra186_cpufreq_cluster *cluster;
> -	struct cpufreq_policy *policy;
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy);
>  	unsigned int edvd_offset, cluster_id;
>  	u32 ndiv;
>  
> @@ -117,7 +117,6 @@ static unsigned int tegra186_cpufreq_get(unsigned int cpu)
>  	ndiv = readl(data->regs + edvd_offset) & EDVD_CORE_VOLT_FREQ_F_MASK;
>  	cluster_id = data->cpus[policy->cpu].bpmp_cluster_id;
>  	cluster = &data->clusters[cluster_id];
> -	cpufreq_cpu_put(policy);
>  
>  	return (cluster->ref_clk_khz * ndiv) / cluster->div;

Merged with:

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 4d71e262a729..4270686fc3e3 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -103,13 +103,12 @@ static int tegra186_cpufreq_set_target(struct cpufreq_policy *policy,
 
 static unsigned int tegra186_cpufreq_get(unsigned int cpu)
 {
+       struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
        struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
        struct tegra186_cpufreq_cluster *cluster;
-       struct cpufreq_policy *policy __free(put_cpufreq_policy);
        unsigned int edvd_offset, cluster_id;
        u32 ndiv;
 
-       policy = cpufreq_cpu_get(cpu);
        if (!policy)
                return 0;
 

-- 
viresh

