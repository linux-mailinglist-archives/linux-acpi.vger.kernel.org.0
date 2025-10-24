Return-Path: <linux-acpi+bounces-18175-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958B7C05647
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 11:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DD43A5448
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057A030BB96;
	Fri, 24 Oct 2025 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="fyuTfiXE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546E30B50F;
	Fri, 24 Oct 2025 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298854; cv=none; b=M6R+WYCR/5LnvEEEjhJS20K44d7aL6V/FcsT0zMzdozHf7EK/NSTpxsfb1yqvWBmvRmKkC8XCiW69MzDqy2m+dxrc8X0fIJQagEG5GG9psTfxSTYHTUIityO1GiPCOHICZ1fBKeUttGrqPVesQ4/mXMbP9m0Lo0ZBiqvR2dhv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298854; c=relaxed/simple;
	bh=DGayQpkhZPLa/s8gxbji4hsifpgUxhD4Bp14VrHlQKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qw+FZDRMmIPU4bLrTyiSndoT3vB0GpcB0yjcY/EGp8S8EW71/vEuqEAI9A4DCAZHSdybOiHpV06NHSRawh8kSirlCDXdZqwJvo2w1aGji8wY92Gc0Ss5WhwUO1MI3yNw7w81FvOrFFo0tGW5xt56PENMhcEnL4NmGqtyyDagxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=fyuTfiXE; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7RqplOmmQP4YUVxtX/HZJ9cHI6vtBIamIcDg6K2HqXY=;
	b=fyuTfiXEhDlikiz6oKbneJzJhcBL+N2c2mJSTrahShA+QP4dhFfnefjGO3k5TDZHuV5y3dPlB
	APo7isnF672GvOFzRqwY6Zw2xeY08x9zOkZ6cuk/BJYBedBlauPodxLDAA4KX7rmhyeG0gsIBK2
	AXcm2Uwy2SGKl2/fUuDBPog=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4ctHtT4dz0z1T4Fg;
	Fri, 24 Oct 2025 17:39:45 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 98CCB18006C;
	Fri, 24 Oct 2025 17:40:42 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Oct 2025 17:40:42 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 17:40:41 +0800
Message-ID: <ab814879-37d6-49dc-8a38-6b94cabf9327@huawei.com>
Date: Fri, 24 Oct 2025 17:40:41 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] ACPI: processor: idle: Add the verification of
 processor FFH LPI state
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-6-lihuisong@huawei.com>
 <CAJZ5v0iLt7rnXBaTBv=-ztKro39h1hECQS_Ov9Cn1eBcfhXDaQ@mail.gmail.com>
 <92b1b431-9855-43fb-8bb3-801649064438@huawei.com>
 <CAJZ5v0g0PgicTEAb3gAeF2D3ZqONNt+6odt2SfGE7XtY3zoPyg@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0g0PgicTEAb3gAeF2D3ZqONNt+6odt2SfGE7XtY3zoPyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/23 18:35, Rafael J. Wysocki 写道:
> On Thu, Oct 23, 2025 at 12:17 PM lihuisong (C) <lihuisong@huawei.com> wrote:
>>
>> 在 2025/10/22 3:42, Rafael J. Wysocki 写道:
>>> On Mon, Sep 29, 2025 at 11:38 AM Huisong Li <lihuisong@huawei.com> wrote:
>>>> Both ARM64 and RISCV architecture would validate Entry Method of LPI
>>>> state and SBI HSM or PSCI cpu suspend. Driver should return failure
>>>> if FFH of LPI state are not ok.
>>> First of all, I cannot parse this changelog, so I don't know the
>>> motivation for the change.
>> Sorry for your confusion.
>>> Second, if _LPI is ever used on x86, the
>>> acpi_processor_ffh_lpi_probe() in acpi_processor_get_power_info() will
>>> get in the way.
>> AFAICS, it's also ok if X86 platform use LPI.
> No, because it returns an error by default as it stands today.
>
>>> Why does the evaluation in acpi_processor_setup_cpuidle_dev() not work?
>> The acpi_processor_ffh_lpi_probe does verify the validity of LPI for ARM
>> and RISCV.
>> But the caller of the acpi_processor_setup_cpuidle_dev()don't verify the
>> return value.
>> In addition, from the name of acpi_processor_setup_cpuidle_dev(), its
>> main purpose is to setup cpudile device rather than to verify LPI.
> That's fair enough.
>
> Also, the list of idle states belongs to the cpuidle driver, not to a
> cpuidle device.
>
>> So I move it to a more prominent position and redefine the
>> acpi_processor_setup_cpuidle_dev to void in patch 9/9.
>>>> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>> ---
>>>>    drivers/acpi/processor_idle.c | 10 ++++++++--
>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>>>> index 5684925338b3..b0d6b51ee363 100644
>>>> --- a/drivers/acpi/processor_idle.c
>>>> +++ b/drivers/acpi/processor_idle.c
>>>> @@ -1264,7 +1264,7 @@ static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
>>>>
>>>>           dev->cpu = pr->id;
>>>>           if (pr->flags.has_lpi)
>>>> -               return acpi_processor_ffh_lpi_probe(pr->id);
>>>> +               return 0;
>>>>
>>>>           return acpi_processor_setup_cpuidle_cx(pr, dev);
>>>>    }
>>>> @@ -1275,7 +1275,13 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
>>>>
>>>>           ret = acpi_processor_get_lpi_info(pr);
>>>>           if (ret)
> So I think it would be better to check it here, that is
>
> if (!ret) {
>         ret = acpi_processor_ffh_lpi_probe(pr->id));
>         if (!ret)
>                 return 0;
>
>         pr_info("CPU%d: FFH LPI state is invalid\n", pr->id);
>         pr->flags.has_lpi = 0;
> }
>
> return acpi_processor_get_cstate_info(pr);
>
> And the default acpi_processor_ffh_lpi_probe() needs to be changed to return 0.
Sorry, I don't understand why pr->flags.has_lpi is true if 
acpi_processor_ffh_lpi_probe() return failure.
In addition, X86 platform doesn't define acpi_processor_ffh_lpi_probe(). 
this function will return EOPNOTSUPP.
>
>>>> -               ret = acpi_processor_get_cstate_info(pr);
>>>> +               return acpi_processor_get_cstate_info(pr);
>>>> +
>>>> +       if (pr->flags.has_lpi) {
>>>> +               ret = acpi_processor_ffh_lpi_probe(pr->id);
>>>> +               if (ret)
>>>> +                       pr_err("Processor FFH LPI state is invalid.\n");
>>>> +       }
>>>>
>>>>           return ret;
>>>>    }
>>>> --

