Return-Path: <linux-acpi+bounces-18905-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 993CDC5C9A5
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 11:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CE03AEFE4
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 10:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7866A31194A;
	Fri, 14 Nov 2025 10:33:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5C2C0F71;
	Fri, 14 Nov 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116401; cv=none; b=R6ct4Af2srqoGy32wHysusjOfJeFHOLlgJfVw1UhgxWNADk7o3goPozCm/g0B5kT30mQ55pcw/KWP7OWh/Er66zGnhU3ZVigcG8joR5P+8FAq9/yrHUsqHjlIMI23g6MV4CfxIndvZTUBBZ5nloBl94gRuqFEp+Ceu5USkJLD3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116401; c=relaxed/simple;
	bh=3wL5EsjnQnxrKxwBjSep6FZUoReVIuDKn8e8RfWg8Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KshVW2QZJ/IAsJZnv591TOnS+B9zswsKCGYfsZKeL2GQZ2gD35ImUST+33ULIsqjWaIV8Zn829YHRintMxcTt38BOj2d5jV5KW24NQxYqnByhQuBsUNKERUrZeTkIcQ4Ab59yAHC2VVjwbjbfA+yVaXbqaOWp9muUgH7vVVBpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EA821063;
	Fri, 14 Nov 2025 02:33:10 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B28953F5A1;
	Fri, 14 Nov 2025 02:33:13 -0800 (PST)
Message-ID: <e4521b04-6c3c-418b-8cee-6be43d5ef17f@arm.com>
Date: Fri, 14 Nov 2025 10:33:12 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/33] arm_mpam: Allow configuration to be applied and
 restored during cpu online
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: james.morse@arm.com, amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, gshan@redhat.com,
 guohanjun@huawei.com, jeremy.linton@arm.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-24-ben.horgan@arm.com>
 <20251110172724.00005675@huawei.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251110172724.00005675@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 11/10/25 17:27, Jonathan Cameron wrote:
> On Fri, 7 Nov 2025 12:34:40 +0000
> Ben Horgan <ben.horgan@arm.com> wrote:
> 
>> From: James Morse <james.morse@arm.com>
>>
>> When CPUs come online the MSC's original configuration should be restored.
>>
>> Add struct mpam_config to hold the configuration. This has a bitmap of
>> features that were modified. Once the maximum partid is known, allocate
> 
> I'm not following 'were modified'.  When?  Sometime in the past?
> Perhaps "features that have been modified when XXX happens" or

The intent of the features bitmp is to only update the configuration in
hardware for the feautures that require it. On reset, this is all
features, but for a user configuration change this is just the
difference from what was previously set.

However, I don't think the difference part is currently working
correctly; the bitmap always has all the bits set and so any update
configures everything. I'll look into this.

> 
> Having read the code I think this is something like "are modified as configuration
> is read".
> 
>> a configuration array for each component, and reprogram each RIS
>> configuration from this.
Thanks,

Ben


