Return-Path: <linux-acpi+bounces-10421-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACD2A04927
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 19:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482853A5E6D
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 18:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13BD1DF25C;
	Tue,  7 Jan 2025 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqrZZehn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94AA86330;
	Tue,  7 Jan 2025 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274300; cv=none; b=Z999IREH0BKwvJQp0qhM6Z7VvDrKtxcpSErXjwgpsX2O8D6znD7lt+XJm+4atJlSXUXpoqhbqmIbFLwzX2jBV2MfiCjeKUUyaaCiS4GF+zSlW0sLSTPCbtcqYkkhMnS2K7TPybSpF97zgK+QYa6zWXdSHdRhfCTCuRKM8AqYrkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274300; c=relaxed/simple;
	bh=lonG0IiiU1iXDkrCTGQsNefJ6Dp6UPc9VlN2BvNf6YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsF2pBjcBxGBXjInU4LswQbXX+xJOVoZNWmuUeSznEDhTATJvDJo3A3E1xINsusWYFL7X3ZnjKVDZrqasKv/hkucca1O/tzQ5VYGK7iBwCeEr0VOYDV77CTiEjJnsQ7qCW9PQT/vxIbbXgFWTikZGZEmAxZ9ck/zL0l66ITThkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqrZZehn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C36C4CEE0;
	Tue,  7 Jan 2025 18:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736274300;
	bh=lonG0IiiU1iXDkrCTGQsNefJ6Dp6UPc9VlN2BvNf6YM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MqrZZehnoRn2mzlOXEQ8H2WoyXC1mQyNQ96I69F2M8FrwFc5C+7+FN7iGh2GTZge2
	 C2PMv0GO29Whonh9KpZKMxjM9c7sfVDZwhx6OQ07YFwhvTGD7uymDs94k4fpSZ2QUt
	 wWlxUIG0HMxstQCyx/ikvCnX6CQKBLhUQ98KT3kAXTY5jXA0FJZdX9qGvpw8WDMVhI
	 lNTpQk1K/8Pd+3Ela6Tp2kWxtjw/gumUux19M1YXHsNVNLU3isMohTKnHIF9VchRl1
	 aQoWVXhCQYikSotJMcmNGhFnEFmPcl1vq2o6BszTojzMw0sONAWZcgZCkivZQXI0vg
	 bLNvAvFx3YnwQ==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb7ecc3c54so7940732b6e.0;
        Tue, 07 Jan 2025 10:25:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8kpbtdQBsCXKM4Ro/O6vMQcUyCmVVwpJkxKZA6E25sevFBG6KTpdNN5r5GzYkvG3yE40ScJTR@vger.kernel.org, AJvYcCX1XAPhnQXyaFJ6fdUSXWbpGt1mzS8SanRpw7VqBa//o9S1NtG57ryI07Tz2xyzH+HGysCJT+Sm8FBy@vger.kernel.org
X-Gm-Message-State: AOJu0YxaBNravcR34ycivwXUfb3ZAtYME4bOAVV+CesqMw2lHFRkmj9P
	0B1eYpmGEZUbDEHhg+7jCvhUp5OFBVvPyuNdXBYXR1Pi2PkB+H/x4Hf2E8lOSAK9ZXrbNX8P4Ll
	7+UnBECQgy/T5S+oeDUls7bl7+I4=
X-Google-Smtp-Source: AGHT+IHrse1FktLgCYAp33BYjM1tcjpCmja83hq8TRbhAp00H9zVI2LaPokqH1fZi/5PS0YEtqMy4fxKQNamQ9xiL9c=
X-Received: by 2002:a05:6808:302a:b0:3eb:6e12:add6 with SMTP id
 5614622812f47-3ef2edd3c48mr16771b6e.31.1736274299721; Tue, 07 Jan 2025
 10:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241228164845.42381-1-hdegoede@redhat.com>
In-Reply-To: <20241228164845.42381-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Jan 2025 19:24:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0isL4ujPDKgWBV4StpQwrqa75xK+wjwv5t0DUs5bne5uw@mail.gmail.com>
X-Gm-Features: AbW1kvYOcpTcT1oypowhJKmjBizTGwC7HuKbsqrNoeUPKufiuCjMvJ3CPc9WPEQ
Message-ID: <CAJZ5v0isL4ujPDKgWBV4StpQwrqa75xK+wjwv5t0DUs5bne5uw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Add TongFang GM5HG0A to irq1_edge_low_force_override[]
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Werner Sembach <wse@tuxedocomputers.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-acpi@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2024 at 5:49=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> The TongFang GM5HG0A is a TongFang barebone design which is sold under
> various brand names.
>
> The ACPI IRQ override for the keyboard IRQ must be used on these AMD Zen
> laptops in order for the IRQ to work.
>
> At least on the SKIKK Vanaheim variant the DMI product- and board-name
> strings have been replaced by the OEM with "Vanaheim" so checking that
> board-name contains "GM5HG0A" as is usually done for TongFang barebones
> quirks does not work.
>
> The DMI OEM strings do contain "GM5HG0A". I have looked at the dmidecode
> for a few other TongFang devices and the TongFang code-name string being
> in the OEM strings seems to be something which is consistently true.
>
> Add a quirk checking one of the DMI_OEM_STRING(s) is "GM5HG0A" in the hop=
e
> that this will work for other OEM versions of the "GM5HG0A" too.
>
> Link: https://www.skikk.eu/en/laptops/vanaheim-15-rtx-4060
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219614
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/resource.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 7d6537ea176f..90aaec923889 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -653,6 +653,17 @@ static const struct dmi_system_id irq1_edge_low_forc=
e_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
>                 },
>         },
> +       {
> +               /*
> +                * TongFang GM5HG0A in case of the SKIKK Vanaheim relabel=
 the
> +                * board-name is changed, so check OEM strings instead. N=
ote
> +                * OEM string matches are always exact matches.
> +                * https://bugzilla.kernel.org/show_bug.cgi?id=3D219614
> +                */
> +               .matches =3D {
> +                       DMI_EXACT_MATCH(DMI_OEM_STRING, "GM5HG0A"),
> +               },
> +       },
>         { }
>  };
>
> --

Applied as 6.13-rc material, thanks!

