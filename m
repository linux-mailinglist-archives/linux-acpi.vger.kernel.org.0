Return-Path: <linux-acpi+bounces-1541-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7B77ECAA3
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 19:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50497281306
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A10C364B3
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frqu3lkc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F58E1A3;
	Wed, 15 Nov 2023 10:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700072334; x=1731608334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/V+4a6YBThcc56i41tofczUJdxwhFYsIxlS5sBR3VII=;
  b=frqu3lkcWZ2MFDbp/hKQ0TANfH5WsBbqJgk+qZWxRde1RJ/jhSr/JZoa
   4g5cjUztuo28zuZ24XjJ3eoMebCcFVAsOVuOb/wt+xJkXOxmAatrpFq4R
   HfoH3S3PAqbXsOs1z18vfwGh/GkjimiTURU/Xcbisqfi8Cu9NTZ5oau9a
   JV2MLy7dTugqIBFkXHW7mRg6ndfi9Oi3MS/1AbbnTzBAE/mBvXvxK3/HA
   veseXbrnGQCvZs7QPV+uWTN33arBf8jQtPCdbzoqo55PqDltStjHg9cQL
   SSD84XJgGBxAgtAk0hDflHr0LCyzZC1G96uo+fsS/V62d1sP02f+tBD8r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381321123"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="381321123"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:18:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="831014655"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="831014655"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:18:44 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 68ACD11FBD1;
	Wed, 15 Nov 2023 20:18:41 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	rafael@kernel.org,
	jacopo.mondi@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH 1/6] pm: runtime: Simplify pm_runtime_get_if_active() usage
Date: Wed, 15 Nov 2023 20:18:35 +0200
Message-Id: <20231115181840.1509046-2-sakari.ailus@linux.intel.com>
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

The majority of the callers currently using pm_runtime_get_if_active()
call it with ign_usage_count argument set to true. There's only one driver
using this feature (and natually implementation of
pm_runtime_get_if_in_use()).

To make this function more practical to use, remove the ign_usage_count
argument from the function. The main implementation is renamed as
__pm_runtime_get_conditional().

This function is expected to gain a large number of users in the future
--- camera sensor drivers using runtime autosuspend have a need to get the
device's usage_count conditionally if it is enabled. Most of these
currently use pm_runtime_get_if_in_use(), which is a bug.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/power/runtime_pm.rst      |  5 ++--
 drivers/base/power/runtime.c            |  9 ++++---
 drivers/gpu/drm/i915/intel_runtime_pm.c |  2 +-
 drivers/media/i2c/ccs/ccs-core.c        |  2 +-
 drivers/net/ipa/ipa_smp2p.c             |  2 +-
 drivers/pci/pci.c                       |  2 +-
 include/linux/pm_runtime.h              | 31 +++++++++++++++++++++----
 sound/hda/hdac_device.c                 |  2 +-
 8 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 65b86e487afe..da99379071a4 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -396,10 +396,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
       nonzero, increment the counter and return 1; otherwise return 0 without
       changing the counter
 
-  `int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);`
+  `int pm_runtime_get_if_active(struct device *dev);`
     - return -EINVAL if 'power.disable_depth' is nonzero; otherwise, if the
-      runtime PM status is RPM_ACTIVE, and either ign_usage_count is true
-      or the device's usage_count is non-zero, increment the counter and
+      runtime PM status is RPM_ACTIVE, increment the counter and
       return 1; otherwise return 0 without changing the counter
 
   `void pm_runtime_put_noidle(struct device *dev);`
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 4545669cb973..8b56468eca9d 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1175,7 +1175,7 @@ int __pm_runtime_resume(struct device *dev, int rpmflags)
 EXPORT_SYMBOL_GPL(__pm_runtime_resume);
 
 /**
- * pm_runtime_get_if_active - Conditionally bump up device usage counter.
+ * __pm_runtime_get_conditional - Conditionally bump up device usage counter.
  * @dev: Device to handle.
  * @ign_usage_count: Whether or not to look at the current usage counter value.
  *
@@ -1195,8 +1195,11 @@ EXPORT_SYMBOL_GPL(__pm_runtime_resume);
  *
  * The caller is responsible for decrementing the runtime PM usage counter of
  * @dev after this function has returned a positive value for it.
+ *
+ * This function is not intended to be called by drivers, use
+ * pm_runtime_get_if_active() or pm_runtime_get_if_in_use() instead.
  */
-int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count)
+int __pm_runtime_get_conditional(struct device *dev, bool ign_usage_count)
 {
 	unsigned long flags;
 	int retval;
@@ -1217,7 +1220,7 @@ int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count)
 
 	return retval;
 }
-EXPORT_SYMBOL_GPL(pm_runtime_get_if_active);
+EXPORT_SYMBOL_GPL(__pm_runtime_get_conditional);
 
 /**
  * __pm_runtime_set_status - Set runtime PM status of a device.
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
index 6d8e5e5c0cba..b163efe80975 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -434,7 +434,7 @@ static intel_wakeref_t __intel_runtime_pm_get_if_active(struct intel_runtime_pm
 		 * function, since the power state is undefined. This applies
 		 * atm to the late/early system suspend/resume handlers.
 		 */
-		if (pm_runtime_get_if_active(rpm->kdev, ignore_usecount) <= 0)
+		if (__pm_runtime_get_conditional(rpm->kdev, ignore_usecount) <= 0)
 			return 0;
 	}
 
diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 12e6f0a26fc8..45701a18c845 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -664,7 +664,7 @@ static int ccs_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
-	pm_status = pm_runtime_get_if_active(&client->dev, true);
+	pm_status = pm_runtime_get_if_active(&client->dev);
 	if (!pm_status)
 		return 0;
 
diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 5620dc271fac..cbf3d4761ce3 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -92,7 +92,7 @@ static void ipa_smp2p_notify(struct ipa_smp2p *smp2p)
 		return;
 
 	dev = &smp2p->ipa->pdev->dev;
-	smp2p->power_on = pm_runtime_get_if_active(dev, true) > 0;
+	smp2p->power_on = pm_runtime_get_if_active(dev) > 0;
 
 	/* Signal whether the IPA power is enabled */
 	mask = BIT(smp2p->enabled_bit);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59c01d68c6d5..d8d4abbc936f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2439,7 +2439,7 @@ static void pci_pme_list_scan(struct work_struct *work)
 			 * If the device is in a low power state it
 			 * should not be polled either.
 			 */
-			pm_status = pm_runtime_get_if_active(dev, true);
+			pm_status = pm_runtime_get_if_active(dev);
 			if (!pm_status)
 				continue;
 
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 7c9b35448563..810330bb802b 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -72,7 +72,8 @@ extern int pm_runtime_force_resume(struct device *dev);
 extern int __pm_runtime_idle(struct device *dev, int rpmflags);
 extern int __pm_runtime_suspend(struct device *dev, int rpmflags);
 extern int __pm_runtime_resume(struct device *dev, int rpmflags);
-extern int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);
+extern int __pm_runtime_get_conditional(struct device *dev,
+					bool ign_usage_count);
 extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
 extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
 extern int pm_runtime_barrier(struct device *dev);
@@ -94,16 +95,33 @@ extern void pm_runtime_release_supplier(struct device_link *link);
 
 extern int devm_pm_runtime_enable(struct device *dev);
 
+/**
+ * pm_runtime_get_if_active - Bump up runtime PM usage counter if the device is
+ *			      in active state
+ * @dev: Target device.
+ *
+ * Increment the runtime PM usage counter of @dev if its runtime PM status is
+ * %RPM_ACTIVE, in which case it returns 1. If the device is in a different
+ * state, 0 is returned. -EINVAL is returned if runtime PM is disabled for the
+ * device.
+ */
+static inline int pm_runtime_get_if_active(struct device *dev)
+{
+	return __pm_runtime_get_conditional(dev, true);
+}
+
 /**
  * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
  * @dev: Target device.
  *
  * Increment the runtime PM usage counter of @dev if its runtime PM status is
- * %RPM_ACTIVE and its runtime PM usage counter is greater than 0.
+ * %RPM_ACTIVE and its runtime PM usage counter is greater than 0, in which case
+ * it returns 1. If the device is in a different state or its usage_count is 0,
+ * 0 is returned. -EINVAL is returned if runtime PM is disabled for the device.
  */
 static inline int pm_runtime_get_if_in_use(struct device *dev)
 {
-	return pm_runtime_get_if_active(dev, false);
+	return __pm_runtime_get_conditional(dev, false);
 }
 
 /**
@@ -275,8 +293,11 @@ static inline int pm_runtime_get_if_in_use(struct device *dev)
 {
 	return -EINVAL;
 }
-static inline int pm_runtime_get_if_active(struct device *dev,
-					   bool ign_usage_count)
+static inline int pm_runtime_get_if_active(struct device *dev)
+{
+	return -EINVAL;
+}
+static inline int __pm_runtime_get_conditional(struct device *dev)
 {
 	return -EINVAL;
 }
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index bbf7bcdb449a..0a9223c18d77 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -611,7 +611,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_power_up_pm);
 int snd_hdac_keep_power_up(struct hdac_device *codec)
 {
 	if (!atomic_inc_not_zero(&codec->in_pm)) {
-		int ret = pm_runtime_get_if_active(&codec->dev, true);
+		int ret = pm_runtime_get_if_active(&codec->dev);
 		if (!ret)
 			return -1;
 		if (ret < 0)
-- 
2.39.2


