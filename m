Return-Path: <linux-acpi+bounces-16549-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01689B503AD
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 19:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5CF16217F
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 17:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2043353362;
	Tue,  9 Sep 2025 16:58:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E628362094;
	Tue,  9 Sep 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437085; cv=none; b=E2wiTEeMqhFATtAUqLko/tek61F1IsZ/Sjeq9KkA2uTb52x80PJf2c+rOnAZbWAtSvR7HWY+mbfGiGougt2r2eJT56tIZpmUrM7kTb1KJbhC7QBVb/AQmmA6sJfP80VxWWK8zK2XyPrQcwRnsyCyU3S/MXx6IgpNx4gvocoobNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437085; c=relaxed/simple;
	bh=GpQo9QmEwcAmI5NcO84HjLc0BalR2RhF0SbpzI+C67M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1vR89ol0a8GBbS2KmbTRQ8v+Jj8wX7HZ4vmU7uVf4VY77kZq3zxgeCkvYGiNjmHFZjsc+Qso4tGRhx4fLf+qq8HafmAi4As6sgDBUds4SZ2iQcrch8meFMSfCsad8isu+XikMan8G0xL+P2iNMmPU9/A9RM+zWL1ONry9R+2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4775320E3;
	Tue,  9 Sep 2025 09:57:55 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD3323F694;
	Tue,  9 Sep 2025 09:57:57 -0700 (PDT)
Message-ID: <dd9e8800-9b55-4021-90a0-05941c71f146@arm.com>
Date: Tue, 9 Sep 2025 17:57:57 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/33] arm_mpam: Add a helper to touch an MSC from any CPU
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
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
 <20250822153048.2287-21-james.morse@arm.com>
 <8635e616-79b7-4d7d-a8b8-aa76ba027bc4@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <8635e616-79b7-4d7d-a8b8-aa76ba027bc4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 28/08/2025 17:13, Ben Horgan wrote:
> On 8/22/25 16:30, James Morse wrote:
>> Resetting RIS entries from the cpuhp callback is easy as the
>> callback occurs on the correct CPU. This won't be true for any other
>> caller that wants to reset or configure an MSC.
>>
>> Add a helper that schedules the provided function if necessary.
>> Prevent the cpuhp callbacks from changing the MSC state by taking the
>> cpuhp lock.

> At first, I thought this was referring to something done in the patch.
> Consider changing to something like:
> 
> Callers should take the cpuhp lock to prevent the cpuhp callbacks from
> changing the MSC state.

Yes - that is better,


> Regardless, this looks good to me.
> 
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>


Thanks!

James

