Return-Path: <linux-acpi+bounces-16400-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71423B453C5
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 11:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E8E3A579D
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 09:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F9028BA81;
	Fri,  5 Sep 2025 09:50:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B086163;
	Fri,  5 Sep 2025 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065800; cv=none; b=f9vvznl4SCv0efqQnaskNlpBNgC3jHufKBGzHULtKwgTEPAeA8wJkfPs5TfD3MwVt5qbVZcwRBZrCTziS3sar8sAKDNZqYax4mTQ9b0aGl53gmymrbwadUJMzt9AsPGwODUfW93oZ158CnYOCVOOyLvMeZ1hmMhBIXIoOQHZH+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065800; c=relaxed/simple;
	bh=Is1RX+nJYLvCnHgFZ2v8Rej8r6YwILVKPZmWU1+wtgw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYigTwE4/+xOKvLZOH0tTwhtNjB3TRXhqYMxKTNylzD0jZwHDJjBaN0B7L2GLd/QK0MKdmrEhh+CdlkAO5lmBffSGh7PJ8BacMCqRGbl68VmdnUu/zGhLYglHzyQPDH8oCsoOpuIUml+FmQ6gEBE8GAFvQC4ShAT0Ne6bUQEdOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cJBPj4s43z6JBLl;
	Fri,  5 Sep 2025 17:48:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 172721402E9;
	Fri,  5 Sep 2025 17:49:56 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Sep
 2025 11:49:54 +0200
Date: Fri, 5 Sep 2025 10:49:52 +0100
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
Subject: Re: [PATCH v4 04/10] cpufreq: powernv: Use scope-based cleanup
 helper
Message-ID: <20250905104952.00002f58@huawei.com>
In-Reply-To: <20250903131733.57637-5-zhangzihuan@kylinos.cn>
References: <20250903131733.57637-1-zhangzihuan@kylinos.cn>
	<20250903131733.57637-5-zhangzihuan@kylinos.cn>
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

On Wed,  3 Sep 2025 21:17:27 +0800
Zihuan Zhang <zhangzihuan@kylinos.cn> wrote:

> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
> annotation for policy references. This reduces the risk of reference
> counting mistakes and aligns the code with the latest kernel style.
> 
> No functional change intended.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
This one is a little more weak wrt to justification.  Kernel style
isn't to use __free() where there isn't a significant benefit.

Up to maintainer of the driver on this one so I'll not offer
a tag.

> ---
>  drivers/cpufreq/powernv-cpufreq.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 7d9a5f656de8..811fdbf398fa 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -892,15 +892,15 @@ static int powernv_cpufreq_reboot_notifier(struct notifier_block *nb,
>  				unsigned long action, void *unused)
>  {
>  	int cpu;
> -	struct cpufreq_policy *cpu_policy;
>  
>  	rebooting = true;
>  	for_each_online_cpu(cpu) {
> -		cpu_policy = cpufreq_cpu_get(cpu);
> +		struct cpufreq_policy *cpu_policy __free(put_cpufreq_policy) =
> +			cpufreq_cpu_get(cpu);
> +
>  		if (!cpu_policy)
>  			continue;
>  		powernv_cpufreq_target_index(cpu_policy, get_nominal_index());
> -		cpufreq_cpu_put(cpu_policy);
>  	}
>  
>  	return NOTIFY_DONE;
> @@ -913,7 +913,6 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>  static void powernv_cpufreq_work_fn(struct work_struct *work)
>  {
>  	struct chip *chip = container_of(work, struct chip, throttle);
> -	struct cpufreq_policy *policy;
>  	unsigned int cpu;
>  	cpumask_t mask;
>  
> @@ -928,14 +927,14 @@ static void powernv_cpufreq_work_fn(struct work_struct *work)
>  	chip->restore = false;
>  	for_each_cpu(cpu, &mask) {
>  		int index;
> +		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
> +			cpufreq_cpu_get(cpu);
>  
> -		policy = cpufreq_cpu_get(cpu);
>  		if (!policy)
>  			continue;
>  		index = cpufreq_table_find_index_c(policy, policy->cur, false);
>  		powernv_cpufreq_target_index(policy, index);
>  		cpumask_andnot(&mask, &mask, policy->cpus);
> -		cpufreq_cpu_put(policy);
>  	}
>  out:
>  	cpus_read_unlock();


