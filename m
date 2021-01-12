Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCC92F3A95
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 20:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437085AbhALTaj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 14:30:39 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:37312 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732921AbhALTaj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2021 14:30:39 -0500
Received: by mail-ot1-f51.google.com with SMTP id o11so3403074ote.4;
        Tue, 12 Jan 2021 11:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBLiJeNQADKjUgSbhzyFOUFac404UUfzi1rI55CmkHI=;
        b=PNO63moDBC4c2m9l6EqU/kyXT7aItHwIoLUrrtMagN3mD505VbIJuNn/nAqzT9snP0
         /M3LeRNzExzUz+/vWMquYI1q8NIWKlRwhTKz2k8uJYI91hxLq6SwTY+wqkteuu/hnLBE
         Odd2zifHVg4vx18IcS5YFOuuX2vBwaJWshL/92pQ4D136AcjhPvkjmk/wZ0B5LKALtAs
         bHzktdQ8vNlgFL1k+M9GjZ7U8E4mjPRccA+1WKEZKf6/HFL62p08V26N0ItDkZ6RuBem
         M4QgMBxO9fF1X2ktS3YsueOgASHEjbLaKPDbhrZwZkr1UaRuToZaT3s/0i/KHG3dPSH6
         UF3w==
X-Gm-Message-State: AOAM531Wos61s7WIt8jsTQK3GgLlLu1uPnSC9IighVn97ZQnl+CwH0GT
        1DcuAHcazu6YcncSVAfbvXI3NQRTBnti2CNrqOk=
X-Google-Smtp-Source: ABdhPJy/n4CyOG7sST+sBvOp4dcWNxGAIaKS2+2pUstHMvFelSX1gYALDbvieubLL47HjuuhD8Y/beILkYvFHG1IyX0=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr652265ota.260.1610479797900;
 Tue, 12 Jan 2021 11:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20210107132838.396641-1-djrscally@gmail.com> <20210107132838.396641-8-djrscally@gmail.com>
In-Reply-To: <20210107132838.396641-8-djrscally@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jan 2021 20:29:46 +0100
Message-ID: <CAJZ5v0gzRvNwciDRa2CmnimaXwShzvouTK7_mNx9QGcwXe+v+A@mail.gmail.com>
Subject: Re: [PATCH v5 07/15] device property: Define format macros for ports
 and endpoints
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        yong.zhi@intel.com, Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, tian.shu.qiu@intel.com,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 7, 2021 at 2:31 PM Daniel Scally <djrscally@gmail.com> wrote:
>
> OF, ACPI and software_nodes all implement graphs including nodes for ports
> and endpoints. These are all intended to be named with a common schema,
> as "port@n" and "endpoint@n" where n is an unsigned int representing the
> index of the node. To ensure commonality across the subsystems, provide a
> set of macros to define the format.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Changes in v5:
>
>         - Changed commit subject
>
>  include/linux/fwnode.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index fde4ad97564c..77414e431e89 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -50,6 +50,13 @@ struct fwnode_endpoint {
>         const struct fwnode_handle *local_fwnode;
>  };
>
> +/*
> + * ports and endpoints defined as software_nodes should all follow a common
> + * naming scheme; use these macros to ensure commonality.
> + */
> +#define SWNODE_GRAPH_PORT_NAME_FMT             "port@%u"
> +#define SWNODE_GRAPH_ENDPOINT_NAME_FMT         "endpoint@%u"
> +
>  #define NR_FWNODE_REFERENCE_ARGS       8
>
>  /**
> --
> 2.25.1
>
