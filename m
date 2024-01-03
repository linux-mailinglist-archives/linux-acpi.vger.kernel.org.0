Return-Path: <linux-acpi+bounces-2688-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7123822EE2
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 14:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16A91C21756
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 13:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E557119BAF;
	Wed,  3 Jan 2024 13:47:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3451A581
	for <linux-acpi@vger.kernel.org>; Wed,  3 Jan 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-594363b4783so294165eaf.1
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jan 2024 05:47:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704289675; x=1704894475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsoOPSl62cwg1yP827bfdd1JcnLDwtSBoRDxrgJaISM=;
        b=Aao8fjX4dY6MfmONoR3dUUwcAuJ7gp2XawZApXtTDEvC9Zo4D1/EBI7BhixfUyWF1O
         I0zBCpx3i5BwMtkxpEnjoU+fxYwy8Y3ZIE/lQJw9DID+Ll/nxXdRkl9pj5gj5BT5TBhw
         Ockx2XHnVs0qH7Z/uCTacGRnpCcuKX1LaoxDzN67nrWlm2ugzKxLlxUPkHtFS2F43/QZ
         LbbnO0p4uS6TAC+Q8lGzG+SuMIaj8qvtXidn1QWLss3vvoxGwNubcSInNqCkRtBquyWE
         KrOwgcadKm989N8d1omMdoPOs7Grm3RtZnH6yDr8Ag8WbqhTzqb4Z7/gUyHkulJFqECj
         pG6A==
X-Gm-Message-State: AOJu0YxR60ru7GVcxn3TeZPRMG8I+sAvJTV3vKnygBMv23fSKk8d/nUL
	b9Lip389NTrmtIDYeM27NTc3bZUp+5tL8YntCHaDu2Ye
X-Google-Smtp-Source: AGHT+IFmvrTBSOfe1CYUm6ish2j0WM58M8IQ8QGbNoZLZJES8slVqKcDQukwNURS7PZyaIUDusnmhNC0MyqyFBxXS+M=
X-Received: by 2002:a05:6820:2e01:b0:594:35b4:8a with SMTP id
 ec1-20020a0568202e0100b0059435b4008amr26284841oob.0.1704289674822; Wed, 03
 Jan 2024 05:47:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230150916.1843117-1-corngood@gmail.com>
In-Reply-To: <20231230150916.1843117-1-corngood@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2024 14:47:43 +0100
Message-ID: <CAJZ5v0jab+jao4=7r1LOJhNn2Pq2fc_nQ1KS02_=9Z30Eyww9A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Force irq1 edge low override on Infinity laptops
To: David McFarland <corngood@gmail.com>
Cc: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cc Hans and Mario.

On Sat, Dec 30, 2023 at 4:09=E2=80=AFPM David McFarland <corngood@gmail.com=
> wrote:
>
> A user reported a keyboard problem similar to ones reported with other
> Zen laptops, on an Infinity E15-5A165-BM.
>
> Add board name matches for this model and one (untested) close relative
> to tonfang_gm_rg, due to the board names' similarity to GMxRGxx.
>
> Link: https://lemmy.ml/post/9864736
> Link: https://www.infinitygaming.com.au/bios/
> Link: https://lore.kernel.org/linux-acpi/20231006123304.32686-1-hdegoede@=
redhat.com
> ---
>  drivers/acpi/resource.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 297a88587031..f692604b773c 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -484,6 +484,18 @@ static const struct dmi_system_id tongfang_gm_rg[] =
=3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
>                 },
>         },
> +       {
> +               .ident =3D "Infinity E15-5A165-BM",

.ident is not needed any more.

Please add a comment identifying the machine(s) instead.

> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GM5RG1E0009COM"),
> +               },
> +       },
> +       {
> +               .ident =3D "Infinity E15-5A305-1M",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
> +               },
> +       },
>         { }
>  };
>
> --

Thanks!

