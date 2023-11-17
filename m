Return-Path: <linux-acpi+bounces-1581-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F24D7EF2B5
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 13:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4981C204AB
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 12:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8113630F8E
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brl/NxHw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D81B129;
	Fri, 17 Nov 2023 03:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700219684; x=1731755684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k2EyQptTu6UwFV+ONjT/W1odmEoHOBwbS7iQPv5wHAw=;
  b=brl/NxHwKirK++Pz+v/6J24xnb+/Sr/WA3hgl/DV8bBCf2Orh+SyJVlW
   rjxcaoS2gjwPfi9XHuWI77cGpxWdViUHG2BBYdFYhwUC4KTGj27OPWll7
   U6AYz0Q5BuNEbPHQNSbmwLMabGcyDUDXpZ4Admge1y++PtqBnIGV6jt16
   s+rMm0fE7C08KIZ0qKphfM/4WHq/uE4ydSJl07hZfQR/x25Tyogk6XFUY
   MqadeilgcaWhRwjQYPSeUQkx90fP50/cvK/TjMT6Jli0RV9Pao+HoucKZ
   37N2Wmiqf8qOZEy4YB0cyHJAX+027qJXwmunOhs9xCOUS7xXbb0X7Htye
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="9941639"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="9941639"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 03:14:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="769201200"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="769201200"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 03:14:39 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id DDF87120F2A;
	Fri, 17 Nov 2023 13:14:36 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	rafael@kernel.org,
	jacopo.mondi@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH v2 4/7] media: Documentation: Improve camera sensor runtime PM documentation
Date: Fri, 17 Nov 2023 13:14:30 +0200
Message-Id: <20231117111433.1561669-5-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Endorse the use of pm_runtime_get_sync() in order to resume the device and
pm_runtime_get_if_active() to increment its usage_count if the device is
in RPM_ACTIVE state.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 .../driver-api/media/camera-sensor.rst        | 76 +++++++++++++------
 .../firmware-guide/acpi/non-d0-probe.rst      |  2 +
 2 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/Documentation/driver-api/media/camera-sensor.rst b/Documentation/driver-api/media/camera-sensor.rst
index 6456145f96ed..c1bb0de40189 100644
--- a/Documentation/driver-api/media/camera-sensor.rst
+++ b/Documentation/driver-api/media/camera-sensor.rst
@@ -58,35 +58,55 @@ pipeline. They must obey the rules listed herein to ensure coherent power
 management over the pipeline.
 
 Camera sensor drivers are responsible for controlling the power state of the
-device they otherwise control as well. They shall use runtime PM to manage
-power states. Runtime PM shall be enabled at probe time and disabled at remove
-time. Drivers should enable runtime PM autosuspend.
+device they otherwise control as well. They shall use runtime PM to manage power
+states. Runtime PM shall be enabled at probe time using
+:c:func:`pm_runtime_enable()` and disabled using :c:func:`pm_runtime_disable()`
+at remove time. Before enabling Runtime PM, the device's Runtime PM status is
+set to ``RPM_ACTIVE`` using :c:func:`pm_runtime_set_active()` and after
+disabling set to ``RPM_SUSPENDED`` using :c:func:`pm_runtime_set_suspended()`.
+Drivers should enable runtime PM autosuspend.
 
 The runtime PM handlers shall handle clocks, regulators, GPIOs, and other
 system resources required to power the sensor up and down. For drivers that
 don't use any of those resources (such as drivers that support ACPI systems
 only), the runtime PM handlers may be left unimplemented.
 
-In general, the device shall be powered on at least when its registers are
-being accessed and when it is streaming. Drivers should use
-``pm_runtime_resume_and_get()`` when starting streaming and
-``pm_runtime_put()`` or ``pm_runtime_put_autosuspend()`` when stopping
-streaming. They may power the device up at probe time (for example to read
+In general, the device shall be powered on at least when its registers are being
+accessed and when it is streaming. Drivers using autosuspend should use
+:c:func:`pm_runtime_get_sync()` to ensure the device is powered on.  The
+function increments Runtime PM ``usage_count`` which the driver is responsible
+for decrementing using e.g. :c:func:`pm_runtime_put_mark_busy_autosusp()`, which
+starts autosuspend timer to power off the device later on when its
+``usage_count`` is 0, or :c:func:`pm_runtime_put()` which proceeds to power off
+the device without a delay when its ``usage_count`` is 0.
+
+Note that runtime PM ``usage_count`` of the device must be put even if
+:c:func:`pm_runtime_get_sync()` fails. :c:func:`pm_runtime_get_sync()` returns 1
+if the device was already powered on, which may be used as a signal for the
+driver that initialisation related registers need to be written to the
+sensor.
+
+Drivers that support Devicetree shall also power on the device explicitly in
+driver's probe() function and power the device off in driver's remove() function
+without relying on Runtime PM.
+
+Drivers may power the device up at probe time (for example to read
 identification registers), but should not keep it powered unconditionally after
-probe.
+probe. On ACPI systems I²C devices are normally powered on for probe but
+:ref:`this can be avoided if needed <firmware_acpi_non_d0_probe>`.
 
 At system suspend time, the whole camera pipeline must stop streaming, and
 restart when the system is resumed. This requires coordination between the
 camera sensor and the rest of the camera pipeline. Bridge drivers are
 responsible for this coordination, and instruct camera sensors to stop and
-restart streaming by calling the appropriate subdev operations
-(``.s_stream()``, ``.enable_streams()`` or ``.disable_streams()``). Camera
-sensor drivers shall therefore **not** keep track of the streaming state to
-stop streaming in the PM suspend handler and restart it in the resume handler.
-Drivers should in general not implement the system PM handlers.
+restart streaming by calling the appropriate subdev operations (``.s_stream()``,
+``.enable_streams()`` or ``.disable_streams()``). Camera sensor drivers shall
+therefore **not** keep track of the streaming state to stop streaming in the PM
+suspend handler and restart it in the resume handler. Drivers should in general
+not implement the system PM handlers.
 
 Camera sensor drivers shall **not** implement the subdev ``.s_power()``
-operation, as it is deprecated. While this operation is implemented in some
+operation as it is deprecated. While this operation is implemented in some
 existing drivers as they predate the deprecation, new drivers shall use runtime
 PM instead. If you feel you need to begin calling ``.s_power()`` from an ISP or
 a bridge driver, instead add runtime PM support to the sensor driver you are
@@ -94,20 +114,26 @@ using and drop its ``.s_power()`` handler.
 
 Please also see :ref:`examples <media-camera-sensor-examples>`.
 
+.. _media_writing_camera_sensor_drives_control_framework:
+
 Control framework
 ~~~~~~~~~~~~~~~~~
 
 ``v4l2_ctrl_handler_setup()`` function may not be used in the device's runtime
-PM ``runtime_resume`` callback, as it has no way to figure out the power state
-of the device. This is because the power state of the device is only changed
-after the power state transition has taken place. The ``s_ctrl`` callback can be
-used to obtain device's power state after the power state transition:
-
-.. c:function:: int pm_runtime_get_if_in_use(struct device *dev);
-
-The function returns a non-zero value if it succeeded getting the power count or
-runtime PM was disabled, in either of which cases the driver may proceed to
-access the device.
+PM ``runtime_resume`` callback as it has no way to figure out the power state of
+the device. This is because the Runtime PM status of the device is only changed
+after the Runtime PM status transition has taken place. The ``s_ctrl`` callback
+can be used to obtain device's Runtime PM status once the transition has taken
+place:
+
+.. c:function:: int pm_runtime_get_if_active(struct device *dev);
+
+The function returns a non-zero value if the device is powered on (in which case
+it increments the device's ``usage_count``) or runtime PM was disabled, in
+either of which cases the driver may proceed to access the device. Note that the
+device's ``usage_count`` is not incremented if the function returns an error, in
+which case the ``usage_count`` also must not be put using
+:c:func:`pm_runtime_put()` or its variants.
 
 Rotation, orientation and flipping
 ----------------------------------
diff --git a/Documentation/firmware-guide/acpi/non-d0-probe.rst b/Documentation/firmware-guide/acpi/non-d0-probe.rst
index 815bcc8db69f..f0669059101f 100644
--- a/Documentation/firmware-guide/acpi/non-d0-probe.rst
+++ b/Documentation/firmware-guide/acpi/non-d0-probe.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. _firmware_acpi_non_d0_probe:
+
 ========================================
 Probing devices in other D states than 0
 ========================================
-- 
2.39.2


