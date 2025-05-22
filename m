Return-Path: <linux-acpi+bounces-13853-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D932AC153C
	for <lists+linux-acpi@lfdr.de>; Thu, 22 May 2025 22:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8081BC556D
	for <lists+linux-acpi@lfdr.de>; Thu, 22 May 2025 20:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4702BF3E9;
	Thu, 22 May 2025 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="BgNGH79U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A642BF3D3;
	Thu, 22 May 2025 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944274; cv=none; b=AW0USGhUUE71IIIiE5fMOL7QA/omDdiPZY04IQPusWZ2bHG0cMf6csCBMnYy3akSm9q7B65tlO/AEeM75i8Z7X917SAwDE00ke21sZDWCRxCK6jbZV0KRtgUZo/6V6/Tmm1I7K1vHQbXyIouIKzInZY30zWuQ1E40O/WEhwQTlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944274; c=relaxed/simple;
	bh=m/0j/7QIFLkrNbr6N8aGMwm8ESVLo60Xq7cdaPD0R5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SMnGBFl5ySCY1TdcuAHUCCXoPW2f2gL+qHr75WwbdP7kzKL26u3JijngO6nQWeZtveQ7ncUJv3X4Woy2VIpHPDODbjZ75keD5TWKpPDYizsr9Qo641ej2guTzrxXjOwuae/CYJ4Y5q1n89SCR0tdidtAjPHneKGUoIFUBgAT5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=BgNGH79U; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747944264; x=1748549064; i=w_armin@gmx.de;
	bh=BfB9dL1BZc9EG3FvzEB/uXREN3ou+pmHQVviuUcsm4U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BgNGH79U55nM8zUb/q8drRAtlHqA3Lpf77U3IhV/F7VJAAEBZWDcHXccFMJgig/4
	 dS+JFg8hcRCK/j24RCNP3UqoasBYhwIcLTREaawCxxcy/oJodZJ2ME+e6Q+naDgif
	 26AUEY4IeJgHnXdxLH1BoYlnphFAYlmKq0M3aFH8DnsEtYpc1bWo8VQCrz8YX+G/J
	 YnWehMlb2YRMfhxZJOa4qtbUoWq0WpXy3NAarnAaxM1a4UQ44QMsWeMEVvTw/m4VE
	 RcoMqt4TfegbUI+uMs1xfd2k2EfvaRo6MLh28iLp/+WvxBmaTsAlPurLN4cOiq4ae
	 P4OIzMaYTGGR7NjkGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Vi-1v2NrU2dQW-014x44; Thu, 22
 May 2025 22:04:24 +0200
Message-ID: <91458376-dfc7-46fc-8523-aa176907d703@gmx.de>
Date: Thu, 22 May 2025 22:04:22 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: acpi: Fix platform profile driver on !acpi
 platforms
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Arnd Bergmann <arnd@arndb.de>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20250522141410.31315-1-alexghiti@rivosinc.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250522141410.31315-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NTRHH5PMFLIutW5BfrfopU/f8rUa+sK5VihkqKAXFj9HjA48cg+
 wanM72DxYHMj+d1u7zgv4yQjFNFa0RkzGLJ106jEt9z7gnHIwb8qKvn5pCemK+yrFZQpGBB
 m0jpN0pLCFlPKvNcygasmRbju2aU6ak//8ePDjggBaP7prMssLuSNIWfxh/0ZPqWyk8wo6H
 I7jHEHpYqFwOUy8J5D+yA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dKmvU3GXqqo=;z6HbBYWva0ByrtseS5PN6+K67Nw
 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

Am 22.05.25 um 16:13 schrieb Alexandre Ghiti:

> The platform profile driver is loaded even on platforms that do not have
> acpi enabled. The initialization of the sysfs entries was recently moved
> from platform_profile_register() to the module init call, and those
> entries need acpi_kobj to be initialized which is not the case when acpi
> is disabled.
>
> This results in the following warning:
>
>   WARNING: CPU: 5 PID: 1 at fs/sysfs/group.c:131 internal_create_group+0=
xa22/0xdd8
>   Modules linked in:
>   CPU: 5 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.1=
5.0-rc7-dirty #6 PREEMPT
>   Tainted: [W]=3DWARN
>   Hardware name: riscv-virtio,qemu (DT)
>   epc : internal_create_group+0xa22/0xdd8
>    ra : internal_create_group+0xa22/0xdd8
>
>   Call Trace:
>
>   internal_create_group+0xa22/0xdd8
>   sysfs_create_group+0x22/0x2e
>   platform_profile_init+0x74/0xb2
>   do_one_initcall+0x198/0xa9e
>   kernel_init_freeable+0x6d8/0x780
>   kernel_init+0x28/0x24c
>   ret_from_fork+0xe/0x18
>
> Fix this by checking if acpi is enabled before trying to create sysfs
> entries.

I already submitted a patch for this problem (see https://lore.kernel.org/=
linux-acpi/a6d92cdd-4dc3-4080-9ed9-5b1f02f247e0@gmx.de/T/)
that only disables the legacy sysfs interface while keeping the class-base=
d interface functional
as it does not depend on ACPI at all.

Thank,
Armin Wolf

> Fixes: 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI plat=
form profile")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>   drivers/acpi/platform_profile.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index ffbfd32f4cf1..b43f4459a4f6 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -688,6 +688,9 @@ static int __init platform_profile_init(void)
>   {
>   	int err;
>  =20
> +	if (acpi_disabled)
> +		return -EOPNOTSUPP;
> +
>   	err =3D class_register(&platform_profile_class);
>   	if (err)
>   		return err;

