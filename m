Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6213F769D31
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Jul 2023 18:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjGaQyE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Jul 2023 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjGaQyD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jul 2023 12:54:03 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D4A173E
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jul 2023 09:54:00 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4036bd4fff1so11331cf.0
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jul 2023 09:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690822439; x=1691427239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHOVL2V40gEMNYTXztrfE94YR/Gk0U1DqJKN5qos5U8=;
        b=qg3DdyfL5EIg9x/bf9wxui+UXlnU+2api9U6quT4C7zodc217UPM4LzWwxDUNjqilI
         LTc2hsYjyJXTpJNmb58svwlzol/k1EIkvpkSapQ6DsSBNi/69vYM3qEfk9eMCsPzNaUq
         hbI9vI0O0Aky8ce49iz/RsX+W2c115H2l5wzgzceO+DrVbYhtQk3oacSlIShd5psQDUW
         HxPXXomEn8YfuyJRGPIdIlqB9ECbH2hFu7nn0WZ649jK1QFU1u5bVcvpeDc7GZBHmgHQ
         QXVrhCGojGJEQ0QoFMos4rYNjvCkKo8EHNXn9hfQ79cftuIiRz8jSkrwIfYhy2qni1nj
         Ll7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690822439; x=1691427239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHOVL2V40gEMNYTXztrfE94YR/Gk0U1DqJKN5qos5U8=;
        b=N3j7RQ+FJD86ihJ8FqvPfUp1dWjh5x3ofN5SqBNe7uloHZ5p9lerl50nJRlAhKI4VY
         qSFnzRfXOAQR9joBV/9Fk5Q4QiaiWs1MTOukt/gmBG0/VB/Uxp/6RYOH6zIx410aswgf
         1nG+PKQaRUF9LTk9HwbKhZQWlQQ5cMd+m5zjWjU6/bPiHzzBWTikZwM/y6C/fXYZtUDl
         EIfMh0Se+u+EhgDcizNs0rrBJvHNG/LVvgyBe4kxuQRoheLV+wCV7L8ZwcDDSvIEuJDt
         duI5dvfvMQxmku6a9apS9UGKd6evlXgFlE61fOIwO69IRhVpR2currsDs0RPUqwmLGWp
         rDvQ==
X-Gm-Message-State: ABy/qLYqIixYDDXUmnGRnHfcRZ6vyiKDIji7DdA+CG6R8ofAFl4jGzKS
        ObOBZ6koli0CN2+qQN5XkDW0eSEItDFs337fL+lErg==
X-Google-Smtp-Source: APBJJlFMTxD2I+H2XK4Aykzv0jvvRQck1k7JnGEKHaPohGQXRhN6e0LF6l+jDQyUP2QRhDlbvVEAYy+XZvC+2mDAR7Q=
X-Received: by 2002:a05:622a:15d0:b0:3fd:ad1b:4e8a with SMTP id
 d16-20020a05622a15d000b003fdad1b4e8amr559747qty.22.1690822439046; Mon, 31 Jul
 2023 09:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230731024214.908235-1-tzungbi@kernel.org>
In-Reply-To: <20230731024214.908235-1-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 31 Jul 2023 09:53:45 -0700
Message-ID: <CABXOdTemJYufWDV7cmXoNxHRbi8dG2691289OE4u6LPaATdsOg@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: chromeos_acpi: support official HID GOOG0016
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, rafael@kernel.org,
        lenb@kernel.org, guillaume.tucker@collabora.com,
        denys.f@collabora.com, ricardo.canuelo@collabora.com,
        usama.anjum@collabora.com, chrome-platform@lists.linux.dev,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jul 30, 2023 at 7:43=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> Support official HID GOOG0016 for ChromeOS ACPI (see [1]).
>
> [1]: https://crrev.com/c/2266713
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> Changes from v2[2]:
> - Instead of replacing, appending "GOOG0016" in sysfs-driver-chromeos-acp=
i.
>
> Changes from v1[3]:
> - Preserve the PNP ID GGL0001 for backward compatible to older firmwares.
> - Modify commit title and message accordingly.
>
> [2]: https://patchwork.kernel.org/project/chrome-platform/patch/202307280=
65438.4026629-1-tzungbi@kernel.org/
> [3]: https://patchwork.kernel.org/project/chrome-platform/patch/202307280=
14256.3836298-1-tzungbi@kernel.org/
>
>  .../ABI/testing/sysfs-driver-chromeos-acpi        | 15 +++++++++++++++
>  .../firmware-guide/acpi/chromeos-acpi-device.rst  |  5 ++---
>  drivers/platform/chrome/chromeos_acpi.c           |  2 +-
>  3 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi b/Docum=
entation/ABI/testing/sysfs-driver-chromeos-acpi
> index c308926e1568..22082f9a7922 100644
> --- a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> +++ b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> @@ -1,4 +1,5 @@
>  What:          /sys/bus/platform/devices/GGL0001:*/BINF.2
> +               /sys/bus/platform/devices/GOOG0016:*/BINF.2
>  Date:          May 2022
>  KernelVersion: 5.19
>  Description:
> @@ -10,6 +11,7 @@ Description:
>                 =3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  What:          /sys/bus/platform/devices/GGL0001:*/BINF.3
> +               /sys/bus/platform/devices/GOOG0016:*/BINF.3
>  Date:          May 2022
>  KernelVersion: 5.19
>  Description:
> @@ -23,6 +25,7 @@ Description:
>                 =3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  What:          /sys/bus/platform/devices/GGL0001:*/CHSW
> +               /sys/bus/platform/devices/GOOG0016:*/CHSW
>  Date:          May 2022
>  KernelVersion: 5.19
>  Description:
> @@ -38,6 +41,7 @@ Description:
>                 =3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>  What:          /sys/bus/platform/devices/GGL0001:*/FMAP
> +               /sys/bus/platform/devices/GOOG0016:*/FMAP
>  Date:          May 2022
>  KernelVersion: 5.19
>  Description:
> @@ -45,6 +49,7 @@ Description:
>                 processor firmware flashmap.
>
>  What:          /sys/bus/platform/devices/GGL0001:*/FRID
> +               /sys/bus/platform/devices/GOOG0016:*/FRID
>  Date:          May 2022
>  KernelVersion: 5.19
>  Description:
> @@ -52,6 +57,7 @@ Description:
>                 main processor firmware.
>
>  What:          /sys/bus/platform/devices/GGL0001:*/FWID
> +               /sys/bus/platform/devices/GOOG0016:*/FWID
>  Date:          May 2022
>  KernelVersion: 5.19
>  Description:
> @@ -59,6 +65,7 @@ Description:
>                 main processor firmware.
>
>  What:          /sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.0
> +               /sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.0
>  Date:          May 2022
>  KernelVersion: 5.19
>  Description:
> @@ -73,6 +80,7 @@ Description:
>                 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
>  What:          /sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.1
> +               /sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.1
>  Date:          May 2022
>  KernelVersion: 5.19
>  Description:
> @@ -84,6 +92,7 @@ Description:
>                 =3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
>  What:          /sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.2
> +               /sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.2
>  Date:          May 2022
>  KernelVersion: 5.19
>  Description:
> @@ -91,18 +100,21 @@ Description:
>                 controller.
>
>  What:          /sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.3
> +               /sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.3
>  Date:          May 2022
>  KernelVersion: 5.19
>  Description:
>                 Returns name of the GPIO controller.
>
>  What:          /sys/bus/platform/devices/GGL0001:*/HWID
> +               /sys/bus/platform/devices/GOOG0016:*/HWID
>  Date:          May 2022
>  KernelVersion: 5.19
>  Description:
>                 Returns hardware ID for the Chromebook.
>
>  What:          /sys/bus/platform/devices/GGL0001:*/MECK
> +               /sys/bus/platform/devices/GOOG0016:*/MECK
>  Date:          May 2022
>  KernelVersion: 5.19
>  Description:
> @@ -113,6 +125,7 @@ Description:
>                 present, or if the firmware was unable to read the extend=
ed registers, this buffer size can be zero.
>
>  What:          /sys/bus/platform/devices/GGL0001:*/VBNV.0
> +               /sys/bus/platform/devices/GOOG0016:*/VBNV.0
>  Date:          May 2022
>  KernelVersion: 5.19
>  Description:
> @@ -122,6 +135,7 @@ Description:
>                 clock data).
>
>  What:          /sys/bus/platform/devices/GGL0001:*/VBNV.1
> +               /sys/bus/platform/devices/GOOG0016:*/VBNV.1
>  Date:          May 2022
>  KernelVersion: 5.19
>  Description:
> @@ -129,6 +143,7 @@ Description:
>                 storage block.
>
>  What:          /sys/bus/platform/devices/GGL0001:*/VDAT
> +               /sys/bus/platform/devices/GOOG0016:*/VDAT
>  Date:          May 2022
>  KernelVersion: 5.19
>  Description:
> diff --git a/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst b=
/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
> index f37fc90ce340..89419e116413 100644
> --- a/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
> +++ b/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
> @@ -5,9 +5,8 @@ Chrome OS ACPI Device
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  Hardware functionality specific to Chrome OS is exposed through a Chrome=
 OS ACPI device.
> -The plug and play ID of a Chrome OS ACPI device is GGL0001. GGL is a val=
id PNP ID of Google.
> -PNP ID can be used with the ACPI devices according to the guidelines. Th=
e following ACPI
> -objects are supported:
> +The plug and play ID of a Chrome OS ACPI device is GGL0001 and the hardw=
are ID is
> +GOOG0016.  The following ACPI objects are supported:
>
>  .. flat-table:: Supported ACPI Objects
>     :widths: 1 2
> diff --git a/drivers/platform/chrome/chromeos_acpi.c b/drivers/platform/c=
hrome/chromeos_acpi.c
> index 50d8a4d4352d..1cc01d893ada 100644
> --- a/drivers/platform/chrome/chromeos_acpi.c
> +++ b/drivers/platform/chrome/chromeos_acpi.c
> @@ -235,9 +235,9 @@ static int chromeos_acpi_device_probe(struct platform=
_device *pdev)
>         return 0;
>  }
>
> -/* GGL is valid PNP ID of Google. PNP ID can be used with the ACPI devic=
es. */
>  static const struct acpi_device_id chromeos_device_ids[] =3D {
>         { "GGL0001", 0 },
> +       { "GOOG0016", 0 },
>         {}
>  };
>  MODULE_DEVICE_TABLE(acpi, chromeos_device_ids);
> --
> 2.41.0.487.g6d72f3e995-goog
>
