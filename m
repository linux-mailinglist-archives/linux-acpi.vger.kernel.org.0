Return-Path: <linux-acpi+bounces-9363-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD4B9BF63E
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B9E1F23A7B
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 19:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2431320C31A;
	Wed,  6 Nov 2024 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="TSBzv99O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6320BB2D;
	Wed,  6 Nov 2024 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730920738; cv=none; b=KXNqGrWjGDPHz652dfp/Mkeu2Yw1r31sRprLGm9IMUvKPqmPhMweK2KqgMIhFKNznAYXf234ooclrEjxRSsOec/sqGc9FGnM3JdpZWpPOyCQzB2HfyIzgyTHK7a57xGfsWk7thfqD8NMt+5M5nY5lYFDXNyFzbZc80en0oqoMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730920738; c=relaxed/simple;
	bh=Y2hO76nlYLH4oaliyjXCyEVpFRsjQ4+LUZILd/pxEro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hxn47BIfWwMlpmiWtxmod+dGY3+ONDSyweGDO2P4QnG52cVzB0amunL8DlCbx9PkIHoaT0uDle2rQOsOkiaU/pBwaOFKMhbrlb+g7Cqi/88aAyrmIBRj88W7PAE9zWegQttWwcggDjjokw4gm5VoEyd/RNru7mhSmUgYV7JAerU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=TSBzv99O; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730920666; x=1731525466; i=w_armin@gmx.de;
	bh=nDRd2vz978UPLgl6sbE+OoDyIcGzJt9CgPhtAAZ4MVo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TSBzv99OeIwE5ie6rLCIli/N6pr7rUzI0oxoAE/kTQBM3h0ukv6af+3Q6k4rAupt
	 7TpmCGq8vtGvTgs3mwsS9DX2N5DmccZjX18otq0VHzpTC401jmAvjLbfKGD5grlLG
	 BgVV03Hm6kJDcrSGQzNZTr7EqZOx6QYKo5MKklng8iVMNxlF4LuG5DX7P7SKqupWI
	 vpOnasSDmhuuWKXG104K+ZqGyjQZOC72FjiCuqzjA47+/GamvxRjj37ojEtXLIck/
	 1N8v5BxISzhMXL2Omauv7pOx2qjkul4uRUST3ahjq/cMqy1KOIVSEfazOTsH+GloN
	 XkrnD2N5l0nxD/xQIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6m4-1tXyPl43eG-00jXx4; Wed, 06
 Nov 2024 20:17:46 +0100
Message-ID: <2e48d12b-e772-4a11-8660-b3153a018443@gmx.de>
Date: Wed, 6 Nov 2024 20:17:44 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/20] ACPI: platform_profile: Add concept of a
 "custom" profile
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
 <20241105153316.378-16-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-16-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CUr7G7igNB1iTZWuqidIaOopyHCWDf7/CMiRIIUCXNw+r4qzkw4
 qA7MrWKH0kX4jHLKUsliyUkrjbmsODutMuHQXThVWR/u3XhRm47NTypOarnefOnJOvJBySu
 SX2vNBKfJqYoz4zwYqrqS4h1SSsp47I3Gd9y5bU7MC/MKDqM3F2IAO7LJgXm1DfDPZsVC/t
 sX79wbr59QjsWwPbQ6sFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V/NMmZ5hVtY=;MRYCm0XHSCeKEmVfIVCEYQI1yWV
 4J8uHD3z4qj7ESiTNrF4inqzIns8WqPg9fzg78F2LrAHYLMl+QlTKa9zEgk83gNvslH0NutHG
 bj4cRHgG/1xhkC5WlJeX3YE6jY6f6I81R5dJHmnQ1sZzg7VsDW8vudZJdauj9EVZIIiTJrgbc
 NwmgapXaWDHbtS8KNEBh/UhV0xA48wgSq6qQ15CSGKte3YFT9ryrvdUPXSgoffjWC2etZbS4p
 Dphm69r3TTkaKiNS3Xi0DFeJXwDtFeDg1ov8AXlJiWWyPa3FyArw67rPoo2qtJFJBi8oO+C4O
 fooNPdUEZfjexadP4E9YTjGeSUo7Bpaw6ITU4nSp30VXB98e5H/VldlSJ3HXQZPS+vdOZmu38
 wf3ll925kT3IjeUKByuTED3IpuFw9H2Zm1CQNpPp8Ky68G6+5FCxTHYfa8uWNQemLMvKw34/3
 lx75JLQ1OExKceKQucDMk+EVQ0QzLQgxGlUSmqsmuEEs8kpHLXpzA8uouznmUdXcjiAE/IV+k
 vvkHgAxnPxFfXUqZfqHsmwxqqTdui3nnh+hSqqOqWtlIiIHDuSrwnAGAFSTuLfbzCu2wacnvV
 p26CEpUE2OLZBZuSWNlNgcZH9qYD0u84SeTjZWC6Rbta6oaLZ6QQJPP2SC2Akg4OEW9YH00VF
 pPplw3wNbl/O3hBcJyMXlpeomCnslAuXpOif5dSfwaIGJrJcV2+OHYr49V+YxTZBrH0ZzfBC1
 EBTUatCKAvDD5m7Cf4NAGYMsqNZSufWZCl4DHzzKQSC/2NyyAGVPqsfwPic+rBDYrBlRfJVbu
 8aupzPv6lGsqVyJzFWqzRWkQN0+4z2hYpLfVMMbTmsts5rFJg57lbiyqNY7dHmsC8zRTNICYb
 MhBeRt+RAsJD9P+wQDxQR3AfbmbQ8Q0Q0cyDGSOOdLYAYaJxElXAkgk1a

Am 05.11.24 um 16:33 schrieb Mario Limonciello:

> When two profile handlers don't agree on the current profile it's ambigu=
ous
> what to show to the legacy sysfs interface.
>
> Add a "custom" profile string that userspace will be able to distinguish
> this situation when using the legacy sysfs interface.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c  | 1 +
>   include/linux/platform_profile.h | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 8de7c8352673e..d8c2d195106c2 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -20,6 +20,7 @@ static const char * const profile_names[] =3D {
>   	[PLATFORM_PROFILE_BALANCED] =3D "balanced",
>   	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] =3D "balanced-performance",
>   	[PLATFORM_PROFILE_PERFORMANCE] =3D "performance",
> +	[PLATFORM_PROFILE_CUSTOM] =3D "custom",
>   };
>   static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_LAST);
>
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_p=
rofile.h
> index f81c3afcb7575..d2a2ab4c6cee9 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -23,6 +23,7 @@ enum platform_profile_option {
>   	PLATFORM_PROFILE_BALANCED,
>   	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
>   	PLATFORM_PROFILE_PERFORMANCE,
> +	PLATFORM_PROFILE_CUSTOM,
>   	PLATFORM_PROFILE_LAST, /*must always be last */
>   };
>

