Return-Path: <linux-acpi+bounces-9344-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAF09BDDD8
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 04:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53F8285030
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 03:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD521917D6;
	Wed,  6 Nov 2024 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="BfyAGA8W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C224B26;
	Wed,  6 Nov 2024 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730865433; cv=none; b=d6p9gRYomZhlEj/KEWZSZG9Iik22CtBfZodfkcp8s8gcc9EtnaxlsvGTbXwLOzOi7gEwFoyUBlwjeZE+HUQYo9YrM4oz/zIyuUvzqUhFg73QJWXoW/kc6BBYS8lpGVLcW9OgTi2RNdFdkB+j8Dw3UOcTtcdOmahi2L7JCfKhaIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730865433; c=relaxed/simple;
	bh=v2p6nfJrNDEno2Iegmrzidgb+DHGsWItqNs3M18uIMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxdTI6p6cCBMd+oDoGAeFB4n0PZ+8fKtnLqmN2jvr95pmbNahWxq/AhlpSo1+rI6GbRnNgev6RiLB94uOQf4vi+Y5BRYiq+d2LOMMdU9CUDrrEL9xDh3dubSvE6u47WsfebsQrR0Dtu+vNg9vNIxNOemdcExzZzBuVkBDp5XQkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=BfyAGA8W; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730865363; x=1731470163; i=w_armin@gmx.de;
	bh=469pe1G482g3PxMu670oIEwMAAk+7tITEdYGEUMvXjg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BfyAGA8WTY5dGCBtvNjQdz+UELcFj7NA8SNRACMPQK3fOuu7FTS6pSQoAdt7zHHJ
	 U0vD05FdmfS/XJ3P9xtzMz1uXvC4tJauMdHb0/oUQ5fO/yOSXvFbgLmgGSB6Zanvd
	 On2wR2u3SHYE1TSnuihgddOLxyKpB+YU2EXZ5eKN5VUyauqaFYG/icNtxcaCvaEFI
	 cdlLZghBxdvy4XJnEgBAbd0OCvoEVPQCZoq1Liq3O6ycf46vgwPdAnmqrSNpwPBi1
	 ii+Q03d36blmTpJmGl2yj0Sxpq5QfqJjJhcaigXYUsGvEUvxWzY7nYNYfOZlBU35v
	 iVqef/SAFYVRN7uINA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26vB-1t6bLH3LWD-00Bc8U; Wed, 06
 Nov 2024 04:56:02 +0100
Message-ID: <73700d9d-e89a-40d1-85c4-1c20f90eaceb@gmx.de>
Date: Wed, 6 Nov 2024 04:56:01 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/20] ACPI: platform_profile: Add name attribute to
 class interface
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
References: <20241105153316.378-1-mario.limonciello@amd.com>
 <20241105153316.378-11-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-11-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MA909+/vgufVEJlshHG/Ne5XvVR0Xm3wsuQ6pCt6GQ/B03Ro78G
 5VczlEjru8+q0Gb70P1LmQRmt4tIeBPfVQGtWPXiMOzHoETSETDr7SRR2oetKzqTV8lM7xI
 6PDE7IHZEa6Whw8/DjLfAebHExIlDmNzYDXT5bJ4ZtC9ZQOVT+epfO25ldPcSqVD2xCXssz
 /7OI6R8jfuvb/1eobDz9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LGd5C2ii3P0=;uiqI85n3FC/WkzRO+9pH6rgSqpf
 pJUG8mtoF2XM5XetlkL4n7O4JFHy64MJYvvezknCU85AHETXCk1C8atOcWcAxtMmWT9WaeKAn
 fz6eoebu1o5P20BmZiXKCgchkAmarHQiCqLgZe02oarSGZcZ2I8na0nnSDZiQIknOD4+pBf9E
 IWW1YTFhk2O3/gFLeKVvjKkzG9jVxjWsqm+BRr2UlCtMxVeEX8O9gcmyyzTzRleu3ZJTAEXa5
 zZxts/Bu3PjM6S5ITBC0+Mgd+kn7ZgrdsQEWTmMAyES/aKlkON13T0xbqmerrXf1mBOJ5WaQC
 sEEBoTmlt1yYeFcWGCUyd7SzORqVRNDOOVhRaSwLZL7lbSxh6ABEg25bnjZRufoPnL9TtIX2g
 QP956PiBe8JgkQmkhOKV8ixqcrhtzI+cbag2e+k0AdfBCW//Sw2nr7JKEk9bE6XJTZgfnWQsp
 AqyWxJ+6sIYfj8F7AwcRfcteNCt0eyXKzwSIo50IZNFIR+3FPthkPz0jb+z9MFzgqy6c45Gp1
 b1BY0Mlvy1ugPzWIV8rwv4TVDR40BwHiWUg99OFSMsluzLNdqCvty/WY8U43RG6XdZb4p+obd
 iIb7ySXzCQCkWHQ2PR2SKzRyyjsVI11Q3An9HyUHpO0ircWL5uhQVgZnpzL5ArWEdYeZzEAyg
 O9xm5ozKKMKWT5OwFsgWH/ozWptgEivCIF2dUSq3uNCL2p36fEspw/gZNqiOXFoZ35v61xw/y
 tsKSTrxcFLsdzQWarHHlLZFFSDtDWbjX9jCw3ZHwVty6s6F18z2jL1cUBRWfgZNKNcatMnbh0
 AT3EFvsu/J0Kc4XIGYAOpCSkarMkDOStpPnL9dWUy+FIw=

Am 05.11.24 um 16:33 schrieb Mario Limonciello:

> The name attribute shows the name of the associated platform profile
> handler.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index f8e9dc9a10d54..986bd636be226 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -25,8 +25,33 @@ static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFO=
RM_PROFILE_LAST);
>
>   static DEFINE_IDR(platform_profile_minor_idr);
>
> +/**
> + * name_show - Show the name of the profile handler
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to write to
> + * Return: The number of bytes written
> + */
> +static ssize_t name_show(struct device *dev,
> +			 struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct platform_profile_handler *handler =3D dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%s\n", handler->name);
> +}
> +
> +

Please don't use multiple blank lines.

Other than that:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +static DEVICE_ATTR_RO(name);
> +static struct attribute *profile_attrs[] =3D {
> +	&dev_attr_name.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(profile);
> +
>   static const struct class platform_profile_class =3D {
>   	.name =3D "platform-profile",
> +	.dev_groups =3D profile_groups,
>   };
>
>   static ssize_t platform_profile_choices_show(struct device *dev,

