Return-Path: <linux-acpi+bounces-18236-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1EC0B127
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 20:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE58034A08F
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 19:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387402FE050;
	Sun, 26 Oct 2025 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyO/C/Ke"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EEB254B18
	for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2025 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506535; cv=none; b=a7E8PNttvIQ184s9VlG921ovmbLH3YrlxmFEFG53wDjPya//myfPYuLW8kR8dQQgnmsYipp4gGjDwmTlsaMObTN8MI4TWDm15V+t+oma3rCWpw3lKt0S7BTyA6KPMBaAz8NiOZuavZe6F6I/hpbqXdVpbAgToSxYNe1HNphxDS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506535; c=relaxed/simple;
	bh=5hh5H/oXzBOIk5wRb5bURfhtxKr6bwusAlI0LKPWHHs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Xrwidf5PGkGCBjojIdBUFxZWy0J5pS19fQQoRl1QtcSRsFQO19+dq1rrBLAamIe8pP3vTxu1GlyDk6MMK73t0EzTTMTXweFUIh6a+hrFfavYV0wAe1wtejgyjAbX07I8pHt2/B3JbpqwGwsE8lwHlbxz23WCbsA1W40xj2joHXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyO/C/Ke; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290cd62acc3so45364285ad.2
        for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2025 12:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761506533; x=1762111333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1cH1BE6LpM8SseHBjfqUwIPHTH/EsEqQa5n5M8ASBCQ=;
        b=OyO/C/KewCtnyWNqEnLPQLrZ73QwD76MOyotmGev7xz2s7imCpmHaRYEPY7DV45D+K
         MKkdY1zczZW15vyi8OTrYRwaFtwy/8QVg3NaogDYLJTsPCzbM2EfnKtb2ukQo8Xnz+eK
         +pknXZm2w62b/xNwKYB+Yh+IJOlAAzEI0LaIknGBexGEO7ASCP5phW2ZPj/Z0li9VX8d
         VsvYC1/Vr4CbSwBVEJw0Zi17vdbhfb436x+Qys7fa3o9+lr9ClOSfz0Ei/bquDN7Upx9
         9YYrdXnbDf38R7cFxteMeHxt3/acSADznoOqG35+YXDmvvIMxodllZZM0SpDHB88141v
         Tv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761506533; x=1762111333;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cH1BE6LpM8SseHBjfqUwIPHTH/EsEqQa5n5M8ASBCQ=;
        b=oy5l8+xmFRMaSdB3ywGOtA0dTFkQoZYXrGtlQmT1s3VuuL19r9TQ7UsvaAMayfF7Rc
         lJ06yMxR1/9I8YpBbZ4MFA7D23punZ7s1pPF9nZQtp9+SpE7l9PfBNwcwKLZeoW6BTj8
         7207NBM6hBk6NlnwFOHU79AeNzB7Wxe03gzDb5c3GnnOg6Fa2vA48ZBwRmfB9VWALpuS
         SPBbmJ6HSSn+u2NQfQJ62IPVf7rY+6z2FsP67xDol+3f2PJbhFKOF/ZC9adp70lsly8V
         ZshZOXFyR4oaW2QC/Txf5BjH4eEwG0urs6Jkh0LYHwJUZrB7giMxaRMoLycsxBd1k8su
         GpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFZBqr6vgET5F6NwS87Yvc1xjJsbmoZE7NxikGhFIBS6qfv7kFM+xnh5dexjffOxJTbU4teqXjI37X@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1dFLcy4maT1DfsyC1PdbVQlOPbWGVM0EDVHH2upOoemj0Pg3I
	qCHG23CEzyYT/hn9cB3HQ8APOwZyFBq5GQWUYaMMTVb5WGK7SWTYWzFW
X-Gm-Gg: ASbGncsXVcBDb0ti+qQMxrIqoWUxn2RnRNrcfVFL1hNke0EMSOGtu6chJLu2C+jC9xY
	5dF8tja+hz0pqYNcXsaxR82kwwV32NAVK9vQ+Lg07ij/tiVR6UwtR+yqhgigswU2QzA3CpGyLcu
	6+iIwtl++PM+MOag32BJjbgChdSt7AqWCQXU1RJoDQM9ienlZCZ4OXldjTfOI2pZV0JlrrqW1TF
	72EH5zcIb0UrMOQcTfXZGT7zHgsO0zWCLvR6W3gNYOa4dEJnJs8OKKMZMFfIiAVpz84jFc0yliI
	9jX2t8wKnevjp7z0QS59VJgJCF5mK7CgGqDSxfGhnZx4a1scFB3I28pvpGw0e98p9sDlEbZMTgp
	tFxDawFGAVHUd7xHJmOFQdhbGb8YNf/amQgp20/5FknknBUA+gvEa4xAVuQoHahYBTsMoZEwwuk
	X44bJRbGMnUesbBg+5TkuPFVAJQU/lO036zaIeFFMc53CKdMAjX+tmBMwGQmx30jfwOCbQAODKa
	8EeT8iZJA==
X-Google-Smtp-Source: AGHT+IFMIx69T+JS0cQNaPJFmjTEG7wAJoCKtPMQG11v348ofORNvuy7yrfbSjNjsTsoBsw5YAadrg==
X-Received: by 2002:a17:903:32c6:b0:28b:4ca5:d522 with SMTP id d9443c01a7336-2948ba3bb60mr129121165ad.39.1761506532935;
        Sun, 26 Oct 2025 12:22:12 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81b40fsm5863762a91.16.2025.10.26.12.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 12:22:12 -0700 (PDT)
Date: Sun, 26 Oct 2025 12:22:10 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Mario Limonciello <superm1@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Armin Wolf <W_Armin@gmx.de>, Len Brown <lenb@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC: Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/3=5D_platform/x86=3A_lenovo?=
 =?US-ASCII?Q?-wmi-gamezone_Use_explicit_allow_list?=
User-Agent: Thunderbird for Android
In-Reply-To: <4c3a594b-7a57-4b5e-85c8-e9337d70c7e6@kernel.org>
References: <20251026081240.997038-1-derekjohn.clark@gmail.com> <20251026081240.997038-4-derekjohn.clark@gmail.com> <4c3a594b-7a57-4b5e-85c8-e9337d70c7e6@kernel.org>
Message-ID: <1411B6CE-132B-4450-BB27-9ED44BD897B0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 26, 2025 10:50:40 AM PDT, Mario Limonciello <superm1@kernel=2Eor=
g> wrote:
>
>
>On 10/26/25 3:12 AM, Derek J=2E Clark wrote:
>> The stubbed extreme mode issue seems to be more prevalent than previous=
ly
>> thought with multiple users having reported BIOS bugs from setting
>> "performance" when using userspace tools such as PPD=2E To avoid this e=
ver
>> being possible, make enabling extreme mode an explicit allow list inste=
ad=2E
>> These users will still be able to set extreme mode using the Fn+Q keybo=
ard
>> chord, so no functionality is lost=2E Currently no models have been
>> validated with extreme mode=2E
>
>So what exactly happens when a user uses FN+Q to change to extreme mode b=
ut it's now in the allow list?  Does it report as "custom" mode?
>
It turns out I got a correction after posting this that I'll need to inclu=
de for v2=2E Extreme is never actually set using Fn+Q and can only be set i=
n software=2E In that case, functionality is lost (though extreme should ma=
tch custom mode default values, so only slightly)=2E The only chance this c=
ould happen realistically would be if a user switched from windows in extre=
me mode and then booted windows, since the setting is retained=2E

TBS, I'm asking some folks to test exactly that situation so we can know d=
efinitely=2E My assumption was that it would report extreme normally but no=
t be setable=2E

>I feel like this is going to turn into an impedance mismatch=2E  I'm lean=
ing it's better to just expose extreme mode so that userspace knows what's =
actually going on=2E

It's possible, I'll wait for confirmation of the behavior from someone wit=
h the affected hardware=2E

Thanks,
Derek

>I feel the bug situation will actually improve because PPD and Tuned have=
 no idea what extreme mode means so it won't be "easy" to get into it=2E  T=
his at least will allow discovery of BIOS bugs as well that can then get re=
ported and fixed in BIOS=2E
>
>>=20
>> Signed-off-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>> ---
>>   =2E=2E=2E/wmi/devices/lenovo-wmi-gamezone=2Erst       | 10 +++---
>>   drivers/platform/x86/lenovo/wmi-gamezone=2Ec    | 33 ++--------------=
---
>>   2 files changed, 8 insertions(+), 35 deletions(-)
>>=20
>> diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone=2Erst b/Docu=
mentation/wmi/devices/lenovo-wmi-gamezone=2Erst
>> index 6c908f44a08e=2E=2E79051dc62022 100644
>> --- a/Documentation/wmi/devices/lenovo-wmi-gamezone=2Erst
>> +++ b/Documentation/wmi/devices/lenovo-wmi-gamezone=2Erst
>> @@ -31,11 +31,11 @@ The following platform profiles are supported:
>>   Extreme
>>   ~~~~~~~~~~~~~~~~~~~~
>>   Some newer Lenovo "Gaming Series" laptops have an "Extreme Mode" prof=
ile
>> -enabled in their BIOS=2E
>> -
>> -For some newer devices the "Extreme Mode" profile is incomplete in the=
 BIOS
>> -and setting it will cause undefined behavior=2E A BIOS bug quirk table=
 is
>> -provided to ensure these devices cannot set "Extreme Mode" from the dr=
iver=2E
>> +enabled in their BIOS=2E For some newer devices the "Extreme Mode" pro=
file
>> +is incomplete in the BIOS and setting it will cause undefined behavior=
=2E To
>> +prevent ever setting this on unsupported hardware, an explicit allow q=
uirk
>> +table is provided with all validated devices=2E This ensures only full=
y
>> +supported devices can set "Extreme Mode" from the driver=2E
>>     Custom Profile
>>   ~~~~~~~~~~~~~~
>> diff --git a/drivers/platform/x86/lenovo/wmi-gamezone=2Ec b/drivers/pla=
tform/x86/lenovo/wmi-gamezone=2Ec
>> index faabbd4657bd=2E=2E0488162a7194 100644
>> --- a/drivers/platform/x86/lenovo/wmi-gamezone=2Ec
>> +++ b/drivers/platform/x86/lenovo/wmi-gamezone=2Ec
>> @@ -47,10 +47,6 @@ struct quirk_entry {
>>   	bool extreme_supported;
>>   };
>>   -static struct quirk_entry quirk_no_extreme_bug =3D {
>> -	=2Eextreme_supported =3D false,
>> -};
>> -
>>   /**
>>    * lwmi_gz_mode_call() - Call method for lenovo-wmi-other driver noti=
fier=2E
>>    *
>> @@ -241,31 +237,8 @@ static int lwmi_gz_profile_set(struct device *dev,
>>   	return 0;
>>   }
>>   +/* Explicit allow list */
>>   static const struct dmi_system_id fwbug_list[] =3D {
>> -	{
>> -		=2Eident =3D "Legion Go 8APU1",
>> -		=2Ematches =3D {
>> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> -			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
>> -		},
>> -		=2Edriver_data =3D &quirk_no_extreme_bug,
>> -	},
>> -	{
>> -		=2Eident =3D "Legion Go S 8APU1",
>> -		=2Ematches =3D {
>> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> -			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8APU1"),
>> -		},
>> -		=2Edriver_data =3D &quirk_no_extreme_bug,
>> -	},
>> -	{
>> -		=2Eident =3D "Legion Go S 8ARP1",
>> -		=2Ematches =3D {
>> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> -			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8ARP1"),
>> -		},
>> -		=2Edriver_data =3D &quirk_no_extreme_bug,
>> -	},
>>   	{},
>>     };
>> @@ -278,7 +251,7 @@ static const struct dmi_system_id fwbug_list[] =3D =
{
>>    * Anything version 5 or lower does not=2E For devices with a version=
 6 or
>>    * greater do a DMI check, as some devices report a version that supp=
orts
>>    * extreme mode but have an incomplete entry in the BIOS=2E To ensure=
 this
>> - * cannot be set, quirk them to prevent assignment=2E
>> + * cannot be set, quirk them to enable assignment=2E
>>    *
>>    * Return: bool=2E
>>    */
>> @@ -292,7 +265,7 @@ static bool lwmi_gz_extreme_supported(int profile_s=
upport_ver)
>>     	dmi_id =3D dmi_first_match(fwbug_list);
>>   	if (!dmi_id)
>> -		return true;
>> +		return false;
>>     	quirks =3D dmi_id->driver_data;
>>  =20
>


