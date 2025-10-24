Return-Path: <linux-acpi+bounces-18174-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2D7C05548
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 11:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2671B844C7
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 09:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F42630AAA6;
	Fri, 24 Oct 2025 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="F5MzrqH6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE203081D5;
	Fri, 24 Oct 2025 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298080; cv=none; b=sFiyPR78J4Z3QVjvqoRM6v7Fg3guRUYvJ6NTGUOiA2D6F9hh3W3aQNnZPI6PWffRaeigqln0gr+jjcZ/lNvSW+hNG8kQnDQgP4QtYW/1mHoFNX2ZSShHhOMIM8mWCPgrMx+PRPlKT+dIV2dmez8Vb8AdnLEIU2URlHyeComhsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298080; c=relaxed/simple;
	bh=D9CriblZZV8E4ij+hTgV3LihvuP1miWRj90SkmgMp3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cPRJhccZkTLgkxmXn2H0iUIJ3swCWO/5jmwJRiio6pGK1TGCDZ9wCLkB4KXe/Ns0B7RNCqbGbIcpI3Uxb1/6yS1i6sofdvGswl6m9c2KCu6vkqARj6RDFUGCc99fu6htNmu8J96BgK6uAS2vSMaPgsz0lEgHuUmv5kWf2qM5Bv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=F5MzrqH6; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EsaRtWNkL2CQ58jHxlDEoSGIutTPbiMQ7SS5QkptSXc=;
	b=F5MzrqH6Hw9KyMKRYK+I66n2dOAS4ZrWqVKnUtK3EBdb2q3fF5EM9JJF1s8d9hBQZGWWmu4V5
	lIQwcDvvhsWYtQzYSCiU4x2nOOofnsibhPGaNzaJt/rM/qXYrvKxDzNA4xD+QUp6O/qeBaFxtQa
	H48mtdJnh4ICZXJv1bSOo2g=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4ctHcJ5G53z1prQm;
	Fri, 24 Oct 2025 17:27:28 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id EBBB81401F3;
	Fri, 24 Oct 2025 17:27:54 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Oct 2025 17:27:54 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 17:27:54 +0800
Message-ID: <3f081072-4ed1-439f-b4a9-b86728a51b7d@huawei.com>
Date: Fri, 24 Oct 2025 17:27:53 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] ACPI: processor: idle: Return failure when get
 lpi_state->arch_flags failed
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-4-lihuisong@huawei.com>
 <CAJZ5v0hNj817g=rr8+YTGaeBkkfNuuU7FGuZyyb1j61BMOKTGA@mail.gmail.com>
 <5caae4ef-e259-47cc-b0b7-f383dce4a334@huawei.com>
 <CAJZ5v0ivydYPk8yxEUdXJe=uATq_1=__J560v3VApcXAv=f_7Q@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0ivydYPk8yxEUdXJe=uATq_1=__J560v3VApcXAv=f_7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/23 18:09, Rafael J. Wysocki 写道:
> On Thu, Oct 23, 2025 at 11:59 AM lihuisong (C) <lihuisong@huawei.com> wrote:
>>
>> 在 2025/10/22 3:36, Rafael J. Wysocki 写道:
>>> On Mon, Sep 29, 2025 at 11:38 AM Huisong Li <lihuisong@huawei.com> wrote:
>>>> The architecture specific context loss flags is important for ARM.
>>>> And this flag is used to control the execution of different code
>>>> flows in acpi_processor_ffh_lpi_enter().
>>>>
>>>> So it is better to return failure when get lpi_state->arch_flags
>>>> failed.
>>> A failure means no idle states at all.
>> Actually, I didn't know why driver should continue to do cpu idle
>> scaling if the idle state doesn't meet the developer's expectations.🙂
> There may be a firmware bug in one state description, but it doesn't
> mean that the other states are unusable, does it?
Ack
>
>>> Wouldn't it be better to skip the state with invalid arch flags?
>> This arch flags is important.  And acpi_processor_ffh_lpi_enter will use it.
>> There is no other place to verify its validity. so here do it.
>> This check is just to prevent potential issues in cpuidle scaling later.
> I'm saying to treat this particular state as invalid and skip it
> without rejecting all of the other states that may be valid.

Ok, handle this case the same as illegal entry method in patch 2/9 if it 
is ok to you.


