Return-Path: <linux-acpi+bounces-17166-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AADBB8EA8E
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 03:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B837AAD09
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 01:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C37D78F58;
	Mon, 22 Sep 2025 01:16:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081F3481DD;
	Mon, 22 Sep 2025 01:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758503807; cv=none; b=tBEysZx8s78gfVvSVK7gbmXf0QgjqJBtUyEbaGsTMyPXTz6XNCBbabVRGYQIOXb8DF0yd46n7mnNXeeyCPkZrtD9FDSyGJ7RwGri0JEk6iATpKrLdKW2Kr/cgHJtrEJzgxw/ZhRIN79a/0OleJep4aZZ8lTp5aPiRDXXDCUB+Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758503807; c=relaxed/simple;
	bh=ZkPKof/amO8hTFYOIXGD094bq5cznBKUhX6Uh+ZjGK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gj0ba0CmUr4lQbDN6tXUsNf3nGXZdZ675oJWKarzycb3Zs1VdnG+U1JtQa1vhe/zJaiF9LuturhLuk3Fn7gT78BBIG8GI1ErroizODqhwT1sK2ToQVnCC1HfFPJGNJpqh66eX9vVsALWMvmwvP6DrrVnA8pyEEaAmYfsclsRD6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cVQG23NL5z27j8c;
	Mon, 22 Sep 2025 09:17:46 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 631EE1A0188;
	Mon, 22 Sep 2025 09:16:35 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 09:16:35 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Sep
 2025 09:16:34 +0800
Message-ID: <c642d834-dbaa-43bb-95fd-bb9603ba81f2@huawei.com>
Date: Mon, 22 Sep 2025 09:16:33 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ACPI: processor: Update cpuidle driver check in
 __acpi_processor_start()
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>
References: <5926523.DvuYhMxLoT@rafael.j.wysocki>
 <5044465.31r3eYUQgx@rafael.j.wysocki>
 <CAJZ5v0gXHedm9WwwMuTN7vYyf5fNB6yOGLp_-GxSoZAEhSx5aw@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0gXHedm9WwwMuTN7vYyf5fNB6yOGLp_-GxSoZAEhSx5aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/9/19 19:17, Rafael J. Wysocki 写道:
> On Thu, Sep 18, 2025 at 11:10 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Commit 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle
>> driver registration") moved the ACPI idle driver registration to
>> acpi_processor_driver_init() and acpi_processor_power_init() does
>> not register an idle driver any more, so the cpuidle driver check
>> in __acpi_processor_start() needs to be updated to avoid calling
>> acpi_processor_power_init() without a cpuidle driver (in which
>> case the registration of the cpuidle device in that function
>> would fail anyway).
> It's worse, it won't just fail, it'll lead to a NULL pointer
> dereference in __cpuidle_register_device().
>
> I'll update the changelog while applying the patch.
Yeah, thanks for fixing it.
Acked-by: lihuisong@huawei.com
>
>> Fixes: 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle driver registration")
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> Commit 7a8c994cbb2d is only in linux-next at this point.
>>
>> ---
>>   drivers/acpi/processor_driver.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -166,7 +166,7 @@ static int __acpi_processor_start(struct
>>          if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
>>                  dev_dbg(&device->dev, "CPPC data invalid or not present\n");
>>
>> -       if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
>> +       if (cpuidle_get_driver() == &acpi_idle_driver)
>>                  acpi_processor_power_init(pr);
>>
>>          acpi_pss_perf_init(pr);
>>
>>
>>
>>

