Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCEC402ED4
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Sep 2021 21:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345107AbhIGTPU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Sep 2021 15:15:20 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45826 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbhIGTPT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Sep 2021 15:15:19 -0400
Received: by mail-ot1-f50.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso360425otv.12;
        Tue, 07 Sep 2021 12:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QM0pnBbZCN7JGJ3PcVpJ1P3dHXC4qKi2o9dbP7qotE8=;
        b=YI33Z38DlY52u4xdJH0xuIFQIpw8Nr/g3WLkkSEYEIwBxqskmfr2kvJg4KCx9Li+e8
         BZ+KG6c/ZZqNxTYveCUEXuY1NgH/nanGR/ixZ4YO1M17JJoYp2D5ATzwCtHAF1PWi41w
         YCrBNg7SFBOK40W02g0IE5LQ7chrueU9xfyr8VlmbbxSAZi26WC9Equ6YG3+I2T+CzlO
         Z/ZdJe3r9YuNKtkfAv9EQFGYQE5cKyry53tQzXfrpJlhyaOrHfKYtiif3pfKnCfTn69I
         DlZb7r81ezjRrQh0SLVLYrav0iI13SmT8uq79qmKilEZ6rvBbS9d91C6R7xk5I8ns5UK
         gH4A==
X-Gm-Message-State: AOAM531WFJeCbrJlDvxfnS5L1wsQ7jKz2GCZAN94d2xqEUftqVc/JxW2
        kd5JPX1aG/EUNuPW1uFuN/LyVd0Pt9cyh8g9PAk=
X-Google-Smtp-Source: ABdhPJz4Cn/V39TGR4W44vmuWWLvTjHAPaKfwzkl/2vWyem7eSC/v66yGSCiO4TaW1TxIkNwLNeKW2kJlJAz4Blmrw0=
X-Received: by 2002:a9d:4d93:: with SMTP id u19mr16241586otk.86.1631042053048;
 Tue, 07 Sep 2021 12:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210903210633.277807-1-kari.argillander@gmail.com>
In-Reply-To: <20210903210633.277807-1-kari.argillander@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Sep 2021 21:14:02 +0200
Message-ID: <CAJZ5v0iNZvaLVgwJm7PG4-M9T9cyHuQJm0vqEeQ9sg7E0GeObw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Remove unneeded header linux/nls.h
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 3, 2021 at 11:07 PM Kari Argillander
<kari.argillander@gmail.com> wrote:
>
> Code that use linux/nls.h was moved to device_sysfs.c by commit
> c2efefb33abf ("ACPI / scan: Move sysfs-related device code to a separate file")
>
> Remove this include so that complier has easier times and it would be
> easier to grep where nls code is used.
>
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
>  drivers/acpi/scan.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index b24513ec3fae..5b54c80b9d32 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -16,7 +16,6 @@
>  #include <linux/signal.h>
>  #include <linux/kthread.h>
>  #include <linux/dmi.h>
> -#include <linux/nls.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/pgtable.h>
> --

Applied as 5.15-rc material, thanks!
