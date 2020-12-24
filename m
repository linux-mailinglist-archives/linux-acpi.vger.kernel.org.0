Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1812E2328
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 02:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgLXBKE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 20:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgLXBKD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 20:10:03 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2449CC061794;
        Wed, 23 Dec 2020 17:09:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 190so372654wmz.0;
        Wed, 23 Dec 2020 17:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=85WAM78v6JpSpQw5CQB3+QefTnZy1zV7OaxgUpVrsFU=;
        b=SeOWlAxL+Aka8nQP3YUEgbZLsCxR3VvdGadAd8ffa4W53Kcp3KLj3VVoSWm7O0PuNL
         qXjnAj5XYRmYkCW+RIqghDyrcIDCDDtRlBglb0QAvtDCU4ZX4kSrjJRKr5MV2CHOZdhZ
         7uSDbODohq8jmh+fLsxeZD6Q10qLkutL9qCZD8gvcJcSK0qG69HGPMdKQCwlsOA69DxN
         B6O4YHuEdFa98jz0wpJbxqplzgspQ84PgoH1qWQa2Zs6Vij255cEO40DJGFtMH9gpLfC
         ijXNlLVPh52aNkzwPR5W8aH/HVP1EJoDDZp4VnX/q/3JxF15YoF9IKFx8xPf6YSSetSn
         iLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=85WAM78v6JpSpQw5CQB3+QefTnZy1zV7OaxgUpVrsFU=;
        b=EDouQFgf/nQjSfKxULJik4Zt7M4BeWNgvLgMz7qSsPDcr+1tmGJScbFKa9EkFLyyEm
         WwXaofPoRJ6wDsjo/GxwVD0r7VPmP/yd9CilELZLIZmOnD/aG837SkwH+9iUJ3TkP9/s
         jENAyc1zfCWI7H4XfRT2pu/A/WfckoSK5QcUx6TzacQ1gHCWvLFdaxgUEm/sPP8+pHyP
         9vPcgLothFOtMqt8UMStiPRfaYE9lwNwe6wHNKoXy/rJmaVZzZAmtU1trPtsbpPNXNMZ
         k/sH5r9ZSWJ7yY6z1yGiKhJATKbhYfCufx/eUcA8pu9wJjcspRh6+rBZe/qj46wzAbSM
         caOA==
X-Gm-Message-State: AOAM530QZ4jSNfyFAVHpzqNiYIoJ3HRxCcHsTwvTqkLQAhJ4x20VQnzf
        d2JaOBVCp6ddlgMzX/PzvA6wtXB4ga5mwFMz
X-Google-Smtp-Source: ABdhPJwfnIA+Rhup+TZGpkaH1UkB17g8NtYGyHonyHM8Z/MuMP0XWi52q+P1UlQBdFc1wcm6GD1sDQ==
X-Received: by 2002:a1c:4904:: with SMTP id w4mr1933092wma.140.1608772161726;
        Wed, 23 Dec 2020 17:09:21 -0800 (PST)
Received: from valhalla.home ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b200sm1598653wmb.10.2020.12.23.17.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:20 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org
Subject: [PATCH v3 00/14] Add functionality to ipu3-cio2 driver allowing software_node connections to sensors on platforms designed for Windows
Date:   Thu, 24 Dec 2020 01:08:53 +0000
Message-Id: <20201224010907.263125-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello all

v2:
https://lore.kernel.org/linux-media/20201217234337.1983732-1-djrscally@gmail.com/T/#md93fd090009b42a6a98aed892aff0d38cf07e0cd
v1:
https://lore.kernel.org/linux-media/20201130133129.1024662-1-djrscally@gmail.com/T/#m91934e12e3d033da2e768e952ea3b4a125ee3e67
The RFC version before that:
https://lore.kernel.org/linux-media/20201019225903.14276-1-djrscally@gmail.com/

This series is to start adding support for webcams on laptops with ACPI tables
designed for use with CIO2 on Windows. This problem has two main parts; the
first part, which is handled in this series, is extending the ipu3-cio2
driver to allow for patching the firmware via software_nodes if endpoints
aren't defined by ACPI. The second is adding a new driver to handle power,
clocks and GPIO pins defined in DSDT tables in an awkward way. I decided to
split that second part out from this series, and instead give it its own
series (a v2 of which should land "soon"). The reasons for that are:

1. It's a logically separate change anyway
2. The recipients list was getting really long and
3. That probably meant that handling merge for all of this in one go was
   going to be impractically awkward.

I'm hopeful that most or all of this series could get picked up for 5.12.
We touch a few different areas (listed below), but I think the easiest
approach would be to merge everything through media tree. Rafael, Greg,
Mauro and Sergey; are you ok with that plan, or would you prefer a
different approach? Mauro; if that plan is ok (and of course assuming that
the rest of the patches are acked by their respective maintainers) could
we get a dedicated feature branch just in case the following series ends
up being ready in time too?

lib (with an ack already)
  lib/test_printf.c: Use helper function to unwind array of
    software_nodes

base
  software_node: Fix refcounts in software_node_get_next_child()
  property: Return true in fwnode_device_is_available for NULL ops
  property: Call fwnode_graph_get_endpoint_by_id() for fwnode->secondary
  software_node: Enforce parent before child ordering of nodes arrays
  software_node: unregister software_nodes in reverse order
  include: fwnode.h: Define format macros for ports and endpoints

acpi
  acpi: Add acpi_dev_get_next_match_dev() and helper macro

media
  media: v4l2-core: v4l2-async: Check sd->fwnode->secondary in
    match_fwnode()
  ipu3-cio2: Add T: entry to MAINTAINERS
  ipu3-cio2: Rename ipu3-cio2.c
  ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
  include: media: v4l2-fwnode: Include v4l2_fwnode_bus_type

Series-level changelog:
	- Added patch 13/14 to define an enum in media/v4l2-fwnode.h
	- Added patch 06/14 to define name formats for fwnode graph
	  ports and endpoints

More details of changes on each patch.

Merry Christmas everyone!

Dan

Daniel Scally (13):
  software_node: Fix refcounts in software_node_get_next_child()
  property: Return true in fwnode_device_is_available for NULL ops
  property: Call fwnode_graph_get_endpoint_by_id() for fwnode->secondary
  software_node: Enforce parent before child ordering of nodes arrays
  software_node: unregister software_nodes in reverse order
  include: fwnode.h: Define format macros for ports and endpoints
  lib/test_printf.c: Use helper function to unwind array of
    software_nodes
  ipu3-cio2: Add T: entry to MAINTAINERS
  ipu3-cio2: Rename ipu3-cio2.c
  media: v4l2-core: v4l2-async: Check sd->fwnode->secondary in
    match_fwnode()
  acpi: Add acpi_dev_get_next_match_dev() and helper macro
  include: media: v4l2-fwnode: Include v4l2_fwnode_bus_type
  ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver

Heikki Krogerus (1):
  software_node: Add support for fwnode_graph*() family of functions

 MAINTAINERS                                   |   2 +
 drivers/acpi/utils.c                          |  30 +-
 drivers/base/property.c                       |  15 +-
 drivers/base/swnode.c                         | 174 +++++++++--
 drivers/media/pci/intel/ipu3/Kconfig          |  18 ++
 drivers/media/pci/intel/ipu3/Makefile         |   3 +
 drivers/media/pci/intel/ipu3/cio2-bridge.c    | 272 ++++++++++++++++++
 drivers/media/pci/intel/ipu3/cio2-bridge.h    | 122 ++++++++
 .../ipu3/{ipu3-cio2.c => ipu3-cio2-main.c}    |  34 +++
 drivers/media/pci/intel/ipu3/ipu3-cio2.h      |   6 +
 drivers/media/v4l2-core/v4l2-async.c          |   8 +
 drivers/media/v4l2-core/v4l2-fwnode.c         |  11 -
 include/acpi/acpi_bus.h                       |   7 +
 include/linux/fwnode.h                        |  13 +
 include/media/v4l2-fwnode.h                   |  22 ++
 lib/test_printf.c                             |   4 +-
 16 files changed, 704 insertions(+), 37 deletions(-)
 create mode 100644 drivers/media/pci/intel/ipu3/cio2-bridge.c
 create mode 100644 drivers/media/pci/intel/ipu3/cio2-bridge.h
 rename drivers/media/pci/intel/ipu3/{ipu3-cio2.c => ipu3-cio2-main.c} (98%)

-- 
2.25.1

