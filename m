Return-Path: <linux-acpi+bounces-8387-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FD3985674
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 11:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D92C1C23688
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0860515C131;
	Wed, 25 Sep 2024 09:36:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7415CD54;
	Wed, 25 Sep 2024 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256986; cv=none; b=ALNrF6J9Jze+BrTJ98zL9WQvPIl83fXMazIgu9bXW+4lva5ZCv+BHbaFmzHlC6GXl8KJsMUD5Met3pvBWhhCF/gAc6nqyWZil6RyCODUr/tGdNVf68NmlfsUdmXE9qseHQScRxPhffdBxobIU3P80B9TpLM/lMw/47r/8TMBugo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256986; c=relaxed/simple;
	bh=pshnjSeQxKsYPu54WSlDpCmiKuINBsUYXpQGeNb+yzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dv20luTRKWmeikz9tHju+IGwDmjmJt15d8/3QOSew0r0fARH/o10mPg0+14z+dxssqJFn5P5Sk+eq22dZ05zHM3cWqu0JbN955eE1pFu98Z9RqM2H+xZEpJGAs8ya2lc+xLYH1f1ulaqMNCw2Vypr8oXa+jzfm9BbxZTohXhino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XDBQl3Z95z1T7yg;
	Wed, 25 Sep 2024 17:34:55 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D7FC18115E;
	Wed, 25 Sep 2024 17:36:14 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Sep
 2024 17:36:13 +0800
Message-ID: <82f4fa82-ee37-5328-4792-3143a2f0ac6f@huawei.com>
Date: Wed, 25 Sep 2024 17:36:12 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 2/2] cppc_cpufreq: Remove HiSilicon CPPC workaround
To: Jie Zhan <zhanjie9@hisilicon.com>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <wangxiongfeng2@huawei.com>,
	<viresh.kumar@linaro.org>, <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wanghuiqiang@huawei.com>,
	<zhenglifeng1@huawei.com>, <yangyicong@huawei.com>, <liaochang1@huawei.com>,
	<zengheng4@huawei.com>
References: <20240919084552.3591400-1-zhanjie9@hisilicon.com>
 <20240919084552.3591400-3-zhanjie9@hisilicon.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20240919084552.3591400-3-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600004.china.huawei.com (7.193.23.242)

LGTM,

Reviewed-by: Huisong Li <lihuisong@huawei.com>

在 2024/9/19 16:45, Jie Zhan 写道:
> Since commit 6c8d750f9784 ("cpufreq / cppc: Work around for Hisilicon CPPC
> cpufreq"), we introduce a workround for HiSilicon platforms that do not
> support performance feedback counters, whereas they can get the actual
> frequency from the desired perf register.  Later on, FIE is disabled in
> that workaround as well.
>
> Now the workround can be handled by the common code.  Desired perf would be
> read and converted to frequency if feedback counters don't change.  FIE
> would be disabled if the CPPC regs are in PCC region.
>
> Hence, the workaround is no longer needed and can be safely removed, in an
> effort to consolidate the driver procedure.
>
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 71 ----------------------------------
>   1 file changed, 71 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index e55192303a9f..0e95ad2303ea 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -36,24 +36,6 @@ static LIST_HEAD(cpu_data_list);
>   
>   static bool boost_supported;
>   
> -struct cppc_workaround_oem_info {
> -	char oem_id[ACPI_OEM_ID_SIZE + 1];
> -	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
> -	u32 oem_revision;
> -};
> -
> -static struct cppc_workaround_oem_info wa_info[] = {
> -	{
> -		.oem_id		= "HISI  ",
> -		.oem_table_id	= "HIP07   ",
> -		.oem_revision	= 0,
> -	}, {
> -		.oem_id		= "HISI  ",
> -		.oem_table_id	= "HIP08   ",
> -		.oem_revision	= 0,
> -	}
> -};
> -
>   static struct cpufreq_driver cppc_cpufreq_driver;
>   
>   static enum {
> @@ -78,7 +60,6 @@ struct cppc_freq_invariance {
>   static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
>   static struct kthread_worker *kworker_fie;
>   
> -static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
>   static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>   				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>   				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
> @@ -841,57 +822,6 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>   	.name = "cppc_cpufreq",
>   };
>   
> -/*
> - * HISI platform does not support delivered performance counter and
> - * reference performance counter. It can calculate the performance using the
> - * platform specific mechanism. We reuse the desired performance register to
> - * store the real performance calculated by the platform.
> - */
> -static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
> -{
> -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> -	struct cppc_cpudata *cpu_data;
> -	u64 desired_perf;
> -	int ret;
> -
> -	if (!policy)
> -		return -ENODEV;
> -
> -	cpu_data = policy->driver_data;
> -
> -	cpufreq_cpu_put(policy);
> -
> -	ret = cppc_get_desired_perf(cpu, &desired_perf);
> -	if (ret < 0)
> -		return -EIO;
> -
> -	return cppc_perf_to_khz(&cpu_data->perf_caps, desired_perf);
> -}
> -
> -static void cppc_check_hisi_workaround(void)
> -{
> -	struct acpi_table_header *tbl;
> -	acpi_status status = AE_OK;
> -	int i;
> -
> -	status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
> -	if (ACPI_FAILURE(status) || !tbl)
> -		return;
> -
> -	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
> -		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
> -		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
> -		    wa_info[i].oem_revision == tbl->oem_revision) {
> -			/* Overwrite the get() callback */
> -			cppc_cpufreq_driver.get = hisi_cppc_cpufreq_get_rate;
> -			fie_disabled = FIE_DISABLED;
> -			break;
> -		}
> -	}
> -
> -	acpi_put_table(tbl);
> -}
> -
>   static int __init cppc_cpufreq_init(void)
>   {
>   	int ret;
> @@ -899,7 +829,6 @@ static int __init cppc_cpufreq_init(void)
>   	if (!acpi_cpc_valid())
>   		return -ENODEV;
>   
> -	cppc_check_hisi_workaround();
>   	cppc_freq_invariance_init();
>   	populate_efficiency_class();
>   

