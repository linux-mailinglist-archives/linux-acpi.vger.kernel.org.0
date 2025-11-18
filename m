Return-Path: <linux-acpi+bounces-19013-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A6EC68FBB
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 12:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9002D4E1F86
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E824306B2E;
	Tue, 18 Nov 2025 11:07:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD23D280CE0;
	Tue, 18 Nov 2025 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464062; cv=none; b=HL2JSnPzlvgIMUYf9h3sLMET2rJTTp0u76ElpnbV+iFt3DpbLbBQPLuNo+0cPHpHSx+AOW2AX8fHaf9i4ZGRUzechBZVyIcOGg2t8ZlkMJkFtpmPJleY/3mgYN/yVV+6zhMhZdopW++BoZiGYajFB9+pXGyjmSzv/HvdSGfsBkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464062; c=relaxed/simple;
	bh=Ivbmz8xN61PjYO7k9zYt6S4I72m0Yg0CfaZGAWsRPwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SB4DbycAgATdozYofTRFJSlfJnh1ZejlFX1qngSncIwtKAtIdEMx/GyaxCT9QKdvNmsP/RfEeuVkvHlnqIO1n0sxeTXqP149dvbSE0j4ZOlb28HRXaHsZ0aaulPZmV6JLCXHFPIg49M5AcCHXdNpxvqGmjjUZAU9D2D8pRyQuY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 872A3FEC;
	Tue, 18 Nov 2025 03:07:32 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 492833F66E;
	Tue, 18 Nov 2025 03:07:35 -0800 (PST)
Message-ID: <e217c4dc-dd66-4db0-a846-ca8ed462135e@arm.com>
Date: Tue, 18 Nov 2025 11:07:33 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/34] ACPI: Define acpi_put_table cleanup handler and
 acpi_get_table_ret() helper
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: james.morse@arm.com, amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, gshan@redhat.com,
 guohanjun@huawei.com, jeremy.linton@arm.com, jonathan.cameron@huawei.com,
 kobak@nvidia.com, lcherian@marvell.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, lpieralisi@kernel.org, peternewman@google.com,
 quic_jiles@quicinc.com, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Zeng Heng <zengheng4@huawei.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-9-ben.horgan@arm.com>
 <CAJZ5v0hAPoE96C7=ynR=Ex4huPP3b896sBRNdBiLe=3Q9vKwHQ@mail.gmail.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0hAPoE96C7=ynR=Ex4huPP3b896sBRNdBiLe=3Q9vKwHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 11/17/25 19:46, Rafael J. Wysocki wrote:
> On Mon, Nov 17, 2025 at 6:01 PM Ben Horgan <ben.horgan@arm.com> wrote:
>>
>> Define a cleanup helper for use with __free to release the acpi table when
>> the pointer goes out of scope. Also, introduce the helper
>> acpi_get_table_ret() to simplify a commonly used pattern involving
>> acpi_get_table().
>>
>> These are first used in a subsequent commit.
>>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>> Tested-by: Carl Worth <carl@os.amperecomputing.com>
>> Tested-by: Gavin Shan <gshan@redhat.com>
>> Tested-by: Zeng Heng <zengheng4@huawei.com>
>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
>> ---
>>  include/linux/acpi.h | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index a9dbacabdf89..1124b7dc79fd 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -8,6 +8,7 @@
>>  #ifndef _LINUX_ACPI_H
>>  #define _LINUX_ACPI_H
>>
>> +#include <linux/cleanup.h>
>>  #include <linux/errno.h>
>>  #include <linux/ioport.h>      /* for struct resource */
>>  #include <linux/resource_ext.h>
>> @@ -221,6 +222,17 @@ void acpi_reserve_initial_tables (void);
>>  void acpi_table_init_complete (void);
>>  int acpi_table_init (void);
>>
>> +static inline struct acpi_table_header *acpi_get_table_ret(char *signature, u32 instance)
> 
> Maybe call this acpi_get_table_pointer() ?

Ok, can do.

> 
>> +{
>> +       struct acpi_table_header *table;
>> +       int status = acpi_get_table(signature, instance, &table);
>> +
>> +       if (ACPI_FAILURE(status))
>> +               return ERR_PTR(-ENOENT);
>> +       return table;
>> +}
>> +DEFINE_FREE(acpi_put_table, struct acpi_table_header *, if (!IS_ERR_OR_NULL(_T)) acpi_put_table(_T))
>> +
>>  int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
>>  int __init_or_acpilib acpi_table_parse_entries(char *id,
>>                 unsigned long table_size, int entry_id,
>> --

Thanks,

Ben


