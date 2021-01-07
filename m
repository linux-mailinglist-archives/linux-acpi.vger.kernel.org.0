Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1912ED0AD
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbhAGN3f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGN3f (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:29:35 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA791C0612F4;
        Thu,  7 Jan 2021 05:28:54 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q18so5673721wrn.1;
        Thu, 07 Jan 2021 05:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QNHGMZS2NUiX1Xk/NdVhGu99XxfHMzdprSxRlNc93Ww=;
        b=OnsFhSwERDUIVv3XN6QNANI8nK0YBM1eOwPd0HTO3mLGJ9EtxVfaHzgLpGUd50OTXL
         FPNpq9J7YF+ggFVEl9zDWF1S9akpVsHeI1QNioS2nQUXS7JdlT5lEIoqNpCzMCaCxHFR
         1GxbKPMBmLkmFXT9xPCPF40wlN1M2dDpJevNghsZPz4yBRuzNr8QZOLEpBDpuRQRgJyw
         hZBYJWO+e2MC4azFlEesxUz8/8PBmAOORz7vrMPjut+/Cj21Wkgq0H2VKz5EhWEnL2/J
         Me4A2Cb1w9CIYJDMp+CfWzu9UEVqf05+hqiu6JqqJy+JPmuNwyY6MvrcGUuygy1DbELY
         t/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QNHGMZS2NUiX1Xk/NdVhGu99XxfHMzdprSxRlNc93Ww=;
        b=kObZFp6AsIcjj93EfM15Ni7IMWDKzrWt9WkluygYkEAXrj9zc4KfWFLPAznpqBI7aa
         VoGVUeohuclyW8FZ2SoDzckOs0QdAhVmuKn0LarX+5BcMBJSVUkoCcCv9QdjCD/cHK6h
         wmT+AfW+KOUOB/OMD+srxS6MGYHNjm8SqCkTRcuVWdThGLmgOxVWHB+9Zm6j2eRjg42L
         sL4ADuoEWP6k8Lb795tEVFAi9AHlUpgLhTIjdEUE0LtRLSEaYVrq+1y1guA8dAnZQaRL
         JZ+A68pL8Zb3/8yF+A+rIlYxE7QoNAEA0IsoWhM8e4SfdrrAYQ/mNlvanmTanKr8Y/cY
         BI5w==
X-Gm-Message-State: AOAM530dwroFCzgviDGedymXSmNDQgzzidWgnoxrwSkI5ucKsfO1e8q2
        lTjkzud0pD0JxHRO+ttJc4e7K7PjzNHaBMI0
X-Google-Smtp-Source: ABdhPJyh4bxO6TIyr1Xq3SymAlGxxbpR1nADjjXBHVxtpg4rKwlfT6yifCvOabu3IBZspXbYqbgWCw==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr8959663wrs.220.1610026133468;
        Thu, 07 Jan 2021 05:28:53 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o83sm7660125wme.21.2021.01.07.05.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:28:52 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, mchehab@kernel.org,
        sergey.senozhatsky@gmail.com
Cc:     yong.zhi@intel.com, sakari.ailus@linux.intel.com,
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
Subject: [PATCH v5 00/15] Add functionality to ipu3-cio2 driver allowing software_node connections to sensors on platforms designed for Windows
Date:   Thu,  7 Jan 2021 13:28:23 +0000
Message-Id: <20210107132838.396641-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Hello all

v4:
https://lore.kernel.org/linux-media/20210103231235.792999-1-djrscally@gmail.com/T/#m11b7cb977e1b73fba1e625c3d6a189e2943a7783
v3:
https://lore.kernel.org/linux-media/20201224010907.263125-1-djrscally@gmail.com/T/#m37b831bb2b406917d6db5da9acf9ed35df65d72d
v2:
https://lore.kernel.org/linux-media/20201217234337.1983732-1-djrscally@gmail.com/T/#md93fd090009b42a6a98aed892aff0d38cf07e0cd
v1:
https://lore.kernel.org/linux-media/20201130133129.1024662-1-djrscally@gmail.com/T/#m91934e12e3d033da2e768e952ea3b4a125ee3e67

This series is to start adding support for webcams on laptops with ACPI tables
designed for use with CIO2 on Windows. This series extends the ipu3-cio2
driver to allow for patching the firmware via software_nodes if endpoints
aren't defined by ACPI.

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
	- Rebased onto 5.11-rc1

Thanks
Dan

Andy Shevchenko (1):
  media: ipu3-cio2: Add headers that ipu3-cio2.h is direct user of

Daniel Scally (13):
  software_node: Fix refcounts in software_node_get_next_child()
  device property: Return true in fwnode_device_is_available for NULL
    ops
  device property: Call fwnode_graph_get_endpoint_by_id() for
    fwnode->secondary
  software_node: Enforce parent before child ordering of nodes arrays
  software_node: unregister software_nodes in reverse order
  device property: Define format macros for ports and endpoints
  lib/test_printf.c: Use helper function to unwind array of
    software_nodes
  ipu3-cio2: Add T: entry to MAINTAINERS
  ipu3-cio2: Rename ipu3-cio2.c
  media: v4l2-core: v4l2-async: Check sd->fwnode->secondary in
    match_fwnode()
  ACPI / bus: Add acpi_dev_get_next_match_dev() and helper macro
  media: v4l2-fwnode: Include v4l2_fwnode_bus_type
  ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver

Heikki Krogerus (1):
  software_node: Add support for fwnode_graph*() family of functions

 MAINTAINERS                                   |   2 +
 drivers/acpi/utils.c                          |  30 +-
 drivers/base/property.c                       |  15 +-
 drivers/base/swnode.c                         | 180 ++++++++--
 drivers/media/pci/intel/ipu3/Kconfig          |  18 +
 drivers/media/pci/intel/ipu3/Makefile         |   3 +
 drivers/media/pci/intel/ipu3/cio2-bridge.c    | 311 ++++++++++++++++++
 drivers/media/pci/intel/ipu3/cio2-bridge.h    | 125 +++++++
 .../ipu3/{ipu3-cio2.c => ipu3-cio2-main.c}    |  34 ++
 drivers/media/pci/intel/ipu3/ipu3-cio2.h      |  24 ++
 drivers/media/v4l2-core/v4l2-async.c          |   8 +
 drivers/media/v4l2-core/v4l2-fwnode.c         |  11 -
 include/acpi/acpi_bus.h                       |   7 +
 include/linux/fwnode.h                        |   7 +
 include/media/v4l2-fwnode.h                   |  22 ++
 lib/test_printf.c                             |   4 +-
 16 files changed, 763 insertions(+), 38 deletions(-)
 create mode 100644 drivers/media/pci/intel/ipu3/cio2-bridge.c
 create mode 100644 drivers/media/pci/intel/ipu3/cio2-bridge.h
 rename drivers/media/pci/intel/ipu3/{ipu3-cio2.c => ipu3-cio2-main.c} (98%)

-- 
2.25.1

