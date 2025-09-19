Return-Path: <linux-acpi+bounces-17137-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2103EB8A83B
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 18:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A074E627F
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998F531D73B;
	Fri, 19 Sep 2025 16:10:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3843F31D392;
	Fri, 19 Sep 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298246; cv=none; b=MZKsO5Hti8cNY4EOytWg+DDP9tlk676gc/I7EhbXnBGNRlZUhiLtkzVXLEaw+cXzMqBa3F+cqqIX7V67l2f1OGtTiGawdwXlIcOsJtaEg/EK8FzVPTLrxHQsY4XDZewKGPng3LS7toMbK+FhLn1vXX0HgqlWzdYCqXwQ2C0RCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298246; c=relaxed/simple;
	bh=TtjQbcOJxvG112VTPz6mC99j+hDDQQpWHHiN1bCSSSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHyv18fO31aHCLi/cKdE5FbZANd29lNdUVbAhQlmTeEtQKCCeCOs3oM+AyzpvEAqz2yUA1NMZ8oVbEGF1369RmBFsI5PN/s3YhB6fxz9xrpZQYKbUIVHOkurW1FBEap9MYN74Xsj2c/vD4SFqdSdze6EndlqG6Y3v87JiywkZJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68B271BA8;
	Fri, 19 Sep 2025 09:10:36 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 708A13F66E;
	Fri, 19 Sep 2025 09:10:39 -0700 (PDT)
Message-ID: <6892215f-1ed3-4fd4-8546-8fd0aa8783b5@arm.com>
Date: Fri, 19 Sep 2025 17:10:39 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/29] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-3-james.morse@arm.com>
 <8b502a2a-36f0-4234-84a0-e1d00b95ba56@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <8b502a2a-36f0-4234-84a0-e1d00b95ba56@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 11/09/2025 15:08, Ben Horgan wrote:
> On 9/10/25 21:42, James Morse wrote:
>> In acpi_count_levels(), the initial value of *levels passed by the
>> caller is really an implementation detail of acpi_count_levels(), so it
>> is unreasonable to expect the callers of this function to know what to
>> pass in for this parameter.  The only sensible initial value is 0,
>> which is what the only upstream caller (acpi_get_cache_info()) passes.
>>
>> Use a local variable for the starting cache level in acpi_count_levels(),
>> and pass the result back to the caller via the function return value.
>>
>> Gid rid of the levels parameter, which has no remaining purpose.
> 
> Nit: s/Gid/Get/

Oops,


Thanks,

James

