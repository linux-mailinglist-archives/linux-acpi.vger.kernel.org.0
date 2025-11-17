Return-Path: <linux-acpi+bounces-18926-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 227BCC61F2D
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 01:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83C4C35BCA4
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 00:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3281448E0;
	Mon, 17 Nov 2025 00:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="q9ETm0Ak"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC345C0B;
	Mon, 17 Nov 2025 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763338900; cv=none; b=brxCp89ATILoH/F530qAYCqcIUN43qlpeIBu9XhF0HNE82LVwpjHBn9WrnAinz7+VkDdQnZANBl1rOYtCaskN9xHfrU/F8Xbs3HyZENTaH7SbYj19YSFcj18r8Ll6eGmsUVH2Rkd5P+ZtTa6dhstZZlPjEgudvFWN3sNHfRe21s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763338900; c=relaxed/simple;
	bh=K2XzxeRxAj4pQZnP5TrJovV8B20SAYmi6b+U1eqsstc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sgr/TwoQekMbWP5KgEy9VnQumYcIb2jehDjSUCdAzWGxFTV3iuelJtM1d5R6JNIKRcFIOwJ103utIOv3ia0ByFhXWfm+xVsXIDuUvxOl9soMKvXhWU3bxGtlwQYy3P7CAOiWYC2XuKT1P/jfMfSuKAk+1TjcY1CperKm4IRIIU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=q9ETm0Ak; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763338883; x=1763943683; i=w_armin@gmx.de;
	bh=HyST/SII1VyW6P5EddT1+goaN9hsWo1UjQqlI8D9dEc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q9ETm0AkSASdebIeUGSOOekDqoueT6NEVb1za60PU8qAzeQftSOQ3567+XmSra7Z
	 /MtH852whvgph3uSiMMVo43YJc0NDfRo7vyK5pm7RuxYkSu+G7B8/2DtCK7F9+iVF
	 Ufglspy43BUg+cDxAbhHVHpbwUfNbJI8CguxDzFoVZS6uWAn0AMtPfYl+zsuw9dyX
	 wOtOMymP8X9hPhcY9kVg4UulWdJxn+9fq1Jhz21SvodyGa5F7CAgf4P8xVDZrOrwN
	 CshnAf5xhAw8S6D5sjPQJIOTLcdUalQH6+9Re0Fy2A49sP6sDvnRqBr9jtl3IhaKb
	 gsL8reKqeXo59iGDnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9kC-1vO4GV1JrY-008cgE; Mon, 17
 Nov 2025 01:21:23 +0100
Message-ID: <e801bef5-158e-4422-9c23-93dc2210f734@gmx.de>
Date: Mon, 17 Nov 2025 01:21:19 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] acpi: platform_profile - Add max-power profile
 option
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Mario Limonciello <superm1@kernel.org>,
 Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20251113212639.459896-1-derekjohn.clark@gmail.com>
 <20251113212639.459896-2-derekjohn.clark@gmail.com>
 <7050cadc-9cb7-4f9b-8393-247bddb56965@gmx.de>
 <CFD27662-0044-4AF3-8E66-65229324CECF@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CFD27662-0044-4AF3-8E66-65229324CECF@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CSGK0mezaJE1xhRq76VaK+U6B/Tz5/wfANA5pCeo8ZnSb5HkEji
 O0CGfYyST0Fvf5j/M7oeVeCL6yF2Au05DoxCsXuBNQfTmneaM/CzgDo0/bc8DyB9cq3Z3rB
 7nqdL3+GYJ+pJ1xKuxwcOtozR9EfMl7SjmY1o/ejhLmq9DEAoX3vav5kr6DRdYUdxnwrB8r
 aHh3jiHnV8PxmUQaJGwQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SMJUWIVD0Io=;L7uUC+W5hY3sEJJfIY16w61Y1rb
 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

Am 16.11.25 um 20:01 schrieb Derek J. Clark:

> On November 16, 2025 8:13:17 AM PST, Armin Wolf <W_Armin@gmx.de> wrote:
>> Am 13.11.25 um 22:26 schrieb Derek J. Clark:
>>
>>> Some devices, namely Lenovo Legion devices, have an "extreme" mode where
>>> power draw is at the maximum limit of the cooling hardware. Add a new
>>> "max-power" platform profile to properly reflect this operating mode.
>>>
>>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>>> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
>>> ---
>>>    Documentation/ABI/testing/sysfs-class-platform-profile | 2 ++
>>>    drivers/acpi/platform_profile.c                        | 1 +
>>>    include/linux/platform_profile.h                       | 1 +
>>>    3 files changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
>>> index dc72adfb830a..fcab26894ec3 100644
>>> --- a/Documentation/ABI/testing/sysfs-class-platform-profile
>>> +++ b/Documentation/ABI/testing/sysfs-class-platform-profile
>>> @@ -23,6 +23,8 @@ Description:	This file contains a space-separated list of profiles supported
>>>    					power consumption with a slight bias
>>>    					towards performance
>>>    		performance		High performance operation
>>> +		max-power		Higher performance operation that may exceed
>>> +					internal battery draw limits when on AC power
>> I am not sure if it is a good idea to allow platform_profile_cycle() to cycle into this
>> new max-power profile. The system could encounter a brownout if it is currently operating
>> on battery power when selecting max-power.
>>
>> Maybe we should prevent platform_profile_cylce() from selecting max-power?
> At least for Lenovo devices unplugging AC will automatically throttle the ppt values to roughly equivalent to performance. It will look at a different WMI data block for the values when switched, so there's no risk for cycling in this case. This seems like smart hardware design, but we've certainly seen bad hardware design so the concern is warranted. Perhaps it is worth visiting if another vendor implements it differently? That being said, what you're describing would match up with how the physical profile selection button works, so it would align with consumer expectation. I have no strong feelings either way, but I'm a little concerned about meeting the merge window as this series fixes a pretty disruptive bug affecting 6.17 users.
>
> Regards,
> - Derek
>
If the physical platform selection button does not automatically select the max-power profile under Windows, then we should copy this behavior i think.
The changes necessary for that are fairly small, basically you only have to extend the handling of PLATFORM_PROFILE_CUSTOM inside platform_profile_cycle()
to also include the max-power profile. So i would prefer if we modify platform_profile_cycle() now has doing this later might be seen as a regression.

Thanks,
Armin Wolf

>> Other than that:
>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>>
>>>    		custom			Driver defined custom profile
>>>    		====================	========================================
>>>    diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>>> index b43f4459a4f6..aa1dce05121b 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -37,6 +37,7 @@ static const char * const profile_names[] = {
>>>    	[PLATFORM_PROFILE_BALANCED] = "balanced",
>>>    	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
>>>    	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
>>> +	[PLATFORM_PROFILE_MAX_POWER] = "max-power",
>>>    	[PLATFORM_PROFILE_CUSTOM] = "custom",
>>>    };
>>>    static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
>>> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
>>> index a299225ab92e..855b28340e95 100644
>>> --- a/include/linux/platform_profile.h
>>> +++ b/include/linux/platform_profile.h
>>> @@ -24,6 +24,7 @@ enum platform_profile_option {
>>>    	PLATFORM_PROFILE_BALANCED,
>>>    	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
>>>    	PLATFORM_PROFILE_PERFORMANCE,
>>> +	PLATFORM_PROFILE_MAX_POWER,
>>>    	PLATFORM_PROFILE_CUSTOM,
>>>    	PLATFORM_PROFILE_LAST, /*must always be last */
>>>    };
>

