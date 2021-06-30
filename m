Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B503B8820
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jun 2021 20:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhF3SEv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Jun 2021 14:04:51 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:36387 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbhF3SEv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jun 2021 14:04:51 -0400
Received: by mail-oi1-f175.google.com with SMTP id 11so4063838oid.3;
        Wed, 30 Jun 2021 11:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+VjNjcoSkL8TkkIWimseU291DzS7iLsx6ScdS0y4SQ=;
        b=E8wKe38GpFe7zsNSs9zBCtUMnNebLhtXWhyiq/1bVA+d3E4hcUQ5FuaRCGC+XOrKTL
         LS0saCATLF1qFQvOH327qW24FfXCQfaDWLcW+1YRaYNufBIeZwkxGFjqwe7ISDQPxNRu
         /g/J+bOJRPBnvf4af/mfn3yEkxiaOuf29k430O1IAO9IhrsZBvz/0SL+jdhZ/n5XjqKs
         ql/HCAWvN7UMBdn+BluXvZOwQz7mOde/32NTzhQzymRMEdEw3xDD0JLlYEqgwxi9Cicy
         JOz+QPDh2zqQREbo3Rl/qFUDS3cnG7xeNGx4t4D5nl4Bo4C/SibNTf1tHOYxrU8+IrPM
         geXg==
X-Gm-Message-State: AOAM533d4fz1F562z6I5JtMDy4T5prZnfqASLEfTYzE2b9cC1fTLFsoL
        paNNoM1FZEEpKTkExeiyES01N9uWSbqYlNzkST4=
X-Google-Smtp-Source: ABdhPJyzEFsadFe/+/Ht3AYSmJHeIYzDs86sKafszYruAPx8dHCRrifoZxb+q+JeH+/S/P89hg96nsbNAX+nELkNq50=
X-Received: by 2002:a05:6808:15a6:: with SMTP id t38mr4095883oiw.157.1625076142117;
 Wed, 30 Jun 2021 11:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210629112748.23734-1-zhangliguang@linux.alibaba.com>
In-Reply-To: <20210629112748.23734-1-zhangliguang@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jun 2021 20:02:11 +0200
Message-ID: <CAJZ5v0j3oCqW-D-Z3jRP9w8uETsYjxB+=Tsm3-B5FNOYR1QgeQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / amba: Fix resource name in /proc/iomem
To:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 29, 2021 at 1:28 PM Liguang Zhang
<zhangliguang@linux.alibaba.com> wrote:
>
> In function amba_handler_attach(), dev->res.name is initialized by
> amba_device_alloc. But when address_found is false, dev->res.name is
> assigned to null value, which leads to wrong resource name display in
> /proc/iomem, "<BAD>" is seen for those resources.
>
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> ---
>  drivers/acpi/acpi_amba.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
> index 49b781a9cd97..ab8a4e0191b1 100644
> --- a/drivers/acpi/acpi_amba.c
> +++ b/drivers/acpi/acpi_amba.c
> @@ -76,6 +76,7 @@ static int amba_handler_attach(struct acpi_device *adev,
>                 case IORESOURCE_MEM:
>                         if (!address_found) {
>                                 dev->res = *rentry->res;
> +                               dev->res.name = dev_name(&dev->dev);
>                                 address_found = true;
>                         }
>                         break;
> --

Applied as 5.14-rc1 material, thanks!
