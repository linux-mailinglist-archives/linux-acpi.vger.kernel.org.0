Return-Path: <linux-acpi+bounces-17358-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 847BCBA3E15
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 15:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E7E189AB72
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 13:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646492EF673;
	Fri, 26 Sep 2025 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANXHW3ct"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0A72750F3
	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893175; cv=none; b=Zp6vYOi5u+PASmXW1jBPor3m5Vh0k2GjdLmhrSBYNZ5g9SF5gCr53f0lb6KnuiqvTTnMsFpRoUprRZdmNezV6nNXLni0nt0vDQyyAUUb7g2HvWi16CFu99Avj0PHTzddN1xuTC1P6YKyEuPlh+lgENosppF88a3omY3OJ950cAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893175; c=relaxed/simple;
	bh=RtXPjsjkrsab9AzdPVjUAFvhF8lfBADbbM1lZm7ePns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhvTxcA2Pm0jYn4j4stZENzJ4hC5t7VO1d7+tMRCzsm9gkZk0ct9yHAn5u8CynHnByP/6LGUmzHg3d0htFM31MUQhLdZKpJ/T3N4aMMUaaEH5pPDwiDkKH7QjgcsVEGXDtg9KWajTAegkORfIciEF1njeR/Xq7Rj+V+VMBFvkoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANXHW3ct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7370C113D0
	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 13:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758893174;
	bh=RtXPjsjkrsab9AzdPVjUAFvhF8lfBADbbM1lZm7ePns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ANXHW3ct9bxrXIKCtWEZDVkfQ+bMAIojKZO99QloqiWj02hJLb3mqoH7YkyuHE2z0
	 ot+P499X4kpKDBaPnRMiiOpV/adloWVaCZTWIdBnl02MfpaEpcl9h6akPZaHHjpZoW
	 f2TLp1fgz1smZDjvqIbr92nyyghueIfscWLAFzl40m2yzoQkLBFBOofUdkvf6JD5nF
	 e6JPS/ySjgJq3UQoipIOY/85TE8xBdPjD/ipPzGrD9oAORfXj+NxYeGpqlGcQxAIA9
	 vniHLxDF215MpTrHXShdMvS5ObELGbxQuJ/54uqjzxYFesatUcDB1vmwOFZYVv9kbN
	 HlAs9IiV82xDg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-31d6b8be249so2102881fac.0
        for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 06:26:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUC2Ncn+4Xb5hb2vbkwWit8MEz7MUaQvvlOfx1ZdjLKIfaih8sDTMngyU3T9y5E2cum+941bUHEAAt/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+iIc/P4GMBaNo7DG55gkhaKXAW8jmb7QhcMah+CXUqOHdqgc3
	530hDgkQfjdcsPiDQwVnY7pouRTKcPdakOd91tEiQPJtShhuZO6Oawq+oQ2Unb94nos3cB2yzoY
	+9wDrWVaeBoPOAghzQaWlpSEo7rRmPJA=
X-Google-Smtp-Source: AGHT+IEAPK2bkLAJrqItJrUnz3u7H4h7WLpVc/QAmqqZi2roEZiZ2R8aR50xvhgG6xSTlBvthyD74alKb7Prh5eyrzs=
X-Received: by 2002:a05:6870:c1c8:b0:341:d42e:6b42 with SMTP id
 586e51a60fabf-35eef026582mr3949561fac.38.1758893174218; Fri, 26 Sep 2025
 06:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org> <20250926-uvc-orientation-v3-4-6dc2fa5b4220@chromium.org>
In-Reply-To: <20250926-uvc-orientation-v3-4-6dc2fa5b4220@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Sep 2025 15:26:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hz+mkr5WT7TSzL_n7YoOkMmJh0oe5Hz1U2Ggf22NibEQ@mail.gmail.com>
X-Gm-Features: AS18NWAQwaDtnuOl4gR2HFE-6ZWt0LS5S0cYFageANOj7ELddWPtez7e8-mpMWQ
Message-ID: <CAJZ5v0hz+mkr5WT7TSzL_n7YoOkMmJh0oe5Hz1U2Ggf22NibEQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] ACPI: mipi-disco-img: Do not duplicate rotation
 info into swnodes
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans de Goede <hansg@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Hans Verkuil <hverkuil@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 3:11=E2=80=AFPM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> The function v4l2_fwnode_device_parse() is now capable of parsing the
> _PLD method, there is no need to duplicate the rotation information in a
> swnode.
>
> Reviewed-by: Hans de Goede <hansg@kernel.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

and please route this along with the rest of the series.

Thanks!

> ---
>  drivers/acpi/mipi-disco-img.c | 15 ---------------
>  include/acpi/acpi_bus.h       |  1 -
>  2 files changed, 16 deletions(-)
>
> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.=
c
> index 5b85989f96beeb726f59ac9e12e965a215fb38f6..b58b5ba22a47a4afc52129980=
74d322f0b7586dc 100644
> --- a/drivers/acpi/mipi-disco-img.c
> +++ b/drivers/acpi/mipi-disco-img.c
> @@ -617,21 +617,6 @@ static void init_crs_csi2_swnodes(struct crs_csi2 *c=
si2)
>
>         adev_fwnode =3D acpi_fwnode_handle(adev);
>
> -       /*
> -        * If the "rotation" property is not present, but _PLD is there,
> -        * evaluate it to get the "rotation" value.
> -        */
> -       if (!fwnode_property_present(adev_fwnode, "rotation")) {
> -               struct acpi_pld_info *pld;
> -
> -               if (acpi_get_physical_device_location(handle, &pld)) {
> -                       swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_=
ROTATION)] =3D
> -                                       PROPERTY_ENTRY_U32("rotation",
> -                                                          pld->rotation =
* 45U);
> -                       kfree(pld);
> -               }
> -       }
> -
>         if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-clock-freque=
ncy", &val))
>                 swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_CLOCK_FR=
EQUENCY)] =3D
>                         PROPERTY_ENTRY_U32("clock-frequency", val);
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index aad1a95e6863d443a45985ba7ec7be4acf8664fe..296716875a3e7977abb7b7dfa=
89f78664aebd61c 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -389,7 +389,6 @@ struct acpi_gpio_mapping;
>  #define ACPI_DEVICE_SWNODE_PORT_NAME_LENGTH    8
>
>  enum acpi_device_swnode_dev_props {
> -       ACPI_DEVICE_SWNODE_DEV_ROTATION,
>         ACPI_DEVICE_SWNODE_DEV_CLOCK_FREQUENCY,
>         ACPI_DEVICE_SWNODE_DEV_LED_MAX_MICROAMP,
>         ACPI_DEVICE_SWNODE_DEV_FLASH_MAX_MICROAMP,
>
> --
> 2.51.0.536.g15c5d4f767-goog
>

