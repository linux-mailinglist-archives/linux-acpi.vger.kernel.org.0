Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE83C8468
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 14:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhGNMaE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 08:30:04 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:34714 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhGNMaD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jul 2021 08:30:03 -0400
Received: by mail-ot1-f46.google.com with SMTP id w8-20020a0568304108b02904b3da3d49e5so2283479ott.1;
        Wed, 14 Jul 2021 05:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mhl126D+5KrvqHUg8Mnu6CpT2565vYX+nBypTu9pEdQ=;
        b=S0Gcrppcw5p0vhDObTJsA5zg014dVQf9JqlbuNmamx4hnAf67q/SWT7/1SQ3WW7VRH
         P/Lmul+lgWYArOR1dh2xl0G41upWk3fBvBa50iIDWI1hDIpu7S36seGf2egE7gAFpEos
         a/TylSwEgbNozkh7T+NOJ6i370Czp11qsjdaoq2C2kJ4zKOfg31E07IMmsKemgPtIJo8
         gTfxtyQNTPnNKV46P2fLiZIJuIV6F6k/BLIRcRjtwVJg0/KhPpRR23dXpDZnyq/u3e2G
         qQ60uBanGqnsfkMMUPYGRems4wrRW2AUf6S3wD1/LcIua1ZLWqEUvq02CEAx9vUhj8oZ
         9WUQ==
X-Gm-Message-State: AOAM5338p19e97jdKQuImkl9/jf9t5hpBR17R0oQ1Ag4S6rkS+j766EW
        H/Nfeb9DH+TNQwWmITqCQKffQuA00eEECsiVF5I=
X-Google-Smtp-Source: ABdhPJyFbDsKylVuWlvXABz7iW3sGVVm5eX1+HmtYHYKTF69l/8pIq15gHIJUzZBPfkTb2+HYbBKYrXviDCow7Axg7A=
X-Received: by 2002:a9d:5f19:: with SMTP id f25mr8376874oti.206.1626265632099;
 Wed, 14 Jul 2021 05:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210621200459.3558199-1-mw@semihalf.com>
In-Reply-To: <20210621200459.3558199-1-mw@semihalf.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Jul 2021 14:27:01 +0200
Message-ID: <CAJZ5v0jegOF85Zvo8Oyio9cSvb_WfUCG0oNsXzWHSCTi151u0A@mail.gmail.com>
Subject: Re: [net-next: PATCH v3 1/1] ACPI: SPCR: Add new 16550-compatible
 Serial Port Subtype
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>, upstream@semihalf.com,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Jon <jon@solid-run.com>, Tomasz Nowicki <tn@semihalf.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sorry for the delay.

On Mon, Jun 21, 2021 at 10:05 PM Marcin Wojtas <mw@semihalf.com> wrote:
>
> The Microsoft Debug Port Table 2 (DBG2) specification revision
> May 31, 2017 adds support for 16550-compatible Serial Port
> Subtype with parameters defined in Generic Address Structure (GAS) [1]
>
> Add its support in SPCR parsing routine.
>
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-debug-port-table
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  include/acpi/actbl1.h | 1 +
>  drivers/acpi/spcr.c   | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index ce59903c2695..f746012eba8d 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h

This is an ACPICA header, so the first part of the patch should go in
via the ACPICA upstream repository.

Can you please resend this as two patches to make it easier to process it?

> @@ -498,6 +498,7 @@ struct acpi_dbg2_device {
>  #define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
>  #define ACPI_DBG2_ARM_DCC           0x000F
>  #define ACPI_DBG2_BCM2835           0x0010
> +#define ACPI_DBG2_16550_WITH_GAS    0x0012
>
>  #define ACPI_DBG2_1394_STANDARD     0x0000
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 88460bacd5ae..25c2d0be953e 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -136,6 +136,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
>                 break;
>         case ACPI_DBG2_16550_COMPATIBLE:
>         case ACPI_DBG2_16550_SUBSET:
> +       case ACPI_DBG2_16550_WITH_GAS:
>                 uart = "uart";
>                 break;
>         default:
> --
> 2.29.0
>
