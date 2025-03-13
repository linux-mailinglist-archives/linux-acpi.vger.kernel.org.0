Return-Path: <linux-acpi+bounces-12184-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6A6A5F209
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 12:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE683A595C
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 11:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9B1265CD2;
	Thu, 13 Mar 2025 11:09:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F0F265CCA
	for <linux-acpi@vger.kernel.org>; Thu, 13 Mar 2025 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864183; cv=none; b=pq/W5Q/DFLXsd+Exb3/iQ9D+XfAKpLrOTN/Kby3bjslE7kfjAQLm9kYslZ0OHO86cW6EsFGtymXuz5gJCWJR3zsQPfB9BWcW1ro3Ekmj65VOm/YY5oVh3EC/1hWlrdPTGG7brJVWjuHiKwv3LUFgvbNarvkvYzW7Q1Se3gJd7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864183; c=relaxed/simple;
	bh=f4fz3Nm5tn0/pWMG6A0J0GUka5+BD9q8elvMNaTG+TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPNdYDQjihr6+CCKfrH8h8FWaFBfBYkqMuicI3y+92aGNFmL7eycQsEn8fdNNQ13E1BeJr2nF640JSqBVJpSEKu9J6yvl/ybtm7M9D9KmBQzlpZ0zr7M7cBMIwge13Y+ND3ZOTJaae6zYsBAb8KSrHRi68LqnfGb9j5vpN8R1ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AF5D1516;
	Thu, 13 Mar 2025 04:09:51 -0700 (PDT)
Received: from [10.57.40.246] (unknown [10.57.40.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C2503F673;
	Thu, 13 Mar 2025 04:09:39 -0700 (PDT)
Message-ID: <73e4c6fc-bc41-452b-8af5-9653436d8ba7@arm.com>
Date: Thu, 13 Mar 2025 11:09:37 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New "something fishy here" warning fires
To: Baolu Lu <baolu.lu@linux.intel.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-acpi@vger.kernel.org, iommu@lists.linux.dev
References: <3046c6a2-72a0-412e-a865-48dc129be0df@gmail.com>
 <09bc17bd-4d25-4afd-8f6c-56707ea9bc92@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <09bc17bd-4d25-4afd-8f6c-56707ea9bc92@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-03-13 4:38 am, Baolu Lu wrote:
> On 3/13/25 03:34, Heiner Kallweit wrote:
>> Since "iommu: Get DT/ACPI parsing into the proper probe path" I get 
>> the following
>> on a N100-based mini pc. The warning pops up 4 times, for:
>>
>> PNP0C14:00
>> PNP0C14:01
>> PNP0C14:00
>> PNP0C14:01
>>
>> Any other info you'd be interested in?
>>
>> [  +0.000139] Unpacking initramfs...
>> [  +0.000690] ------------[ cut here ]------------
>> [  +0.000028] acpi-wmi PNP0C14:00: late IOMMU probe at driver bind, 
>> something fishy here!
>> [  +0.000041] WARNING: CPU: 1 PID: 1 at drivers/iommu/iommu.c:449 
>> __iommu_probe_device+0x12b/0x530
>> [  +0.000034] Modules linked in:
>> [  +0.000024] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0- 
>> rc6-next-20250312+ #2
>> [  +0.000029] Hardware name: Default string Default string/Default 
>> string, BIOS ADLN.M6.SODIMM.ZB.CY.015 08/08/2023
>> [  +0.000032] RIP: 0010:__iommu_probe_device+0x12b/0x530
>> [  +0.000019] Code: 68 00 74 28 4c 8b 73 50 4d 85 f6 75 03 4c 8b 33 48 
>> 89 df e8 d7 ec 00 00 4c 89 f2 48 c7 c7 b8 91 7b 9e 48 89 c6 e8 f5 3e 
>> 96 ff >
>> [  +0.000055] RSP: 0000:ffffb031c006fc98 EFLAGS: 00010282
>> [  +0.000021] RAX: 0000000000000000 RBX: ffff9469416c5010 RCX: 
>> 0000000000000000
>> [  +0.000023] RDX: 0000000000000002 RSI: 0000000000000003 RDI: 
>> 00000000ffffffff
>> [  +0.000023] RBP: ffffb031c006fcd8 R08: 0000000000000000 R09: 
>> ffffb031c006fae8
>> [  +0.000023] R10: ffffffff9eb1ea68 R11: 0000000000000003 R12: 
>> ffffffff9e485280
>> [  +0.000023] R13: ffffb031c006fd70 R14: ffff946940bb8ec0 R15: 
>> 0000000000000000
>> [  +0.000023] FS:  0000000000000000(0000) GS:ffff946b18bec000(0000) 
>> knlGS:0000000000000000
>> [  +0.000037] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  +0.000020] CR2: 0000000000000000 CR3: 000000016c650001 CR4: 
>> 0000000000770ef0
>> [  +0.000023] PKRU: 55555554
>> [  +0.000012] Call Trace:
>> [  +0.000010]  <TASK>
>> [  +0.000011]  ? show_regs.part.0+0x1d/0x30
>> [  +0.000019]  ? show_regs.cold+0x8/0xd
>> [  +0.000016]  ? __iommu_probe_device+0x12b/0x530
>> [  +0.000017]  ? __warn.cold+0xc2/0x15e
>> [  +0.000018]  ? __iommu_probe_device+0x12b/0x530
>> [  +0.000017]  ? report_bug+0xe3/0x170
>> [  +0.000016]  ? console_unlock+0x7d/0x110
>> [  +0.000018]  ? __iommu_probe_device+0x12b/0x530
>> [  +0.000016]  ? __iommu_probe_device+0x12d/0x530
>> [  +0.000017]  ? handle_bug+0x116/0x170
>> [  +0.000018]  ? exc_invalid_op+0x18/0x70
>> [  +0.000017]  ? asm_exc_invalid_op+0x1b/0x20
>> [  +0.000022]  ? __iommu_probe_device+0x12b/0x530
>> [  +0.000018]  ? __iommu_probe_device+0x12b/0x530
>> [  +0.000019]  ? __pfx_probe_iommu_group+0x10/0x10
>> [  +0.000017]  probe_iommu_group+0x26/0x50
>> [  +0.000016]  bus_for_each_dev+0x79/0xd0
>> [  +0.000020]  iommu_device_register+0xbe/0x230
>> [  +0.000021]  intel_iommu_init+0xd76/0xf40
>> [  +0.000016]  ? _raw_spin_unlock_irqrestore+0x55/0x80
>> [  +0.000022]  ? __this_cpu_preempt_check+0x13/0x20
>> [  +0.000018]  ? lockdep_hardirqs_on+0x7d/0x110
>> [  +0.000018]  ? trace_hardirqs_on+0x5b/0xd0
>> [  +0.000017]  ? _raw_spin_unlock_irqrestore+0x3c/0x80
>> [  +0.000020]  ? __pfx_pci_iommu_init+0x10/0x10
>> [  +0.000021]  pci_iommu_init+0xd/0x40
>>
> 
> The fix is here.
> 
> https://lore.kernel.org/linux- 
> iommu/72a4853e7ef36e7c1c4ca171ed4ed8e1a463a61a.1741791691.git.robin.murphy@arm.com/

Indeed, and I see Joerg has updated the iommu/next branch already, so 
hopefully today's -next will be OK again. Sorry for the false positives!

Thanks,
Robin.

