Return-Path: <linux-acpi+bounces-16651-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B559B52792
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 06:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBD31BC823A
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 04:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBC421CC4B;
	Thu, 11 Sep 2025 04:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UJEsvHZm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE62B4A32;
	Thu, 11 Sep 2025 04:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757564894; cv=none; b=Mr5sSUjvCINml1pdkGQhQ+6swyJs4y4obmMcDy1K7sBPsFMXKFVUot6jJ5jSGwYMvnKUV45LH5l8eIGLFwEE2IRmM6qhECASsqkwp217VxfVKe8KAfNL5AH1TQbQbUmiaZ82PmAB8ee00VwrdvcNfWMatVGOurLZX3OFP/ow4eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757564894; c=relaxed/simple;
	bh=ymwoN8HVzEu96HC+Scu0Y1rq8pT9FNncKZTtDQc4V+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpA/bHBb3WiRFz95lNmub1Dup5nCFcuu7O8LkNqckhDi1PFtJw52BDZKdbEvBlBcI14eEEMWzE2E0z9bWLrrjBaPRIzU6j2bEaZFzW5YBWWItJ8iPLEpXWMq6mXMGn+FDUljFmbB/8+1Y1SgZqMrVArsUllWKcRWtzVy4AJ3Vo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UJEsvHZm; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757564883; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IUu9taPZoApNbuQhkcFfradbfbsd2faZRK0ukpoOPLU=;
	b=UJEsvHZm2BWvQ+VxMab777V/mkWafjwxM/GRDe/kzQUTVE+HyRWzWTuk5obgaXfDgaCBRDRp8cSBlOHMsVHwoUagO9Jdt5dv7byWZeWiTeuxMNCkD1D8rTstC4jCWz/LsIz4iMrDo5ODixF1hjIxig8wZ7OHFBaXtjuXl7Kc3ro=
Received: from 30.246.178.7(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WnkiLzk_1757564880 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Sep 2025 12:28:01 +0800
Message-ID: <998939f5-e0f9-457f-98a2-73f687ad29cc@linux.alibaba.com>
Date: Thu, 11 Sep 2025 12:28:00 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi,srat: Fix incorrect device handle check for Generic
 Initiator
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
 andrew@kernel.org, bfaccini@nvidia.com, eahariha@linux.microsoft.com,
 dan.j.williams@intel.com, thorsten.blum@linux.dev, gourry@gourry.net,
 nunodasneves@linux.microsoft.com, wangyuquan1236@phytium.com.cn,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20250910093949.5793-1-xueshuai@linux.alibaba.com>
 <20250910105729.000070a5@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250910105729.000070a5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/10 17:57, Jonathan Cameron 写道:
> On Wed, 10 Sep 2025 17:39:49 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> The Generic Initiator Affinity Structure in SRAT table uses device
>> handle type field to indicate the device type. According to ACPI
>> specification, the device handle type value of 1 represents PCI device,
>> not 0.
>>
>> Fix this by defining explicit macros for device handle types and using
>> the correct check for PCI devices:
>>
>> - ACPI_SRAT_ACPI_DEVICE_HANDLE (0): ACPI device handle
>> - ACPI_SRAT_PCI_DEVICE_HANDLE (1): PCI device handle
>>
>> Fixes: 894c26a1c274 ("ACPI: Support Generic Initiator only domains")
>> Reported-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> The actbl3.h additions need to go through acpcia and then have a link
> tag in here to show that it was merged.  Perhaps just fix it with a number
> for now and follow up with the acpcia stuff in the longer run?

Sure, I will drop changes in actbl3.h to make it easy to progress.

> 
> Also note clearly this only affects a debug print - no functional bug.
> That may change whether people choose to backport this or not.

Yes.

> 
> I'm curious on whether you are thinking of wiring this up so that
> we can set the appropriate nodes on PCI Devices other than by doing it
> with _PXM().  For obscure reasons there can be references both ways
> (so DSDT Device entry -> SRAT via _PXM, and SRAT -> Device via this field
> of generic initiators).
> 
> For now we only implement the first one so all we need is a node to be
> instantiated for the GI to sit in.
> 
> Come to think of it the fix that made PCI device entries in DSDT with _PXM
> turn up in the right place was reverted (for a problem with broken firmware
> on AMD threadripper systems - IIRC that I think is long solved).
> Not sure if that path even works today and the one this code is about has
> never been hooked up.

You mean add a new map like pxm_to_node_map[]?

> 
> Thanks for the fix!
> 
> Jonathan
> 
> 

Thanks.

Best Regards,
Shuai

