Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51DE21080B
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2019 14:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfEAMxg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 May 2019 08:53:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:62613 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfEAMxg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 May 2019 08:53:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 05:53:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,417,1549958400"; 
   d="scan'208";a="320528458"
Received: from sbahirat-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.231.197])
  by orsmga005.jf.intel.com with ESMTP; 01 May 2019 05:53:34 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        devel@acpica.org (open list:ACPI COMPONENT ARCHITECTURE (ACPICA))
Subject: [PATCH v2] ACPI / device_sysfs: change _ADR representation to 64 bits
Date:   Wed,  1 May 2019 07:53:22 -0500
Message-Id: <20190501125322.23791-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Standards such as the MIPI DisCo for SoundWire 1.0 specification
assume the _ADR field is 64 bits.

_ADR is defined as an "Integer" represented as 64 bits since ACPI 2.0
released in 2002. The low levels already use _ADR as 64 bits, e.g. in
struct acpi_device_info.

This patch bumps the representation used for sysfs to 64 bits. To
avoid any compatibility/ABI issues, the printf format is only extended
to 16 characters when the actual _ADR value exceeds the 32 bit
maximum.

Example with a SoundWire device, the results show the complete
vendorID and linkID which were omitted before:

Before:
$ more /sys/bus/acpi/devices/device\:38/adr
0x5d070000
After:
$ more /sys/bus/acpi/devices/device\:38/adr
0x000010025d070000

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
v2: only use 64 bits when required to avoid compatibility issues
(feedback from Vinod and Rafael)

 drivers/acpi/device_sysfs.c | 6 ++++--
 include/acpi/acpi_bus.h     | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 8940054d6250..7dda0ee05cd1 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -428,8 +428,10 @@ static ssize_t acpi_device_adr_show(struct device *dev,
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
-	return sprintf(buf, "0x%08x\n",
-		       (unsigned int)(acpi_dev->pnp.bus_address));
+	if (acpi_dev->pnp.bus_address > 0xFFFFFFFF)
+		return sprintf(buf, "0x%016llx\n", acpi_dev->pnp.bus_address);
+	else
+		return sprintf(buf, "0x%08llx\n", acpi_dev->pnp.bus_address);
 }
 static DEVICE_ATTR(adr, 0444, acpi_device_adr_show, NULL);
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f7981751ac77..9075e28ea60a 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -230,7 +230,7 @@ struct acpi_device_dir {
 /* Plug and Play */
 
 typedef char acpi_bus_id[8];
-typedef unsigned long acpi_bus_address;
+typedef u64 acpi_bus_address;
 typedef char acpi_device_name[40];
 typedef char acpi_device_class[20];
 
-- 
2.17.1

