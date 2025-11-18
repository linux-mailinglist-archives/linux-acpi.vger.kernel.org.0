Return-Path: <linux-acpi+bounces-19010-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F0AC68E2B
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 11:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 607B22AB9E
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 10:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0F4348890;
	Tue, 18 Nov 2025 10:44:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD2F346E59;
	Tue, 18 Nov 2025 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763462674; cv=none; b=IntObA6uRizi5UIjagfxoermmEYVgv65i57UHVtUyeAVM03pnkbMN3vT/NZX+PE5/ZT/JLNGnwGXeAiIPVuag8XyGNfMuNSTdrIeH1KM3xJ+3pyDezIZrKk5sI6khlPIa/CkcQagmWculS1tMY0bLtO+/05TikCFxIVFT5saJCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763462674; c=relaxed/simple;
	bh=Fi92iRAH8GmexsBQN85W9mA5aibeGiC2ZYk+7nepmEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObLSJzjRRSqUDYFZQDJ1FPEm8NxLzQWY5TnyE2qrJJfZomJO2cNdTHqCKUbzCumvms5dUW5Nw+jpZ6Mf9t3n3v4WBRXI77WUMg4nEyX0sPU0ggiqxVuxukWOdmZXJyDNbPhxZdRUOygTslZ9Mf908a6CyQwluVizmOfygyh4XcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DBF3FEC;
	Tue, 18 Nov 2025 02:44:24 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1E4C3F740;
	Tue, 18 Nov 2025 02:44:26 -0800 (PST)
Message-ID: <3d2b7980-db26-423f-9525-5d18eade8344@arm.com>
Date: Tue, 18 Nov 2025 10:44:25 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/34] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
To: Markus Elfring <Markus.Elfring@web.de>, James Morse
 <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Baisheng Gao <baisheng.gao@unisoc.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 D Scott Phillips <scott@os.amperecomputing.com>,
 Danilo Krummrich <dakr@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
 David Hildenbrand <david@redhat.com>, Drew Fustini <dfustini@baylibre.com>,
 Fenghua Yu <fenghuay@nvidia.com>, Gavin Shan <gshan@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, Jamie Iles <quic_jiles@quicinc.com>,
 Jeremy Linton <jeremy.linton@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Koba Ko <kobak@nvidia.com>,
 Len Brown <lenb@kernel.org>, Linu Cherian <lcherian@marvell.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Peter Newman <peternewman@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>,
 Will Deacon <will@kernel.org>, Xin Hao <xhao@linux.alibaba.com>,
 Zeng Heng <zengheng4@huawei.com>
References: <20251117170014.4113754-11-ben.horgan@arm.com>
 <a5306f5a-92b0-437d-b384-40863fbed6d8@web.de>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <a5306f5a-92b0-437d-b384-40863fbed6d8@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Markus,

On 11/17/25 19:50, Markus Elfring wrote:
> …
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -0,0 +1,190 @@
> …
>> +static int mpam_msc_drv_probe(struct platform_device *pdev)
>> +{
> …
>> +	mutex_lock(&mpam_list_lock);
>> +	msc = do_mpam_msc_drv_probe(pdev);
>> +	mutex_unlock(&mpam_list_lock);
> …
> 
> Does anything hinder you to integrate statements like “guard(mutex)(&mpam_list_lock);” here?
> https://elixir.bootlin.com/linux/v6.18-rc6/source/include/linux/mutex.h#L228

The mpam_list_lock needs to be dropped before the end of the scope as it
is also taken in mpam_msc_drv_remove().

> 
> Regards,
> Markus

Thanks,

Ben


