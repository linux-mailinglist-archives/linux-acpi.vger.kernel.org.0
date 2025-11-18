Return-Path: <linux-acpi+bounces-19019-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C14FC69E0A
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 15:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89DF334BA67
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BEA35E52C;
	Tue, 18 Nov 2025 14:11:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4860235C1A5;
	Tue, 18 Nov 2025 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475101; cv=none; b=NWbB/JySnMWi1Kp2muMrzIFAHmPQN6zwXR5lqm10EhQExP4xdg/AO9Z4q1oFxH/fbQLqFTLppK6nzxuQ5Xuwzp0RKqeadagXzP8CVzp4EbKehqk4TNtxzwypvRwsT36z3E4G4OSoELUmBiNivBetW6Tt4l0D1R6azWcr7gBD3sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475101; c=relaxed/simple;
	bh=lnFjOA9F2o/b7zV8Wir53ekV4hSg9x8MBNlVqgmyT9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvcharG4IGsyQ3vb+7IxfUACerov2TGXkeIGwG4KNpZIlZA3cx7YVJVP1k/xkf4rvm1YuTWneVGcJk95OBqlbyvQOjJYWeQaoQ9bXf1zC3unyi3+klr4qgFijir2MMCJzXVFMUfTMmqmScxQsCkaxdCQrnsf7rfdq8RboJ1+n94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 994C1FEC;
	Tue, 18 Nov 2025 06:11:30 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ADE73F740;
	Tue, 18 Nov 2025 06:11:33 -0800 (PST)
Message-ID: <753f4d26-efa9-4ffd-a820-7c2a53c0bc5f@arm.com>
Date: Tue, 18 Nov 2025 14:11:31 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] arm_mpam: Add basic mpam driver
To: Drew Fustini <fustini@kernel.org>
Cc: james.morse@arm.com, amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, gshan@redhat.com,
 guohanjun@huawei.com, jeremy.linton@arm.com, jonathan.cameron@huawei.com,
 kobak@nvidia.com, lcherian@marvell.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, lpieralisi@kernel.org, peternewman@google.com,
 quic_jiles@quicinc.com, rafael@kernel.org, robh@kernel.org,
 rohit.mathew@arm.com, scott@os.amperecomputing.com, sdonthineni@nvidia.com,
 sudeep.holla@arm.com, tan.shaopeng@fujitsu.com, will@kernel.org,
 xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com> <aRoG+UptQg9mix+7@x1>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <aRoG+UptQg9mix+7@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Drew,

On 11/16/25 17:16, Drew Fustini wrote:
> On Fri, Nov 07, 2025 at 12:34:17PM +0000, Ben Horgan wrote:
>> Hi all,
> [snip]
>> The rest of the driver can be found here: (no updated version - based on v3)
>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.18-rc1
> 
> Does anyone know of a hosting platform that offers ARM machines that
> have MPAM?

As far as I know there aren't any.

There is some MPAM support in the Orion Radxa board which is likely the
cheapest option. The MPAM acpi table isn't in the firmware though so
you'd need to load a custom table. James has this working.

> 
> I see there are Ampere systems on Oracle but I wasn't sure if those have
> MPAM.
> 
> I'm getting a RISC-V QoS patch series ready (Ssqosid ext and CBQRI spec)
> and I'd like to get a better understanding of how resctrl works on MPAM
> in practice.
> 
> Thanks,
> Drew


Thanks,

Ben


