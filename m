Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659183AA4AF
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 21:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhFPTyy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 15:54:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:43250 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhFPTyx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 15:54:53 -0400
IronPort-SDR: IDZgJz9ValPFoo/TbxA9qbRr08tSaBhQuV5MQBSLUbMqfp6vb67DIbN6QLFQmR78bZ8bR0fZHG
 OFZFsSMqBuAw==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206284190"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="206284190"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 12:52:46 -0700
IronPort-SDR: 4PbMpYAmJ3K9aHs7Yq5kwP6O9WEYRNb0R37wplybeYW680U6YCazNwkOoaRJdVPjiaYiWxi3lF
 Gm6wk7B7xH7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="640123789"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jun 2021 12:52:45 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH -next] Revert "ACPI: DPTF: Add new PCH FIVR methods"
Date:   Wed, 16 Jun 2021 12:52:39 -0700
Message-Id: <20210616195239.1627552-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This reverts commit bab858b30cbe5619038dd68ab89be469fff9861e.

Some user reported issues with this change. Will resubmit for 5.15 cycle.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-platform-dptf | 42 -------------------
 drivers/acpi/dptf/dptf_pch_fivr.c             |  9 ----
 2 files changed, 51 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
index bce1b745fc56..141834342a4d 100644
--- a/Documentation/ABI/testing/sysfs-platform-dptf
+++ b/Documentation/ABI/testing/sysfs-platform-dptf
@@ -111,45 +111,3 @@ Contact:	linux-acpi@vger.kernel.org
 Description:
 		(RW) The PCH FIVR (Fully Integrated Voltage Regulator) switching frequency in MHz,
 		when FIVR clock is 38.4MHz.
-
-What:		/sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/fivr_switching_freq_mhz
-Date:		June, 2021
-KernelVersion:	v5.14
-Contact:	linux-acpi@vger.kernel.org
-Description:
-		(RO) PCH FIVR switching control frequency in the units of
-		XTAL_FREQ / 128, where XTAL_FREQ is the (product specific)
-		Crystal Oscillator frequency.
-
-What:		/sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/fivr_switching_fault_status
-Date:		June, 2021
-KernelVersion:	v5.14
-Contact:	linux-acpi@vger.kernel.org
-Description:
-		(RO) Read the FIVR switching frequency control fault status.
-
-What:		/sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/ssc_clock_info
-Date:		June, 2021
-KernelVersion:	v5.14
-Contact:	linux-acpi@vger.kernel.org
-Description:
-		(RO) Presents SSC (spread spectrum clock) information for EMI
-		(Electro magnetic interference) control. This is a bit mask.
-		Bits	Description
-		[7:0]	Sets clock spectrum spread percentage:
-			0x00=0.2% , 0x3F=10%
-			1 LSB = 0.1% increase in spread (for
-			settings 0x01 thru 0x1C)
-			1 LSB = 0.2% increase in spread (for
-			settings 0x1E thru 0x3F)
-		[8]	When set to 1, enables spread
-			spectrum clock
-		[9]	0: Triangle mode. FFC frequency
-			walks around the Fcenter in a linear
-			fashion
-			1: Random walk mode. FFC frequency
-			changes randomly within the SSC
-			(Spread spectrum clock) range
-		[10]	0: No white noise. 1: Add white noise
-			to spread waveform
-		[11]	When 1, future writes are ignored.
diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index 22c4ae0401ef..5fca18296bf6 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -55,24 +55,15 @@ static ssize_t name##_store(struct device *dev,\
 
 PCH_FIVR_SHOW(freq_mhz_low_clock, GFC0)
 PCH_FIVR_SHOW(freq_mhz_high_clock, GFC1)
-PCH_FIVR_SHOW(ssc_clock_info, GEMI)
-PCH_FIVR_SHOW(fivr_switching_freq_mhz, GFCS)
-PCH_FIVR_SHOW(fivr_switching_fault_status, GFFS)
 PCH_FIVR_STORE(freq_mhz_low_clock, RFC0)
 PCH_FIVR_STORE(freq_mhz_high_clock, RFC1)
 
 static DEVICE_ATTR_RW(freq_mhz_low_clock);
 static DEVICE_ATTR_RW(freq_mhz_high_clock);
-static DEVICE_ATTR_RO(ssc_clock_info);
-static DEVICE_ATTR_RO(fivr_switching_freq_mhz);
-static DEVICE_ATTR_RO(fivr_switching_fault_status);
 
 static struct attribute *fivr_attrs[] = {
 	&dev_attr_freq_mhz_low_clock.attr,
 	&dev_attr_freq_mhz_high_clock.attr,
-	&dev_attr_ssc_clock_info.attr,
-	&dev_attr_fivr_switching_freq_mhz.attr,
-	&dev_attr_fivr_switching_fault_status.attr,
 	NULL
 };
 
-- 
2.30.2

