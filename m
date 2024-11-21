Return-Path: <linux-acpi+bounces-9723-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118729D553E
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 23:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9984282806
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E841DC06D;
	Thu, 21 Nov 2024 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EoTJS+Sx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A021BD031;
	Thu, 21 Nov 2024 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227154; cv=none; b=ecsnL9gi54WV8ROY0mZtm5EUVvjXnEsWfOQnGZPPwLGJXEnsO5Ol9S3ZDkBzGSPCtgma0Opte9YADQ5gFZpeCL09YGC+wwlQW1BtU3RAQzrOmfMQfClnotJ0GbeHMHpyMQ4sx5euSPUZwXNnUycsSP8bjQJqfBzjXrpd3QihxeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227154; c=relaxed/simple;
	bh=NhjuSpspxT3yJx/sMuY1BV7wwO6kYrAIry98XHJ+JkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sL10nX4ukku27sk8QgQnPVurWbpWs1n10SOjTlDjdvpuAwx4yF2Jat6QIBhAztMTqeEMVjodiRq/kpWzgI1/1co6mBr8xv7W850MoaIZB5UMSEqsfiuknOSnXtXVlbgRHxbNHzCFmn8wSlXV4T3DjlZmTE/k4DidtiG1NAEBXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EoTJS+Sx; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732227082; x=1732831882; i=w_armin@gmx.de;
	bh=12h0nkXzRpRPBdDYuvJTbtYKOHplWb1VjGQB5kjumvg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EoTJS+SxmkvoufhpgeHPiLUz3+202BBtdgDMRrXBGXYeNRjkztODaplBQHFzlzsW
	 XJ9DH3ibwDSMtJuxmk7q6e/DqilaGGhyrWHS6+R5momjVbwNwA6PtKoGZmtsSUOZJ
	 r+BpsCW/3WBPTbOP/DHCUQz6VDSEO6QXoQw+GVyPQbUgNRyRWF0VuVPt/gsFD3oEL
	 WmAGEimEhrEplcJwvrOQJaYlMPtMo2zzsgoLev+8LRZe8Tn5D/FnwR7Z2istXnUic
	 vg1UmZjkDvYHhb60gmkyobPUnbi/PpTB1lLf0fip5HtX7VfmKdp7PoQA4DflVm3RG
	 jOiQw1PeCTOsYDYObQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.129.90] ([176.6.148.212]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRk3-1tkqJs3gjJ-00liBl; Thu, 21
 Nov 2024 23:11:22 +0100
Message-ID: <3662669a-0a1e-4b33-82ca-b4ff237c0c9b@gmx.de>
Date: Thu, 21 Nov 2024 23:11:14 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/22] ACPI: platform_profile: Add name attribute to
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
References: <20241119171739.77028-1-mario.limonciello@amd.com>
 <20241119171739.77028-12-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241119171739.77028-12-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SAWBVRbCDSesSiXfWJrGZm6CyPzqNg93ixXpjUg8+KmstVJoHIO
 Kw4iKZxa7vlF8iyCte/Nw9/qCgFxGPI8jzx66hIWk+gLsNYWBlzOTr9xAsEdk0m+cBN6mkk
 rpUknOPX0d1Vl9LanuocKhpsfNNyodv3UxLYrs34pu4sEHDZSqbd5gjsxFKF4ZJeBzyN0aK
 bXxIQ44d21IZZ5MK7/VNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j3gAM7TshiM=;g0zXdNF9rBb2ZrrPqqgcp+NrrWh
 0FlliVacg/EYkjUM+KEpFqvEUeCW8JMCojtYvOFC6M0FjIuVTymoFL1qS6YrCAcH2lDwR6/ZK
 NRNzLfRp3zWv5+PeG7nm1RpRXD4yhIVUzenfAIPlQF0UEFyN/kEeq2PEqoVzoNgnqrRwlaixI
 zi11706yTh3xsmCcA31Srx+kOFAhq2dEejWiYMQ2KbPCwfXbPmfCiDqxhGEHFvHro84QPMrgc
 b21h94s7+xYf/BhN1XBipbeTTF3o+4ScGh1q3rgUxDEtNomcKXBHrElWFLllfX/8Map2tbQy9
 YLJw1skQ9Kv8Gv6+KF+BdXcYVDXUNa2krQ+VjyCxrEj1IBhU9vhwfe7sYVX2dzqDwIuCEvtEi
 DWV3RVV20L7+BycAJgu68YNhNnwIhNbkVSiectKCcZWawdb/Cl2wnWJ4C3Rffwqkf9SiNq2eX
 BGvI/Lc/YtyfaOTqX/iHVe9NDPJ9nqJdOpAjAViNjMXWlxw9XW/IQZvuPbmby6tw9Pt0JwqN8
 S/zVNVR1rQqg9DyvpS3mtsSZZGu+fnSFfmuwWp2l9bAYu1WLOU/KLyjEvg9P3iq4PPP9VJfu8
 BfOCPztINZAHnu2N81cDXRDcc7CeaRdRFOgWEr/dHk7WoHEA0qUu7ZlRDZFYgDFk5XKSE3g3u
 HaE2kOVqp4w4s5Cq2zOYbFpj8XIVuq6+7ADoLP4V+wGS4HQkbNgYvyW/DdT7QbqYqQt9gt9QY
 YI1dxseL7GoG2m/C9o5qfpxtVHKTZlNzEGaB3vnztoTa4gQ7FDk2RfIp2PgxNMJDimLNiiUc9
 YYCiACBbhg0abyRGKG+N3tO5s8JONGENFFb+V/aKLRlDPAzBOqDR3cXahP0nd52d2G/8EGBIu
 ur2x48vtRzNiNy/PC8B5HhTRFMdaZZe8z665Dw3g8H02pRLFu5J15arCL

Am 19.11.24 um 18:17 schrieb Mario Limonciello:

> The name attribute shows the name of the associated platform profile
> handler.
>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v7:
>   * Drop locking
> ---
>   drivers/acpi/platform_profile.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 3524a2b4618ed..a9d7ec3c85844 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -25,8 +25,32 @@ static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFO=
RM_PROFILE_LAST);
>
>   static DEFINE_IDA(platform_profile_ida);
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
> +static DEVICE_ATTR_RO(name);

Can you move DEVICE_ATTR_RO() right below name_show() and leave a blank li=
ne here? With that being fixed:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

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

