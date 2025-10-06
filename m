Return-Path: <linux-acpi+bounces-17630-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A8850BBE926
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 18:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51344349F11
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 16:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5802D94B8;
	Mon,  6 Oct 2025 16:00:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC0A2D94BB;
	Mon,  6 Oct 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766409; cv=none; b=nxNP2Uj+xoUWnc6gCOpcl0m+qJjvDM11U/1ZWyYYsGPVkflxoHhwhgqiTo+KmV82E7OFPaiwrXyff8YOzd993eHsrcysg6+Jf8Ws7bGbmNDAkl+X4loK6/9kxc42YR5+Ez9P8bD3Sk6T72rg/QlKpBixCjoqYLHnK+05H0/+v5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766409; c=relaxed/simple;
	bh=017mx55a33CQXrt4HRZdEp+wgp9KSSCismm4YwmfCns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5qHGgp9Cdj6nOtVGbTz8UU/I2/pgXRHglY8YGyanlKST72N/dP5D6ZVM8or6ey6ZK2vUvK+gHX0mPx/oruKK9UC9nwkJWz8++wNJZVxY5gMPK4RTrFEKEls+Ll1QP/vaXZ+CIpLyK0dZYU3u5WyFPRI8/A3Tn2NtIi7n5RhKzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 422A21515;
	Mon,  6 Oct 2025 08:59:56 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 577313F738;
	Mon,  6 Oct 2025 08:59:58 -0700 (PDT)
Message-ID: <8ecfb414-dc3d-4e66-90cf-427b22d4a949@arm.com>
Date: Mon, 6 Oct 2025 16:59:56 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/29] arm_mpam: Add mpam_msmon_read() to read monitor
 value
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
 <20250910204309.20751-24-james.morse@arm.com>
 <1344b395-66aa-4714-b1fc-9c970c0fd0bf@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <1344b395-66aa-4714-b1fc-9c970c0fd0bf@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 11/09/2025 16:46, Ben Horgan wrote:
> On 9/10/25 21:43, James Morse wrote:
>> Reading a monitor involves configuring what you want to monitor, and
>> reading the value. Components made up of multiple MSC may need values
>> from each MSC. MSCs may take time to configure, returning 'not ready'.
>> The maximum 'not ready' time should have been provided by firmware.
>>
>> Add mpam_msmon_read() to hide all this. If (one of) the MSC returns
>> not ready, then wait the full timeout value before trying again.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index cf190f896de1..1543c33c5d6a 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -898,6 +898,232 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)

>> +static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
>> +{
>> +	int err, idx;
>> +	struct mpam_msc *msc;
>> +	struct mpam_vmsc *vmsc;
>> +	struct mpam_msc_ris *ris;
>> +
>> +	idx = srcu_read_lock(&mpam_srcu);
>> +	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
> 
> This can be list_for_each_entry_srcu(). (I thought I'd already commented
> but turns out that was on another patch.)




> 
>> +		msc = vmsc->msc;
>> +
>> +		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
> 
> Also here.


Yup - thanks I missed these. Fixed.
I bet I went cross-eyed between here and mpam_apply_config() as they are structurally similar.



Thanks,

James

