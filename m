Return-Path: <linux-acpi+bounces-9431-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A869C14DE
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 04:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24BE1C20B55
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 03:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF953209;
	Fri,  8 Nov 2024 03:52:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01112629F
	for <linux-acpi@vger.kernel.org>; Fri,  8 Nov 2024 03:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731037964; cv=none; b=cSfV9LBkfMVfZz1NVHyIuk/z6nAd7PedPsqNGvfowfTRhQ85mSa3g1v0dLZv851kOq2/s/ADAnqPpG+SiedB/5XFOS60mH1bapcO8DSJlcVd6/gAN4acHIeRaet2pRkr7tfMTqEv7CbkqewE2h8ew+Gwv4bscX2jumop3DMPu8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731037964; c=relaxed/simple;
	bh=j10V0rJkb/vClAIQKMwTH5WKDOsf4MscTdjLaSr+pQ8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sPrqvg8GJJt/1AlhvHwp9dCUM4GszRAlxoqCRXf9rUMbFAkpEvE/fwXKAotiOYNQqMdt0234w83WzgHum5C2HAbjSmEhepTZ3V7R/UPff1FA8yMKYZJiF4bVbH/TG26e566eFJFrJUVVRlbzEFYveFM6SLTbO7wy9ymjwPTGMxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Xl4lc1hH7z1ynvJ;
	Fri,  8 Nov 2024 11:52:44 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id C3224140138;
	Fri,  8 Nov 2024 11:52:33 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Nov 2024 11:52:33 +0800
Subject: Re: [PATCH] acpi/arm64: Adjust error handling procedure in
 gtdt_parse_timer_block()
To: Sudeep Holla <sudeep.holla@arm.com>, Aleksandr Mishin <amishin@t-argos.ru>
CC: Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Will
 Deacon <will@kernel.org>
References: <20240827101239.22020-1-amishin@t-argos.ru>
 <ZtCfKEIfJW7X8UWg@bogus> <ZtCgyuQ4IRr9Mx8x@bogus>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <9d53d1f4-1f65-be5e-f68d-18799080a2e5@huawei.com>
Date: Fri, 8 Nov 2024 11:52:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZtCgyuQ4IRr9Mx8x@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

+Cc Catalin and Will

On 2024/8/30 0:24, Sudeep Holla wrote:
> On Thu, Aug 29, 2024 at 05:17:44PM +0100, Sudeep Holla wrote:
>> On Tue, Aug 27, 2024 at 01:12:39PM +0300, Aleksandr Mishin wrote:
>>> In case of error in gtdt_parse_timer_block() invalid 'gtdt_frame'
>>> will be used in 'do {} while (i-- >= 0 && gtdt_frame--);' statement block
>>> because do{} block will be executed even if 'i == 0'.
>>>
>>> Adjust error handling procedure by replacing 'i-- >= 0' with 'i-- > 0'.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>
>> (For some reason I don't see the original email in my inbox, might have
>> got blocked 🙁). Anyways LGTM,
>>
>> Acked-by: Aleksandr Mishin <amishin@t-argos.ru>
> 
> Sorry I messed up, I meant
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Catalin, this is a fix, and was acked by Sudeep and me, could you
merge it for next release cycle?

Thanks
Hanjun

