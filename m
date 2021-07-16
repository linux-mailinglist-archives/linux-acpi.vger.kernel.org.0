Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E523CBB33
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 19:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhGPRdE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 13:33:04 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:40508 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhGPRdE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 13:33:04 -0400
Received: by mail-ot1-f47.google.com with SMTP id v32-20020a0568300920b02904b90fde9029so10618233ott.7;
        Fri, 16 Jul 2021 10:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCnllYXMUCczcBIwb3YxN8Rr6MFU7yF3+xfqgmoa1hY=;
        b=VQlg6aRaqM4WtFbm9ZeOUE5qF5Wd72eCFtlqY0CrPO9GGVBOqeYtz3KPVk4sr9zPHC
         T8ir/NlvgoI+/jlZHrT7AvogqvVs9EE75JN48pEmoXIZWP71AC/htWtNt58y2jkzeOUT
         h6gd+HrEZkGUZE8NekZEJjfEsEDCdJKGipliVcaq4W/Q8tayW8SvtdVNFiNRtlvnuiSU
         6B+aHH3+TUA8KNDfnueltNR7eVY8cciie24RZdj+LjnDybbNzaPoI0sTMupV5LeCjU2g
         pqs0V3V74uUb1bcXVVfejrbD5ptylBwMTe2CWXwb6XDMK+f6EOxQGsDDBa44+tf+mG2v
         gn/A==
X-Gm-Message-State: AOAM531b9Gm/2ll7rgqNjVyVgwfgnCD2hx0yvulcSyXb9QcDQISR7qxQ
        ulZz9nczN7fnu7WNRkadNKzdigIf16ozAb1xJQ31Fvc4
X-Google-Smtp-Source: ABdhPJxHpb3jOPDUJQ8YVA5GsTkwTtnlDQwZVqqTSdxENBEo8fSOQ5nl3mfdE7fs396K4M87oBejAU7/uMUIKImhJb4=
X-Received: by 2002:a05:6830:9a:: with SMTP id a26mr1888401oto.260.1626456608012;
 Fri, 16 Jul 2021 10:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <ad9c50c54887bde41ae5de782248231c06a527c0.1626262835.git.rrichter@amd.com>
In-Reply-To: <ad9c50c54887bde41ae5de782248231c06a527c0.1626262835.git.rrichter@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Jul 2021 19:29:57 +0200
Message-ID: <CAJZ5v0hczSLj56g0ho=DkS4FaMtKSutUsBmqEr080z43ueEGAA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Kconfig: Fix table override from built-in initrd
To:     Robert Richter <rrichter@amd.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 15, 2021 at 11:26 AM Robert Richter <rrichter@amd.com> wrote:
>
> During a rework of initramfs code the INITRAMFS_COMPRESSION config
> option was removed in commit 65e00e04e5ae. A leftover as a dependency
> broke the config option ACPI_TABLE_OVERRIDE_VIA_ BUILTIN_INITRD that
> is used to enable the overriding of ACPI tables from built-in initrd.
> Fixing the dependency.
>
> Fixes: 65e00e04e5ae ("initramfs: refactor the initramfs build rules")
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 9d872ea477a6..8f9940f40baa 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -370,7 +370,7 @@ config ACPI_TABLE_UPGRADE
>  config ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD
>         bool "Override ACPI tables from built-in initrd"
>         depends on ACPI_TABLE_UPGRADE
> -       depends on INITRAMFS_SOURCE!="" && INITRAMFS_COMPRESSION=""
> +       depends on INITRAMFS_SOURCE!="" && INITRAMFS_COMPRESSION_NONE
>         help
>           This option provides functionality to override arbitrary ACPI tables
>           from built-in uncompressed initrd.
> --

Applied as 5.14-rc material, thanks!
