Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7930A2E6CBB
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Dec 2020 01:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgL2AH6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 19:07:58 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:44820 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgL2AH6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Dec 2020 19:07:58 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8BC5D98;
        Tue, 29 Dec 2020 01:07:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1609200434;
        bh=d4Mhfe3bfkE71312xd7PJbpeT/ceK/ppJxKjsDG5mdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pXfrmYmua0twZRFvuhxMt7W8MJbwh2Lre6rJEvwDuS/nfUsF2WPCJM7kBxduidM+Y
         zZMMvC8paqLiNrH7tJvaB9z9xRTQqpKIyryeFcsRASAuLVYXCvAMHh5npSrXh5CD3s
         oaojhOJE+hcISC6kr6s5P3YJwqtHcgaWjzE05kBk=
Date:   Tue, 29 Dec 2020 02:07:04 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        kieran.bingham+renesas@ideasonboard.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        niklas.soderlund+renesas@ragnatech.se,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jordan Hand <jorhand@linux.microsoft.com>
Subject: Re: [PATCH v3 14/14] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
Message-ID: <X+pzKDNWpiQWenHy@pendragon.ideasonboard.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-15-djrscally@gmail.com>
 <CAHp75VeXN6PnV7Mzz6UMpD+m-yjPi6XK0kx1=+-M5mci=Vb=YQ@mail.gmail.com>
 <20201228170521.GZ26370@paasikivi.fi.intel.com>
 <2d37df3d-f04c-6679-6e27-6c7f82e9b158@gmail.com>
 <20201228225544.GH4077@smile.fi.intel.com>
 <X+plTyUFhfHi7eIE@pendragon.ideasonboard.com>
 <CAHp75Vdzk7i+QzkTxLJUUkw3xZot9F7QT8pyu6b5yjkCVzMXEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Vdzk7i+QzkTxLJUUkw3xZot9F7QT8pyu6b5yjkCVzMXEA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Tue, Dec 29, 2020 at 01:54:59AM +0200, Andy Shevchenko wrote:
> On Tue, Dec 29, 2020 at 1:08 AM Laurent Pinchart wrote:
> >
> > On Tue, Dec 29, 2020 at 12:55:44AM +0200, Andy Shevchenko wrote:
> > > On Mon, Dec 28, 2020 at 10:37:38PM +0000, Daniel Scally wrote:
> > > > On 28/12/2020 17:05, Sakari Ailus wrote:
> 
> ...
> 
> > > > Which do you prefer?
> > >
> > > Actually ipu3-cio2.h misses a lot of inclusions (like mutex.h which I
> > > immediately noticed when scrolled over data types).
> >
> > Then ipu3-cio2.h should be fixed :-)
> 
> Below is a draft patch (it is possible mangled, due to Gmail). Can you
> look at it and tell me what you think?

Thank you for the patch.

> I believe some headers can be removed, but I have no idea about header
> inclusion guarantees that v4l2 provides.
> 
> From 10fa6c7ff66ded35a246677ffe20c677e8453f5b3 Mon Sep 17 00:00:00 2001
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Tue, 29 Dec 2020 01:42:03 +0200
> Subject: [PATCH 1/1] media: ipu3-cio2: Add headers that ipu3-cio2.h is direct
>  user of
> 
> Add headers that ipu3-cio2.h is direct user of.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/pci/intel/ipu3/ipu3-cio2.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.h
> b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
> index ccf0b85ae36f..9ea154c50ba1 100644
> --- a/drivers/media/pci/intel/ipu3/ipu3-cio2.h
> +++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
> @@ -4,8 +4,25 @@
>  #ifndef __IPU3_CIO2_H
>  #define __IPU3_CIO2_H
> 
> +#include <linux/bits.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/kernel.h>
> +#include <linux/mutex.h>
>  #include <linux/types.h>
> 
> +#include <asm/page.h>
> +
> +#include <linux/videodev2.h>

I think this can be dropped.

> +
> +#include <media/media-device.h>
> +#include <media/media-entity.h>
> +#include <media/v4l2-async.h>
> +#include <media/v4l2-dev.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-subdev.h>
> +#include <media/videobuf2-core.h>
> +#include <media/videobuf2-v4l2.h>
> +
>  #define CIO2_NAME "ipu3-cio2"
>  #define CIO2_DEVICE_NAME "Intel IPU3 CIO2"
>  #define CIO2_ENTITY_NAME "ipu3-csi2"
> @@ -325,6 +342,8 @@ struct csi2_bus_info {
>   u32 lanes;
>  };
> 
> +struct cio2_fbpt_entry;
> +
>  struct cio2_queue {
>   /* mutex to be used by vb2_queue */
>   struct mutex lock;
> @@ -355,6 +374,8 @@ struct cio2_queue {
>   atomic_t bufs_queued;
>  };
> 
> +struct pci_dev;
> +

How about grouping all forward declarations at the top ?

Otherwise this looks good,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

If I was maintaining this driver I would likely move the structure
definitions to ipu3-cio2.c though.

>  struct cio2_device {
>   struct pci_dev *pci_dev;
>   void __iomem *base;

-- 
Regards,

Laurent Pinchart
