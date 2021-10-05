Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5D44229BF
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhJEOBA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 10:01:00 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:35638 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbhJEN7b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Oct 2021 09:59:31 -0400
Received: by mail-ot1-f52.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so25924069otj.2;
        Tue, 05 Oct 2021 06:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Dmc2UFMnKcE8fZkmJNJs2CtEujDkiJDHQO9nSLj434=;
        b=UdoNgHaw9Afd4Na9tYay55Y+V70klvhU7tcwXBqLCrRkPgtzh+sx6wuNrRW78/dlZF
         FqhcO1Zc7xM5gGe2UfZ42gEWm+GAe4kJkZfHa2OyQeFYunc83vNhqtt6DCKH1o7hlxW/
         3FTu1VK/WP2tfsgTdBMvNWXGd1QIXGZGhRtBKIDoIiD5W9/IFLCtAaMIraEnRhFT04ko
         quy2+inUirN6KN+VZ+HgboFfME1hHFatp8xA3LW0k7f+5v6A/Qkn0gpZO2pHm4nw4T6D
         z7TOhhmaFU4vhkDgMc7a/Snt0K2wNMu4ITQ9IJaKIe2noA8vhFAJYdjtxeZRt4nxCpRw
         xm5w==
X-Gm-Message-State: AOAM530Y9B0ZoU1e9fYb3f6fldxKhNpITK8ALJs87qVxB5ICTIJ0LH4a
        EwPlIT1PlNFlNDyD+67AKU5kPsXAn44Pj//Tmas=
X-Google-Smtp-Source: ABdhPJxSdpGAi/bDgCXOQyZaMdrRL1F3GTxfm3bZCxHuboEmINvhSI5BEiSNvVfo5XSAyl4iCzKlaOXCcNBeoJ7/iZA=
X-Received: by 2002:a05:6830:2784:: with SMTP id x4mr14547219otu.86.1633442260806;
 Tue, 05 Oct 2021 06:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211002044500.24306-1-rdunlap@infradead.org>
In-Reply-To: <20211002044500.24306-1-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Oct 2021 15:57:30 +0200
Message-ID: <CAJZ5v0ggDQ7ZXKRgZXQy-EsdD8-Yu01e=A+OSXm9UkJs2P8wUA@mail.gmail.com>
Subject: Re: [PATCH] PNP: system.c: unmark a comment as being kernel-doc
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Oct 2, 2021 at 6:45 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix a documentation build warning caused by the comment not being
> in kernel-doc format:
>
> system.c:110: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Reserve motherboard resources after PCI claim BARs,
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Aditya Srivastava <yashsri421@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: linux-acpi@vger.kernel.org
> ---
>  drivers/pnp/system.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20211001.orig/drivers/pnp/system.c
> +++ linux-next-20211001/drivers/pnp/system.c
> @@ -106,7 +106,7 @@ static int __init pnp_system_init(void)
>         return pnp_register_driver(&system_pnp_driver);
>  }
>
> -/**
> +/*
>   * Reserve motherboard resources after PCI claim BARs,
>   * but before PCI assign resources for uninitialized PCI devices
>   */

Applied as 5.16 material, thanks!
