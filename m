Return-Path: <linux-acpi+bounces-16152-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD80B3A50B
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 17:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29588175BA8
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280AF25782A;
	Thu, 28 Aug 2025 15:58:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCF925744D;
	Thu, 28 Aug 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396685; cv=none; b=IswHYKFbN+nyNBp4rpMpzcFcrktfZYJ3mQPfONofqk29+bsoyCZxt8bf+paZjp1Q3t79m73nUfhbePQ27BReiLa4ODdhUQtGQCprMUsHYxoczLXiZ0Ov1mf7yoZSGOKrwm7FxX7ycpqrxnivijefbp0bD6q4OwCWt4uNKDuQ8cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396685; c=relaxed/simple;
	bh=V1qiqwurLe1DRj4mhXRsbO/UrN4a9Fy7Q6AABkiLF7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUc5wJozo2A9c2t9GshZ2pPGETVfBJPqRAvl19qbI6jpRcHQCFmFGBFTslsTQj7Vo9XzTz1Qg9qO5g/WeResmFGWSN19yujRZc/L0SW/z8jr30KOgdO6oE3HFViVaVppMaGWNZlZIq98DdJ6RZRjSDEytvjFXXZI0BUFIaIVZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E7AA1A32;
	Thu, 28 Aug 2025 08:57:54 -0700 (PDT)
Received: from [10.1.196.42] (eglon.cambridge.arm.com [10.1.196.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23C883F694;
	Thu, 28 Aug 2025 08:57:55 -0700 (PDT)
Message-ID: <c87745ab-988e-4d3f-963c-9543e9c73d27@arm.com>
Date: Thu, 28 Aug 2025 16:57:55 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/33] ACPI / PPTT: Find cache level by cache-id
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
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
 <20250822153048.2287-6-james.morse@arm.com>
 <9ce36190-6d99-4a41-a803-a65be677db2d@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <9ce36190-6d99-4a41-a803-a65be677db2d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 27/08/2025 10:25, Ben Horgan wrote:
> On 8/22/25 16:29, James Morse wrote:
>> The MPAM table identifies caches by id. The MPAM driver also wants to know
>> the cache level to determine if the platform is of the shape that can be
>> managed via resctrl. Cacheinfo has this information, but only for CPUs that
>> are online.
>>
>> Waiting for all CPUs to come online is a problem for platforms where
>> CPUs are brought online late by user-space.
>>
>> Add a helper that walks every possible cache, until it finds the one
>> identified by cache-id, then return the level.
>> Add a cleanup based free-ing mechanism for acpi_get_table().

>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index f97a9ff678cc..30c10b1dcdb2 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -221,6 +222,17 @@ void acpi_reserve_initial_tables (void);
>>  void acpi_table_init_complete (void);
>>  int acpi_table_init (void);
>>  
>> +static inline struct acpi_table_header *acpi_get_table_ret(char *signature, u32 instance)
>> +{
>> +	struct acpi_table_header *table;
>> +	int status = acpi_get_table(signature, instance, &table);
>> +
>> +	if (ACPI_FAILURE(status))
>> +		return ERR_PTR(-ENOENT);
>> +	return table;
>> +}
>> +DEFINE_FREE(acpi_table, struct acpi_table_header *, if (!IS_ERR(_T)) acpi_put_table(_T))

> nit: Is it useful to change the condition from !IS_ERR(_T) to
> !IS_ERR_OR_NULL(_T)? This seems to be the common pattern. I do note that
> acpi_put_table() can take NULL, so there is no real danger.

If it's the common pattern, sure.

But this code got dropped as Dave pointed out the PPTT doesn't care about the reference
counting anyway, its acpi_get_pptt() helper just uses the same reference for everything.

This might come back for the MPAM driver..


>> +
>>  int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
>>  int __init_or_acpilib acpi_table_parse_entries(char *id,
>>  		unsigned long table_size, int entry_id,


Thanks,

James

