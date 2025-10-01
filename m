Return-Path: <linux-acpi+bounces-17466-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5428ABAFEB4
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 11:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF34C1887B8C
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 09:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EA7283FE0;
	Wed,  1 Oct 2025 09:50:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB47238D42;
	Wed,  1 Oct 2025 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759312259; cv=none; b=LxjE1m+6zZQRFqp8ChIBPkyg1sdBBC5864GX1z5yOB16m0D+TMzIpWg+7AeH/Ki5v9omg2OrGQFZRSKLUw+NSgvfApRgNuPwMbVLllcW5P/ufGjszzBqh2HkqPAtNKv7ih2LfzgggDENulG7926WL8tz7+gmaFYQ1bQpPEaJFE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759312259; c=relaxed/simple;
	bh=LBzKpvYn50qQRIoPNE9y9HPb+JJBbJm+1xmS3YmjJxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMUIivuaP6Cx8VWFoFcwQ8X0WDdQaixqwRghaUDapCvnMpBYTL4iBr531fANsZ7JRZeyB+1OTmLzl00zemEuwclOc9CgeGY5OT4IZIGGNwPDyS8KdcLGsi+E6xT4SycFTAWJOtZa5T2W9E53cLA5sjP3EJVcU4Ny0Whno/D7wjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01B0516F2;
	Wed,  1 Oct 2025 02:50:48 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECE5A3F59E;
	Wed,  1 Oct 2025 02:50:50 -0700 (PDT)
Message-ID: <7ac224c2-9014-4701-8d96-6df0a4bcc5f6@arm.com>
Date: Wed, 1 Oct 2025 10:50:49 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/29] arm_mpam: Add a helper to touch an MSC from any
 CPU
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
 <20250910204309.20751-17-james.morse@arm.com>
 <20250912125722.0000373e@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250912125722.0000373e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/09/2025 12:57, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:42:56 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> Resetting RIS entries from the cpuhp callback is easy as the
>> callback occurs on the correct CPU. This won't be true for any other
>> caller that wants to reset or configure an MSC.
>>
>> Add a helper that schedules the provided function if necessary.
>>
>> Callers should take the cpuhp lock to prevent the cpuhp callbacks from
>> changing the MSC state.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Reviewed-by: Ben Horgan <ben.horgan@arm.com>

> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


Thanks!

James


