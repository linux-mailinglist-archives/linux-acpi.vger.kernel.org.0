Return-Path: <linux-acpi+bounces-20949-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KydDE69jWnL6QAAu9opvQ
	(envelope-from <linux-acpi+bounces-20949-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 12:45:18 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8920012D1D3
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 12:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D30F7301A704
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 11:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD278346AED;
	Thu, 12 Feb 2026 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUjkD+nS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79102DAFBD
	for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770896694; cv=none; b=Al/JWm69pPcOzhQB0fy6giY8TSt+eOjPwy3pZRDGlB1mcg8vsxkSsoSUmEvFOv8VeME1AoIp6pwuuAK85Qjs226MKX0KAe0UGAQ6lEpqtvkvxp0Po4od2+nPhc9RHM4FflsWdAZ7mgU+uRUA/Hq7ZVUm8so3pTEEvg95RqMK7Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770896694; c=relaxed/simple;
	bh=tpdj+zuFt2n98g3229+7PupGPWLqPWUQhEFmRjVDOjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYwnuFloeyfgs0UGNtcqv8BFuib5rwVT3AJ7spkK9go8ZIPBngqSdmOd9nk8KIMqiXMuldyOttoukK1ozJMqRm3Rzth1L9yKBrJs1GeWjIcRvE3Mmt0GvnMpQvEubqLvplNycQzht68gRSnlBHhx5hyhzj167gm87JeX/vDuMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUjkD+nS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92885C19425
	for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 11:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770896694;
	bh=tpdj+zuFt2n98g3229+7PupGPWLqPWUQhEFmRjVDOjc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VUjkD+nS6eAi1BrNWUaVVZd1FVLFsX1kB3AlZNlVK7SPHQenTnIi0YnfI113dmGZV
	 O8ceqmGS0K05ywCDrkJdU6yc9orGxUui0rjhhhAYokysBuDLtkpV+zrTtmtYXcrU02
	 +qmZvBZrUSs/0vYgo/wUZWb97ZCUtLf5URhAStzHTaaUfkkGVtpplNTS3h0WspgSp7
	 WAjnUba/dI+ee5reh/2WgXqYO42iTrWFP4H3Q9zGVDeFxYaSUwlw4anricctdcURMQ
	 CPDF2Jmzbmu+R4uK5Yr9GDJprmgsFAYjmxNnBAQudfUZVlZAO68ltpLQpV2WwUV4aa
	 m45a0DH0oaRgQ==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45f126d47b8so3908949b6e.2
        for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 03:44:54 -0800 (PST)
X-Gm-Message-State: AOJu0YwJc0XgTLK1QEVTXMuaOJZ14XXkc/Ij6jA1SrqUpvK544B2gfll
	lEi0lKtGWWCiENBbPuvbd+C91H3KLOKzTT5Vs3fhQ81OWuEj8h58jziL3Ga6xOl9pNjdt7bbf75
	sh+kvMTLJXG7tLfaREl5CwlqCyFZQLaI=
X-Received: by 2002:a05:6820:4913:b0:662:f837:e6bf with SMTP id
 006d021491bc7-67598941f08mr967097eaf.21.1770896693736; Thu, 12 Feb 2026
 03:44:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211222242.4101162-1-jekhor@gmail.com>
In-Reply-To: <20260211222242.4101162-1-jekhor@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Feb 2026 12:44:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jEy_D3nGpQYufmcxmV+Uwgsy4U-VydKEfJhj_BxL-KPw@mail.gmail.com>
X-Gm-Features: AZwV_Qi6Zdjk-bhgCUATVDNQtrkN2e_NZFNUWkfXciC_WYll3Kyq7iUKlmj-N4c
Message-ID: <CAJZ5v0jEy_D3nGpQYufmcxmV+Uwgsy4U-VydKEfJhj_BxL-KPw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: Force enabling of PWM2 on the Yogabook YB1-X90
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20949-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8920012D1D3
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 11:22=E2=80=AFPM Yauhen Kharuzhy <jekhor@gmail.com>=
 wrote:
>
> The PWM2 on YB1-X90 tablets is used for keyboard backlight control but
> it is disabled in the ACPI DSDT table. Add it to the override_status_ids
> list to allow keyboard function control driver
> (drivers/platform/x86/lenovo/yogabook.c) to use it.
>
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  drivers/acpi/x86/utils.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 4ee30c2897a2..418951639f51 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -81,6 +81,18 @@ static const struct override_status_id override_status=
_ids[] =3D {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
>               }),
>
> +       /*
> +        * Lenovo Yoga Book uses PWM2 for touch keyboard backlight contro=
l.
> +        * It needs to be enabled only for the Android device version (YB=
1-X90*
> +        * aka YETI-11); the Windows version (YB1-X91*) uses ACPI control
> +        * methods.
> +        */
> +       PRESENT_ENTRY_HID("80862289", "2", INTEL_ATOM_AIRMONT, {
> +               DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
> +               DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM=
"),
> +               DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
> +             }),
> +
>         /*
>          * The INT0002 device is necessary to clear wakeup interrupt sour=
ces
>          * on Cherry Trail devices, without it we get nobody cared IRQ ms=
gs.
> --

Applied as 7.0-rc material, thanks!

