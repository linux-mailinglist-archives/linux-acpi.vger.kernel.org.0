Return-Path: <linux-acpi+bounces-711-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3647CCE43
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 22:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5041C20AE0
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 20:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C53D2E3F2
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB0C430EE
	for <linux-acpi@vger.kernel.org>; Tue, 17 Oct 2023 20:12:47 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58156FAA;
	Tue, 17 Oct 2023 13:12:45 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id b9b0ec6ca16d320a; Tue, 17 Oct 2023 22:12:44 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7ACE7666BCD;
	Tue, 17 Oct 2023 22:12:43 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 2/3] ACPI: thermal_lib: Add functions returning temperature in deci-Kelvin
Date: Tue, 17 Oct 2023 22:06:52 +0200
Message-ID: <4861460.GXAFRqVoOG@kreacher>
In-Reply-To: <5740803.DvuYhMxLoT@kreacher>
References: <5740803.DvuYhMxLoT@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddugeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because the ACPI thermal driver generally operates temperature values
in deci-Kelvin, it needs the library functions returning temperature
for various trip point types to use deci-Kelvin too.

To address that, arrange the ACPI thermal library code in three levels
of functions where the high-level ones will return temperature in
milli-Celsius, as needed by the thermal core and the majority of
thermal drivers, the mid-level ones will return temperature in
deci-Kelvin and will be called internally by the corresponding high-
level functions, and all of the mid-level functions will call the same
low-level one, acpi_trip_temp(), to actually evaluate ACPI objects to
retrieve themperature values from the platform firmware.

Going forward, this will allow the ACPI thermal driver to use the
mid-level functions to provide temperature values needed by it, so as
to reduce code duplication related to evaluating trip temperature ACPI
control methods.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal_lib.c |   75 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/acpi/thermal_lib.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal_lib.c
+++ linux-pm/drivers/acpi/thermal_lib.c
@@ -3,8 +3,8 @@
  * Copyright 2023 Linaro Limited
  * Copyright 2023 Intel Corporation
  *
- * Library routines for populating a generic thermal trip point structure
- * with data obtained by evaluating a specific object in the ACPI Namespace.
+ * Library routines for retrieving trip point temperature values from the
+ * platform firmware via ACPI.
  */
 #include <linux/acpi.h>
 #include <linux/units.h>
@@ -17,11 +17,11 @@
  * firmware. Any values out of these boundaries may be considered
  * bogus and we can assume the firmware has no data to provide.
  */
-#define TEMP_MIN_DECIK	2180
-#define TEMP_MAX_DECIK	4480
+#define TEMP_MIN_DECIK	2180ULL
+#define TEMP_MAX_DECIK	4480ULL
 
-static int thermal_acpi_trip_temp(struct acpi_device *adev, char *obj_name,
-				  int *ret_temp)
+static int acpi_trip_temp(struct acpi_device *adev, char *obj_name,
+			  int *ret_temp)
 {
 	unsigned long long temp;
 	acpi_status status;
@@ -33,7 +33,7 @@ static int thermal_acpi_trip_temp(struct
 	}
 
 	if (temp >= TEMP_MIN_DECIK && temp <= TEMP_MAX_DECIK) {
-		*ret_temp = deci_kelvin_to_millicelsius(temp);
+		*ret_temp = temp;
 	} else {
 		acpi_handle_debug(adev->handle, "%s result %llu out of range\n",
 				  obj_name, temp);
@@ -43,6 +43,44 @@ static int thermal_acpi_trip_temp(struct
 	return 0;
 }
 
+int acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
+{
+	char obj_name[] = {'_', 'A', 'C', '0' + id, '\0'};
+
+	if (id < 0 || id > 9)
+		return -EINVAL;
+
+	return acpi_trip_temp(adev, obj_name, ret_temp);
+}
+
+int acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
+{
+	return acpi_trip_temp(adev, "_PSV", ret_temp);
+}
+
+int acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
+{
+	return acpi_trip_temp(adev, "_HOT", ret_temp);
+}
+
+int acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
+{
+	return acpi_trip_temp(adev, "_CRT", ret_temp);
+}
+
+static int thermal_temp(int error, int temp_decik, int *ret_temp)
+{
+	if (error)
+		return error;
+
+	if (temp_decik == THERMAL_TEMP_INVALID)
+		*ret_temp = THERMAL_TEMP_INVALID;
+	else
+		*ret_temp = deci_kelvin_to_millicelsius(temp_decik);
+
+	return 0;
+}
+
 /**
  * thermal_acpi_active_trip_temp - Retrieve active trip point temperature
  * @adev: Target thermal zone ACPI device object.
@@ -57,12 +95,10 @@ static int thermal_acpi_trip_temp(struct
  */
 int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
 {
-	char obj_name[] = {'_', 'A', 'C', '0' + id, '\0'};
-
-	if (id < 0 || id > 9)
-		return -EINVAL;
+	int temp_decik;
+	int ret = acpi_active_trip_temp(adev, id, &temp_decik);
 
-	return thermal_acpi_trip_temp(adev, obj_name, ret_temp);
+	return thermal_temp(ret, temp_decik, ret_temp);
 }
 EXPORT_SYMBOL_GPL(thermal_acpi_active_trip_temp);
 
@@ -78,7 +114,10 @@ EXPORT_SYMBOL_GPL(thermal_acpi_active_tr
  */
 int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
 {
-	return thermal_acpi_trip_temp(adev, "_PSV", ret_temp);
+	int temp_decik;
+	int ret = acpi_passive_trip_temp(adev, &temp_decik);
+
+	return thermal_temp(ret, temp_decik, ret_temp);
 }
 EXPORT_SYMBOL_GPL(thermal_acpi_passive_trip_temp);
 
@@ -95,7 +134,10 @@ EXPORT_SYMBOL_GPL(thermal_acpi_passive_t
  */
 int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
 {
-	return thermal_acpi_trip_temp(adev, "_HOT", ret_temp);
+	int temp_decik;
+	int ret = acpi_hot_trip_temp(adev, &temp_decik);
+
+	return thermal_temp(ret, temp_decik, ret_temp);
 }
 EXPORT_SYMBOL_GPL(thermal_acpi_hot_trip_temp);
 
@@ -111,6 +153,9 @@ EXPORT_SYMBOL_GPL(thermal_acpi_hot_trip_
  */
 int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
 {
-	return thermal_acpi_trip_temp(adev, "_CRT", ret_temp);
+	int temp_decik;
+	int ret = acpi_critical_trip_temp(adev, &temp_decik);
+
+	return thermal_temp(ret, temp_decik, ret_temp);
 }
 EXPORT_SYMBOL_GPL(thermal_acpi_critical_trip_temp);




