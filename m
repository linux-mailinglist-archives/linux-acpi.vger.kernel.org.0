Return-Path: <linux-acpi+bounces-18482-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7211C3044D
	for <lists+linux-acpi@lfdr.de>; Tue, 04 Nov 2025 10:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37ECB34CF87
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Nov 2025 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4390F28C87C;
	Tue,  4 Nov 2025 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="hmSDJsJ/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC9B1B87C0;
	Tue,  4 Nov 2025 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248657; cv=none; b=cpmDOLrM+CVuSR0rrpQ7xiJHMPuWmS0HP1Nwc4vbU/+8yNPIn/KGtWWnD2q/aPkDMjJHryZ9F2sd+TcFJ7ctsD55d5L03P3ZXb0WvWpwfteajRmmryUFrGViKj6uDYKg33Z3q8FuJGjwC4KBlaTN20XEcplGUD40GBze3ykpmRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248657; c=relaxed/simple;
	bh=y5IE2z0bh7a+V1TKaw55c+sRi7cS6OOkVVs3enJ9s9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pBXecxVQojx/nerW0xI8XOkZcqPLbKP6kZNINIKUU7u1wG2lX20osAW9AO8meJ8VB0Dx8stRiwPaDuLtVsHPnFpzxO1+Mf4wYrBboGjdWFEOZ7aBYiGTj9qhm1jT1+4Y43eaPYy9v5qj5wdCbYys2+Inem32XPX3U45peqDsbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=hmSDJsJ/; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Es9bGyJrosDWdP55MX2T4q0zyC4k+N2oaH9yrCMdDlU=;
	b=hmSDJsJ/ssugUDNaoNURqe9ZEcn7it6KYIK6sQUnaRSD7Vcjcga7257plhuEmZqDywqX1/oiN
	yqt2QCJfLkIniF6ERCjnxNYW7NFJh6zhcDVK+wvNtkANw/W90XmPDU/Pn0qg19krlTv760urKlh
	TwCA3D+cNa15O7MBb7I6mqg=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4d137F03slz1K98d;
	Tue,  4 Nov 2025 17:29:13 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id E21311402CC;
	Tue,  4 Nov 2025 17:30:45 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 17:30:45 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 17:30:45 +0800
Message-ID: <53a38563-1151-4e2d-8932-b5242c68bf62@huawei.com>
Date: Tue, 4 Nov 2025 17:30:44 +0800
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
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0j5_+gOuuW8PdyzjOJ+Q__k9PrpM3X6=Q0d50u+d8SPpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/11/4 1:49, Rafael J. Wysocki 写道:
> On Mon, Nov 3, 2025 at 9:42 AM Huisong Li <lihuisong@huawei.com> wrote:
>> According to ACPI spec, entry method in LPI sub-package must be buffer
>> or integer. And the entry method is very key in cpuidle. So mark the state
>> as invalid.
>>
>> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/processor_idle.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 341825e8ac63..9f1040eac051 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -956,6 +956,9 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
>>                          lpi_state->entry_method = ACPI_CSTATE_INTEGER;
>>                          lpi_state->address = obj->integer.value;
>>                  } else {
>> +                       pr_debug("Entry method of state-%d is illegal, disable it.\n",
>> +                                state_idx);
>> +                       lpi_state->flags = 0;
> Why does lpi_state->flags need to be cleared, isn't it 0 already?
Good point.
Do we need to add debug log?
>
>>                          continue;
>>                  }
>>
>> --

