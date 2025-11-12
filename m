Return-Path: <linux-acpi+bounces-18814-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFF3C539C2
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 18:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A490E500F98
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 16:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0831933F39A;
	Wed, 12 Nov 2025 16:49:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C5C2D130C;
	Wed, 12 Nov 2025 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966144; cv=none; b=r/Ym7fwG1Z7tawQ3VaaoWE8OUtWyorMaJkdMTqoZVY+XcGGqns0wIWULPzBzTgj5vdxotDC2f/mQqpwI9D4vOj9Mh8kL6VbvV0wdjB8G0MtjU/Tg/P2RyGkTVt05wSgODKzoiWUJsHWf8IqAw7ZoVfHBbyDAR3vVUeJ82Twldfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966144; c=relaxed/simple;
	bh=DCABuo/lM5b9CfFj5tLkGlhYnZKy/VPRvWllwjqP8rA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eGTbjyOPec85+qGhprliRJ3FpKIUMmFvY0oOSoJK4FjsrHj31QhBlPyyX65QFBhwljjdLagj3o3lDQJ5reNNW9Ma7+6qhPyAGlaxS/55q7SBXi5VMB3/PaYoQIhQi1oaHStiT3tdkjj/9sn31qswxaj7bcvgP+ARbZIJ1gqNiNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCC38497;
	Wed, 12 Nov 2025 08:48:53 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B08343F63F;
	Wed, 12 Nov 2025 08:48:56 -0800 (PST)
Message-ID: <365d8625-17fc-41f1-b7ab-d7ef3ab06b92@arm.com>
Date: Wed, 12 Nov 2025 16:48:55 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/33] arm_mpam: Add the class and component structures
 for firmware described ris
From: Ben Horgan <ben.horgan@arm.com>
To: Gavin Shan <gshan@redhat.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-12-ben.horgan@arm.com>
 <2c81664f-45c0-43e4-91e9-79d0c84376b6@redhat.com>
 <3350b73e-1021-4091-87f1-4b946da22f4e@arm.com>
Content-Language: en-US
In-Reply-To: <3350b73e-1021-4091-87f1-4b946da22f4e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gavin,

I was a bit hasty on one of those changes.

On 11/12/25 16:39, Ben Horgan wrote:
> Hi Gavin,
> 
> On 11/9/25 00:07, Gavin Shan wrote:
>> Hi Ben,
>>
>> On 11/7/25 10:34 PM, Ben Horgan wrote:
>>> From: James Morse <james.morse@arm.com>
>>>
>>> An MSC is a container of resources, each identified by their RIS index.
>>> Some RIS are described by firmware to provide their position in the
>>> system.
>>> Others are discovered when the driver probes the hardware.
>>>
>>> To configure a resource it needs to be found by its class, e.g. 'L2'.
>>> There are two kinds of grouping, a class is a set of components, which
>>> are visible to user-space as there are likely to be multiple instances
>>> of the L2 cache. (e.g. one per cluster or package)
>>>
>>> Add support for creating and destroying structures to allow a hierarchy
>>> of resources to be created.
>>>
>>> CC: Ben Horgan <ben.horgan@arm.com>
>>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>>> Tested-by: Peter Newman <peternewman@google.com>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

>> This function is only used in mpam_devices.c and won't be exposed in the
>> future, we can make it 'static' and 'inline'.
> 
> Done

Gets used later in mpam_resctl.c so I'll keep as is.

Thanks,

Ben


