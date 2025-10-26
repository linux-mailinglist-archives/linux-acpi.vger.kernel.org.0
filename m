Return-Path: <linux-acpi+bounces-18234-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A93EC0AF8F
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 18:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3EC3ADCF2
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6352561AB;
	Sun, 26 Oct 2025 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDn9eF8C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0351E32D7;
	Sun, 26 Oct 2025 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761501193; cv=none; b=hHAxSki8rw/JrDYGTeFF0DTCf22hE41QYvLO3kswnaTk6WBd8qxqTpWy67M+AJbRC1UBKlKSzCq53wjvxl3TsXJiAHu/z12RK/BXPxW9g+QzgFP54ZEzl2j0zmrnVA2B/1u7OMRa9iAq36na3iRSktMHiica1v7pGBX4mu8hV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761501193; c=relaxed/simple;
	bh=KMq6Nbn1BXYVNV4CKwx+j6K2MWgiZKL1HsUVnOM099c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYvSjoHbaWKIIqXdVIYtb17u9dYi6GmUOvWeukE7C+1LTJl1uHOdCcvNSB9OfOLf3eAH7/dr4XGqZ+dsMJSxIjo2TozoWcwPJQ3RxDyQ3lAJH7+K7uFyhiYb96p1ji85OizLi9xdDGik2FgrshXiNvcXmdt5tw5tfUmXnEBgjH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDn9eF8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C429C4CEE7;
	Sun, 26 Oct 2025 17:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761501192;
	bh=KMq6Nbn1BXYVNV4CKwx+j6K2MWgiZKL1HsUVnOM099c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fDn9eF8CiQS+5ncmwYJmPQ29RmZEU9kezZnAP/5ePpw9/Ssk+Ga4nQdchcgt8o7Vu
	 9SUsYCdvNu9zWlHroPWFJokrEDs5BqYg97xXzlI263eRfJbLz0HaQwJ5XllQ6aJkk0
	 g/qysu45SlCw9yULZ/lFkwZIQm9dqBWN/Z6PcoeeNE0PLktQrYjB7RWbC4JHsQcAIx
	 QtvUai94VrDKm3QeP9fL0ald/hosC0crOCNNJ5QUzz9ZHMFzaANjmmFNMHfDpKy8n2
	 xsqO0BFN/F9zzmdo6TYo/RNJ/8vEt3DExXoNT31Kd3V2H9Yg2rvn3E4W2XmsdiRjuq
	 EnY7omU8wtYuw==
Message-ID: <149c41aa-aebc-4aa3-8bc6-6412931d3a4b@kernel.org>
Date: Sun, 26 Oct 2025 12:53:10 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] acpi: platform_profile - Add Extreme profile option
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
 <20251026081240.997038-2-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251026081240.997038-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/25 3:12 AM, Derek J. Clark wrote:
> Some devices, namely Lenovo Legion devices, have an "extreme" mode where
> power draw is at the maximum limit of the cooling hardware. Add a new
> "extreme" platform profile to properly reflect this operating mode.
> 
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   Documentation/ABI/testing/sysfs-class-platform-profile | 2 ++
>   drivers/acpi/platform_profile.c                        | 1 +
>   include/linux/platform_profile.h                       | 1 +
>   3 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
> index dc72adfb830a..9bee8deb4dc9 100644
> --- a/Documentation/ABI/testing/sysfs-class-platform-profile
> +++ b/Documentation/ABI/testing/sysfs-class-platform-profile
> @@ -23,6 +23,8 @@ Description:	This file contains a space-separated list of profiles supported
>   					power consumption with a slight bias
>   					towards performance
>   		performance		High performance operation
> +		extreme			Higher performance operation that may exceed
> +					internal battery draw limits when on AC power
>   		custom			Driver defined custom profile
>   		====================	========================================
>   
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index b43f4459a4f6..78da17e16d9b 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -37,6 +37,7 @@ static const char * const profile_names[] = {
>   	[PLATFORM_PROFILE_BALANCED] = "balanced",
>   	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
>   	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
> +	[PLATFORM_PROFILE_EXTREME] = "extreme",
>   	[PLATFORM_PROFILE_CUSTOM] = "custom",
>   };
>   static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index a299225ab92e..2bf178bde2b5 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -24,6 +24,7 @@ enum platform_profile_option {
>   	PLATFORM_PROFILE_BALANCED,
>   	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
>   	PLATFORM_PROFILE_PERFORMANCE,
> +	PLATFORM_PROFILE_EXTREME,
>   	PLATFORM_PROFILE_CUSTOM,
>   	PLATFORM_PROFILE_LAST, /*must always be last */
>   };


