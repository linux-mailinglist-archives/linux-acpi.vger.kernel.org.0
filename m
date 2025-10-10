Return-Path: <linux-acpi+bounces-17716-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B81E8BCDFCE
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 18:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76E1B4E925E
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A67E2F999F;
	Fri, 10 Oct 2025 16:53:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41A949620;
	Fri, 10 Oct 2025 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115193; cv=none; b=Di2AzBPtyTD8ZcOWynk9BQMxNVgAELMZgzgN6zLmJbSY7cjiOxrUWZch4I8fQW/Wogt/fMkCr8y2QFUNrmVOrf0aP+8EPIl0DEHY3DHCQiBiYYAPL2Sa8dhQCGXUXbtm9e9Xh4lrPTK0i5jRX2xyf6ig1CtfDS3KPcMNjgn9HmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115193; c=relaxed/simple;
	bh=NvHno/MeFbr57dMbH3NV1tNKl1NOg7uNhF56N3nM4VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXT0vhmmDWIc7YmRIq4CIEZVLIsRVOwFcgmON1lLYbk5BTjJxn55c5ZXmt0KJgQezcKPHOnKuyK3702i6mtjf9Yf1WFu9bS9aTiGxVQKy/KP+cbnANHLs5FuNN2ZDKDqva9ngxE1QaUOqmVeqpJisAb4Q6GeC8h65KIaQwrgFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1649153B;
	Fri, 10 Oct 2025 09:53:01 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30B843F66E;
	Fri, 10 Oct 2025 09:53:04 -0700 (PDT)
Message-ID: <de2c78a5-4879-46a4-9869-5bcd0c694302@arm.com>
Date: Fri, 10 Oct 2025 17:53:02 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/29] arm_mpam: Use long MBWU counters if supported
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com, Rob Herring <robh@kernel.org>,
 Rohit Mathew <rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-27-james.morse@arm.com>
 <20250912142929.00003cff@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250912142929.00003cff@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/09/2025 14:29, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:43:06 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> From: Rohit Mathew <rohit.mathew@arm.com>
>>
>> If the 44 bit (long) or 63 bit (LWD) counters are detected on probing
>> the RIS, use long/LWD counter instead of the regular 31 bit mbwu
>> counter.
>>
>> Only 32bit accesses to the MSC are required to be supported by the
>> spec, but these registers are 64bits. The lower half may overflow
>> into the higher half between two 32bit reads. To avoid this, use
>> a helper that reads the top half multiple times to check for overflow.
>>
>> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
>> [morse: merged multiple patches from Rohit]
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks!

Your push back on the 'front facing' thing in the previous patch made some knock on
changes here, but I think they're minor.


Thanks,

James

