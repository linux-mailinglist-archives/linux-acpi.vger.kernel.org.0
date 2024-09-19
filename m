Return-Path: <linux-acpi+bounces-8336-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD8F97C53E
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2024 09:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8760A1F2279A
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2024 07:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E28B195FEC;
	Thu, 19 Sep 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="XIbC1LWI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501CE196450;
	Thu, 19 Sep 2024 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732111; cv=none; b=ZJqFot5RJTJLPTZG0WZR+0Yp0rZx7N0xvLpu4SXiBZMn25Opun6g9xhjwi3lNGcUz8MFktw/kehdLpzZFlTX5Cp2XkSmSvOvTdm0gpH1CW8jD7itsIeiqDiIHd67cfTTtUHsKrbtD0AJVFK7if/QddwVCiIANJvUNYIK4VkC65g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732111; c=relaxed/simple;
	bh=I8i0PtYzbp5/3UHNuCLN6I1UE1MX9/TvaUsV0muqxv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLhdGXrS5YwQHJeuOSOBpNXMu5YE95Aoj1PR0qQLGZsfzAGJ3b55UQajWgP8X37wo2dGtYyflQDKA6vFKRzgjxi5LlWfjPZmQwFFHV6OmVRU2d34+qpm1xvdrGGE6uDii0Gybhi5N6LHL6XpVeuefLYQHdOToyFQejbtFxn+2zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=XIbC1LWI; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726732088; x=1727336888; i=w_armin@gmx.de;
	bh=Ivu6pNMFNDdzz9NzA2QR63kAY+I41GjtOQX8rtxsG/8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XIbC1LWILdwoDD14/xthaHpnOcTENEi2sB8flsfU1vsnq0k7blLbVeSlf9TWepxK
	 4e3jS07u8xpG8T2waaLS81LVwir8bJ2534RsH+n2545XuYypTjF63o1HljkPcdF+r
	 HRk8xwaTuUGNDnE7q9agU18f9mbUKAQ8VT0uOChs3GOqSPcZiDrnyA0vl+0YK+Gj4
	 DcpamDW4y1/MUztladk+HuipCNtzyPa3TJwa67NsL+fXZUTVGGrBDYvluoQxoUv6r
	 xDBgP2GOe1ly6b59vaWNZxaB/zPG8uJIydvSJc5NwjLl1+IzEoLydjph7zb/SU8FE
	 kWsF9tyJSdxT2l1AtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UZ6-1sqdfG28nK-00Buff; Thu, 19
 Sep 2024 09:48:08 +0200
Message-ID: <115271db-b7dd-4490-9f24-9e0a99dbf133@gmx.de>
Date: Thu, 19 Sep 2024 09:48:02 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: dell-laptop: Fix crash when unregistering
 battery hook
To: Andres Salomon <dilinger@queued.net>
Cc: mjg59@srcf.ucam.org, pali@kernel.org, rafael@kernel.org, lenb@kernel.org,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240919063332.362201-1-W_Armin@gmx.de>
 <20240919031329.3e0f76d0@5400>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240919031329.3e0f76d0@5400>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vpecjAySGrq5pw6epyOpemsGkmdivEr4qpldfmRmrscnK/W2DIt
 jIBK5rPBR+KO33JuVA8iaXDc5CZIQYSP02ttm+wgOJsq58BE6RivY+OHm3JHwVtkYjlomS3
 9QtHTPA1slc+EZ/AM8+Lb/oYpT5hp+6+1TmHs0PKJetbievYp7wZztPzVTGogBYzHpqGA1i
 3U4hIceW9ZpkH+O0jQkBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EoIFML1Xr9c=;TbYs4bi3J/5bfsQW7mVyymklksm
 Z4jnWaazsWymMXaV238/1MCmVzv6kmof0aVlLPLdPnC/Ly3X0sY+kSnd/aRjQ312xSAzyZCFa
 ie937XYZzy1ZRG5PKnJwMUiAEvJmnngIjGNpnkZ2InPzGNX6qe+2uBlGVpn1f3gZ+W1h9F9Iy
 tm+tqHTixskcvmXwKm3KuwAWzwqzoXEmOlNaIgJVXztM7kAhNXiBbRy1Z4vhSv9+FqWu1mAjd
 AdPjilOGwlvQlXjXMKjOzVsPZAAo1jPiR6yLlKP/hLbEcupRWt2mwOrp1s2RFj5Cazf80ahU3
 tyK0funDR96BcRmiB/XqjdwE6x6nJNoqByc3itbnSmgqbLP59cUvA+H3oW4vWw3egUsvcI23S
 2JWs/DWtcEjX7z8wnlYZn8fGWu/uVeKHddIQiXQ9dNqWHhIsHbbVO7dy8KncV3Zvn6vfWTsxV
 h2IV9wL5Fo5hREDS3CYsp/AOaG736GBCHICTCAAJcrjo1hg0MtE/YlZiBop7RtbJyLGdTdlak
 8dIl3QMVAtuHuP68i/cd7G49LqeDZ+UvnOrjnzsG5Gao055HNeN4HwFBKF242p/DNBqn8GQVR
 QjGpe/RClUiLzBETyNCv+RVcp32+mvyaJ+EUrnFQdGsaubvjxYIrp2M7rBqM1/pj9e9S9EVJe
 DEyLXUdWcHXtwDRuDE1Fss6oX4OLqTmOYvORpQAVT8pms4MXPuO0oHCpMDW5FaQ4RqDzcWQrO
 x1myDk+CKEQOsW2cUyuhAIOFpUvuPMX3bJlH7EOiOuoY2nGsX+RoSOaNRdFGHRZoWiAA+OhQH
 ByFZY0XiKVOjGsd9wQvZwt3g==

Am 19.09.24 um 09:13 schrieb Andres Salomon:

> On Thu, 19 Sep 2024 08:33:32 +0200
> Armin Wolf <W_Armin@gmx.de> wrote:
>
>> If the battery hook encounters a unsupported battery, it will
>> return an error. This in turn will cause the battery driver to
>> automatically unregister the battery hook.
>>
>> However as soon as the driver itself attempts to unregister the
>> already unregistered battery hook, a crash occurs due to a
>> corrupted linked list.
>>
>> Fix this by simply ignoring unsupported batteries.
>>
>> Tested on a Dell Inspiron 3505.
>>
>> Fixes: ab58016c68cc ("platform/x86:dell-laptop: Add knobs to change bat=
tery charge settings")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>> I CCed the maintainers of the ACPI battery driver since i believe
>> that this patch highlights a general issue inside the battery hook
>> mechanism.
>>
>> This is because the same crash will be triggered should for example
>> device_add_groups() fail.
>>
>> Any ideas on how to solve this problem?
>> ---
> Hm, I see that when battery_hook_register() has the add_battery hook fai=
l,
> then __battery_hook_unregister() calls the remove_battery hook. Does
> something like the following fix it?
>
> (note: not any kind of final patch, just a test.)

Not really, since the error can happen even while a new battery is being a=
dded,
which can happen anytime (even during battery hook removal). This means th=
at using
a global variable would be prone to race conditions.

The issue can only be solved inside the ACPI battery driver itself, that i=
s the reason
why i CCed the ACPI maintainers.

Aside from that, ignoring unsupported batteries allows the driver to work =
on
machines with multiple batteries.

Thanks,
Armin Wolf

>
> ---
>   drivers/platform/x86/dell/dell-laptop.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/=
x86/dell/dell-laptop.c
> index a9de19799f01..c7b92b2f7ed2 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -2390,21 +2390,29 @@ static struct attribute *dell_battery_attrs[] =
=3D {
>   	NULL,
>   };
>   ATTRIBUTE_GROUPS(dell_battery);
> +static bool bgroup_registered =3D false;
>
>   static int dell_battery_add(struct power_supply *battery,
>   		struct acpi_battery_hook *hook)
>   {
> +	int err;
> +
>   	/* this currently only supports the primary battery */
>   	if (strcmp(battery->desc->name, "BAT0") !=3D 0)
>   		return -ENODEV;
>
> -	return device_add_groups(&battery->dev, dell_battery_groups);
> +	err =3D device_add_groups(&battery->dev, dell_battery_groups);
> +	if (!err)
> +		bgroup_registered =3D true;
> +
> +	return err;
>   }
>
>   static int dell_battery_remove(struct power_supply *battery,
>   		struct acpi_battery_hook *hook)
>   {
> -	device_remove_groups(&battery->dev, dell_battery_groups);
> +	if (bgroup_registered)
> +		device_remove_groups(&battery->dev, dell_battery_groups);
>   	return 0;
>   }
>

