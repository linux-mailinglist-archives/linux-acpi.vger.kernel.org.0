Return-Path: <linux-acpi+bounces-18233-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E25B8C0AF80
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 18:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AB3E4E1205
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 17:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0531B20B81B;
	Sun, 26 Oct 2025 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC5kFVO2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C638FA6;
	Sun, 26 Oct 2025 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761501152; cv=none; b=XS8n2OUPvNPJbuvsglX1BxbK+kRMlF6KQCfxChflU5EtLPyMM4QbpH2Jt+pgm1BRSIG2ETQ4eg7/ySWJElHePk9BK5GrPa8i/urUKDvxYO+vn+P5AhJvaMoVZc45+UcBdYnA7bhhu9U4EWru5cWH0K8vz74Z9REhxSX6mICRRKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761501152; c=relaxed/simple;
	bh=HxhkhOjx3Trgt6++OL+Yxr8TKWEQa9NloU7IFOQMecM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCI65RffGEBGAX54tjqnTGmMb/aqiufid08bmqWfsILNIOqBeStkeApjQZTsJFe80M4XDFSJF/OF2XyG8/uZKN+XR8fSQ7d9pT8PJWOxROP2pezckfDX+hFW4/7bHtFDobtXV35zYmN5RDqQKotDbCGcA676bme9Yt/Z9z14Lag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC5kFVO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA08DC4CEE7;
	Sun, 26 Oct 2025 17:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761501152;
	bh=HxhkhOjx3Trgt6++OL+Yxr8TKWEQa9NloU7IFOQMecM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZC5kFVO2MWDtxOaVeXkMr12Ex9QqaRVNutbEt1K6wCiDGy564lQeCz60W8TXQA7vZ
	 n3klyxRZmYYwNNDrPKNqzjlbcNag2UEy/dUnd5NeTwoaZVwMta8Xms0uOesO5mCjl9
	 Z+o7Ye937kj+CIk1lYODQw1L5xVVqAUtoYV3a+kwOX/dKkziv8q9oCEN3qVpYc/Y/W
	 PhFVBz5L482+ZypP4LszFMoh6T9U0y1kDAXNiCtijBkyRd+2pi8m6b0zAdXeYJmX4V
	 RNQ1HOF+TU97aTXsRQ+r8JfnrlW+v7RqjSGPVaXjMpMxLeEDWB7KzjN0Lty9HFRLoo
	 lU6PQoppp2j4w==
Message-ID: <e8789ef0-1700-4f1b-95fe-95dfdbc1e785@kernel.org>
Date: Sun, 26 Oct 2025 12:52:29 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] platform/x86: lenovo-wmi-gamezone Use Extreme vice
 balanced-performance
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Armin Wolf <W_Armin@gmx.de>, Len Brown <lenb@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20251026081240.997038-1-derekjohn.clark@gmail.com>
 <20251026081240.997038-3-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251026081240.997038-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Is 'vice' the right word for the subject?

On 10/26/25 3:12 AM, Derek J. Clark wrote:
> When upstreaming the gamezone WMI drivers the "extreme" mode was matched
> to performance and performance was matched to balanced-performance, but
> only when extreme mode was fully enabled. Otherwise performance was
> matched to performance. This has led to quite a bit of confusion with
> users not understanding why the LED color indicating the platform
> profile doesn't match their expectations. To solve this, replace the
> confusing convention with the new "extreme" profile.

Are the colors common to all devices?  Maybe it would be worth adding to 
the documentation the expected colors for each mode.

> 
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>   .../wmi/devices/lenovo-wmi-gamezone.rst        | 10 +++-------
>   drivers/platform/x86/lenovo/wmi-gamezone.c     | 18 +++++-------------
>   2 files changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> index 997263e51a7d..6c908f44a08e 100644
> --- a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> +++ b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> @@ -24,18 +24,14 @@ current platform profile when it changes.
>   The following platform profiles are supported:
>    - low-power
>    - balanced
> - - balanced-performance
>    - performance
> + - extreme
>    - custom
>   
> -Balanced-Performance
> +Extreme
>   ~~~~~~~~~~~~~~~~~~~~
>   Some newer Lenovo "Gaming Series" laptops have an "Extreme Mode" profile
> -enabled in their BIOS. For these devices, the performance platform profile
> -corresponds to the BIOS Extreme Mode, while the balanced-performance
> -platform profile corresponds to the BIOS Performance mode. For legacy
> -devices, the performance platform profile will correspond with the BIOS
> -Performance mode.
> +enabled in their BIOS.
>   
>   For some newer devices the "Extreme Mode" profile is incomplete in the BIOS
>   and setting it will cause undefined behavior. A BIOS bug quirk table is
> diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
> index 0eb7fe8222f4..faabbd4657bd 100644
> --- a/drivers/platform/x86/lenovo/wmi-gamezone.c
> +++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
> @@ -171,14 +171,10 @@ static int lwmi_gz_profile_get(struct device *dev,
>   		*profile = PLATFORM_PROFILE_BALANCED;
>   		break;
>   	case LWMI_GZ_THERMAL_MODE_PERFORMANCE:
> -		if (priv->extreme_supported) {
> -			*profile = PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> -			break;
> -		}
>   		*profile = PLATFORM_PROFILE_PERFORMANCE;
>   		break;
>   	case LWMI_GZ_THERMAL_MODE_EXTREME:
> -		*profile = PLATFORM_PROFILE_PERFORMANCE;
> +		*profile = PLATFORM_PROFILE_EXTREME;
>   		break;
>   	case LWMI_GZ_THERMAL_MODE_CUSTOM:
>   		*profile = PLATFORM_PROFILE_CUSTOM;
> @@ -218,16 +214,12 @@ static int lwmi_gz_profile_set(struct device *dev,
>   	case PLATFORM_PROFILE_BALANCED:
>   		mode = LWMI_GZ_THERMAL_MODE_BALANCED;
>   		break;
> -	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> -		mode = LWMI_GZ_THERMAL_MODE_PERFORMANCE;
> -		break;
>   	case PLATFORM_PROFILE_PERFORMANCE:
> -		if (priv->extreme_supported) {
> -			mode = LWMI_GZ_THERMAL_MODE_EXTREME;
> -			break;
> -		}
>   		mode = LWMI_GZ_THERMAL_MODE_PERFORMANCE;
>   		break;
> +	case PLATFORM_PROFILE_EXTREME:
> +		mode = LWMI_GZ_THERMAL_MODE_EXTREME;
> +		break;
>   	case PLATFORM_PROFILE_CUSTOM:
>   		mode = LWMI_GZ_THERMAL_MODE_CUSTOM;
>   		break;
> @@ -338,7 +330,7 @@ static int lwmi_gz_platform_profile_probe(void *drvdata, unsigned long *choices)
>   
>   	priv->extreme_supported = lwmi_gz_extreme_supported(profile_support_ver);
>   	if (priv->extreme_supported)
> -		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> +		set_bit(PLATFORM_PROFILE_EXTREME, choices);
>   
>   	return 0;
>   }


