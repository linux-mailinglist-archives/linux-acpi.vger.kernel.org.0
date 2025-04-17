Return-Path: <linux-acpi+bounces-13090-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D5AA91B88
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 14:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4448A0453
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 12:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DE423F40C;
	Thu, 17 Apr 2025 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmgY/nN4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA068197A8A;
	Thu, 17 Apr 2025 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744891416; cv=none; b=lcKVhyzcmDtJzgWlGb6WwsPcs7HbaZn+eYTa/uR5wH/QVhKM3h1FNkxoz3DsAL0huUleJtMOsym4tlGxQj0M2VR8ZD22bwxYnR8XnlaP09tDTHphrYCKeOZvbk429LJGiliAbuWMbKAJ15sCUbrOUUk94nWNHAuB+7/Gh6Xi1Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744891416; c=relaxed/simple;
	bh=cOq9eqXqmc1PFM9I6HGHBJRy8g60NzwMTQLnPS9m5Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNhsF1Gd2Gbl5ejbXZH88aWOt9IguzQF4bBFAahovmII4NdIuB0Qni5PH4C9+FD2cDPoA6xlvm/IKawpwa44pKufccG8X2wY1QvxsMOeG89082e1p/O1xyKPO2xJzUO/dSfvc6wi4E8TZbJCbCLw0vLz1KCXu2Ut5blWJDu0mbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmgY/nN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D20EC4CEE4;
	Thu, 17 Apr 2025 12:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744891416;
	bh=cOq9eqXqmc1PFM9I6HGHBJRy8g60NzwMTQLnPS9m5Bo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NmgY/nN41M5FegtwQoDDPcMLHwKngGckjBzerQQFGLUQg+Vtm3xY2O0e6lCScwxlq
	 npFctPm0QdZdKGSuyNQY4slHlW5qjNwUK2fY0WZztG/IGRssnbMoXCPKKm7+R3V49+
	 YMnaKGrvFxnu1nns8NWEaLEggeYeJI1htIDTBJXvqJvVlHBhjJxyoZndAgsEE+aRF4
	 QFNFQwn+Z7ebV+s1uuMGEkn7ZcM/qa6Ku2iFiRbiLaBioyVI3DemQYwARZTWxLpFSd
	 iD16q3iZ9zw479PrJxrBflxL/XC5fMB2xXN42EQbVi9RkuBAY4pxO7iyTFk+8OI6zE
	 rYGqrwB+Gmu+g==
Message-ID: <90fcc29b-be8e-44b3-b6bb-a1ef06096520@kernel.org>
Date: Thu, 17 Apr 2025 07:03:34 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPICA: Add support for printing AML arguments when
 trace point enabled
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mario.limonciello@amd.com, robert.moore@intel.com,
 rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20250417031040.514460-1-superm1@kernel.org>
 <CAJZ5v0iQMOY1NhpE9Hy0jD6iKQeFbdxB4ZWj5KZcsbApwZ_RhQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0iQMOY1NhpE9Hy0jD6iKQeFbdxB4ZWj5KZcsbApwZ_RhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/17/25 06:19, Rafael J. Wysocki wrote:
> On Thu, Apr 17, 2025 at 5:10 AM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> When debug level is set to `ACPI_LV_TRACE_POINT` method start and
>> exit are emitted into the debug logs. This can be useful to understand
>> call paths, however none of the arguments for the method calls are
>> populated even when turning up other debug levels.
>>
>> This can be useful for BIOSes that contain debug strings to see those
>> strings. When `ACPI_LV_TRACE_POINT` is set also output all of the arguments
>> for a given method call.
>>
>> This enables this type of debugging:
>>
>> ```
>> extrace-0138 ex_trace_point        : Method Begin [0x0000000096b240c4:\M460] execution.
>> extrace-0173 ex_trace_args         :  "  POST CODE: %X  ACPI TIMER: %X  TIME: %d.%d ms\n", b0003f53, 1a26a8b2, 0, 15e, 0, 0
>> extrace-0138 ex_trace_point        : Method End [0x0000000096b240c4:\M460] execution.
>> ```
>>
>> Link: https://github.com/acpica/acpica/commit/08219d91b5678ae2fae6e4f208df790a4e108c1c
> 
> The link doesn't work.

Are you sure?

I just tried again and it worked for me.

> 
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> This is a backport from upstream ACPICA.  I'm not sure if there is a script
>> that converts code style, so I just manually adjusted to kernel code style.
>> It is really useful for me for debugging; so I would ideally like to see it
>> go for 6.16 if possible.
>>
>> v2:
>>   * handle non-CONFIG_ACPI_DEBUG W=1 build
>> ---
>>   drivers/acpi/acpica/acinterp.h |  3 ++
>>   drivers/acpi/acpica/dsmthdat.c |  1 +
>>   drivers/acpi/acpica/extrace.c  | 51 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 55 insertions(+)
>>
>> diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
>> index 955114c926bd0..d02779ee92103 100644
>> --- a/drivers/acpi/acpica/acinterp.h
>> +++ b/drivers/acpi/acpica/acinterp.h
>> @@ -120,6 +120,9 @@ void
>>   acpi_ex_trace_point(acpi_trace_event_type type,
>>                      u8 begin, u8 *aml, char *pathname);
>>
>> +void
>> +acpi_ex_trace_args(union acpi_operand_object **params, u32 count);
>> +
>>   /*
>>    * exfield - ACPI AML (p-code) execution - field manipulation
>>    */
>> diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
>> index eca50517ad824..5393de4dbc4ca 100644
>> --- a/drivers/acpi/acpica/dsmthdat.c
>> +++ b/drivers/acpi/acpica/dsmthdat.c
>> @@ -188,6 +188,7 @@ acpi_ds_method_data_init_args(union acpi_operand_object **params,
>>
>>                  index++;
>>          }
>> +       acpi_ex_trace_args(params, index);
>>
>>          ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%u args passed to method\n", index));
>>          return_ACPI_STATUS(AE_OK);
>> diff --git a/drivers/acpi/acpica/extrace.c b/drivers/acpi/acpica/extrace.c
>> index b5e4bb4ae3ce6..e4721504c390d 100644
>> --- a/drivers/acpi/acpica/extrace.c
>> +++ b/drivers/acpi/acpica/extrace.c
>> @@ -147,6 +147,57 @@ acpi_ex_trace_point(acpi_trace_event_type type,
>>          }
>>   }
>>
>> +/*******************************************************************************
>> + *
>> + * FUNCTION:    acpi_ex_trace_args
>> + *
>> + * PARAMETERS:  params            - AML method arguments
>> + *              count             - numer of method arguments
>> + *
>> + * RETURN:      None
>> + *
>> + * DESCRIPTION: Trace any arguments
>> + *
>> + ******************************************************************************/
>> +
>> +void
>> +acpi_ex_trace_args(union acpi_operand_object **params, u32 count)
>> +{
>> +       u32 i;
>> +
>> +       ACPI_FUNCTION_NAME(ex_trace_args);
>> +
>> +       for (i = 0; i < count; i++) {
>> +               union acpi_operand_object *obj_desc = params[i];
>> +
>> +               if (!i) {
>> +                       ACPI_DEBUG_PRINT((ACPI_DB_TRACE_POINT, " "));
>> +               }
>> +
>> +               switch (obj_desc->common.type) {
>> +               case ACPI_TYPE_INTEGER:
>> +                       ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, "%llx", obj_desc->integer.value));
>> +                       break;
>> +               case ACPI_TYPE_STRING:
>> +                       if (!obj_desc->string.length) {
>> +                               ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, "NULL"));
>> +                               continue;
>> +                       }
>> +                       if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_TRACE_POINT, _COMPONENT))
>> +                               acpi_ut_print_string(obj_desc->string.pointer, ACPI_UINT8_MAX);
>> +                       break;
>> +               default:
>> +                       ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, "Unknown"));
>> +                       break;
>> +               }
>> +               if (i+1 == count) {
>> +                       ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, "\n"));
>> +               } else {
>> +                       ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, ", "));
>> +               }
>> +       }
>> +}
>> +
>>   /*******************************************************************************
>>    *
>>    * FUNCTION:    acpi_ex_start_trace_method
>> --
>> 2.43.0
>>
>>


