Return-Path: <linux-acpi+bounces-18066-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FF7BF9AC9
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 04:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDE94280F5
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 02:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92651DE4CD;
	Wed, 22 Oct 2025 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QAm0pNqq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322231885A5;
	Wed, 22 Oct 2025 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761098908; cv=none; b=QhJDZDbMZtc1yL3fQXPNMSpJle/uKbTMW0wegEzwhe7yB9foO8xTEtSLDRdPVvBDVhilBHBoryyB+0vNdo7w4xDlBdaVK/15x0dR83nQ/d0kW4FzZ2V8N8ozRmvfONbqPxqb9pmCdCvevHRRyDK+UDFghGPyh4GS/TtcsZZhKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761098908; c=relaxed/simple;
	bh=i1/nDNEFVbEfImwpNCS2ynzRyOgKxIt3gfOTAj4NK6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kyg81o1A6MPKJCpZRZGkGvQlhS1gS2PC6ApVyxq8L2nA8Ah2OMh1lJgTdMoL3wIOOC8LG3dvdtutoVWAutywjxARo/T55wt/cDeozsKdV1VcDaNNaESbRwnUJu9Yh2d0PUrzMMnWARHU9DReQACnEXayscxqucm1eIxMQE1u9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QAm0pNqq; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761098897; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VZDctKiGHUM0XAo9DQHO2fuaaGzjYL24hYPkTKDpZyA=;
	b=QAm0pNqq/awHAh1kVUW5etagLZOdINQDvNjolQALbtiLhKTLwy0QlVOQYy3OBfzCZ23cATWl5hEFN3an2sHecOpKcM6dhjucUwz9mEOUfwrKYhQo2bdKgWg97Cw47N7EJJiAH13UptV2gGWLVNHlIlhYbTtRQYYFjVaNYqPlvSA=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqkiZLE_1761098895 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 10:08:16 +0800
Message-ID: <d99a7a1e-f0ba-4bad-8bc6-c31e05187d4d@linux.alibaba.com>
Date: Wed, 22 Oct 2025 10:08:15 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] acpi,srat: Fix incorrect device handle check for
 Generic Initiator
To: Dave Jiang <dave.jiang@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, robert.moore@intel.com, andrew@kernel.org,
 bfaccini@nvidia.com, eahariha@linux.microsoft.com, dan.j.williams@intel.com,
 thorsten.blum@linux.dev, gourry@gourry.net,
 nunodasneves@linux.microsoft.com, wangyuquan1236@phytium.com.cn,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20250913023224.39281-1-xueshuai@linux.alibaba.com>
 <20250915093549.00006109@huawei.com>
 <45d5e6a9-d561-4df9-96d4-285f2ca12888@linux.alibaba.com>
 <CAJZ5v0grihVDor12BXU3-tAiQ5WH6rK+AZK8aTtaUa3cq1i0jA@mail.gmail.com>
 <2ee6c734-7a6e-4888-b00f-17de1c0f5e5a@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <2ee6c734-7a6e-4888-b00f-17de1c0f5e5a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/21 23:06, Dave Jiang 写道:
> 
> 
> On 10/21/25 6:30 AM, Rafael J. Wysocki wrote:
>> On Tue, Oct 21, 2025 at 8:55 AM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>>
>>>
>>>
>>> 在 2025/9/15 16:35, Jonathan Cameron 写道:
>>>> On Sat, 13 Sep 2025 10:32:24 +0800
>>>> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>>>
>>>>> The Generic Initiator Affinity Structure in SRAT table uses device
>>>>> handle type field to indicate the device type. According to ACPI
>>>>> specification, the device handle type value of 1 represents PCI device,
>>>>> not 0.
>>>>>
>>>>> Fixes: 894c26a1c274 ("ACPI: Support Generic Initiator only domains")
>>>>> Reported-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
>>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>>
>>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>>
>>>> Thanks!
>>>>
>>>>> ---
>>>>> changes since v1: drop changes in actbl3.h to make it easy to progress per Jonathan
>>>>> ---
>>>
>>>
>>> Hi, Rafael,
>>>
>>> Gentle ping.
>>>
>>> Are you happy to pick this bugfix up in this cycle?
>>
>> drives/acpi/numa/ is maintained by Dave.
> 
> Applied to cxl/fixes
> 7c3643f204edf1


Thanks.
Shuai

