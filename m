Return-Path: <linux-acpi+bounces-13127-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B99BA94819
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Apr 2025 17:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFE93A7A99
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Apr 2025 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0351A20409D;
	Sun, 20 Apr 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx5/HeRF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD8204092;
	Sun, 20 Apr 2025 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745161410; cv=none; b=J+uUPkvHX0rqQHkMAzR/UjJ2XxYTw9r9kKJ9s4SvEKaPRMeLX+vA4PPZ8VcxcuWPZAbTaZtNmSQsAO1zwo8bA8+9GMWnAsVDEbGqfKDv7MzG7C9QlSIc1bewAtwhgTRGJoZUj8EFUtGwWNQylJ43VJuIgQV73acsWxtLBtAj+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745161410; c=relaxed/simple;
	bh=+9LASRl2tgiRL4NDDl2k5h76QKgodPrX8V3hIsjXurM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/XP0Ji2F5shniqpkk0EkVqFK1y9GTDA9wNGubk8upNnl/nAHr8VjNKPEcyOIwAFBc8E2xMGLkfoIWWAoFrUgVlPKejBlic6HZn6rGrR8LdWnx9bgqqAdPouk+zZR4bhzyHDtVH/V6aCmJWlIqiLMkMG4jlsAR0gx5CetySqbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx5/HeRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC3FC4CEEA;
	Sun, 20 Apr 2025 15:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745161410;
	bh=+9LASRl2tgiRL4NDDl2k5h76QKgodPrX8V3hIsjXurM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zx5/HeRFwBrmjSFw1REvNL3vj0IZsJSDfKtDVNvpLmanUImD20fZAwCR56V7rOB4M
	 cRdjQ/J95hnsgJK6MQqb7kUz4WlttDfLGyxw7qd4KmkeLF7SOCcOpAlBhAPjc36YDP
	 dfrhVhIuOJNda+976grF/DTjvq+YxlV5Kf4zBO7lZTwfp9r3iCXc4mN5KvuByI2OEW
	 6aQ+pzUmVo7BRe4ommF+Vj3VUkG6+QkKQTk7V/CAwBBGGGgAtPL/rbvY6HeuZ29esH
	 KN/HDf4R0raRixi7Yp6iefHOcGA+aW26SSkPiOvcSMoVQtcqMZQtSx9+xArO+8EBw+
	 jSdn0iHXB8CVg==
Message-ID: <a5353fe9-bcd2-4afe-97b5-76d61da8de49@kernel.org>
Date: Sun, 20 Apr 2025 10:03:28 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ACPI: EC: Set ec_no_wakeup for MECHREVO Wujie 14XA
 (GX4HRXL)
To: Rong Zhang <i@rong.moe>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, Mingcong Bai <jeffbai@aosc.io>,
 Yemu Lu <prcups@krgm.moe>, Xinhui Yang <cyan@cyano.uk>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, Runhua He <hua@aosc.io>,
 linux-kernel@vger.kernel.org
References: <20250418112229.93075-1-hua@aosc.io>
 <eff33a971679fb47f5c9da9fd39f433a8e997089.camel@rong.moe>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <eff33a971679fb47f5c9da9fd39f433a8e997089.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rong,

On 4/20/25 05:05, Rong Zhang wrote:
> Hi Mario,
> 
> I noticed a patch [1] of yours fixed an identical issue on old AMD
> platforms with outdated platform firmware while another recent patch
> [2] set ec_no_wakeup for Lenovo Go S, and you are the author of amd-
> debug-tools (hence also amd_s2idle.py). Could you kindly take a look at
> this?
> 
> I reached Runhua in private, asking him to try disabling
> /sys/kernel/irq/1/wakeup and
> /sys/bus/serio/devices/serio0/power/wakeup to reproduce the effect of
> patch [1]. Doing so also worked around the issue.
> 
> [1]: 8e60615e8932 ("platform/x86/amd: pmc: Disable IRQ1 wakeup for
> RN/CZN")

Yeah; we concluded this is a bug in AMD platform firmware.

Similarly we have applied that same quirk for some BIOS versions of the 
Framework 13 7040 model:

a55bdad5dfd1e ("platform/x86/amd/pmc: Disable keyboard wakeup on AMD 
Framework 13")
f609e7b1b49e4 ("platform/x86/amd/pmc: Extend Framework 13 quirk to more 
BIOSes")

In Framework's case this was fixed by their BIOS, so it only matches two 
versions of their firmware.

> [2]: b988685388ef ("ACPI: EC: Set ec_no_wakeup for Lenovo Go S")

In this case we found that the root cause for this issue is actually the 
touchscreen. This was confirmed with an oscilloscope and by a hardware 
modification.

> 
> Thanks,
> Rong

Adding the platform into one quirk lists *might* be the right outcome, 
but I would like to understand more about the failure first.

Would you please open a bug report on 
https://gitlab.freedesktop.org/drm/amd/-/issues and attach the s2idle 
report?

We can go back and forth there to decide.

Thanks,
> 
> On Fri, 2025-04-18 at 19:22 +0800, Runhua He wrote:
>> MECHREVO Wujie 14XA (GX4HRXL) wakes up immediately after s2idle entry.
>> This happens regardless of whether the laptop is plugged into AC power, or
>> whether any peripheral is plugged into the laptop.
>>
>> Using `amd_s2idle.py --debug-ec', we found that the laptop has a wakeup
>> event triggered by IRQ 1 (PS/2 Controller) and IRQ 9 (ACPI SCI), and was
>> eventually woken up by IRQ 9. Taking a look at `dmesg', we found that the
>> EC was quite chatty after s2idle entry:
>>
>> [ 1842.317151] PM: suspend-to-idle
>> [ 1842.317178] ACPI: EC: ACPI EC GPE status set
>> [ 1842.317184] ACPI: EC: IRQ (5)
>> [ 1842.317190] ACPI: EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
>> [ 1842.317196] ACPI: EC: Polling enabled
>> [ 1842.317198] ACPI: EC: Command(QR_EC) submitted/blocked
>> [ 1842.317202] ACPI: EC: ACPI EC GPE dispatched
>> [ 1842.317248] ACPI: EC: Event started
>> [ 1842.317259] ACPI: EC: 2: Increase command
>> [ 1842.317264] ACPI: EC: Command(QR_EC) started
>> [ 1842.317271] ACPI: EC: TASK (14)
>> [ 1842.317288] ACPI: EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
>> [ 1842.317294] ACPI: EC: EC_SC(W) = 0x84
>> [ 1842.317303] ACPI: EC: TASK (14)
>> [ 1842.317324] ACPI: EC: EC_SC(R) = 0x2a SCI_EVT=1 BURST=0 CMD=1 IBF=1 OBF=0
>> [ 1842.317329] ACPI: EC: TASK (14)
>> [ 1842.317336] ACPI: EC: EC_SC(R) = 0x2a SCI_EVT=1 BURST=0 CMD=1 IBF=1 OBF=0
>>
>> [...]
>>
>> [ 1842.317399] ACPI: EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
>> [ 1842.317405] ACPI: EC: TASK (14)
>> [ 1842.317412] ACPI: EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
>> [ 1842.317418] ACPI: EC: TASK (14)
>> [ 1842.317425] ACPI: EC: EC_SC(R) = 0x29 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=1
>> [ 1842.317432] ACPI: EC: EC_DATA(R) = 0x7b
>> [ 1842.317436] ACPI: EC: Command(QR_EC) unblocked
>> [ 1842.317445] ACPI: EC: Polling quirk
>> [ 1842.317448] ACPI: EC: TASK (14)
>> [ 1842.317455] ACPI: EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
>> [ 1842.317463] ACPI: EC: Polling enabled
>> [ 1842.317466] ACPI: EC: Command(QR_EC) submitted/blocked
>> [ 1842.317469] ACPI: EC: Polling disabled
>> [ 1842.317472] ACPI: EC: Command(QR_EC) completed by hardware
>> [ 1842.317476] ACPI: EC: Command(QR_EC) stopped
>> [ 1842.317480] ACPI: EC: 1: Decrease command
>> [ 1842.317484] ACPI: EC: Query(0x7b) scheduled
>> [ 1842.317495] ACPI: EC: 2: Increase command
>> [ 1842.317499] ACPI: EC: Command(QR_EC) started
>> [ 1842.317504] ACPI: EC: TASK (14)
>> [ 1842.317516] ACPI: EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
>> [ 1842.317521] ACPI: EC: EC_SC(W) = 0x84
>> [ 1842.317529] ACPI: EC: TASK (14)
>> [ 1842.317537] ACPI: EC: EC_SC(R) = 0x0a SCI_EVT=0 BURST=0 CMD=1 IBF=1 OBF=0
>> [ 1842.317543] ACPI: EC: TASK (14)
>> [ 1842.317550] ACPI: EC: EC_SC(R) = 0x0a SCI_EVT=0 BURST=0 CMD=1 IBF=1 OBF=0
>> [ 1842.317555] ACPI: EC: TASK (14)
>>
>> [...]
>>
>> [ 1842.317638] ACPI: EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
>> [ 1842.317643] ACPI: EC: TASK (14)
>> [ 1842.317650] ACPI: EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
>> [ 1842.317656] ACPI: EC: TASK (14)
>> [ 1842.317663] ACPI: EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
>> [ 1842.317670] ACPI: EC: EC_DATA(R) = 0x00
>> [ 1842.317674] ACPI: EC: Command(QR_EC) unblocked
>> [ 1842.317682] ACPI: EC: Polling quirk
>> [ 1842.317685] ACPI: EC: TASK (14)
>> [ 1842.317692] ACPI: EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
>> [ 1842.317697] ACPI: EC: Polling disabled
>> [ 1842.317700] ACPI: EC: Command(QR_EC) completed by hardware
>> [ 1842.317704] ACPI: EC: Command(QR_EC) stopped
>> [ 1842.317707] ACPI: EC: 1: Decrease command
>> [ 1842.317711] ACPI: EC: Event stopped
>> [ 1842.317723] ACPI: EC: Query(0x7b) started
>> [ 1842.318142] ACPI: EC: Query(0x7b) stopped
>> [ 1842.318150] ACPI: EC: ACPI EC work flushed
>> [ 1842.318158] ACPI: PM: Rearming ACPI SCI for wakeup
>> [ 1842.318169] amd_pmc: SMU idlemask s0i3: 0x1ffb3ebd
>> [ 1842.318193] PM: Triggering wakeup from IRQ 9
>> [ 1842.318244] ACPI: EC: ACPI EC GPE status set
>> [ 1842.318249] ACPI: EC: IRQ (5)
>> [ 1842.318254] ACPI: EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
>> [ 1842.318263] ACPI: PM: Rearming ACPI SCI for wakeup
>>
>> I'm not quite sure what the EC was during this time. As
>> `acpi.ec_no_wakeup=1' works around this issue, I believe that the EC had
>> for some reason caused the system to wake up.
>>
>> Browsing the source code, I found that in `drivers/acpi/ec.c',
>> `struct dmi_system_id acpi_ec_no_wakeup[]' records a few machines with
>> incorrect suspend behaviors caused by EC wakeup.
>>
>> As this struct corresponds to a series of machines that needs
>> `acpi.ec_no_wakeup' enabled by default, add GX4HRXL to this struct. Note
>> that I have only matched the motherboard model, as MECHREVO is a "white
>> label" manufacturer using commonly used chassis and motherboards - GX4HRXL
>> may be found in a variety of laptops sold under different brands and model
>> names.
>>
>> Since the reason behind this EC wakeup is not yet clear to me, I'm sending
>> this patch in hope of getting more comments and guidance on how to further
>> debug this issue.
>>
>> Suggested-by: Mingcong Bai <jeffbai@aosc.io>
>> Link: https://zhuanlan.zhihu.com/p/730538041
>> Tested-by: Yemu Lu <prcups@krgm.moe>
>> Co-developed-by: Xinhui Yang <cyan@cyano.uk>
>> Signed-off-by: Xinhui Yang <cyan@cyano.uk>
>> Co-developed-by: Rong Zhang <i@rong.moe>
>> Signed-off-by: Rong Zhang <i@rong.moe>
>> Signed-off-by: Runhua He <hua@aosc.io>
>> ---
>>   drivers/acpi/ec.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>> index 3c5f34892..19f1d36a5 100644
>> --- a/drivers/acpi/ec.c
>> +++ b/drivers/acpi/ec.c
>> @@ -2329,6 +2329,12 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
>>   			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
>>   		}
>>   	},
>> +	{
>> +		/* MECHREVO Wujie 14 Series (GX4HRXL) */
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GX4HRXL"),
>> +		}
>> +	},
>>   	{ },
>>   };
>>   
> 


