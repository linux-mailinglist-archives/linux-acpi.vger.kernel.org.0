Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9803729E48
	for <lists+linux-acpi@lfdr.de>; Fri, 24 May 2019 20:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfEXSo3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 May 2019 14:44:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36270 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfEXSo3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 May 2019 14:44:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so5510470pgb.3;
        Fri, 24 May 2019 11:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DEKp3R9bzWITm6m4VOnqiAhUVI7e2LB8OiUJABzyZx8=;
        b=qxKDRoU1G/mwIWP7uUuNzzAmD7D6dvoYgB9hhTNPyWsq9qxRGRTqyNXnjGTkleh1Tp
         VQOZVd78RCsDy8Z97aLIcvGcbiBNaNCo20PZrlvbM1rvJ4I71Ol8JJhK2RIGzbcfAMNc
         4aFBhpo2Dv2EL0mqtr7BgBYoBT1N4MCcUWvxUUds55z3J1EDk12Sax4tmU2nA+oOEtLk
         3vnUnThFId83WEpuUWgqydw0So8PHlZr32Eo7ggJ6ai6usGJYhhMMJD3xP1kR0nTM67W
         9/89lkAuDy+BMq9xfh01KiNUFn0UgLC6PI9D6b0AlLwTO8WYDO8J4QVVN7PJ9uP4FIJE
         DhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEKp3R9bzWITm6m4VOnqiAhUVI7e2LB8OiUJABzyZx8=;
        b=YwSmGPjSAigBINQS5VwLv1vyD5J9EnKi2Gbek6HPxowH3jXLctcGcm04g37RG165dd
         7HpFtt4Pd1SYRasUYm9lNVNVcb+pGKxPo+d4rlQ7w6H6b8OxuZ3N3VTGk4qK4Mj0KT+i
         aCZ35n45kA/gkKuxAVUrzT8G916G+GIuUdgGRQ/KN8ip8NbRJBC5t5mKkwKveiUIVPpD
         rleRsBKzxBL0OMZk5ViL8n7u06PVXjCICJ1D9qo11rhKJGPMKwqfXI77OMDh5eefAXM5
         iqqj3g00oYmM6n5Mm6DQri9URNeFSX0fMZNvjmfAs7IHwrVdOTip2DcQnKEtDe0ufcv7
         GtFQ==
X-Gm-Message-State: APjAAAWfRKvD6PGbUXb+Du3nk3i20WYiBMSLQ171/wIRhgS3PvG6mhOz
        WKgopgGhvIG5PDw4Vr0gmPGVfv+Ewc3i5ERSxg7xRgB7EM0=
X-Google-Smtp-Source: APXvYqz7sGEKbs0+Ma3aDEulBrlqCsNX+W3IUJLVBSwDvswP70eniWkTfxtGATVQV4azjI2DmKfSU2jLiy8X/7+Hslk=
X-Received: by 2002:a17:90a:778b:: with SMTP id v11mr11447669pjk.132.1558723467843;
 Fri, 24 May 2019 11:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 May 2019 21:44:17 +0300
Message-ID: <CAHp75VcvpoUhOnB1fLBY9G_L6R8SJBCjn+tYFdTo37GuHFKcyQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] Software fwnode references
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 22, 2019 at 1:51 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> I'm not splitting this series in two after all. After thinking about
> this for some time, I decided to add support for static software
> nodes. I did not want to support them because I don't want to make it
> easy to maintain board files, but in end they make the use of the
> software nodes so much more easier compared to if we always had to
> dynamically allocate them that it's a no-brainer. The references can
> now be also described statically. Actually, those can now only be
> described statically.
>
> Hans! I applied (hopefully) all of the fixes you proposed in v3. I
> hope you have time to test these.
>
> Here's the cover letter from v3:
>
> This is the third version of my proposal to add reference handling to
> the software node code. In this version I renamed ACPI_NAME_SIZE to
> ACPI_NAMESEG_SIZE in 6/13, and slit patch 9/13 in two separate patches
> (9/13 and 10/13) as suggested by Andy. Patch 9/13 will now only move
> the registration of max17047 out of probe, and 10/13 will introduce
> the software nodes.
>
> v2 cover letter:
>
> This is the second version of this series. In this version I'm
> introducing a new helper device_find_child_by_name() as proposed
> by Andy. Andy requested also another helper that could be used for
> chaining the fwnodes, but I decided not to add that now. I would like
> to still think about how we should handle exceptions like if there
> already is a secondary node assigned for a node.
>
> v1 cover letter:
>
> This series adds support for software fwnode reference handling. In
> practice it means making fwnode_property_get_reference_args() function
> usable in the drivers also with software nodes. I send the series
> originally as RFC [1].
>
> As the first user for the software node references, I'm converting
> intel_cht_int33fe.c to use them as part of the series.
>
> [1] https://lkml.org/lkml/2019/3/15/457
>

For PDx86 bits,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Assuming it will go thru some other tree.

> thanks,
>
> Heikki Krogerus (16):
>   software node: Allow node creation without properties
>   software node: Simplify software_node_release() function
>   software node: Add support for static node descriptors
>   software node: Use kobject name when finding child nodes by name
>   software node: Add software_node_get_reference_args()
>   driver core: Add helper device_find_child_by_name()
>   ACPI / property: Don't limit named child node matching to data nodes
>   device property: Introduce fwnode_find_reference()
>   device connection: Find connections also by checking the references
>   usb: typec: Registering real device entries for the muxes
>   platform/x86: intel_cht_int33fe: Register max17047 in its own function
>   platform/x86: intel_cht_int33fe: Remove unused fusb302 device property
>   platform/x86: intel_cht_int33fe: Provide software nodes for the
>     devices
>   platform/x86: intel_cht_int33fe: Provide fwnode for the USB connector
>   platform/x86: intel_cht_int33fe: Supply fwnodes for the external
>     dependencies
>   platform/x86: intel_cht_int33fe: Replacing the old connections with
>     references
>
>  drivers/acpi/property.c                  |  26 +-
>  drivers/base/core.c                      |  28 ++
>  drivers/base/devcon.c                    |  26 ++
>  drivers/base/property.c                  |  24 ++
>  drivers/base/swnode.c                    | 324 +++++++++++++++++------
>  drivers/platform/x86/intel_cht_int33fe.c | 290 ++++++++++++++++----
>  drivers/usb/roles/class.c                |   2 +-
>  drivers/usb/typec/bus.h                  |  15 ++
>  drivers/usb/typec/class.c                |  17 +-
>  drivers/usb/typec/mux.c                  | 238 ++++++++++++-----
>  drivers/usb/typec/mux/pi3usb30532.c      |  46 ++--
>  include/linux/device.h                   |   2 +
>  include/linux/property.h                 |  51 ++++
>  include/linux/usb/typec_mux.h            |  62 ++---
>  14 files changed, 902 insertions(+), 249 deletions(-)
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
