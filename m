Return-Path: <linux-acpi+bounces-8594-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798B0993C84
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 03:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221931F223D1
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 01:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F186517BD9;
	Tue,  8 Oct 2024 01:52:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859C18651;
	Tue,  8 Oct 2024 01:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352336; cv=none; b=hVI0eEIEJffispbSvgFiASjmrU4OuUv4FFggxYwP7d0GWN81U2jMvcNkykmIKENbzoMaTd+WiujUFwbQRQ9SrybSlTfRasKECFHnmElGDmvolnoBxZWhOwkkIaEgGGZrfLxPQxRsMiyl3DY1G6X10DJUZoUUl9FlF1ZhBVoILN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352336; c=relaxed/simple;
	bh=4oSTPG6TMVEjXfGn0FgiLzkwsmseOF4HggcBP8Y/FUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HCA9zVQ+/fwoN+7ptecH4sWYBa7fMvZJ+CRKxfwjvBpjERa3PQfDE95wzV52Xm9yuYFwsWVXqCDQ3DtWGILOHFbt8xIhzjQeImg8TaYngDqKMr3PZ+D4zs2BtqiM5V/mIpdm1Gi9VsfYEtkPaDkrWu1OO1SAldutwznVfYv+HKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XMzWy5w9jzCt6Z;
	Tue,  8 Oct 2024 09:51:26 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BE28180106;
	Tue,  8 Oct 2024 09:52:02 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Oct
 2024 09:52:01 +0800
Message-ID: <29a93f04-41a1-3673-a523-73b560bdaa03@hisilicon.com>
Date: Tue, 8 Oct 2024 09:52:01 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 0/2] cppc_cpufreq: Rework ->get() error handling when
 cores are idle
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <ionela.voinescu@arm.com>, <beata.michalska@arm.com>,
	<wangxiongfeng2@huawei.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<wanghuiqiang@huawei.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yangyicong@huawei.com>, <liaochang1@huawei.com>, <zengheng4@huawei.com>
References: <20240929033214.1039485-1-zhanjie9@hisilicon.com>
 <20241003054042.t463fqivfk6immen@vireshk-i7>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20241003054042.t463fqivfk6immen@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500019.china.huawei.com (7.185.36.137)



On 03/10/2024 13:40, Viresh Kumar wrote:
> On 29-09-24, 11:32, Jie Zhan wrote:
>> CPPC feedback counters can be unchanged or 0 when cores are idle, e.g.
>> clock-gated or power-gated.  In such case, get the latest desired perf for
>> calculating frequency.
>>
>> Also, the HiSilicon CPPC workaround can now be removed as it can be handled
>> by the common code.
>>
>> ---
>> v4:
>> - Some additional comments as suggested. No functions changes.
> 
> Merged with following diff to fix the warning.
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index ae3424cb3335..fd3e328a2d57 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -38,13 +38,13 @@ static bool boost_supported;
> 
>  static struct cpufreq_driver cppc_cpufreq_driver;
> 
> +#ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>  static enum {
>         FIE_UNSET = -1,
>         FIE_ENABLED,
>         FIE_DISABLED
>  } fie_disabled = FIE_UNSET;
> 
> -#ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>  module_param(fie_disabled, int, 0444);
>  MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)");
> 

Thanks for fixing the warning and merging!

Jie

