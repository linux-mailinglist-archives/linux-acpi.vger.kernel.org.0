Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B882B5E2A3
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 13:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfGCLMs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 07:12:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43137 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfGCLMs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 07:12:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id q10so1900105otk.10;
        Wed, 03 Jul 2019 04:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U7f1EyIiFwc1ziRwMDUFrIFL5oAxoWGW+66zhLCeniw=;
        b=p67wq8ZtXT9zPWRUNrwoc4LIEMV/4tlLjCOfijWLeEb2GiqqcNi2+wQF8u/OssJdfk
         7DJMyfH2fKQfeY53GGL1CXcF2+55IhjyWOfZUyw9Y0D3aEP8mddNSSUBoznENzKTGASQ
         ZM5X+fvKD6osdQK/Y3BF7W6MPjIOUuvGHVYX/uGQ9QuxEZ8wVUkNcEIgHAwVVX1iznOK
         PSGTYUGZxqeYkxiB/WmRon/0ytXoPhQUiYp/QD5UalNEHN2SGKLejOiskf7QX5gZdSRJ
         LPeRIM+xUAbieVLvcy7OiUcC7BDu1esNiqyyv6Cqb0xNSOcE/yEskXeRD8JGVXdMuyMw
         bOKQ==
X-Gm-Message-State: APjAAAVycMsZZselyhJ/zDQzEHTxozxMnpafM+noa+ksZV/9KrP3+5vW
        LJlAERO+OgM8E4W6oRRosPEkSopjmQu76J25/vY=
X-Google-Smtp-Source: APXvYqxFHMr6lDzi0AllC0aFB9PTf+FIR9lUZMObiJ0wMV7PVbFF5coqE7mhBMuA394XW2hUSI7+T7132sn1uQLuN9E=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr10838606oto.167.1562152367825;
 Wed, 03 Jul 2019 04:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156140042119.2951909.7727308817426477621.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156140042119.2951909.7727308817426477621.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jul 2019 13:12:36 +0200
Message-ID: <CAJZ5v0gzRar8oowUSw0Z9_uofcbZCirmaYFmbjBvDrDAp4W5SA@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] acpi/numa/hmat: Register HMAT at device_initcall level
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 24, 2019 at 8:34 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> In preparation for registering device-dax instances for accessing EFI
> specific-purpose memory, arrange for the HMAT registration to occur
> later in the init process. Critically HMAT initialization needs to occur
> after e820__reserve_resources_late() which is the point at which the
> iomem resource tree is populated with "Application Reserved"
> (IORES_DESC_APPLICATION_RESERVED). e820__reserve_resources_late()
> happens at subsys_initcall time.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/numa/hmat.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2c220cb7b620..1d329c4af3bf 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -671,4 +671,4 @@ static __init int hmat_init(void)
>         acpi_put_table(tbl);
>         return 0;
>  }
> -subsys_initcall(hmat_init);
> +device_initcall(hmat_init);
>
