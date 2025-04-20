Return-Path: <linux-acpi+bounces-13126-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2647FA94767
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Apr 2025 12:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7148B1717B4
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Apr 2025 10:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38EF1DF97A;
	Sun, 20 Apr 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="We/ougYr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173B14D29B;
	Sun, 20 Apr 2025 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745143617; cv=pass; b=BHghFIHuSjZPCNJ28+iQf8WlH9jX5G5jbUnB0ZGar2ySyuIb2Wxe2Mg3UwyPeVmIBPMETqr5nKjtjCdHxAuxwGaQh3Lfod+7Bv5sgEWrndL8sO5H7gXVrB7a/UxJPXLB/sQ8XZnG+2y54i0VpNQOZ6t0bOQnAAgAQcNK1ak+GY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745143617; c=relaxed/simple;
	bh=KEZ8NbBI4R0rm+plo5T2i1pnOqzfp8/jirVQ2IBpD9E=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=cxgSmv1IsnU+bGYOjMyB57y92hhX3dPRaZT2vws2DzRO5y1jCpafx+g3pU79LH5wBmw3rsTwXOfeFAOTIkILxRzK4avalFaoYcgF+IX+tdtSeZmzxVk0Xp7hUD+KwYg9jOVq+bDYFg4irH6vmkUlMYenTQbaJ63tdsQrxhGrarc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=We/ougYr; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1745143591; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QBauzDLNVigVpXO6PhsJiTmwWipRP1oE4nzNOFy35xdg6wQAl+tplqVYc/oRE9hWTHkDnt5vfrUb7wGOLQqtHp3wr2Y7yY+tpimwOPYmjbLq7VWLbb4CmBpo2YkyeKwbDTA2t8CHrss6xe5D20wn/i6MzDj3xuJd6Fx8tnyyv4c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745143591; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xemWXU9zQclMEmhBNpJXAygrjZW6BOjxP7DM9G4DMmo=; 
	b=M8b3Zham98XYbAZWSBMJwJIAXMk7KFxYXz02NMM6tJIvNJWEabPZp2fxLFobfDh2M3gAjvI1rXrXU9L6wGgmHbP82rxWvDzhKLwEWHHGErIlLlNwI30ADdUg3a/180fmszwcejUrJwKYubMsa411BzFQeQLic6Cc6P3PZu0WB/I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745143591;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=xemWXU9zQclMEmhBNpJXAygrjZW6BOjxP7DM9G4DMmo=;
	b=We/ougYr3T20guamLRPUh/e6u3gJA41/mBRueGsjxQesCN9IxwTbm5f03FdkRjBw
	qa1h49+fQ9bNBnbZS2yXuQ9M6gX/KRA5jcuS1v3IHlJ51HPe19KkDhLbQbXhuGQ3yi6
	gDEMHW0ks02dwF3FZE38cPu08bR1sYHE7TwPIioU=
Received: by mx.zohomail.com with SMTPS id 1745143589716357.5982257748544;
	Sun, 20 Apr 2025 03:06:29 -0700 (PDT)
Message-ID: <eff33a971679fb47f5c9da9fd39f433a8e997089.camel@rong.moe>
Subject: Re: [RFC PATCH] ACPI: EC: Set ec_no_wakeup for MECHREVO Wujie 14XA
 (GX4HRXL)
From: Rong Zhang <i@rong.moe>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, Mingcong Bai <jeffbai@aosc.io>,
 Yemu Lu	 <prcups@krgm.moe>, Xinhui Yang <cyan@cyano.uk>, "Rafael J.
 Wysocki"	 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org,  Runhua He <hua@aosc.io>,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250418112229.93075-1-hua@aosc.io>
References: <20250418112229.93075-1-hua@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Apr 2025 18:05:23 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.1-1 
X-ZohoMailClient: External

Hi Mario,

I noticed a patch [1] of yours fixed an identical issue on old AMD
platforms with outdated platform firmware while another recent patch
[2] set ec_no_wakeup for Lenovo Go S, and you are the author of amd-
debug-tools (hence also amd_s2idle.py). Could you kindly take a look at
this?

I reached Runhua in private, asking him to try disabling
/sys/kernel/irq/1/wakeup and
/sys/bus/serio/devices/serio0/power/wakeup to reproduce the effect of
patch [1]. Doing so also worked around the issue.

[1]: 8e60615e8932 ("platform/x86/amd: pmc: Disable IRQ1 wakeup for
RN/CZN")
[2]: b988685388ef ("ACPI: EC: Set ec_no_wakeup for Lenovo Go S")

Thanks,
Rong

On Fri, 2025-04-18 at 19:22 +0800, Runhua He wrote:
> MECHREVO Wujie 14XA (GX4HRXL) wakes up immediately after s2idle entry.
> This happens regardless of whether the laptop is plugged into AC power, o=
r
> whether any peripheral is plugged into the laptop.
>=20
> Using `amd_s2idle.py --debug-ec', we found that the laptop has a wakeup
> event triggered by IRQ 1 (PS/2 Controller) and IRQ 9 (ACPI SCI), and was
> eventually woken up by IRQ 9. Taking a look at `dmesg', we found that the
> EC was quite chatty after s2idle entry:
>=20
> [ 1842.317151] PM: suspend-to-idle
> [ 1842.317178] ACPI: EC: ACPI EC GPE status set
> [ 1842.317184] ACPI: EC: IRQ (5)
> [ 1842.317190] ACPI: EC: EC_SC(R) =3D 0x28 SCI_EVT=3D1 BURST=3D0 CMD=3D1 =
IBF=3D0 OBF=3D0
> [ 1842.317196] ACPI: EC: Polling enabled
> [ 1842.317198] ACPI: EC: Command(QR_EC) submitted/blocked
> [ 1842.317202] ACPI: EC: ACPI EC GPE dispatched
> [ 1842.317248] ACPI: EC: Event started
> [ 1842.317259] ACPI: EC: 2: Increase command
> [ 1842.317264] ACPI: EC: Command(QR_EC) started
> [ 1842.317271] ACPI: EC: TASK (14)
> [ 1842.317288] ACPI: EC: EC_SC(R) =3D 0x28 SCI_EVT=3D1 BURST=3D0 CMD=3D1 =
IBF=3D0 OBF=3D0
> [ 1842.317294] ACPI: EC: EC_SC(W) =3D 0x84
> [ 1842.317303] ACPI: EC: TASK (14)
> [ 1842.317324] ACPI: EC: EC_SC(R) =3D 0x2a SCI_EVT=3D1 BURST=3D0 CMD=3D1 =
IBF=3D1 OBF=3D0
> [ 1842.317329] ACPI: EC: TASK (14)
> [ 1842.317336] ACPI: EC: EC_SC(R) =3D 0x2a SCI_EVT=3D1 BURST=3D0 CMD=3D1 =
IBF=3D1 OBF=3D0
>=20
> [...]
>=20
> [ 1842.317399] ACPI: EC: EC_SC(R) =3D 0x28 SCI_EVT=3D1 BURST=3D0 CMD=3D1 =
IBF=3D0 OBF=3D0
> [ 1842.317405] ACPI: EC: TASK (14)
> [ 1842.317412] ACPI: EC: EC_SC(R) =3D 0x28 SCI_EVT=3D1 BURST=3D0 CMD=3D1 =
IBF=3D0 OBF=3D0
> [ 1842.317418] ACPI: EC: TASK (14)
> [ 1842.317425] ACPI: EC: EC_SC(R) =3D 0x29 SCI_EVT=3D1 BURST=3D0 CMD=3D1 =
IBF=3D0 OBF=3D1
> [ 1842.317432] ACPI: EC: EC_DATA(R) =3D 0x7b
> [ 1842.317436] ACPI: EC: Command(QR_EC) unblocked
> [ 1842.317445] ACPI: EC: Polling quirk
> [ 1842.317448] ACPI: EC: TASK (14)
> [ 1842.317455] ACPI: EC: EC_SC(R) =3D 0x28 SCI_EVT=3D1 BURST=3D0 CMD=3D1 =
IBF=3D0 OBF=3D0
> [ 1842.317463] ACPI: EC: Polling enabled
> [ 1842.317466] ACPI: EC: Command(QR_EC) submitted/blocked
> [ 1842.317469] ACPI: EC: Polling disabled
> [ 1842.317472] ACPI: EC: Command(QR_EC) completed by hardware
> [ 1842.317476] ACPI: EC: Command(QR_EC) stopped
> [ 1842.317480] ACPI: EC: 1: Decrease command
> [ 1842.317484] ACPI: EC: Query(0x7b) scheduled
> [ 1842.317495] ACPI: EC: 2: Increase command
> [ 1842.317499] ACPI: EC: Command(QR_EC) started
> [ 1842.317504] ACPI: EC: TASK (14)
> [ 1842.317516] ACPI: EC: EC_SC(R) =3D 0x08 SCI_EVT=3D0 BURST=3D0 CMD=3D1 =
IBF=3D0 OBF=3D0
> [ 1842.317521] ACPI: EC: EC_SC(W) =3D 0x84
> [ 1842.317529] ACPI: EC: TASK (14)
> [ 1842.317537] ACPI: EC: EC_SC(R) =3D 0x0a SCI_EVT=3D0 BURST=3D0 CMD=3D1 =
IBF=3D1 OBF=3D0
> [ 1842.317543] ACPI: EC: TASK (14)
> [ 1842.317550] ACPI: EC: EC_SC(R) =3D 0x0a SCI_EVT=3D0 BURST=3D0 CMD=3D1 =
IBF=3D1 OBF=3D0
> [ 1842.317555] ACPI: EC: TASK (14)
>=20
> [...]
>=20
> [ 1842.317638] ACPI: EC: EC_SC(R) =3D 0x08 SCI_EVT=3D0 BURST=3D0 CMD=3D1 =
IBF=3D0 OBF=3D0
> [ 1842.317643] ACPI: EC: TASK (14)
> [ 1842.317650] ACPI: EC: EC_SC(R) =3D 0x08 SCI_EVT=3D0 BURST=3D0 CMD=3D1 =
IBF=3D0 OBF=3D0
> [ 1842.317656] ACPI: EC: TASK (14)
> [ 1842.317663] ACPI: EC: EC_SC(R) =3D 0x09 SCI_EVT=3D0 BURST=3D0 CMD=3D1 =
IBF=3D0 OBF=3D1
> [ 1842.317670] ACPI: EC: EC_DATA(R) =3D 0x00
> [ 1842.317674] ACPI: EC: Command(QR_EC) unblocked
> [ 1842.317682] ACPI: EC: Polling quirk
> [ 1842.317685] ACPI: EC: TASK (14)
> [ 1842.317692] ACPI: EC: EC_SC(R) =3D 0x08 SCI_EVT=3D0 BURST=3D0 CMD=3D1 =
IBF=3D0 OBF=3D0
> [ 1842.317697] ACPI: EC: Polling disabled
> [ 1842.317700] ACPI: EC: Command(QR_EC) completed by hardware
> [ 1842.317704] ACPI: EC: Command(QR_EC) stopped
> [ 1842.317707] ACPI: EC: 1: Decrease command
> [ 1842.317711] ACPI: EC: Event stopped
> [ 1842.317723] ACPI: EC: Query(0x7b) started
> [ 1842.318142] ACPI: EC: Query(0x7b) stopped
> [ 1842.318150] ACPI: EC: ACPI EC work flushed
> [ 1842.318158] ACPI: PM: Rearming ACPI SCI for wakeup
> [ 1842.318169] amd_pmc: SMU idlemask s0i3: 0x1ffb3ebd
> [ 1842.318193] PM: Triggering wakeup from IRQ 9
> [ 1842.318244] ACPI: EC: ACPI EC GPE status set
> [ 1842.318249] ACPI: EC: IRQ (5)
> [ 1842.318254] ACPI: EC: EC_SC(R) =3D 0x08 SCI_EVT=3D0 BURST=3D0 CMD=3D1 =
IBF=3D0 OBF=3D0
> [ 1842.318263] ACPI: PM: Rearming ACPI SCI for wakeup
>=20
> I'm not quite sure what the EC was during this time. As
> `acpi.ec_no_wakeup=3D1' works around this issue, I believe that the EC ha=
d
> for some reason caused the system to wake up.
>=20
> Browsing the source code, I found that in `drivers/acpi/ec.c',
> `struct dmi_system_id acpi_ec_no_wakeup[]' records a few machines with
> incorrect suspend behaviors caused by EC wakeup.
>=20
> As this struct corresponds to a series of machines that needs
> `acpi.ec_no_wakeup' enabled by default, add GX4HRXL to this struct. Note
> that I have only matched the motherboard model, as MECHREVO is a "white
> label" manufacturer using commonly used chassis and motherboards - GX4HRX=
L
> may be found in a variety of laptops sold under different brands and mode=
l
> names.
>=20
> Since the reason behind this EC wakeup is not yet clear to me, I'm sendin=
g
> this patch in hope of getting more comments and guidance on how to furthe=
r
> debug this issue.
>=20
> Suggested-by: Mingcong Bai <jeffbai@aosc.io>
> Link: https://zhuanlan.zhihu.com/p/730538041
> Tested-by: Yemu Lu <prcups@krgm.moe>
> Co-developed-by: Xinhui Yang <cyan@cyano.uk>
> Signed-off-by: Xinhui Yang <cyan@cyano.uk>
> Co-developed-by: Rong Zhang <i@rong.moe>
> Signed-off-by: Rong Zhang <i@rong.moe>
> Signed-off-by: Runhua He <hua@aosc.io>
> ---
>  drivers/acpi/ec.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 3c5f34892..19f1d36a5 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -2329,6 +2329,12 @@ static const struct dmi_system_id acpi_ec_no_wakeu=
p[] =3D {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
>  		}
>  	},
> +	{
> +		/* MECHREVO Wujie 14 Series (GX4HRXL) */
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_NAME, "GX4HRXL"),
> +		}
> +	},
>  	{ },
>  };
> =20

