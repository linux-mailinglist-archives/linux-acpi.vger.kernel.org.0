Return-Path: <linux-acpi+bounces-8424-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322AC986B26
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 05:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33ED1F233BD
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 03:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960E0185B55;
	Thu, 26 Sep 2024 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIZMkgbf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F2185935;
	Thu, 26 Sep 2024 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727319609; cv=none; b=GRmCBXd8bqn13P5eVDrR4IVDzFQiOcTQpVYiUJCr/nKJUS7djonVwZBZJg+LKALNQe1UxR96aXUfE+AhA7bpq7klftobbnaunfHwtsRRjKBsRzF5MIV5a1B4yUHb93ags5KhmieEtnOqPcluoB/E7LQzt0dmaaIhjVuVK7lwdhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727319609; c=relaxed/simple;
	bh=76u71rRNZF7OhwZgnbtAuqloFp7f92CXMWJRA3n6qmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMTw/TE8b7609/ztU0GA8HtVkqJ9ppSMOAQ0OX5uxevu2y/w0R+353JAyVAvNPW6w7I6n2eiL8huqBQ2bLR6OauMpUJQBYo7FoeIRGPJew1vP3IGKajLKXCZ9b6Eg1oy7Cq4KvvEm9IZvhYgCWilpOQ+JjLz3vsnPPvRDOX0hPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIZMkgbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D970CC4CEC3;
	Thu, 26 Sep 2024 03:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727319609;
	bh=76u71rRNZF7OhwZgnbtAuqloFp7f92CXMWJRA3n6qmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIZMkgbfTc5T58oBBADwsmWnxcvfTXZ7ltwbKUoQELjg+KPhKqxIC5BJhDUWYQxAN
	 Xe1ioH5eo57G3VPzoemBUxdMup0J21tbKRiyDf3MrBGV4W6P4GMKzVtb7iuWOBtEky
	 s48va1I1UjABIfwY6EZMU3mDEcGbHLC8FiNorViryKaS7hF78/hvz21lRQTiZzVhUV
	 zIGHQGX6Ao4ea6CLouTyEXIFSV24gbXWjSIoukh0wDFTKNHk56yrhS9+PKQd5v621l
	 9glVwosXRpX3yY0PAUmSY2BjTf+oYbO1Zq+22Zpv3nM7Hjwtek//zZd5PdZXj7l8qY
	 fsUlGIoOVb4Pw==
From: Mario Limonciello <superm1@kernel.org>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: platform-driver-x86@vger.kernel.org (open list:AMD PMF DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-acpi@vger.kernel.org (open list:ACPI),
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC 2/2] platform/x86/amd: pmf: Add manual control support
Date: Wed, 25 Sep 2024 21:59:55 -0500
Message-ID: <20240926025955.1728766-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926025955.1728766-1-superm1@kernel.org>
References: <20240926025955.1728766-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

A number of users resort to using reverse engineered software like
ryzenadj to manipulate debugging interfaces for modifying APU settings.

At a glance these tools are useful, but the problem is they break
state machines in other software such as the PMF driver or the OEM
EC.

Offer a knob for PMF to allow 'manual control' which will users can
directly change things like fPPT and sPPT. As this can be harmful for
a system to try to push limits outside of a thermal design, taint the
kernel and show a critical message when in use.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/ABI/testing/sysfs-amd-pmf | 10 +++
 drivers/platform/x86/amd/pmf/Makefile   |  1 +
 drivers/platform/x86/amd/pmf/core.c     |  9 +++
 drivers/platform/x86/amd/pmf/manual.c   | 88 +++++++++++++++++++++++++
 drivers/platform/x86/amd/pmf/pmf.h      |  5 ++
 drivers/platform/x86/amd/pmf/sps.c      |  4 ++
 6 files changed, 117 insertions(+)
 create mode 100644 drivers/platform/x86/amd/pmf/manual.c

diff --git a/Documentation/ABI/testing/sysfs-amd-pmf b/Documentation/ABI/testing/sysfs-amd-pmf
index 7fc0e1c2b76b..6f3d5cbf443f 100644
--- a/Documentation/ABI/testing/sysfs-amd-pmf
+++ b/Documentation/ABI/testing/sysfs-amd-pmf
@@ -11,3 +11,13 @@ Description:	Reading this file tells if the AMD Platform Management(PMF)
 		To turn off CnQF user can write "off" to the sysfs node.
 		Note: Systems that support auto mode will not have this sysfs file
 		available.
+
+What:		/sys/devices/platform/*/{spl, fppt, sppt, sppt_apu_only, stt_min, stt_limit_apu, stt_skip_temp}
+Date:		December 2024
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:	Manual control of AMD PMF APU coefficients
+		.
+		These files are used to manually control the APU coefficients.
+		In order to write to these files the module most be
+		loaded with manual_control=1 and the user must write "custom"
+		to the ACPI platform profile.
diff --git a/drivers/platform/x86/amd/pmf/Makefile b/drivers/platform/x86/amd/pmf/Makefile
index 7d6079b02589..81444d6f4428 100644
--- a/drivers/platform/x86/amd/pmf/Makefile
+++ b/drivers/platform/x86/amd/pmf/Makefile
@@ -7,4 +7,5 @@
 obj-$(CONFIG_AMD_PMF) += amd-pmf.o
 amd-pmf-objs := core.o acpi.o sps.o \
 		auto-mode.o cnqf.o \
+		manual.o \
 		tee-if.o spc.o pmf-quirks.o
diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index d6af0ca036f1..52a68ca094be 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -53,6 +53,10 @@ static bool force_load;
 module_param(force_load, bool, 0444);
 MODULE_PARM_DESC(force_load, "Force load this driver on supported older platforms (experimental)");
 
+bool pmf_manual_control;
+module_param_named(manual_control, pmf_manual_control, bool, 0444);
+MODULE_PARM_DESC(manual_control, "Expose manual control knobs (experimental)");
+
 static int amd_pmf_pwr_src_notify_call(struct notifier_block *nb, unsigned long event, void *data)
 {
 	struct amd_pmf_dev *pmf = container_of(nb, struct amd_pmf_dev, pwr_src_notifier);
@@ -349,6 +353,10 @@ static void amd_pmf_init_features(struct amd_pmf_dev *dev)
 		dev_dbg(dev->dev, "SPS enabled and Platform Profiles registered\n");
 	}
 
+	if (pmf_manual_control) {
+		amd_pmf_init_manual_control(dev);
+		return;
+	}
 	amd_pmf_init_smart_pc(dev);
 	if (dev->smart_pc_enabled) {
 		dev_dbg(dev->dev, "Smart PC Solution Enabled\n");
@@ -485,6 +493,7 @@ static void amd_pmf_remove(struct platform_device *pdev)
 
 static const struct attribute_group *amd_pmf_driver_groups[] = {
 	&cnqf_feature_attribute_group,
+	&manual_attribute_group,
 	NULL,
 };
 
diff --git a/drivers/platform/x86/amd/pmf/manual.c b/drivers/platform/x86/amd/pmf/manual.c
new file mode 100644
index 000000000000..b33fc3cd8d61
--- /dev/null
+++ b/drivers/platform/x86/amd/pmf/manual.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Platform Management Framework Driver
+ *
+ * Copyright (c) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Mario Limonciello <mario.limonciello@amd.com>
+ */
+
+#include "pmf.h"
+
+#define pmf_manual_attribute(_name, _set_command, _get_command)		\
+static ssize_t _name##_store(struct device *d,				\
+			     struct device_attribute *attr,		\
+			     const char *buf, size_t count)		\
+{									\
+	struct amd_pmf_dev *dev = dev_get_drvdata(d);			\
+	uint val;							\
+									\
+	if (dev->current_profile != PLATFORM_PROFILE_CUSTOM) {		\
+		dev_warn_once(dev->dev,					\
+			      "Manual control is disabled, please set "	\
+			      "platform profile to custom.\n");		\
+		return -EINVAL;						\
+	}								\
+									\
+	if (kstrtouint(buf, 10, &val) < 0)				\
+		return -EINVAL;						\
+									\
+	amd_pmf_send_cmd(dev, _set_command, false, val, NULL);		\
+									\
+	return count;							\
+}									\
+static ssize_t _name##_show(struct device *d,				\
+			   struct device_attribute *attr,		\
+			   char *buf)					\
+{									\
+	struct amd_pmf_dev *dev = dev_get_drvdata(d);			\
+	uint val;							\
+									\
+	amd_pmf_send_cmd(dev, _get_command, true, ARG_NONE, &val);	\
+									\
+	return sysfs_emit(buf, "%u\n", val);				\
+}
+
+pmf_manual_attribute(spl, SET_SPL, GET_SPL);
+static DEVICE_ATTR_RW(spl);
+pmf_manual_attribute(fppt, SET_FPPT, GET_FPPT);
+static DEVICE_ATTR_RW(fppt);
+pmf_manual_attribute(sppt, SET_SPPT, GET_SPPT);
+static DEVICE_ATTR_RW(sppt);
+pmf_manual_attribute(sppt_apu_only, SET_SPPT_APU_ONLY, GET_SPPT_APU_ONLY);
+static DEVICE_ATTR_RW(sppt_apu_only);
+pmf_manual_attribute(stt_min, SET_STT_MIN_LIMIT, GET_STT_MIN_LIMIT);
+static DEVICE_ATTR_RW(stt_min);
+pmf_manual_attribute(stt_limit_apu, SET_STT_LIMIT_APU, GET_STT_LIMIT_APU);
+static DEVICE_ATTR_RW(stt_limit_apu);
+pmf_manual_attribute(stt_skin_temp, SET_STT_LIMIT_HS2, GET_STT_LIMIT_HS2);
+static DEVICE_ATTR_RW(stt_skin_temp);
+
+static umode_t manual_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	return pmf_manual_control ? 0660 : 0;
+}
+
+static struct attribute *manual_attrs[] = {
+	&dev_attr_spl.attr,
+	&dev_attr_fppt.attr,
+	&dev_attr_sppt.attr,
+	&dev_attr_sppt_apu_only.attr,
+	&dev_attr_stt_min.attr,
+	&dev_attr_stt_limit_apu.attr,
+	&dev_attr_stt_skin_temp.attr,
+	NULL,
+};
+
+const struct attribute_group manual_attribute_group = {
+	.attrs = manual_attrs,
+	.is_visible = manual_attr_is_visible,
+};
+
+void amd_pmf_init_manual_control(struct amd_pmf_dev *dev)
+{
+	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	pr_crit("Manual PMF control is enabled, please disable it before "
+		"reporting any bugs unrelated to PMF.\n");
+}
diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
index 8ce8816da9c1..ca3df63cf190 100644
--- a/drivers/platform/x86/amd/pmf/pmf.h
+++ b/drivers/platform/x86/amd/pmf/pmf.h
@@ -798,4 +798,9 @@ void amd_pmf_dump_ta_inputs(struct amd_pmf_dev *dev, struct ta_pmf_enact_table *
 /* Quirk infrastructure */
 void amd_pmf_quirks_init(struct amd_pmf_dev *dev);
 
+/* Manual configuration */
+extern bool pmf_manual_control;
+extern const struct attribute_group manual_attribute_group;
+void amd_pmf_init_manual_control(struct amd_pmf_dev *dev);
+
 #endif /* PMF_H */
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 92f7fb22277d..6db88e523a86 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -305,6 +305,8 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
 	case PLATFORM_PROFILE_LOW_POWER:
 		mode = POWER_MODE_POWER_SAVER;
 		break;
+	case PLATFORM_PROFILE_CUSTOM:
+		return 0;
 	default:
 		dev_err(pmf->dev, "Unknown Platform Profile.\n");
 		return -EOPNOTSUPP;
@@ -412,6 +414,8 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 	set_bit(PLATFORM_PROFILE_LOW_POWER, dev->pprof.choices);
 	set_bit(PLATFORM_PROFILE_BALANCED, dev->pprof.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, dev->pprof.choices);
+	if (pmf_manual_control)
+		set_bit(PLATFORM_PROFILE_CUSTOM, dev->pprof.choices);
 
 	/* Create platform_profile structure and register */
 	err = platform_profile_register(&dev->pprof);
-- 
2.43.0


