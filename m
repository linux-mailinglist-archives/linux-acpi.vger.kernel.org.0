Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E262F3AA9
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 20:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390350AbhALTe4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 14:34:56 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:43916 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388019AbhALTez (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2021 14:34:55 -0500
Received: by mail-oi1-f172.google.com with SMTP id q25so3540696oij.10;
        Tue, 12 Jan 2021 11:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k32Qu3cNSiXcAEMafYSgn1kVqosninNEkgSTQf4f+b8=;
        b=fp8Qd2NeuY+hQCJRQo4uUuCfnEB6p9MkS1IaFYgCRVKuy6wtKB/Wdldzw09ppKud7U
         7cU0l0DEdHd4ct0xpoKnlNkRz+9+jv6Bvz4c+xliBpLVWGohRqIaM4Kn8fpQ3n18JH6r
         j8WAhrZvRvEtImnp6ReCEtxaKgP5ivLbK1SGWtQMLvqBJqUeep4Zk7H95eD2jByy+RM1
         AOixkbJs+W0zoV05/mJKvI+4x53dBSbZCSQjVuMRb6KhQYokWcZI56OVdvjC93l0DQC/
         KSbOvl89Kq7UMlYM5slpSFDERmJczI0xeFQd7/Onu5fnXgX9l0IzQ8G5M4h2L7CbBXmt
         dleQ==
X-Gm-Message-State: AOAM533UOCjvmvI6AFxm0A56099trQC0cEcSDXlkZe0NSBw6sIVUl82E
        hPaWtXWlFzaL6IFr0WGOe46xvvmlZSfp7nrfgfo=
X-Google-Smtp-Source: ABdhPJx7Dl0rZbXiXD6L6Xfo9BZWZpfCRxNircr5Bvuzz8XDqjnp0tR+JuDzrI0pKoBbcHejVMVKTnBv1PaBNG8qTnA=
X-Received: by 2002:aca:4892:: with SMTP id v140mr468391oia.71.1610480054580;
 Tue, 12 Jan 2021 11:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20210107132838.396641-1-djrscally@gmail.com>
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jan 2021 20:34:03 +0100
Message-ID: <CAJZ5v0gb9c-kWM4aAKm6UqbVKt7dyp6xJS5E=7yoPRnPP+msbw@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] Add functionality to ipu3-cio2 driver allowing
 software_node connections to sensors on platforms designed for Windows
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
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 7, 2021 at 2:30 PM Daniel Scally <djrscally@gmail.com> wrote:
>
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
>         - Rebased onto 5.11-rc1
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

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to all of the device properties patches in this series if that helps.

Thanks!
