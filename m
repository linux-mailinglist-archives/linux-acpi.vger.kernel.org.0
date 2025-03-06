Return-Path: <linux-acpi+bounces-11880-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E04DDA54161
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 04:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3577318928A5
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 03:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985B8192D86;
	Thu,  6 Mar 2025 03:50:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB55F80BFF;
	Thu,  6 Mar 2025 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741233033; cv=none; b=VqJabsJ8J5ayuW7B6vi1xGfmXyAJNjrPgE+kxBKxMwJBkQ0/gOBVKdHGxmVOrRDkcofixsw23YSFC5KlrBIAzqXsCrMBy+9rwiQ1Syy0gxk0HLTEcuR0KJpCBiVFguz2k0G6ahvUTTFe6QkoEy6JqOQcDQudTPARXSAYB2lP0as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741233033; c=relaxed/simple;
	bh=o/qpQ848bA3dPwlTINNIox+xkxKbOr5vjlE0updQ5bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k3nLhhjszjt+OGiF00L1T8xf334kSx00B4/n10ugglmmOhColn5yNCukxjD/Rpebwoq+V1XYvdi0YDhX4arPyz/M1ObkGXFUHPXfLnePeNK9cbwA48wcZ0NLSwNhOdS1gwWUDmZBwgktcnX+wM9OnqdFqVQTOWyezf0x9G9nQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z7b1d5NNQz1f07F;
	Thu,  6 Mar 2025 11:46:13 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id E1C341A016C;
	Thu,  6 Mar 2025 11:50:27 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Mar 2025 11:50:27 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 6 Mar
 2025 11:50:27 +0800
Message-ID: <f414e0e7-6781-000b-1987-2e3c13311c55@huawei.com>
Date: Thu, 6 Mar 2025 11:50:26 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 03/14] mailbox: pcc: Drop unnecessary endianness
 conversion of pcc_hdr.flags
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jassi Brar
	<jassisinghbrar@gmail.com>, Adam Young <admiyo@os.amperecomputing.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-3-3b44f3d134b1@arm.com>
 <5093286f-1db6-bab2-920d-71fe274ad251@huawei.com>
 <20250305103648.7e2ajxlkwza7axzc@bogus>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250305103648.7e2ajxlkwza7axzc@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/5 18:36, Sudeep Holla 写道:
> On Wed, Mar 05, 2025 at 12:02:13PM +0800, lihuisong (C) wrote:
>> 在 2025/3/3 18:51, Sudeep Holla 写道:
>>> The Sparse static checker flags a type mismatch warning related to
>>> endianness conversion:
>>>
>>>     |  warning: incorrect type in argument 1 (different base types)
>>>     |     expected restricted __le32 const [usertype] *p
>>>     |     got unsigned int *
>>>
>>> This is because an explicit endianness conversion (le32_to_cpu()) was
>>> applied unnecessarily to a pcc_hdr.flags field that is already in
>>> little-endian format.
>>>
>>> The PCC driver is only enabled on little-endian kernels due to its
>>> dependency on ACPI and EFI, making the explicit conversion unnecessary.
>> How to confirm ACPI works only on little-endian?
> Sorry I didn't notice this question. ACPI depends on ARCH_SUPPORTS_ACPI
> and it is selected only from EFI which is disabled if CPU_BIG_ENDIAN=y
>
got it. I found it.
> .

