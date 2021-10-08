Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258FE426E92
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Oct 2021 18:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhJHQYZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Oct 2021 12:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229681AbhJHQYY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Oct 2021 12:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633710148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LcIF1ATa5pMxZWD7XVYsx964hvOu7/ZW7mOWWqM4Eac=;
        b=DWd2rW55WSPmNaG59tH7uF1/fv+1iCc2wAduNLZcNNoDQhnLmcufaLoGh6IH8Dpf+Nxw4Y
        bKDZWbcobn9T6q5E2aRqw+wOveOtMb4VJVlJiPxSORvf0brSVGaBvxPBjrD60fpfq6npEQ
        kQrAhz/q1LbIiauD2F6epmBrWg4tq3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-Js1_vogPMRiS5BUD58g9-w-1; Fri, 08 Oct 2021 12:22:25 -0400
X-MC-Unique: Js1_vogPMRiS5BUD58g9-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A2E9117D670;
        Fri,  8 Oct 2021 16:21:59 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3985061140;
        Fri,  8 Oct 2021 16:21:23 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 00/12] Add support for X86/ACPI camera sensor/PMIC setup with clk and regulator platform data
Date:   Fri,  8 Oct 2021 18:21:09 +0200
Message-Id: <20211008162121.6628-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

This patch series is a rework/rewrite of Daniel Scally's earlier
attempts at adding support for camera sensor connected to a
TPS68470 PMIC on x86/ACPI devices.

The clk and regulator frameworks expect clk/regulator consumer-devices
to have info about the consumed clks/regulators described in the device's
fw_node, but on ACPI this info is missing.

This series worksaround this by providing platform_data with the info to
the TPS68470 clk/regulator MFD cells.

Patches 1 - 3 deal with a probe-ordering problem this introduces, since the
lookups are only registered when the provider-driver binds, trying to get
these clks/regulators before then results in a -ENOENT error for clks and
a dummy regulator for regulators. See the patches for more details.

Patch 4 adds a header file which adds tps68470_clk_platform_data and
tps68470_regulator_platform_data structs. The futher patches depend on
this new header file.

Patch 5 + 6 add the TPS68470 clk and regulator drivers

Patches 7 - 12 Modify the INT3472 driver which instantiates the MFD cells to
provide the necessary platform-data.

Assuming this series is acceptable to everyone, we need to talk about how
to merge this.

Rafael, can you provide an immutable branch with
"[PATCH 01/12] ACPI: Add has_unmet_acpi_deps() helper function"
on there? Then the media subsys-maintaines can merge that and then
merge patch 2 + 3 on top.

For "[PATCH 04/12] platform_data: Add linux/platform_data/tps68470.h file",
which all further patches depend on I plan to provide an immutable branch
myself (once it has been reviewed), which the clk / regulator maintainers
can then merge before merging the clk / regulator driver which depends on
this.

Regards,

Hans


Daniel Scally (1):
  platform/x86: int3472: Enable I2c daisy chain

Hans de Goede (11):
  ACPI: Add has_unmet_acpi_deps() helper function
  media: i2c: ov8865: Add an has_unmet_acpi_deps() check
  media: i2c: ov5693: Add an has_unmet_acpi_deps() check
  platform_data: Add linux/platform_data/tps68470.h file
  regulator: Introduce tps68470-regulator driver
  clk: Introduce clk-tps68470 driver
  platform/x86: int3472: Split into 2 drivers
  platform/x86: int3472: Add get_sensor_adev_and_name() helper
  platform/x86: int3472: Pass tps68470_clk_platform_data to the
    tps68470-regulator MFD-cell
  platform/x86: int3472: Pass tps68470_regulator_platform_data to the
    tps68470-regulator MFD-cell
  platform/x86: int3472: Call acpi_dev_clear_dependencies() on
    successful probe

 drivers/clk/Kconfig                           |   6 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-tps68470.c                    | 257 ++++++++++++++++++
 drivers/media/i2c/ov5693.c                    |   3 +
 drivers/media/i2c/ov8865.c                    |   3 +
 drivers/platform/x86/intel/int3472/Makefile   |   9 +-
 ...lk_and_regulator.c => clk_and_regulator.c} |   2 +-
 drivers/platform/x86/intel/int3472/common.c   |  82 ++++++
 .../{intel_skl_int3472_common.h => common.h}  |   6 +-
 ...ntel_skl_int3472_discrete.c => discrete.c} |  51 ++--
 .../intel/int3472/intel_skl_int3472_common.c  | 106 --------
 ...ntel_skl_int3472_tps68470.c => tps68470.c} |  88 +++++-
 drivers/platform/x86/intel/int3472/tps68470.h |  25 ++
 .../x86/intel/int3472/tps68470_board_data.c   | 118 ++++++++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/tps68470-regulator.c        | 194 +++++++++++++
 include/linux/acpi.h                          |  12 +
 include/linux/mfd/tps68470.h                  |  11 +
 include/linux/platform_data/tps68470.h        |  35 +++
 20 files changed, 873 insertions(+), 146 deletions(-)
 create mode 100644 drivers/clk/clk-tps68470.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_clk_and_regulator.c => clk_and_regulator.c} (99%)
 create mode 100644 drivers/platform/x86/intel/int3472/common.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_common.h => common.h} (94%)
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_discrete.c => discrete.c} (91%)
 delete mode 100644 drivers/platform/x86/intel/int3472/intel_skl_int3472_common.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_tps68470.c => tps68470.c} (58%)
 create mode 100644 drivers/platform/x86/intel/int3472/tps68470.h
 create mode 100644 drivers/platform/x86/intel/int3472/tps68470_board_data.c
 create mode 100644 drivers/regulator/tps68470-regulator.c
 create mode 100644 include/linux/platform_data/tps68470.h

-- 
2.31.1

