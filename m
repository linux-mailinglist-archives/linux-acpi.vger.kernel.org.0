Return-Path: <linux-acpi+bounces-6361-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DF09061B3
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 04:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7FF281FF1
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 02:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FEA44C86;
	Thu, 13 Jun 2024 02:21:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AE433062
	for <linux-acpi@vger.kernel.org>; Thu, 13 Jun 2024 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245318; cv=none; b=pe766onog8iB71JelHen64fMEmnTG8p0P7rwfx2rLsv7UQKuoHOoQXeotLP/8Nc7AUlcz0ZrCOu3DvQBrepBXSw/j+SMbNOCjlwjcjU0ySCH0eZvQHTHbElXOR3mqVV/eTX0/lWjUrAIa44xnAK0qxyrSYyWWFfUOBd0/R99LHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245318; c=relaxed/simple;
	bh=qU6DZgFRVJibwNSyt6JQe+xDYMFJes+pDn6ZHjClnAY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Fl8ibUkvBNXCzCSRJaJQbsy/R+tokaLEVsusVJdWzAWLDJVT2nqjHhsAEtg/h7xuxYPvHvxaWbGO/uy+EEu3MpN7HN1NTWo6Q7SucCUQHSgmrE4tMRCn3LxV3OnPP3RX2RAE0QEW7TyfyAtyyc++gQwPbjgKV5U4ws1oNjYF7pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W05dd1KNPzmZxj;
	Thu, 13 Jun 2024 10:17:09 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 04F76140258;
	Thu, 13 Jun 2024 10:21:54 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Jun 2024 10:21:50 +0800
Subject: Re: [PATCH 2/3] arm64: cpuidle: Move ACPI specific code into
 drivers/acpi/arm64/
To: Catalin Marinas <catalin.marinas@arm.com>, Sudeep Holla
	<sudeep.holla@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Will
 Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <20240605131458.3341095-1-sudeep.holla@arm.com>
 <20240605131458.3341095-3-sudeep.holla@arm.com> <ZmiBNbSXu4B0czYs@arm.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <2972824c-7cbc-1bda-2fdb-45ed4c42faf4@huawei.com>
Date: Thu, 13 Jun 2024 10:21:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZmiBNbSXu4B0czYs@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/6/12 0:54, Catalin Marinas wrote:
> On Wed, Jun 05, 2024 at 02:14:57PM +0100, Sudeep Holla wrote:
>> The ACPI cpuidle LPI FFH code can be moved out of arm64 arch code as
>> it just uses SMCCC. Move all the ACPI cpuidle LPI FFH code into
>> drivers/acpi/arm64/cpuidle.c
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   arch/arm64/kernel/Makefile                          | 1 -
>>   drivers/acpi/arm64/Makefile                         | 1 +
>>   {arch/arm64/kernel => drivers/acpi/arm64}/cpuidle.c | 4 ----
>>   3 files changed, 1 insertion(+), 5 deletions(-)
>>   rename {arch/arm64/kernel => drivers/acpi/arm64}/cpuidle.c (97%)
> 
> For arch/arm64 changes:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Lorenzo, Hanjun, please let me know if you want these to go in via the
> arm64 tree or Raphael's one.

As it's arm64 related code, I would like to go via the arm64 tree.

Thanks
Hanjun

