Return-Path: <linux-acpi+bounces-18232-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A5EC0AF76
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 18:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177A63A8C58
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 17:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945712571BD;
	Sun, 26 Oct 2025 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3HXg6wC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ABD2264CF;
	Sun, 26 Oct 2025 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761501043; cv=none; b=WYyv+uM4hY6xnes0QfD+5o09nzvai9Zx94gnORquGemYNIt2MKT3gFlm+Lmwf9lVgiRzHdJK2r3ORIXml+mz9P8bmtQNvlwiJL3K3jQgw4y05ZyPhGdYNVs0S0kylfyWaOGlnTGu7brx6tHanhNA2CXGVrx98+8wNF2IReY+C9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761501043; c=relaxed/simple;
	bh=liSMpe60PodcwFd6ppXcZD7qBvCHIlF/WVEGjJ6nEmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Adh+yvX2TwRJfTYF6Q4WQOst6n5nG/cPQW3onWNLq37UMGGaTQvWJDcujW6qbkXQiNGulFlq4zX6bPjTpJkq0jekiW6GCtsJiY4aa7jp+FNYB5URr9JXBmaSNFaZAPxJaipIylogDVE+iuJawAM/PYdYP6bU8f30uSbDoya2HDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3HXg6wC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33C6C4CEE7;
	Sun, 26 Oct 2025 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761501042;
	bh=liSMpe60PodcwFd6ppXcZD7qBvCHIlF/WVEGjJ6nEmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D3HXg6wCG/CDSXsMFjPaXG/GwA37ZfhaeIelkYutujxiyzaE5+B7JmW3/U7Sssjup
	 TVjVCF4a+yyuY/sccrejEoTq3wPAtpAI9iZqE8T+1HRdNx1c12yCPH7DFhf63eqwAd
	 5wjnIUd3Mm1dwcyR02VnhgZtN8WvSOvWoTcOujl71z8lc3T8BfFkfPY38SWyqhPVW+
	 x2EMPTaPA/76tQPUCzw+AaNKKJA1CsDKzdaKo4IyHBOPmPfJimZ4s5xoiOLMyowXTO
	 S+H0dK6fBnjop0T3kiTj5z0RJ78YkvRwFTbg0feFzn0DlDt/0w8fwgypD+oPQWHXGy
	 CkfJVY1GDMhmg==
Message-ID: <4c3a594b-7a57-4b5e-85c8-e9337d70c7e6@kernel.org>
Date: Sun, 26 Oct 2025 12:50:40 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] platform/x86: lenovo-wmi-gamezone Use explicit allow
 list
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
 <20251026081240.997038-4-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251026081240.997038-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/25 3:12 AM, Derek J. Clark wrote:
> The stubbed extreme mode issue seems to be more prevalent than previously
> thought with multiple users having reported BIOS bugs from setting
> "performance" when using userspace tools such as PPD. To avoid this ever
> being possible, make enabling extreme mode an explicit allow list instead.
> These users will still be able to set extreme mode using the Fn+Q keyboard
> chord, so no functionality is lost. Currently no models have been
> validated with extreme mode.

So what exactly happens when a user uses FN+Q to change to extreme mode 
but it's now in the allow list?  Does it report as "custom" mode?

I feel like this is going to turn into an impedance mismatch.  I'm 
leaning it's better to just expose extreme mode so that userspace knows 
what's actually going on.

I feel the bug situation will actually improve because PPD and Tuned 
have no idea what extreme mode means so it won't be "easy" to get into 
it.  This at least will allow discovery of BIOS bugs as well that can 
then get reported and fixed in BIOS.

> 
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>   .../wmi/devices/lenovo-wmi-gamezone.rst       | 10 +++---
>   drivers/platform/x86/lenovo/wmi-gamezone.c    | 33 ++-----------------
>   2 files changed, 8 insertions(+), 35 deletions(-)
> 
> diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> index 6c908f44a08e..79051dc62022 100644
> --- a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> +++ b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> @@ -31,11 +31,11 @@ The following platform profiles are supported:
>   Extreme
>   ~~~~~~~~~~~~~~~~~~~~
>   Some newer Lenovo "Gaming Series" laptops have an "Extreme Mode" profile
> -enabled in their BIOS.
> -
> -For some newer devices the "Extreme Mode" profile is incomplete in the BIOS
> -and setting it will cause undefined behavior. A BIOS bug quirk table is
> -provided to ensure these devices cannot set "Extreme Mode" from the driver.
> +enabled in their BIOS. For some newer devices the "Extreme Mode" profile
> +is incomplete in the BIOS and setting it will cause undefined behavior. To
> +prevent ever setting this on unsupported hardware, an explicit allow quirk
> +table is provided with all validated devices. This ensures only fully
> +supported devices can set "Extreme Mode" from the driver.
>   
>   Custom Profile
>   ~~~~~~~~~~~~~~
> diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
> index faabbd4657bd..0488162a7194 100644
> --- a/drivers/platform/x86/lenovo/wmi-gamezone.c
> +++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
> @@ -47,10 +47,6 @@ struct quirk_entry {
>   	bool extreme_supported;
>   };
>   
> -static struct quirk_entry quirk_no_extreme_bug = {
> -	.extreme_supported = false,
> -};
> -
>   /**
>    * lwmi_gz_mode_call() - Call method for lenovo-wmi-other driver notifier.
>    *
> @@ -241,31 +237,8 @@ static int lwmi_gz_profile_set(struct device *dev,
>   	return 0;
>   }
>   
> +/* Explicit allow list */
>   static const struct dmi_system_id fwbug_list[] = {
> -	{
> -		.ident = "Legion Go 8APU1",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
> -		},
> -		.driver_data = &quirk_no_extreme_bug,
> -	},
> -	{
> -		.ident = "Legion Go S 8APU1",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8APU1"),
> -		},
> -		.driver_data = &quirk_no_extreme_bug,
> -	},
> -	{
> -		.ident = "Legion Go S 8ARP1",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8ARP1"),
> -		},
> -		.driver_data = &quirk_no_extreme_bug,
> -	},
>   	{},
>   
>   };
> @@ -278,7 +251,7 @@ static const struct dmi_system_id fwbug_list[] = {
>    * Anything version 5 or lower does not. For devices with a version 6 or
>    * greater do a DMI check, as some devices report a version that supports
>    * extreme mode but have an incomplete entry in the BIOS. To ensure this
> - * cannot be set, quirk them to prevent assignment.
> + * cannot be set, quirk them to enable assignment.
>    *
>    * Return: bool.
>    */
> @@ -292,7 +265,7 @@ static bool lwmi_gz_extreme_supported(int profile_support_ver)
>   
>   	dmi_id = dmi_first_match(fwbug_list);
>   	if (!dmi_id)
> -		return true;
> +		return false;
>   
>   	quirks = dmi_id->driver_data;
>   


