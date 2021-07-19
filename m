Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928663CD460
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jul 2021 14:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbhGSL3b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Jul 2021 07:29:31 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:34723 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbhGSL3a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Jul 2021 07:29:30 -0400
Received: by mail-oi1-f177.google.com with SMTP id u11so20461690oiv.1
        for <linux-acpi@vger.kernel.org>; Mon, 19 Jul 2021 05:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yfde0RjlqdKu/WzvQew0iyLAZTuzu0gAVFBNgSN9E0A=;
        b=Apw3c23nme2HWEVqnKsyD2ZQetDSn7a2KRN7UFhlUX0NCf/zyocNCRqjGgSIjVouja
         0nfCASCZxF8lZhvZ+V7+2CagFd9Ql5t527IrKHVCNdUgkjm+BNQxJVzGaxzzMJjnRZDP
         QigPGpsN02kdUo/GHycgujisp71ch1ewRH5kT8aTjCWNct2zIN+zqTGE5xHb1czZgowY
         atNSvNkvQEah9Jpl5zydAlqFndUO2RPVCvrs57L6EAIm7z82mlSCh8b0vj8YbofNy3LJ
         PeI8U9l2NAsiK2PKj9wZVNZ3iEi6xHfKX2YojLL5DFYfjatNOzwcwua93eNJQAnbyFuY
         kQQA==
X-Gm-Message-State: AOAM531HR+dI/K3UCz89gsV92zPfFDu7kR7f7cWGR1bHz3Q9IcvOC4fm
        L1CvZgKrrcHPrxzOf2xt+T+xf+0nhJcvJ7FWG/I=
X-Google-Smtp-Source: ABdhPJx5O1GR70bIBl4m3GAuJCn/+HxAdq2W3bQ800RnKQ1Wp9VT526E/NZSErv36INGHpkeN8VjNMvK0KYRoB9nJXI=
X-Received: by 2002:aca:4f57:: with SMTP id d84mr17574262oib.71.1626696608384;
 Mon, 19 Jul 2021 05:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210718041138.4739-1-mario.limonciello@amd.com>
In-Reply-To: <20210718041138.4739-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Jul 2021 14:09:53 +0200
Message-ID: <CAJZ5v0iOV-E2V=XvLDmwPXpBEsywe2me58LbX2PxuJdDUCG7Qw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Add support for upcoming AMD uPEP HID AMDI007
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jul 18, 2021 at 6:11 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> AMD systems with uPEP HID AMDI007 should be using revision 2 and
> the AMD method.
>
> CC: stable@kernel.org # v5.14

Well, what do you mean?

5.14 is still under development.


> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/x86/s2idle.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 1c507804fb10..fbdbef0ab552 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -378,19 +378,25 @@ static int lps0_device_attach(struct acpi_device *adev,
>                  * AMDI0006:
>                  * - should use rev_id 0x0
>                  * - function mask = 0x3: Should use Microsoft method
> +                * AMDI0007:
> +                * - Should use rev_id 0x2
> +                * - Should only use AMD method
>                  */
>                 const char *hid = acpi_device_hid(adev);
> -               rev_id = 0;
> +               rev_id = strcmp(hid, "AMDI0007") ? 0 : 2;
>                 lps0_dsm_func_mask = validate_dsm(adev->handle,
>                                         ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
>                 lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
> -                                       ACPI_LPS0_DSM_UUID_MICROSOFT, rev_id,
> +                                       ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
>                                         &lps0_dsm_guid_microsoft);
>                 if (lps0_dsm_func_mask > 0x3 && (!strcmp(hid, "AMD0004") ||
>                                                  !strcmp(hid, "AMDI0005"))) {
>                         lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
>                         acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
>                                           ACPI_LPS0_DSM_UUID_AMD, lps0_dsm_func_mask);
> +               } else if (lps0_dsm_func_mask_microsoft > 0 && !strcmp(hid, "AMDI0007")) {
> +                       lps0_dsm_func_mask_microsoft = -EINVAL;
> +                       acpi_handle_debug(adev->handle, "_DSM Using AMD method\n");
>                 }
>         } else {
>                 rev_id = 1;
> --
> 2.25.1
>
