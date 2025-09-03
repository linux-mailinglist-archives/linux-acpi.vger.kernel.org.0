Return-Path: <linux-acpi+bounces-16344-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF50DB42801
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 19:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F05C189FB3F
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E4721858D;
	Wed,  3 Sep 2025 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+odmW40"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1484C92;
	Wed,  3 Sep 2025 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920755; cv=none; b=bXk4EGaBHg4nIZL/ZLWUN3Ov9KOk4oP6drWc7dODHzyHZopP9VfBbJ5RLAmVfW+b+G+ekLqF6ViCrXGdEdpU1OxmqIQ+/X1HcOBm5vw+upyENo3/90oiZu6fo+YIivTDlEsQYPsLKFt5weT0TE1LIFE3RHlkVD0CX224jaba12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920755; c=relaxed/simple;
	bh=XyCyaQqKiIYeF4kqKMzSg4kGIZw/yuZU3kEW5CRqxEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxE5sbR/oCig7oqZPxEinvDWYPkmAt2aipvJdfTl7ghoT3LdDn8wPMtskhdMwfYjJq73xBCO0V44HxP2yeBg6ZJjICH4QnrY4rKSZTVdhl7qfvNt9yWeRyEojQkSghzFxs51DEQbJn1D3dCSnFVO764dzM4jpPai12UQUYLNxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+odmW40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D738C4CEE7;
	Wed,  3 Sep 2025 17:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756920754;
	bh=XyCyaQqKiIYeF4kqKMzSg4kGIZw/yuZU3kEW5CRqxEk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R+odmW40nBrPK0zs24/dDFn9fdCh72hxh83Q4erCHYX6gQ3b0R4SyK2alwSQLxLFK
	 Wj+/NsnIgbIZxKS61LzwnBmo+YD5rfXsEOgWxaipqsPEvaQMshvx6jdgNnURw70Dms
	 T7GarHudVdTrnu/OdREJN9st4H/wTWI1Ijr/60vJ/fGZ88anY5nC5S7yh39jQkUt+D
	 lPyhbX+jha0AH36UP7zjlqtgbjculkNFYN+i3p3tkeYHBcDh0fA3qbq85+QqQamCX1
	 As1F//kFJNaJ98SaC689NSqTfrQWKZPYYYWh0BIDW84OzN4hQ+O7icdqJZcu59xBBv
	 mwDPROjmvWnsA==
Message-ID: <7a3a3a35-27d3-4b46-b297-475deda04656@kernel.org>
Date: Wed, 3 Sep 2025 12:32:33 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] MECHREVO Yilong15Pro GM5HG7A: lid switch causing unwanted
 s2idle wakeups
To: aprilgrimoire <aprilgrimoire@proton.me>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <6ww4uu6Gl4F5n6VY5dl1ufASfKzs4DhMxAN8BuqUpCoqU3PQukVSVSBCl_lKIzkQ-S8kt1acPd58eyolhkWN32lMLFj4ViI0Tdu2jwhnYZ8=@proton.me>
 <06f0c531-2cb6-4a1a-a716-406b4f5f9676@kernel.org>
 <MawTZCnf5jVqp47YcxRrH21nl0rN8O78_my4TxiZ3tFoNxuP568eHxnEH5-VIMa6DtNbHdXytnpRgVyay-UydMK5tbYe4-TG8e2BYEky5hc=@proton.me>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <MawTZCnf5jVqp47YcxRrH21nl0rN8O78_my4TxiZ3tFoNxuP568eHxnEH5-VIMa6DtNbHdXytnpRgVyay-UydMK5tbYe4-TG8e2BYEky5hc=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/25 12:13 PM, aprilgrimoire wrote:
> 
>> Hi,
>>
>> Can you please reproduce the issue using 'amd-s2idle' from
>> https://pypi.org/project/amd-debug-tools/ ?
>>
>> Basically install the wheel, run 'amd-s2idle test'. When prompted how
>> long, set it for ~20 seconds. Then wait for the LED to flash and close
>> the lid and it should wake up and generate a report.
>>
>> This will capture a lot of artifacts about the problem in the report and
>> we can go from there on next steps. Ideally if you can put the report
>> on a new issue here and tag me (@superm1):
>> https://gitlab.freedesktop.org/drm/amd/-/issues
>> We can iterate back and forth on it to come up with the best solution.
>>
>> Thanks,
> 
> Hi! Here's the output:
> 
> https://paste.gentoo.zip/mpV8dQcl
> 
> I disabled the patched dsdt since with it amd-s2idle would think ASPM Policy is set to power-saving and refuse to run.
> 
> It's late here and I'll probably return tomorrow. Thanks!

IRQ1 doesn't show up in this report, so this is not a problem with the 
keyboard wakeup.

There's a few things that stand out to me.

1) There are ACPI errors with the PEP _DSM; specificially the screen on 
action.  This isn't likely the cause of this issue but it's most 
definitely a BIOS bug.

     ACPI BIOS Error (bug): Could not resolve symbol [\_SB.ACDC.RTAC], 
AE_NOT_FOUND (20250404/psargs-332)
     ACPI Error: Aborting method \_SB.PEP._DSM due to previous error 
(AE_NOT_FOUND) (20250404/psparse-529)
     ACPI: \_SB_.PEP_: Failed to transitioned to state screen on

2) The wakeup is from IRQ 7 (like you said) which is the GPIO controller.
     PM: Triggering wakeup from IRQ 7
     Woke up from IRQ 7 (IR-IO-APIC 7-fasteoi pinctrl_amd)

The GPIO controller wakes up the system when any of the pins that are 
marked as wake pins are triggered.  In your case this is GPIO 0.
     GPIO 0 is active: 0x38157800

According to the SSDT _EVT handler this notifies the _PWRB ACPI object.

                     Case (Zero)
                     {
                         M000 (0x3900)
                         Notify (\_SB.PWRB, 0x80) // Status Change
                     }

We can see that notify happened here:
     Dispatching Notify on [PWRB] (Device) Value 0x80 (Status Change)

So based on above what it looks like is going on to me is that the lid 
is likely indirectly tied to GPIO 0 in this design.  It's not clear if 
it's a mux, directly connected or if the EC drives that GPIO or what not.

It's worth noting that we did have a Linux kernel change to turn off 
debounce for all GPIOs recently at suspend time [1].  You can see in 
your log this message associated with it.

     Clearing debounce for GPIO #0 during suspend.

I don't expect it's the cause of your issue, but you could try to revert 
it to confirm.

Instead I think what's going on is that they have their design expecting 
that Windows does a "dark screen wakeup".  This is where it exits a 
hardware sleep state but doesn't fully wake the system.  If no input 
activity happens then it goes back to hardware sleep.

This is something that common userspace (systemd on most systems) 
doesn't support today.

One option for you is to try to set this GPIO not to be a wake source by 
gpiolib_acpi.ignore_wake=AMDI0030:00@0.

If this helps, please also check whether this breaks power button wakeup 
though.  If it does we might be trading one wakeup source for another if 
they're muxed.

[1] 
https://github.com/torvalds/linux/commit/8ff4fb276e2384a87ae7f65f3c28e1e139dbb3fe

