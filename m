Return-Path: <linux-acpi+bounces-714-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BD47CCE49
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 22:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0960280C8C
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 20:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941342E3EB
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F6430F9
	for <linux-acpi@vger.kernel.org>; Tue, 17 Oct 2023 20:12:49 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CE26FA9;
	Tue, 17 Oct 2023 13:12:46 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 25056178d9cded64; Tue, 17 Oct 2023 22:12:45 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 86C38666BCD;
	Tue, 17 Oct 2023 22:12:44 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 1/3] thermal: ACPI: Move the ACPI thermal library to drivers/acpi/
Date: Tue, 17 Oct 2023 22:05:23 +0200
Message-ID: <4539892.LvFx2qVVIh@kreacher>
In-Reply-To: <5740803.DvuYhMxLoT@kreacher>
References: <5740803.DvuYhMxLoT@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddugeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnheptddvfeegledvfedvveevhedvteeffeehvdeuiedukeeiledttefgvdeihffgteetnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI thermal library contains functions that can be used to
retrieve trip point temperature values through the platform firmware
for various types of trip points.  Each of these functions basically
evaluates a specific ACPI object, checks if the value produced by it
is reasonable and returns it (or THERMAL_TEMP_INVALID if anything
fails).

It made sense to hold it in drivers/thermal/ so long as it was only used
by the code in that directory, but since it is also going to be used by
the ACPI thermal driver, located in drivers/acpi/, move it to the latter
in order to keep the code related to evaluating ACPI objects defined in
the specification proper together.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/acpi/Kconfig                          |    4=20
 drivers/acpi/Makefile                         |    1=20
 drivers/acpi/thermal_lib.c                    |  116 +++++++++++++++++++++=
+++++
 drivers/thermal/Kconfig                       |    4=20
 drivers/thermal/Makefile                      |    1=20
 drivers/thermal/intel/Kconfig                 |    2=20
 drivers/thermal/intel/int340x_thermal/Kconfig |    2=20
 drivers/thermal/thermal_acpi.c                |  116 ---------------------=
=2D----
 include/linux/acpi.h                          |    7 +
 include/linux/thermal.h                       |    7 -
 10 files changed, 130 insertions(+), 130 deletions(-)

Index: linux-pm/drivers/thermal/intel/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/intel/Kconfig
+++ linux-pm/drivers/thermal/intel/Kconfig
@@ -85,7 +85,7 @@ config INTEL_BXT_PMIC_THERMAL
 config INTEL_PCH_THERMAL
 	tristate "Intel PCH Thermal Reporting Driver"
 	depends on X86 && PCI
=2D	select THERMAL_ACPI if ACPI
+	select ACPI_THERMAL_LIB if ACPI
 	help
 	  Enable this to support thermal reporting on certain intel PCHs.
 	  Thermal reporting device will provide temperature reading,
Index: linux-pm/drivers/thermal/intel/int340x_thermal/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/intel/int340x_thermal/Kconfig
+++ linux-pm/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -9,7 +9,7 @@ config INT340X_THERMAL
 	select THERMAL_GOV_USER_SPACE
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
=2D	select THERMAL_ACPI
+	select ACPI_THERMAL_LIB
 	select INTEL_SOC_DTS_IOSF_CORE
 	select INTEL_TCC
 	select PROC_THERMAL_MMIO_RAPL if POWERCAP
Index: linux-pm/drivers/acpi/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/acpi/Kconfig
+++ linux-pm/drivers/acpi/Kconfig
@@ -60,6 +60,10 @@ config ACPI_CCA_REQUIRED
 config ACPI_TABLE_LIB
 	bool
=20
+config ACPI_THERMAL_LIB
+       depends on THERMAL
+       bool
+
 config ACPI_DEBUGGER
 	bool "AML debugger interface"
 	select ACPI_DEBUG
Index: linux-pm/drivers/thermal/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/Kconfig
+++ linux-pm/drivers/thermal/Kconfig
@@ -76,10 +76,6 @@ config THERMAL_OF
 	  Say 'Y' here if you need to build thermal infrastructure
 	  based on device tree.
=20
=2Dconfig THERMAL_ACPI
=2D       depends on ACPI
=2D       bool
=2D
 config THERMAL_WRITABLE_TRIPS
 	bool "Enable writable trip points"
 	help
Index: linux-pm/drivers/acpi/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/acpi/Makefile
+++ linux-pm/drivers/acpi/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_ACPI_TAD)		+=3D acpi_tad.o
 obj-$(CONFIG_ACPI_PCI_SLOT)	+=3D pci_slot.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+=3D processor.o
 obj-$(CONFIG_ACPI)		+=3D container.o
+obj-$(CONFIG_ACPI_THERMAL_LIB)	+=3D thermal_lib.o
 obj-$(CONFIG_ACPI_THERMAL)	+=3D thermal.o
 obj-$(CONFIG_ACPI_PLATFORM_PROFILE) 	+=3D platform_profile.o
 obj-$(CONFIG_ACPI_NFIT)		+=3D nfit/
Index: linux-pm/drivers/thermal/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/Makefile
+++ linux-pm/drivers/thermal/Makefile
@@ -13,7 +13,6 @@ thermal_sys-$(CONFIG_THERMAL_NETLINK)		+
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+=3D thermal_hwmon.o
 thermal_sys-$(CONFIG_THERMAL_OF)		+=3D thermal_of.o
=2Dthermal_sys-$(CONFIG_THERMAL_ACPI)		+=3D thermal_acpi.o
=20
 # governors
 CFLAGS_gov_power_allocator.o			:=3D -I$(src)
Index: linux-pm/include/linux/acpi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -439,6 +439,13 @@ extern int acpi_blacklisted(void);
 extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
=20
+#ifdef CONFIG_ACPI_THERMAL_LIB
+int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *r=
et_temp);
+int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp=
);
+int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp);
+int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_tem=
p);
+#endif
+
 #ifdef CONFIG_ACPI_NUMA
 int acpi_map_pxm_to_node(int pxm);
 int acpi_get_node(acpi_handle handle);
Index: linux-pm/include/linux/thermal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -294,13 +294,6 @@ int thermal_zone_get_num_trips(struct th
=20
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
=20
=2D#ifdef CONFIG_THERMAL_ACPI
=2Dint thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int =
*ret_temp);
=2Dint thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_te=
mp);
=2Dint thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp);
=2Dint thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_t=
emp);
=2D#endif
=2D
 #ifdef CONFIG_THERMAL
 struct thermal_zone_device *thermal_zone_device_register_with_trips(
 					const char *type,
Index: linux-pm/drivers/acpi/thermal_lib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- /dev/null
+++ linux-pm/drivers/acpi/thermal_lib.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Linaro Limited
+ * Copyright 2023 Intel Corporation
+ *
+ * Library routines for populating a generic thermal trip point structure
+ * with data obtained by evaluating a specific object in the ACPI Namespac=
e.
+ */
+#include <linux/acpi.h>
+#include <linux/units.h>
+#include <linux/thermal.h>
+
+/*
+ * Minimum temperature for full military grade is 218=C2=B0K (-55=C2=B0C) =
and
+ * max temperature is 448=C2=B0K (175=C2=B0C). We can consider those value=
s as
+ * the boundaries for the [trips] temperature returned by the
+ * firmware. Any values out of these boundaries may be considered
+ * bogus and we can assume the firmware has no data to provide.
+ */
+#define TEMP_MIN_DECIK	2180
+#define TEMP_MAX_DECIK	4480
+
+static int thermal_acpi_trip_temp(struct acpi_device *adev, char *obj_name,
+				  int *ret_temp)
+{
+	unsigned long long temp;
+	acpi_status status;
+
+	status =3D acpi_evaluate_integer(adev->handle, obj_name, NULL, &temp);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(adev->handle, "%s evaluation failed\n", obj_name);
+		return -ENODATA;
+	}
+
+	if (temp >=3D TEMP_MIN_DECIK && temp <=3D TEMP_MAX_DECIK) {
+		*ret_temp =3D deci_kelvin_to_millicelsius(temp);
+	} else {
+		acpi_handle_debug(adev->handle, "%s result %llu out of range\n",
+				  obj_name, temp);
+		*ret_temp =3D THERMAL_TEMP_INVALID;
+	}
+
+	return 0;
+}
+
+/**
+ * thermal_acpi_active_trip_temp - Retrieve active trip point temperature
+ * @adev: Target thermal zone ACPI device object.
+ * @id: Active cooling level (0 - 9).
+ * @ret_temp: Address to store the retrieved temperature value on success.
+ *
+ * Evaluate the _ACx object for the thermal zone represented by @adev to o=
btain
+ * the temperature of the active cooling trip point corresponding to the a=
ctive
+ * cooling level given by @id.
+ *
+ * Return 0 on success or a negative error value on failure.
+ */
+int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *r=
et_temp)
+{
+	char obj_name[] =3D {'_', 'A', 'C', '0' + id, '\0'};
+
+	if (id < 0 || id > 9)
+		return -EINVAL;
+
+	return thermal_acpi_trip_temp(adev, obj_name, ret_temp);
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_active_trip_temp);
+
+/**
+ * thermal_acpi_passive_trip_temp - Retrieve passive trip point temperature
+ * @adev: Target thermal zone ACPI device object.
+ * @ret_temp: Address to store the retrieved temperature value on success.
+ *
+ * Evaluate the _PSV object for the thermal zone represented by @adev to o=
btain
+ * the temperature of the passive cooling trip point.
+ *
+ * Return 0 on success or -ENODATA on failure.
+ */
+int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
+{
+	return thermal_acpi_trip_temp(adev, "_PSV", ret_temp);
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_passive_trip_temp);
+
+/**
+ * thermal_acpi_hot_trip_temp - Retrieve hot trip point temperature
+ * @adev: Target thermal zone ACPI device object.
+ * @ret_temp: Address to store the retrieved temperature value on success.
+ *
+ * Evaluate the _HOT object for the thermal zone represented by @adev to o=
btain
+ * the temperature of the trip point at which the system is expected to be=
 put
+ * into the S4 sleep state.
+ *
+ * Return 0 on success or -ENODATA on failure.
+ */
+int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
+{
+	return thermal_acpi_trip_temp(adev, "_HOT", ret_temp);
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_hot_trip_temp);
+
+/**
+ * thermal_acpi_critical_trip_temp - Retrieve critical trip point temperat=
ure
+ * @adev: Target thermal zone ACPI device object.
+ * @ret_temp: Address to store the retrieved temperature value on success.
+ *
+ * Evaluate the _CRT object for the thermal zone represented by @adev to o=
btain
+ * the temperature of the critical cooling trip point.
+ *
+ * Return 0 on success or -ENODATA on failure.
+ */
+int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_tem=
p)
+{
+	return thermal_acpi_trip_temp(adev, "_CRT", ret_temp);
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_critical_trip_temp);
Index: linux-pm/drivers/thermal/thermal_acpi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_acpi.c
+++ /dev/null
@@ -1,116 +0,0 @@
=2D// SPDX-License-Identifier: GPL-2.0
=2D/*
=2D * Copyright 2023 Linaro Limited
=2D * Copyright 2023 Intel Corporation
=2D *
=2D * Library routines for populating a generic thermal trip point structure
=2D * with data obtained by evaluating a specific object in the ACPI Namesp=
ace.
=2D */
=2D#include <linux/acpi.h>
=2D#include <linux/units.h>
=2D#include <linux/thermal.h>
=2D
=2D/*
=2D * Minimum temperature for full military grade is 218=C2=B0K (-55=C2=B0C=
) and
=2D * max temperature is 448=C2=B0K (175=C2=B0C). We can consider those val=
ues as
=2D * the boundaries for the [trips] temperature returned by the
=2D * firmware. Any values out of these boundaries may be considered
=2D * bogus and we can assume the firmware has no data to provide.
=2D */
=2D#define TEMP_MIN_DECIK	2180
=2D#define TEMP_MAX_DECIK	4480
=2D
=2Dstatic int thermal_acpi_trip_temp(struct acpi_device *adev, char *obj_na=
me,
=2D				  int *ret_temp)
=2D{
=2D	unsigned long long temp;
=2D	acpi_status status;
=2D
=2D	status =3D acpi_evaluate_integer(adev->handle, obj_name, NULL, &temp);
=2D	if (ACPI_FAILURE(status)) {
=2D		acpi_handle_debug(adev->handle, "%s evaluation failed\n", obj_name);
=2D		return -ENODATA;
=2D	}
=2D
=2D	if (temp >=3D TEMP_MIN_DECIK && temp <=3D TEMP_MAX_DECIK) {
=2D		*ret_temp =3D deci_kelvin_to_millicelsius(temp);
=2D	} else {
=2D		acpi_handle_debug(adev->handle, "%s result %llu out of range\n",
=2D				  obj_name, temp);
=2D		*ret_temp =3D THERMAL_TEMP_INVALID;
=2D	}
=2D
=2D	return 0;
=2D}
=2D
=2D/**
=2D * thermal_acpi_active_trip_temp - Retrieve active trip point temperature
=2D * @adev: Target thermal zone ACPI device object.
=2D * @id: Active cooling level (0 - 9).
=2D * @ret_temp: Address to store the retrieved temperature value on succes=
s.
=2D *
=2D * Evaluate the _ACx object for the thermal zone represented by @adev to=
 obtain
=2D * the temperature of the active cooling trip point corresponding to the=
 active
=2D * cooling level given by @id.
=2D *
=2D * Return 0 on success or a negative error value on failure.
=2D */
=2Dint thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int =
*ret_temp)
=2D{
=2D	char obj_name[] =3D {'_', 'A', 'C', '0' + id, '\0'};
=2D
=2D	if (id < 0 || id > 9)
=2D		return -EINVAL;
=2D
=2D	return thermal_acpi_trip_temp(adev, obj_name, ret_temp);
=2D}
=2DEXPORT_SYMBOL_GPL(thermal_acpi_active_trip_temp);
=2D
=2D/**
=2D * thermal_acpi_passive_trip_temp - Retrieve passive trip point temperat=
ure
=2D * @adev: Target thermal zone ACPI device object.
=2D * @ret_temp: Address to store the retrieved temperature value on succes=
s.
=2D *
=2D * Evaluate the _PSV object for the thermal zone represented by @adev to=
 obtain
=2D * the temperature of the passive cooling trip point.
=2D *
=2D * Return 0 on success or -ENODATA on failure.
=2D */
=2Dint thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_te=
mp)
=2D{
=2D	return thermal_acpi_trip_temp(adev, "_PSV", ret_temp);
=2D}
=2DEXPORT_SYMBOL_GPL(thermal_acpi_passive_trip_temp);
=2D
=2D/**
=2D * thermal_acpi_hot_trip_temp - Retrieve hot trip point temperature
=2D * @adev: Target thermal zone ACPI device object.
=2D * @ret_temp: Address to store the retrieved temperature value on succes=
s.
=2D *
=2D * Evaluate the _HOT object for the thermal zone represented by @adev to=
 obtain
=2D * the temperature of the trip point at which the system is expected to =
be put
=2D * into the S4 sleep state.
=2D *
=2D * Return 0 on success or -ENODATA on failure.
=2D */
=2Dint thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
=2D{
=2D	return thermal_acpi_trip_temp(adev, "_HOT", ret_temp);
=2D}
=2DEXPORT_SYMBOL_GPL(thermal_acpi_hot_trip_temp);
=2D
=2D/**
=2D * thermal_acpi_critical_trip_temp - Retrieve critical trip point temper=
ature
=2D * @adev: Target thermal zone ACPI device object.
=2D * @ret_temp: Address to store the retrieved temperature value on succes=
s.
=2D *
=2D * Evaluate the _CRT object for the thermal zone represented by @adev to=
 obtain
=2D * the temperature of the critical cooling trip point.
=2D *
=2D * Return 0 on success or -ENODATA on failure.
=2D */
=2Dint thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_t=
emp)
=2D{
=2D	return thermal_acpi_trip_temp(adev, "_CRT", ret_temp);
=2D}
=2DEXPORT_SYMBOL_GPL(thermal_acpi_critical_trip_temp);




