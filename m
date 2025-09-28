Return-Path: <linux-acpi+bounces-17375-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24157BA65E1
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Sep 2025 03:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF24117F03A
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Sep 2025 01:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D859217F35;
	Sun, 28 Sep 2025 01:59:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4742A96;
	Sun, 28 Sep 2025 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759024764; cv=none; b=f+YDKb6hGGBD+K2mfe7VpQODzqVoFUhry95JSqhi1g4cLFK4q2t82o/zs4bwBXUMguhGXGvJf5K1MtWy44Q07dXjp/kR+GUAqMHJpWyO9ZfDNoTvamnJqH6fyTlLIUxlYP4nm76e6uH2duI5t87wb8bo/IV3mtIbUZpO9OuA4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759024764; c=relaxed/simple;
	bh=N4LPkmwK6smqMMSd9bSdCIg3UiOaiO0ARVFzJHAuoCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ACPJJoxmjVubi73+oB0HwBAomT+JP9VPlSFp9Vh7suPDykkgHuHc9b0GDZfbkuY7EGqpvuhq93jiTy9AotGbQJAxtDaHjXgHNv88LpOSgxXa5wBJ5CVXv3F1T24afOEq6Z7JTv5+84u5GfEYuzHpDESxu9pMeEG1B0xkaMPyn+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from canpmsgout08.his.huawei.com (unknown [172.19.92.156])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cZ6ng45S3zJsX5;
	Sun, 28 Sep 2025 09:54:31 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cZ6tk3yZBzmV71;
	Sun, 28 Sep 2025 09:58:54 +0800 (CST)
Received: from kwepemr500004.china.huawei.com (unknown [7.202.195.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 32916180044;
	Sun, 28 Sep 2025 09:59:04 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemr500004.china.huawei.com
 (7.202.195.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 28 Sep
 2025 09:59:03 +0800
Message-ID: <e01fef03-65cd-4eb6-be48-974bcd59ae23@hisilicon.com>
Date: Sun, 28 Sep 2025 09:59:02 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as
 transition delay
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>, LKML
	<linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Pierre Gondois <pierre.gondois@arm.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Linux ACPI <linux-acpi@vger.kernel.org>
References: <5069803.31r3eYUQgx@rafael.j.wysocki>
 <3406003.44csPzL39Z@rafael.j.wysocki>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <3406003.44csPzL39Z@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500004.china.huawei.com (7.202.195.141)



On 9/26/2025 6:19 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If cppc_get_transition_latency() returns CPUFREQ_ETERNAL to indicate a
> failure to retrieve the transition latency value from the platform
> firmware, the CPPC cpufreq driver will use that value (converted to
> microseconds) as the policy transition delay, but it is way too large
> for any practical use.
> 
> Address this by making the driver use the cpufreq's default
> transition latency value (in microseconds) as the transition delay
> if CPUFREQ_ETERNAL is returned by cppc_get_transition_latency().
> 
> Fixes: d4f3388afd48 ("cpufreq / CPPC: Set platform specific transition_delay_us")
> Cc: 5.19+ <stable@vger.kernel.org> # 5.19
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
> 
> v1 -> v3:
>    * Change the name of the new function (Jie Zhan)
>    * Add a tag from Mario Limonciello
> 
> ---
>  drivers/cpufreq/cppc_cpufreq.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

