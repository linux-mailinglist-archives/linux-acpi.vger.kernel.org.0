Return-Path: <linux-acpi+bounces-17363-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956DBBA4C9D
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 19:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B59626575
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 17:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FB130C605;
	Fri, 26 Sep 2025 17:53:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB7230C113;
	Fri, 26 Sep 2025 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909181; cv=none; b=Pp0Pwy3xngyK+i0hp3RJJfJ+Gf4DvTel0uK+fdwTjebWnP5t9xhP3nQhtH02hf/sO07KbV4RbxFxo1xNPrSvGrixzLS9Ngpjho2lRzPcRtyfOSHTruBJ15p3rd3oO6rKncDvethw7VUcltDE69qPCH3+vOzYYEiaalac9kFrwSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909181; c=relaxed/simple;
	bh=yCJUUC/x7SHBnIIkv7jnds+rzYaU04/QYMTRAf3yiNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuMaQhzmhhmEzR9sQw+5N+woe4mMUCBgXCf/B4dFdU0kM+ZZO9aKedatHKdJiBCYb1DJ4M/D58hJ0bJUC7j3SxSMAf18EGEfHDwLAWqIuNi/MEx6csl/65AjBui93JWvEIAFluchkyd6TFEKOT9Vfacj2D7YftdDURxxgOhE1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63E891691;
	Fri, 26 Sep 2025 10:52:50 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 998DF3F5A1;
	Fri, 26 Sep 2025 10:52:51 -0700 (PDT)
Message-ID: <88f45c7f-9769-478b-9abd-749ec8f8d43b@arm.com>
Date: Fri, 26 Sep 2025 18:52:49 +0100
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
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <5a80cb91-6095-4f44-b576-53badc4575f5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Markus,

On 11/09/2025 17:30, Markus Elfring wrote:
> …
>> +++ b/drivers/resctrl/mpam_devices.c
> …
>>> +int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>> +		    enum mpam_class_types type, u8 class_id, int component_id)
>> +{
>> +	int err;
>> +
>> +	mutex_lock(&mpam_list_lock);
>> +	err = mpam_ris_create_locked(msc, ris_idx, type, class_id,
>> +				     component_id);
>> +	mutex_unlock(&mpam_list_lock);
> …
> 
> Under which circumstances would you become interested to apply a statement
> like “guard(mutex)(&mpam_list_lock);”?
> https://elixir.bootlin.com/linux/v6.17-rc5/source/include/linux/mutex.h#L228

None! The bit of this you cut out is a call to mpam_free_garbage() which calls
synchronize_srcu(). That may sleep for a while. The whole point of the deferred free-ing
is it does not happen under the lock. The 'guard' magic means the compiler gets to choose
when to call unlock.



Thanks,

James

