Return-Path: <linux-acpi+bounces-18740-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DC2C47F38
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 17:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BF63BB3DD
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621F82798F8;
	Mon, 10 Nov 2025 16:16:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8D01F03C5;
	Mon, 10 Nov 2025 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791367; cv=none; b=Y/uazPAoqM4QP4aL/llb+IpCRaOgD1USxFbvTtwU/55r5ZNFV/GuwyhruXLKVC6zIVC5zaQyn8hwCXVP+qjUcaPqRG2g0AP5SBGkLGKkR4nYVo8JMlfdWSXZ1J03n/2z2RmlFP3E6tffRShSnPCqFkyZI9sgirt28XnLTwOchD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791367; c=relaxed/simple;
	bh=+NIWvsEWL+3vu6kXlQKP3RGe4FZg4stEK3Hka6DrG0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8vDwQ+3jwxzIrl/F4I+1o0hFRl3QtXSFmdquhR6i5wqWiY+Jb1MGzRzBZXzxDphbgycaiejXanxT1+3LNiAblQVG8pYugAlB5bHfrQkRERtBzi3glZJmBosP68+xTHzhVlFd/NTuU9DZm5aPKoMeBe/T/7LzfZlj8kDVr8dxYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 139382F;
	Mon, 10 Nov 2025 08:15:57 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3691F3F66E;
	Mon, 10 Nov 2025 08:16:00 -0800 (PST)
Message-ID: <3db645f5-b0bf-44a0-9cdc-460e46ec7bc2@arm.com>
Date: Mon, 10 Nov 2025 16:15:58 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] arm_mpam: Add basic mpam driver
To: Carl Worth <carl@os.amperecomputing.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 catalin.marinas@arm.com, dakr@kernel.org, dave.martin@arm.com,
 david@redhat.com, dfustini@baylibre.com, fenghuay@nvidia.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <87y0ohbf7e.fsf@rasp.cworth.amperemail.amperecomputing.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <87y0ohbf7e.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Carl,

On 11/7/25 23:22, Carl Worth wrote:
> Ben Horgan <ben.horgan@arm.com> writes:
>> This version of the series comes to you from me as James is otherwise
>> engaged. I hope I have done his work justice. I've made quite a few
>> changes, rework, bugs, typos, all the usual. In order to aid review,
>> as Jonathan suggested, I've split out some patches and made an effort
>> to minimise the amount of churn between patches.
> 
> I've built this and booted on an Ampere system. It ends up reporting a
> successful message of:
> 
> 	MPAM enabled with 1 PARTIDs and 1 PMGs
> 
> So the code seems happy enough as far as that goes.
> 
> But the expected number of PARTIDs on this system is much larger than 1,
> (MPAM with a single PARTID would not be useful at all).
> 
>> See below for a public branch. No public updated version of the
>> snapshot (the rest of the driver) I'm afraid.
> 
> Looking closer, it looks like the bogus value of 0 for mpam_partid_max
> is because the following patch (which does appear in James' various
> snapshots) isn't present yet in the code submitted to this point:
> 
> 	commit 33c1f50970917ac9f2a8e224d850936374df6173
> 	Author: James Morse <james.morse@arm.com>
> 	Date:   Fri Jul 4 14:22:30 2025 +0100
> 	
> 	    arm64: mpam: Advertise the CPUs MPAM limits to the driver
> 	    
> 	    Requestors need to populate the MPAM fields on the interconnect. For
> 	    the CPUs these fields are taken from the corresponding MPAMy_ELx
> 	    register. Each requestor may have a limit on the largest PARTID or
> 	    PMG value that can be used. The MPAM driver has to determine the
> 	    system-wide minimum supported PARTID and PMG values.
> 	    
> 	    To do this, the driver needs to be told what each requestor's
> 	    limit is.

Yes, the driver does barely anything without a requestor.

> 
> So, I guess I'm wondering what more I could do to test this code at this
> point, prior to merging it.
> 
> I'm very interested in seeing this code land upstream as soon as
> possible, and I've got access to an implementation to test whatever I
> can.
> 
> So let me know what else I can do and I'll be glad to contribute my
> Tested-by when I've done it.
> 
> -Carl

Thanks for the quick response and testing.

I've just responded to the cover letter with a branch containing the
rest of the driver. (Just so it's not hidden in this thread) It's
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/v6.18-rc4

With that, you should be able to enable all usable PARTID and PMG, mount
resctrl, add tasks/cpus to resctrl control groups, run benchmarks to
check that the controls are respected and check that the monitors give
expected values.

Thanks,

Ben


