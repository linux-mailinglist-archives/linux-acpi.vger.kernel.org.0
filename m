Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13EF3B1F8F
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jun 2021 19:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFWRf3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Jun 2021 13:35:29 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41704 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFWRf1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jun 2021 13:35:27 -0400
Received: by mail-ot1-f43.google.com with SMTP id m6-20020a9d1d060000b029044e2d8e855eso755291otm.8;
        Wed, 23 Jun 2021 10:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=riea6Yx42NfdkMCg0Ketroi7GWO16G5+ktOeMGqjrPA=;
        b=hlKcXI2BhCRPF1CFoDnettyFZ+oeGEc0q9ijOQbyksFylfT/G71iaNfHBn/3vL6aPk
         skSjNGLYb1JS/XxIMtzE+KPT9P1soZ08dTnOR+Kl0MHBNjqP9b48S9RAWxBsGrDFgnK2
         p+FatjNQHGypK0eLxQSVe/429uBAN6HMkYDzwfaYFkdwYGRH35mvmvvYMuZeLusycv5e
         0+20esYhaR0hZwqm3Gf8ZS+PfM+MUxrwV14da+OvzzS7QcIpQl6Qu2P/YrpPl4HcyFUa
         mbUAo7G+2T+Zpqvzev4gD35w36I9yUgnit7FMc4yBSuKKjcphtk8t2QM1B+Dblx/LgXY
         PdLg==
X-Gm-Message-State: AOAM531+9/rNJHDaLSlXBWUKA6RVgwBbnmPVZbjh/NWpvo555ABK9RbD
        1OLVg+9VC00MTOdUxn9+E5gAfEEH7oKcpI15JFI=
X-Google-Smtp-Source: ABdhPJwLCQlTei0mNC4Bf1WC6HysPCpYFklJTlGteqgE/TEzaTHp6+ZUtP6vDXySP99ZK2GhW4JNntTwjMKmznAYBiM=
X-Received: by 2002:a9d:1905:: with SMTP id j5mr881357ota.321.1624469589692;
 Wed, 23 Jun 2021 10:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210621152433.29716-1-rf@opensource.cirrus.com>
In-Reply-To: <20210621152433.29716-1-rf@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Jun 2021 19:32:58 +0200
Message-ID: <CAJZ5v0jBk9LnimOPRgVOof-DJp4rqfto31+nFv8gzmsQ1jUB=A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: tables: Add custom DSDT file as makefile prerequisite
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 21, 2021 at 5:24 PM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> A custom DSDT file is mostly used during development or debugging,
> and in that case it is quite likely to want to rebuild the kernel
> after changing ONLY the content of the DSDT.
>
> This patch adds the custom DSDT as a prerequisite to tables.o
> to ensure a rebuild if the DSDT file is updated. Make will merge
> the prerequisites from multiple rules for the same target.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/acpi/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index efb0d1f64019..ceb1aed4b1fc 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -8,6 +8,11 @@ ccflags-$(CONFIG_ACPI_DEBUG)   += -DACPI_DEBUG_OUTPUT
>  #
>  # ACPI Boot-Time Table Parsing
>  #
> +ifeq ($(CONFIG_ACPI_CUSTOM_DSDT),y)
> +tables.o: $(src)/../../include/$(subst $\",,$(CONFIG_ACPI_CUSTOM_DSDT_FILE)) ;
> +
> +endif
> +
>  obj-$(CONFIG_ACPI)             += tables.o
>  obj-$(CONFIG_X86)              += blacklist.o
>
> --

Applied as 5.14 material, thanks!
