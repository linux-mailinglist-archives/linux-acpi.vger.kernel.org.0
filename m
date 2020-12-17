Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A77A2DDBF6
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 00:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbgLQXoe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 18:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732201AbgLQXoe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 18:44:34 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F9C061794;
        Thu, 17 Dec 2020 15:43:53 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t16so246741wra.3;
        Thu, 17 Dec 2020 15:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UBqa0Lp+3ygWF6OGkOP1uHW2xoysiDViqe/7uQy1Q2c=;
        b=cEYYIywkMDxTUX7cW4KSyTS2FP1Gm5u6zdbSRyz9XE5nFKnajH0cak8KW6FwfluVn4
         qlZQw5PljRD+nMQIVe3vIx5UOxbVfNaV5oBef1CBnMWSj3YCutyw/hRY7p6Kq9l+ID+4
         LI8X/TLt1ntdFeXyqmORSPBDFYr9c3nayM2xoUOfuqEaMWK+u+nFNfvP++rMGm6y+6FW
         tTcF14+5gBOmMB8UmMqbDL82ob6pz/AwIH4JXdYzm6paYc3xSRDSCLLqa+lg571loPU6
         ylQraO6B0PDL3azcn+VFc8iIR9Q3IdLhWiAIc5MkmTdchxXo5uc1ynkLy8LEjLH4HVcZ
         6/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UBqa0Lp+3ygWF6OGkOP1uHW2xoysiDViqe/7uQy1Q2c=;
        b=P5gNUgsL5DQMq/zhm57qhNMu4POti8OkOOX43MEcsctblnUKVbZ4hT1yk53QzIariE
         CAlDB3ll6/9lquPOKhkatUbt8wu1W0Kf6L3dlgaXxkubm3r/yMZ4Axq+pXDk2MyVAFPa
         rioyTESBK7fOYKqNFsboRqVvXGHJ1je7s3vcWKKh7KzBC0AhAq/tF1FWexg/gfnqjSDu
         LayJONumkmBxVPMDXqPKger8hktssAbL08yBfLLGd1V3qD74FzWZ04XKsWKhpkARQI7S
         L8iKCFPIUrkB8DHpLlAcIWk59yRJcA+NWJF650jX7g5JFNlNjicXU6b/kCIDXYrk1yde
         D6DQ==
X-Gm-Message-State: AOAM530o54+/7oUZpR5P7uhIbKGOBtuTxJz6CSyy6Ony8KkFELOMF1Q5
        EJXK2lcfJqHoxMLrMWePePC5c3RCGAPG+ds6
X-Google-Smtp-Source: ABdhPJyKudBgqFd03IKg8iG672BcNf9NNDeb5mtZkBsdWzUVc+LJ4BDY6PIukgM8KKWdQkM+Y48bWQ==
X-Received: by 2002:a5d:4905:: with SMTP id x5mr1207091wrq.75.1608248632136;
        Thu, 17 Dec 2020 15:43:52 -0800 (PST)
Received: from valhalla.home ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id o3sm1873575wrc.93.2020.12.17.15.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:43:51 -0800 (PST)
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
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
Subject: [PATCH v2 00/12] Add functionality to ipu3-cio2 driver allowing software_node connections to sensors on platforms designed for Windows
Date:   Thu, 17 Dec 2020 23:43:25 +0000
Message-Id: <20201217234337.1983732-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello all

Previous version:
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

Given how few comments the remaining patches of this series received in the
last posting, I'm hopeful that most or all of it could get picked up for 5.12.
We touch a few different areas:

lib (with an ack already)
  lib/test_printf.c: Use helper function to unwind array of
    software_nodes

drivers/base
  software_node: Fix refcounts in software_node_get_next_child()
  property: Return true in fwnode_device_is_available for NULL ops
  property: Call fwnode_graph_get_endpoint_by_id() for fwnode->secondary
  software_node: Enforce parent before child ordering of nodes arrays
  software_node: unregister software_nodes in reverse order

drivers/acpi
  acpi: Add acpi_dev_get_next_match_dev() and helper macro

drivers/media
  media: v4l2-core: v4l2-async: Check sd->fwnode->secondary in
    match_fwnode()
  ipu3-cio2: Add T: entry to MAINTAINERS
  ipu3-cio2: Rename ipu3-cio2.c
  ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver

Given that, it feels sensible to me to try and merge them all through a single
tree; I was hoping the other maintainers would be amenable to having everything
merged through the media tree. Mauro; if that plan is ok (and of course assuming
that the rest of the patches are acked by their respective maintainers too),
could we get a dedicated feature branch just in case the following series ends
up being ready in time too? 

Series-level changelog:
	- Squashed the patches enforcing ordering in register/unregister_nodes()

More details of changes on each patch.

Comments as always very welcome - and thanks to everyone for all your help on
this so far, hope I've addressed everything from last time.

Dan

Daniel Scally (11):
  software_node: Fix refcounts in software_node_get_next_child()
  property: Return true in fwnode_device_is_available for NULL ops
  property: Call fwnode_graph_get_endpoint_by_id() for fwnode->secondary
  software_node: Enforce parent before child ordering of nodes arrays
  software_node: unregister software_nodes in reverse order
  lib/test_printf.c: Use helper function to unwind array of
    software_nodes
  ipu3-cio2: Add T: entry to MAINTAINERS
  ipu3-cio2: Rename ipu3-cio2.c
  media: v4l2-core: v4l2-async: Check sd->fwnode->secondary in
    match_fwnode()
  acpi: Add acpi_dev_get_next_match_dev() and helper macro
  ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver

Heikki Krogerus (1):
  software_node: Add support for fwnode_graph*() family of functions

 MAINTAINERS                                   |   2 +
 drivers/acpi/utils.c                          |  30 +-
 drivers/base/property.c                       |  15 +-
 drivers/base/swnode.c                         | 173 +++++++++--
 drivers/media/pci/intel/ipu3/Kconfig          |  18 ++
 drivers/media/pci/intel/ipu3/Makefile         |   3 +
 drivers/media/pci/intel/ipu3/cio2-bridge.c    | 274 ++++++++++++++++++
 drivers/media/pci/intel/ipu3/cio2-bridge.h    | 122 ++++++++
 .../ipu3/{ipu3-cio2.c => ipu3-cio2-main.c}    |  34 +++
 drivers/media/pci/intel/ipu3/ipu3-cio2.h      |   6 +
 drivers/media/v4l2-core/v4l2-async.c          |   8 +
 include/acpi/acpi_bus.h                       |   7 +
 lib/test_printf.c                             |   4 +-
 13 files changed, 669 insertions(+), 27 deletions(-)
 create mode 100644 drivers/media/pci/intel/ipu3/cio2-bridge.c
 create mode 100644 drivers/media/pci/intel/ipu3/cio2-bridge.h
 rename drivers/media/pci/intel/ipu3/{ipu3-cio2.c => ipu3-cio2-main.c} (98%)

-- 
2.25.1

