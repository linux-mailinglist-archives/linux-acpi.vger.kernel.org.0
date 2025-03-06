Return-Path: <linux-acpi+bounces-11881-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81C3A5417B
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 04:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C96316927A
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 03:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0917C1993BD;
	Thu,  6 Mar 2025 03:55:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D818DB3F;
	Thu,  6 Mar 2025 03:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741233349; cv=none; b=X/SKDgOSlqpCPyCYC1tQp9ghfCJnY9MlHizr+cqGlkFPQOho2FHLZZfwmg/rJVTKOgWgHFRsFJTBRExpjrOMrGyaxwhdewngusGc7dDLdizKYK9z1E3ZOmGJTWe8C6w2pMSMnaBpX2OAtMp5gixsV868JGqp9omJUYXN5wshL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741233349; c=relaxed/simple;
	bh=mU1rD5hor+x9j18lew5INuhzCiqrn+clR2sCncajU4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ABUxwiqZm9SHs6pQ6acOWOEQjoP5V3SYCkDIOqki8E1l3zt4VS+hG64ncA78HW25gu+LOxc0bu6+9Vl4DgNAjC38HKqXJseMuc68GWQuwgE9sFyyNI1Bg62/My4aFNTfwHzWS4gaywzQrVLBIt/btPwt+qbnWt3EJvNMpGzn7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z7b8C15W1zvWYt;
	Thu,  6 Mar 2025 11:51:55 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id F31C814022E;
	Thu,  6 Mar 2025 11:55:42 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Mar 2025 11:55:42 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 6 Mar
 2025 11:55:42 +0800
Message-ID: <9eb0cd8b-00aa-e304-5b10-850c41b0c0c4@huawei.com>
Date: Thu, 6 Mar 2025 11:55:41 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 10/14] soc: hisilicon: kunpeng_hccs: Simplify PCC shared
 memory region handling
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jassi Brar
	<jassisinghbrar@gmail.com>, Adam Young <admiyo@os.amperecomputing.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-10-3b44f3d134b1@arm.com>
 <1e7560ab-2545-843a-e42a-2d37f6b7ef93@huawei.com>
 <20250305113426.bt2lebp2rfyngcpl@bogus>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250305113426.bt2lebp2rfyngcpl@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/5 19:34, Sudeep Holla 写道:
> On Wed, Mar 05, 2025 at 03:14:50PM +0800, lihuisong (C) wrote:
>> 在 2025/3/3 18:51, Sudeep Holla 写道:
>>> The PCC driver now handles mapping and unmapping of shared memory
>>> areas as part of pcc_mbox_{request,free}_channel(). Without these before,
>>> this Kunpeng HCCS driver did handling of those mappings like several
>>> other PCC mailbox client drivers.
>>>
>>> There were redundant operations, leading to unnecessary code. Maintaining
>>> the consistency across these driver was harder due to scattered handling
>>> of shmem.
>>>
>>> Just use the mapped shmem and remove all redundant operations from this
>>> driver.
>>>
>>> Cc: Huisong Li <lihuisong@huawei.com>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> With belows to change,
>> Reviewed-by: Huisong Li <lihuisong@huawei.com>
> Thanks!
>
> [...]
>
>>> -	if (!pcc_chan->shmem_base_addr ||
>>> -	    pcc_chan->shmem_size != HCCS_PCC_SHARE_MEM_BYTES) {
>>> +	if (pcc_chan->shmem_size != HCCS_PCC_SHARE_MEM_BYTES) {
>>>    		dev_err(dev, "The base address or size (%llu) of PCC communication region is invalid.\n",
>>>    			pcc_chan->shmem_size);
>> Now the check of shared base address is not here. The log about this address
>> no need to be printed.
>>
>> Can you help me fix it like:
>>
>> dev_err(dev, "The base size (%llu) of PCC communication region must be %d Byte.\n",
>>   			pcc_chan->shmem_size, HCCS_PCC_SHARE_MEM_BYTES
>> );
> Sure.
>
> Did you get a chance to validate this driver and any other users of PCC
> on your platform with these changes + the error handling fix you pointed
> out ? That would be very useful as I don't have any set up to test.
Sure, I'll test this series.
>
> .

