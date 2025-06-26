Return-Path: <linux-acpi+bounces-14704-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A63FAEA43F
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB44E4CFA
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A1C2E7179;
	Thu, 26 Jun 2025 17:14:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B672DAFB8
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jun 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750958086; cv=none; b=dQw7tS4qmcQsNYJVq0hGre4fwDRyYorJplBL5om/lBavVtFd9rG0HzKRV2c5L/wwn+JlNQlSYt9hdU9XLTFqpNhpqLA+0uLsY6ngzrt+gCuXwSnNTq4ruGcYRz0/N/hEceBCAfvbwd1B9B02lV7qYatwlOzBj+qEhQn+tddvFIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750958086; c=relaxed/simple;
	bh=DIlaJtpBKlViAMvmQtKddLKkjCGcz+TWnZLLY3AHVbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6h+FrasOOltqxwSRgI9KQfultoQQOjCrXERZLe1E2WJtCP/Vhxihv41VxkJzc2qnTBvrk+5aq3SHWEZkCKq2gH6dhxOGzIT1bi/gVCvltwOouLrTIuEuBt/KfQ+0La/le5GZM74Fj0ESjV39jhKJkvIHwQFi9r0L9qcVwtT6Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 063C21758;
	Thu, 26 Jun 2025 10:14:27 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24E373F762;
	Thu, 26 Jun 2025 10:14:42 -0700 (PDT)
Message-ID: <5f2316d0-165f-4a15-9762-dadce6940b06@arm.com>
Date: Thu, 26 Jun 2025 18:14:41 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ACPI / PPTT: Add a helper to fill a cpumask from a
 processor container
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, Rafael Wysocki <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, jeremy.linton@arm.com
References: <20250612171336.4858-1-james.morse@arm.com>
 <20250612171336.4858-2-james.morse@arm.com>
 <20250623-incredible-overjoyed-foxhound-baa930@sudeepholla>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250623-incredible-overjoyed-foxhound-baa930@sudeepholla>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sudeep,

On 23/06/2025 14:08, Sudeep Holla wrote:
> On Thu, Jun 12, 2025 at 05:13:33PM +0000, James Morse wrote:
>> The PPTT describes CPUs and caches, as well as processor containers.
>> The ACPI table for MPAM describes the set of CPUs that can access an MSC
>> with the UID of a processor container.
>>
>> Add a helper to find the processor container by its id, then walk
>> the possible CPUs to fill a cpumask with the CPUs that have this
>> processor container as a parent.

>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 54676e3d82dd..aaf9b5a26d07 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -298,6 +298,97 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
>>  	return NULL;
>>  }
>>  
>> +/**
>> + * acpi_pptt_get_child_cpus() - Find all the CPUs below a PPTT processor node
>> + * @table_hdr:		A reference to the PPTT table.
>> + * @parent_node:	A pointer to the processor node in the @table_hdr.
>> + * @cpus:		A cpumask to fill with the CPUs below @parent_node.
>> + *

> Is this cpus mask always cleared before acpi_pptt_get_child_cpus() is called.
> Just checking if it makes sense to clear it before we start the loop in this
> function or do we have a need to start with a pre-filled cpumask ?

It's only got one caller, which does the cpumask_clear() - but I've been bitten by this,
so getting them both to do it would be least surprising.


> Other than that, LGTM.
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>


Thanks!

James

