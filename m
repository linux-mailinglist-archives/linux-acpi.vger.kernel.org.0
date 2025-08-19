Return-Path: <linux-acpi+bounces-15832-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D1B2BFE1
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 13:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD55C16A108
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 11:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B4331A042;
	Tue, 19 Aug 2025 11:07:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8AB27A44D;
	Tue, 19 Aug 2025 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601669; cv=none; b=elY1fwt8ZPbLS6GPOKeX0oEyMrUQBdOxPMfHIrYI3co3+qImN6Kgn99IOPmqkMyD2sjeLLbcME66vCW5+WaG6haCtbgPHmbAKUAaPwynaWm7GObz3Ux2EZ1KIsicfL9X32t/L/yJFSD/74Fs048F4mgmZwEpT2qU1PqrATSAlzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601669; c=relaxed/simple;
	bh=QbhkxGzizAvJoI6JomljhYA3Sp/Qq2lu8OFJbj0qHI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hc1sn2Tvpp3fxkATT0qqOE7PSFGB0W6NENptjqSFz+mynk6jvDuc3feP8hPF4TBsYcmra5Q+hAglzkxDdPlWeK1LyH/rZJk251Bi3f8Dq4EnjUjp9oHd9ocviYOVmZBPf1OJSRMm/Yzr6HVPko+6OuPSS3Zmmxe7qfKO23gVoAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c5msN4bG2z2CgJ7;
	Tue, 19 Aug 2025 19:03:20 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 002851400D4;
	Tue, 19 Aug 2025 19:07:43 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 19:07:42 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 19:07:42 +0800
Message-ID: <6b65f2a1-7906-4659-a254-3cbbc9ba8bf1@huawei.com>
Date: Tue, 19 Aug 2025 19:07:41 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] ACPI: processor: idle: Optimize acpi idle driver
 registration
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<liuyonglong@huawei.com>
References: <20250728070612.1260859-1-lihuisong@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250728070612.1260859-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Kindly ping for review.

在 2025/7/28 15:06, Huisong Li 写道:
> This series fix a memory leak issue and optimize the registration of
> acpi idle driver to enhance its readability.
>
> ---
> changelog:
> v3:
>   * use a separate patch to fix memory leak.
>   * change the return value of the new function to void.
>   * change log level to debug on failure path.
> v2:
>   * register cpuidle driver in advance when all of the CPUs have been
>     brought up.
> https://patchwork.kernel.org/project/linux-acpi/patch/20250723121034.3685996-1-lihuisong@huawei.com/
> v1:
> https://patchwork.kernel.org/project/linux-acpi/patch/20250619061327.1674384-1-lihuisong@huawei.com/
>
> Huisong Li (2):
>    ACPI: processor: idle: Fix memory leak when register cpuidle device
>      failed
>    ACPI: processor: idle: Optimize acpi idle driver registration
>
>   drivers/acpi/processor_driver.c |  3 ++
>   drivers/acpi/processor_idle.c   | 67 ++++++++++++++++++++++-----------
>   include/acpi/processor.h        |  8 ++++
>   3 files changed, 55 insertions(+), 23 deletions(-)
>

