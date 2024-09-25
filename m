Return-Path: <linux-acpi+bounces-8385-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7309852ED
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 08:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CE1281F81
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 06:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34E113AA53;
	Wed, 25 Sep 2024 06:30:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635DE81E;
	Wed, 25 Sep 2024 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727245823; cv=none; b=CkypWmjbu8RrHXzBQ43eWAhQLt06m03+sstCgxtg/aAq6L3hIL+VPLoaOz3r+YH+20a5EDTyqtjUL8tWF4/qqaiY/E8LQfVrAHOxACQuz6TSRQOG/fnmcSnmHSbXsogbSGBM8DOjCCHDJhmc4ZXUS91Yr3cbNl+GoDitrLSplnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727245823; c=relaxed/simple;
	bh=rY3m7yhYB/1rNY6tuLk33kopGZouZRv/J6mGg62Ah/U=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Pza/1BnCO7q0gsiZ+julfQI8cPQMe4JkdiNXdUkbvY6CUvr6FgfCLUq6w+JoHQ6VH/x8Dbzj2mp7hCpxeKe8NhStiMVfr+SA+58hzYdB+EFLzk3YNi+VQl2EVEPmDQck7MHunq+ukUwoXS7HhZx+h8c/W6KDl7eoz2eJxUN2b7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XD6Jk1kkpz1SBgD;
	Wed, 25 Sep 2024 14:29:26 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id E6819140158;
	Wed, 25 Sep 2024 14:30:13 +0800 (CST)
Received: from [10.174.179.5] (10.174.179.5) by kwepemd100023.china.huawei.com
 (7.221.188.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Sep
 2024 14:30:12 +0800
Subject: Re: [PATCH v3 2/2] cppc_cpufreq: Remove HiSilicon CPPC workaround
To: Jie Zhan <zhanjie9@hisilicon.com>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <viresh.kumar@linaro.org>, <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wanghuiqiang@huawei.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yangyicong@huawei.com>,
	<liaochang1@huawei.com>, <zengheng4@huawei.com>
References: <20240919084552.3591400-1-zhanjie9@hisilicon.com>
 <20240919084552.3591400-3-zhanjie9@hisilicon.com>
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <6305475a-3fbd-780d-e341-716fecf4b769@huawei.com>
Date: Wed, 25 Sep 2024 14:30:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240919084552.3591400-3-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100023.china.huawei.com (7.221.188.33)

Reviewed-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

On 2024/9/19 16:45, Jie Zhan wrote:
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
>  drivers/cpufreq/cppc_cpufreq.c | 71 ----------------------------------
>  1 file changed, 71 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index e55192303a9f..0e95ad2303ea 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -36,24 +36,6 @@ static LIST_HEAD(cpu_data_list);
>  
>  static bool boost_supported;
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
>  static struct cpufreq_driver cppc_cpufreq_driver;
>  
>  static enum {
> @@ -78,7 +60,6 @@ struct cppc_freq_invariance {
>  static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
>  static struct kthread_worker *kworker_fie;
>  
> -static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
>  static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>  				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>  				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
> @@ -841,57 +822,6 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.name = "cppc_cpufreq",
>  };
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
>  static int __init cppc_cpufreq_init(void)
>  {
>  	int ret;
> @@ -899,7 +829,6 @@ static int __init cppc_cpufreq_init(void)
>  	if (!acpi_cpc_valid())
>  		return -ENODEV;
>  
> -	cppc_check_hisi_workaround();
>  	cppc_freq_invariance_init();
>  	populate_efficiency_class();
>  
> 

