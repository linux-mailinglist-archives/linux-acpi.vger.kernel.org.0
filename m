Return-Path: <linux-acpi+bounces-2191-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8085D80796E
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 21:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4FF2821AA
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006EF4B13D
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:35:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7048311F;
	Wed,  6 Dec 2023 12:10:57 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1fb00ea5e5fso32417fac.1;
        Wed, 06 Dec 2023 12:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893457; x=1702498257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32NboKdEEry+p7HRVVx+YEW6Zjud8R5v5yW1kUM2NMU=;
        b=sKlJBRc++kmYVjtJBIMsWf2mFcme5f1AiYWDvJP0v1AzxUkBuYdwa/e/h/sZotFAil
         Blwf0bWPbZANUmLAk8tqY37x2z/COhp2R8n2elh5DTSx9yd3YgHjvHumlee9wel2fiIU
         6lpZ9ItDeFHqwZQPVT/njkNAQQSA0obiDvnx8HYT6GoEDB65UhZwLFbkR5Lkm2GyiQ/V
         +PAnONmshaUGDb4ORJPVHWl9uAIemhAjUFmkk/FGyjE/f1h+X3ZkyvPb0KhF8jDscBBW
         XNj2FwDf6qqwNPI8Opc44YDvObCzOhzBytj9kUANcwnkKHU/1L5x+FkdjTnlfAI+EnDg
         OenQ==
X-Gm-Message-State: AOJu0YxyY4WrPsFOvwgqpeoSG5T0QwHVanVw9fzTc3bWQTOd2MWg3nXs
	R5ZIiU6SgqDAv5Zj1z1NrFwNQLy0GiSxuMradeo=
X-Google-Smtp-Source: AGHT+IHPAP8AL59zyFtPtTB7eVNF84HILsRrEh/VOneuGIXezqqewr+VNupPVANN38p6QKK7bV7A6or59SU+DB3njKw=
X-Received: by 2002:a05:6870:9e84:b0:1fa:f195:e3b4 with SMTP id
 pu4-20020a0568709e8400b001faf195e3b4mr3000102oab.2.1701893456740; Wed, 06 Dec
 2023 12:10:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129084247.32443-1-liuhaoran14@163.com>
In-Reply-To: <20231129084247.32443-1-liuhaoran14@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 21:10:46 +0100
Message-ID: <CAJZ5v0goHCBcgFhphtenVKoFPyWN83Uuoo30q3E4DtEH=w4Q7A@mail.gmail.com>
Subject: Re: [PATCH] [ACPI] sbshc: Add error handling for acpi_driver_data
To: Haoran Liu <liuhaoran14@163.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 9:43=E2=80=AFAM Haoran Liu <liuhaoran14@163.com> wr=
ote:
>
> This patch enhances the acpi_smbus_hc_add and acpi_smbus_hc_remove
> functions in drivers/acpi/sbshc.c by adding error handling for the
> acpi_driver_data calls. Previously, these functions did not check
> the return value of acpi_driver_data, potentially leading to
> stability issues if the function failed and returned a null pointer.

This needs to describe a real scenario in which acpi_driver_data() can
return NULL for each of the 2 places modified by the patch.

> Signed-off-by: Haoran Liu <liuhaoran14@163.com>
> ---
>  drivers/acpi/sbshc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
> index 16f2daaa2c45..1394104d3894 100644
> --- a/drivers/acpi/sbshc.c
> +++ b/drivers/acpi/sbshc.c
> @@ -267,6 +267,12 @@ static int acpi_smbus_hc_add(struct acpi_device *dev=
ice)
>         init_waitqueue_head(&hc->wait);
>
>         hc->ec =3D acpi_driver_data(acpi_dev_parent(device));
> +       if (!hc->ec) {
> +               pr_err("Failed to retrieve parent ACPI device data\n");
> +               kfree(hc);
> +               return -ENODEV;
> +       }
> +
>         hc->offset =3D (val >> 8) & 0xff;
>         hc->query_bit =3D val & 0xff;
>         device->driver_data =3D hc;
> @@ -288,6 +294,11 @@ static void acpi_smbus_hc_remove(struct acpi_device =
*device)
>                 return;
>
>         hc =3D acpi_driver_data(device);
> +       if (!hc) {
> +               pr_err("Failed to retrieve ACPI SMBus HC data\n");
> +               return;
> +       }
> +
>         acpi_ec_remove_query_handler(hc->ec, hc->query_bit);
>         acpi_os_wait_events_complete();
>         kfree(hc);
> --
> 2.17.1
>

