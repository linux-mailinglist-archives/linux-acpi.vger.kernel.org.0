Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855B12EFD0E
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Jan 2021 03:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbhAICJA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 21:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbhAICJA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 21:09:00 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268A5C061573;
        Fri,  8 Jan 2021 18:08:20 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8BDDCDA;
        Sat,  9 Jan 2021 03:08:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1610158098;
        bh=HqFLAk4wlbnnnu9n22IHt3F+ZPuS5ti9Z/jeFz4xo7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qE9VFJETZN1AGT0SgJrTBHu7AoPRhLMLNT0WYnSHcBow7oyLBog1H35mUp0gCtnFx
         OUOkRX1fbBnZnqHtQtXbDYU8xFkFofqDv2KsvOF7JpfX8jy/vTOD0uP17oH4s6jc9W
         oCRWPasJDJBjOYoL86d8zgBB/ZOpErpJT0A6y/nU=
Date:   Sat, 9 Jan 2021 04:08:04 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        devel@acpica.org, rjw@rjwysocki.net, lenb@kernel.org,
        mchehab@kernel.org, sergey.senozhatsky@gmail.com,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se,
        prabhakar.mahadev-lad.rj@bp.renesas.com, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v5 00/15] Add functionality to ipu3-cio2 driver allowing
 software_node connections to sensors on platforms designed for Windows
Message-ID: <X/kQBAQZi3l5/WI7@pendragon.ideasonboard.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Greg,

On Thu, Jan 07, 2021 at 01:28:23PM +0000, Daniel Scally wrote:
> 
> Hello all
> 
> v4:
> https://lore.kernel.org/linux-media/20210103231235.792999-1-djrscally@gmail.com/T/#m11b7cb977e1b73fba1e625c3d6a189e2943a7783
> v3:
> https://lore.kernel.org/linux-media/20201224010907.263125-1-djrscally@gmail.com/T/#m37b831bb2b406917d6db5da9acf9ed35df65d72d
> v2:
> https://lore.kernel.org/linux-media/20201217234337.1983732-1-djrscally@gmail.com/T/#md93fd090009b42a6a98aed892aff0d38cf07e0cd
> v1:
> https://lore.kernel.org/linux-media/20201130133129.1024662-1-djrscally@gmail.com/T/#m91934e12e3d033da2e768e952ea3b4a125ee3e67
> 
> This series is to start adding support for webcams on laptops with ACPI tables
> designed for use with CIO2 on Windows. This series extends the ipu3-cio2
> driver to allow for patching the firmware via software_nodes if endpoints
> aren't defined by ACPI.
> 
> I'm hopeful that most or all of this series could get picked up for 5.12.
> We touch a few different areas (listed below), but I think the easiest
> approach would be to merge everything through media tree. Rafael, Greg,
> Mauro and Sergey; are you ok with that plan, or would you prefer a
> different approach? Mauro; if that plan is ok (and of course assuming that
> the rest of the patches are acked by their respective maintainers) could
> we get a dedicated feature branch just in case the following series ends
> up being ready in time too?
> 
> lib
>   lib/test_printf.c: Use helper function to unwind array of
>     software_nodes
> 
> base
>   software_node: Fix refcounts in software_node_get_next_child()
>   property: Return true in fwnode_device_is_available for NULL ops
>   property: Call fwnode_graph_get_endpoint_by_id() for fwnode->secondary
>   software_node: Enforce parent before child ordering of nodes arrays
>   software_node: unregister software_nodes in reverse order

Could you please let us know with an Acked-by if these patches can be
merged through the linux-media tree for v5.12 ? This is a cross-tree
series and we would like to avoid topic branches if possible.

>   include: fwnode.h: Define format macros for ports and endpoints
> 
> acpi
>   acpi: Add acpi_dev_get_next_match_dev() and helper macro
> 
> media
>   media: v4l2-core: v4l2-async: Check sd->fwnode->secondary in
>     match_fwnode()
>   ipu3-cio2: Add T: entry to MAINTAINERS
>   ipu3-cio2: Rename ipu3-cio2.c
>   ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
>   include: media: v4l2-fwnode: Include v4l2_fwnode_bus_type
> 
> Series-level changelog:
> 	- Rebased onto 5.11-rc1
> 
> Thanks
> Dan
> 
> Andy Shevchenko (1):
>   media: ipu3-cio2: Add headers that ipu3-cio2.h is direct user of
> 
> Daniel Scally (13):
>   software_node: Fix refcounts in software_node_get_next_child()
>   device property: Return true in fwnode_device_is_available for NULL
>     ops
>   device property: Call fwnode_graph_get_endpoint_by_id() for
>     fwnode->secondary
>   software_node: Enforce parent before child ordering of nodes arrays
>   software_node: unregister software_nodes in reverse order
>   device property: Define format macros for ports and endpoints
>   lib/test_printf.c: Use helper function to unwind array of
>     software_nodes
>   ipu3-cio2: Add T: entry to MAINTAINERS
>   ipu3-cio2: Rename ipu3-cio2.c
>   media: v4l2-core: v4l2-async: Check sd->fwnode->secondary in
>     match_fwnode()
>   ACPI / bus: Add acpi_dev_get_next_match_dev() and helper macro
>   media: v4l2-fwnode: Include v4l2_fwnode_bus_type
>   ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
> 
> Heikki Krogerus (1):
>   software_node: Add support for fwnode_graph*() family of functions
> 
>  MAINTAINERS                                   |   2 +
>  drivers/acpi/utils.c                          |  30 +-
>  drivers/base/property.c                       |  15 +-
>  drivers/base/swnode.c                         | 180 ++++++++--
>  drivers/media/pci/intel/ipu3/Kconfig          |  18 +
>  drivers/media/pci/intel/ipu3/Makefile         |   3 +
>  drivers/media/pci/intel/ipu3/cio2-bridge.c    | 311 ++++++++++++++++++
>  drivers/media/pci/intel/ipu3/cio2-bridge.h    | 125 +++++++
>  .../ipu3/{ipu3-cio2.c => ipu3-cio2-main.c}    |  34 ++
>  drivers/media/pci/intel/ipu3/ipu3-cio2.h      |  24 ++
>  drivers/media/v4l2-core/v4l2-async.c          |   8 +
>  drivers/media/v4l2-core/v4l2-fwnode.c         |  11 -
>  include/acpi/acpi_bus.h                       |   7 +
>  include/linux/fwnode.h                        |   7 +
>  include/media/v4l2-fwnode.h                   |  22 ++
>  lib/test_printf.c                             |   4 +-
>  16 files changed, 763 insertions(+), 38 deletions(-)
>  create mode 100644 drivers/media/pci/intel/ipu3/cio2-bridge.c
>  create mode 100644 drivers/media/pci/intel/ipu3/cio2-bridge.h
>  rename drivers/media/pci/intel/ipu3/{ipu3-cio2.c => ipu3-cio2-main.c} (98%)

-- 
Regards,

Laurent Pinchart
