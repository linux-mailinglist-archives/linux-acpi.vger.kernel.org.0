Return-Path: <linux-acpi+bounces-20911-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIFCOiAgimkAHgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20911-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 18:57:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 618AF1134DD
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 18:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DD3D301DEE7
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Feb 2026 17:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B567385EC2;
	Mon,  9 Feb 2026 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL1t653U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AC8385535
	for <linux-acpi@vger.kernel.org>; Mon,  9 Feb 2026 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659852; cv=none; b=eLE8lia/H7N696PraeYtqhmTd1F12NZShcKngCcVSZviAAvvhnyS77VfWT82Z+mmhr2Y/g4FgarIP0rvz5e46t8K5Cd8ZoIiKQPD5E0j7VYWBv+hNc68i2WqrQT8qOiYbw/lh8Vi+3Q3UZ+vmHO5xHB3HwAmNGnoJ0k94LeBrRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659852; c=relaxed/simple;
	bh=un5y1+8gDxSWg+WtEts3vaKtMUgcg6VA+H27hy0DtRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNOAiApG4DC8qkg/PIF7o2GcTeyfl0JfIL0OznT8qrqeGHq5Z6k43CxsP0jV+2rQjl65wCnJ2nxAf1xsFfd3IEePpzk5TiHudsqLioq4bXjoQigy25cdxJ68aQqLQFQ2j0QiOyvalRml/oFDvdvF7THpc0+zSK11IiBjiOCMFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL1t653U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D305C4AF09
	for <linux-acpi@vger.kernel.org>; Mon,  9 Feb 2026 17:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770659852;
	bh=un5y1+8gDxSWg+WtEts3vaKtMUgcg6VA+H27hy0DtRQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cL1t653UE9ZdHPe4zAqY75ZQ55gcdtBC1QbeMnbgmsODM5nOUBcGFWtt2OxTdIgGJ
	 MPcPCRMPE5VdNOWlPIiKxr3lcMeZnnWYOezs6zLp1UA9ev8M4LvzWZG6hzcCrAcS3I
	 r2oAYW5J+z/yvXvcxSwesH+znjqVTwAn2V3Hi1JpdKr2KhTb9bSpdG9qfev3QChSUZ
	 VysYQmg8caORaksZ4kOjZFDm269NqHY4aAjt5cSbZKo3auxZKeGuq2PQyibKy2tCBB
	 OHj2P2vUv93MfbROIP3TW9cknvq+AS3vGQEAWYgyi5T5j3L/ro+uwHzqpxGiwWGNHW
	 AOPqvGEyul8nQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4042f55de3aso3700108fac.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Feb 2026 09:57:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1DQV5nILOiYAW07xdXxBZLIMKS4ecqxdCRh2ImcqD9JtvrzduwpXwrDn0eZl0hHwjhlpgu1rVffwB@vger.kernel.org
X-Gm-Message-State: AOJu0YzSluaL+bBmFDCy3gwpHsnq0YLKJeCZPSyAYq8tebGUtKlz0UCH
	TzX0j75HAlqcnig6hwZmMgpp3d+Mw8sGLBJ3FSC14HSBeANSQkKo0+ee3AdMgw/7g9LWcT4UVXI
	9NjejvAHQeemo99h3ItA7JYD/gjNFRYo=
X-Received: by 2002:a05:6870:e08f:b0:404:2e44:18b6 with SMTP id
 586e51a60fabf-40c10f9327amr156284fac.16.1770659851079; Mon, 09 Feb 2026
 09:57:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209173827.87744-1-alperyasinak1@gmail.com>
In-Reply-To: <20260209173827.87744-1-alperyasinak1@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Feb 2026 18:57:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hnWigDAgAsd6moc6qaK2Hn2MfU7PunrgukOAPCvt8dHQ@mail.gmail.com>
X-Gm-Features: AZwV_QjDiM1aqNo6onM7RvoEOlL3lFSPen-qARDztMkvX4noNdBFfAbkCf987qw
Message-ID: <CAJZ5v0hnWigDAgAsd6moc6qaK2Hn2MfU7PunrgukOAPCvt8dHQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: battery: Avoid dereferencing battery before NULL check
To: Alper Ak <alperyasinak1@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20911-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 618AF1134DD
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 6:38=E2=80=AFPM Alper Ak <alperyasinak1@gmail.com> w=
rote:
>
> acpi_battery_notify() dereferences the battery pointer before checking
> for NULL. Reorder the check to ensure the pointer is validated before
> use.

The check is redundant, please see:

https://lore.kernel.org/linux-acpi/5981321.DvuYhMxLoT@rafael.j.wysocki/

> This issue was reported by the Smatch static analyzer.
>
> Fixes: 08b54fd57782 ("ACPI: battery: Adjust event notification routine")
> Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
> ---
>  drivers/acpi/battery.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 3bbddd6f622c..abc82be69215 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -1063,12 +1063,14 @@ static void acpi_battery_refresh(struct acpi_batt=
ery *battery)
>  static void acpi_battery_notify(acpi_handle handle, u32 event, void *dat=
a)
>  {
>         struct acpi_battery *battery =3D data;
> -       struct acpi_device *device =3D battery->device;
> +       struct acpi_device *device;
>         struct power_supply *old;
>
>         if (!battery)
>                 return;
>
> +       device =3D battery->device;
> +
>         guard(mutex)(&battery->update_lock);
>
>         old =3D battery->bat;
> --
> 2.43.0
>
>

