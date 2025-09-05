Return-Path: <linux-acpi+bounces-16403-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB970B45414
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 12:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC71A18948D2
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 10:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84C82BE02D;
	Fri,  5 Sep 2025 10:05:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0782029DB61;
	Fri,  5 Sep 2025 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066759; cv=none; b=r5n927lB49aARCCCTlTl45HKD+JsbeklJHVdfA/XaB1wrwdbD1BQMQ8XlkH1L/sqnvFT4WcER52rhAmL5Y1NTFT+KADXRRE9tU34oQ69zoVAkKqKiJo5fIXfsm/dYKzUJezwghbDe+1EkyIBxA1X/qcH2dGrzs1SSqZnFiygll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066759; c=relaxed/simple;
	bh=wenfa45yXzz3Ie0WAoc3CoSUI/TsM3QA/mIu3NiP9gs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFfDOlETkHaeoNeHdhuIPCDOzBfFzAi9rVG7ipqakirG/2Exou7vNIQy5dOGTckadexmD7LebfUL/0h4YQPszxrPCWXJ5XC+Mq0xv9bWmN9wIRvMSsQJ9Rjz6hr3BmQfjxGIu7apd7sDEpN8brZwZV6tT5hI1LLC11PcM06CJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cJBhn0xyXz6L5ly;
	Fri,  5 Sep 2025 18:02:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 03F6A1402CB;
	Fri,  5 Sep 2025 18:05:55 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Sep
 2025 12:05:53 +0200
Date: Fri, 5 Sep 2025 11:05:51 +0100
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
Subject: Re: [PATCH v4 08/10] thermal: imx: Use scope-based cleanup helper
Message-ID: <20250905110551.00006588@huawei.com>
In-Reply-To: <20250903131733.57637-9-zhangzihuan@kylinos.cn>
References: <20250903131733.57637-1-zhangzihuan@kylinos.cn>
	<20250903131733.57637-9-zhangzihuan@kylinos.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  3 Sep 2025 21:17:31 +0800
Zihuan Zhang <zhangzihuan@kylinos.cn> wrote:

> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
> annotation for policy references. This reduces the risk of reference
> counting mistakes and aligns the code with the latest kernel style.
> 
> No functional change intended.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>

This radically changes the lifetime of the reference to policy.
If that is valid, then I'd expect a lot more description of why!

> ---
>  drivers/thermal/imx_thermal.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 38c993d1bcb3..cd1d9d419275 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -201,7 +201,6 @@ static struct thermal_soc_data thermal_imx7d_data = {
>  
>  struct imx_thermal_data {
>  	struct device *dev;
> -	struct cpufreq_policy *policy;
>  	struct thermal_zone_device *tz;
>  	struct thermal_cooling_device *cdev;
>  	struct regmap *tempmon;
> @@ -541,22 +540,20 @@ MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
>  static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
>  {
>  	struct device_node *np;
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(0);
>  	int ret = 0;
>  
> -	data->policy = cpufreq_cpu_get(0);
> -	if (!data->policy) {
> +	if (!policy) {
>  		pr_debug("%s: CPUFreq policy not found\n", __func__);
>  		return -EPROBE_DEFER;
>  	}
>  
> -	np = of_get_cpu_node(data->policy->cpu, NULL);
> +	np = of_get_cpu_node(policy->cpu, NULL);
>  
>  	if (!np || !of_property_present(np, "#cooling-cells")) {
> -		data->cdev = cpufreq_cooling_register(data->policy);
> -		if (IS_ERR(data->cdev)) {
> +		data->cdev = cpufreq_cooling_register(policy);
> +		if (IS_ERR(data->cdev))
>  			ret = PTR_ERR(data->cdev);
> -			cpufreq_cpu_put(data->policy);
> -		}
>  	}
>  
>  	of_node_put(np);
> @@ -567,7 +564,6 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
>  static void imx_thermal_unregister_legacy_cooling(struct imx_thermal_data *data)
>  {
>  	cpufreq_cooling_unregister(data->cdev);
> -	cpufreq_cpu_put(data->policy);
>  }
>  
>  #else


