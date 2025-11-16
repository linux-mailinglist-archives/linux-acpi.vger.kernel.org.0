Return-Path: <linux-acpi+bounces-18924-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 383C2C61B2E
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Nov 2025 20:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A1C84E301F
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Nov 2025 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EA5221F34;
	Sun, 16 Nov 2025 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBApSxH2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E847D63B9
	for <linux-acpi@vger.kernel.org>; Sun, 16 Nov 2025 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763319680; cv=none; b=ilseXUsVU3Rmf5YK7jW7d/GHK5zDyhAvuJ/KWMrLRfU8CYV2cNMTNSOZVNfODe5jOUv7BuHkbKmbv8GMSelrGvts0ZYAufcfceEzB4gNxgiPOyQ0Nf7y48TgUyepMSOLCPdxoK0zWB4Ia8P7GOa3nPRmAKbo77BB8186P6tnw6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763319680; c=relaxed/simple;
	bh=cZS0PxUQPTpcN54RYE/jYvXcW+/9c/VgJLoIs03CWoU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZXrDNCdJ3q7toAcQ2exiI9oFALetQkn3TZfmnw0UWpLecvBJpj6xN9ZmpOqjGlW251oZ7iFEdHEbimwRWJq31a7MAMeGNyQsJtjspaQwI+mH9b9PYNmJgxNFAQ8I/jE7KhqU9HV96cGNO88DJX0gEmdAHVBSPVwe3WOEBvobwFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBApSxH2; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bc8ceb76c04so1302651a12.1
        for <linux-acpi@vger.kernel.org>; Sun, 16 Nov 2025 11:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763319678; x=1763924478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YOGEXFxwW48TjZB0mw3iozFgJleZ3SAxTi5WfDILBEc=;
        b=KBApSxH29kpjdiofXPV4IApRHe+VlYIcX6RbMVFIjVygEWNxuv+Vz0J0zRHieNEXO8
         zEIRrS5tm+ilpsC5fdQ4auOKc9vU/4vaFBoQd9Fcx5cCNTseselzk1F3rtaYU1gTCvo7
         RFlouxWP/TGMiEz1SN9J39pk16sIVnqxzQTgeBxVUOLx4zQfXjVQRBumGJemYSsw2cK7
         Sekemg45OyRwWsy6G3UBB0NncxLptr3mQjQEW1+rFY3Zl0gFcPANn70D1IqryFQqZ9B0
         I41dO8HBTIXm/ffj5kmSeHOfmsINSIXb06ED/FYAcaIiWt+IggAwyJrpiT3qrba0em5f
         77rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763319678; x=1763924478;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOGEXFxwW48TjZB0mw3iozFgJleZ3SAxTi5WfDILBEc=;
        b=njrh8IPjLuCU8YVPYAEcz13ORCArEKy9zG8CvmdL5Ti7/s12XLyMOR49b9R7lHXp0d
         J4ThuO8mvGyXLOVvxZCLkajMXoCKpiHMHT7Woo1e1JQZgWG41H7Y8s9B0SBuhVQOgUlv
         d3b49Fcnqq04e0qICJ3sCjNt0GlPxQGpyUmTys5mJfe4SJME8BMCd0/EcV0BKZEcOB+j
         XyMVMMBvMNKobKIRBVnX3g2snVh6j2vJqC+NFEp1RSs2dSsNeh504MXF9x7ePCSbLzgf
         ZD14cV+1InF27CgAmyzOkuWl0KCrtD4gQ8Vsch7YkbNeAeBb6Mwzq3Th1qknvfviPrXH
         rMHw==
X-Forwarded-Encrypted: i=1; AJvYcCWKQOJnSgtKGcJvliVeQTUdruFkATNuuA0rGTfQoE5f9b0hOwO7spWYg7LK+NX40KrtAgh+E0H7c4/A@vger.kernel.org
X-Gm-Message-State: AOJu0YxH59d6RhhGSWofoxpbKwcH7P4wgEhbai3FPs9LWI5EXrc3TMEg
	Dn+dTHcPUbUBN5P7Pet5bxkh8DKl1Tt+iHGi7kt49svdWUq1hG5y6qnQ
X-Gm-Gg: ASbGncvcXNU+hnZV7akqVOLN0NeZGWdOQDJtYqnafm6f7WvEtEYnya3GftiRrqGb6GW
	bKfxFCpkYVpgRftEV5U3PTwSF7tiUuddUoSXwSJ2TEaioopydOvPFzl7yY8+C/kMZiYl1e2wrih
	pi8IJi29OCkaUiI2KIcRSKNzUx2Ruu7goSsN1agZugn51fnv+0N2ezAM5naa8JKIgYM6yRlmw0A
	urIxvoBCndWe0NYr1a67Z1pB9rs76YF/7RlbCikyHYO7jW2Uazx9JnvnPFLfiL2K7I+hTf+CdMg
	HcgjnwgvrFkXAFuAN2BYlWp/SYw4VS5Rrd0fEKLrJSxAGroqFpcym9yszJSMAbUFcODH/7O+yBM
	WXOE2gZpITNlYr5/vWv9o31Ah/5CELZBcM0rkcH8x/f04ktbgwN+zqzm1tXOiXT8PyDRwl5T0ow
	2gPBOYsg5gUFykul1gis2Z8g==
X-Google-Smtp-Source: AGHT+IGzAZalYPBCrBdPjLHParF3LDK8Sa973po1LUxsJ1+1Lsk5MmBi0pKSSk4XLoBThUNykmuT9g==
X-Received: by 2002:a05:7301:4384:b0:2a4:3593:c7da with SMTP id 5a478bee46e88-2a4abd49e41mr3789692eec.26.1763319677891;
        Sun, 16 Nov 2025 11:01:17 -0800 (PST)
Received: from ehlo.thunderbird.net ([2607:fb91:1be4:38b7:ac39:c338:9a5e:57f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db102f5sm29610809eec.4.2025.11.16.11.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Nov 2025 11:01:16 -0800 (PST)
Date: Sun, 16 Nov 2025 11:01:13 -0800
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
CC: Mario Limonciello <superm1@kernel.org>, Zhixin Zhang <zhangzx36@lenovo.com>,
 Mia Shao <shaohz1@lenovo.com>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/3=5D_acpi=3A_platform=5Fpr?=
 =?US-ASCII?Q?ofile_-_Add_max-power_profile_option?=
User-Agent: Thunderbird for Android
In-Reply-To: <7050cadc-9cb7-4f9b-8393-247bddb56965@gmx.de>
References: <20251113212639.459896-1-derekjohn.clark@gmail.com> <20251113212639.459896-2-derekjohn.clark@gmail.com> <7050cadc-9cb7-4f9b-8393-247bddb56965@gmx.de>
Message-ID: <CFD27662-0044-4AF3-8E66-65229324CECF@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 16, 2025 8:13:17 AM PST, Armin Wolf <W_Armin@gmx=2Ede> wrote:
>Am 13=2E11=2E25 um 22:26 schrieb Derek J=2E Clark:
>
>> Some devices, namely Lenovo Legion devices, have an "extreme" mode wher=
e
>> power draw is at the maximum limit of the cooling hardware=2E Add a new
>> "max-power" platform profile to properly reflect this operating mode=2E
>>=20
>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel=2Eorg>
>> Acked-by: Rafael J=2E Wysocki (Intel) <rafael@kernel=2Eorg>
>> Signed-off-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>> ---
>>   Documentation/ABI/testing/sysfs-class-platform-profile | 2 ++
>>   drivers/acpi/platform_profile=2Ec                        | 1 +
>>   include/linux/platform_profile=2Eh                       | 1 +
>>   3 files changed, 4 insertions(+)
>>=20
>> diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/D=
ocumentation/ABI/testing/sysfs-class-platform-profile
>> index dc72adfb830a=2E=2Efcab26894ec3 100644
>> --- a/Documentation/ABI/testing/sysfs-class-platform-profile
>> +++ b/Documentation/ABI/testing/sysfs-class-platform-profile
>> @@ -23,6 +23,8 @@ Description:	This file contains a space-separated lis=
t of profiles supported
>>   					power consumption with a slight bias
>>   					towards performance
>>   		performance		High performance operation
>> +		max-power		Higher performance operation that may exceed
>> +					internal battery draw limits when on AC power
>
>I am not sure if it is a good idea to allow platform_profile_cycle() to c=
ycle into this
>new max-power profile=2E The system could encounter a brownout if it is c=
urrently operating
>on battery power when selecting max-power=2E
>
>Maybe we should prevent platform_profile_cylce() from selecting max-power=
?

At least for Lenovo devices unplugging AC will automatically throttle the =
ppt values to roughly equivalent to performance=2E It will look at a differ=
ent WMI data block for the values when switched, so there's no risk for cyc=
ling in this case=2E This seems like smart hardware design, but we've certa=
inly seen bad hardware design so the concern is warranted=2E Perhaps it is =
worth visiting if another vendor implements it differently? That being said=
, what you're describing would match up with how the physical profile selec=
tion button works, so it would align with consumer expectation=2E I have no=
 strong feelings either way, but I'm a little concerned about meeting the m=
erge window as this series fixes a pretty disruptive bug affecting 6=2E17 u=
sers=2E

Regards,
- Derek

>Other than that:
>Reviewed-by: Armin Wolf <W_Armin@gmx=2Ede>
>
>>   		custom			Driver defined custom profile
>>   		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   diff --git a/drivers/acpi/platform_profile=2Ec b/drivers/acpi/platfor=
m_profile=2Ec
>> index b43f4459a4f6=2E=2Eaa1dce05121b 100644
>> --- a/drivers/acpi/platform_profile=2Ec
>> +++ b/drivers/acpi/platform_profile=2Ec
>> @@ -37,6 +37,7 @@ static const char * const profile_names[] =3D {
>>   	[PLATFORM_PROFILE_BALANCED] =3D "balanced",
>>   	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] =3D "balanced-performance",
>>   	[PLATFORM_PROFILE_PERFORMANCE] =3D "performance",
>> +	[PLATFORM_PROFILE_MAX_POWER] =3D "max-power",
>>   	[PLATFORM_PROFILE_CUSTOM] =3D "custom",
>>   };
>>   static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_LAST)=
;
>> diff --git a/include/linux/platform_profile=2Eh b/include/linux/platfor=
m_profile=2Eh
>> index a299225ab92e=2E=2E855b28340e95 100644
>> --- a/include/linux/platform_profile=2Eh
>> +++ b/include/linux/platform_profile=2Eh
>> @@ -24,6 +24,7 @@ enum platform_profile_option {
>>   	PLATFORM_PROFILE_BALANCED,
>>   	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
>>   	PLATFORM_PROFILE_PERFORMANCE,
>> +	PLATFORM_PROFILE_MAX_POWER,
>>   	PLATFORM_PROFILE_CUSTOM,
>>   	PLATFORM_PROFILE_LAST, /*must always be last */
>>   };


