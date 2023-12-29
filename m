Return-Path: <linux-acpi+bounces-2643-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF39D8200EE
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Dec 2023 18:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3BA1C20B85
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Dec 2023 17:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FA612B7F;
	Fri, 29 Dec 2023 17:46:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC3012B7A;
	Fri, 29 Dec 2023 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-593f182f263so1546087eaf.0;
        Fri, 29 Dec 2023 09:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703871970; x=1704476770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ij+yfM4X0zpLioUNYhPb+qga+C2woQXfUc7dfdDob98=;
        b=t1UYfM7ZOKmNqK8UbjDBhBW70bWsB9yujiIaAxYM93vHjc/Wre78z40v6cOaEMF1LE
         hUj11h2INraVv//FXPvRRG+K6r0k/0hW3b+5zlmtdVLUW7p556FizZ19PGm0hpGYA7Jw
         tIukGLIIaKG5KS1crKEz7FDFIX4pGkLK2VFHGmVvrbvsX0KU+WZTlasNdebnErRYsaku
         iY8Dr80vmmIV6o19xhK1zqiRf+sKDoj0upTxpAcxuFjuEv4nSUOi4+HqmDMwQUtL9nC5
         bI8Jt1KmrKxclDg5UZhqbUY1vM4iXgbtxBF5yTXXQGyn98YHG0rBD58ir08WtmyPqISN
         ZTkQ==
X-Gm-Message-State: AOJu0Yy2upddJQo6GAwiwY4udzS4DF8da4ZyytNuRu9OZnZEjMJcK3oj
	8RiblTApDtt2sMKmaV8ZDiRVP6OBIrMuCYTntnb8d4OW
X-Google-Smtp-Source: AGHT+IER5p4XKobGAux2V7O3DbwvUZwNDzoHCNqx/v4bJCnl64wHp/9z4gWFcsNQLXwu7K2jVP18XZcsNTK9PS+3X9s=
X-Received: by 2002:a4a:d1b0:0:b0:594:177d:8bd6 with SMTP id
 z16-20020a4ad1b0000000b00594177d8bd6mr17897825oor.1.1703871970187; Fri, 29
 Dec 2023 09:46:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223145706.26218-1-hdegoede@redhat.com>
In-Reply-To: <20231223145706.26218-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Dec 2023 18:45:58 +0100
Message-ID: <CAJZ5v0icBn6ib7sVOvYoMR2_amqFH8s4KDb0fe-iYe6s-pqvZg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: At another DMI match for the TongFang GMxXGxx
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	Luis Acuna <ldacuna@gmail.com>, Werner Sembach <wse@tuxedocomputers.com>, 
	All applicable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 3:57=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> The TongFang GMxXGxx, which needs IRQ overriding for the keyboard to work=
,
> is also sold as the Eluktronics RP-15 which does not use the standard
> TongFang GMxXGxx DMI board_name.
>
> Add an entry for this laptop to the irq1_edge_low_force_override[] DMI
> table to make the internal keyboard functional.
>
> Reported-by: Luis Acuna <ldacuna@gmail.com>
> Cc: Werner Sembach <wse@tuxedocomputers.com>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note reportedy by private email so not Closes tag
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 9bd9f79cd409..c3536c236be9 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -510,6 +510,13 @@ static const struct dmi_system_id irq1_edge_low_forc=
e_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
>                 },
>         },
> +       {
> +               /* TongFang GMxXGxx sold as Eluktronics Inc. RP-15 */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Eluktronics Inc."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "RP-15"),
> +               },
> +       },
>         {
>                 /* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
>                 .matches =3D {
> --

Applied as 6.8 material, thanks!

