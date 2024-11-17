Return-Path: <linux-acpi+bounces-9623-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654339D0590
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 20:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BBA282103
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 19:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A8C1DB53A;
	Sun, 17 Nov 2024 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="jQVIH/MQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9773BBEA;
	Sun, 17 Nov 2024 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731872157; cv=none; b=ad/POZT7xQgqgspEg2CSwJA9bYlivTkwDzfhlpvLo2UWZe4hHTt5nkxzebHlOX58Qiu6S0M8jai8bhKizfz7R6tYfjt/LpWJweD/GExuKzV8qTwC5p6TdmfZ2Mrmo6Qv4JfZNKiaG5M0hm9kGTh2UuhPunDB0Tg6WEirCbFFwpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731872157; c=relaxed/simple;
	bh=XUIur0HMQDaY4x9r2qT5TU8fwu4PLZhNxfQFtfkJtPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=go+qRVdPW4BE8LlQjevJVuMbx1/fiAqLDrjwSsVLnE77vIjpzwPUrHwqV5xBV2j1KpUipconcsTpSYjhj+HtNLeJP+ldwIvNOWFWO1c0f/JajRvynciThqh2JwNgKqLbTMPBo0Xi49VPpLiv97u9JfL0H93oOR3XS7nRSddlqNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=jQVIH/MQ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731872080; x=1732476880; i=w_armin@gmx.de;
	bh=fKQUVHgnMUfsRJgLc4Ki6RRXzaHF/RXS3pp8KVZMOvw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jQVIH/MQl/Ecf0Iou6PcHGiJRHAyXgR+pcduWtXdM4x2ERrRVfshOBqwdpHlBylA
	 0wzL5tZf3LA5S3xze82iU9EFsyjHtiy0prT3Ngo6L8DwyDKqGoe6FT1A8+aMVp/NS
	 4KYS0RuP+gWYcO/M62SspmohTeeAUuxRhSFx+UpQs65bhCDMyEQyeosS29Ofmkhrf
	 ia5Bcn3UyuN8v/kqxESzitt3ZDplnnXZ42BogLfiMl3zRgmhQyPqIOm0YqXtSIyMx
	 PXOojqRJOvPed45+b72GAarLk2fuddcReBkerTDuSA0TVgsf6KjibsT7fHaiQKgr6
	 vfjUj+plWsoR5+uH8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1ttDO53aAA-011llx; Sun, 17
 Nov 2024 20:34:40 +0100
Message-ID: <229772cf-9671-429f-bb2d-70f1f4e56172@gmx.de>
Date: Sun, 17 Nov 2024 20:34:33 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 22/22] Documentation: Add documentation about class
 interface for platform profiles
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
 <20241109044151.29804-23-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241109044151.29804-23-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HUy4UsSbMRAnDfl6uP+L9wLbCPCmS8q1bX7QrwI+CqahK2vFLGF
 FKM6Px+BW/11kcZo+NahktzmWoEprHf7gR7pFPVMijZvn7m6nTNDKxqC1GMU6cmPs7foVxh
 SQfH30Sj5sXXnCSo2zlktlhvr+eMxckn+5U8nAAmHBUmjoVntj4KevkftFHtfEVAf/KhjF7
 CaCKkhph6Qb9uL2EAd2pA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:flInAw9PPZo=;UPJ4lesXFmTdiFJyMDCCKcvlU4e
 2Usyuh7DBHPD0vQJn5qriLxMkzYojMQZClPVIYVqryyw10dhYBpIq5F8akzkM1FNf7ptVXRun
 2IgNczqYFpG2d30lMf2oJUm3in49kdr//b0QZRjWjy+A2QOf8UElyv4f2/8hZC2aaq2Nboee7
 zCui1CQ5FcRuHL2H8qfRKc2ZQiNW6YpUBpfPSLML9eJ35p9shfgYgaQ/Ya6E0F18u9QtWNnmU
 FeBHXc6Hz9PtiQGfEIi2Hu2p8L2idWOyoeyvp3Tb0qSjx5gWV3dHpjP0bvJkMifUyIBvYr15X
 hLlm7UVyb7SOHhnh2MLgRKJlFjCAB8Ru7GbspUAq0pa/myx+2yQeO0ZRycX8F+jh+zqzbVGEa
 CkSSwsbAlYr7uz6eyDkjVRFde+fW8XQBwb9oOLzvknHNpyJpD7xVOBzNrhHcfzWyKLbiKOy9g
 cAG3Ww1hv+oRZ20ZwWUue8T+0O8b3E45q74PywVtFb/X/67kPWkUk6+qr1+9jCBkuw8Q7oRnR
 7FLUaEesc/FrXLt/uBgvGSBrOf20U2Jjg30pa/gjdMhvUfz4ksEXWyxzlTozXagzLLzyHTMzv
 Fbwt/MN+ZpDDGy3SVHsz89rcuY23IKsVU8c2V6+Zj/RBvX3lslUZV/v725BUyyITVw2ztlzqp
 3jmO3hox+XoDCVlY2FtoqEV79lPEPuxJfCrTsRGM0iWdH9XqzmybjPIGVqa4kQXJYL4a2qpsz
 fMOFZDmTXbLzemVVSUhKZV64hMYNIHVPeJ3AZd4mK8IN4MMH0KDMfhZjpByvGQswH5ocsCnx2
 URTOlXT1/aqDy1d6+erpLHrcRes1wtaxLGjpUMIMH61utIA9+wuPESv1vOkYygANkzMj5jH9N
 kup3wRvNlZLiDHncpqF/tN0mUJUYtRPXkXH7t1RBb4ULDIICwzLoVUCgr

Am 09.11.24 um 05:41 schrieb Mario Limonciello:

> The class interface allows changing multiple platform profiles on a system
> to different values. The semantics of it are similar to the legacy
> interface.
>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v5:
>   * Fix some typos
> ---
>   .../ABI/testing/sysfs-platform_profile        |  5 ++++
>   .../userspace-api/sysfs-platform_profile.rst  | 28 +++++++++++++++++++
>   2 files changed, 33 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
> index baf1d125f9f83..125324ab53a96 100644
> --- a/Documentation/ABI/testing/sysfs-platform_profile
> +++ b/Documentation/ABI/testing/sysfs-platform_profile
> @@ -33,3 +33,8 @@ Description:	Reading this file gives the current selected profile for this
>   		source such as e.g. a hotkey triggered profile change handled
>   		either directly by the embedded-controller or fully handled
>   		inside the kernel.
> +
> +		This file may also emit the string 'custom' to indicate
> +		that multiple platform profiles drivers are in use but
> +		have different values.  This string can not be written to
> +		this interface and is solely for informational purposes.
> diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
> index 4fccde2e45639..b746c30432753 100644
> --- a/Documentation/userspace-api/sysfs-platform_profile.rst
> +++ b/Documentation/userspace-api/sysfs-platform_profile.rst
> @@ -40,3 +40,31 @@ added. Drivers which wish to introduce new profile names must:
>    1. Explain why the existing profile names cannot be used.
>    2. Add the new profile name, along with a clear description of the
>       expected behaviour, to the sysfs-platform_profile ABI documentation.
> +
> +Multiple driver support
> +=======================
> +When multiple drivers on a system advertise a platform profile handler, the
> +platform profile handler core will only advertise the profiles that are
> +common between all drivers to the ``/sys/firmware/acpi`` interfaces.
> +
> +This is to ensure there is no ambiguity on what the profile names mean when
> +all handlers don't support a profile.
> +
> +Individual drivers will register a 'platform_profile' class device that has
> +similar semantics as the ``/sys/firmware/acpi/platform_profile`` interface.
> +

Please add a short description of the 'name' attribute of the class device.

With that being addressed:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +To discover available profiles from the class interface the user can read the
> +``choices`` attribute.
> +
> +If a user wants to select a profile for a specific driver, they can do so
> +by writing to the ``profile`` attribute of the driver's class device.
> +
> +This will allow users to set different profiles for different drivers on the
> +same system. If the selected profile by individual drivers differs the
> +platform profile handler core will display the profile 'custom' to indicate
> +that the profiles are not the same.
> +
> +While the ``platform_profile`` attribute has the value ``custom``, writing a
> +common profile from ``platform_profile_choices`` to the platform_profile
> +attribute of the platform profile handler core will set the profile for all
> +drivers.

