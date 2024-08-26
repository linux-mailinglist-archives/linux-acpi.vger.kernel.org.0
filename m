Return-Path: <linux-acpi+bounces-7820-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCAA95E62C
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 03:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3F31F21130
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70F2139D;
	Mon, 26 Aug 2024 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEaii0uP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6122913;
	Mon, 26 Aug 2024 01:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724634623; cv=none; b=B9WTfpR6EQn78zoJq5QY/DEcxWezMWWvEzQMCYuZtqGdNbfheEjfOg+UC+munqCzXVdGvm5iLwVkieM+F9btJs7vlw7pcud7EngHzj4aWx/H40z7njDzRLxC4JeKpUXHeBsUh5wB4L4fRQYjapKhnkNdw3NF6ES7yDNkdG4hQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724634623; c=relaxed/simple;
	bh=7tye6QropyoxCiVWsCw2kMvEiF7Zsxv+8zMJkehhxvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XouUsELcRPRMIpxm398gnemhiv4mzAhIv8yD7I/j6OUT5KFfzKmo0Mp8eWLLy1ngogrXcika99rK7pwZPkyZKFW5xjHZUeqbQtnBGQs3DSKwkWDeUx4abTRJMr30bGTZDUy1PjQX+O+l311zeYrmM9hFiNk5KpIRMk+oq2GDv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gEaii0uP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724634622; x=1756170622;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7tye6QropyoxCiVWsCw2kMvEiF7Zsxv+8zMJkehhxvM=;
  b=gEaii0uP/DwlFIr6gbrShwbv4+LiboCKoUiHdqvw9jqHBtEZLDqWdJA9
   p2VMWA4tqT0olpS6/klDDZzdX1PiN9+KVD6Z3j3YlS3y9XaJGEfAAGLfn
   5AQvHXbopYpacGIP9pf6LCr0a63yDfwG0c/4dLF8/3Ttw4vzIWdOg4kWL
   F5CAIA5MpFZG+wAKhdWeE6k+ql4N1u5GWF3ejmcnRS1aFivse4uPLHnwu
   Mtym7fFEBIWw9X/VJYkFGPyQNyTjYxIsD3F5mB77u/b8wUx4diGY0QfmA
   LrkXnxB/kBq87KY7Qwvb7+azUIEIDT+QzkLiJdWPRo4pRm7WAdU++FNfD
   w==;
X-CSE-ConnectionGUID: L6azZ+bvR5qmA2CBW1CQWg==
X-CSE-MsgGUID: 6AekM9dXQTm348qgdaNJqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="48427837"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="48427837"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 18:10:21 -0700
X-CSE-ConnectionGUID: REkBD5B8Sfyt12aeVZWTmw==
X-CSE-MsgGUID: rTRRKj90RkK/2hbpiZByKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="62499766"
Received: from zhedache-mobl1.ccr.corp.intel.com (HELO [10.125.240.83]) ([10.125.240.83])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 18:10:19 -0700
Message-ID: <f2fd62f7-3fe3-4bea-8c9e-6343d2cce8b7@linux.intel.com>
Date: Mon, 26 Aug 2024 09:09:00 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ACPICA: Detect FACS in reduced hardware build
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown
 <lenb@kernel.org>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240812054647.1194716-1-jiaqing.zhao@linux.intel.com>
 <20240812054647.1194716-2-jiaqing.zhao@linux.intel.com>
 <CAJZ5v0hPtvVRM=Te2oPzCvE3tOy_rXYGJwaoQOfNc71z+pmkvA@mail.gmail.com>
Content-Language: en-US
From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
In-Reply-To: <CAJZ5v0hPtvVRM=Te2oPzCvE3tOy_rXYGJwaoQOfNc71z+pmkvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-08-20 22:55, Rafael J. Wysocki wrote:
> On Mon, Aug 12, 2024 at 7:47 AM Jiaqing Zhao
> <jiaqing.zhao@linux.intel.com> wrote:
>>
>> According to Section 5.2.10 of ACPI Specification, FACS is optional
>> in reduced hardware model. Enable the detection for "Hardware-reduced
>> ACPI support only" build (CONFIG_ACPI_REDUCED_HARDWARE_ONLY=y) also.
>>
>> Link: https://github.com/acpica/acpica/commit/ee53ed6b5452612bb44af542b68d605f8b2b1104
>> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
>> ---
>>  drivers/acpi/acpica/acglobal.h |  6 +-----
>>  drivers/acpi/acpica/tbutils.c  |  5 +----
>>  drivers/acpi/acpica/utxfinit.c | 24 ++++++++++++------------
>>  include/acpi/acconfig.h        |  1 -
>>  4 files changed, 14 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
>> index f4c90fc99be2..309ce8efb4f6 100644
>> --- a/drivers/acpi/acpica/acglobal.h
>> +++ b/drivers/acpi/acpica/acglobal.h
>> @@ -29,11 +29,7 @@ ACPI_INIT_GLOBAL(u32, acpi_gbl_dsdt_index, ACPI_INVALID_TABLE_INDEX);
>>  ACPI_INIT_GLOBAL(u32, acpi_gbl_facs_index, ACPI_INVALID_TABLE_INDEX);
>>  ACPI_INIT_GLOBAL(u32, acpi_gbl_xfacs_index, ACPI_INVALID_TABLE_INDEX);
>>  ACPI_INIT_GLOBAL(u32, acpi_gbl_fadt_index, ACPI_INVALID_TABLE_INDEX);
>> -
>> -#if (!ACPI_REDUCED_HARDWARE)
>> -ACPI_GLOBAL(struct acpi_table_facs *, acpi_gbl_FACS);
>> -
>> -#endif                         /* !ACPI_REDUCED_HARDWARE */
>> +ACPI_INIT_GLOBAL(struct acpi_table_facs *, acpi_gbl_FACS, NULL);
>>
>>  /* These addresses are calculated from the FADT Event Block addresses */
>>
>> diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
>> index 15fa68a5ea6e..356700349b45 100644
>> --- a/drivers/acpi/acpica/tbutils.c
>> +++ b/drivers/acpi/acpica/tbutils.c
>> @@ -18,7 +18,6 @@ ACPI_MODULE_NAME("tbutils")
>>  static acpi_physical_address
>>  acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size);
>>
>> -#if (!ACPI_REDUCED_HARDWARE)
>>  /*******************************************************************************
>>   *
>>   * FUNCTION:    acpi_tb_initialize_facs
>> @@ -37,8 +36,7 @@ acpi_status acpi_tb_initialize_facs(void)
>>         struct acpi_table_facs *facs;
>>
>>         if (acpi_gbl_FADT.Xfacs &&
>> -                  (!acpi_gbl_FADT.facs
>> -                   || !acpi_gbl_use32_bit_facs_addresses)) {
>> +           (!acpi_gbl_FADT.facs || !acpi_gbl_use32_bit_facs_addresses)) {
>>                 (void)acpi_get_table_by_index(acpi_gbl_xfacs_index,
>>                                               ACPI_CAST_INDIRECT_PTR(struct
>>                                                                      acpi_table_header,
> 
> I'm not sure how this change is related to the rest of the patch.
> 
> It doesn't appear to be present in the original commit pointed to by
> the Link tag.

This change here is just indention fix, in original acpica, the indention is just fine.

Shall I remove this change?

>> @@ -56,7 +54,6 @@ acpi_status acpi_tb_initialize_facs(void)
>>
>>         return (AE_OK);
>>  }
>> -#endif                         /* !ACPI_REDUCED_HARDWARE */
>>
>>  /*******************************************************************************
>>   *
>> diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
>> index 1915bec2b279..70ae0afa7939 100644
>> --- a/drivers/acpi/acpica/utxfinit.c
>> +++ b/drivers/acpi/acpica/utxfinit.c
>> @@ -120,6 +120,18 @@ acpi_status ACPI_INIT_FUNCTION acpi_enable_subsystem(u32 flags)
>>          */
>>         acpi_gbl_early_initialization = FALSE;
>>
>> +       /*
>> +        * Obtain a permanent mapping for the FACS. This is required for the
>> +        * Global Lock and the Firmware Waking Vector
>> +        */
>> +       if (!(flags & ACPI_NO_FACS_INIT)) {
>> +               status = acpi_tb_initialize_facs();
>> +               if (ACPI_FAILURE(status)) {
>> +                       ACPI_WARNING((AE_INFO, "Could not map the FACS table"));
>> +                       return_ACPI_STATUS(status);
>> +               }
>> +       }
>> +
>>  #if (!ACPI_REDUCED_HARDWARE)
>>
>>         /* Enable ACPI mode */
>> @@ -137,18 +149,6 @@ acpi_status ACPI_INIT_FUNCTION acpi_enable_subsystem(u32 flags)
>>                 }
>>         }
>>
>> -       /*
>> -        * Obtain a permanent mapping for the FACS. This is required for the
>> -        * Global Lock and the Firmware Waking Vector
>> -        */
>> -       if (!(flags & ACPI_NO_FACS_INIT)) {
>> -               status = acpi_tb_initialize_facs();
>> -               if (ACPI_FAILURE(status)) {
>> -                       ACPI_WARNING((AE_INFO, "Could not map the FACS table"));
>> -                       return_ACPI_STATUS(status);
>> -               }
>> -       }
>> -
>>         /*
>>          * Initialize ACPI Event handling (Fixed and General Purpose)
>>          *
>> diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
>> index d768d9c568cf..2da5f4a6e814 100644
>> --- a/include/acpi/acconfig.h
>> +++ b/include/acpi/acconfig.h
>> @@ -67,7 +67,6 @@
>>   *      General Purpose Events (GPEs)
>>   *      Global Lock
>>   *      ACPI PM timer
>> - *      FACS table (Waking vectors and Global Lock)
>>   */
>>  #ifndef ACPI_REDUCED_HARDWARE
>>  #define ACPI_REDUCED_HARDWARE           FALSE
>> --
>> 2.43.0
>>
>>

