Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2230E748FC1
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 23:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjGEVbQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 17:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjGEVbO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 17:31:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00901982
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 14:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688592627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aNPcI727MEQr120xN4jIDjobzYcffFj0ReEYJ4IlPyI=;
        b=HvplbNmRfFM/2WHrptrShBdhN15b4fJ06mSGMqQZ+O5lULyzgPIpoow36L7jO0/3bT2+a3
        JqIKsckTAjbKRENf7h8r7p6hs+KHAHjepqbffgu4LJJiPychvJeIk4FggEkwFey8EOUheV
        S/+mVX6LLtW99vV4m5QyuboJpX6jPT8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-eWTu-zhFOZWxf2ZUWGweWQ-1; Wed, 05 Jul 2023 17:30:21 -0400
X-MC-Unique: eWTu-zhFOZWxf2ZUWGweWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B25B101A54E;
        Wed,  5 Jul 2023 21:30:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A1DA40C2063;
        Wed,  5 Jul 2023 21:30:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Kate Hsuan <hpa@redhat.com>,
        Hao Yao <hao.yao@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
        linux-media@vger.kernel.org
Subject: [PATCH v3 00/18] media: ipu-bridge: Shared with atomisp, rework VCM instantiation
Date:   Wed,  5 Jul 2023 23:29:52 +0200
Message-ID: <20230705213010.390849-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Here is v3 of my patch-series to make the atomisp code share the
ACPI -> sensor fwnode bridge code with the IPU3 (and IPU6 code).

This series also rework VCM instantiation, which was my
initial reason for unifying / sharing the code.

Rafael, this v3 now includes a small ACPI patch:
  ACPI: bus: Introduce acpi_match_acpi_device() function

It is probably easiest if you can give an ack for merging this
through the media tree. May we have your ack for this?

Sakari, I know that you have other pending patches depending
on this, patches 1-14 can be merged independent of the new
ACPI patch. Only the atomisp changes require that and those
can also be merged later.

Changes in v3:
- New patches:
  media: i2c: Add driver for DW9719 VCM
  ACPI: bus: Introduce acpi_match_acpi_device() function
  media: atomisp: csi2-bridge: Add dev_name() to acpi_handle_info() logging
  media: atomisp: csi2-bridge: Add support for VCM I2C-client instantiation
- media: atomisp: csi2-bridge: Switch to new common ipu_bridge_init():
  - Add a table with per sensor-HID atomisp_sensor_config settings
    for sensors which have lanes != 1 or which may have a VCM
    (VCM support is added in a follow-up patch)
  - Switch to acpi_handle_err() for logging errors
  - Set orientation based on CSI link/port

This set now consists of the following parts:

Patches 1-4  Bugfixes for recent changes
Patches 5-12 Cleanup / preparation patches
Patch 13     Rework how VCM client instantiation is done so that
             a device-link can be added from VCM to sensor to
             fix issues with the VCM power-state being tied to
             the sensor power state
Patch 14     Resubmit DW9719 VCM driver upstream now that Vsio hack is gone
Patch 15     New ACPI helper needed by atomisp bridge code
Patch 16     Drop ipu-bridge code copy from atomisp, switching to
             the shared ipu-bridge module
Patch 17-18  Further atomisp bridge code improvements

Changes in v2:
- Rebase on top of f54eb0ac7c1a ("media: ipu3-cio2: rename cio2 bridge
  to ipu bridge and move out of ipu3")
  (rebase on top of sailus/media_tree.git/for-6.6-1.4-signed)
- Share the ipu_supported_sensors[] array between atomisp and IPU3/IPU6
  (leave it in ipu-bridge.c instead of giving each consumer its own copy)
- 2 new bugfixes:
  media: ipu-bridge: Fix null pointer deref on SSDB/PLD parsing warnings  
  media: ipu-bridge: Allow building as module

Original cover-letter:

While working on adding (proper) VCM support to the atomisp code
I found myself copying yet more code from
drivers/media/pci/intel/ipu3/cio2-bridge.c into the atomisp code.

So I decided that it really was time to factor out the common code
(most of the code) from intel/ipu3/cio2-bridge.c into its own
helper library and then share it between the atomisp and IPU3 code.

This will hopefully also be useful for the ongoing work to upstream
IPU6 input system support which also needs this functionality and
currently contains a 3th copy of this code in the out of tree driver.

Regards,

Hans


Daniel Scally (1):
  media: i2c: Add driver for DW9719 VCM

Hans de Goede (17):
  media: ipu-bridge: Fix null pointer deref on SSDB/PLD parsing warnings
  media: ipu-bridge: Do not use on stack memory for software_node.name
    field
  media: ipu-bridge: Move initialization of node_names.vcm to
    ipu_bridge_init_swnode_names()
  media: ipu-bridge: Allow building as module
  media: ipu-bridge: Make ipu_bridge_init() take a regular struct device
    as argument
  media: ipu-bridge: Store dev pointer in struct ipu_bridge
  media: ipu-bridge: Only keep PLD around while parsing
  media: ipu-bridge: Add a ipu_bridge_parse_ssdb() helper function
  media: ipu-bridge: Drop early setting of sensor->adev
  media: ipu-bridge: Add a parse_sensor_fwnode callback to
    ipu_bridge_init()
  media: ipu-bridge: Move ipu-bridge.h to include/media/
  media: ipu-bridge: Add GalaxyCore GC0310 to ipu_supported_sensors[]
  media: ipu-bridge: Add a runtime-pm device-link between VCM and sensor
  ACPI: bus: Introduce acpi_match_acpi_device() function
  media: atomisp: csi2-bridge: Switch to new common ipu_bridge_init()
  media: atomisp: csi2-bridge: Add dev_name() to acpi_handle_info()
    logging
  media: atomisp: csi2-bridge: Add support for VCM I2C-client
    instantiation

 MAINTAINERS                                   |   7 +
 drivers/acpi/bus.c                            |  22 +-
 drivers/media/i2c/Kconfig                     |  11 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/dw9719.c                    | 427 ++++++++++++++++++
 drivers/media/pci/intel/Kconfig               |  18 +-
 drivers/media/pci/intel/ipu-bridge.c          | 333 ++++++++------
 drivers/media/pci/intel/ipu3/Kconfig          |  20 +
 drivers/media/pci/intel/ipu3/ipu3-cio2.c      |  10 +-
 drivers/staging/media/atomisp/Kconfig         |   3 +
 .../staging/media/atomisp/pci/atomisp_csi2.h  |  67 ---
 .../media/atomisp/pci/atomisp_csi2_bridge.c   | 424 ++++++-----------
 .../staging/media/atomisp/pci/atomisp_v4l2.c  |   1 +
 include/acpi/acpi_bus.h                       |   2 +
 .../pci/intel => include/media}/ipu-bridge.h  |  27 +-
 15 files changed, 851 insertions(+), 522 deletions(-)
 create mode 100644 drivers/media/i2c/dw9719.c
 rename {drivers/media/pci/intel => include/media}/ipu-bridge.h (80%)

-- 
2.41.0

