Return-Path: <linux-acpi+bounces-2700-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEAD8235E2
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 20:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3821C2140D
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 19:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486481CF90;
	Wed,  3 Jan 2024 19:49:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E529A1CF92
	for <linux-acpi@vger.kernel.org>; Wed,  3 Jan 2024 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbe78dbd1aso450108b6e.1
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jan 2024 11:49:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704311397; x=1704916197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cy9nfsDa9YfpVOn5YJRqAl8YxyjiewbksGHJnRYW/ic=;
        b=VA5PMnOnSTZN7Vuq94XrixWHjZBbwjnZNdd5o1Zw/w49Ak9HsWGJLk+6HGZ3nmmQxp
         Vi+LggotMosMKMbxMe2SzcZc783O0N0C1Cy1N6RTLn2BN87mqe+iPCvLmy45wwrEPMpG
         Unxtn8TXVc8GHu3GVNqus+MKpFtBbT8hRppRgbw+jv5nPMReuZSnP7309K5MWkSzBDqC
         f3dUN5tyGrviehgwLU05s2mkz2f3wdjnQ1zoVqzOtEG8IXCfo5qr3/TDsFIuCIyDlIRa
         0SM99ZbvyBOtxEjnLUYiUcH90JDUumg3eAx5Zr7oz+PyzNwhPrkcNhn+v4XQJ3hiD14q
         uREg==
X-Gm-Message-State: AOJu0Ywo3h9P6eosxey0g06cwDKJoJTg8t7czNfvFRqvJLYyz0xIogpY
	tPiF+iVcN0mvNlPKuBney4LarRczx/dUpUatGpQ=
X-Google-Smtp-Source: AGHT+IH1DnD3ZHlXLqBI/eqO2b45gnLJyaA4V+KCOgV/vnmx5WdA0JQLN+r6+p5tDDFX5T0r7F8nL0cfjfXpsOGnIEw=
X-Received: by 2002:a05:6808:2a73:b0:3bc:1171:470c with SMTP id
 fu19-20020a0568082a7300b003bc1171470cmr6350047oib.5.1704311397022; Wed, 03
 Jan 2024 11:49:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230150916.1843117-1-corngood@gmail.com> <CAJZ5v0jab+jao4=7r1LOJhNn2Pq2fc_nQ1KS02_=9Z30Eyww9A@mail.gmail.com>
 <87il4a4ipc.fsf_-_@gmail.com> <fe82ff9a-3d9d-43a6-ae83-7b9953d3cb5d@redhat.com>
 <87edey4bcp.fsf_-_@gmail.com> <877ckq4az2.fsf_-_@gmail.com> <8734ve4art.fsf_-_@gmail.com>
In-Reply-To: <8734ve4art.fsf_-_@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2024 20:49:45 +0100
Message-ID: <CAJZ5v0grPN5p_ct3zoyHXEeuaTLHMZm=Jf7H=fWHbF7cA83opQ@mail.gmail.com>
Subject: Re: [PATCH v5] ACPI: resource: Add Infinity laptops to irq1_edge_low_force_override
To: David McFarland <corngood@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 5:55=E2=80=AFPM David McFarland <corngood@gmail.com>=
 wrote:
>
> A user reported a keyboard problem similar to ones reported with other
> Zen laptops, on an Infinity E15-5A165-BM.
>
> Add board name matches for this model and one (untested) close relative
> to irq1_edge_low_force_override.
>
> Link: https://lemmy.ml/post/9864736
> Link: https://www.infinitygaming.com.au/bios/
> Link: https://lore.kernel.org/linux-acpi/20231006123304.32686-1-hdegoede@=
redhat.com
> ---
>
> - v5: fix commit message
>
> Apologies again, in my haste I made a typo in the commit message.
>
>  drivers/acpi/resource.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index c3536c236be9..0e2c397b1399 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -555,6 +555,18 @@ static const struct dmi_system_id irq1_edge_low_forc=
e_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "GM6BG0Q"),
>                 },
>         },
> +       {
> +               /* Infinity E15-5A165-BM */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GM5RG1E0009COM"),
> +               },
> +       },
> +       {
> +               /* Infinity E15-5A305-1M */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
> +               },
> +       },
>         { }
>  };
>
> --

Applied as 6.8 material, thanks!

