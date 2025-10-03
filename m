Return-Path: <linux-acpi+bounces-17577-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6B9BB7D50
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 20:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A21E4E1193
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 18:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276A52DF148;
	Fri,  3 Oct 2025 18:03:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBD52DE71D;
	Fri,  3 Oct 2025 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514615; cv=none; b=iSUJt0gzlMJiBU5qAEyY78iQrVYrziCgh4ef4ZlHxEGmPP87SPHl4BKSjtQt1aGn0mZZv8x41tKrCq/CGyoZ6GeKFraxtzurWgJ3KGEKKTQqOsDG9/GfvSri+1JRIQf5nq12RIurrHn1pvfT1vplMHQ/BmGqmeZ9+/uJdtCFDzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514615; c=relaxed/simple;
	bh=QaGD808ycN8erqbyvi0e0oc4i3eJEFsiJNnzzBh+W7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9rnB0PM4g51gBDWaxJUFAruP/mH/D/pjyLDDTJR7l1aeXRDtPZqysjBSxRg4+2FFe8didDdcY9BwqSf7nwT4xttecpGtRHWiSl0vJoLULe9NW6Q/bd/wtYaf7z2stoEzyM9g6geNUDLysOHV+jjdVzntrBJtILosR0pZp+g6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 824EA1596;
	Fri,  3 Oct 2025 11:03:23 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 590C03F5A1;
	Fri,  3 Oct 2025 11:03:25 -0700 (PDT)
Message-ID: <0d84faef-5a14-4f16-8612-d0e5dfc15985@arm.com>
Date: Fri, 3 Oct 2025 19:03:25 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/29] arm_mpam: Use a static key to indicate when mpam
 is enabled
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
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-20-james.morse@arm.com>
 <20250912131336.000014d3@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250912131336.000014d3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/09/2025 13:13, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:42:59 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> Once all the MSC have been probed, the system wide usable number of
>> PARTID is known and the configuration arrays can be allocated.
>>
>> After this point, checking all the MSC have been probed is pointless,
>> and the cpuhp callbacks should restore the configuration, instead of
>> just resetting the MSC.
>>
>> Add a static key to enable this behaviour. This will also allow MPAM
>> to be disabled in repsonse to an error, and the architecture code to
>> enable/disable the context switch of the MPAM system registers.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> Seems fine to me (other than the TODO move to arch code
> that should probably be resolved.

That is just to make it clear this isn't where it should live, its a quirk of moving
the arch code alter to reduce the number of trees this interacts with.
I've dropped the word 'TODO'...


> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


Thanks!

James

