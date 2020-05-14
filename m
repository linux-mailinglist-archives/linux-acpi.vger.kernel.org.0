Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A171D2EC8
	for <lists+linux-acpi@lfdr.de>; Thu, 14 May 2020 13:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgENLvO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 May 2020 07:51:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33136 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgENLvO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2020 07:51:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id o24so24285309oic.0
        for <linux-acpi@vger.kernel.org>; Thu, 14 May 2020 04:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uphN1zqM5WK3HENHwA4U2X6UgtB7IhowXY7eUDvw28=;
        b=YDfFCMBTzfcvri5koeTJfYeCyJHq+qrqUA7or5/GSr0gt/Rm+ra0y2Fgk1vmQocid4
         CEEkxtLNEhKWN4UyA7D4Pj6QczAqcJd1IVSVbFGPoL27vp1Tdyttd0NQvXZxqKnetcR/
         9b+3kZH0EiXT/5ty2RSLRn+OLdEMczBe1KtEQh6sb2jOEvJcUnpdsGniZH0ksNcpf1ZV
         GeDonB1Qx8V6Pg8O8Ip8+qhRrL9JJD7g+m7R6E+pIo8xsqWDixhhDQ8d4XV4gbt3uI2F
         PLF01shXGXVhHXa1n3JwwWpSkvAbDq8y2uQtQYGfNu8Qfce+0UdulixRFYmchB5QBtfY
         s2Cw==
X-Gm-Message-State: AGi0Pubc8XV8hIW55Gsb/n/th7uXTT8vY0ZQY7tOCi+/zBPMc4m7fPxn
        MwXx255+B9ns7KNtWf+NV4ZkFM1VlxcEQVBmmf0=
X-Google-Smtp-Source: APiQypLPqRnfq56qZvmxRgQhGdyrbIatJgjllgPFaqomqADQ1VCP3sdWfrB3VumFwIWY6so5+wQYOM9dYzfobw6Ize8=
X-Received: by 2002:aca:4fd5:: with SMTP id d204mr9626127oib.103.1589457073766;
 Thu, 14 May 2020 04:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200510193016.100818-1-pterjan@google.com>
In-Reply-To: <20200510193016.100818-1-pterjan@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 May 2020 13:51:02 +0200
Message-ID: <CAJZ5v0iTeKwG1fLGt2rcw5eGY6Hx17d0+vD-D_EdqcPpgK5yWA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Delete unused proc filename macros
To:     Pascal Terjan <pterjan@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, May 10, 2020 at 9:30 PM Pascal Terjan <pterjan@google.com> wrote:
>
> Those were used to create files in /proc/acpi long ago
> and were missed when that code was deleted.
>
> Signed-off-by: Pascal Terjan <pterjan@google.com>
> ---
>  drivers/acpi/button.c   | 1 -
>  drivers/acpi/ec.c       | 1 -
>  drivers/acpi/pci_link.c | 2 --
>  drivers/acpi/power.c    | 2 --
>  drivers/acpi/sbs.c      | 3 ---
>  5 files changed, 9 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 78cfc70cb320..3c35e57dd854 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -24,7 +24,6 @@
>  #define PREFIX "ACPI: "
>
>  #define ACPI_BUTTON_CLASS              "button"
> -#define ACPI_BUTTON_FILE_INFO          "info"
>  #define ACPI_BUTTON_FILE_STATE         "state"
>  #define ACPI_BUTTON_TYPE_UNKNOWN       0x00
>  #define ACPI_BUTTON_NOTIFY_STATUS      0x80
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index b4c0152e92aa..8535bea2f4e3 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -34,7 +34,6 @@
>
>  #define ACPI_EC_CLASS                  "embedded_controller"
>  #define ACPI_EC_DEVICE_NAME            "Embedded Controller"
> -#define ACPI_EC_FILE_INFO              "info"
>
>  /* EC status register */
>  #define ACPI_EC_FLAG_OBF       0x01    /* Output buffer full */
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index ed3d2182cf2c..606da5d77ad3 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -31,8 +31,6 @@
>  ACPI_MODULE_NAME("pci_link");
>  #define ACPI_PCI_LINK_CLASS            "pci_irq_routing"
>  #define ACPI_PCI_LINK_DEVICE_NAME      "PCI Interrupt Link"
> -#define ACPI_PCI_LINK_FILE_INFO                "info"
> -#define ACPI_PCI_LINK_FILE_STATUS      "state"
>  #define ACPI_PCI_LINK_MAX_POSSIBLE     16
>
>  static int acpi_pci_link_add(struct acpi_device *device,
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index fe1e7bc91a5e..837b875d075e 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -36,8 +36,6 @@
>  ACPI_MODULE_NAME("power");
>  #define ACPI_POWER_CLASS               "power_resource"
>  #define ACPI_POWER_DEVICE_NAME         "Power Resource"
> -#define ACPI_POWER_FILE_INFO           "info"
> -#define ACPI_POWER_FILE_STATUS         "state"
>  #define ACPI_POWER_RESOURCE_STATE_OFF  0x00
>  #define ACPI_POWER_RESOURCE_STATE_ON   0x01
>  #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index 6e88224f60f0..f158b8c30113 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -28,9 +28,6 @@
>  #define ACPI_SBS_CLASS                 "sbs"
>  #define ACPI_AC_CLASS                  "ac_adapter"
>  #define ACPI_SBS_DEVICE_NAME           "Smart Battery System"
> -#define ACPI_SBS_FILE_INFO             "info"
> -#define ACPI_SBS_FILE_STATE            "state"
> -#define ACPI_SBS_FILE_ALARM            "alarm"
>  #define ACPI_BATTERY_DIR_NAME          "BAT%i"
>  #define ACPI_AC_DIR_NAME               "AC0"
>
> --

Applied as 5.8 material, thanks!
