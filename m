Return-Path: <linux-acpi+bounces-267-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A3E7B228B
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 18:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 84F33280123
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685164D8F0
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 16:35:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81F3B7AF
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 15:40:39 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A8AAC
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 08:40:36 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 59a6490da1c0af6f; Thu, 28 Sep 2023 17:40:34 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by v370.home.net.pl (Postfix) with ESMTPSA id 004866655D6;
	Thu, 28 Sep 2023 17:40:33 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Vicki Pfau <vi@endrift.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2] ACPI: utils: Make acpi_handle_list dynamically allocated
Date: Thu, 28 Sep 2023 17:40:33 +0200
Message-ID: <4857096.GXAFRqVoOG@kreacher>
In-Reply-To: <20230927201725.2339488-1-vi@endrift.com>
References: <20230927201725.2339488-1-vi@endrift.com>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrtddtgdeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehvihesvghnughrihhfthdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wednesday, September 27, 2023 10:17:25 PM CEST Vicki Pfau wrote:
> This fixes a long-standing "TBD" comment in the ACPI headers regarding making
> the acpi_handle_list struct's size dynamic. The number 10, which along with the
> comment dates back to 2.4.23, seems like it may have been arbitrarily chosen,
> and isn't sufficient in all cases. This patch finally makes the size dynamic
> and updates its users to handle the modified API.

First off, the effort is definitely appreciated, because this is about
addressing a real issue seen in the field.

However, the users of acpi_handle_list should not need to care about its
internal structure, so functions should be provided for freeing it and
manipulating it as needed.

> 
> Signed-off-by: Vicki Pfau <vi@endrift.com>
> ---
>  drivers/acpi/acpi_lpss.c                      |  5 +++-
>  drivers/acpi/scan.c                           |  1 +
>  drivers/acpi/thermal.c                        | 23 ++++++++++++++-----
>  drivers/acpi/utils.c                          |  5 ++--
>  .../platform/surface/surface_acpi_notify.c    |  5 +++-
>  include/acpi/acpi_bus.h                       |  4 +---
>  6 files changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 539e700de4d2..4b3aa84faf70 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -591,10 +591,13 @@ static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
>  	}
>  
>  	for (i = 0; i < dep_devices.count; i++) {
> -		if (dep_devices.handles[i] == handle)
> +		if (dep_devices.handles[i] == handle) {
> +			kfree(dep_devices.handles);
>  			return true;
> +		}
>  	}
>  
> +	kfree(dep_devices.handles);

Moreover, the code duplication here can be avoided by using a return variable.

>  	return false;
>  }
>  
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 691d4b7686ee..2fbe354db0c0 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2032,6 +2032,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
>  		mutex_unlock(&acpi_dep_list_lock);
>  	}
>  
> +	kfree(dep_devices.handles);
>  	return count;
>  }
>  
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 312730f8272e..48ddc56f96f6 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -307,8 +307,10 @@ static void __acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>  			tz->trips.passive.trip.valid = true;
>  		}
>  
> -		if (memcmp(&tz->trips.passive.devices, &devices,
> -			   sizeof(struct acpi_handle_list))) {
> +		if (&tz->trips.passive.devices.count != devices.count ||
> +			   memcmp(tz->trips.passive.devices.handles,
> +			   devices.handles, sizeof(acpi_handle) * devices.count)) {
> +			kfree(tz->trips.passive.devices.handles);
>  			memcpy(&tz->trips.passive.devices, &devices,
>  			       sizeof(struct acpi_handle_list));
>  			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
> @@ -372,8 +374,10 @@ static void __acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>  				tz->trips.active[i].trip.valid = true;
>  			}
>  
> -			if (memcmp(&tz->trips.active[i].devices, &devices,
> -				   sizeof(struct acpi_handle_list))) {
> +			if (&tz->trips.active[i].devices.count != devices.count ||
> +				   memcmp(tz->trips.active[i].devices.handles,
> +				   devices.handles, sizeof(acpi_handle) * devices.count)) {
> +				kfree(tz->trips.active[i].devices.handles);
>  				memcpy(&tz->trips.active[i].devices, &devices,
>  				       sizeof(struct acpi_handle_list));
>  				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
> @@ -391,8 +395,10 @@ static void __acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>  		memset(&devices, 0, sizeof(devices));
>  		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
>  						 NULL, &devices);
> -		if (ACPI_SUCCESS(status) &&
> -		    memcmp(&tz->devices, &devices, sizeof(devices))) {
> +		if (ACPI_SUCCESS(status) && (tz->devices.count != devices.count ||
> +		    memcmp(tz->devices.handles, devices.handles,
> +		    sizeof(acpi_handle) * devices.count))) {
> +			kfree(tz->devices.handles);
>  			tz->devices = devices;
>  			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
>  		}

All of the changes in thermal.c above need to be rebased on the ACPI thermal
changes currently in-flight, but that's something for me to take care of.

> @@ -974,6 +980,7 @@ static int acpi_thermal_add(struct acpi_device *device)
>  static void acpi_thermal_remove(struct acpi_device *device)
>  {
>  	struct acpi_thermal *tz;
> +	int i;
>  
>  	if (!device || !acpi_driver_data(device))
>  		return;
> @@ -986,6 +993,10 @@ static void acpi_thermal_remove(struct acpi_device *device)
>  	flush_workqueue(acpi_thermal_pm_queue);
>  	acpi_thermal_unregister_thermal_zone(tz);
>  
> +	kfree(tz->trips.passive.devices.handles);
> +	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
> +		kfree(tz->trips.active[i].devices.handles);
> +	kfree(tz->devices.handles);

And this also needs to be done in the acpi_thermal_add() error cleanup path
so as to avoid leaking memory from there.

>  	kfree(tz);
>  }
>  
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 2ea14648a661..96f821c41756 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -370,7 +370,8 @@ acpi_evaluate_reference(acpi_handle handle,
>  		goto end;
>  	}
>  
> -	if (package->package.count > ACPI_MAX_HANDLES) {
> +	list->handles = kcalloc(package->package.count, sizeof(*list->handles), GFP_KERNEL);
> +	if (!list->handles) {
>  		kfree(package);
>  		return AE_NO_MEMORY;
>  	}
> @@ -402,7 +403,7 @@ acpi_evaluate_reference(acpi_handle handle,
>        end:
>  	if (ACPI_FAILURE(status)) {
>  		list->count = 0;
> -		//kfree(list->handles);
> +		kfree(list->handles);

Clearing list->handles (to avoid leaking a stale pointer) here would be nice.

>  	}
>  
>  	kfree(buffer.pointer);
> diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/platform/surface/surface_acpi_notify.c
> index 897cdd9c3aae..6932d4b35c6c 100644
> --- a/drivers/platform/surface/surface_acpi_notify.c
> +++ b/drivers/platform/surface/surface_acpi_notify.c
> @@ -753,10 +753,13 @@ static bool is_san_consumer(struct platform_device *pdev, acpi_handle handle)
>  	}
>  
>  	for (i = 0; i < dep_devices.count; i++) {
> -		if (dep_devices.handles[i] == supplier)
> +		if (dep_devices.handles[i] == supplier) {
> +			kfree(dep_devices.handles);
>  			return true;
> +		}
>  	}
>  
> +	kfree(dep_devices.handles);
>  	return false;

And again, the code duplication here is avoidable.

>  }
>  
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 254685085c82..b4bf12343a22 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -12,11 +12,9 @@
>  #include <linux/device.h>
>  #include <linux/property.h>
>  
> -/* TBD: Make dynamic */
> -#define ACPI_MAX_HANDLES	10
>  struct acpi_handle_list {
>  	u32 count;
> -	acpi_handle handles[ACPI_MAX_HANDLES];
> +	acpi_handle* handles;
>  };
>  
>  /* acpi_utils.h */
> 

All of the above said, I don't really want to defer making this change
too much, so below is my version of it (with the Co-developed-by tag
pointing to you and your S-o-b as the co-author of the changes) and
this is what I'm going to apply unless somebody is able to poke a hole
in it.
---
Subject: [PATCH] ACPI: utils: Dynamically determine acpi_handle_list size
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Address a long-standing "TBD" comment in the ACPI headers regarding the
number of handles in struct acpi_handle_list.

The number 10, which along with the comment dates back to 2.4.23, seems
like it may have been arbitrarily chosen and isn't sufficient in all
cases [1].

Finally change the code to dynamically determine the size of the handles
table in struct acpi_handle_list and allocate it accordingly.

Update the users of to struct acpi_handle_list to take the additional
dynamic allocation into account.

Link: https://lore.kernel.org/linux-acpi/20230809094451.15473-1-ivan.hu@canonical.com # [1]
Co-developed-by: Vicki Pfau <vi@endrift.com>
Signed-off-by: Vicki Pfau <vi@endrift.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This applies on top of

https://patchwork.kernel.org/project/linux-pm/patch/1785516.VLH7GnMWUR@kreacher/

---
 drivers/acpi/acpi_lpss.c                       |   10 ++--
 drivers/acpi/scan.c                            |    1 
 drivers/acpi/thermal.c                         |   28 ++++++++---
 drivers/acpi/utils.c                           |   61 ++++++++++++++++++++++++-
 drivers/platform/surface/surface_acpi_notify.c |   10 ++--
 include/acpi/acpi_bus.h                        |    9 ++-
 6 files changed, 101 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -578,6 +578,7 @@ static bool acpi_lpss_dep(struct acpi_de
 {
 	struct acpi_handle_list dep_devices;
 	acpi_status status;
+	bool ret = false;
 	int i;
 
 	if (!acpi_has_method(adev->handle, "_DEP"))
@@ -591,11 +592,14 @@ static bool acpi_lpss_dep(struct acpi_de
 	}
 
 	for (i = 0; i < dep_devices.count; i++) {
-		if (dep_devices.handles[i] == handle)
-			return true;
+		if (dep_devices.handles[i] == handle) {
+			ret = true;
+			break;
+		}
 	}
 
-	return false;
+	acpi_handle_list_free(&dep_devices);
+	return ret;
 }
 
 static void acpi_lpss_link_consumer(struct device *dev1,
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2031,6 +2031,7 @@ static u32 acpi_scan_check_dep(acpi_hand
 		mutex_unlock(&acpi_dep_list_lock);
 	}
 
+	acpi_handle_list_free(&dep_devices);
 	return count;
 }
 
Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -208,7 +208,7 @@ static bool update_trip_devices(struct a
 				struct acpi_thermal_trip *acpi_trip,
 				int index, bool compare)
 {
-	struct acpi_handle_list devices;
+	struct acpi_handle_list devices = { 0 };
 	char method[] = "_PSL";
 	acpi_status status;
 
@@ -218,18 +218,21 @@ static bool update_trip_devices(struct a
 		method[3] = '0' + index;
 	}
 
-	memset(&devices, 0, sizeof(devices));
-
 	status = acpi_evaluate_reference(tz->device->handle, method, NULL, &devices);
 	if (ACPI_FAILURE(status)) {
 		acpi_handle_info(tz->device->handle, "%s evaluation failure\n", method);
 		return false;
 	}
 
-	if (compare && memcmp(&acpi_trip->devices, &devices, sizeof(devices)))
+	if (acpi_handle_list_equal(&acpi_trip->devices, &devices)) {
+		acpi_handle_list_free(&devices);
+		return true;
+	}
+
+	if (compare)
 		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "device");
 
-	memcpy(&acpi_trip->devices, &devices, sizeof(devices));
+	acpi_handle_list_replace(&acpi_trip->devices, &devices);
 	return true;
 }
 
@@ -845,6 +848,17 @@ static void acpi_thermal_check_fn(struct
 	mutex_unlock(&tz->thermal_check_lock);
 }
 
+static void acpi_thermal_free_thermal_zone(struct acpi_thermal *tz)
+{
+	int i;
+
+	acpi_handle_list_free(&tz->trips.passive.trip.devices);
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
+		acpi_handle_list_free(&tz->trips.active[i].trip.devices);
+
+	kfree(tz);
+}
+
 static int acpi_thermal_add(struct acpi_device *device)
 {
 	struct acpi_thermal_trip *acpi_trip;
@@ -971,7 +985,7 @@ flush_wq:
 free_trips:
 	kfree(tz->trip_table);
 free_memory:
-	kfree(tz);
+	acpi_thermal_free_thermal_zone(tz);
 
 	return result;
 }
@@ -991,7 +1005,7 @@ static void acpi_thermal_remove(struct a
 	flush_workqueue(acpi_thermal_pm_queue);
 	acpi_thermal_unregister_thermal_zone(tz);
 
-	kfree(tz);
+	acpi_thermal_free_thermal_zone(tz);
 }
 
 #ifdef CONFIG_PM_SLEEP
Index: linux-pm/drivers/acpi/utils.c
===================================================================
--- linux-pm.orig/drivers/acpi/utils.c
+++ linux-pm/drivers/acpi/utils.c
@@ -370,7 +370,8 @@ acpi_evaluate_reference(acpi_handle hand
 		goto end;
 	}
 
-	if (package->package.count > ACPI_MAX_HANDLES) {
+	list->handles = kcalloc(package->package.count, sizeof(*list->handles), GFP_KERNEL);
+	if (!list->handles) {
 		kfree(package);
 		return AE_NO_MEMORY;
 	}
@@ -402,7 +403,8 @@ acpi_evaluate_reference(acpi_handle hand
       end:
 	if (ACPI_FAILURE(status)) {
 		list->count = 0;
-		//kfree(list->handles);
+		kfree(list->handles);
+		list->handles = NULL;
 	}
 
 	kfree(buffer.pointer);
@@ -412,6 +414,61 @@ acpi_evaluate_reference(acpi_handle hand
 
 EXPORT_SYMBOL(acpi_evaluate_reference);
 
+/**
+ * acpi_handle_list_equal - Check if two ACPI handle lists are the same
+ * @list1: First list to compare.
+ * @List2: Second list to compare.
+ *
+ * Return true if the given ACPI handle lists are of the same size and
+ * contain the same ACPI handles in the same order.  Otherwise, return false.
+ */
+bool acpi_handle_list_equal(struct acpi_handle_list *list1,
+			    struct acpi_handle_list *list2)
+{
+	return list1->count == list2->count &&
+		!memcmp(list1->handles, list2->handles,
+		        list1->count * sizeof(acpi_handle));
+}
+EXPORT_SYMBOL_GPL(acpi_handle_list_equal);
+
+/**
+ * acpi_handle_list_replace - Replace one ACPI handle list with another
+ * @dst: ACPI handle list to replace.
+ * @src: Source ACPI handle list.
+ *
+ * Free the handles table in @dst, move the handles table from @src to @dst,
+ * copy count from @src to @dst and clear @src.
+ */
+void acpi_handle_list_replace(struct acpi_handle_list *dst,
+			      struct acpi_handle_list *src)
+{
+	if (dst->count)
+		kfree(dst->handles);
+
+	dst->count = src->count;
+	dst->handles = src->handles;
+
+	src->handles = NULL;
+	src->count = 0;
+}
+EXPORT_SYMBOL_GPL(acpi_handle_list_replace);
+
+/**
+ * acpi_handle_list_free - Free the handles table in an ACPI handle list
+ * @list: ACPI handle list to free.
+ *
+ * Free the handles table in @list and clear its count field.
+ */
+void acpi_handle_list_free(struct acpi_handle_list *list)
+{
+	if (!list->count)
+		return;
+
+	kfree(list->handles);
+	list->count = 0;
+}
+EXPORT_SYMBOL_GPL(acpi_handle_list_free);
+
 acpi_status
 acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
 {
Index: linux-pm/drivers/platform/surface/surface_acpi_notify.c
===================================================================
--- linux-pm.orig/drivers/platform/surface/surface_acpi_notify.c
+++ linux-pm/drivers/platform/surface/surface_acpi_notify.c
@@ -741,6 +741,7 @@ static bool is_san_consumer(struct platf
 	struct acpi_handle_list dep_devices;
 	acpi_handle supplier = ACPI_HANDLE(&pdev->dev);
 	acpi_status status;
+	bool ret = false;
 	int i;
 
 	if (!acpi_has_method(handle, "_DEP"))
@@ -753,11 +754,14 @@ static bool is_san_consumer(struct platf
 	}
 
 	for (i = 0; i < dep_devices.count; i++) {
-		if (dep_devices.handles[i] == supplier)
-			return true;
+		if (dep_devices.handles[i] == supplier) {
+			ret = true;
+			break;
+		}
 	}
 
-	return false;
+	acpi_handle_list_free(&dep_devices);
+	return ret;
 }
 
 static acpi_status san_consumer_setup(acpi_handle handle, u32 lvl,
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -12,11 +12,9 @@
 #include <linux/device.h>
 #include <linux/property.h>
 
-/* TBD: Make dynamic */
-#define ACPI_MAX_HANDLES	10
 struct acpi_handle_list {
 	u32 count;
-	acpi_handle handles[ACPI_MAX_HANDLES];
+	acpi_handle* handles;
 };
 
 /* acpi_utils.h */
@@ -32,6 +30,11 @@ acpi_evaluate_reference(acpi_handle hand
 			acpi_string pathname,
 			struct acpi_object_list *arguments,
 			struct acpi_handle_list *list);
+bool acpi_handle_list_equal(struct acpi_handle_list *list1,
+			    struct acpi_handle_list *list2);
+void acpi_handle_list_replace(struct acpi_handle_list *dst,
+			      struct acpi_handle_list *src);
+void acpi_handle_list_free(struct acpi_handle_list *list);
 acpi_status
 acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
 		  struct acpi_buffer *status_buf);




