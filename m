Return-Path: <linux-acpi+bounces-18133-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 792D6C003D6
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 11:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C0104E2BD3
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 09:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B287E302149;
	Thu, 23 Oct 2025 09:28:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1A327B4F7;
	Thu, 23 Oct 2025 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211681; cv=none; b=DucgOk2o9kD97Dtj3SFrc1E9xijSDNhq30c9bp9BLa+fFRtj3Ud+gegOnlqDLywQ8hRmy85L/ZCKaaEXz+6zyXW5jPxP4SeqShn4JlTe0m0WRwmWVt1OhvQtjLUFMBHuB5eRYsmJUzRFRzS5wqBJ0K2p+VEP9KzrasUL+0VHPT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211681; c=relaxed/simple;
	bh=OhWnH2hi1c2eRf012mL/hJqHRglQrxYLUPSY1uqGB6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nkWrp7FfYRUGAWWSG7zdek1JrESNqa552c0dGhkbuibJj/UBh5757gJAWJRRpr4+kEyu/Z41SHGYQZI0CH3RnSvp0bLH5jpEzzo84YhrhXeZwfwanmzWZzOgSPyJ16BhLapFFuXcDZ1aX5Xl5cr3suZkXleZmiP02ai0Lkx8VdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4csgJ32Jqtz11Wsc;
	Thu, 23 Oct 2025 17:11:15 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 09D1E14011B;
	Thu, 23 Oct 2025 17:09:59 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Oct 2025 17:09:58 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 17:09:58 +0800
Message-ID: <32d9ae29-55e9-4102-afbe-f34c20a19a02@huawei.com>
Date: Thu, 23 Oct 2025 17:09:54 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] ACPI: processor: idle: raise up log level when
 evaluate LPI failed
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-2-lihuisong@huawei.com>
 <CAJZ5v0gFdmFhDxoX8HNHf5h+-L4XV=3TZZx_L1u3H7A=4bEzUA@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0gFdmFhDxoX8HNHf5h+-L4XV=3TZZx_L1u3H7A=4bEzUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/22 3:29, Rafael J. Wysocki 写道:
> On Mon, Sep 29, 2025 at 11:38 AM Huisong Li <lihuisong@huawei.com> wrote:
>> According to ACPI spec, LPI package must be ACPI_TYPE_PACKAGE and
>> the count of package must be greater than 4. And the count contained
>> in package needs to be equal to the value of count field in LPI package.
>> All are illegal and return failure. It is better for these verification
>> to use error level log instead of debug so as to get detailed logs directly
>> when initialization fails.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/processor_idle.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 22b051b94a86..5acf12a0441f 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -908,7 +908,7 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
>>          /* There must be at least 4 elements = 3 elements + 1 package */
>>          if (!lpi_data || lpi_data->type != ACPI_TYPE_PACKAGE ||
>>              lpi_data->package.count < 4) {
>> -               pr_debug("not enough elements in _LPI\n");
>> +               pr_err("not enough elements in _LPI\n");
>>                  ret = -ENODATA;
>>                  goto end;
>>          }
>> @@ -917,7 +917,7 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
>>
>>          /* Validate number of power states. */
>>          if (pkg_count < 1 || pkg_count != lpi_data->package.count - 3) {
>> -               pr_debug("count given by _LPI is not valid\n");
>> +               pr_err("count given by _LPI is not valid\n");
>>                  ret = -ENODATA;
>>                  goto end;
>>          }
>> --
> They are pr_debug() on purpose because they are not useful to anyone
> other than the people who work on _LPI implementations in firmware or
> debug firmware issues.  They do not indicate kernel functional issues
> in particular.
ok, get this purpose. Thanks.

