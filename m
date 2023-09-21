Return-Path: <linux-acpi+bounces-45-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E977AA041
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 22:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A351C209BB
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 20:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B584F18C1C
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 20:35:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A0C12B96
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 19:00:37 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82BE3BE16
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 12:00:32 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57328758a72so260649eaf.1
        for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 12:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322832; x=1695927632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/WWtmcVttLgnH4sBxCRwv+MN4pmOUoblrYJ6B54t8o=;
        b=dXjp0Dyj8P80cXO8PaiVhl5IZuC9hrrhALbmfoBOELIX9W9JJ8qiBU5GfL2kAknPfQ
         jnAYBD6i9Me0YoW6vPC1biqrK1nF/qZOZVPhaiustc/mp9j/g4MDnZodK2SKJ0vKuQu2
         02CFacf5JBpHIpJn8lDmjz5fVZolrY4BVgva+cngB6Pmxu0bd6Unjd+Ve19YBP1wzxqH
         s6tr/T922UtuzHKhb2q2Zz0AjY//HbrDFCn/MAw4VDWnzHq7/5C2a03TFjccuvFNdwcC
         W0mbGKi4eK5toeOZfz78X4ArIIWlVUwGdMgspZCXO6Y9+1v39+bkG4P4hEymZvZUEMuX
         yuHw==
X-Gm-Message-State: AOJu0Yx7qkHmn8TNXzwRGdUJJsk8gJCAfbgfQDW5L1b5o6ePOYclieiR
	lfFg+fKfEV174M01WA4XQt+62HClUkPa7rENOihwldB8
X-Google-Smtp-Source: AGHT+IE1xay0JF4e194wDErMNYFopM6epRN6CegokmzVfTl6A8N8qdIlSKG6t0x11REM8f7Pnvzx3zS0rGWA8SgOoQ4=
X-Received: by 2002:a4a:d859:0:b0:57b:3b64:7ea5 with SMTP id
 g25-20020a4ad859000000b0057b3b647ea5mr5118977oov.1.1695322831841; Thu, 21 Sep
 2023 12:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920130506.8595-1-hdegoede@redhat.com>
In-Reply-To: <20230920130506.8595-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Sep 2023 21:00:20 +0200
Message-ID: <CAJZ5v0gGBO7PO==qnnt44DKEc=H_oSFPdgt1bLXeqAG7OTa1mw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 3:05=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Added GPE quirk entry for the HP Pavilion Gaming 15-dk1xxx.
> There is a quirk entry for 2 15-c..... laptops, this is
> for a new version which has 15-dk1xxx as identifier.
>
> This fixes the LID switch and rfkill and brightness hotkeys
> not working.
>
> Closes: https://github.com/systemd/systemd/issues/28942
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/ec.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 660834a49c1f..c95d0edb0be9 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1913,6 +1913,17 @@ static const struct dmi_system_id ec_dmi_table[] _=
_initconst =3D {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "HP 15-cx0041ur"),
>                 },
>         },
> +       {
> +               /*
> +                * HP Pavilion Gaming Laptop 15-dk1xxx
> +                * https://github.com/systemd/systemd/issues/28942
> +                */
> +               .callback =3D ec_honor_dsdt_gpe,
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming L=
aptop 15-dk1xxx"),
> +               },
> +       },
>         {
>                 /*
>                  * Samsung hardware
> --

Applied as 6.7 material, thanks!

