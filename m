Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8BB52508D
	for <lists+linux-acpi@lfdr.de>; Thu, 12 May 2022 16:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355565AbiELOtZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 May 2022 10:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354603AbiELOtY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 May 2022 10:49:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0D9246D95
        for <linux-acpi@vger.kernel.org>; Thu, 12 May 2022 07:49:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bv19so10738376ejb.6
        for <linux-acpi@vger.kernel.org>; Thu, 12 May 2022 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJ6VUZzoDkfLtMcSKZ/xAZwNEeznBOTpJcMR80gxEaE=;
        b=LRIQIHKu955VeYwToItCjxGLldJS5DLVoFa29OQIZSgbolaU8+C8xioMoIq0dhfLPk
         sgfG1GYN+qp5/NKTuAtbTrjp110Ohx2KeN5ZIs2hAXiu+0HUnaCGuCf5MBo6LvF7Xo+f
         mUXzCFo1KuV4qNubb5z9EUkF+Vlmszp2jdbfR2oSBCP0zCo0dr+yP4N1KF1FC05rFRaL
         Df3wvM21k1GNwrG3GqCW/qDERtRBrMLS9AFMQChchyCfwNlFICyMtxl6B3baBsorj+HX
         RS9OYWXiasEOdSGdNyn60FCk1YyV9hpmXClRgrbD0NZ8RZBgY99h8ZaG3M9FXbJo+Bnu
         YhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJ6VUZzoDkfLtMcSKZ/xAZwNEeznBOTpJcMR80gxEaE=;
        b=Bon22MDL6Z0gLhGw65MLPV2RZV3PmN+khfX7DtlBpAcPNx118tIQPyBzwnZDX7/PwI
         cfvV6vfV54/uh15uGRDG5tsDIiCprRAq6kTCPul570itiCmO2V3JTrKK+6PBRCdMdywV
         EnmOOLEC+siIfCcpyixXTPlNDRIw27s6bB2DJQfWIJgenh0RMxikHrza7pK6txXYg//+
         Q0oUae09W2KoVQjVfoYRY7uQc09eB1Xgx+cqIpKvXU/4vsDDtrY5Af880KO5xCQZRX29
         mGENrFOH4yKMHvSfww/EHnP4EhsoDj5TxxRxAn2pJAVofMb7dJt3vgsyo8Zxn3/Yca5h
         a67A==
X-Gm-Message-State: AOAM530xHVLF8oYz4R4PoJSYxhZVGdHFZB200uT2ic4hmm36n4Ee9rEo
        XNLuxsLsl0cqxLkOv6r2z5K5gDXRkIwBA744Vb1ZcA==
X-Google-Smtp-Source: ABdhPJw/k0tkdptYkUwJJLZnkbBu9+HvvEkq7/HRxeGED7/f+Gs7uThckD7oBZDoG4FKp5b04Jm7xIagSCmKcWlEz8c=
X-Received: by 2002:a17:907:1c06:b0:6df:b257:cbb3 with SMTP id
 nc6-20020a1709071c0600b006dfb257cbb3mr220276ejc.631.1652366959202; Thu, 12
 May 2022 07:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <YnycZaoBPF89t/qF@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <YnycZaoBPF89t/qF@debian-BULLSEYE-live-builder-AMD64>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 12 May 2022 07:49:07 -0700
Message-ID: <CABXOdTc_vJ7poJRAWLBw7hkFOsVmu9q_75qyJK-SfdF7yWstgw@mail.gmail.com>
Subject: Re: [PATCH v12] platform/chrome: Add ChromeOS ACPI device driver
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, vbendeb@chromium.org,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
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

On Wed, May 11, 2022 at 10:34 PM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> The x86 Chromebooks have the ChromeOS ACPI device. This driver attaches
> to the ChromeOS ACPI device and exports the values reported by ACPI in a
> sysfs directory. This data isn't present in ACPI tables when read
> through ACPI tools, hence a driver is needed to do it. The driver gets
> data from firmware using the ACPI component of the kernel. The ACPI values
> are presented in string form (numbers as decimal values) or binary
> blobs, and can be accessed as the contents of the appropriate read only
> files in the standard ACPI device's sysfs directory tree. This data is
> consumed by the ChromeOS user space.
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Co-developed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> Changes in v12:
> - Use one type of correct commenting style
> - Optimize parse_attr_name
> - Made code a little more readable at some places
> - Remove usage of ACPI_PTR
>
> Changes in v11:
> - Use __ATTR macro
> - Remove local variable length and return instead
>
> Changes in v10:
> - Remove COMPILE_TEST as driver depends on ACPI component which isn't
>   enabled by COMPILE_TEST itself.
> - Fix build warnings
>
> Changes in v9:
> - Changed the implementation completely
> - Move the driver to drivers/platform/chrome
> - Remove Acked-by Rafael as driver has changed
> - Corrected some typos
> - Changed the author of the module
>
> Changes in v8:
> - Change struct platform_driver name from chromeos_acpi_driver to
>   chromeos_acpi_device_driver
>
> Changes in v7:
> - Rename acpi_chromeos Kconfig option to chromeos_acpi
> - Change this acpi driver to platform driver
> - Minor cosmetic changes
>
> There were the following concerns on v4 which have been delt with in
> v5/v6:
> - Remove BINF.{0,1,4} from sysfs as they are reserved and not used
>   anymore
> - Reword the description of MECK
> - Change function name from chromeos_acpi_alloc_name() to
>   chromeos_acpi_gen_file_name()
> - Remove local variable obj in chromeos_acpi_add_method()
> - Replace usage of dev_info() to dev_dbg()
> - Improve the description of the patch
> - Add the firmware interface document which serves as primary
>   documentation and garantees that this interface will not change
> - GGL0001 is valid PNP ID of the Google. PNP ID can be used with the
>   ACPI devices. Consensus was developed on it in discussion of v4.
>
> Changes in v6:
> - Correct authorship and path email's From
> - Add changelog between v4 and v5 in detail
> - Add copywrite year 2022
> - Improve the description and add concerns from V4 which have been fixed
>
> Changes in v5:
> - Improve the description of the patch
> - Document firmware interface
> - Update sysfs interface documentation
> - Remove binf{0,1,4} as they have been deprecated
> - Update some cleanup logic in case of error
>   - Remove freeing of chromeos_acpi.root explicitely in
>     chromeos_acpi_device_remove() as it'll be automatically freed by
>     chromeos_acpi_remove_groups()
>   - If sysfs_create_groups() fails in chromeos_acpi_process_mlst(),
>     cleanup all groups
> - Cosmetic changes
>
> Changes in v4:
> https://lore.kernel.org/lkml/20200413134611.478441-1-enric.balletbo@collabora.com/t/
> - Add COMPILE_TEST to increase build coverage.
> - Add sysfs ABI documentation.
> - Rebased on top of 5.7-rc1 and solve conflicts.
> - Cc ACPI maintainers.
>
> Changes in v3:
> - Use attribute groups instead of adding files "by hand".
> - Do not use "raw" kobject to create directories.
> - Do not abuse of the platform_device interface. Remove it.
>
> Changes in v2:
> - Note that this version is a total rework, with those major changes:
> - Use lists to track dinamically allocated attributes and groups.
> - Use sysfs binary attributes to store the ACPI contents.
> - Remove all the functionalities except the one that creates the sysfs files.
> ---
>  .../ABI/testing/sysfs-driver-chromeos-acpi    | 126 ++++++
>  .../acpi/chromeos-acpi-device.rst             | 363 ++++++++++++++++++
>  Documentation/firmware-guide/acpi/index.rst   |   1 +
>  drivers/platform/chrome/Kconfig               |  11 +
>  drivers/platform/chrome/Makefile              |   1 +
>  drivers/platform/chrome/chromeos_acpi.c       | 259 +++++++++++++
>  6 files changed, 761 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-chromeos-acpi
>  create mode 100644 Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
>  create mode 100644 drivers/platform/chrome/chromeos_acpi.c
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> new file mode 100644
> index 0000000000000..5b59ef9d7b371
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> @@ -0,0 +1,126 @@
> +What:          /sys/bus/platform/devices/GGL0001:*/BINF.2
> +Date:          May 2022
> +KernelVersion: 5.19
> +Description:
> +               This file shows information about the current boot of
> +               the active EC firmware.
> +                 * 0 - Read only (recovery) firmware.
> +                 * 1 - Rewritable firmware.
> +
> +What:          /sys/bus/platform/devices/GGL0001:*/BINF.3
> +Date:          May 2022
> +KernelVersion: 5.19
> +Description:
> +               This file shows information about the current boot of
> +               the active main firmware type.
> +                 * 0 - Recovery.
> +                 * 1 - Normal.
> +                 * 2 - Developer.
> +                 * 3 - Netboot (factory installation only).
> +
> +What:          /sys/bus/platform/devices/GGL0001:*/CHSW
> +Date:          May 2022
> +KernelVersion: 5.19
> +Description:
> +               This file shows the switch position for the Chrome OS specific
> +               hardware switches.
> +                 * 0   - No changes.
> +                 * 2   - Recovery button was pressed when firmware booted.
> +                 * 4   - Recovery button was pressed when EC firmware booted.
> +                 * 32  - Developer switch was enabled when firmware booted.
> +                 * 512 - Firmware write protection was disabled when firmware
> +                         booted.
> +
> +What:          /sys/bus/platform/devices/GGL0001:*/FMAP
> +Date:          May 2022
> +KernelVersion: 5.19
> +Description:
> +               This file shows the physical memory address of the start of
> +               the main processor firmware flashmap.
> +
> +What:          /sys/bus/platform/devices/GGL0001:*/FRID
> +Date:          May 2022
> +KernelVersion: 5.19
> +Description:
> +               This file shows the firmware version for the read-only portion
> +               of the main processor firmware.
> +
> +What:          /sys/bus/platform/devices/GGL0001:*/FWID
> +Date:          May 2022
> +KernelVersion: 5.19
> +Description:
> +               This file shows the firmware version for the rewritable portion
> +               of the main processor firmware.
> +
> +What:          /sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.0
> +Date:          May 2022
> +KernelVersion: 5.19
> +Description:
> +               This file shows the type of the GPIO signal for the Chrome OS
> +               specific GPIO assignments.
> +                 * 1   - Recovery button.
> +                 * 2   - Developer mode switch.
> +                 * 3   - Firmware write protection switch.
> +                 * 256 to 511 - Debug header GPIO 0 to GPIO 255.
> +
> +What:          /sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.1
> +Date:          May 2022
> +KernelVersion: 5.19
> +Description:
> +               This file shows the signal attributes of the GPIO signal.
> +                 * 0 - Signal is active low.
> +                 * 1 - Signal is active high.
> +
> +What:          /sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.2
> +Date:          May 2022
> +KernelVersion: 5.19
> +Description:
> +               This file shows the GPIO number on the specified GPIO
> +               controller.
> +
> +What:          /sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.3
> +Date:          May 2022
> +KernelVersion: 5.19
> +Description:
> +               This file shows the name of the GPIO controller.
> +
> +What:          /sys/bus/platform/devices/GGL0001:*/HWID
> +Date:          May 2022
> +KernelVersion: 5.19
> +Description:
> +               This file shows the hardware ID for the Chromebook.
> +
> +What:          /sys/bus/platform/devices/GGL0001:*/MECK
> +Date:          May 2022
> +KernelVersion: 5.19
> +Description:
> +               This binary file returns the SHA-1 or SHA-256 hash that is
> +               read out of the Management Engine extended registers during
> +               boot. The hash is exported vi ACPI so the OS can verify that
> +               the Management Engine firmware has not changed. If Management
> +               Engine is not present, or if the firmware was unable to read the
> +               extended registers, this buffer size can be zero.
> +
> +What:          /sys/bus/platform/devices/GGL0001:*/VBNV.0
> +Date:          May 2022
> +KernelVersion: 5.19
> +Description:
> +               This file shows the offset in CMOS bank 0 of the verified boot
> +               non-volatile storage block, counting from the first writable
> +               CMOS byte (that is, 'offset = 0' is the byte following the 14
> +               bytes of clock data).
> +
> +What:          /sys/bus/platform/devices/GGL0001:*/VBNV.1
> +Date:          May 2022
> +KernelVersion: 5.19
> +Description:
> +               This file shows the size in bytes of the verified boot
> +               non-volatile storage block.
> +
> +What:          /sys/bus/platform/devices/GGL0001:*/VDAT
> +Date:          May 2022
> +KernelVersion: 5.19
> +Description:
> +               This binary file returns the verified boot data block shared
> +               between the firmware verification step and the kernel
> +               verification step.
> diff --git a/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst b/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
> new file mode 100644
> index 0000000000000..f37fc90ce340e
> --- /dev/null
> +++ b/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
> @@ -0,0 +1,363 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Chrome OS ACPI Device
> +=====================
> +
> +Hardware functionality specific to Chrome OS is exposed through a Chrome OS ACPI device.
> +The plug and play ID of a Chrome OS ACPI device is GGL0001. GGL is a valid PNP ID of Google.
> +PNP ID can be used with the ACPI devices according to the guidelines. The following ACPI
> +objects are supported:
> +
> +.. flat-table:: Supported ACPI Objects
> +   :widths: 1 2
> +   :header-rows: 1
> +
> +   * - Object
> +     - Description
> +
> +   * - CHSW
> +     - Chrome OS switch positions
> +
> +   * - HWID
> +     - Chrome OS hardware ID
> +
> +   * - FWID
> +     - Chrome OS firmware version
> +
> +   * - FRID
> +     - Chrome OS read-only firmware version
> +
> +   * - BINF
> +     - Chrome OS boot information
> +
> +   * - GPIO
> +     - Chrome OS GPIO assignments
> +
> +   * - VBNV
> +     - Chrome OS NVRAM locations
> +
> +   * - VDTA
> +     - Chrome OS verified boot data
> +
> +   * - FMAP
> +     - Chrome OS flashmap base address
> +
> +   * - MLST
> +     - Chrome OS method list
> +
> +CHSW (Chrome OS switch positions)
> +=================================
> +This control method returns the switch positions for Chrome OS specific hardware switches.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +An integer containing the switch positions as bitfields:
> +
> +.. flat-table::
> +   :widths: 1 2
> +
> +   * - 0x00000002
> +     - Recovery button was pressed when x86 firmware booted.
> +
> +   * - 0x00000004
> +     - Recovery button was pressed when EC firmware booted. (required if EC EEPROM is
> +       rewritable; otherwise optional)
> +
> +   * - 0x00000020
> +     - Developer switch was enabled when x86 firmware booted.
> +
> +   * - 0x00000200
> +     - Firmware write protection was disabled when x86 firmware booted. (required if
> +       firmware write protection is controlled through x86 BIOS; otherwise optional)
> +
> +All other bits are reserved and should be set to 0.
> +
> +HWID (Chrome OS hardware ID)
> +============================
> +This control method returns the hardware ID for the Chromebook.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +A null-terminated ASCII string containing the hardware ID from the Model-Specific Data area of
> +EEPROM.
> +
> +Note that the hardware ID can be up to 256 characters long, including the terminating null.
> +
> +FWID (Chrome OS firmware version)
> +=================================
> +This control method returns the firmware version for the rewritable portion of the main
> +processor firmware.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +A null-terminated ASCII string containing the complete firmware version for the rewritable
> +portion of the main processor firmware.
> +
> +FRID (Chrome OS read-only firmware version)
> +===========================================
> +This control method returns the firmware version for the read-only portion of the main
> +processor firmware.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +A null-terminated ASCII string containing the complete firmware version for the read-only
> +(bootstrap + recovery ) portion of the main processor firmware.
> +
> +BINF (Chrome OS boot information)
> +=================================
> +This control method returns information about the current boot.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +
> +.. code-block::
> +
> +   Package {
> +           Reserved1
> +           Reserved2
> +           Active EC Firmware
> +           Active Main Firmware Type
> +           Reserved5
> +   }
> +
> +.. flat-table::
> +   :widths: 1 1 2
> +   :header-rows: 1
> +
> +   * - Field
> +     - Format
> +     - Description
> +
> +   * - Reserved1
> +     - DWORD
> +     - Set to 256 (0x100). This indicates this field is no longer used.
> +
> +   * - Reserved2
> +     - DWORD
> +     - Set to 256 (0x100). This indicates this field is no longer used.
> +
> +   * - Active EC firmware
> +     - DWORD
> +     - The EC firmware which was used during boot.
> +
> +       - 0 - Read-only (recovery) firmware
> +       - 1 - Rewritable firmware.
> +
> +       Set to 0 if EC firmware is always read-only.
> +
> +   * - Active Main Firmware Type
> +     - DWORD
> +     - The main firmware type which was used during boot.
> +
> +       - 0 - Recovery
> +       - 1 - Normal
> +       - 2 - Developer
> +       - 3 - netboot (factory installation only)
> +
> +       Other values are reserved.
> +
> +   * - Reserved5
> +     - DWORD
> +     - Set to 256 (0x100). This indicates this field is no longer used.
> +
> +GPIO (Chrome OS GPIO assignments)
> +=================================
> +This control method returns information about Chrome OS specific GPIO assignments for
> +Chrome OS hardware, so the kernel can directly control that hardware.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +.. code-block::
> +
> +        Package {
> +                Package {
> +                        // First GPIO assignment
> +                        Signal Type        //DWORD
> +                        Attributes         //DWORD
> +                        Controller Offset  //DWORD
> +                        Controller Name    //ASCIIZ
> +                },
> +                ...
> +                Package {
> +                        // Last GPIO assignment
> +                        Signal Type        //DWORD
> +                        Attributes         //DWORD
> +                        Controller Offset  //DWORD
> +                        Controller Name    //ASCIIZ
> +                }
> +        }
> +
> +Where ASCIIZ means a null-terminated ASCII string.
> +
> +.. flat-table::
> +   :widths: 1 1 2
> +   :header-rows: 1
> +
> +   * - Field
> +     - Format
> +     - Description
> +
> +   * - Signal Type
> +     - DWORD
> +     - Type of GPIO signal
> +
> +       - 0x00000001 - Recovery button
> +       - 0x00000002 - Developer mode switch
> +       - 0x00000003 - Firmware write protection switch
> +       - 0x00000100 - Debug header GPIO 0
> +       - ...
> +       - 0x000001FF - Debug header GPIO 255
> +
> +       Other values are reserved.
> +
> +   * - Attributes
> +     - DWORD
> +     - Signal attributes as bitfields:
> +
> +       - 0x00000001 - Signal is active-high (for button, a GPIO value
> +         of 1 means the button is pressed; for switches, a GPIO value
> +         of 1 means the switch is enabled). If this bit is 0, the signal
> +         is active low. Set to 0 for debug header GPIOs.
> +
> +   * - Controller Offset
> +     - DWORD
> +     - GPIO number on the specified controller.
> +
> +   * - Controller Name
> +     - ASCIIZ
> +     - Name of the controller for the GPIO.
> +       Currently supported names:
> +       "NM10" - Intel NM10 chip
> +
> +VBNV (Chrome OS NVRAM locations)
> +================================
> +This control method returns information about the NVRAM (CMOS) locations used to
> +communicate with the BIOS.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +.. code-block::
> +
> +        Package {
> +                NV Storage Block Offset  //DWORD
> +                NV Storage Block Size    //DWORD
> +        }
> +
> +.. flat-table::
> +   :widths: 1 1 2
> +   :header-rows: 1
> +
> +   * - Field
> +     - Format
> +     - Description
> +
> +   * - NV Storage Block Offset
> +     - DWORD
> +     - Offset in CMOS bank 0 of the verified boot non-volatile storage block, counting from
> +       the first writable CMOS byte (that is, offset=0 is the byte following the 14 bytes of
> +       clock data).
> +
> +   * - NV Storage Block Size
> +     - DWORD
> +     - Size in bytes of the verified boot non-volatile storage block.
> +
> +FMAP (Chrome OS flashmap address)
> +=================================
> +This control method returns the physical memory address of the start of the main processor
> +firmware flashmap.
> +
> +Arguments:
> +----------
> +None
> +
> +NoneResult code:
> +----------------
> +A DWORD containing the physical memory address of the start of the main processor firmware
> +flashmap.
> +
> +VDTA (Chrome OS verified boot data)
> +===================================
> +This control method returns the verified boot data block shared between the firmware
> +verification step and the kernel verification step.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +A buffer containing the verified boot data block.
> +
> +MECK (Management Engine Checksum)
> +=================================
> +This control method returns the SHA-1 or SHA-256 hash that is read out of the Management
> +Engine extended registers during boot. The hash is exported via ACPI so the OS can verify that
> +the ME firmware has not changed. If Management Engine is not present, or if the firmware was
> +unable to read the extended registers, this buffer can be zero.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +A buffer containing the ME hash.
> +
> +MLST (Chrome OS method list)
> +============================
> +This control method returns a list of the other control methods supported by the Chrome OS
> +hardware device.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +A package containing a list of null-terminated ASCII strings, one for each control method
> +supported by the Chrome OS hardware device, not including the MLST method itself.
> +For this version of the specification, the result is:
> +
> +.. code-block::
> +
> +        Package {
> +                "CHSW",
> +                "FWID",
> +                "HWID",
> +                "FRID",
> +                "BINF",
> +                "GPIO",
> +                "VBNV",
> +                "FMAP",
> +                "VDTA",
> +                "MECK"
> +        }
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index b053b0c3d6969..b6a42f4ffe032 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -29,3 +29,4 @@ ACPI Support
>     non-d0-probe
>     extcon-intel-int3496
>     intel-pmc-mux
> +   chromeos-acpi-device
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 75e93efd669f0..717299cbccac6 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -15,6 +15,17 @@ menuconfig CHROME_PLATFORMS
>
>  if CHROME_PLATFORMS
>
> +config CHROMEOS_ACPI
> +       tristate "ChromeOS specific ACPI extensions"
> +       depends on ACPI
> +       help
> +         This driver provides the firmware interface for the services
> +         exported through the ChromeOS interfaces when using ChromeOS
> +         ACPI firmware.
> +
> +         If you have an ACPI-compatible Chromebook, say Y or M here.
> +         The module will be called chromeos_acpi.
> +
>  config CHROMEOS_LAPTOP
>         tristate "Chrome OS Laptop"
>         depends on I2C && DMI && X86
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 6420ca129548e..52f5a2dde8b81 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -4,6 +4,7 @@
>  CFLAGS_cros_ec_trace.o:=               -I$(src)
>  CFLAGS_cros_ec_sensorhub_ring.o:=      -I$(src)
>
> +obj-$(CONFIG_CHROMEOS_ACPI)            += chromeos_acpi.o
>  obj-$(CONFIG_CHROMEOS_LAPTOP)          += chromeos_laptop.o
>  obj-$(CONFIG_CHROMEOS_PRIVACY_SCREEN)  += chromeos_privacy_screen.o
>  obj-$(CONFIG_CHROMEOS_PSTORE)          += chromeos_pstore.o
> diff --git a/drivers/platform/chrome/chromeos_acpi.c b/drivers/platform/chrome/chromeos_acpi.c
> new file mode 100644
> index 0000000000000..0434e15569046
> --- /dev/null
> +++ b/drivers/platform/chrome/chromeos_acpi.c
> @@ -0,0 +1,259 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ChromeOS specific ACPI extensions
> + *
> + * Copyright 2022 Google LLC
> + *
> + * This driver attaches to the ChromeOS ACPI device and then exports the
> + * values reported by the ACPI in a sysfs directory. All values are
> + * presented in the string form (numbers as decimal values) and can be
> + * accessed as the contents of the appropriate read only files in the
> + * sysfs directory tree.
> + */
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +
> +#define ACPI_ATTR_NAME_LEN 4
> +
> +#define DEV_ATTR(_var, _name)                                  \
> +       static struct device_attribute dev_attr_##_var =        \
> +               __ATTR(_name, 0444, chromeos_first_level_attr_show, NULL);
> +
> +#define GPIO_ATTR_GROUP(_group, _name, _num)                                           \
> +       static umode_t attr_is_visible_gpio_##_num(struct kobject *kobj,                \
> +                                                  struct attribute *attr, int n)       \
> +       {                                                                               \
> +               if (_num < chromeos_acpi_gpio_groups)                                   \
> +                       return attr->mode;                                              \
> +               return 0;                                                               \
> +       }                                                                               \
> +       static ssize_t chromeos_attr_show_gpio_##_num(struct device *dev,               \
> +                                                     struct device_attribute *attr,    \
> +                                                     char *buf)                        \
> +       {                                                                               \
> +               char name[ACPI_ATTR_NAME_LEN + 1];                                      \
> +               int ret, num;                                                           \
> +                                                                                       \
> +               ret = parse_attr_name(attr->attr.name, name, &num);                     \
> +               if (ret)                                                                \
> +                       return ret;                                                     \
> +               ret = chromeos_acpi_evaluate_method(dev, _num, num, name, buf);         \
> +               return ret;                                                             \
> +       }                                                                               \
> +       static struct device_attribute dev_attr_0_##_group =                            \
> +               __ATTR(GPIO.0, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
> +       static struct device_attribute dev_attr_1_##_group =                            \
> +               __ATTR(GPIO.1, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
> +       static struct device_attribute dev_attr_2_##_group =                            \
> +               __ATTR(GPIO.2, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
> +       static struct device_attribute dev_attr_3_##_group =                            \
> +               __ATTR(GPIO.3, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
> +                                                                                       \
> +       static struct attribute *attrs_##_group[] = {                                   \
> +               &dev_attr_0_##_group.attr,                                              \
> +               &dev_attr_1_##_group.attr,                                              \
> +               &dev_attr_2_##_group.attr,                                              \
> +               &dev_attr_3_##_group.attr,                                              \
> +               NULL                                                                    \
> +       };                                                                              \
> +       static const struct attribute_group attr_group_##_group = {                     \
> +               .name = _name,                                                          \
> +               .is_visible = attr_is_visible_gpio_##_num,                              \
> +               .attrs = attrs_##_group,                                                \
> +       };
> +
> +static unsigned int chromeos_acpi_gpio_groups;
> +
> +/* Parse the ACPI package and return the data related to that attribute */
> +static int chromeos_acpi_handle_package(struct device *dev, union acpi_object *obj,
> +                                       int pkg_num, int sub_pkg_num, char *name, char *buf)
> +{
> +       union acpi_object *element = obj->package.elements;
> +
> +       if (pkg_num >= obj->package.count)
> +               return -EINVAL;
> +       element += pkg_num;
> +
> +       if (element->type == ACPI_TYPE_PACKAGE) {
> +               if (sub_pkg_num >= element->package.count)
> +                       return -EINVAL;
> +               /* select sub element inside this package */
> +               element = element->package.elements;
> +               element += sub_pkg_num;
> +       }
> +
> +       switch (element->type) {
> +       case ACPI_TYPE_INTEGER:
> +               return sysfs_emit(buf, "%d\n", (int)element->integer.value);
> +       case ACPI_TYPE_STRING:
> +               return sysfs_emit(buf, "%s\n", element->string.pointer);
> +       case ACPI_TYPE_BUFFER:
> +               return sysfs_emit(buf, "%s\n", element->buffer.pointer);
> +       default:
> +               dev_err(dev, "element type %d not supported\n", element->type);
> +               return -EINVAL;
> +       }
> +}
> +
> +static int chromeos_acpi_evaluate_method(struct device *dev, int pkg_num, int sub_pkg_num,
> +                                        char *name, char *buf)
> +{
> +       struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +       acpi_status status;
> +       int ret = -EINVAL;
> +
> +       status = acpi_evaluate_object(ACPI_HANDLE(dev), name, NULL, &output);
> +       if (ACPI_FAILURE(status)) {
> +               dev_err(dev, "failed to retrieve %s. %s\n", name, acpi_format_exception(status));
> +               return ret;
> +       }
> +
> +       if (((union acpi_object *)output.pointer)->type == ACPI_TYPE_PACKAGE)
> +               ret = chromeos_acpi_handle_package(dev, output.pointer, pkg_num, sub_pkg_num,
> +                                                  name, buf);
> +
> +       kfree(output.pointer);
> +       return ret;
> +}
> +
> +static int parse_attr_name(const char *name, char *attr_name, int *attr_num)
> +{
> +       int ret;
> +
> +       ret = strscpy(attr_name, name, ACPI_ATTR_NAME_LEN + 1);
> +       if (ret == -E2BIG)
> +               return kstrtoint(&name[ACPI_ATTR_NAME_LEN + 1], 0, attr_num);
> +       return 0;
> +}
> +
> +static ssize_t chromeos_first_level_attr_show(struct device *dev, struct device_attribute *attr,
> +                                             char *buf)
> +{
> +       char attr_name[ACPI_ATTR_NAME_LEN + 1];
> +       int ret, attr_num = 0;
> +
> +       ret = parse_attr_name(attr->attr.name, attr_name, &attr_num);
> +       if (ret)
> +               return 0;
> +       ret = chromeos_acpi_evaluate_method(dev, attr_num, 0, attr_name, buf);
> +       return ret;
> +}
> +
> +static unsigned int get_gpio_pkg_num(struct device *dev)
> +{
> +       struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +       union acpi_object *obj;
> +       acpi_status status;
> +       unsigned int count = 0;
> +       char *name = "GPIO";
> +
> +       status = acpi_evaluate_object(ACPI_HANDLE(dev), name, NULL, &output);
> +       if (ACPI_FAILURE(status)) {
> +               dev_err(dev, "failed to retrieve %s. %s\n", name, acpi_format_exception(status));
> +               return count;
> +       }
> +
> +       obj = output.pointer;
> +
> +       if (obj->type == ACPI_TYPE_PACKAGE)
> +               count = obj->package.count;
> +
> +       kfree(output.pointer);
> +       return count;
> +}
> +
> +DEV_ATTR(binf2, BINF.2)
> +DEV_ATTR(binf3, BINF.3)
> +DEV_ATTR(chsw, CHSW)
> +DEV_ATTR(fmap, FMAP)
> +DEV_ATTR(frid, FRID)
> +DEV_ATTR(fwid, FWID)
> +DEV_ATTR(hwid, HWID)
> +DEV_ATTR(meck, MECK)
> +DEV_ATTR(vbnv0, VBNV.0)
> +DEV_ATTR(vbnv1, VBNV.1)
> +DEV_ATTR(vdat, VDAT)
> +
> +static struct attribute *first_level_attrs[] = {
> +       &dev_attr_binf2.attr,
> +       &dev_attr_binf3.attr,
> +       &dev_attr_chsw.attr,
> +       &dev_attr_fmap.attr,
> +       &dev_attr_frid.attr,
> +       &dev_attr_fwid.attr,
> +       &dev_attr_hwid.attr,
> +       &dev_attr_meck.attr,
> +       &dev_attr_vbnv0.attr,
> +       &dev_attr_vbnv1.attr,
> +       &dev_attr_vdat.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group first_level_attr_group = {
> +       .attrs = first_level_attrs,
> +};
> +
> +/*
> + * Every platform can have a different number of GPIO attribute groups.
> + * Define upper limit groups. At run time, the platform decides to show
> + * the present number of groups only, others are hidden.
> + */
> +GPIO_ATTR_GROUP(gpio0, "GPIO.0", 0)
> +GPIO_ATTR_GROUP(gpio1, "GPIO.1", 1)
> +GPIO_ATTR_GROUP(gpio2, "GPIO.2", 2)
> +GPIO_ATTR_GROUP(gpio3, "GPIO.3", 3)
> +GPIO_ATTR_GROUP(gpio4, "GPIO.4", 4)
> +GPIO_ATTR_GROUP(gpio5, "GPIO.5", 5)
> +GPIO_ATTR_GROUP(gpio6, "GPIO.6", 6)
> +GPIO_ATTR_GROUP(gpio7, "GPIO.7", 7)
> +
> +static const struct attribute_group *chromeos_acpi_all_groups[] = {
> +       &first_level_attr_group,
> +       &attr_group_gpio0,
> +       &attr_group_gpio1,
> +       &attr_group_gpio2,
> +       &attr_group_gpio3,
> +       &attr_group_gpio4,
> +       &attr_group_gpio5,
> +       &attr_group_gpio6,
> +       &attr_group_gpio7,
> +       NULL
> +};
> +
> +static int chromeos_acpi_device_probe(struct platform_device *pdev)
> +{
> +       chromeos_acpi_gpio_groups = get_gpio_pkg_num(&pdev->dev);
> +
> +       /*
> +        * If the platform has more GPIO attribute groups than the number of
> +        * groups this driver supports, give out a warning message.
> +        */
> +       if (chromeos_acpi_gpio_groups > ARRAY_SIZE(chromeos_acpi_all_groups) - 2)
> +               dev_warn(&pdev->dev, "Only %zu GPIO attr groups supported by the driver out of total %u.\n",
> +                        ARRAY_SIZE(chromeos_acpi_all_groups) - 2, chromeos_acpi_gpio_groups);
> +       return 0;
> +}
> +
> +/* GGL is valid PNP ID of Google. PNP ID can be used with the ACPI devices. */
> +static const struct acpi_device_id chromeos_device_ids[] = {
> +       { "GGL0001", 0 },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, chromeos_device_ids);
> +
> +static struct platform_driver chromeos_acpi_device_driver = {
> +       .probe = chromeos_acpi_device_probe,
> +       .driver = {
> +               .name = KBUILD_MODNAME,
> +               .dev_groups = chromeos_acpi_all_groups,
> +               .acpi_match_table = chromeos_device_ids,
> +       }
> +};
> +module_platform_driver(chromeos_acpi_device_driver);
> +
> +MODULE_AUTHOR("Muhammad Usama Anjum <usama.anjum@collabora.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ChromeOS specific ACPI extensions");
> --
> 2.30.2
>
