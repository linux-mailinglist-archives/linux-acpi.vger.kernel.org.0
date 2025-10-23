Return-Path: <linux-acpi+bounces-18134-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DE2C00541
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 11:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94ACB4FB01F
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353EC3093AD;
	Thu, 23 Oct 2025 09:42:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A4E2E040E;
	Thu, 23 Oct 2025 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212532; cv=none; b=ecaSdUL/49tjUzKF8RiUVl4cWGsRItmPD2VHMXQ/8tM4JfPHEGmTqJs7EpUIFXF3XjW9BHFjSIqCqPwxhbHz+DYqh0lTLfnfwfodazgKPCUphRyp8Z0vnXWl1E/BmPXmbpRTSC/5/5FcPb76sC6fp9aCowRAQT0GxWgSbUvfAhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212532; c=relaxed/simple;
	bh=XkrnJYea9B1sj1bHt99yR2CrbCN5vQSI+UvKg+XFAHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Urkwym1QfWcOwDyIMrzccnj6oE/fXjUQUW9akVbvZx7Swmt9LQpbos0d7xVeKgtDxU6n09owOXG8z5wPuA5Auk8XRHRxoGw4iVLYcO4CA8q0h12I0/F1m1v7h02u6aivL0Rsy5AWK6FC8rS2qoknao8qdoEIz9gwRTRPoko6A+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4csgWF3jkxz24jJn;
	Thu, 23 Oct 2025 17:20:57 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7787814011B;
	Thu, 23 Oct 2025 17:25:08 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Oct 2025 17:25:08 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 17:25:07 +0800
Message-ID: <8c0057a7-24a2-493a-8054-904a89ca9f6d@huawei.com>
Date: Thu, 23 Oct 2025 17:25:07 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] ACPI: processor: idle: Return failure if entry
 method is not buffer or integer type
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-3-lihuisong@huawei.com>
 <CAJZ5v0ikPpwKA4WLvwon3p+e8+53fOQuudOioOr-KD-Ee-E0dA@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0ikPpwKA4WLvwon3p+e8+53fOQuudOioOr-KD-Ee-E0dA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/22 3:34, Rafael J. Wysocki 写道:
> On Mon, Sep 29, 2025 at 11:38 AM Huisong Li <lihuisong@huawei.com> wrote:
>> According to ACPI spec, entry method in LPI sub-package must be buffer
>> or integer. However, acpi_processor_evaluate_lpi() regeards it as success
>> and treat it as an effective LPI state.
> Is that the case?  AFAICS, it just gets to the next state in this case
> and what's wrong with that?
The flatten_lpi_states() would consider the state with illegal entry 
method sub-package as a valid one
if the flag of this state is enabled(ACPI_LPI_STATE_FLAGS_ENABLED is set).
And then cpuidle governor would use it because the caller of 
acpi_processor_ffh_lpi_probe() also don't see the return value.
>
>> This is unreasonable and needs to
>> return failure to prevent other problems from occurring.
>>
>> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/processor_idle.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 5acf12a0441f..681587f2614b 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -958,7 +958,9 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
>>                          lpi_state->entry_method = ACPI_CSTATE_INTEGER;
>>                          lpi_state->address = obj->integer.value;
>>                  } else {
>> -                       continue;
>> +                       pr_err("Entry method in LPI sub-package must be buffer or integer.\n");
>> +                       ret = -EINVAL;
>> +                       goto end;
>>                  }
>>
>>                  /* elements[7,8] skipped for now i.e. Residency/Usage counter*/
>> --

