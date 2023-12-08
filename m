Return-Path: <linux-acpi+bounces-2246-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBA480AE0A
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 21:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4E0280E16
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 20:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3823757887
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 20:37:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0F31729;
	Fri,  8 Dec 2023 12:07:52 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id e04bf29fd40f84a8; Fri, 8 Dec 2023 21:07:50 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 429496688FF;
	Fri,  8 Dec 2023 21:07:50 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 2/4] ACPI: utils: Return bool from acpi_evaluate_reference()
Date: Fri, 08 Dec 2023 21:06:04 +0100
Message-ID: <4864019.GXAFRqVoOG@kreacher>
In-Reply-To: <6008018.lOV4Wx5bFT@kreacher>
References: <6008018.lOV4Wx5bFT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhm
 pdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are only 4 users of acpi_evaluate_reference() and none of them
actually cares about the reason why it fails.  All of them are only
interested in whether or not it is successful, so it can return a bool
value indicating that.

Modify acpi_evaluate_reference() as per the observation above and update
its callers accordingly so as to get rid of useless code and local
variables.

The observable behavior of the kernel is not expected to change after
this modification of the code.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_lpss.c                       |    5 ---
 drivers/acpi/scan.c                            |    5 +--
 drivers/acpi/thermal.c                         |    4 ---
 drivers/acpi/utils.c                           |   32 +++++++++----------------
 drivers/platform/surface/surface_acpi_notify.c |    4 ---
 include/acpi/acpi_bus.h                        |    8 ++----
 6 files changed, 20 insertions(+), 38 deletions(-)

Index: linux-pm/drivers/acpi/utils.c
===================================================================
--- linux-pm.orig/drivers/acpi/utils.c
+++ linux-pm/drivers/acpi/utils.c
@@ -329,19 +329,18 @@ const char *acpi_get_subsystem_id(acpi_h
 }
 EXPORT_SYMBOL_GPL(acpi_get_subsystem_id);
 
-acpi_status
-acpi_evaluate_reference(acpi_handle handle,
-			acpi_string pathname,
-			struct acpi_object_list *arguments,
-			struct acpi_handle_list *list)
+bool acpi_evaluate_reference(acpi_handle handle, acpi_string pathname,
+			     struct acpi_object_list *arguments,
+			     struct acpi_handle_list *list)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *package;
 	acpi_status status;
+	bool ret = false;
 	u32 i;
 
 	if (!list)
-		return AE_BAD_PARAMETER;
+		return false;
 
 	/* Evaluate object. */
 
@@ -352,42 +351,35 @@ acpi_evaluate_reference(acpi_handle hand
 	package = buffer.pointer;
 
 	if (buffer.length == 0 || !package ||
-	    package->type != ACPI_TYPE_PACKAGE || !package->package.count) {
-		status = AE_BAD_DATA;
+	    package->type != ACPI_TYPE_PACKAGE || !package->package.count)
 		goto err;
-	}
 
 	list->count = package->package.count;
 	list->handles = kcalloc(list->count, sizeof(*list->handles), GFP_KERNEL);
-	if (!list->handles) {
-		status = AE_NO_MEMORY;
+	if (!list->handles)
 		goto err_clear;
-	}
 
 	/* Extract package data. */
 
 	for (i = 0; i < list->count; i++) {
 		union acpi_object *element = &(package->package.elements[i]);
 
-		if (element->type != ACPI_TYPE_LOCAL_REFERENCE) {
-			status = AE_BAD_DATA;
+		if (element->type != ACPI_TYPE_LOCAL_REFERENCE ||
+		    !element->reference.handle)
 			goto err_free;
-		}
 
-		if (!element->reference.handle) {
-			status = AE_NULL_ENTRY;
-			goto err_free;
-		}
 		/* Get the  acpi_handle. */
 
 		list->handles[i] = element->reference.handle;
 		acpi_handle_debug(list->handles[i], "Found in reference list\n");
 	}
 
+	ret = true;
+
 end:
 	kfree(buffer.pointer);
 
-	return status;
+	return ret;
 
 err_free:
 	kfree(list->handles);
Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -565,16 +565,13 @@ static struct device *acpi_lpss_find_dev
 static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
-	acpi_status status;
 	bool ret = false;
 	int i;
 
 	if (!acpi_has_method(adev->handle, "_DEP"))
 		return false;
 
-	status = acpi_evaluate_reference(adev->handle, "_DEP", NULL,
-					 &dep_devices);
-	if (ACPI_FAILURE(status)) {
+	if (!acpi_evaluate_reference(adev->handle, "_DEP", NULL, &dep_devices)) {
 		dev_dbg(&adev->dev, "Failed to evaluate _DEP.\n");
 		return false;
 	}
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -25,11 +25,9 @@ acpi_status
 acpi_evaluate_integer(acpi_handle handle,
 		      acpi_string pathname,
 		      struct acpi_object_list *arguments, unsigned long long *data);
-acpi_status
-acpi_evaluate_reference(acpi_handle handle,
-			acpi_string pathname,
-			struct acpi_object_list *arguments,
-			struct acpi_handle_list *list);
+bool acpi_evaluate_reference(acpi_handle handle, acpi_string pathname,
+			     struct acpi_object_list *arguments,
+			     struct acpi_handle_list *list);
 bool acpi_handle_list_equal(struct acpi_handle_list *list1,
 			    struct acpi_handle_list *list2);
 void acpi_handle_list_replace(struct acpi_handle_list *dst,
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1984,7 +1984,6 @@ static void acpi_scan_init_hotplug(struc
 static u32 acpi_scan_check_dep(acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
-	acpi_status status;
 	u32 count;
 	int i;
 
@@ -1997,8 +1996,7 @@ static u32 acpi_scan_check_dep(acpi_hand
 	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
 		return 0;
 
-	status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
-	if (ACPI_FAILURE(status)) {
+	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
 		acpi_handle_debug(handle, "Failed to evaluate _DEP.\n");
 		return 0;
 	}
@@ -2007,6 +2005,7 @@ static u32 acpi_scan_check_dep(acpi_hand
 		struct acpi_device_info *info;
 		struct acpi_dep_data *dep;
 		bool skip, honor_dep;
+		acpi_status status;
 
 		status = acpi_get_object_info(dep_devices.handles[i], &info);
 		if (ACPI_FAILURE(status)) {
Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -244,7 +244,6 @@ static bool update_trip_devices(struct a
 {
 	struct acpi_handle_list devices = { 0 };
 	char method[] = "_PSL";
-	acpi_status status;
 
 	if (index != ACPI_THERMAL_TRIP_PASSIVE) {
 		method[1] = 'A';
@@ -252,8 +251,7 @@ static bool update_trip_devices(struct a
 		method[3] = '0' + index;
 	}
 
-	status = acpi_evaluate_reference(tz->device->handle, method, NULL, &devices);
-	if (ACPI_FAILURE(status)) {
+	if (!acpi_evaluate_reference(tz->device->handle, method, NULL, &devices)) {
 		acpi_handle_info(tz->device->handle, "%s evaluation failure\n", method);
 		return false;
 	}
Index: linux-pm/drivers/platform/surface/surface_acpi_notify.c
===================================================================
--- linux-pm.orig/drivers/platform/surface/surface_acpi_notify.c
+++ linux-pm/drivers/platform/surface/surface_acpi_notify.c
@@ -740,15 +740,13 @@ static bool is_san_consumer(struct platf
 {
 	struct acpi_handle_list dep_devices;
 	acpi_handle supplier = ACPI_HANDLE(&pdev->dev);
-	acpi_status status;
 	bool ret = false;
 	int i;
 
 	if (!acpi_has_method(handle, "_DEP"))
 		return false;
 
-	status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
-	if (ACPI_FAILURE(status)) {
+	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
 		san_consumer_dbg(&pdev->dev, handle, "failed to evaluate _DEP\n");
 		return false;
 	}




