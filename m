Return-Path: <linux-acpi+bounces-14702-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B96AEA420
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47CC56409A
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 17:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D092E175E;
	Thu, 26 Jun 2025 17:11:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90792ECE84
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jun 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957866; cv=none; b=krtCGsHzkoRc8V4UCulDgGv9pkkNwQyf/bBUW5+v6y44gNK1to3pKhNhNwKnK9ANyPfUKCu4SBDVuuYrI3Sq3y4IqN0Gi5wvEjhnWhTInyTnG9/3w+gAaJJh4rbfxfn6JdDS5Qy0YVTN6U3hRuDk33cZ72xnsG+85+zU6yCDhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957866; c=relaxed/simple;
	bh=UtuzgysNHcaaY6/mg9sBumj9vhhW+OmYRrKx4HitOew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAJGD3Nd0d8bnT0sDuceFT0EVB3oqeTK0hed+AiESbFJeNv8xbdJ2vQrfFJMUnVBck44Q7rhs7cy15xC/v3o/bSbvrObbK8Ch+etGy5Edg5uHSX6AqKEz7KgBrb0VEjTvBSCBjZG5ZzMKUb96wGNScpRB5+SzpuBbpHwXDfxq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2A361758;
	Thu, 26 Jun 2025 10:10:46 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5E353F762;
	Thu, 26 Jun 2025 10:11:03 -0700 (PDT)
Message-ID: <994a8207-30cb-4c6a-a232-b8dec735ed50@arm.com>
Date: Thu, 26 Jun 2025 18:11:03 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, Rafael Wysocki <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, jeremy.linton@arm.com
References: <20250612171336.4858-1-james.morse@arm.com>
 <20250612171336.4858-3-james.morse@arm.com>
 <20250623-fancy-quizzical-ostrich-32d305@sudeepholla>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250623-fancy-quizzical-ostrich-32d305@sudeepholla>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sudeep,

On 23/06/2025 14:10, Sudeep Holla wrote:
> On Thu, Jun 12, 2025 at 05:13:34PM +0000, James Morse wrote:
>> acpi_count_levels() passes the number of levels back via a pointer argument.
>> It also passes this to acpi_find_cache_level() as the starting_level, and
>> preserves this value as it walks up the cpu_node tree counting the levels.
>>
>> The only caller acpi_get_cache_info() happens to have already initialised
>> levels to zero, which acpi_count_levels() depends on to get the correct
>> result.
>>
>> Explicitly zero the levels variable, so the count always starts at zero.
>> This saves any additional callers having to work out they need to do this.

>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index aaf9b5a26d07..72e6bfc1e358 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -183,7 +183,7 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>>   * @cpu_node: processor node we wish to count caches for
>>   * @levels: Number of levels if success.
>>   * @split_levels:	Number of split cache levels (data/instruction) if
>> - *			success. Can by NULL.
>> + *			success. Can be NULL.
>>   *
>>   * Given a processor node containing a processing unit, walk into it and count
>>   * how many levels exist solely for it, and then walk up each level until we hit
>> @@ -196,6 +196,8 @@ static void acpi_count_levels(struct acpi_table_header *table_hdr,
>>  			      struct acpi_pptt_processor *cpu_node,
>>  			      unsigned int *levels, unsigned int *split_levels)
>>  {
>> +	*levels = 0;
>> +
> 
> Does it make sense to drop similar reset to 0 in acpi_get_cache_info(), just
> to be consistent across all callers of acpi_count_levels().

acpi_get_cache_info() does this because it can return early, it makes sense that it
already cleared the values it passes back.


> Otherwise, LGTM:
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>


Thanks!

James

