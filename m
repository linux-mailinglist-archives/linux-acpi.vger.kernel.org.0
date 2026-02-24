Return-Path: <linux-acpi+bounces-21133-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFAXISS6nWklRgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21133-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 15:48:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110E188A58
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 15:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C50173094A24
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CD022154F;
	Tue, 24 Feb 2026 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlhvpUWK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4941F8755
	for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944437; cv=none; b=oBXJhJyi6GM2IYeve/D0ndprvpuDKEWz4Fqkk7sPbOP+VJ5bP6GApxWXbsz0V5OMJhe3erioz7hZDc4kGJuFoPPB8fJVNGrRklJfjXOpoLKxe6WOPrGurw65rgw/qQ75MlBSwMs8ylU65rrjQIfJNKNmtdZU+pinv95YWhZkdcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944437; c=relaxed/simple;
	bh=HR6SwXIYzbLzdbD9bXS+UDt2zwZGO3QXIOeK1VrlTWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V76GQ3sTfcjlOc9Z+StrKBJ48sJpwohcyfKwV7Jbnx/eRgpZihDmmoDM6WvzjFiknp8iW7J9zTVB9uMG8fQAkgHbDUpZPCnsvQYiyxW20AG1MFwBMOxyixY5Y86Yixwf6kxM2IIzg5vMwY3q9OWtOqJzUqVTcjLeEMw9Q5WMUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlhvpUWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56F4C2BC86
	for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771944436;
	bh=HR6SwXIYzbLzdbD9bXS+UDt2zwZGO3QXIOeK1VrlTWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KlhvpUWK7tWpIwRJ33TPlXbLJe6shM1b23z4YEXdijxTTammvOUejMyZfb5PVHtTp
	 EUpBioJaqbRS81KmKoe6t0mULF2u+95T8IqPprQxBmK3UPs9XPVTwb+A/zw0PGwBZf
	 vbR8II/pz2X8q9BX6kQXHFnjrYMkLaxyrpA63DzjXYNk3CLaxl8yKbXO6FouMZ2/Y0
	 pvf1t4G9XDicY9UMkmEPC5LiN1jPuNUQLew0unEqnYJahl6/wEtfOaBfjO5L0TIW61
	 eqDBdFYa7dt3ehlW9smA5UkH5eAnwdSN09E1SHEFdWsPI5RB/etv+TcOiJo9rkhWQQ
	 VNoWfj7tcxXwQ==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so5162040a34.2
        for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 06:47:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDa35V+R5cMKg1TCpAGSslH6/pv/6xpen1+QofU4CzHACoB8K5kEAOIAQ0s3SxNfClkIlvlp1a30+a@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6nMdmr6uqwmV5VTEQ9ZVYDWB9v86K4LXj93ewOdshbpSP0avw
	HHbEsF8GJHYeoT0R2vqJ+pLmp2em+5fSgZJDItV3Jv4a9gohNdo42gE4VLR1eLtCglUI1uwIcdI
	BUGUrESCttLUWLdJ1Dee1C6y6dhv+Ycc=
X-Received: by 2002:a05:6820:160a:b0:662:facc:529f with SMTP id
 006d021491bc7-679c446f068mr6761829eaf.28.1771944436022; Tue, 24 Feb 2026
 06:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223025240.518509-1-sofia@schn.dev>
In-Reply-To: <20260223025240.518509-1-sofia@schn.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Feb 2026 15:47:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i3bWhzdzmBmw=cB14ogP6hBa=eppwA_Q03mHLZDk6ngA@mail.gmail.com>
X-Gm-Features: AaiRm53RfiD_OD85m-Cb9M3P2gjWxAA5c8IhuDEQ8socH_w29VTVvTPv5wj_b3U
Message-ID: <CAJZ5v0i3bWhzdzmBmw=cB14ogP6hBa=eppwA_Q03mHLZDk6ngA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: OSI: Add DMI quirk for Acer Aspire One D255
To: sofia@schn.dev
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21133-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,schn.dev:email]
X-Rspamd-Queue-Id: 0110E188A58
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 4:00=E2=80=AFAM Sofia Schneider <sofia@schn.dev> wr=
ote:
>
> The screen backlight turns off during boot (specifically during udev devi=
ce
> initialization) when returning true for _OSI("Windows 2009").
>
> Analyzing the device's DSDT reveals that the firmware takes a different
> code path when Windows 7 is reported, which leads to the backlight shutof=
f.
> Add a DMI quirk to invoke dmi_disable_osi_win7 for this model.
>
> Signed-off-by: Sofia Schneider <sofia@schn.dev>
> ---
>  drivers/acpi/osi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> index f2c943b934be..9470f1830ff5 100644
> --- a/drivers/acpi/osi.c
> +++ b/drivers/acpi/osi.c
> @@ -389,6 +389,19 @@ static const struct dmi_system_id acpi_osi_dmi_table=
[] __initconst =3D {
>                 },
>         },
>
> +       /*
> +        * The screen backlight turns off during udev device creation
> +        * when returning true for _OSI("Windows 2009")
> +        */
> +       {
> +       .callback =3D dmi_disable_osi_win7,
> +       .ident =3D "Acer Aspire One D255",
> +       .matches =3D {
> +                    DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +                    DMI_MATCH(DMI_PRODUCT_NAME, "AOD255"),
> +               },
> +       },
> +
>         /*
>          * The wireless hotkey does not work on those machines when
>          * returning true for _OSI("Windows 2012")
> --

Applied as 7.0-rc material, thanks!

