Return-Path: <linux-acpi+bounces-18173-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF11C0550C
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 11:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 322A34E74C5
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 09:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282E9307AE0;
	Fri, 24 Oct 2025 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="ECaKH57k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228F22A817;
	Fri, 24 Oct 2025 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297949; cv=none; b=lkHWULBftplz3CLVVAi+HjjZ+fgsdzmljEnnQ5XXQVQzRck0dW00uqM3B72y82YZXIcaQlw1fY3r4qSk4YkRkse5K2RHHOn5iCImvQSDqDkSBP0DOohAbPTNztBMgoO74KVPwkhEoVw+qhrIhBHtKfbmO2Jkt+Ew6aNLnR9hQEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297949; c=relaxed/simple;
	bh=lxWTjGJqQQYFFcrn21A9F9jgFj7I+CDowNz3ZTvqCYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FNrDyXeOKmQInslckISpLZp+87D85HP9FVq+tJLYL6ULbA0CWUpWZVf0wWi/svvHnYIIg3UQ2ya116FzGh+mSxRVfOxogigzsY9DiMObwRw9ECWf9TxNJh0zpfNPuTvCOtQ4b7NDskWAiUHoQLZQe6RW4svD+cz1bKADGrSiUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=ECaKH57k; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fdAIjFY0hBlFnhs8gVq2fOXVlMAYZaseUdjZC/wG1nQ=;
	b=ECaKH57krHoxbICVrCii4/Oty4TVvj6bJl2lCTfVfs0HfpubtueUBRFzj9zxQrArQ+7HAu4d5
	Xbm5NIK/mHwffs552xTgbFPh/0c3Cn6QVMNzCbDxlPgy0gtMyUnpyk+HwXjCtzuuf4PiFI8vXvr
	2Bjcyt9ImrQb0MYAq84z7FQ=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4ctHYf6s0Pz1prQ0;
	Fri, 24 Oct 2025 17:25:10 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C86318006C;
	Fri, 24 Oct 2025 17:25:37 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Oct 2025 17:25:36 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 17:25:36 +0800
Message-ID: <a577bfd3-a4b8-4d06-b95b-a78b2916b8a4@huawei.com>
Date: Fri, 24 Oct 2025 17:25:35 +0800
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
 <8c0057a7-24a2-493a-8054-904a89ca9f6d@huawei.com>
 <CAJZ5v0jg5RGi-+i3LtwK6U8m+_C5Rs4OuRTBLTGi6g0aRq3LBQ@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0jg5RGi-+i3LtwK6U8m+_C5Rs4OuRTBLTGi6g0aRq3LBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/23 18:07, Rafael J. Wysocki 写道:
> On Thu, Oct 23, 2025 at 11:25 AM lihuisong (C) <lihuisong@huawei.com> wrote:
>>
>> 在 2025/10/22 3:34, Rafael J. Wysocki 写道:
>>> On Mon, Sep 29, 2025 at 11:38 AM Huisong Li <lihuisong@huawei.com> wrote:
>>>> According to ACPI spec, entry method in LPI sub-package must be buffer
>>>> or integer. However, acpi_processor_evaluate_lpi() regeards it as success
>>>> and treat it as an effective LPI state.
>>> Is that the case?  AFAICS, it just gets to the next state in this case
>>> and what's wrong with that?
>> The flatten_lpi_states() would consider the state with illegal entry
>> method sub-package as a valid one
>> if the flag of this state is enabled(ACPI_LPI_STATE_FLAGS_ENABLED is set).
>> And then cpuidle governor would use it because the caller of
>> acpi_processor_ffh_lpi_probe() also don't see the return value.
> So the problem appears to be that lpi_state increments in every step
> of the loop, but it should only increment if the given state is valid.
Yes,
So set the flag of the state with illegal entry method sub-package to 
zero so that this invalid LPI state will be skiped in 
flatten_lpi_states(), ok?

