Return-Path: <linux-acpi+bounces-9976-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA669E6258
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 01:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC8E282C70
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 00:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187731DFD1;
	Fri,  6 Dec 2024 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="C9z+rVGa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240F256E;
	Fri,  6 Dec 2024 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445647; cv=pass; b=iLwO23VT57qO2Pd+09GhbapkosgRWrw2522HgrKB+dXCYbAhLWvuxLA7fX8DJS4d/Q+dWECZfBF7NFAX/ULNfGI055hKVJGv7FVisJq0I2zhbMPuKmUAHugJvibS9HOpkJUi3XMcBE4nhjwU7HS05o4nVHefck6GmtMTSDbE8Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445647; c=relaxed/simple;
	bh=GSIEqMYo5vThXZGy6JV5xlVJmqxSa8C704WYbVv6s8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkxbTRa999/XArwm4GFLOe95lsEIE7pXXUVZOBvGib3beYQkm8fJpZLulDndF2RWpwJQSgDLlG4y8Z1um3O9sT/ySmrNUbakg0EXAqPF1gzTMx8nnWHEDjbYP6sGyZuP1driE37hqGLPpuTQIWjdqRTBRdsM8Zb/OZq5o3pDIl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=C9z+rVGa; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733445631; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TeLcGQCU87TbxuePIUY/S7DCGt3mRBQiWubckpekdM4vKNQg1QoKOR4tyIkbYZVNLjOf9k2qaqlfXDvAcEaBUETQqZKGs+xnz8DwNLVov6/jQ4muYRYKKq/mOYx6J/QMOG/+kYOAbwXZ88znjX/n1f0I9e/aoygzKXfwh+lRTjU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733445631; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rT7++9Mdv8YbXMj7Zuc3lS7faaXPct294/dJGGRilAM=; 
	b=CCblPUzsGSQE1TMR0xcPTL3y6TnNIXXLFPkOKKjxRv9LsDGMSpS1FQh4CW9CD53xTeZV21/wL1zqbhkmlAJ9uxHqfzhUonpEFuX5MXSAr7CQjrxf/JOhBkUwR8gNYIaYBDDN8RIldHlN/IPwpZiXLtNreRV3cgt8/XKZSnpDTec=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733445631;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=rT7++9Mdv8YbXMj7Zuc3lS7faaXPct294/dJGGRilAM=;
	b=C9z+rVGa5R+LDnk358m4JnGxyS6BUiKe9f5E/zUYeeC7FQV6oYRx0a2bgU5GPyBu
	XafNAzhmc+5PerPwGx1nPpcN2Fs/CFqPgWqm/Q8Iu/PEzsw+R4K0cqDbrlaZ6hLjgR1
	ZN6YIKM9AUg9yXBLtidKYxcIwUmujIZ8JAm+42EU=
Received: by mx.zohomail.com with SMTPS id 1733445628508262.2270336570124;
	Thu, 5 Dec 2024 16:40:28 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 9C5E110604B0; Fri, 06 Dec 2024 01:40:23 +0100 (CET)
Date: Fri, 6 Dec 2024 01:40:23 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 1/4] ACPI: battery: Rename extensions to hook in
 messages
Message-ID: <esivcfgbfewjcnvc3uhsdvxbu5dmh3r5z2hjjagzvfrxxsioav@cx2du3oznvhi>
References: <20241205-power-supply-extensions-v5-0-f0f996db4347@weissschuh.net>
 <20241205-power-supply-extensions-v5-1-f0f996db4347@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q7p5clnrysa7uzxu"
Content-Disposition: inline
In-Reply-To: <20241205-power-supply-extensions-v5-1-f0f996db4347@weissschuh.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/233.395.87
X-ZohoMailClient: External


--q7p5clnrysa7uzxu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/4] ACPI: battery: Rename extensions to hook in
 messages
MIME-Version: 1.0

Hi,

On Thu, Dec 05, 2024 at 09:46:35PM +0100, Thomas Wei=DFschuh wrote:
> This functionality is called "hook" everywhere in the code.
> For consistency call it the same in the log messages.
>=20
> The power supply subsystem is about to get its own extension
> functionality. While the two are closely related and will be used
> together, the current wording leaves room for misinterpretation.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
>=20
> ---
> This patch can also be applied independently through the ACPI tree.
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/acpi/battery.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 3d5342f8d7b3ae4e259131f9c7b7144a6206cfdb..6760330a8af55d51c82a04476=
23c2040ffdaab10 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -717,7 +717,7 @@ static void battery_hook_unregister_unlocked(struct a=
cpi_battery_hook *hook)
>  	}
>  	list_del_init(&hook->list);
> =20
> -	pr_info("extension unregistered: %s\n", hook->name);
> +	pr_info("hook unregistered: %s\n", hook->name);
>  }
> =20
>  void battery_hook_unregister(struct acpi_battery_hook *hook)
> @@ -751,18 +751,18 @@ void battery_hook_register(struct acpi_battery_hook=
 *hook)
>  		if (hook->add_battery(battery->bat, hook)) {
>  			/*
>  			 * If a add-battery returns non-zero,
> -			 * the registration of the extension has failed,
> +			 * the registration of the hook has failed,
>  			 * and we will not add it to the list of loaded
>  			 * hooks.
>  			 */
> -			pr_err("extension failed to load: %s", hook->name);
> +			pr_err("hook failed to load: %s", hook->name);
>  			battery_hook_unregister_unlocked(hook);
>  			goto end;
>  		}
> =20
>  		power_supply_changed(battery->bat);
>  	}
> -	pr_info("new extension: %s\n", hook->name);
> +	pr_info("new hook: %s\n", hook->name);
>  end:
>  	mutex_unlock(&hook_mutex);
>  }
> @@ -805,10 +805,10 @@ static void battery_hook_add_battery(struct acpi_ba=
ttery *battery)
>  	list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
>  		if (hook_node->add_battery(battery->bat, hook_node)) {
>  			/*
> -			 * The notification of the extensions has failed, to
> -			 * prevent further errors we will unload the extension.
> +			 * The notification of the hook has failed, to
> +			 * prevent further errors we will unload the hook.
>  			 */
> -			pr_err("error in extension, unloading: %s",
> +			pr_err("error in hook, unloading: %s",
>  					hook_node->name);
>  			battery_hook_unregister_unlocked(hook_node);
>  		}
>=20
> --=20
> 2.47.1
>=20

--q7p5clnrysa7uzxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdSR/cACgkQ2O7X88g7
+po4bhAAkwFuiG8m9IWcEx2HNmQv44UIb3XinIolWEiYfZRJUSMOpWwCd82oXR2e
OsWFs9T8V3iRA5TBy3J0pVAp5ULCkKaOhJHTV/ktnCC6tzxXgDcOKDE10B4FfV/U
cvJ4A78qFKEGb6GJmfulG751XSG7pPs0nVd7+R57d6FTTrzWP/QUu3CNMN3+FgTI
P6khQ1fxdgI9F8Rj+/HxHOBTdmhIfEmOt7nl5C493t+re9DXPFgJcJUr91EFTr7v
fDNOTBcUaZHrxBJQz6O8Pzlwnr7NT480co94u0jaOuUxpZCw9Td3tLaEMN5U/PoU
f8P/qaKFfcbHcMvSUoqe8qr3cBGBAjelhFtgEXgsOWJPaiv2OtYq+aTIeVqHqRR0
96pTMUsycxGOJljHeMwhDymddalT0k48oPuPMkYISiSG5DKRjv7Mc/F2idqItlPj
0uQlUjsuzjNkbiETN5ykAuM0LIewgiZ517AF+xZcfPAmqDnONARc9DQHocDWKpL8
cY2C5mbdIVeTiJXEybC68vmcejLvjrhTaye7BalWN6J0nBDr+13ZHseUgKR4l48r
HeY9Gc9N70XQ/rvoQwkt7IoUHxRdGcVViKOmIUwR2S6KtcB5ArLMcRwT8ck4SzME
bwDR+eEDOEerSmCQUBTPuA/BU4F9bJNWGOBKFfHhzJCcC2metfQ=
=CczE
-----END PGP SIGNATURE-----

--q7p5clnrysa7uzxu--

