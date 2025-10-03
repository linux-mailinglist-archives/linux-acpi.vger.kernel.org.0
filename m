Return-Path: <linux-acpi+bounces-17579-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F79BB7D6E
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 20:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68E5D347A93
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 18:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7428A2DC78C;
	Fri,  3 Oct 2025 18:04:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0612DAFDF;
	Fri,  3 Oct 2025 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514657; cv=none; b=Fqfkg0d9+d1WdJ85+fsKWgMDi8nu8kRs3+FgvE9SLxt73n8RdPJRyfrPJhjDIuacGreBOWFf5RJfKqBlOtVMv8zwh73ivVkiSDVZ7HFyCewE0jvZUZHvBIodZdraGYgzVVEFTdSlgsZV1vwDEc7afhhp83hz5MPYtiVa9S5ykDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514657; c=relaxed/simple;
	bh=oYCdX+JUQjSpgfzx96CljhHT+QnJFx1k4nkGwNis/xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4Zcif3mjKwQET4h5OZvIs2qacu0ePScWxJPSog6Le9jyWYNlAJv7XJjAhp0yPhlExWtsHPofcG9qeeHWv6hXHLyEeFnJn4NlvYJA/sONsgusXMm/EA8ceBvysitfFrETpi4Ev41FRliE/ljZobYNDlwS2ZGFZdAhk6j1CVtO/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6107F1596;
	Fri,  3 Oct 2025 11:04:07 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 105593F5A1;
	Fri,  3 Oct 2025 11:04:09 -0700 (PDT)
Message-ID: <f2c3ea6d-deb3-4ff1-8f8b-8cadc27a77db@arm.com>
Date: Fri, 3 Oct 2025 19:04:08 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/29] arm_mpam: Use a static key to indicate when mpam
 is enabled
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
 <20250910204309.20751-20-james.morse@arm.com>
 <6acfa275-93ea-4bbe-843c-62911280d950@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <6acfa275-93ea-4bbe-843c-62911280d950@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Fenghua,

On 26/09/2025 03:31, Fenghua Yu wrote:
> On 9/10/25 13:42, James Morse wrote:
>> Once all the MSC have been probed, the system wide usable number of
>> PARTID is known and the configuration arrays can be allocated.
>>
>> After this point, checking all the MSC have been probed is pointless,
>> and the cpuhp callbacks should restore the configuration, instead of
>> just resetting the MSC.
>>
>> Add a static key to enable this behaviour. This will also allow MPAM
>> to be disabled in repsonse to an error, and the architecture code to

> nit...s/repsonse/response/

Oops,


>> enable/disable the context switch of the MPAM system registers.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks!

James

