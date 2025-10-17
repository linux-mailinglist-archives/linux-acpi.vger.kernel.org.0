Return-Path: <linux-acpi+bounces-17891-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAEBBEB457
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 20:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 864E6504F87
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3402E9749;
	Fri, 17 Oct 2025 18:51:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215183328EB;
	Fri, 17 Oct 2025 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727089; cv=none; b=GfhYCTHP/lIUMDfLuIK10VkDYAFOo6XyyiQY6hgEng+0IBkHNZeW6O8fligIPF2F33uFUHaoQFphC1Buq0sPq6ptndlQU3U7Dea2QH36/mKoK0XfQhoebxNnilKO1SINjJGMRUevx7653iY+NUxqq2oR7gn72XqS7osvNEKLHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727089; c=relaxed/simple;
	bh=lleXYRsqTTGOg7HyySH/E8d/rbkRXFSammjebf7Er2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOo9UWHbTwd8NNebXonMmqr3iO9OYJ7lg9FWLeORMg/QmRk5/amQzfO2Z2Z0W4Y0US1ppbZHpVroenYOdpCE2Z4jIuvlDyFfdRNj+nV4oKYgU3hbbQVz5mcX1dDT98rHDAUkIv6Tl+QIruzj66JHZvRk9z0PmtlkVqJ9+rdYxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74B1B1595;
	Fri, 17 Oct 2025 11:51:19 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3F1B3F6A8;
	Fri, 17 Oct 2025 11:51:21 -0700 (PDT)
Message-ID: <c28f04f8-3989-45d4-b630-2cc35574e47a@arm.com>
Date: Fri, 17 Oct 2025 19:51:19 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/29] arm_mpam: Add the class and component structures
 for firmware described ris
To: Markus Elfring <Markus.Elfring@web.de>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Baisheng Gao <baisheng.gao@unisoc.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Ben Horgan
 <ben.horgan@arm.com>, Carl Worth <carl@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 D Scott Phillips <scott@os.amperecomputing.com>,
 Danilo Krummrich <dakr@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
 David Hildenbrand <david@redhat.com>, Drew Fustini <dfustini@baylibre.com>,
 Fenghua Yu <fenghuay@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, Jamie Iles <quic_jiles@quicinc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Koba Ko <kobak@nvidia.com>,
 Len Brown <lenb@kernel.org>, Linu Cherian <lcherian@marvell.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Peter Newman <peternewman@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Shaopeng Tan
 <tan.shaopeng@fujitsu.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>,
 Will Deacon <will@kernel.org>, Xin Hao <xhao@linux.alibaba.com>
References: <20250910204309.20751-9-james.morse@arm.com>
 <5a80cb91-6095-4f44-b576-53badc4575f5@web.de>
 <88f45c7f-9769-478b-9abd-749ec8f8d43b@arm.com>
 <a4a637e4-ae58-40ec-a4d3-a382aaad814c@web.de>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <a4a637e4-ae58-40ec-a4d3-a382aaad814c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Markus,

On 26/09/2025 19:15, Markus Elfring wrote:
>>> …
>>>> +++ b/drivers/resctrl/mpam_devices.c
>>> …
>>>>> +int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>>>> +		    enum mpam_class_types type, u8 class_id, int component_id)
>>>> +{
>>>> +	int err;
>>>> +
>>>> +	mutex_lock(&mpam_list_lock);
>>>> +	err = mpam_ris_create_locked(msc, ris_idx, type, class_id,
>>>> +				     component_id);
>>>> +	mutex_unlock(&mpam_list_lock);
>>> …
>>>
>>> Under which circumstances would you become interested to apply a statement
>>> like “guard(mutex)(&mpam_list_lock);”?
>>> https://elixir.bootlin.com/linux/v6.17-rc5/source/include/linux/mutex.h#L228
>>
>> None! The bit of this you cut out is a call to mpam_free_garbage() which calls
>> synchronize_srcu(). That may sleep for a while. The whole point of the deferred free-ing
>> is it does not happen under the lock. The 'guard' magic means the compiler gets to choose
>> when to call unlock.
> 
> How does this feedback fit to the proposed addition of a mutex_lock()/mutex_unlock()
> call combination (which might be achievable also with another programming interface)?

Right - I've muddled the horde of "must use guard srcu" with the horde of "must use guard
mutex". In this case I'd still prefer we don't spuriously hold the write side lock when
doing the deferred free-ing.


Thanks,

James

