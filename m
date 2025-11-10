Return-Path: <linux-acpi+bounces-18735-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8EDC47D4D
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 17:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D59954F6ABE
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256CC274B35;
	Mon, 10 Nov 2025 16:03:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFCD205AA1;
	Mon, 10 Nov 2025 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790618; cv=none; b=akuG7krNfSJWi3qz+4oAEmjMEGglZibPXVMOtS7Q4Gl8JhmjNPKizTTa+gyy2s6ZpKCFxVulp7ZXC46ZG9ICeI6YzeVjJslS20eUQZ7YnjXnzQAYexcvMTwIeiHZmDvn2l4DfInjbFghSxz39O4GbFSB3wOomgaL2ldXB4nzN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790618; c=relaxed/simple;
	bh=zKF0hoHTyVoyJKotkjaFqV55fZkLgo/H5hrHTIeXSho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0faI/3zfo+PuTeL3vuSj/+JGnNHMP9qWnUQLBIZS6U+aatsKn/Vr+GVvOC21NE2B3597kLKKPRT3PVzEoF+fvTKgKDV0GKvPOR2CkdHIVLXGb1NO5/sCHBNlXP4JMlqxMVTaijNl7Oz6QtB6d4JvqgSRRVtFKvMiT76YjCpGTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 964732F;
	Mon, 10 Nov 2025 08:03:27 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A15E43F66E;
	Mon, 10 Nov 2025 08:03:30 -0800 (PST)
Message-ID: <29bb9d3c-cc78-46f2-b3dd-dbe12c59b2a9@arm.com>
Date: Mon, 10 Nov 2025 16:03:29 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] arm_mpam: Add basic mpam driver
To: james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
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
References: <20251107123450.664001-1-ben.horgan@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251107123450.664001-1-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

On 11/7/25 12:34, Ben Horgan wrote:

> 
> The rest of the driver can be found here: (no updated version - based on v3)
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.18-rc1
> 

James has kindly hosted a branch with my rebase of the rest of the
driver here.
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/v6.18-rc4

This can be used to help with more testing.

Thanks,

Ben


