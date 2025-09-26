Return-Path: <linux-acpi+bounces-17334-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04718BA33AD
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 11:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29628385A3A
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 09:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531462BE039;
	Fri, 26 Sep 2025 09:47:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F8D2BD58C;
	Fri, 26 Sep 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880064; cv=none; b=lbmXS6cYGm14h4J9Ii+nSt4cA1xH9bdV9tVqZX5+ifRO42fqiKknTBXo6qr8TLXPd0SCRkaUooMZ6XLqfxoBARFmkKlKbs/7eEvUgFOcEnjWBFCF5ZXyXySsRHHcVT116eeRaRJm1WWpPEDObVfwpBRSZ4EuQrqUG7RZW4FstjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880064; c=relaxed/simple;
	bh=A/2krd+kW51Ci9YgMe6nqKVo5aZEJW74+oXFZS4DwXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gAL0dRa8Gh5b1fIPyOrnEYHFqg7kchmhKCPoNrWcXFnqpK47jRtClOMNEzcAcL7quE0Ssi31VuXZGMsoB2CLUc3Fwqz6DY7PArFEjnoloV59xfNzhX6Nlzcu48Cpou29zmBTB75sfFAQSa/2z3vOPOLgkChFiuyu1x/IhNnEd7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cY5MW06vpzVmdT;
	Fri, 26 Sep 2025 17:46:47 +0800 (CST)
Received: from kwepemr500004.china.huawei.com (unknown [7.202.195.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BFD9180087;
	Fri, 26 Sep 2025 17:47:39 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemr500004.china.huawei.com
 (7.202.195.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Sep
 2025 17:47:38 +0800
Message-ID: <5887881a-ace1-49dd-a4e4-4eb7b499f7c4@hisilicon.com>
Date: Fri, 26 Sep 2025 17:47:38 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] cpufreq: Drop unused symbol CPUFREQ_ETERNAL
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>, LKML
	<linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Prashanth Prakash <pprakash@codeaurora.org>, Pierre Gondois
	<pierre.gondois@arm.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>
References: <8605612.T7Z3S40VBb@rafael.j.wysocki>
 <9533136.CDJkKcVGEf@rafael.j.wysocki>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <9533136.CDJkKcVGEf@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500004.china.huawei.com (7.202.195.141)



On 9/25/2025 11:47 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop CPUFREQ_ETERNAL that has no users any more along with all
> references to it in the documentation.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  Documentation/admin-guide/pm/cpufreq.rst                  |    4 ----
>  Documentation/cpu-freq/cpu-drivers.rst                    |    3 +--
>  Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst |    3 +--
>  Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst |    3 +--
>  include/linux/cpufreq.h                                   |    5 -----
>  5 files changed, 3 insertions(+), 15 deletions(-)

