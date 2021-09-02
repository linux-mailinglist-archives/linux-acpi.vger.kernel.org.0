Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3073D3FF0C4
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Sep 2021 18:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbhIBQKX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Sep 2021 12:10:23 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:36532 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbhIBQKW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Sep 2021 12:10:22 -0400
Received: by mail-ot1-f43.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso3159745otv.3;
        Thu, 02 Sep 2021 09:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9s/CeztrdJ5mW7eXs2FCAq69cl4eT4riWgVkym3DBI=;
        b=CLMjo0A8UQjvOhhCbMdg4QjTOlwTDqGrsf2xypGTJK0VNn2s3N4dn9x6zzp9FxEP3V
         1CQBsZeGe12gz0RRBwmof/tkzpNF7vTy2Ebj+FGfaaFnfPm1Ri7EA+U2zvmIHPF7R4Re
         OrMkut2lUZ2HoDS46x976cD28MDICcluhZdQ0sOLxT+up9OtdjFF/tJ2dH/iWfxBZ1bZ
         nyuSY4HMoxtpf0Las6lzKEijU0XDJkwq9iwvc7X2y+7Uzu/w/Mlve3PGtV0bXTXWL3LS
         iORz5Kr9+fc4T2SOvNE1GbR9+uwal0+NQE/sGA3vuYbzcS7mw5kwPAETrHpYyOsZhr8G
         TKFA==
X-Gm-Message-State: AOAM531GWSLFx5kFZfeFSdeqJRO2HR6crpHxAKXBK9tqQEdXXG5RR+hq
        fO7/DuDLVOX+q73bg8YP82cRVSMdtg6ivXpzqu4=
X-Google-Smtp-Source: ABdhPJzKMX1gorKDZvQ6+EZ0VUUlgn8z9GTqZRYd0mvVKwMjustuLbXhmjMBcAd0OgAzQuoTkwzcuKC+jiZkpimjCfU=
X-Received: by 2002:a9d:7115:: with SMTP id n21mr3323619otj.321.1630598963788;
 Thu, 02 Sep 2021 09:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210829132243.82281-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210829132243.82281-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Sep 2021 18:09:12 +0200
Message-ID: <CAJZ5v0iXyW3EnsjXsRCGzwkP45jjOHmErMyGhm6HvTOVCawTZA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Documentation: ACPI: Align the SSDT overlays file
 with the code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Aug 29, 2021 at 3:22 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> This updates the following:
>
> 1) The ASL code to follow latest ACPI requirements, i.e.
>    - static buffer to be defined outside of the method
>    - The _ADR and _HID shouldn't be together for the same device
>
> 2) EFI section relies on the additional kernel configuration option,
>    i.e. CONFIG_EFI_CUSTOM_SSDT_OVERLAYS
>
> 3) Refer to ACPI machine language as AML (capitalized)
>
> 4) Miscellaneous amendments
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied, thanks!

> ---
>  .../admin-guide/acpi/ssdt-overlays.rst        | 49 ++++++++++---------
>  1 file changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/admin-guide/acpi/ssdt-overlays.rst b/Documentation/admin-guide/acpi/ssdt-overlays.rst
> index 5d7e25988085..b5fbf54dca19 100644
> --- a/Documentation/admin-guide/acpi/ssdt-overlays.rst
> +++ b/Documentation/admin-guide/acpi/ssdt-overlays.rst
> @@ -30,22 +30,21 @@ following ASL code can be used::
>          {
>              Device (STAC)
>              {
> -                Name (_ADR, Zero)
>                  Name (_HID, "BMA222E")
> +                Name (RBUF, ResourceTemplate ()
> +                {
> +                    I2cSerialBus (0x0018, ControllerInitiated, 0x00061A80,
> +                                AddressingMode7Bit, "\\_SB.I2C6", 0x00,
> +                                ResourceConsumer, ,)
> +                    GpioInt (Edge, ActiveHigh, Exclusive, PullDown, 0x0000,
> +                            "\\_SB.GPO2", 0x00, ResourceConsumer, , )
> +                    { // Pin list
> +                        0
> +                    }
> +                })
>
>                  Method (_CRS, 0, Serialized)
>                  {
> -                    Name (RBUF, ResourceTemplate ()
> -                    {
> -                        I2cSerialBus (0x0018, ControllerInitiated, 0x00061A80,
> -                                    AddressingMode7Bit, "\\_SB.I2C6", 0x00,
> -                                    ResourceConsumer, ,)
> -                        GpioInt (Edge, ActiveHigh, Exclusive, PullDown, 0x0000,
> -                                "\\_SB.GPO2", 0x00, ResourceConsumer, , )
> -                        { // Pin list
> -                            0
> -                        }
> -                    })
>                      Return (RBUF)
>                  }
>              }
> @@ -75,7 +74,7 @@ This option allows loading of user defined SSDTs from initrd and it is useful
>  when the system does not support EFI or when there is not enough EFI storage.
>
>  It works in a similar way with initrd based ACPI tables override/upgrade: SSDT
> -aml code must be placed in the first, uncompressed, initrd under the
> +AML code must be placed in the first, uncompressed, initrd under the
>  "kernel/firmware/acpi" path. Multiple files can be used and this will translate
>  in loading multiple tables. Only SSDT and OEM tables are allowed. See
>  initrd_table_override.txt for more details.
> @@ -103,12 +102,14 @@ This is the preferred method, when EFI is supported on the platform, because it
>  allows a persistent, OS independent way of storing the user defined SSDTs. There
>  is also work underway to implement EFI support for loading user defined SSDTs
>  and using this method will make it easier to convert to the EFI loading
> -mechanism when that will arrive.
> +mechanism when that will arrive. To enable it, the
> +CONFIG_EFI_CUSTOM_SSDT_OVERLAYS shoyld be chosen to y.
>
> -In order to load SSDTs from an EFI variable the efivar_ssdt kernel command line
> -parameter can be used. The argument for the option is the variable name to
> -use. If there are multiple variables with the same name but with different
> -vendor GUIDs, all of them will be loaded.
> +In order to load SSDTs from an EFI variable the ``"efivar_ssdt=..."`` kernel
> +command line parameter can be used (the name has a limitation of 16 characters).
> +The argument for the option is the variable name to use. If there are multiple
> +variables with the same name but with different vendor GUIDs, all of them will
> +be loaded.
>
>  In order to store the AML code in an EFI variable the efivarfs filesystem can be
>  used. It is enabled and mounted by default in /sys/firmware/efi/efivars in all
> @@ -127,7 +128,7 @@ variable with the content from a given file::
>
>      #!/bin/sh -e
>
> -    while ! [ -z "$1" ]; do
> +    while [ -n "$1" ]; do
>              case "$1" in
>              "-f") filename="$2"; shift;;
>              "-g") guid="$2"; shift;;
> @@ -167,14 +168,14 @@ variable with the content from a given file::
>  Loading ACPI SSDTs from configfs
>  ================================
>
> -This option allows loading of user defined SSDTs from userspace via the configfs
> +This option allows loading of user defined SSDTs from user space via the configfs
>  interface. The CONFIG_ACPI_CONFIGFS option must be select and configfs must be
>  mounted. In the following examples, we assume that configfs has been mounted in
> -/config.
> +/sys/kernel/config.
>
> -New tables can be loading by creating new directories in /config/acpi/table/ and
> -writing the SSDT aml code in the aml attribute::
> +New tables can be loading by creating new directories in /sys/kernel/config/acpi/table
> +and writing the SSDT AML code in the aml attribute::
>
> -    cd /config/acpi/table
> +    cd /sys/kernel/config/acpi/table
>      mkdir my_ssdt
>      cat ~/ssdt.aml > my_ssdt/aml
> --
> 2.33.0
>
