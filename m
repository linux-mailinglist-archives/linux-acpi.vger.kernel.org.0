Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88CD1E48E8
	for <lists+linux-acpi@lfdr.de>; Wed, 27 May 2020 17:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388041AbgE0P5P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 May 2020 11:57:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44797 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbgE0P5O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2020 11:57:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id f18so19529384otq.11;
        Wed, 27 May 2020 08:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHXnsm9FgPRIvAJXm9vXdaP6dHYEAo0qih1OcX3Oy5Q=;
        b=tlcJYixA4V6MbXZbgQdShQ7bSJiIhPUh+kuq0hftpR2bMDS+T6l8ZXYwVSsN3CGX62
         2sNIojm/gT7G/78VGzSUSZGxMgpMBBj8oH8uYOgqSAICIJ9/CkatNo7iNGg783l7F+8u
         yn+J+9f/4rwR8LgUWdkg/2Qbgy1vVsQ6x5T76Z3C5c890lgbC7lThRGwClWEF+qzh3Dk
         AArGfWmVHbLls82YoI2OcBuX8Z2W6+xPXZA0AgA8LK5R12M37yxa1RSW6ju+KhfR+xhE
         UOK4max0syMqKn4NLRtK500nLsUIPsbPOObboNkBZpKUDNAZwxs9nfm9X10DCC9ZBXJK
         wPgQ==
X-Gm-Message-State: AOAM53261SNWJtirUYOmlCSkWQAeXcmdynhOOJ0m2YAxwzY8/XoAL7Y/
        8Ff6R5TH4diHWABmZAAUMVSmO7eTRetm/pEdQj4=
X-Google-Smtp-Source: ABdhPJwkP+hoFNQs/+ZP0moiGYxQtu0ohqp5UBCeH+ouDHvfNaOpL1CG4pf4SgqPt6RFs2DR/IW7QpMqt0HkpTp1Zfc=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr5174224otc.262.1590595033025;
 Wed, 27 May 2020 08:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200527113700.3579-1-ardb@kernel.org>
In-Reply-To: <20200527113700.3579-1-ardb@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 May 2020 17:57:02 +0200
Message-ID: <CAJZ5v0g_pHDN9iZP-pvcNZm6aZdkRkxgWfUmiXy7wtzCinf0EA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: GED: use correct trigger type field in _Exx / _Lxx handling
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 27, 2020 at 1:37 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Commit ea6f3af4c5e63f69 ("ACPI: GED: add support for _Exx / _Lxx handler
> methods") added a reference to the 'triggering' field of either the
> normal or the extended ACPI IRQ resource struct, but inadvertently used
> the wrong pointer in the latter case. Note that both pointers refer to the
> same union, and the 'triggering' field appears at the same offset in both
> struct types, so it currently happens to work by accident. But let's fix
> it nonetheless
>
> Fixes: ea6f3af4c5e63f69 ("ACPI: GED: add support for _Exx / _Lxx handler methods")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/acpi/evged.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
> index 6d7a522952bf..ccd900690b6f 100644
> --- a/drivers/acpi/evged.c
> +++ b/drivers/acpi/evged.c
> @@ -94,7 +94,7 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
>                 trigger = p->triggering;
>         } else {
>                 gsi = pext->interrupts[0];
> -               trigger = p->triggering;
> +               trigger = pext->triggering;
>         }
>
>         irq = r.start;
> --

Applied, thanks!
