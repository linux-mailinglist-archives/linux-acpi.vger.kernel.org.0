Return-Path: <linux-acpi+bounces-9410-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8CA9BFFF2
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 09:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD82E2827E1
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 08:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185291D7E42;
	Thu,  7 Nov 2024 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="eCu2LKnN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8349619ABD4;
	Thu,  7 Nov 2024 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968176; cv=none; b=M592emFNu55m2Na64S7qh672rr72Kuz4M2leJJYt4ctmKKiZFGPZJrKIoVzM7upk/ZDqh5uHgDHKRRyrw2Surnie7zxs+MM8PWyhuf82in3Y3RofHnuoH1qNsbChHZoMWX6sEDXbrpN0ZzWd6rXGWooIWY7ty73rfmrU1D58TOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968176; c=relaxed/simple;
	bh=cj8MS+1NU0WnR8wiXTILWQa4XssYX3wH/iS27hbxvmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goBH/KXvg69+2LxdQPEFRx7RpjZDW4SBeeovMe+0z3y5dggX9agnBr2khPpvS01iePujuoa0PSd18IeSoBw6KzlZg/JT7NcPy1DSks5zyiZj8K1oX+rBIuEm8CXADBUkd1f4Ig1c9j66wzJskpEZagpNLwVnJRBRfvsV1tQ0ye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=eCu2LKnN; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730968105; x=1731572905; i=w_armin@gmx.de;
	bh=izolzRQwtqEC94qXeOhC7cGfUQ7/McRUzrvB15R7m+s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eCu2LKnN0oMcm5biu/E1xN4ivdYyHJ9izPQCsWsZ/vLeRzHGc1uVZLk6EJMPgbo7
	 MxnYzK9T0+DSYpXWPcCfX5+KZgS2BRPr3WxVixAN6zWC6fELxwSXiUOdPBw9iBPjN
	 9FdtLATreffPAMagRcbS4iBwsTmTJb2YY1x6QTQVcb+UFeVuOreDd+mQokkndXRJ/
	 mWffzgQwXJKmwwAbp/+m43MB+dYmGhEdV6+E52i1/bEdM/PdPWUj83qrMbP3v0dvu
	 XOzGncJ5ArQYRb3Wq6RQE5OmAMonE/JsLiUawkNTnHJUBVIcsbH0JZIImsl76hNx7
	 sXna/XDPqCoUguXwWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mjj87-1tY5902MDz-00gcEk; Thu, 07
 Nov 2024 09:28:25 +0100
Message-ID: <7e302f04-cb4d-4ecd-b1a1-4b89f09e692b@gmx.de>
Date: Thu, 7 Nov 2024 09:28:21 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/20] ACPI: platform_profile: Add choices attribute
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
References: <20241107060254.17615-1-mario.limonciello@amd.com>
 <20241107060254.17615-12-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241107060254.17615-12-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L97aA5dXE6UpudHzza/iSlf4ftAxHMvJdf7hYW1xJYQmBvKAyRb
 rLR6ppc3qqbV7E6Nl5Vt/Vxq8Tfo2W81BG1dlBxaG/4vV6Oa3eQ+2FWHfeqdjYw7j1vW0uD
 v8XBwLALHMEiRJL22aBrzYQgPTlwtrATbHQQ5UpzBBqo1ry34lbsxFdn5bp8Ik4+/ivsyXi
 S7Rl0WHvqw2twGepxnntw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DDbpsOSh7PE=;GqUcLaYe9jC1f0Cmi7x5/U7Ethc
 B4eEDtughEo00NtPgko8nHtGSgSj/Ns6Eup3yRLkaOFIhgfLHnEZ3ul1BAvlC9djDCg6KRTud
 i88Gc6ZIDHX0/C8dPsM5qzpr+6xx0GhWUxyhOShthYPwfxLauAQUy32sKvi95UgRvm7JeEWTk
 eVPz6T1tsjzmcSNV73HQ9rWkZZ121P0tZcHvqiQ8j5UpBK6GuIb/1BQOEky4wA0YDvVUAKYfa
 Jiif4Y9tJTIyFpcT+rNQ55jae4VzlQc5HP7IVTbJ69GyJ3H4xpCQZZEicKrVkAOnrH5P3nVk1
 ZQ55hZsfOQf6uzyrR+6tBTupwNMl3puSpxiSdKCeIgunRg8iVDSrOJu60g7RE/vHqQ8KxcadI
 iduDxRryvda1D2IPR7qAXDU+83omAmG5Eee2Os9LIsICpemYvmd3CI80EUosfF3jmn3I+r/52
 Za6joaIDuN4hwNuu8lYDIVoKhaFPgvCGyPvU0GOi0QPEFO50JSy8C2U8lPBFb8I6IftJYXN10
 mZdA16j5KIY8CCLcWiGUTLYl4fAG6zKsHrjhzh0Om5vrn/XaTrGatACDY11X3ifHehRPWABq7
 WzCFJuzboerq/SBKZ2fUPpwsDMAIW/5ktacMucCIGIUAEmefEIm2F0jeuIENv5AjIgZC6UgZO
 bJIFx5wV0KVvEOviivWT/UST9+Jp2U4jv/q8iw4Zlim9367kd7KIdrRDfmSgo5jvFPRCQ8sFx
 teDWwAx/UK8fVInJlqHQJ1LtGOo9i854UdRTrQiQvM4eMgxmHBOL9ty/O09sA4N+5QDR2YYkj
 8iS9tXrCntLoen4B6vmMwik5PgrPbOwA7VPCyEbzXNgCo=

Am 07.11.24 um 07:02 schrieb Mario Limonciello:

> The `choices` file will show all possible choices that a given platform
> profile handler can support.
>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v5:
>   * Fix kdoc
>   * Add tag
>   * Fix whitespace
>   * Adjust mutex use
> ---
>   drivers/acpi/platform_profile.c | 65 +++++++++++++++++++++++++++++++++
>   1 file changed, 65 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index f605c2bd35c68..5e0bb91c5f451 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -25,6 +25,46 @@ static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFO=
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
> +static ssize_t _commmon_choices_show(unsigned long choices, char *buf)
> +{
> +	int i, len =3D 0;
> +
> +	for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
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
> +/**
> + * _get_class_choices - Get the available profile choices for a class d=
evice
> + * @dev: The class device
> + * @choices: Pointer to return the available profile choices
> + * Return: The available profile choices
> + */
> +static int _get_class_choices(struct device *dev, unsigned long *choice=
s)
> +{
> +	struct platform_profile_handler *handler;
> +	int i;
> +
> +	lockdep_assert_held(&profile_lock);
> +	handler =3D dev_get_drvdata(dev);
> +	for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST)
> +		*choices |=3D BIT(i);

Maybe just copying the bitmask would be enough here? In this case we could=
 also drop
this function as well.

> +
> +	return 0;
> +}
> +
>   /**
>    * name_show - Show the name of the profile handler
>    * @dev: The device
> @@ -44,9 +84,34 @@ static ssize_t name_show(struct device *dev,
>   	return -ERESTARTSYS;
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
> +	unsigned long choices =3D 0;
> +	int err;
> +
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		err =3D _get_class_choices(dev, &choices);
> +		if (err)
> +			return err;
> +	}

Please directly use the choices field here, no need for a mutex  since the=
 choices are static
across the lifetime of the platform profile.

Thanks,
Armin Wolf

> +
> +	return _commmon_choices_show(choices, buf);
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

