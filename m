Return-Path: <linux-acpi+bounces-18868-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0384C59230
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 18:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0A424FC9A5
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 16:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A942364047;
	Thu, 13 Nov 2025 16:39:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E1534574A;
	Thu, 13 Nov 2025 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051998; cv=none; b=KEKrV66NDrdpeZu8aL6S4ZrPUqlVbewU3oBlilB42AvAOOXtZ+MJESiXaeuZ1Xn/Hqzabb6RH6Wq5/V8QGJvHzdhGX/ldWp/99w1vcakSrcDkQakkbMfZqBRRwo57lyAm+DFjMnevlKqpBAp13L6n5hGM9Zq3M3gJXTN5S4l1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051998; c=relaxed/simple;
	bh=GKvRaHoleFqCFEZ4uWaKFupeRgZ70gUUYC4hLuNMikA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slKcgUWBLv5mWP/aMFlHhIS/GXUhYzSVNzbeJe0zRN4FItlbXKOXj4h3r5LjNNMX32374hZVZgxtdp2tEbps1e/n/rSAMuhmKCg1ocF7sHCnrK7P87fZB9purpvSAjI4FbonWONK4ZqfYhxOqKuuTP7bnGbiNBXFt1x6c0h1h+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D13412FC;
	Thu, 13 Nov 2025 08:39:47 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D5713F5A1;
	Thu, 13 Nov 2025 08:39:50 -0800 (PST)
Message-ID: <47603a3c-e94d-4452-9f09-0e27ff02e18b@arm.com>
Date: Thu, 13 Nov 2025 16:39:48 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/33] arm_mpam: Add the class and component structures
 for firmware described ris
To: Fenghua Yu <fenghuay@nvidia.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-12-ben.horgan@arm.com>
 <316b04af-2005-47f0-887d-6e9d4031df5b@nvidia.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <316b04af-2005-47f0-887d-6e9d4031df5b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 11/13/25 03:23, Fenghua Yu wrote:
> Hi, Ben and James,
> 
> On 11/7/25 04:34, Ben Horgan wrote:
>> From: James Morse <james.morse@arm.com>
> 
> [SNIP]
> 
>> +static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
>> +                  enum mpam_class_types type, u8 class_id,
>> +                  int component_id)
>> +{
>> +    int err;
>> +    struct mpam_vmsc *vmsc;
>> +    struct mpam_msc_ris *ris;
>> +    struct mpam_class *class;
>> +    struct mpam_component *comp;
>> +    struct platform_device *pdev = msc->pdev;
>> +
>> +    lockdep_assert_held(&mpam_list_lock);
>> +
>> +    if (ris_idx > MPAM_MSC_MAX_NUM_RIS)
>> +        return -EINVAL;
>> +
>> +    if (test_and_set_bit(ris_idx, &msc->ris_idxs))
>> +        return -EBUSY;
>> +
>> +    ris = devm_kzalloc(&msc->pdev->dev, sizeof(*ris), GFP_KERNEL);
>> +    if (!ris)
>> +        return -ENOMEM;
> 
> The ris_idx bit in msc->ris_idxs is not cleared on error paths in this
> function. The bit cannot be set again.
> 
> Not sure if this is a real problem in any case. Clearing the bit on
> error paths may be clean code.

I think this would just add noise. There is no anticipation of any
functionality after failing to create RIS and I expect there are more
places in the code where this assumption is relied on.

> 
> [SNIP]
> 
> Thanks.
> 
> -Fenghua

Thanks,

Ben


