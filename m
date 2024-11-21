Return-Path: <linux-acpi+bounces-9724-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114FB9D5541
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 23:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B65282E9C
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 22:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717731DC1BA;
	Thu, 21 Nov 2024 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="W281CVnz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D401BD031;
	Thu, 21 Nov 2024 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227240; cv=none; b=QHxOfHtCy59qivgyLKGXb3gGWknP9N+JBwHMRKuXgwpU+FqFvOV6C5HZVtxwQW8TgHQVmW4mz5V3ApO3hhjb9gafNB9DXZCR1/tRsuYMbp73hIYj6SvZl7Qaxk6rwN8Wd1k/6LOAAbzT72kGbLPQRwwchRN8YHud56m+GeUk3AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227240; c=relaxed/simple;
	bh=oH7nqItlYPkTypgpC09pOI9idAGE9dHoYaCHeGqHVaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0JHgJcK38Q/2Dn7T/LXKVjwI71fd/G7Y8p3ERrv1nKmX0jnYQh8l6hZwaS09HBlRY/6CXdgC5Re8kX7Xsusfy53zV0dwy+PFtSw+YX4goHR1psT/Fx2IRtAJY8187mpq6WAD5EvGv3cESiZ83GSYi4RGB1USOMx76Zmuh5sQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=W281CVnz; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732227175; x=1732831975; i=w_armin@gmx.de;
	bh=cXX54Y9INubhhZ0b2wtvIgEg76woonkRAY1ALNTis3o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=W281CVnz9kVQXUqCLfGxMvj/UtMP4YAOkuwkwCXL/ztx6SJzEs2kV77yUom2PJ69
	 aUGnllmwVYpFkeO2MGUOzd0/OZBbDXYEV1QDU3d6JczeosozQXaJSh2kUdAPTU1XC
	 Efee0mWSVKdhUW6x6qSduZcLaz5rEIlKDpArmRKYIFNkOHde2l2ZyVdCgiMCAPTCR
	 AieEobfwg3WAIF7YREzS/oCyZ53LTieqTGesvDsX7Qx/1s67m3DnGUsuQ8syhRvb0
	 jfy8DaHyjDJbKGOxbK4GE0gEJ6CicoawkPtRKbL39n4MWPLo97u05LB2snEbvnS/C
	 Jw7lYHAbKKkpjPZArw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.129.90] ([176.6.148.212]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1u1gmB0IV2-0182Hl; Thu, 21
 Nov 2024 23:12:55 +0100
Message-ID: <217c843d-3b8a-4d6e-9e19-3fb22f099fc5@gmx.de>
Date: Thu, 21 Nov 2024 23:12:50 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/22] ACPI: platform_profile: Add choices attribute
 for class interface
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
References: <20241119171739.77028-1-mario.limonciello@amd.com>
 <20241119171739.77028-13-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241119171739.77028-13-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wQKlekWLqT4X1GSRk8d/ayccGcCUF6fyIDf0scD5h/eDdcxG8dB
 sd446YRaWch7PHGMekBXcbbYJ30JzMYfR3ErtySgqQ0xvmbpzzpyQbHlJoAzCnA6cplPg8R
 jYZeYGDpBfLupB0nNu+8gBo8M/6ZuhKcQ2TWaMeGpRxHh97kdx9eyQL2h4hhGvv7foQu49Y
 Wy6pD4+WV95h4JGC3w0Aw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F/7G9+BBVvQ=;DNrlaOH5JaTyt8xKiZ9x9Tj4E22
 vWu1yu132tpmsP0m1LFceVnFXYmpJ8jY2BNmxBfVRmiiR4O0za8916O+mx3/9BOzZgM6fZ71G
 6MNgMdGPUTYPpCVGL/iYTUD4ymVS/kUq/AAkJRef+j4lkgnMgBQu4t2j8SHdJa/OiGB/r5MjH
 SXaP1RXl/NXsUCfwrM8U23ZkMBzW4vGN6v9uEFgCV7yMiKYDJ3PzRUYPPrw0cZjm5O+9OiWR2
 K28/ZaPv9HFBpDGY7pvODg3Eaon6Xv3uAWkdho0EuLyLzJBXIHMUTfshCh/mvuy+bF5qaayg2
 lhE/q8mxBv/Wia3TlbMz3QkIPs0mcaEYWXFjfR6EihN+ESaSaCt0JkzryEcFDkhrwMKzTUbJb
 3p2NKcMDc8CqGvVWZRqQhfaY3Xy84B5THkcj0cFedEF0AIDNI/j9f4InYNpXw5L50SK9Miv2f
 LkDI/uUGFdhe2fdj2X04LoKkrvivb/bJggWeA97zRllHJoplXX4zIJy+cxGFZS9ooXhjqYBUc
 1YBdQyz4430kG+zqWtHl+Z/hQnUas4pZyOBchIkW6tT2CwlASHDA5J/p/fQIh3/0MKPCvxzGC
 A+QihS8Zph0X5SXR++1Xz4t0ueo5uZKSfV1Z+FAZ/ZLUInMGtXbvusNR6lYw07OUmwZFzHDoA
 AWDzojZrZGJh8S9TEJr+o8JK008Ew+hVuSXdpEn4Ba+hUyGroORuiacW+3/MStpKgjjGi0nwQ
 3ephWCaTQDa29YW5Fk53QNkJCQ+ZOH7ks1yw4vhm+hIYqWxy86K2XAIeccVZUhvrp0+dTKZ+K
 MHg4mgP8BSJTwfDRIH6r8AdTcorpvXOQsNt4NHK4OEi3AR5Aa/9+zlNeKP/blbYmRa4zURQsB
 J6Fh6bbnrp44xC/vUf9gbirZcG064CbvQANVdNjK4lctL/BP+K/do7/OEbgT6WJhfZwZKS3tg
 242wxDzaTKTV4PA5/v1fufH+OJMFIg4n9kVk+ToRdb+YUE49cAgYLZKnrSADKz5q+uy4g0vm/
 waEigjQImXe0266y/Y5XXs1JkHz2dM4XTEHKrWYMg+h/IWLi3Z1O05SAfEtZx48w4/oYXO9rO
 F7CAC9JzNVCLjhqYXM+XUWa8n2Letw

Am 19.11.24 um 18:17 schrieb Mario Limonciello:

> The `choices` file will show all possible choices that a given platform
> profile handler can support.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v7:
>   * Drop locking
> v5:
>   * Fix kdoc
>   * Add tag
>   * Fix whitespace
>   * Adjust mutex use
> ---
>   drivers/acpi/platform_profile.c | 39 +++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index a9d7ec3c85844..9d6ead043994c 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -25,6 +25,27 @@ static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFO=
RM_PROFILE_LAST);
>
>   static DEFINE_IDA(platform_profile_ida);
>
> +/**
> + * _commmon_choices_show - Show the available profile choices
> + * @choices: The available profile choices
> + * @buf: The buffer to write to
> + * Return: The number of bytes written
> + */
> +static ssize_t _commmon_choices_show(unsigned long *choices, char *buf)
> +{
> +	int i, len =3D 0;
> +
> +	for_each_set_bit(i, choices, PLATFORM_PROFILE_LAST) {
> +		if (len =3D=3D 0)
> +			len +=3D sysfs_emit_at(buf, len, "%s", profile_names[i]);
> +		else
> +			len +=3D sysfs_emit_at(buf, len, " %s", profile_names[i]);
> +	}
> +	len +=3D sysfs_emit_at(buf, len, "\n");
> +
> +	return len;
> +}
> +
>   /**
>    * name_show - Show the name of the profile handler
>    * @dev: The device
> @@ -41,9 +62,27 @@ static ssize_t name_show(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", handler->name);
>   }
>
> +/**
> + * choices_show - Show the available profile choices
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to write to
> + */
> +static ssize_t choices_show(struct device *dev,
> +			    struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct platform_profile_handler *handler =3D dev_get_drvdata(dev);
> +
> +	return _commmon_choices_show(handler->choices, buf);
> +}
> +
>   static DEVICE_ATTR_RO(name);
> +static DEVICE_ATTR_RO(choices);
> +
>   static struct attribute *profile_attrs[] =3D {
>   	&dev_attr_name.attr,
> +	&dev_attr_choices.attr,
>   	NULL
>   };
>   ATTRIBUTE_GROUPS(profile);

