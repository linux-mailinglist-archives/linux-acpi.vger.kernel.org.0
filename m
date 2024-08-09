Return-Path: <linux-acpi+bounces-7456-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E8C94CEEB
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 12:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A360B20AEC
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CAA18FDC1;
	Fri,  9 Aug 2024 10:45:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453218FC6F
	for <linux-acpi@vger.kernel.org>; Fri,  9 Aug 2024 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200328; cv=none; b=dENkTrTb7s6Tbr/638gV6pwxtu63kBhbQYhLUDqTXWU5I+EHfldhVzocxyf53EJ8tqsjPNHJDKdpOjbYr8Eu7/wDz6y0ZwH2iFJkTV2KO+tnIGnHSj7L++1abps4SC//+mnYQp4Ns8d+SN3NzrJHUsMaxHjYe8Y7vRjiDvpIwaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200328; c=relaxed/simple;
	bh=76RRaAPvyC68vcuxJmcAVf0CuI6wT8tGn41LD4lLxJg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uTwzQS4Txq2dxDFx9dffJQgrQgJ1IrAbaUsEuDalg/6NJ30xoD1RuyrNhxiJOtaOaExHVT2uJUlhsNlNLiDcAoltXglSOIEci/+pMxXzVkaF9gLRPJYp4uOkVbo7hiqg1hSPK55aIpCwYqQrVtCoDb1sl7kWPf/znBcU0t0HBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WgL6X3LLczQnH0;
	Fri,  9 Aug 2024 18:40:52 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DFBE1800FF;
	Fri,  9 Aug 2024 18:45:21 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 Aug 2024 18:45:20 +0800
Subject: Re: [PATCH 3/3] ARM64: ACPI: Move the NUMA code to
 drivers/acpi/arm64/
To: Sudeep Holla <sudeep.holla@arm.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Will Deacon <will@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240808131522.1032431-1-guohanjun@huawei.com>
 <20240808131522.1032431-4-guohanjun@huawei.com>
 <20240809072153.5uoci2kfqvr7qfmr@bogus>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <0dc58328-601f-6174-aa0a-95c194e45960@huawei.com>
Date: Fri, 9 Aug 2024 18:45:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240809072153.5uoci2kfqvr7qfmr@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/8/9 15:21, Sudeep Holla wrote:
> On Thu, Aug 08, 2024 at 09:15:22PM +0800, Hanjun Guo wrote:
>> The ARM64 ACPI NUMA code can be moved out of arm64 arch code
>> as it just related to ACPI NUMA table parsing, mappings for
>> ACPI NUMA and cpu, move the ACPI NUMA code to drivers/acpi/arm64/.
>>
>> Since arm64 selects ACPI_NUMA by default, so just move the function
>> definitions under CONFIG_ARM64 in linux/acpi.h.
> 
> I was about to ask to take a look at riscv implementation to avoid any
> issues with this move, kbuild has already reported a build failure.

sharp-sighted :)

Will take care of it next version.

Thanks
Hanjun

