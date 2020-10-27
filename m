Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6D629C6BF
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 19:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827222AbgJ0SWR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 14:22:17 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34129 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1827206AbgJ0SWK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2020 14:22:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id z23so2279652oic.1;
        Tue, 27 Oct 2020 11:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iU/Y/1FgEUxwbaXAY+xHKp3frAfzlMLRAVJXYu+1krw=;
        b=gEBHF/kcjIeYh24G1VlKSfyEgo+2t4jdpCo1ap8NK6H628WnhXkwZHgDZPP027C0U2
         SLO+IoRxGjjuJ6DTzZIEj9cxJ/LTBro5Acv8ZSwOvirJaD7ll3idGrwDquZcpYisXjDg
         wYsoRviWX/qmpJyFEmINgQ6juXIHbZAxCxhiJWVRJTjgcLhXHM0R6zgtc4QKRfVLIV7X
         Iu7FwmO8OHWb8Q8Sdl9oQuRAZFiW+UW9h6jxbAqVfjEy0Xbzki9xm4wY8asqJsU3ZeRn
         saYfhf8FS0/tlLz1loOXIPHEIROs5XxK4i86m/k4J+r54uQjJQo5jFXWWCvVQ8uT6iBC
         /DyA==
X-Gm-Message-State: AOAM530ZV/Xr3QZJ9Axlh/Wy42wrXeAG6TcsRH6cDkwqFMoorF4QKgfM
        8+owKeMpWj9gw37i+RxWrriwBydGseTwTfr0s0Y=
X-Google-Smtp-Source: ABdhPJxvBaWabVHcPkpKGoIm0pSNdKaTLZIREu6mJulfwALp+v/j2Y4mkX4bxqN+cjUhBByHd0bc3TZbMG0rbcCdqjE=
X-Received: by 2002:aca:4c86:: with SMTP id z128mr2440673oia.71.1603822929434;
 Tue, 27 Oct 2020 11:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201022184100.71659-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201022184100.71659-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Oct 2020 19:21:57 +0100
Message-ID: <CAJZ5v0h5DF5g5TvO+sZWmJyBi=Z09EbiCkkn=jGwV3e2gM_HAQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] device property: Keep secondary firmware node
 secondary by type
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ferry Toth <fntoth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 22, 2020 at 8:41 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Behind primary and secondary we understand the type of the nodes
> which might define their ordering. However, if primary node gone,
> we can't maintain the ordering by definition of the linked list.
> Thus, by ordering secondary node becomes first in the list.
> But in this case the meaning of it is still secondary (or auxiliary).
> The type of the node is maintained by the secondary pointer in it:
>
>         secondary pointer               Meaning
>         NULL or valid                   primary node
>         ERR_PTR(-ENODEV)                secondary node
>
> So, if by some reason we do the following sequence of calls
>
>         set_primary_fwnode(dev, NULL);
>         set_primary_fwnode(dev, primary);
>
> we should preserve secondary node.
>
> This concept is supported by the description of set_primary_fwnode()
> along with implementation of set_secondary_fwnode(). Hence, fix
> the commit c15e1bdda436 to follow this as well.
>
> Fixes: c15e1bdda436 ("device property: Fix the secondary firmware node handling in set_primary_fwnode()")
> Cc: Ferry Toth <fntoth@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index c852f16c111b..41feab679fa1 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4278,7 +4278,7 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
>         } else {
>                 if (fwnode_is_primary(fn)) {
>                         dev->fwnode = fn->secondary;
> -                       fn->secondary = NULL;
> +                       fn->secondary = ERR_PTR(-ENODEV);
>                 } else {
>                         dev->fwnode = NULL;
>                 }
> --

Applied as 5.10-rc material along with the [2/2], thanks!
