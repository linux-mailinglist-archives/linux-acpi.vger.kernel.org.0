Return-Path: <linux-acpi+bounces-16736-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 658F9B55204
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 16:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8FA14E07AD
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604F5309DDF;
	Fri, 12 Sep 2025 14:43:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76DF30E0D1;
	Fri, 12 Sep 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688187; cv=none; b=FqvcMew+IfCDz1Crbcq26rhVJcrr8cXk8hIO12Gjr2fT9EIqlOe4c7XUn9Pm2RbbeuBmtaibJDvvi0ejygzLQEkvW2fvRQSNvOPQbaSI5H2QbdfefJZkPSvL81UC5wM8Edt1B2QasLR/LB1AptkKOr9hxLE0qokp+20kh8mQbII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688187; c=relaxed/simple;
	bh=vrIPv5i/CQ8Y+l31lRrsdhIHOYFa4QZouWNok4yLK9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XszW3IQYECFqCavnEI6gxIWBBfcaLT1ErACEf1akVD97Wiz+/IF8mCOUgYG2KaN+i3iIQme8sDeQWQuycEFhJyBLcteWNvMaO0UxaqNI3oogx02urVyjC00iNTDqo9PcPaSdYU88SgTRMxYU+g1DKa3vz34UiU5Uh9CRvZ0lGZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8C4816A3;
	Fri, 12 Sep 2025 07:42:56 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9163F3F66E;
	Fri, 12 Sep 2025 07:43:00 -0700 (PDT)
Message-ID: <7b72615a-a1a5-4945-9199-d30b7caee70b@arm.com>
Date: Fri, 12 Sep 2025 15:42:59 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/29] arm_mpam: Use a static key to indicate when mpam
 is enabled
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
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
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250910204309.20751-20-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 9/10/25 21:42, James Morse wrote:
> Once all the MSC have been probed, the system wide usable number of
> PARTID is known and the configuration arrays can be allocated.
> 
> After this point, checking all the MSC have been probed is pointless,
> and the cpuhp callbacks should restore the configuration, instead of
> just resetting the MSC.
> 
> Add a static key to enable this behaviour. This will also allow MPAM
> to be disabled in repsonse to an error, and the architecture code to
> enable/disable the context switch of the MPAM system registers.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c  | 12 ++++++++++++
>  drivers/resctrl/mpam_internal.h |  8 ++++++++
>  2 files changed, 20 insertions(+)
> 

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben


