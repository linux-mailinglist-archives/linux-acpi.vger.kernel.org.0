Return-Path: <linux-acpi+bounces-20940-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Mi/0EVDkjGmLuwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20940-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 21:19:28 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAB81275D8
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 21:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35D5C3016910
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 20:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14D0318EE4;
	Wed, 11 Feb 2026 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aa4C+0oI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C2261B92
	for <linux-acpi@vger.kernel.org>; Wed, 11 Feb 2026 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770841162; cv=none; b=nCz3cMup2QQI8/s0SpLJ5xNv5i4sn2jjeo43Hq+DlQFckuKBOo/MK0YfsEFHYWc/dyuaBZHLyUVOrrPC0OSbi+Ikx5l2uVctxkK55rGTKgmCJHOVPTnQyX2xLrTLfpyNioiyw0Gltkxn/vlJJBb/Xu9QstcWfxaaIilcwNamhE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770841162; c=relaxed/simple;
	bh=rThvMKzr5yNt7vSe9QblRfC3v8NQ22l7POrhG7Uisl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uq39n2XQM0CxmFQeXJme12PUZyvrhtrDZmyq05nh7sb+YmnRpAkVM0uc/ejF3PMxayRlQ3xl/ZrENqZMUiLGxdLPzt0cf8AGM2O4CkqZgNXaYm2syMQcgm/zav7ZoxZdrhwUHyPKv5B5ULAXkUN1EEcsxUzY1CDQcFWI2cMZr28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aa4C+0oI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70526C19425
	for <linux-acpi@vger.kernel.org>; Wed, 11 Feb 2026 20:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770841162;
	bh=rThvMKzr5yNt7vSe9QblRfC3v8NQ22l7POrhG7Uisl8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Aa4C+0oIFxfmk1uXryokdMF37HJgN3CEzeLszCeIEgQkrdlAYp8ym+FGBk5z20FzX
	 qVVRqmH0vNNBGrlWyca2r7L1Xm1rXFB4ZGf8ywsxpZbYIRvhwZ4Om+NjNQN40zcZNi
	 STWC0evan21rlwnPrxgPOD2rC0meZFXv0WNnCDjUS/b2Ac5NN2pHXIY72qhqZfB5i3
	 Zqh4QE0QjLtavTiLsbYlaRa0I5zNeLenk4V2Lu2A5aH5sBTmy0lC6RbdjLtr3tGxID
	 M9irxjLIeX30bTZaDsGbEUn8qmHQ9AZIwYByLobkJ1t3Q1gdA+tsm55FE4cL3pPAxA
	 BdW5QkXXlRuXA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4094b31a037so4109068fac.1
        for <linux-acpi@vger.kernel.org>; Wed, 11 Feb 2026 12:19:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWruDsDQVhGGVdwOgDWjbOspgPzgtEATlFDnjyNlYhu6hINhD8SnSx8hAufSlBlFv250af8JMASJsYS@vger.kernel.org
X-Gm-Message-State: AOJu0YyJcaWr7tClmGf8XY7AZe14LmLnGCV9sAgW49Vdt99Je34ngidv
	AA20rhWIdiFbGT+IYDy/BUNmWQ/YZZR2CHKPakJNYBUUQ0XQT1oRLKcbnR53cwhEPkBxPyGzfR5
	YLXMN/X+l8gLcpSzsMiHLlHSZg9GoWuY=
X-Received: by 2002:a05:6820:1b18:b0:662:f61e:75a8 with SMTP id
 006d021491bc7-6759b2edc4cmr206502eaf.65.1770841161587; Wed, 11 Feb 2026
 12:19:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <GV2PPF3CD5B63CC2442EE3F76F8443EAD90D499A@GV2PPF3CD5B63CC.EURP251.PROD.OUTLOOK.COM>
In-Reply-To: <GV2PPF3CD5B63CC2442EE3F76F8443EAD90D499A@GV2PPF3CD5B63CC.EURP251.PROD.OUTLOOK.COM>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Feb 2026 21:19:10 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j_+SbSwiyT2eq2R_7GE2YOvDuhShEqfdtr--XVNCdhNA@mail.gmail.com>
X-Gm-Features: AZwV_QjEIExPEkkCMkSkbBKvilivcIF4bfdKKvD1f33FlmugUB7Y9Vyn8ikw_XA
Message-ID: <CAJZ5v0j_+SbSwiyT2eq2R_7GE2YOvDuhShEqfdtr--XVNCdhNA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: save NVS memory for Lenovo G70-35
To: Piotr Mazek <pmazek@outlook.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20940-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,outlook.com:email]
X-Rspamd-Queue-Id: 8FAB81275D8
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 11:06=E2=80=AFPM Piotr Mazek <pmazek@outlook.com> wr=
ote:
>
> From: Piotr <pmazek@outlook.com>
>
> [821d6f0359b0614792ab8e2fb93b503e25a65079] prevented machines
> produced later than 2012 from saving NVS region to accelerate S3.
>
> Despite being made after 2012, Lenovo G70-35 still needs
> NVS memory saving during S3. A quirk is introduced for this platform.
>
> Signed-off-by: Piotr Mazek <pmazek@outlook.com>
> ---
>  drivers/acpi/sleep.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 66ec81e306d4..132a9df98471 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -386,6 +386,14 @@ static const struct dmi_system_id acpisleep_dmi_tabl=
e[] __initconst =3D {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "80E1"),
>                 },
>         },
> +       {
> +       .callback =3D init_nvs_save_s3,
> +       .ident =3D "Lenovo G70-35",
> +       .matches =3D {
> +               DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "80Q5"),
> +               },
> +       },
>         /*
>          * ThinkPad X1 Tablet(2016) cannot do suspend-to-idle using
>          * the Low Power S0 Idle firmware interface (see
> --

Applied as 7.0-rc material, thanks!

