Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8813439DCDA
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 14:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFGMrh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 08:47:37 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:37864 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhFGMrg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 08:47:36 -0400
Received: by mail-ot1-f51.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so16532581otp.4;
        Mon, 07 Jun 2021 05:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ne/p4NOGCwVSG6gGyVyzO7r+FfStromPMY+PxpPNydI=;
        b=O2Rob0cgSz/Jho0ELC9k4oJPMkqhTMMqhTQEmuyFZMQUgcXeD29eCIayPGPEGQtUmg
         Kyl0RR+hSR1LDD7FggVckr7MFSmBOxdjXLhga0B/a6AFU6sjLpVwhwj2YvX/ZP/yFsK2
         Jb7y5iYF9wIFbz7h/rUMXbdl5bwHDQd8z40ANCDGyu/VdvhaF5sea8UXJFivcTOM3ho6
         9Eo80+SzPZGdz8R2Cba4OfUq1Ism5NBGOUzQW2rz3diGe53IR2NBMgyp1g8sJfDqOI1B
         76QM+r7412H4fs5xucqyzriUxnlxh4zBHcz4PIxN4hPnooWJPt1I6Twctlc4NEmbY6Mu
         x5fA==
X-Gm-Message-State: AOAM533/Zm5XhQprvQfcP9f2pQ/Wa4qHYd+sq6fGF2YVXK6KAD+oIRJ3
        ycAxIiFMT5g+VCN2HFm6JEZi8XTrGPJBklNfw9k=
X-Google-Smtp-Source: ABdhPJy+PE0k4m3sO4C/+M2oB5Dp8/vHSk6ur8aGkSkM/rVZq77o5QtmrOm/ZEAzeGQHKTEXMYlTP/dDBrFFSjW8XnE=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr13451517otg.260.1623069943825;
 Mon, 07 Jun 2021 05:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210604165047.13243-1-andriy.shevchenko@linux.intel.com> <20210604165047.13243-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210604165047.13243-3-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 14:45:32 +0200
Message-ID: <CAJZ5v0hk8BiDt5e_P=KXkj3datr_WTCUe7k2u_TkFUPjWm79Aw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] device property: Unify access to of_node
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 4, 2021 at 6:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Historically we have a few variants how we access dev->fwnode
> and dev->of_node. Some of the functions during development
> gained different versions of the getters. Unify access to of_node
> and as a side change slightly refactor ACPI specific branches.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: no changes
> v2: no changes
>  drivers/base/property.c  | 29 +++++++++++++----------------
>  include/linux/property.h |  2 +-
>  2 files changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index c26370aacdc6..d0874f6c29bb 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -759,13 +759,8 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
>  struct fwnode_handle *device_get_next_child_node(struct device *dev,
>                                                  struct fwnode_handle *child)
>  {
> -       struct acpi_device *adev = ACPI_COMPANION(dev);
> -       struct fwnode_handle *fwnode = NULL, *next;
> -
> -       if (dev->of_node)
> -               fwnode = of_fwnode_handle(dev->of_node);
> -       else if (adev)
> -               fwnode = acpi_fwnode_handle(adev);
> +       const struct fwnode_handle *fwnode = dev_fwnode(dev);
> +       struct fwnode_handle *next;
>
>         /* Try to find a child in primary fwnode */
>         next = fwnode_get_next_child_node(fwnode, child);
> @@ -868,28 +863,31 @@ EXPORT_SYMBOL_GPL(device_get_child_node_count);
>
>  bool device_dma_supported(struct device *dev)
>  {
> +       const struct fwnode_handle *fwnode = dev_fwnode(dev);
> +
>         /* For DT, this is always supported.
>          * For ACPI, this depends on CCA, which
>          * is determined by the acpi_dma_supported().
>          */
> -       if (IS_ENABLED(CONFIG_OF) && dev->of_node)
> +       if (is_of_node(fwnode))
>                 return true;
>
> -       return acpi_dma_supported(ACPI_COMPANION(dev));
> +       return acpi_dma_supported(to_acpi_device_node(fwnode));
>  }
>  EXPORT_SYMBOL_GPL(device_dma_supported);
>
>  enum dev_dma_attr device_get_dma_attr(struct device *dev)
>  {
> +       const struct fwnode_handle *fwnode = dev_fwnode(dev);
>         enum dev_dma_attr attr = DEV_DMA_NOT_SUPPORTED;
>
> -       if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
> -               if (of_dma_is_coherent(dev->of_node))
> +       if (is_of_node(fwnode)) {
> +               if (of_dma_is_coherent(to_of_node(fwnode)))
>                         attr = DEV_DMA_COHERENT;
>                 else
>                         attr = DEV_DMA_NON_COHERENT;
>         } else
> -               attr = acpi_get_dma_attr(ACPI_COMPANION(dev));
> +               attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
>
>         return attr;
>  }
> @@ -1007,14 +1005,13 @@ EXPORT_SYMBOL(device_get_mac_address);
>   * Returns Linux IRQ number on success. Other values are determined
>   * accordingly to acpi_/of_ irq_get() operation.
>   */
> -int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index)
> +int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
>  {
> -       struct device_node *of_node = to_of_node(fwnode);
>         struct resource res;
>         int ret;
>
> -       if (IS_ENABLED(CONFIG_OF) && of_node)
> -               return of_irq_get(of_node, index);
> +       if (is_of_node(fwnode))
> +               return of_irq_get(to_of_node(fwnode), index);
>
>         ret = acpi_irq_get(ACPI_HANDLE_FWNODE(fwnode), index, &res);
>         if (ret)
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 0d876316e61d..073e680c35e2 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -119,7 +119,7 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
>  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
>  void fwnode_handle_put(struct fwnode_handle *fwnode);
>
> -int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index);
> +int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
>
>  unsigned int device_get_child_node_count(struct device *dev);
>
> --

Applied as 5.14 material along with the [1-2/3], thanks!
