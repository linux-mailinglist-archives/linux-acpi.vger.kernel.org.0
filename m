Return-Path: <linux-acpi+bounces-18235-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C273C0B0C1
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 20:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8EA189C86C
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 19:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47AA2F99BE;
	Sun, 26 Oct 2025 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULU3LZ5Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4147A6B
	for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2025 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761505807; cv=none; b=AnYGt+MU05lBT97dR8JPXV1BbvLH5Zq2JXNPHih1qgZYU8j08BcfSIDclU0c1g3vU0WO8uDPkpw2UJ4lKuu5QrzLl7ZZUMEnzwdn37UOm+SMNGUkhSPDhAxHVEynAFEocoJI8ixroo6io6+W/SYiihfI0jhQtUB4v80kUDx6Dn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761505807; c=relaxed/simple;
	bh=0lq7zVwPZaQ1Z0QmxvXwvIFsXJKsKrMtftkVUtORhEE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=L3+L5GkfQxMl1coqbF7RBmh3yBcqohFrHj3EecP3Xzj87/o92JEJoBdArrdZlM3IzyLaRSQvojL60nzCe2tsCwJWT7b6eUvrl5YeXa8+mwVELcsLfSZEfbWklT9tz96rgeoi4/PqIjQPIRbV2KbnMixOInNFbr506KJ66AEGnfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULU3LZ5Q; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so3669698a91.1
        for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2025 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761505805; x=1762110605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fnFYZ9YUqokdNrVhAzveB7Lx/h8vJ0ZLZBrXLG7FIwU=;
        b=ULU3LZ5QDucJoRHtdN4r5T2qvlQG/ptN219iohNQDg9o3S+ZEmuCqEOwU7absOBLYh
         q3IE8Zle/mINy94lD2fCyJvHl7Sqa8q7k9mxFQibFX6Bqv751DVk2lczqAZ7N0qhF8Xw
         K5q22x+K/FLPFD/5oQFHNVYgI264hMqb5BVxncTbrJXjvLJPt7Q98gPnc4GVxuabEFsl
         g2xjlYH+tSEC4Pc2toEXQRfwZ9cDe+iKVQLzrqtJX7XJGaJ78JHinAZhz09O/Q5VPI7v
         5FLXRauY85GvtYjwGijcr8p8G/cTQEGs0mg/qmvFbbn6WE01SDCuF0NeFKrJTS3NlmBR
         vpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761505805; x=1762110605;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fnFYZ9YUqokdNrVhAzveB7Lx/h8vJ0ZLZBrXLG7FIwU=;
        b=i+ti1FlToe6MQ5uLgjx4QOFYrP/RcM5jXIqmDBoy/G4PSlWmPmvePMkKRTUjV0e6G6
         yPA4BTwmJfSR3rtm7xKgpy/4LqGl1I5vfk4MUb6opiQ7cBlwAc6YCu0leg0JgEFwzqgx
         jVFjXoB5nWdbP5vbOg7avzLIPmAa1oB6u+4bSp1S+Hdu6tdxf+N6RAEr4MWe82mIaFhW
         VKyQ6+voqUd8NzuZbv6AbJmVozOiqEsyOilvDIljKSuDTBQJDcL54Fhp6Ya136KXy1bt
         cK5tGFJBdL2GCECCdLWhaCH/OZ6KkqUEZMLIhkENulXhDCoePAhk6ZOx/hF+Vrs+GQkq
         8Wdw==
X-Forwarded-Encrypted: i=1; AJvYcCVwOkPlSSe1Ia3v0c6Je6+r+Gjfw9YlvOvh0wEfXG0tzVPIzlbDwvSIghLflhhJHXwEtVD/289OjAZR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0uWJxXNbaiq2OQPZBrSjAEJb6nQPvDS/NUARIB9F1UYqazR3f
	PoTLvhXSEPOcj1U+OHWM6bUo3UEqCR+iPZnwaGHOYN4HHG7Fspt27da3
X-Gm-Gg: ASbGnctZSMhaZVRjX+G1Sj43LyL5c92HOYbRR4m6VJ5rUyFd24Aa2z0P3zjjeic1g8h
	U2uuzLwgfQPs67ka3dXoIgQLSWWO0qDX0iLKxCWoVMZTGWA+Os5/S/YRYUD7vAtaY9z8KytZe7s
	wDbL0/7019nTqKACSxcGk7vhvgYxFwifevXQ2Qf7H7f1Auoe2NNT0vZ2DGNEXyESURTT4y7UrjP
	la/wJZuzdDZlbaiNgChbw15USZ89UmyWhBjnJ42vrHPElYSAcf2PAIaV/1shBnaCdNfENEinvGJ
	lCQe8Lf+/ZJN4rnolRtje31o/rFOk3nXi4aZuyAUOwAuEPtbtvaKPsQ3ofRI1GXEzrCFhHvsimL
	TFgt3/CB0FoKCGAHuuBzSVzx8jF6XI8yU1kcr85T7fq7Fjd4AvFI9I/RDfi5aceJZB2HqLdSkJk
	Lu5wgtpNAj5e4Lx59a58jtAfaaOFm81mRHigqx7KzyqYarEY9N3mdpWAF5ltaf2pU/isYQD340z
	Gjef9rEMEnl31s8y0IN
X-Google-Smtp-Source: AGHT+IHIMcsGGm24Rt7x4qUBaUlLuW2TkTj9Vx3KclPFhSEmsfRY9ycNQeSpu5npNrhMtA0Tz3+PdA==
X-Received: by 2002:a17:90a:ec8b:b0:32e:d011:ea0f with SMTP id 98e67ed59e1d1-33bcf8f7280mr40460828a91.25.1761505805426;
        Sun, 26 Oct 2025 12:10:05 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f3aeesm5818053a91.14.2025.10.26.12.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 12:10:05 -0700 (PDT)
Date: Sun, 26 Oct 2025 12:10:03 -0700
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/3=5D_platform/x86=3A_lenovo-wmi-ga?=
 =?US-ASCII?Q?mezone_Use_Extreme_vice_balanced-performance?=
User-Agent: Thunderbird for Android
In-Reply-To: <e8789ef0-1700-4f1b-95fe-95dfdbc1e785@kernel.org>
References: <20251026081240.997038-1-derekjohn.clark@gmail.com> <20251026081240.997038-3-derekjohn.clark@gmail.com> <e8789ef0-1700-4f1b-95fe-95dfdbc1e785@kernel.org>
Message-ID: <C92AC0B4-8458-4D2B-AE5D-9D452294EDFE@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 26, 2025 10:52:29 AM PDT, Mario Limonciello <superm1@kernel=2Eor=
g> wrote:
>Is 'vice' the right word for the subject?
>
Used as in rather than or as an alternative to, it has more brevity=2E

>On 10/26/25 3:12 AM, Derek J=2E Clark wrote:
>> When upstreaming the gamezone WMI drivers the "extreme" mode was matche=
d
>> to performance and performance was matched to balanced-performance, but
>> only when extreme mode was fully enabled=2E Otherwise performance was
>> matched to performance=2E This has led to quite a bit of confusion with
>> users not understanding why the LED color indicating the platform
>> profile doesn't match their expectations=2E To solve this, replace the
>> confusing convention with the new "extreme" profile=2E
>
>Are the colors common to all devices?  Maybe it would be worth adding to =
the documentation the expected colors for each mode=2E
>
I think so, based on every case I've run into=2E I'll need to expound a li=
ttle and reword more in this section but that should be doable=2E

Thanks,
Derek

>>=20
>> Signed-off-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>> ---
>>   =2E=2E=2E/wmi/devices/lenovo-wmi-gamezone=2Erst        | 10 +++------=
-
>>   drivers/platform/x86/lenovo/wmi-gamezone=2Ec     | 18 +++++----------=
---
>>   2 files changed, 8 insertions(+), 20 deletions(-)
>>=20
>> diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone=2Erst b/Docu=
mentation/wmi/devices/lenovo-wmi-gamezone=2Erst
>> index 997263e51a7d=2E=2E6c908f44a08e 100644
>> --- a/Documentation/wmi/devices/lenovo-wmi-gamezone=2Erst
>> +++ b/Documentation/wmi/devices/lenovo-wmi-gamezone=2Erst
>> @@ -24,18 +24,14 @@ current platform profile when it changes=2E
>>   The following platform profiles are supported:
>>    - low-power
>>    - balanced
>> - - balanced-performance
>>    - performance
>> + - extreme
>>    - custom
>>   -Balanced-Performance
>> +Extreme
>>   ~~~~~~~~~~~~~~~~~~~~
>>   Some newer Lenovo "Gaming Series" laptops have an "Extreme Mode" prof=
ile
>> -enabled in their BIOS=2E For these devices, the performance platform p=
rofile
>> -corresponds to the BIOS Extreme Mode, while the balanced-performance
>> -platform profile corresponds to the BIOS Performance mode=2E For legac=
y
>> -devices, the performance platform profile will correspond with the BIO=
S
>> -Performance mode=2E
>> +enabled in their BIOS=2E
>>     For some newer devices the "Extreme Mode" profile is incomplete in =
the BIOS
>>   and setting it will cause undefined behavior=2E A BIOS bug quirk tabl=
e is
>> diff --git a/drivers/platform/x86/lenovo/wmi-gamezone=2Ec b/drivers/pla=
tform/x86/lenovo/wmi-gamezone=2Ec
>> index 0eb7fe8222f4=2E=2Efaabbd4657bd 100644
>> --- a/drivers/platform/x86/lenovo/wmi-gamezone=2Ec
>> +++ b/drivers/platform/x86/lenovo/wmi-gamezone=2Ec
>> @@ -171,14 +171,10 @@ static int lwmi_gz_profile_get(struct device *dev=
,
>>   		*profile =3D PLATFORM_PROFILE_BALANCED;
>>   		break;
>>   	case LWMI_GZ_THERMAL_MODE_PERFORMANCE:
>> -		if (priv->extreme_supported) {
>> -			*profile =3D PLATFORM_PROFILE_BALANCED_PERFORMANCE;
>> -			break;
>> -		}
>>   		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
>>   		break;
>>   	case LWMI_GZ_THERMAL_MODE_EXTREME:
>> -		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
>> +		*profile =3D PLATFORM_PROFILE_EXTREME;
>>   		break;
>>   	case LWMI_GZ_THERMAL_MODE_CUSTOM:
>>   		*profile =3D PLATFORM_PROFILE_CUSTOM;
>> @@ -218,16 +214,12 @@ static int lwmi_gz_profile_set(struct device *dev=
,
>>   	case PLATFORM_PROFILE_BALANCED:
>>   		mode =3D LWMI_GZ_THERMAL_MODE_BALANCED;
>>   		break;
>> -	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>> -		mode =3D LWMI_GZ_THERMAL_MODE_PERFORMANCE;
>> -		break;
>>   	case PLATFORM_PROFILE_PERFORMANCE:
>> -		if (priv->extreme_supported) {
>> -			mode =3D LWMI_GZ_THERMAL_MODE_EXTREME;
>> -			break;
>> -		}
>>   		mode =3D LWMI_GZ_THERMAL_MODE_PERFORMANCE;
>>   		break;
>> +	case PLATFORM_PROFILE_EXTREME:
>> +		mode =3D LWMI_GZ_THERMAL_MODE_EXTREME;
>> +		break;
>>   	case PLATFORM_PROFILE_CUSTOM:
>>   		mode =3D LWMI_GZ_THERMAL_MODE_CUSTOM;
>>   		break;
>> @@ -338,7 +330,7 @@ static int lwmi_gz_platform_profile_probe(void *drv=
data, unsigned long *choices)
>>     	priv->extreme_supported =3D lwmi_gz_extreme_supported(profile_supp=
ort_ver);
>>   	if (priv->extreme_supported)
>> -		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
>> +		set_bit(PLATFORM_PROFILE_EXTREME, choices);
>>     	return 0;
>>   }
>


