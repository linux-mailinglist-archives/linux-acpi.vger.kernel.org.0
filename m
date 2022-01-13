Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E2548E0A3
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jan 2022 23:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiAMWrQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jan 2022 17:47:16 -0500
Received: from mga05.intel.com ([192.55.52.43]:38198 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238106AbiAMWrP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Jan 2022 17:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642114035; x=1673650035;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GHr99sUaS6FbIt+6PpfeffyY9527DwD06qutskOVWhw=;
  b=I5rCqtB+SelPVaxZsGxHN8MS+QV9IH42p/PfnbTEzmep8B0TPH6rYoG7
   /qJ3/TrN549+KFqBXdOCn4FoLWILrjWVHGsZLvLSJVlMcReTRmRHIvBK7
   fPvswq2kv9YuqQp2umTc7X9i39bTEd+pcx+yeSZWQ67fJ9nynaWST8z4A
   6ZRy4j+SKBhXgX+E2JY6SCR4nhrk+S30W7kZCdYtMrMphbt2lWYfP7SK+
   biRS6pGvPGEEUUHJvnWtz8GGsim57aB5W0LWKukrfIeD4qBRdBMk+H+7s
   F7BQ1IQHSDDdWiv4QoLOezqQqBIKd7kOzvyoGdFmKNWz/dPjYUVWI6qiQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="330476747"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="330476747"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 14:47:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="529885623"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga008.jf.intel.com with ESMTP; 13 Jan 2022 14:47:14 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] ACPI / fan: Properly handle fine grain control
Date:   Thu, 13 Jan 2022 14:47:13 -0800
Message-Id: <20220113224713.90092-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When _FIF object specifies support for fine grain control, then fan speed
can be set from 0 to 100% with the recommended minimum "step size" via
_FSL object. Here the control value doesn't need to match any value from
_FPS object.

Currently we have a simple solution implemented which just pick maximum
control value from _FPS to display the actual state, but this is not
optimal when there is a big window between two control values in
_FPS. Also there is no way to set to any speed which doesn't match
control values in _FPS. The system firmware can start the fan at speed
which doesn't match any control value.

To support fine grain control via thermal sysfs:
- cooling device max state is not _FPS state count but it will be
100 / _FIF.step_size
- cooling device current state is 100 / _FIF.step_size
- cooling device set state will set the control value
curr_state * _FIF.step_size plus any adjustment for 100%.
By the spec, when control value do not sum to 100% because of
_FIF.step_size, OSPM may select an appropriate ending Level increment
to reach 100%.

Also publish the actual fan rpm in sysfs in the same place where
_FIF objects are displayed. Knowing fan rpm is helpful to reduce noise
level and use passive control instead. Also fan performance may not be
same over time, so the same control value may not be enough to run the
fan at a speed. So a feedback value of speed is helpful. This sysfs
attribute is called "fan_speed_rpm".

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
This is not a urgent patch for the current merge cycle.

 .../acpi/fan_performance_states.rst           |  10 ++
 drivers/acpi/fan.c                            | 137 ++++++++++++++----
 2 files changed, 122 insertions(+), 25 deletions(-)

diff --git a/Documentation/admin-guide/acpi/fan_performance_states.rst b/Documentation/admin-guide/acpi/fan_performance_states.rst
index 98fe5c333121..2a5988d747e5 100644
--- a/Documentation/admin-guide/acpi/fan_performance_states.rst
+++ b/Documentation/admin-guide/acpi/fan_performance_states.rst
@@ -60,3 +60,13 @@ For example::
 
 When a given field is not populated or its value provided by the platform
 firmware is invalid, the "not-defined" string is shown instead of the value.
+
+ACPI Fan Performance Feedback
+=============================
+
+The optional _FST object provides status information for the fan device.
+This includes field to provide current fan speed in revolutions per minute
+at which the fan is rotating.
+
+This speed is presented in the sysfs using the attribute "fan_speed_rpm",
+in the same directory as performance states.
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 5cd0ceb50bc8..2fd3d22899b6 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -64,12 +64,19 @@ struct acpi_fan_fif {
 	u64 low_speed_notification;
 };
 
+struct acpi_fan_fst {
+	u64 revision;
+	u64 control;
+	u64 speed;
+};
+
 struct acpi_fan {
 	bool acpi4;
 	struct acpi_fan_fif fif;
 	struct acpi_fan_fps *fps;
 	int fps_count;
 	struct thermal_cooling_device *cdev;
+	struct device_attribute fst_speed;
 };
 
 static struct platform_driver acpi_fan_driver = {
@@ -89,20 +96,21 @@ static int fan_get_max_state(struct thermal_cooling_device *cdev, unsigned long
 	struct acpi_device *device = cdev->devdata;
 	struct acpi_fan *fan = acpi_driver_data(device);
 
-	if (fan->acpi4)
+	if (fan->fif.fine_grain_ctrl)
+		*state = 100 / fan->fif.step_size;
+	else if (fan->acpi4)
 		*state = fan->fps_count - 1;
 	else
 		*state = 1;
+
 	return 0;
 }
 
-static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
+static int fan_get_fps(struct acpi_device *device, struct acpi_fan_fst *fst)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_fan *fan = acpi_driver_data(device);
 	union acpi_object *obj;
 	acpi_status status;
-	int control, i;
 
 	status = acpi_evaluate_object(device->handle, "_FST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -119,31 +127,51 @@ static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
 		goto err;
 	}
 
-	control = obj->package.elements[1].integer.value;
+	fst->revision = obj->package.elements[0].integer.value;
+	fst->control = obj->package.elements[1].integer.value;
+	fst->speed = obj->package.elements[2].integer.value;
+
+	status = 0;
+err:
+	kfree(obj);
+	return status;
+}
+
+static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
+{
+	struct acpi_fan *fan = acpi_driver_data(device);
+	struct acpi_fan_fst fst;
+	int status;
+	int control, i;
+
+	status = fan_get_fps(device, &fst);
+	if (status)
+		return status;
+
+	control = fst.control;
+
+	if (fan->fif.fine_grain_ctrl) {
+		/* This control should be same what we set using _FSL by spec */
+		if (control > 100) {
+			dev_dbg(&device->dev, "Invalid control value returned\n");
+			return -EINVAL;
+		}
+
+		*state = control / fan->fif.step_size;
+		return 0;
+	}
+
 	for (i = 0; i < fan->fps_count; i++) {
-		/*
-		 * When Fine Grain Control is set, return the state
-		 * corresponding to maximum fan->fps[i].control
-		 * value compared to the current speed. Here the
-		 * fan->fps[] is sorted array with increasing speed.
-		 */
-		if (fan->fif.fine_grain_ctrl && control < fan->fps[i].control) {
-			i = (i > 0) ? i - 1 : 0;
-			break;
-		} else if (control == fan->fps[i].control) {
+		if (control == fan->fps[i].control)
 			break;
-		}
 	}
 	if (i == fan->fps_count) {
 		dev_dbg(&device->dev, "Invalid control value returned\n");
-		status = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	*state = i;
 
-err:
-	kfree(obj);
 	return status;
 }
 
@@ -187,12 +215,36 @@ static int fan_set_state_acpi4(struct acpi_device *device, unsigned long state)
 {
 	struct acpi_fan *fan = acpi_driver_data(device);
 	acpi_status status;
+	u64 value = state;
+	int max_state;
+
+	if (fan->fif.fine_grain_ctrl)
+		max_state = 100 / fan->fif.step_size;
+	else
+		max_state = fan->fps_count - 1;
 
-	if (state >= fan->fps_count)
+	if (state > max_state)
 		return -EINVAL;
 
-	status = acpi_execute_simple_method(device->handle, "_FSL",
-					    fan->fps[state].control);
+	if (fan->fif.fine_grain_ctrl) {
+		int rem;
+
+		value *= fan->fif.step_size;
+
+		/*
+		 * In the event OSPM’s incremental selections of Level
+		 * using the StepSize field value do not sum to 100%,
+		 * OSPM may select an appropriate ending Level
+		 * increment to reach 100%.
+		 */
+		rem = 100 - value;
+		if (rem && rem < fan->fif.step_size)
+			value = 100;
+	} else {
+		value = fan->fps[state].control;
+	}
+
+	status = acpi_execute_simple_method(device->handle, "_FSL", value);
 	if (ACPI_FAILURE(status)) {
 		dev_dbg(&device->dev, "Failed to set state by _FSL\n");
 		return status;
@@ -258,6 +310,9 @@ static int acpi_fan_get_fif(struct acpi_device *device)
 		status = -EINVAL;
 	}
 
+	/* If there is a bug in step size and set as 0, change to 1 */
+	if (!fan->fif.step_size)
+		fan->fif.step_size = 1;
 err:
 	kfree(obj);
 	return status;
@@ -303,6 +358,19 @@ static ssize_t show_state(struct device *dev, struct device_attribute *attr, cha
 	return count;
 }
 
+static ssize_t show_fan_speed(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct acpi_device *acpi_dev = container_of(dev, struct acpi_device, dev);
+	struct acpi_fan_fst fst;
+	int status;
+
+	status = fan_get_fps(acpi_dev, &fst);
+	if (status)
+		return status;
+
+	return sprintf(buf, "%lld\n", fst.speed);
+}
+
 static int acpi_fan_get_fps(struct acpi_device *device)
 {
 	struct acpi_fan *fan = acpi_driver_data(device);
@@ -311,15 +379,25 @@ static int acpi_fan_get_fps(struct acpi_device *device)
 	acpi_status status;
 	int i;
 
+	/* _FST is present if we are here */
+	sysfs_attr_init(&fan->fst_speed.attr);
+	fan->fst_speed.show = show_fan_speed;
+	fan->fst_speed.store = NULL;
+	fan->fst_speed.attr.name = "fan_speed_rpm";
+	fan->fst_speed.attr.mode = 0444;
+	status = sysfs_create_file(&device->dev.kobj, &fan->fst_speed.attr);
+	if (status)
+		return status;
+
 	status = acpi_evaluate_object(device->handle, "_FPS", NULL, &buffer);
 	if (ACPI_FAILURE(status))
-		return status;
+		goto rem_attr;
 
 	obj = buffer.pointer;
 	if (!obj || obj->type != ACPI_TYPE_PACKAGE || obj->package.count < 2) {
 		dev_err(&device->dev, "Invalid _FPS data\n");
 		status = -EINVAL;
-		goto err;
+		goto rem_attr;
 	}
 
 	fan->fps_count = obj->package.count - 1; /* minus revision field */
@@ -366,8 +444,17 @@ static int acpi_fan_get_fps(struct acpi_device *device)
 		}
 	}
 
+	if (status)
+		goto err;
+
+	return 0;
+
 err:
 	kfree(obj);
+
+rem_attr:
+	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
+
 	return status;
 }
 
-- 
2.25.1

