Return-Path: <linux-acpi+bounces-1538-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A997ECAA0
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 19:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF6C1C2093F
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8D1364BD
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGh9doLm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF621A4;
	Wed, 15 Nov 2023 10:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700072335; x=1731608335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RaEMyiauU/9JpJO6Nmz7wbzZ0ghxj71bUy55K9W8zM8=;
  b=LGh9doLmDrGQoqpU1Tjy3amxBVYGW7rNucEJwkB7wJcwlCL4cCLVYtD2
   ceEMydN3i7ZWKoy0ek06FkYd9wfG9SyNAliNv372ZuPg5C9rj9FykI99K
   cNyAQKMmkgG40us8QQK93NWay9vjeITQz9CM/8IFcohk8rq67g4mIx+q3
   EzxffiBDyjDZS1rfNJPiMFNiU21Y9lonrLtfrZxQHlfMkugAo7ArFikm/
   KkDsFlszNrcpogtNaQBoIfxdVGdUERXuNRX801+M2e0K6cpuiUHcsak5O
   olJAd+TpwDcf816JSxeNpDmboI9Mms6HJgzpZO9QocviMXP/CMICdvMAB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381321134"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="381321134"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:18:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="831014660"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="831014660"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:18:45 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 2B22A12022F;
	Wed, 15 Nov 2023 20:18:43 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	rafael@kernel.org,
	jacopo.mondi@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH 3/6] media: Documentation: Improve camera sensor runtime PM documentation
Date: Wed, 15 Nov 2023 20:18:37 +0200
Message-Id: <20231115181840.1509046-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115181840.1509046-1-sakari.ailus@linux.intel.com>
References: <20231115181840.1509046-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Endorse the use of pm_runtime_get_sync() in order to resume the device and
pm_runtime_get_if_active() to increment its usage_count if the device is
in RPM_ACTIVE state.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 .../driver-api/media/camera-sensor.rst        | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/driver-api/media/camera-sensor.rst b/Documentation/driver-api/media/camera-sensor.rst
index 6456145f96ed..a15c09f8347e 100644
--- a/Documentation/driver-api/media/camera-sensor.rst
+++ b/Documentation/driver-api/media/camera-sensor.rst
@@ -67,11 +67,23 @@ system resources required to power the sensor up and down. For drivers that
 don't use any of those resources (such as drivers that support ACPI systems
 only), the runtime PM handlers may be left unimplemented.
 
-In general, the device shall be powered on at least when its registers are
-being accessed and when it is streaming. Drivers should use
-``pm_runtime_resume_and_get()`` when starting streaming and
-``pm_runtime_put()`` or ``pm_runtime_put_autosuspend()`` when stopping
-streaming. They may power the device up at probe time (for example to read
+In general, the device shall be powered on at least when its registers are being
+accessed and when it is streaming. Drivers not using autosuspend should use
+:c:func:`pm_runtime_resume_and_get()` to ensure the device is powered on. The
+function increments Runtime PM usage_count which the driver is responsible for
+decrementing using e.g. :c:func:`pm_runtime_put()` in order to power off the
+device. Drivers using autosuspend in order to avoid needless powering the sensor
+off and on again, should use :c:func:`pm_runtime_get_sync()` and
+:c:func:`pm_runtime_put_mark_busy_autosusp()` respectively. Note that runtime PM
+usage_count of the device must be put even if :c:func:`pm_runtime_get_sync()`
+fails. :c:func:`pm_runtime_get_sync()` returns 1 if the device was already
+powered on.
+
+Drivers that support Devicetree shall also power on the device explicitly in
+driver's probe() function and power the device off in driver's remove() function
+without relying on Runtime PM.
+
+Drivers may power the device up at probe time (for example to read
 identification registers), but should not keep it powered unconditionally after
 probe.
 
@@ -103,11 +115,13 @@ of the device. This is because the power state of the device is only changed
 after the power state transition has taken place. The ``s_ctrl`` callback can be
 used to obtain device's power state after the power state transition:
 
-.. c:function:: int pm_runtime_get_if_in_use(struct device *dev);
+.. c:function:: int pm_runtime_get_if_active(struct device *dev);
 
 The function returns a non-zero value if it succeeded getting the power count or
 runtime PM was disabled, in either of which cases the driver may proceed to
-access the device.
+access the device. Note that the device's usage_count is not incremented if the
+function returns an error, in which case the usage_count also must not be put
+using pm_runtime_put() or its variants.
 
 Rotation, orientation and flipping
 ----------------------------------
-- 
2.39.2


