Return-Path: <linux-acpi+bounces-12593-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECD4A77D85
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 16:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88FA3AEA4C
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56432040A4;
	Tue,  1 Apr 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ41Le0n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81471189F56
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743517110; cv=none; b=syceCBdzhNcNTdpry+YOIN+X3TKBjNzJNJHXf1L2yjvorg8B48Agf3sDi80F5rbGCBUoCnfHU8oeo3YrSWYE+290DbI3U0zC1tFB1XIz2Fk+En8552w867XDhONA3p+vpx2MJ0Q+2+YZJmaXgnmAZ5d2/RHAXDFGbk3dYdbpy2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743517110; c=relaxed/simple;
	bh=Egext6lGErG7mC8ugxnCnx/Vrry2PiqXpeeatjNXrfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvRRUOjqgWFFCQpCh0WUDQuwGipzUKGD97K97VsiPKxLaedhEiFXq2CGamw9zjr+kFtjfhzovjdqITBxcrYCVpNe1uG03qOHr2L1ThD+GX811WSPWr7+CY5dVeFL+K54BI8B+2r79saLh6nxwry+BkcabRlWCxPaPvdmAyvbsRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ41Le0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41241C4CEE9;
	Tue,  1 Apr 2025 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743517110;
	bh=Egext6lGErG7mC8ugxnCnx/Vrry2PiqXpeeatjNXrfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IQ41Le0nyxhktNduxlosRL5aGuZ91xbJNDmKXEfjIIsGepTsBKMB6HV7zjgrW21hU
	 SvuSOKvz/y5MidA1wWjZNXxW++RsjguEVaIci8L0GIcuhpsmU7xW9OffK/2H63qNfU
	 n4T7kO0q+tpjSlwe/m71tltxmPjxqTNzKEX6mte7Rm6RwJY3m2e5wjxni8gPFOXH07
	 h3ca25hr1z1236Lxs/xpZI+1F1Jpv87vnlpLgTjamdhrLfFnuBWCA5b7XwC+Qclwbh
	 G7GSIFLmizp43F7o46G0MEiWmufaLU8ZU5mXdpee6/0vWZe1lVSl4HwdzJkrOCs42D
	 mX3K8V/v1+yJg==
Message-ID: <a089c36a-09e1-445a-b689-a41163ca3db3@kernel.org>
Date: Tue, 1 Apr 2025 09:18:28 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mario.limonciello@amd.com, Xino JS1 Ni <nijs1@lenovo.com>,
 Antheas Kapenekakis <lkml@antheas.dev>, linux-acpi@vger.kernel.org
References: <20250401133858.1892077-1-superm1@kernel.org>
 <CAJZ5v0gqFhUSu5_JiA3Z3qZACcqa+9Tdqv6DqHCq_b5HGbF7Sg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0gqFhUSu5_JiA3Z3qZACcqa+9Tdqv6DqHCq_b5HGbF7Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/1/2025 8:48 AM, Rafael J. Wysocki wrote:
> On Tue, Apr 1, 2025 at 3:39 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> When AC adapter is unplugged or plugged in EC wakes from
>> HW sleep but APU doesn't enter back into HW sleep.
>>
>> The reason this happens is that when APU exits HW sleep the power rails
>> the EC controls will power up the TCON.
> 
> I think that the above should be
> 
> "The reason this happens is that, when the APU exits HW sleep, the
> power rails controlled by the EC will power up the TCON."
> 
> If I'm not mistaken, please let me know and I'll make this change when
> applying the patch.

Sounds good, thanks!

> 
>> The TCON has a GPIO that will
>> be toggled during this time.  The GPIO is not marked as a wakeup source,
>> however GPIO controller still has an unserviced interrupt. Unserviced
>> interrupts will block entering HW sleep again. Clearing the GPIO doesn't
>> help as the TCON continues to assert it until it's been initialized by
>> i2c-hid.
>>
>> Fixing this would require TCON F/W changes and it's already broken
>> in the wild on production hardware.
>>
>> To avoid triggering this issue add a quirk to avoid letting EC wake
>> up system at all.  The power button still works properly on this system.
>>
>> Cc: Xino JS1 Ni <nijs1@lenovo.com>
>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
>> Link: https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
>> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   Add more tags
>>   Fix a typo and grammar in commit
>> ---
>>   drivers/acpi/ec.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>> index 8db09d81918fb..3c5f34892734e 100644
>> --- a/drivers/acpi/ec.c
>> +++ b/drivers/acpi/ec.c
>> @@ -2301,6 +2301,34 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
>>                          DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
>>                  },
>>          },
>> +       /*
>> +        * Lenovo Legion Go S; touchscreen blocks HW sleep when woken up from EC
>> +        * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
>> +        */
>> +       {
>> +               .matches = {
>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
>> +               }
>> +       },
>> +       {
>> +               .matches = {
>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
>> +               }
>> +       },
>> +       {
>> +               .matches = {
>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
>> +               }
>> +       },
>> +       {
>> +               .matches = {
>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
>> +               }
>> +       },
>>          { },
>>   };
>>
>> --
>> 2.43.0
>>


