Return-Path: <linux-acpi+bounces-721-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF947CDBDC
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560C71F230DD
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AAB18C05
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887911C80
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 11:01:20 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238DDB0;
	Wed, 18 Oct 2023 04:01:18 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-57de3096e25so1373547eaf.1;
        Wed, 18 Oct 2023 04:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697626877; x=1698231677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lcRiI20ZuywZkKh3K94fi7hRo3xDvC91w21Xu89tDA=;
        b=dn4rfb1Mp7uPUofEAZ5GmVb1ga56RXZNg7toM06+wYdFOMpqdZiLfFSLq8veFEL0QU
         pJCUf7C3c+N+k9OAJFZAToB/pi+T7juhyZCi8FhHkZwHWZj3lN0ffVFAlAEnjTiQg2WU
         AupPazNs81lvH5WMw0rMfiFpompFBK2V8X9pY93Trv/xl2OPs6R58uEwjttJriwaMIpX
         4msoiLWaBUe9l5mzNV/ktloR4L05TtPTCFOzPY+kog4Lylo4aCuVp6rxLyyKMeQLNMRk
         oo91/HNPJWj5Qtrs9LLklNssBswlu9Q6pg1tbs5aW3ATVWjND5//3cYKbGsQCOnaFEiO
         hzeg==
X-Gm-Message-State: AOJu0Yz7eL2Yg4W3Un9XQE+2nP4RtwHuU4YBWEO7XLB7ajKtI45Qgjni
	nntuUM1qr0IB5OLUn2R++BC8wGlivXSTMM35kt4=
X-Google-Smtp-Source: AGHT+IHKOXhEkpSOf/2bcSgi0F90xtejN4EPHb5JRiEY94jWF8NzmelIVAVzgSKoWTFssRg5klRal1SEwtMLeZzZ3qs=
X-Received: by 2002:a4a:ee94:0:b0:581:5990:dbb8 with SMTP id
 dk20-20020a4aee94000000b005815990dbb8mr4871904oob.0.1697626877296; Wed, 18
 Oct 2023 04:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231014205314.59333-1-hdegoede@redhat.com> <20231014205314.59333-3-hdegoede@redhat.com>
In-Reply-To: <20231014205314.59333-3-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Oct 2023 13:01:06 +0200
Message-ID: <CAJZ5v0i1b4wKj=1bhvtD385OSRMKzzd8bL68am4HZtgV2JtZ=A@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI: scan: Add LNXVIDEO HID to ignore_serial_bus_ids[]
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 10:53=E2=80=AFPM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> The I2C-core already has filtering to skip i2c_client instantiation for
> LNXVIDEO acpi_device-s with I2cSerialBus resources, since LNXVIDEO device=
s
> are not i2c_client-s and are handled by the acpi_video driver.
>
> This filtering was added to i2c-core-acpi.c in commit 3a4991a9864c ("i2c:
> acpi: Do not create i2c-clients for LNXVIDEO ACPI devices").
>
> Now a similar problem has shown up where the SPI-core is instantiating
> an unwanted SPI-device for a SpiSerialBus resource under a LNXVIDEO
> acpi_device. On a Lenovo Yoga Tab 3 YT3-X90F this unwanted SPI-device
> instanstantiation causes the SPI-device instanstantiation for the WM5102
> audio codec to fail with:
>
> [   21.988441] pxa2xx-spi 8086228E:00: chipselect 0 already in use
>
> Instead of duplicating the I2C-core filtering in the SPI-core code, push
> the filtering of SerialBus resources under LNXVIDEO acpi_device-s up into
> the ACPI-core by adding the LNXVIDEO HID to ignore_serial_bus_ids[].
>
> Note the filtering in the I2C-core i2c_acpi_do_lookup() function is still
> necessary because this not only impacts i2c_client instantiation but it
> also makes the I2C-core ignore the I2cSerialBus resource when checking wh=
at
> the maximum speed is the I2C bus supports, which is still necessary.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and please feel free to route it along with the rest of the series.

> ---
>  drivers/acpi/scan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 691d4b7686ee..4b6faa2350f5 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1727,6 +1727,7 @@ static bool acpi_device_enumeration_by_parent(struc=
t acpi_device *device)
>          * Some ACPI devs contain SerialBus resources even though they ar=
e not
>          * attached to a serial bus at all.
>          */
> +               {ACPI_VIDEO_HID, },
>                 {"MSHW0028", },
>         /*
>          * HIDs of device with an UartSerialBusV2 resource for which user=
space
> --
> 2.41.0
>

