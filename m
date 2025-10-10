Return-Path: <linux-acpi+bounces-17729-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D33BCE031
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 18:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9E6581436
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 16:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC102FC88A;
	Fri, 10 Oct 2025 16:55:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C832FBE1A;
	Fri, 10 Oct 2025 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115338; cv=none; b=cuX+vEYgV6HWhRsLMxcX/Naukk3Z+JEVNNc3qs9wLbNqxfMwc/Cmqd7Heh+h3Ev3bW7FWMYJVQlD1tGsBFDDkIE9h2pVo0HOeIu/6PSvfWZ3S7wYLu7PqKPKafnbDBRnQ5aN9KoaVf+ef7DnLK/QhU5nIjfTCO1RzkN57k7AJq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115338; c=relaxed/simple;
	bh=ae/zoxqsLkfyIkm6FlTXmRSEfgzfAZUSBpv6izvN+KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFEm39ieKtcysMw50fTxYOi9xwmYGfFnXLHRy+Cze8CQ15mAD8I0CcoaqV9VpEw2W3HHVmY3gJzKibu3FdkARzCCwDz5zR/AvoN9oDgnMwWzry2tRyXXoUS+L0r2Mh8UFGaF6qlkJ/0CWFtMGCq15XTtaO3WN+dlAMk/jMD+KH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D7E9153B;
	Fri, 10 Oct 2025 09:55:28 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75ED33F66E;
	Fri, 10 Oct 2025 09:55:29 -0700 (PDT)
Message-ID: <7d3110b6-5247-4054-9642-d4f68c159296@arm.com>
Date: Fri, 10 Oct 2025 17:55:26 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/29] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
To: Fenghua Yu <fenghuay@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-3-james.morse@arm.com>
 <e05396d8-a3f1-476f-b217-0f0a74e9e08a@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <e05396d8-a3f1-476f-b217-0f0a74e9e08a@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 02/10/2025 04:55, Fenghua Yu wrote:
> On 9/10/25 13:42, James Morse wrote:
>> In acpi_count_levels(), the initial value of *levels passed by the
>> caller is really an implementation detail of acpi_count_levels(), so it
>> is unreasonable to expect the callers of this function to know what to
>> pass in for this parameter.  The only sensible initial value is 0,
>> which is what the only upstream caller (acpi_get_cache_info()) passes.
>>
>> Use a local variable for the starting cache level in acpi_count_levels(),
>> and pass the result back to the caller via the function return value.
>>
>> Gid rid of the levels parameter, which has no remaining purpose.
>>
>> Fix acpi_get_cache_info() to match.
>>
>> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> 
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks!

James

