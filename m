Return-Path: <linux-acpi+bounces-19499-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 935AECAF238
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 08:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA08B304639F
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 07:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4533288525;
	Tue,  9 Dec 2025 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="XbITDAAx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2372868AB;
	Tue,  9 Dec 2025 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265381; cv=none; b=G7G3wdIk0jN00E1vegXYaW+6YYR0exm2Nv2eSLb7+inLkRrwIq7oxMD8O00O5q8a+mWUIpY/MNoVRpRz3JzC2t7UuirR9svN0UorbD/JIT6xwEaVKiFVrRBF1qfbix77BAr6cL0I/HLfcjwsj8/3V7kbX9SanQ7DZW71LbebRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265381; c=relaxed/simple;
	bh=Y7zyQ3Cc5DlKIsNW/GqayFZcqof4q0SiDOyea2py6q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Irbk/v4N+V2ArM0Cd9G6Rihsps9W/V6CFf6bFFZYEGMjwgYHOQm0a3Q+kig6xPH7R3kJthJoSNQUN8opz1QQjoQ3d0LBhexDAFYQFb7xbMV5v6PakXsZ8IMBOPxDWZ6i1cy4I3j957EYV95dTqDnoiS0t+6MGNQaXFri2K+Pg40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=XbITDAAx; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=khkDOJh1/uYzmB+/MJQsODnByd/QEEA368wUov7qEg8=;
	b=XbITDAAxKMXbJQw3hmqrBSUzOJ2BSUIeKOMULD/gTHZ+SbiTM46kWxY5u8cvvlZx9RJyNDoFA
	yNqbHAa/WQk7bnXS3JYWWyyoUjBgB5HKZNyFxU8oLBmldmY30eYet4kFB6uk6VpwyRDlGX0F6Jt
	bakeX9vPGScBYefSd4Q2MII=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dQVmp3d2qzLlTc;
	Tue,  9 Dec 2025 15:27:38 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id E949F140155;
	Tue,  9 Dec 2025 15:29:33 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Dec 2025 15:29:33 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 9 Dec
 2025 15:29:33 +0800
Message-ID: <09d66576-5d17-4a80-b41f-2f76a09d963b@huawei.com>
Date: Tue, 9 Dec 2025 15:29:32 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Urgent ACPI support fix for v6.18
To: "Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>
CC: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, <kprateek.nayak@amd.com>, <dhsrivas@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <lihuisong@huawei.com>
References: <CAJZ5v0g6c1HNbxxh088xh_nTgD-SE6c2qtDr81AgD1+by-jnKA@mail.gmail.com>
 <1ea445d0-0949-4a28-9f76-325861a3c57f@huawei.com>
 <7487e99d-421b-4ac5-bb77-e61c3131bb13@amd.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <7487e99d-421b-4ac5-bb77-e61c3131bb13@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)

在 2025/11/28 3:03, Longia, Amandeep Kaur 写道:
> Hi all,
>
> On 11/27/2025 7:39 AM, lihuisong (C) wrote:
>> Hello Rafael,
>>
>> 在 2025/11/26 20:54, Rafael J. Wysocki 写道:
>>> Hi Linus,
>>>
>>> Please pull from the tag
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>>>   acpi-6.18-rc8
>>>
>>> with top-most commit 43ff36c4a5a574ee83b4b0d3f3d74f09a3a8c2d3
>>>
>>>   Revert "ACPI: processor: idle: Optimize ACPI idle driver 
>>> registration"
>>>
>>> on top of commit ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
>>>
>>>   Linux 6.18-rc7
>>>
>>> to receive an urgent ACPI support fix for 6.18.
>>>
>>> This reverts a commit that attempted to make the code in the ACPI
>>> processor driver more straightforward, but it turned out to cause
>>> the kernel to crash on at least one system, along with some further
>>> cleanups on top of it.
>> I just found that "ACPI: processor: idle: Optimize ACPI idle driver 
>> registration" depends on the change
>> about cpuhp_setup_state in the commit [1]. Or many CPUs don't create 
>> cpuidle directory.
>> What is the crash? Do you have releated trace?
>>
>> [1] https://lore.kernel.org/all/20240529133446.28446-2- 
>> Jonathan.Cameron@huawei.com/
>
> We have observed the same issue. After booting the system with the 
> latest kernel, the sysfs path /sys/devices/system/cpu/cpu*/cpuidle 
> does not exist. Bisecting between v6.18-rc7 (good) and master (bad) 
> led us to the following commit:
>
> 43ff36c4a5a574ee83b4b0d3f3d74f09a3a8c2d3 Revert "ACPI: processor: 
> idle: Optimize ACPI idle driver registration"
>
>
Hello Amandeep,

I guess that your kernel doesn't have the following patch [1] if you 
also encountered this issue.

The __acpi_processor_start() of all CPUs are called when run 
driver_register(&acpi_processor_driver).
But acpi_processor_register_idle_driver() is called after 
driver_register(&acpi_processor_driver).
As a result, the acpi_processor_power_init() would not register cpuidle 
device and create these directory.

I tested it ok on my platform under the following modification.
Can you test it again using following modification based on kernel 
without revert any ACPI idle patch?
  I am looking forward to your reply. Thanks.
-->
diff --git a/drivers/acpi/processor_driver.c 
b/drivers/acpi/processor_driver.c
index 4b906b56186a..b56a2a228693 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -268,12 +268,12 @@ static int __init acpi_processor_driver_init(void)
                 acpi_processor_ignore_ppc_init();
         }

+       acpi_processor_register_idle_driver();
+
         result = driver_register(&acpi_processor_driver);
         if (result < 0)
                 return result;

-       acpi_processor_register_idle_driver();
-
         result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
                                            "acpi/cpu-drv:online",
                                            acpi_soft_cpu_online, NULL);
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 66d8df5a37a6..a34983abb0b9 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1404,6 +1404,7 @@ void acpi_processor_register_idle_driver(void)
                 if (!pr)
                         continue;

+               acpi_processor_cstate_first_run_checks();
                 ret = acpi_processor_get_power_info(pr);
                 if (!ret) {
                         pr->flags.power_setup_done = 1;

[1] 
https://lore.kernel.org/all/20240529133446.28446-2-Jonathan.Cameron@huawei.com/


