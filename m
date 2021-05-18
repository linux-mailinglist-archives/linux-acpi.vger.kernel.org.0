Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEAB387050
	for <lists+linux-acpi@lfdr.de>; Tue, 18 May 2021 05:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243301AbhERDnC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 23:43:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:44199 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346297AbhERDnB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 May 2021 23:43:01 -0400
IronPort-SDR: 72j0DbcF5kV8ovqZSC5BSog3kQgAqoulMDFtzGihkzlKGaG6GlX+cTurYnVidsd2r+QnLKz4uK
 lLNHcGmyRROA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="197535485"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="197535485"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 20:41:28 -0700
IronPort-SDR: F4bch374bs5ASg4VRU8F+0ew/1K/h07FCOHF4obGMfUC+uAHtkc8OF9hrLK7s/GTMlwNa5Bqgj
 Gvlg1F6mZjHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="472724222"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga001.jf.intel.com with ESMTP; 17 May 2021 20:41:28 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] ACPI: DPTF: Add new PCH FIVR methods
Date:   Mon, 17 May 2021 20:41:19 -0700
Message-Id: <20210518034119.2116555-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some additional information is required for updating PCH FIVR values
upon WiFi channel changes.

New attributes added to the existing sysfs:
fivr_switching_freq_mhz	: Get the FIVR switching control frequency
			  using ACPI method GFCS. Refer to the
			  documentation for the equation.
fivr_switching_fault_status: Read the FIVR switching frequency control
			fault status. Uses ACPI method GFFS

ssc_clock_info : Presents SSC (spread spectrum clock) information for EMI
(Electro magnetic interference) control. Use ACPI method GEMI. Refer
to the description of GEMI method below.

GFFS
This ACPI method is used to read the FIVR switching frequency control
fault status.
Bits	Description
[0:0]	Fault status when set to 1
[31:1]	Reserved

GFCS
This ACPI method is used to read the FIVR switching control
frequency.
Bits	Description
[11:0]	Actual Frequency = value * XTAL_FREQ / 128
[31:12]	Reserved

GEMI
This ACPI method is used to read the programmed register value for EMI
(Electro magnetic interference) control.

Bits	Description
[7:0]	Sets clock spectrum spread percentage:
	0x00=0.2% , 0x3F=10%
	1 LSB = 0.1% increase in spread (for
	settings 0x01 thru 0x1C)
	1 LSB = 0.2% increase in spread (for
	settings 0x1E thru 0x3F)
[8]	When set to 1, enables spread
	spectrum clock
[9]	0: Triangle mode. FFC frequency
	walks around the Fcenter in a linear
	fashion
	1: Random walk mode. FFC frequency
	changes randomly within the SSC
	(Spread spectrum clock) range
[10]	0: No white noise. 1: Add white noise
	to spread waveform
[11]	When 1, future writes are ignored.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2
	Update documentation for fivr_switching_freq_mhz

 Documentation/ABI/testing/sysfs-platform-dptf | 42 +++++++++++++++++++
 drivers/acpi/dptf/dptf_pch_fivr.c             |  9 ++++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
index 141834342a4d..fe62f024eb93 100644
--- a/Documentation/ABI/testing/sysfs-platform-dptf
+++ b/Documentation/ABI/testing/sysfs-platform-dptf
@@ -111,3 +111,45 @@ Contact:	linux-acpi@vger.kernel.org
 Description:
 		(RW) The PCH FIVR (Fully Integrated Voltage Regulator) switching frequency in MHz,
 		when FIVR clock is 38.4MHz.
+
+What:		/sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/fivr_switching_freq_mhz
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Get the FIVR switching control frequency in MHz after applying equation
+		"fivr_switching_freq_mhz * XTAL_FREQ / 128". Here XTAL_FREQ is Crystal Oscillator frequency
+		in MHz, which is product specific.
+
+What:		/sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/fivr_switching_fault_status
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Read the FIVR switching frequency control fault status.
+
+What:		/sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/ssc_clock_info
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Presents SSC (spread spectrum clock) information for EMI
+		(Electro magnetic interference) control. This is a bit mask.
+		Bits	Description
+		[7:0]	Sets clock spectrum spread percentage:
+			0x00=0.2% , 0x3F=10%
+			1 LSB = 0.1% increase in spread (for
+			settings 0x01 thru 0x1C)
+			1 LSB = 0.2% increase in spread (for
+			settings 0x1E thru 0x3F)
+		[8]	When set to 1, enables spread
+			spectrum clock
+		[9]	0: Triangle mode. FFC frequency
+			walks around the Fcenter in a linear
+			fashion
+			1: Random walk mode. FFC frequency
+			changes randomly within the SSC
+			(Spread spectrum clock) range
+		[10]	0: No white noise. 1: Add white noise
+			to spread waveform
+		[11]	When 1, future writes are ignored.
diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index 5fca18296bf6..22c4ae0401ef 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -55,15 +55,24 @@ static ssize_t name##_store(struct device *dev,\
 
 PCH_FIVR_SHOW(freq_mhz_low_clock, GFC0)
 PCH_FIVR_SHOW(freq_mhz_high_clock, GFC1)
+PCH_FIVR_SHOW(ssc_clock_info, GEMI)
+PCH_FIVR_SHOW(fivr_switching_freq_mhz, GFCS)
+PCH_FIVR_SHOW(fivr_switching_fault_status, GFFS)
 PCH_FIVR_STORE(freq_mhz_low_clock, RFC0)
 PCH_FIVR_STORE(freq_mhz_high_clock, RFC1)
 
 static DEVICE_ATTR_RW(freq_mhz_low_clock);
 static DEVICE_ATTR_RW(freq_mhz_high_clock);
+static DEVICE_ATTR_RO(ssc_clock_info);
+static DEVICE_ATTR_RO(fivr_switching_freq_mhz);
+static DEVICE_ATTR_RO(fivr_switching_fault_status);
 
 static struct attribute *fivr_attrs[] = {
 	&dev_attr_freq_mhz_low_clock.attr,
 	&dev_attr_freq_mhz_high_clock.attr,
+	&dev_attr_ssc_clock_info.attr,
+	&dev_attr_fivr_switching_freq_mhz.attr,
+	&dev_attr_fivr_switching_fault_status.attr,
 	NULL
 };
 
-- 
2.27.0

