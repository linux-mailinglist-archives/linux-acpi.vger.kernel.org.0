Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FDD2E8EC5
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 00:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbhACXNf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jan 2021 18:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbhACXNf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2021 18:13:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C0EC061573;
        Sun,  3 Jan 2021 15:12:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w5so29981742wrm.11;
        Sun, 03 Jan 2021 15:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLb4fKNSG4SMrjIYJ+fA2rrhLatLlO6tz5eQrj9mj/Y=;
        b=Oxsft3URx40Eeicl5HxJl48+EJe7BCG0SkRJ3EZ8d+hrg+NrzDpdvjy1iJk7/78fd+
         eea3z7zTWVoFUWIwxW5layFdWG4SOmj50N0t5VLAYI/FPURU8mhtonoAgKFKnuC2m6d1
         EijPX1Z1vZWuHIKAVZM3QK/vMM2W3ZhqIfVIBXOsjPvAi9Q79hQbpQ43H9kJ7MCKkxTp
         Gf+JseEH5Si231GoewoXxxiKINfJOmX8BrtYygWz1Tw4MAA0aI5FFDl/b5h73M3oN/96
         pKK1A2zqXjmRRQZwgCgCx8x5YJkCtexelPVflQalnR9+h5tbeGW9nse2G6b91QmLCjhE
         erbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLb4fKNSG4SMrjIYJ+fA2rrhLatLlO6tz5eQrj9mj/Y=;
        b=S3qoVJhMutV6MbJtuxR+L4RWR9LEgMdT0mNffVlNJKHefJvVItTliVpKAXaJswqVQ+
         HMUSJ4hR3U/pG4c0Ej1/VfAl4Ai4vV4BFSL28uvwnyfgx04EOi8LaphYeeteikO4i0UR
         4UXwe/TzBgzi3PC3rEHACTAXPMzDldTW0RaerrZYtnBbaTZcQaYS69koDwPrHQXFMG88
         Qz63iQcYSrF3xyHLXd8ozzi1x6cQu9vKLlg8UP8LMpw/IgJDYL0yg9i1AUGTlI2Cre6i
         m+BGtmd7XeiFC2ygOfc8xbQEtGWtmgs1ewFu9VDTtEs+qvNEMYw8ydQMlwHQvR8IVMqd
         YsDg==
X-Gm-Message-State: AOAM530LavwyRAKKneCpCTf7vQoHvp1JGxLJUbuWZPUn5Z872QzVJ+7E
        9reSdWwGrZbq9WRPoYEg+pakiDkvZ8hm4VMv
X-Google-Smtp-Source: ABdhPJz3aFWlRA2eMStLumhKX3ObBEUO2LzYkUFC5o+EReoSvoKVx/+7pulhNKyaZs89AhRKny6fVw==
X-Received: by 2002:adf:82c8:: with SMTP id 66mr76691586wrc.420.1609715573686;
        Sun, 03 Jan 2021 15:12:53 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm32571018wme.11.2021.01.03.15.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:12:52 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        sergey.senozhatsky@gmail.com, mchehab@kernel.org
Cc:     lenb@kernel.org, yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org
Subject: [PATCH v4 00/15] Add functionality to ipu3-cio2 driver allowing software_node connections to sensors on platforms designed for Windows
Date:   Sun,  3 Jan 2021 23:12:20 +0000
Message-Id: <20210103231235.792999-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello all

v3:
https://lore.kernel.org/linux-media/20201224010907.263125-1-djrscally@gmail.com/T/#m37b831bb2b406917d6db5da9acf9ed35df65d72d
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

lib
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
	- Incorporated Andy's patch fixing the ipu3-cio2 header

More details of changes on each patch.

Thanks
Dan

Andy Shevchenko (1):
  media: ipu3-cio2: Add headers that ipu3-cio2.h is direct user of

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
 drivers/base/swnode.c                         | 181 +++++++++--
 drivers/media/pci/intel/ipu3/Kconfig          |  18 ++
 drivers/media/pci/intel/ipu3/Makefile         |   3 +
 drivers/media/pci/intel/ipu3/cio2-bridge.c    | 302 ++++++++++++++++++
 drivers/media/pci/intel/ipu3/cio2-bridge.h    | 125 ++++++++
 .../ipu3/{ipu3-cio2.c => ipu3-cio2-main.c}    |  33 ++
 drivers/media/pci/intel/ipu3/ipu3-cio2.h      |  24 ++
 drivers/media/v4l2-core/v4l2-async.c          |   8 +
 drivers/media/v4l2-core/v4l2-fwnode.c         |  11 -
 include/acpi/acpi_bus.h                       |   7 +
 include/linux/fwnode.h                        |   7 +
 include/media/v4l2-fwnode.h                   |  22 ++
 lib/test_printf.c                             |   4 +-
 16 files changed, 754 insertions(+), 38 deletions(-)
 create mode 100644 drivers/media/pci/intel/ipu3/cio2-bridge.c
 create mode 100644 drivers/media/pci/intel/ipu3/cio2-bridge.h
 rename drivers/media/pci/intel/ipu3/{ipu3-cio2.c => ipu3-cio2-main.c} (98%)

-- 
2.25.1

