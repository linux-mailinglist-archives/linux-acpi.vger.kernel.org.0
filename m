Return-Path: <linux-acpi+bounces-10803-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB45A1AA3F
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 20:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E01168FDF
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 19:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC5B1ADC9A;
	Thu, 23 Jan 2025 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRUX8IpJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866701ADC97
	for <linux-acpi@vger.kernel.org>; Thu, 23 Jan 2025 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737659909; cv=none; b=SPsbNZ3NlfM4o6MID3KzgyL/cC9OCyev3sEZIheCakrZzxMUg3kEKU/nBJljZc68WOYPmfm5poQxYWds+nfFhDCbpsGSPbT+g5qjGfpamif6+Bt3wx0KNKVBYDV+iB+scWRx52Ths9AF4HdYkBvIH8zK7jrsHSWbapAjEpUYw0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737659909; c=relaxed/simple;
	bh=P008RMjmbl6zSXRN6lscSGUJ5eYqZncjjqT9qit8Dfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssnaFtrJyb9MawIlKnFJ/FD5oQ4Wfxt1a5/NZyGMS2Y4p9d+ZtojgHHXoZFQz7IazGpafb1xQXOu633K9xfhOc1raecKjwabaKMZYuWQo/7qPp9yxUH4reqlo+1VqkDtrfY3EuWSp+q1H849FWOuMMXco+jYMXQO1nmQKrczHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRUX8IpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF07C4CEDF
	for <linux-acpi@vger.kernel.org>; Thu, 23 Jan 2025 19:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737659908;
	bh=P008RMjmbl6zSXRN6lscSGUJ5eYqZncjjqT9qit8Dfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BRUX8IpJVDwUaMSMLBtYEQibpW8KrRwQ6U8EzWPykRVUkinsYXvDCg8hCY8rQb7Sj
	 jNICsWT4ZJGRLtYlNltinJPnKZQD1F4cITdY9brS+/Sozk2Y/WpCS1VO4usY3dnDuy
	 xR2rc6JwTf7HHxtFdgd5aqio27L90GyUt1kAZvgZy3Mw4AhVZ8WKEgFNC79pS2u2JN
	 lMbBSlRR8KQHBhfm2atcn1FFAUHCDB7KYj0ZIFrru9u9Ns2YvZT2dYf3PYGDnoFXkF
	 eX16asf86iiSNrOC4tL/mR5NmRa//sZz9K0s8oO7pUCQVIR2f1H3xU5huSm/GZ+xk9
	 OYj12Br9gZuCA==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ebbe804913so350289b6e.0
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jan 2025 11:18:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWu3nn4KOOb9rY09/1QOxzMCsubEhf4Elxn+vJtWIMKu/V7uNh5xgvAZYO9SZxp/avWbO7/4/6b6LL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx58J5bHSvEIr8GQUAdd0oZXNLqKKrHybjB/ubCVOshG5Q5aFC
	3ewq5ix0uaZ9X046+4JcFTUHI6SewQdMinB+lKmz2FjVoyjLZO5Z6x5ao9EWCbgPzB1zx1ObCCM
	ieXI5k7UCkzX55DfjYJ7tE2UIMQY=
X-Google-Smtp-Source: AGHT+IFpchuBOeHQ9K08d5mYWFa2zGgwXRmy0tybh0BzD2KzHhabZlkctEI0i3xVimviz+Cn9xNrmfTAvmlGhtUxuVU=
X-Received: by 2002:a05:6808:228f:b0:3ea:43b8:29f2 with SMTP id
 5614622812f47-3f19fc2ab86mr17980815b6e.17.1737659908127; Thu, 23 Jan 2025
 11:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123132202.18209-1-hdegoede@redhat.com>
In-Reply-To: <20250123132202.18209-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Jan 2025 20:18:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iuNwqmcUh3Gk1=qG9Bm3RvSVNMO_1t==K6JPe+w7VJwg@mail.gmail.com>
X-Gm-Features: AWEUYZlq6qA-gsSd9khA14CVm6Er1ieHzkKhVYqawM0YK-GWI8TM91CVQ7gUcIY
Message-ID: <CAJZ5v0iuNwqmcUh3Gk1=qG9Bm3RvSVNMO_1t==K6JPe+w7VJwg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: Add skip i2c clients quirk for Vexia EDU ATLA
 10 tablet 5V
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 2:22=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> The Vexia EDU ATLA 10 tablet comes in 2 different versions with
> significantly different mainboards. The only outward difference is that
> the charging barrel on one is marked 5V and the other is marked 9V.
>
> Both ship with Android 4.4 as factory OS and have the usual broken DSDT
> issues for x86 Android tablets.
>
> Add a quirk to skip ACPI I2C client enumeration for the 5V version to
> complement the existing quirk for the 9V version.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/x86/utils.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index cb45ef5240da..068c1612660b 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -407,6 +407,19 @@ static const struct dmi_system_id acpi_quirk_skip_dm=
i_ids[] =3D {
>                 .driver_data =3D (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
>                                         ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTE=
RY),
>         },
> +       {
> +               /* Vexia Edu Atla 10 tablet 5V version */
> +               .matches =3D {
> +                       /* Having all 3 of these not set is somewhat uniq=
ue */
> +                       DMI_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M.=
"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "To be filled by O.E.=
M."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "To be filled by O.E.M.=
"),
> +                       /* Above strings are too generic, also match on B=
IOS date */
> +                       DMI_MATCH(DMI_BIOS_DATE, "05/14/2015"),
> +               },
> +               .driver_data =3D (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
> +                                       ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTE=
RY),
> +       },
>         {
>                 /* Vexia Edu Atla 10 tablet 9V version */
>                 .matches =3D {
> --

Applied as 6.14-rc material, thanks!

