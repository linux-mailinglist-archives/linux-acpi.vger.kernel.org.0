Return-Path: <linux-acpi+bounces-17168-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F17B8EAF8
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 03:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A063BF6E7
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 01:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3091990A7;
	Mon, 22 Sep 2025 01:22:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF4A15A85A;
	Mon, 22 Sep 2025 01:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758504155; cv=none; b=D9G0JS7wpLowM1bOZZpRInfGl6/ZUfDJ7hYPfVdLP+09k2bvHpoDDM8VTMLGxwW02UC66/1nl5QB99FWv9dvU6J2qZVeTXAAKRUMqtdMlySTTWPBqJM3Mda3kxs9oVew+B0QlZAEfPYDVu/V4sY8a8LpVRppcThjJTMFRWlL+gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758504155; c=relaxed/simple;
	bh=XAamMMfkpbHGtCHKsLwo4FwJ/UlHpAaxwSrAHRb/jdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UeSRvCVpltZAgkwJk7S7ypwbwMxTTJYITO5Ej9ut8FlD5RKlIAfiZPGR4z0EwTi6teDtvalKysOHV2CcbvQypzaatjLDrdow2zwCB34G8LAe5s9Cgzm7CR4jbJeozlhUUUapE98AXxO1addOt1GYuZKSaRK4NhIUcJdXYb0+wf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cVQG23VpRzQkKs;
	Mon, 22 Sep 2025 09:17:46 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id B2A76140123;
	Mon, 22 Sep 2025 09:22:24 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 09:22:24 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Sep
 2025 09:22:23 +0800
Message-ID: <be080550-9480-4040-adc2-c438d7d407f4@huawei.com>
Date: Mon, 22 Sep 2025 09:22:22 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ACPI: processor: Do not expose the global
 acpi_idle_driver variable
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20250911112408.1668431-1-lihuisong@huawei.com>
 <20250911112408.1668431-4-lihuisong@huawei.com>
 <CAJZ5v0hb19Xy8dOP4itU-F5F7OjDXBVNGYiwoxAVc_yGuUv=Aw@mail.gmail.com>
 <1e55d104-9746-4b37-8663-12714cc00026@huawei.com>
 <CAJZ5v0hAYpBWTpfJV6ZVX0tLiZZ-S5ABxpmqckxYcPyMyZrJfA@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0hAYpBWTpfJV6ZVX0tLiZZ-S5ABxpmqckxYcPyMyZrJfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/9/19 5:22, Rafael J. Wysocki 写道:
> On Thu, Sep 18, 2025 at 2:23 PM lihuisong (C) <lihuisong@huawei.com> wrote:
>>
>> 在 2025/9/18 4:01, Rafael J. Wysocki 写道:
>>> On Thu, Sep 11, 2025 at 1:24 PM Huisong Li <lihuisong@huawei.com> wrote:
>>>> Currently, processor_driver just use the global acpi_idle_driver variable
>>>> to check if the cpuidle driver is acpi_idle_driver. Actually, there is no
>>>> need to expose this global variable defined in processor_idle.c to outside.
>>>> So move the related logical to acpi_processor_power_init() and do not
>>>> expose it.
>>> And it can also be made static, can't it?
>> ok, will do it in next version. Thanks.
> You may as well rebase it on top of this one:
>
> https://lore.kernel.org/linux-acpi/5044465.31r3eYUQgx@rafael.j.wysocki/

Ok, will will fix it based your patch.

Thank you for the reminder.

>

