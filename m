Return-Path: <linux-acpi+bounces-16611-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A41CB52106
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3091C86420
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958202D248D;
	Wed, 10 Sep 2025 19:31:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158CB2C11D8;
	Wed, 10 Sep 2025 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532666; cv=none; b=JNsYMvfMN2MTgG1WoSmVM9N9pdBFhbZqB2zU7ko8c8vOVq5zrJYb2S0WcmqtsY0zOyH2jY8Grno+U3y8b+RceCUo9icNcws6cvQPA/KuYW/dCQkSiNNmnIUUdKl7l7nSQNj0XQgNz1ciY+qMoZ6mN6ghBICeddIex3ornzpysgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532666; c=relaxed/simple;
	bh=tNSzoVAY2Vjgl50eHt48Cx/9rmLvj6NyJIPC+Kk8ULI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLh3mYtUykAHlKFmyidKynv4nHLazRobMjOrcM7INzDCMtSugJVv5Z9RKmXZIeM5SOjjtNzlFADNkgGnTxOsiaYGV9xe4KXwtXK/jL84mMwTVVnq9vVpD3wcXoL1MJpWqRpZzHWFsBmCjyj4YB/LXjzPzu1urxA93wvvktDktHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2EF316F2;
	Wed, 10 Sep 2025 12:30:55 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 810E93F694;
	Wed, 10 Sep 2025 12:30:57 -0700 (PDT)
Message-ID: <3502cad6-e2e2-426b-b707-162d338c87c9@arm.com>
Date: Wed, 10 Sep 2025 20:30:55 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/33] arm_mpam: Add kunit test for bitmap reset
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-33-james.morse@arm.com>
 <ee847bec-ad08-473e-96b5-407872c2a0f2@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <ee847bec-ad08-473e-96b5-407872c2a0f2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 29/08/2025 17:56, Ben Horgan wrote:
> On 8/22/25 16:30, James Morse wrote:
>> The bitmap reset code has been a source of bugs. Add a unit test.
>>
>> This currently has to be built in, as the rest of the driver is
>> builtin.

>> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
>> index dff7b87280ab..f5e0609975e4 100644
>> --- a/drivers/resctrl/Kconfig
>> +++ b/drivers/resctrl/Kconfig
>> @@ -4,8 +4,21 @@ config ARM64_MPAM_DRIVER
>>  	bool "MPAM driver for System IP, e,g. caches and memory controllers"
>>  	depends on ARM64_MPAM && EXPERT
>>  
>> +menu "ARM64 MPAM driver options"
>> +
>>  config ARM64_MPAM_DRIVER_DEBUG
>>  	bool "Enable debug messages from the MPAM driver."
>>  	depends on ARM64_MPAM_DRIVER
>>  	help
>>  	  Say yes here to enable debug messages from the MPAM driver.
>> +
>> +config MPAM_KUNIT_TEST
>> +	bool "KUnit tests for MPAM driver " if !KUNIT_ALL_TESTS
>> +	depends on KUNIT=y

> It depends on ARM64_MPAM_DRIVER as well.

Yeah, the kbuild robot had some fun with all this. Turns out ARM64_MPAM is undefined on
non-ARM64, which means its dependencies disappear.

All this is now under an 'if ARM64_MPAM_DRIVER' and the driver symbol depends on ARM64 &&
ARM64_MPAM...


Thanks,

James

