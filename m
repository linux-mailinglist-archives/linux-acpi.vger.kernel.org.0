Return-Path: <linux-acpi+bounces-8259-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C5C9762A4
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 09:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 674D7B2151A
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 07:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A806918E03A;
	Thu, 12 Sep 2024 07:27:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EB41885A0;
	Thu, 12 Sep 2024 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126028; cv=none; b=kgvMNAB8kSeR5mrX5PNokcePssgjMBlbUA0X+XQqn9kIOxsPVt2GhjpMCPZXVHysA5jWDAULvBrz+lNCzSud2MNQQKDEjHceUHm0eBpgAVhzas4NnFL1uzDerZNT5hpf1BlEIBEUda7km3advB44hWR6Wnd5by+WZzJnXo6xiU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126028; c=relaxed/simple;
	bh=ITHaZx556TCDhMkVOu8jwGakV8Wz+pHoCLmJF4zAQMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jIujUmUikxtJNxzl98Fk47tvcWTp0cPI7z/xTgIh6ZiD3mUXkyKKybiQJlqgy/g5WlQopHPwNfe6KaKwDfjU+B3BkI/7C4MueR3YgPeGhBFdZfG/XZdOS7eNUGbA4qTUf5ge6EpJQipDHy+4gylkUy4T+C88duaKA107iArF7jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X488q2j3LzmVFK;
	Thu, 12 Sep 2024 15:24:59 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id EB8A11800D4;
	Thu, 12 Sep 2024 15:27:03 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Sep
 2024 15:27:03 +0800
Message-ID: <95bc95ce-4964-44b3-5f19-813998ee53c3@hisilicon.com>
Date: Thu, 12 Sep 2024 15:27:03 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 0/3] cppc_cpufreq: Rework ->get() error handling when
 cores are idle
To: <ionela.voinescu@arm.com>, <beata.michalska@arm.com>,
	<wangxiongfeng2@huawei.com>, <viresh.kumar@linaro.org>, <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wanghuiqiang@huawei.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yangyicong@huawei.com>,
	<liaochang1@huawei.com>, <zengheng4@huawei.com>
References: <20240912072001.433980-1-zhanjie9@hisilicon.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20240912072001.433980-1-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500019.china.huawei.com (7.185.36.137)

Sorry, please ignore this thread.

Jie

On 12/09/2024 15:19, Jie Zhan wrote:
> Internal:
> 
> A quick update of V2 with the feedback received today.
> Also, cc'd a wider range of people.
> Looking forward to further discussion and feedback.
> 
> -----------------
> External:
> 
> CPPC feedback counters can be unchanged or 0 when cores are idle, e.g.
> clock-gated or power-gated.  In such case, get the latest desired perf for
> calculating frequency.  Also, the HiSilicon CPPC workaround is now handled
> by the common code and can be removed.
> 
> Jie Zhan (3):
>   cppc_cpufreq: Return desired perf in ->get() if feedback counters are
>     0
>   cppc_cpufreq: Return latest desired perf if feedback counters don't
>     change
>   cppc_cpufreq: Remove HiSilicon CPPC workaround
> 
>  drivers/cpufreq/cppc_cpufreq.c | 103 +++++++++------------------------
>  1 file changed, 27 insertions(+), 76 deletions(-)
> 

