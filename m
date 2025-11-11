Return-Path: <linux-acpi+bounces-18766-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3B9C4B867
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 06:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B483A6EE5
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 05:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F32280035;
	Tue, 11 Nov 2025 05:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HML3rEDy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628672798E8;
	Tue, 11 Nov 2025 05:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762838235; cv=none; b=ogqes0E20S0mbA3suVkMcXxQt5ruxWY/Tq2jrKg/ucTlhEgveT8gWc4R/1kFysOkZRHti1WN8jU9o9UX6H273swvtpQGhMNMhC26uR49dbjkKYdK2B5/oisIGhGkvvvV2dpwVPoNo9DYkq2ocJ6foiZIG7COx2tAvpCKWgjFVlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762838235; c=relaxed/simple;
	bh=hjOPFaeauwey41qsMiqTUz+prPAurghEYgN371uYvlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGFJsS8ndiEMoRYiI2BWtZnt4prmT8M7AIQBWrTfF5DH5l0naht91Mul7QPb/7XqjXFXGseAqNZM+UcSGg5c/uS8NyjA6gqN2ptRToaP/UtdcRVLkbvFldx3abZGVcD3gZ9fsEY1LMBI8eBJiZScK0Wwh2kO1azIqDkgKVfm8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HML3rEDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EEEC116B1;
	Tue, 11 Nov 2025 05:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762838234;
	bh=hjOPFaeauwey41qsMiqTUz+prPAurghEYgN371uYvlU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HML3rEDy72dEJmUBeyg5e8MGKUojvs48aZYO96aXjYU3HvJ1g58iccqkznX9EXJvV
	 QVigw5Kgj8yBXUtnr+ccEdUdYH9XBkFcIPeH6VxG/nVcyAvQ9tCbsCO742DiTUpslg
	 C7XCXdxmo16fbbdv4WGZX1NgqetK3WYiryeYh6rNPEy/HHF41OpBYLX5buESZqVetM
	 3NudFI2Cp+DHvPQ3ajrTN7BFbYugJ97l2wuyYU3QAhtPczsdah3xYxF9gxUGYK/yol
	 JMFUhUf/T3zfWodAzjzwCByM0UCfBCl+wqldFIfCvriiIeUylJ6Vrx5Cs/y8tv8GTy
	 Xp7jWT7iFJy/w==
Message-ID: <d660801f-8551-4940-8555-1059e9d565f7@kernel.org>
Date: Mon, 10 Nov 2025 23:17:12 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] acpi: platform_profile - Add Extreme profile
 option
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hansg@kernel.org>
Cc: Armin Wolf <W_Armin@gmx.de>, Len Brown <lenb@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org,
 linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-acpi@vger.kernel.org
References: <20251106212121.447030-1-derekjohn.clark@gmail.com>
 <20251106212121.447030-2-derekjohn.clark@gmail.com>
 <701898dd-3310-e86d-7499-fca5a445447a@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <701898dd-3310-e86d-7499-fca5a445447a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/10/25 5:14 AM, Ilpo Järvinen wrote:
> On Thu, 6 Nov 2025, Derek J. Clark wrote:
> 
>> Some devices, namely Lenovo Legion devices, have an "extreme" mode where
>> power draw is at the maximum limit of the cooling hardware. Add a new
>> "extreme" platform profile to properly reflect this operating mode.
>>
>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
>> ---
>>   Documentation/ABI/testing/sysfs-class-platform-profile | 2 ++
>>   drivers/acpi/platform_profile.c                        | 1 +
>>   include/linux/platform_profile.h                       | 1 +
>>   3 files changed, 4 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
>> index dc72adfb830a..9bee8deb4dc9 100644
>> --- a/Documentation/ABI/testing/sysfs-class-platform-profile
>> +++ b/Documentation/ABI/testing/sysfs-class-platform-profile
>> @@ -23,6 +23,8 @@ Description:	This file contains a space-separated list of profiles supported
>>   					power consumption with a slight bias
>>   					towards performance
>>   		performance		High performance operation
>> +		extreme			Higher performance operation that may exceed
>> +					internal battery draw limits when on AC power
>>   		custom			Driver defined custom profile
>>   		====================	========================================
>>   
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>> index b43f4459a4f6..78da17e16d9b 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -37,6 +37,7 @@ static const char * const profile_names[] = {
>>   	[PLATFORM_PROFILE_BALANCED] = "balanced",
>>   	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
>>   	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
>> +	[PLATFORM_PROFILE_EXTREME] = "extreme",
>>   	[PLATFORM_PROFILE_CUSTOM] = "custom",
>>   };
>>   static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
>> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
>> index a299225ab92e..2bf178bde2b5 100644
>> --- a/include/linux/platform_profile.h
>> +++ b/include/linux/platform_profile.h
>> @@ -24,6 +24,7 @@ enum platform_profile_option {
>>   	PLATFORM_PROFILE_BALANCED,
>>   	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
>>   	PLATFORM_PROFILE_PERFORMANCE,
>> +	PLATFORM_PROFILE_EXTREME,
>>   	PLATFORM_PROFILE_CUSTOM,
>>   	PLATFORM_PROFILE_LAST, /*must always be last */
>>   };
>>
> 
> I wonder if "extreme" is the best name for this? Given the description you
> gave above, perhaps "max-power" would be more descriptive (and we already
> have "low-power" so it kind of feels fitting the theme too).
> 
> I don't have strong opinion on this so if you guys feel this suggestion
> would not make things better, feel free to voice it. :-)
> 

I don't feel strongly here, either sound find to me.


