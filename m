Return-Path: <linux-acpi+bounces-17578-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F86BB7D62
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 20:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247A41B210CC
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 18:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1462DCF45;
	Fri,  3 Oct 2025 18:03:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE4B2DCBF1;
	Fri,  3 Oct 2025 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514636; cv=none; b=Ooyl0gwUbh8wKVZvL0+4BmBMM2J42pMbncPWP86lQJgAPZgHjSswO1+xtqZK/OK4xvCkPP0kL2ZBAsrZyXefo9EtaKpYYKdl/8I9d4pCpIPg3NlVytVwOOgyOHRLdbSDCRK4qyU7aRmHJ+5umnFvF3AVRR/o0LJpKPXIxFZ5XGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514636; c=relaxed/simple;
	bh=4eHHzocHHtz2wCKBm3r2zI/nINuL5/9x64rUy0eAOAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUxDxzXCalEljT+qjwh+20D0dbKkhzmOupLU7gIlGnjdvW5cE7NKT0BXlNWPf3q1AnPgoSNDIPHvdy1F+FGsQmPSiAq/fXTOlpaqq2bdZUdsL96ZrSKUdLlAolp4xAgwU+TYtELPP7RqHtCJBXNuz8NLhI27ckTmht+vtlWJ0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62E061596;
	Fri,  3 Oct 2025 11:03:46 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2DA63F5A1;
	Fri,  3 Oct 2025 11:03:48 -0700 (PDT)
Message-ID: <85bef7bc-42c9-4a27-b74e-35fbbae4b39b@arm.com>
Date: Fri, 3 Oct 2025 19:03:47 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/29] arm_mpam: Use a static key to indicate when mpam
 is enabled
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
 <20250910204309.20751-20-james.morse@arm.com>
 <7b72615a-a1a5-4945-9199-d30b7caee70b@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <7b72615a-a1a5-4945-9199-d30b7caee70b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 12/09/2025 15:42, Ben Horgan wrote:
> On 9/10/25 21:42, James Morse wrote:
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

> Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks!

James

