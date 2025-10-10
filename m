Return-Path: <linux-acpi+bounces-17726-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A225ABCE028
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 18:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D10F24FFD3E
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 16:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E98F2FC893;
	Fri, 10 Oct 2025 16:54:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8CF2FB99D;
	Fri, 10 Oct 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115290; cv=none; b=jav9Y1hIeRwwHq+A8Y1qpx/Hp0Nwg1i36bLvWgxUfUk15SzShjMDQs02YK0HEtC0tmDKigfuLxXjAm1+Ez6F/C7YZ+YeAIr2Q1jBYIb2kJlV2vsIjwF1gwiXAyGi+t5stUmKIP/AtPXaZBPu+sMqQ3Yh8NUbJK5YVbk9VHg9d8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115290; c=relaxed/simple;
	bh=OxOChyWRZw/pR7CtPmAB5YnWpcsxS8vPMJhJ/TsOVy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhdSCooGWWf1jHeWaNKJq4ryabHExprwIeR/KxQZGj04JDm2UXiQ+ofCx7xBWzmHQZZZwvWkIzaTqDO85wn6rLxSXCBfoPBH7qvHvQSaT4sVEHma4iOxUJRlUYTFG16KIo5MXroUt9xFjUMpisoDZPiJwqx9ZcflTSMLBYvFGGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41C7C1713;
	Fri, 10 Oct 2025 09:54:40 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1691A3F66E;
	Fri, 10 Oct 2025 09:54:42 -0700 (PDT)
Message-ID: <b2d79768-fb1c-4a15-8a1c-f519bc81eeb7@arm.com>
Date: Fri, 10 Oct 2025 17:54:11 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/29] arm_mpam: Add kunit tests for props_mismatch()
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
 <20250910204309.20751-30-james.morse@arm.com>
 <1c0907cc-5cfe-448e-a308-c347566c1f68@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <1c0907cc-5cfe-448e-a308-c347566c1f68@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Fenghua,

On 26/09/2025 03:36, Fenghua Yu wrote:
> On 9/10/25 13:43, James Morse wrote:
>> When features are mismatched between MSC the way features are combined
>> to the class determines whether resctrl can support this SoC.
>>
>> Add some tests to illustrate the sort of thing that is expected to
>> work, and those that must be removed.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks!

James

