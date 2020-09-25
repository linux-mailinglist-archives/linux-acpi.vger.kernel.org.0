Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E2B278DC1
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 18:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgIYQM5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 25 Sep 2020 12:12:57 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:35569 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIYQM5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 12:12:57 -0400
Received: by mail-oo1-f67.google.com with SMTP id k13so886458oor.2
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 09:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p6r219c9DLO15OfEk2pcpu4mJh+Ck5oqlP09njsqxVs=;
        b=jnILda1RZ9bQtWq6vSyNSD3uFOoQnnzAZFw5oO0VeLNwWwDYLy5HU8ESIKSpk5D2wy
         BvC0TmSiAhUdhZTaL/c2gtH1/CWxarzM2JvTs+1vFl/sYEQkA6NvX6EeefvGQf99oU/y
         Kan6W2qX/n6gG3yOODvFl8jOUDciBgzg4K2R7h3clu4tbP35uwT9/Q8QX+BaA7K5uq5v
         Qx52Isff56PUtm4Lbdkb7vTEAahBUUe8ayvcklilhkfl3zTS9ng1vW69zoU2sq9VddHK
         xC+Kgj8YiWYy7WYN96Mq6RDyzIjlAvWnuwNy/RNUyZuvlyy6C7tmEqal9LtjoFlJe3Fw
         4wDw==
X-Gm-Message-State: AOAM531kFolbCkAPmyARHeXDd9btNDTIAm0td9D6iKQQ5FywVxyHbPke
        KwdAhwbBU+cwlw5WnHMMAMQ/V4LTMGhS4yql3qc=
X-Google-Smtp-Source: ABdhPJw5q6U/vaL5/57hy3IELV2HABpyTZnIyM315Yw+PJ1SBggImfZjosb0LEgMK7gpRrPAzldM2aGtKfrKLLjB7VQ=
X-Received: by 2002:a4a:e946:: with SMTP id v6mr1396439ood.38.1601050376969;
 Fri, 25 Sep 2020 09:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <1600740674-43727-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1600740674-43727-1-git-send-email-tiantao6@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 18:12:46 +0200
Message-ID: <CAJZ5v0iD=QyTrS8Z2UjHzswUTeys9XLvkbxY3hi-vmVchdxUTg@mail.gmail.com>
Subject: Re: [PATCH] ACPI / PNP: Fix missing-prototypes in acpi_pnp.c
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 22, 2020 at 4:13 AM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> Fix the following warnings.
> drivers/acpi/acpi_pnp.c:382:13: warning: no previous prototype
> for ‘acpi_pnp_init’ [-Wmissing-prototypes].
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/acpi/acpi_pnp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> index f3039b9..4ed755a 100644
> --- a/drivers/acpi/acpi_pnp.c
> +++ b/drivers/acpi/acpi_pnp.c
> @@ -11,6 +11,8 @@
>  #include <linux/module.h>
>  #include <linux/ctype.h>
>
> +#include "internal.h"
> +
>  static const struct acpi_device_id acpi_pnp_device_ids[] = {
>         /* pata_isapnp */
>         {"PNP0600"},            /* Generic ESDI/IDE/ATA compatible hard disk controller */
> --

Applied as 5.10 material with a minor edit in the subject, thanks!
