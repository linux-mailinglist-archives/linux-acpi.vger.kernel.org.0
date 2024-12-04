Return-Path: <linux-acpi+bounces-9911-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085DC9E336A
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 07:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E98162AC6
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 06:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9521714CF;
	Wed,  4 Dec 2024 06:07:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A2B28F4;
	Wed,  4 Dec 2024 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733292445; cv=none; b=sYP0Pq3FoR4BhmuuIzk1GLs5vw+ojPZJXhZu/EGcPEF4HNeKxWQY9IyPQ/+pzfVrZDUC+FDvyTC9dhumaNs+jZCck6j3MWlNMZ/iAeZ9d6RGQD8p48nR2QA2YYMgeHs+Nq9G8RHKeiDqWJlq7u8UPQoyn1DOZ5yncrp0ewjBwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733292445; c=relaxed/simple;
	bh=GaTcstdK7cG9e90GCCL0+x7r6GT+lrSX4pIs+KE378I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n/81EHWsK60B1x6cirE/yPDxrckY/fZaTgDDcht9OUkO5JIQYdHh6BQW4ipLraOm8D5nBaXqJGbOV2jocoSQoMohrk6u5aLNQDqP53Nn2oznzEpgroBxqZLnIMBY94VK4meBvMgCqcK9ww+vQJMyClIH0zScXrp/18V4CRaBVEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Y36T12DSgzRhph;
	Wed,  4 Dec 2024 14:05:41 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 97C99180104;
	Wed,  4 Dec 2024 14:07:18 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Dec
 2024 14:07:17 +0800
Message-ID: <57668237-5c98-4d03-858f-8d29057bfad8@huawei.com>
Date: Wed, 4 Dec 2024 14:07:14 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Support for autonomous selection in cppc_cpufreq
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <hepeng68@huawei.com>,
	<fanghao11@huawei.com>, <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
	"zhenglifeng (A)" <zhenglifeng1@huawei.com>
References: <20241122062051.3658577-1-zhenglifeng1@huawei.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20241122062051.3658577-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Gentle ping.
+cc a few developers

On 2024/11/22 14:20, Lifeng Zheng wrote:
> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
> driver.
> 
> The patch series is organized in two parts:
> 
>  - patch 1 refactor out the general CPPC register get and set functions
>    in cppc_acpi.c
> 
>  - patches 2-3 expose sysfs files for users to control CPPC autonomous
>    selection when supported
> 
> Change since v1:
>  - fix some incorrect placeholder
>  - change kstrtoul to kstrtobool in store_auto_select
> 
> Lifeng Zheng (3):
>   ACPI: CPPC: Refactor register get and set ABIs
>   ACPI: CPPC: Add autonomous selection ABIs
>   cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq
> 
>  .../ABI/testing/sysfs-devices-system-cpu      |  54 ++++
>  drivers/acpi/cppc_acpi.c                      | 235 +++++++++---------
>  drivers/cpufreq/cppc_cpufreq.c                | 138 ++++++++++
>  include/acpi/cppc_acpi.h                      |  20 ++
>  4 files changed, 328 insertions(+), 119 deletions(-)
> 


