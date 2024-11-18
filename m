Return-Path: <linux-acpi+bounces-9625-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4429D0793
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 02:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D563CB216BB
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 01:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AD41946B;
	Mon, 18 Nov 2024 01:29:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013F817BA3;
	Mon, 18 Nov 2024 01:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731893394; cv=none; b=HHa2K9b/w2C0cp2I3ut7kcDjlhK/aiVc5dQgJE8qQb0N0sX+YdizfriwjL1XWYE+w+lrtrLt7WiixtlfS2SjvkopoxPSyAa9pxbJ99f5lD2P2Enwmrtk+XaYtdh5qjrPOe5T7UCp7GXzg0HEs4xKK9VF8C/C8vAuW7eucJWAmt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731893394; c=relaxed/simple;
	bh=lM9XoLTlH4w7aBEstkNtGMfmVvVr+vxFBznR54ornks=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BJtIqxzeVeUxaeTZ1EZ6jKFh78/8POUOzD5um2mkc90WKMMJE/cbI+hqUPfKsVFv/pm7Q0hnV/Fl6RmjonGY093jbFRG0UtYkq8Lr/UPXi2ADmA02la7fjcvF1yXO5Cm/igWCdsWVeRt8F0Xr02yPtlZ0CmmzU4HdNPJ5YBMg1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xs93019Fwz10Rt3;
	Mon, 18 Nov 2024 09:27:08 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 93C8F1403A0;
	Mon, 18 Nov 2024 09:29:43 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 09:29:43 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Nov
 2024 09:29:42 +0800
Message-ID: <ee3f6294-dc62-11d2-9467-53fd9241a922@huawei.com>
Date: Mon, 18 Nov 2024 09:29:42 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] ACPI: thermal: Support for linking devices associated
 with the thermal zone
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
	<liuyonglong@huawei.com>, <zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>
References: <20241113085634.7657-1-lihuisong@huawei.com>
 <CAJZ5v0jTMg=Wipt2VPU1DDnnO7Rh5pu0VYvUjHRW5Nada--O8A@mail.gmail.com>
 <52539572-6128-8c87-84e6-3f539d887b34@huawei.com>
 <CAJZ5v0heL_wa=bimMDijn-x6G0SxsMf=yGhKZAe282P5+h2O3w@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0heL_wa=bimMDijn-x6G0SxsMf=yGhKZAe282P5+h2O3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2024/11/14 19:53, Rafael J. Wysocki 写道:
> Hi,
>
> On Thu, Nov 14, 2024 at 9:37 AM lihuisong (C) <lihuisong@huawei.com> wrote:
>> Hi Rafael,
>>
>> 在 2024/11/13 17:26, Rafael J. Wysocki 写道:
>>> On Wed, Nov 13, 2024 at 10:07 AM Huisong Li <lihuisong@huawei.com> wrote:
>>>> There are many 'cdevX' files which link cooling devices under
>>>> '/sys/class/thermal/thermal_zoneX/'. These devices contain active cooling
>>>> devices and passive cooling devices. And user cann't directly know which
>>>> devices temperature is represented by the thermal zone.
>>>>
>>>> However, ACPI spec provides a '_TZD' object which evaluates to a package
>>>> of device names. Each name corresponds to a device in the ACPI namespace
>>>> that is associated with the thermal zone. The temperature reported by the
>>>> thermal zone is roughly correspondent to that of each of the devices.
>>>>
>>>> User can get all devices a thermal zone measured by the 'measures'
>>>> directory under the thermal zone device.
>>> Well, that's kind of clear, but what exactly is the use case?  Why
>>> does the user need to know that?
>> IMO, this makes thermal zone information more friendly.
>> For instance, user can directly know the temperature of CPUs or other
>> devices is roughly represented by which thermal zone.
>> This may offer the convenience for further usersapce application.
>>
>> BTW, the '_TZD' method is similar to the '_PMD' in acpi power meter.
>> Since ACPI spec provides them, they should also have a role in their
>> existence.
> So there is no specific use case, but it is possible that somebody may
> want to use this information, IIUC.
>
> Well, let's defer making kernel changes until there is a user
> wanting/needing this information.  Then we'll decide how to expose it.
>
> For one, I'm not convinced that exposing it under the ACPI
> representation of a thermal zone is going to be really useful.
All right. Thanks for your review.
>
> .

