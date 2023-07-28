Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AB57663D2
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jul 2023 07:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjG1F7d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Jul 2023 01:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG1F7c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Jul 2023 01:59:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEE026B2
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jul 2023 22:59:30 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.218.24])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D5185660705E;
        Fri, 28 Jul 2023 06:59:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690523969;
        bh=A6xk56bW+h1xNIqJIqhlip5HS9GqSE5Ep52qnqNmdQI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=fwuyHiMyA8o20bSicWKk3YOMSK8UF3rZ887YB27oNVGGKqGAkx4jWQr0hLtQz5fIG
         fiqt69jSDfuiIP7gP1w5F/fz+Zcv9fNHuJWi4D//4JYFff+MWfKkDEPHUx0hl68UL1
         t3WH7z8esMmCGubJXEWuCc42sFOQhJufTSHdmlo4zKwRpheJI+Bu7yRBY+hNBMRjDN
         bczJicWEfClVBhlI2sMRIcoSqbDAJOC00G2fKMYnO+yaljy5muqeNIO3VqPPn7qMv5
         a+dcalPt6keth/GuT2alr6EeR4lJr6Ilc0kai/U9vATB/OD25tVGGspsmL8CXn54b0
         ku0Kxa5RPT9zA==
Message-ID: <fb9876f1-e729-f2d3-75d8-55fdae24e3ee@collabora.com>
Date:   Fri, 28 Jul 2023 10:59:22 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        chrome-platform@lists.linux.dev, linux-acpi@vger.kernel.org,
        guillaume.tucker@collabora.com, denys.f@collabora.com,
        ricardo.canuelo@collabora.com
Subject: Re: [PATCH] platform/chrome: chromeos_acpi: use official HID GOOG0016
To:     Tzung-Bi Shih <tzungbi@kernel.org>, bleung@chromium.org,
        groeck@chromium.org, rafael@kernel.org, lenb@kernel.org
References: <20230728014256.3836298-1-tzungbi@kernel.org>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230728014256.3836298-1-tzungbi@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks for the patch.

On 7/28/23 6:42 AM, Tzung-Bi Shih wrote:
> Use official HID GOOG0016 for ChromeOS ACPI (see [1]).
> 
> [1]: https://crrev.com/c/2266713
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> AFAIK, there has no ChromeOS devices using the driver yet.  Instead, they
> still stick to some downstream implementation.  IOW, I guess we are safe
> to just replace the PNP ID.
GOOG0016 got introduced in newer firmware. Older firmware will still have
only GGL0001 id. Lets keep both IDs otherwise the updated driver will not
work on older chromebooks. This can be easily achieved by keeping both IDs
in chromeos_device_ids.

> 
>  .../ABI/testing/sysfs-driver-chromeos-acpi    | 30 +++++++++----------
>  .../acpi/chromeos-acpi-device.rst             |  5 ++--
>  drivers/platform/chrome/chromeos_acpi.c       |  3 +-
>  3 files changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> index c308926e1568..8e8a5d6610b8 100644
> --- a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> +++ b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> @@ -1,4 +1,4 @@
> -What:		/sys/bus/platform/devices/GGL0001:*/BINF.2
> +What:		/sys/bus/platform/devices/GOOG0016:*/BINF.2
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
> @@ -9,7 +9,7 @@ Description:
>  		1  Rewritable firmware.
>  		== ===============================
>  
> -What:		/sys/bus/platform/devices/GGL0001:*/BINF.3
> +What:		/sys/bus/platform/devices/GOOG0016:*/BINF.3
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
> @@ -22,7 +22,7 @@ Description:
>  		3  Netboot (factory installation only).
>  		== =====================================
>  
> -What:		/sys/bus/platform/devices/GGL0001:*/CHSW
> +What:		/sys/bus/platform/devices/GOOG0016:*/CHSW
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
> @@ -37,28 +37,28 @@ Description:
>  		512  Firmware write protection was disabled.
>  		==== ===========================================
>  
> -What:		/sys/bus/platform/devices/GGL0001:*/FMAP
> +What:		/sys/bus/platform/devices/GOOG0016:*/FMAP
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
>  		Returns physical memory address of the start of the main
>  		processor firmware flashmap.
>  
> -What:		/sys/bus/platform/devices/GGL0001:*/FRID
> +What:		/sys/bus/platform/devices/GOOG0016:*/FRID
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
>  		Returns firmware version for the read-only portion of the
>  		main processor firmware.
>  
> -What:		/sys/bus/platform/devices/GGL0001:*/FWID
> +What:		/sys/bus/platform/devices/GOOG0016:*/FWID
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
>  		Returns firmware version for the rewritable portion of the
>  		main processor firmware.
>  
> -What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.0
> +What:		/sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.0
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
> @@ -72,7 +72,7 @@ Description:
>  		256 to 511  Debug header GPIO 0 to GPIO 255.
>  		=========== ==================================
>  
> -What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.1
> +What:		/sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.1
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
> @@ -83,26 +83,26 @@ Description:
>  		1  Signal is active high.
>  		== =======================
>  
> -What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.2
> +What:		/sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.2
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
>  		Returns the GPIO number on the specified GPIO
>  		controller.
>  
> -What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.3
> +What:		/sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.3
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
>  		Returns name of the GPIO controller.
>  
> -What:		/sys/bus/platform/devices/GGL0001:*/HWID
> +What:		/sys/bus/platform/devices/GOOG0016:*/HWID
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
>  		Returns hardware ID for the Chromebook.
>  
> -What:		/sys/bus/platform/devices/GGL0001:*/MECK
> +What:		/sys/bus/platform/devices/GOOG0016:*/MECK
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
> @@ -112,7 +112,7 @@ Description:
>  		Engine firmware has not changed. If Management Engine is not
>  		present, or if the firmware was unable to read the extended registers, this buffer size can be zero.
>  
> -What:		/sys/bus/platform/devices/GGL0001:*/VBNV.0
> +What:		/sys/bus/platform/devices/GOOG0016:*/VBNV.0
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
> @@ -121,14 +121,14 @@ Description:
>  		(that is, 'offset = 0' is the byte following the 14 bytes of
>  		clock data).
>  
> -What:		/sys/bus/platform/devices/GGL0001:*/VBNV.1
> +What:		/sys/bus/platform/devices/GOOG0016:*/VBNV.1
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
>  		Return the size in bytes of the verified boot non-volatile
>  		storage block.
>  
> -What:		/sys/bus/platform/devices/GGL0001:*/VDAT
> +What:		/sys/bus/platform/devices/GOOG0016:*/VDAT
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
> diff --git a/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst b/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
> index f37fc90ce340..abb8641fd022 100644
> --- a/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
> +++ b/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
> @@ -5,9 +5,8 @@ Chrome OS ACPI Device
>  =====================
>  
>  Hardware functionality specific to Chrome OS is exposed through a Chrome OS ACPI device.
> -The plug and play ID of a Chrome OS ACPI device is GGL0001. GGL is a valid PNP ID of Google.
> -PNP ID can be used with the ACPI devices according to the guidelines. The following ACPI
> -objects are supported:
> +The hardware ID of a Chrome OS ACPI device is GOOG0016.  The following ACPI objects are
> +supported:
>  
>  .. flat-table:: Supported ACPI Objects
>     :widths: 1 2
> diff --git a/drivers/platform/chrome/chromeos_acpi.c b/drivers/platform/chrome/chromeos_acpi.c
> index 50d8a4d4352d..4dcc22c34469 100644
> --- a/drivers/platform/chrome/chromeos_acpi.c
> +++ b/drivers/platform/chrome/chromeos_acpi.c
> @@ -235,9 +235,8 @@ static int chromeos_acpi_device_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -/* GGL is valid PNP ID of Google. PNP ID can be used with the ACPI devices. */
>  static const struct acpi_device_id chromeos_device_ids[] = {
> -	{ "GGL0001", 0 },
> +	{ "GOOG0016", 0 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(acpi, chromeos_device_ids);

-- 
BR,
Muhammad Usama Anjum
