Return-Path: <linux-acpi+bounces-16119-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA5CB3884F
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 19:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE70F1B60943
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7D72FF152;
	Wed, 27 Aug 2025 17:11:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F3E223710;
	Wed, 27 Aug 2025 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314707; cv=none; b=NjRH+SmiRPRP9GK2wtdX5NJCvuXrysyqc3oaR8UILBpJKN5WXugOjZVv3uY0zSItfxCiWcawqA9JwVnoRtdOQ4FU/rrKAC5oGj4qoEfi4O7vIcnJG/xSWe149pgcaGydJsnfQ/a330gs1UgYlru2wKbhGJLO3QGcNwzDOGQCxPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314707; c=relaxed/simple;
	bh=Zv4tlqmeyNrFaUpCqrhKxtlapI7AXU2/uUSIsRpFUeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFVLyZLQOs6AGCZN/k84UaMCTrfVYnWpmL+jTt+wfCGmj52V3YYRDjjhcy0qfUwCCZ/lU9oSRnvwFPVKWbhF7ypIUbWOjqgXE+0TIx7M9VMJ+lPm5NaWnz1RRxCN/ICoPQCiClOeEzLz7EibVGxVK1rZm8lQ0af8HW80d+QQbHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5932C2720;
	Wed, 27 Aug 2025 10:11:36 -0700 (PDT)
Received: from [10.1.196.42] (eglon.cambridge.arm.com [10.1.196.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5161E3F694;
	Wed, 27 Aug 2025 10:11:38 -0700 (PDT)
Message-ID: <9fde0d3c-52e7-4545-a273-4b37b865997c@arm.com>
Date: Wed, 27 Aug 2025 18:11:38 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/33] drivers: base: cacheinfo: Add helper to find the
 cache size from cpu+level
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-3-james.morse@arm.com>
 <172e9dd6-3b25-4fdf-943e-2bd559117519@kernel.org>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <172e9dd6-3b25-4fdf-943e-2bd559117519@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 24/08/2025 18:25, Krzysztof Kozlowski wrote:
> On 22/08/2025 17:29, James Morse wrote:
>> MPAM needs to know the size of a cache associated with a particular CPU.
>> The DT/ACPI agnostic way of doing this is to ask cacheinfo.
>>
>> Add a helper to do this.

>> ---
>> Changes since v1:
> 
> You marked this as v1.

Oops - that should say RFC. I'll fix all those.


>>  * Converted to kdoc.
>>  * Simplified helper to use get_cpu_cacheinfo_level().

> Please use consistent subject prefixes. Look at previous patch subject
> prefix.

Presumably the previous patch in my series - this is a side effect of multiple branches
that were written at different times getting combined! I'll change it to 'cacheinfo:' as
that seems to be the most popular recently.


Thanks,

James

