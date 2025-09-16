Return-Path: <linux-acpi+bounces-17050-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 646A6B5A0D4
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 20:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298BF3208CA
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451E32877F7;
	Tue, 16 Sep 2025 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql1Ckjmv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207D48F6F
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758048927; cv=none; b=DY1RGcgfOefK5N5XhOjiNeoegCu1Y9KE8TBHkLMuKamqpN+9wn+CiRhVFnZU9NrOCHH7TDI3tolGGLhwMLOR4tocyisY6c3JaEWC5Rl68lQRkvhyssXwVYFXoORbH3s3GGXp4PJFtL4wPZ0xolMm5D4UxWNLqXCiACEgNdjvnzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758048927; c=relaxed/simple;
	bh=QjHIA772RWfA6526HOPxVHRy/CLWvfgjTa+3+fdiRdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITRlFdoC0q1IeGV/l2/3otRgo6z/RqoeB/Tp9YLQVyrhZ/vHxpdeycQZkvn1agicMVP9bxHtuzxla033hqAm6eUCPeLNATykSa79gU3dK0RzHoUFJHkpL39EBM9PbTpL84qbEeSQzE/LVVd9DHryLXIe+M9SxK0I5vSyYbHsZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql1Ckjmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499D8C4CEEB;
	Tue, 16 Sep 2025 18:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758048926;
	bh=QjHIA772RWfA6526HOPxVHRy/CLWvfgjTa+3+fdiRdA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ql1CkjmvGAMADp64JVODV1z1teSYOFTneeqXF5p/MxV34Xj4t6DNztnjGM/nreJBk
	 QBn1Ab/u7W1tn52sEyQyx+y1Gqciy2uGnTXa6SMvRwjzxyeWxPvebjrcV3CX2ZEMPP
	 SKIPfDp8Nqk7FOdMZK/c9TpSdsV4w5nRUMPvhf6ER3h4un8y0pMDBAhuFY4/yG/a2G
	 n88sCJfuDGX808dHdKEFj4FgRe3XaCvVnLaVuwmIqukwIhx6TwvsmIuJ2aeJtmaiRX
	 XAZ6nONqi49TLaoXgQtLu5Oaiy4KbU5mylKaLKptztVOlU8P4kQNi54cn80mHatfJY
	 YyJ9S3RubINNw==
Message-ID: <6efd9fea-92d3-4731-8bfb-cd5366227acf@kernel.org>
Date: Tue, 16 Sep 2025 13:55:25 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ACPI: processor: Add support for ACPI C4 state
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
References: <20250915204318.696058-1-superm1@kernel.org>
 <20250915204318.696058-3-superm1@kernel.org>
 <CAJZ5v0haE_XDZa8r+Dy_jrtGhqqgwDZVJMnpapA7xdESycWWrQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0haE_XDZa8r+Dy_jrtGhqqgwDZVJMnpapA7xdESycWWrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/16/25 6:24 AM, Rafael J. Wysocki wrote:
> On Mon, Sep 15, 2025 at 10:43 PM Mario Limonciello (AMD)
> <superm1@kernel.org> wrote:
>>
>> The _CST object described in the ACPI specification [1] allows processors
>> to support any arbitrary number of power states that are described by
>> a package describing the register used, the type of C-state, latency
>> and the power consumption.
>>
>> Currently the Linux kernel supports up to ACPI C3, and if a system
>> supports any further states they are ignored.  This causes problems on
>> some AMD hardware which can support up to ACPI C4.
>>
>> AMD systems that support up to C3 will enter CPUOFF and VDDOFF
>> when entering C3. Systems that support up to C4 will enter CPUOFF
>> when going to C3 and will enter VDDOFF when entering into C4.
>>
>> The existing semantics for bus mastering around C3 are also valid for C4,
>> so instead of hardcoding to C3, map then >= C3. In the case of s2idle
>> detect the deepest C-state supported and enter the deepest.
>>
>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/08_Processor_Configuration_and_Control/declaring-processors.html?#cst-c-states [1]
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/acpi/processor_idle.c | 10 +++++++---
>>   include/acpi/actypes.h        |  5 +++--
>>   2 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 5dacf41d7cc0a..537b0119535ea 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -444,6 +444,10 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
>>                  case ACPI_STATE_C3:
>>                          acpi_processor_power_verify_c3(pr, cx);
>>                          break;
>> +               case ACPI_STATE_C4:
>> +                       if (!cx->latency || !cx->address)
>> +                               break;
>> +                       cx->valid = 1;
>>                  }
>>                  if (!cx->valid)
>>                          continue;
>> @@ -685,7 +689,7 @@ static int __cpuidle acpi_idle_enter(struct cpuidle_device *dev,
>>                  return -EINVAL;
>>
>>          if (cx->type != ACPI_STATE_C1) {
>> -               if (cx->type == ACPI_STATE_C3 && pr->flags.bm_check)
>> +               if (cx->type >= ACPI_STATE_C3 && pr->flags.bm_check)
>>                          return acpi_idle_enter_bm(drv, pr, cx, index);
>>
>>                  /* C2 to C1 demotion. */
>> @@ -708,7 +712,7 @@ static int __cpuidle acpi_idle_enter_s2idle(struct cpuidle_device *dev,
>>   {
>>          struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
>>
>> -       if (cx->type == ACPI_STATE_C3) {
>> +       if (cx->index == drv->state_count - 1) {
>>                  struct acpi_processor *pr = __this_cpu_read(processors);
>>
>>                  if (unlikely(!pr))
>> @@ -754,7 +758,7 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
>>                  if (lapic_timer_needs_broadcast(pr, cx))
>>                          state->flags |= CPUIDLE_FLAG_TIMER_STOP;
>>
>> -               if (cx->type == ACPI_STATE_C3) {
>> +               if (cx->type >= ACPI_STATE_C3) {
>>                          state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
>>                          if (pr->flags.bm_check)
>>                                  state->flags |= CPUIDLE_FLAG_RCU_IDLE;
>> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
>> index 8fe893d776dde..6c9f472af482c 100644
>> --- a/include/acpi/actypes.h
>> +++ b/include/acpi/actypes.h
>> @@ -600,8 +600,9 @@ typedef u64 acpi_integer;
>>   #define ACPI_STATE_C1                   (u8) 1
>>   #define ACPI_STATE_C2                   (u8) 2
>>   #define ACPI_STATE_C3                   (u8) 3
>> -#define ACPI_C_STATES_MAX               ACPI_STATE_C3
>> -#define ACPI_C_STATE_COUNT              4
>> +#define ACPI_STATE_C4                   (u8) 4
>> +#define ACPI_C_STATES_MAX               ACPI_STATE_C4
>> +#define ACPI_C_STATE_COUNT              5
> 
> Don't you need to update ACPICA accordingly?

Thanks, I've got a PR opened.

> 
>>
>>   /*
>>    * Sleep type invalid value
>> --
> 
> The current point in the cycle is kind of unsuitable for changes like
> this.  I'd prefer to revisit it after 6.18-rc1.

OK! I wanted this out a few weeks ago but was waiting for positive Q/A 
results.

I'll rebase/resend after 6.18-rc1.


