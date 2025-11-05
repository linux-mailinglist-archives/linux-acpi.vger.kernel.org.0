Return-Path: <linux-acpi+bounces-18527-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DECCC349C7
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 09:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C981A1920E4F
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 08:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7312E5B08;
	Wed,  5 Nov 2025 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="NevCTVpm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631952E6106;
	Wed,  5 Nov 2025 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332831; cv=none; b=s0PNIIOvsLrtT0rivHfzRhX1LPsOeUJmtTU6OSLxNc0J7AdJ33D0FqNVwfR+XwqJe663szjTnGsX4uAoGlvTeHGLNxQRjq6NvKcC6NeWjJG854s2fLxc7uFe8bgvpoGI0dYiUzK0vLYBuAAkxXScOOQzRjiCM92bkBboqBQhzzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332831; c=relaxed/simple;
	bh=27uDWFrcHRepGKR7+qcQ2CU9wz23C65nVbpJ+KNWpVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i+GSapT9+VK15+IJXY+DKKpoBYYg/Gol3lhJItNqxwlnXWISmXpEhdU5Uq7VAgbXMAnoHqrs/6+OsiH3ZukDtj7GI3qYwhXOIWjjvK80HsrsD2Jb1Bvcu51t23CwlpESqaNBpDK07cNry9t4l7MUWRwhXZFJvJ1w5Ft2FkJydME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=NevCTVpm; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JW6a4KGLA/zueaP9v7VdlhKvHETXZnNM0ASKgsBEyBk=;
	b=NevCTVpmAuaXABqdmWswXwjT8L34OrWNW1FE+nJwuAWYljKEvq1BcJcZ/op0e/XgbXe51qrb3
	zqzpS8/qAr54ZrPxHZdh48g9vHIgsYvL5i3KVKAupJjsBUXFo8UotwGL8hXjh+Jdp/4ZIv9X+Vw
	OUUCyXZ7ND6/Lek8cF+B0vY=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4d1fFw088nzmV6w;
	Wed,  5 Nov 2025 16:52:04 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 6259C140156;
	Wed,  5 Nov 2025 16:53:39 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 16:53:39 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 16:53:31 +0800
Message-ID: <0140a714-a092-4bb8-af93-e3723fba20f1@huawei.com>
Date: Wed, 5 Nov 2025 16:53:30 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] ACPI: processor: idle: Mark the state as invalid
 if its entry method is illegal
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20251103084244.2654432-1-lihuisong@huawei.com>
 <20251103084244.2654432-2-lihuisong@huawei.com>
 <CAJZ5v0j5_+gOuuW8PdyzjOJ+Q__k9PrpM3X6=Q0d50u+d8SPpg@mail.gmail.com>
 <53a38563-1151-4e2d-8932-b5242c68bf62@huawei.com>
 <CAJZ5v0htRKzEhe3yWC52tnJnDBwH3U=ndWX+6ZjguhstuHcWhg@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0htRKzEhe3yWC52tnJnDBwH3U=ndWX+6ZjguhstuHcWhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/11/4 23:00, Rafael J. Wysocki 写道:
> On Tue, Nov 4, 2025 at 10:30 AM lihuisong (C) <lihuisong@huawei.com> wrote:
>>
>> 在 2025/11/4 1:49, Rafael J. Wysocki 写道:
>>> On Mon, Nov 3, 2025 at 9:42 AM Huisong Li <lihuisong@huawei.com> wrote:
>>>> According to ACPI spec, entry method in LPI sub-package must be buffer
>>>> or integer. And the entry method is very key in cpuidle. So mark the state
>>>> as invalid.
>>>>
>>>> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>> ---
>>>>    drivers/acpi/processor_idle.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>>>> index 341825e8ac63..9f1040eac051 100644
>>>> --- a/drivers/acpi/processor_idle.c
>>>> +++ b/drivers/acpi/processor_idle.c
>>>> @@ -956,6 +956,9 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
>>>>                           lpi_state->entry_method = ACPI_CSTATE_INTEGER;
>>>>                           lpi_state->address = obj->integer.value;
>>>>                   } else {
>>>> +                       pr_debug("Entry method of state-%d is illegal, disable it.\n",
>>>> +                                state_idx);
>>>> +                       lpi_state->flags = 0;
>>> Why does lpi_state->flags need to be cleared, isn't it 0 already?
>> Good point.
>> Do we need to add debug log?
> Well, is it helpful?
I think it is useful for developers.
They have a way to know why a state is disabled.
>

