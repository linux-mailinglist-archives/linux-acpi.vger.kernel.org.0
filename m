Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31B236FB7F
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Apr 2021 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhD3Ncv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Apr 2021 09:32:51 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44953 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhD3Ncv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Apr 2021 09:32:51 -0400
Received: by mail-ot1-f45.google.com with SMTP id z25-20020a9d65d90000b02902a560806ca7so5701060oth.11;
        Fri, 30 Apr 2021 06:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLVdihhgQNggYlan5oTIeC7fztaYes5nMicbhpxCOR8=;
        b=UxPSsmBUt4FJeZBg4CdEJjap1JdyhaZkgLU1PFioZViBpXhCV3KizIzrohWPzm9p+O
         vhfq4RoXq2uMX8bUUrN9VMb+bAC3npekDQ8e+VuhIazaHhEGLrlIN6so7xKIqyEDrkT5
         go05RZpj/RxVobldzAU5drUB1y77X3GifjYswSSKKDIDMRDbtDrT5Ke6mGzInUIKu+cD
         d+hWHJe40Mbt+oOynv9XCfKRbzV2eeAh2j+ap6iJ6VWGs9B+ZbF0piruJ/ArUfwpwkQE
         IeitfltmzS7QXW+lF7KK8YSANZ/sRe//Jrp5vJJ8+nUyujR1OS4eTcgz2L7UY+1glbiH
         c30w==
X-Gm-Message-State: AOAM532IGWU79S4u8/hYHZ6HlPV0aUV7rwvQZSfsud8S+j2VP4Y2FloY
        76eBseWeR+a11oVgwUlnPED6q68U+Bg9hCi+b+8=
X-Google-Smtp-Source: ABdhPJxOdZMw5rEiLlSaYhxL1pnIqrAM4TbAWONhgWwdlJ3DHgE1RyN4x/WtZLEjCFsSO7kx5aYtHuRPapMK0N+EqQU=
X-Received: by 2002:a9d:5a7:: with SMTP id 36mr3440541otd.321.1619789522557;
 Fri, 30 Apr 2021 06:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210430124224.6383-1-wsj20369@163.com>
In-Reply-To: <20210430124224.6383-1-wsj20369@163.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Apr 2021 15:31:49 +0200
Message-ID: <CAJZ5v0jk+wYtJwqTh-RiwOxE+57BM+T-f=2jAVTjz_ZGHx0ehw@mail.gmail.com>
Subject: Re: [PATCH] Revert "ACPI: power: Turn off unused power resources unconditionally"
To:     Shujun Wang <wsj20369@163.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 30, 2021 at 2:43 PM Shujun Wang <wsj20369@163.com> wrote:
>
> This reverts commit 7e4fdeafa61f2b653fcf9678f09935e55756aed2.

OK, I'll revert that commit, thanks!

> It may cause some NVMe device probes to fail, and the system may get
> stuck when using an NVMe device as the root filesystem.
>
> In the function nvme_pci_enable(struct nvme_dev *dev), as shown below,
> readl(NVME_REG_CSTS) always returns -1 with the commit, which results in
> the probe failed.
>
>   if (readl(dev->bar + NVME_REG_CSTS) == -1) {
>         result = -ENODEV;
>         goto disable;
>   }
>
> dmesg:
>   [    1.106280] nvme 0000:04:00.0: platform quirk: setting simple suspend
>   [    1.109111] nvme nvme0: pci function 0000:04:00.0
>   [    1.113066] nvme 0000:04:00.0: enabling device (0000 -> 0002)
>   [    1.121040] nvme nvme0: Removing after probe failure status: -19
>
> lspci:
>   Non-Volatile memory controller: KIOXIA Corporation Device 0001
>
> device uevent:
>   DRIVER=nvme
>   PCI_CLASS=10802
>   PCI_ID=1E0F:0001
>   PCI_SUBSYS_ID=1E0F:0001
>   PCI_SLOT_NAME=0000:04:00.0
>   MODALIAS=pci:v00001E0Fd00000001sv00001E0Fsd00000001bc01sc08i02
>
> This patch was tested in Lenovo Thinkpad X1.
>
> Signed-off-by: Shujun Wang <wsj20369@163.com>
> ---
>  drivers/acpi/power.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 56102eaaa2da..8bf10abeb2e0 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -1004,9 +1004,18 @@ void acpi_turn_off_unused_power_resources(void)
>         mutex_lock(&power_resource_list_lock);
>
>         list_for_each_entry_reverse(resource, &acpi_power_resource_list, list_node) {
> +               int result, state;
> +
>                 mutex_lock(&resource->resource_lock);
>
> -               if (!resource->ref_count) {
> +               result = acpi_power_get_state(resource->device.handle, &state);
> +               if (result) {
> +                       mutex_unlock(&resource->resource_lock);
> +                       continue;
> +               }
> +
> +               if (state == ACPI_POWER_RESOURCE_STATE_ON
> +                   && !resource->ref_count) {
>                         dev_info(&resource->device.dev, "Turning OFF\n");
>                         __acpi_power_off(resource);
>                 }
> --
> 2.25.1
>
