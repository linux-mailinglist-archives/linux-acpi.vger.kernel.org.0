Return-Path: <linux-acpi+bounces-16398-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98156B453B5
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 11:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7D1A01B30
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2587428852E;
	Fri,  5 Sep 2025 09:47:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D41F2882BD;
	Fri,  5 Sep 2025 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065672; cv=none; b=MOpTSKT7Jt26QXwoMEw9PDZe0SxVuHVensT459JcUbRuedA1aSzN9XhnIegoiFGeotiFFFPvVQjCCgNkkLG7o/pVNiil9EaWcDgYkQFOu/flm1CSSs0Bdg83mhUeKB7kzc699KlaCup0CFSf4VRCzTf21SQIC9vuiZkrNyv5oJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065672; c=relaxed/simple;
	bh=WxBMlDcI1gNv1hytp9jLWeQmFhxZS9MagRnSSDkwk2E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugC/JhqmcjP6zMY4g7M/rztXsEvBF5XoaIuORMVBm7IP7ynGJAMi2sj7IRYXHIFZyxZiwgAbmPgNmQcBpl2fZ+WNWJJ5XMtlDfXBlvmn+ycij3c+yr2WPzNVb6vs1UW6M98c1WDmTY3ZvXQ/9pnBIzhOBOsTdQrtgwi2SAvSI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cJBHr7169z6L5Zv;
	Fri,  5 Sep 2025 17:43:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C5FBC1402F1;
	Fri,  5 Sep 2025 17:47:46 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Sep
 2025 11:47:44 +0200
Date: Fri, 5 Sep 2025 10:47:43 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
CC: "Rafael J . wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>, MyungJoo Ham
	<myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, "Jani Nikula"
	<jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko
 Ursulin <tursulin@ursulin.net>, "David Airlie" <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Daniel Lezcano <daniel.lezcano@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, "Shawn Guo" <shawnguo@kernel.org>, Eduardo
 Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Ben Horgan
	<ben.horgan@arm.com>, zhenglifeng <zhenglifeng1@huawei.com>, Zhang Rui
	<rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Lukasz Luba
	<lukasz.luba@arm.com>, "Pengutronix Kernel Team" <kernel@pengutronix.de>,
	Beata Michalska <beata.michalska@arm.com>, Fabio Estevam
	<festevam@gmail.com>, Pavel Machek <pavel@kernel.org>, "Sumit Gupta"
	<sumitg@nvidia.com>, Prasanna Kumar T S M <ptsm@linux.microsoft.com>, Sudeep
 Holla <sudeep.holla@arm.com>, Yicong Yang <yangyicong@hisilicon.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<imx@lists.linux.dev>, <linux-omap@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/10] cpufreq: intel_pstate: Use scope-based cleanup
 helper
Message-ID: <20250905104743.00004177@huawei.com>
In-Reply-To: <20250903131733.57637-4-zhangzihuan@kylinos.cn>
References: <20250903131733.57637-1-zhangzihuan@kylinos.cn>
	<20250903131733.57637-4-zhangzihuan@kylinos.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  3 Sep 2025 21:17:26 +0800
Zihuan Zhang <zhangzihuan@kylinos.cn> wrote:

> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
> annotation for policy references. This reduces the risk of reference
> counting mistakes and aligns the code with the latest kernel style.
> 
> No functional change intended.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>

One trivial comment inline.  This LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/cpufreq/intel_pstate.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index f366d35c5840..925efb1e65be 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1209,6 +1209,17 @@ static bool hybrid_clear_max_perf_cpu(void)
>  	return ret;
>  }
>  
> +static struct freq_qos_request *intel_pstate_cpufreq_get_req(int cpu)
> +{
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) =
> +		cpufreq_cpu_get(cpu);
> +
> +	if (!policy)
> +		return NULL;
> +
> +	return policy->driver_data;
> +}
> +
>  static void __intel_pstate_get_hwp_cap(struct cpudata *cpu)
>  {
>  	u64 cap;
> @@ -1698,19 +1709,13 @@ static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
>  static void update_qos_request(enum freq_qos_req_type type)
>  {
>  	struct freq_qos_request *req;
> -	struct cpufreq_policy *policy;
>  	int i;
>  
>  	for_each_possible_cpu(i) {
>  		struct cpudata *cpu = all_cpu_data[i];
>  		unsigned int freq, perf_pct;
>  
> -		policy = cpufreq_cpu_get(i);
> -		if (!policy)
> -			continue;
> -
> -		req = policy->driver_data;
> -		cpufreq_cpu_put(policy);
> +		req = intel_pstate_cpufreq_get_req(i);
>  

I'd drop this blank line as it'll keep the setting or req and checking it
closely coupled.  Previously the put inbetween stopped that but now
we can improve the formatting!

>  		if (!req)
>  			continue;


