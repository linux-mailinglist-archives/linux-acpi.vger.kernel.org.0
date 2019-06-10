Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3EE3BD51
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2019 22:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389170AbfFJUHm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 Jun 2019 16:07:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389099AbfFJUHm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jun 2019 16:07:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7747E307D844;
        Mon, 10 Jun 2019 20:07:41 +0000 (UTC)
Received: from masetto.com (ovpn-116-108.phx2.redhat.com [10.3.116.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C6865C1B4;
        Mon, 10 Jun 2019 20:07:38 +0000 (UTC)
From:   Al Stone <ahs3@redhat.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ahs3@redhat.com
Subject: [RFC PATCH] ACPI / processors: allow a processor device _UID to be a string
Date:   Mon, 10 Jun 2019 14:07:34 -0600
Message-Id: <20190610200734.1182-1-ahs3@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 10 Jun 2019 20:07:41 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In the ACPI specification, section 6.1.12, a _UID may be either an
integer or a string object.  Up until now, when defining processor
Device()s in ACPI (_HID ACPI0007), only integers were allowed even
though this ignored the specification.  As a practical matter, it
was not an issue.

Recently, some DSDTs have shown up that look like this:

  Device (XX00)
  {
	Name (_HID, "ACPI0007" /* Processor Device */)
        Name (_UID, "XYZZY-XX00")
        .....
  }

which is perfectly legal.  However, the kernel will report instead:

...
[    0.706970] ACPI: \_SB_.XXXX.XX00: Invalid processor object
...
[    0.776998] acpi ACPI0007:xx: Failed to evaluate processor _UID (0xc)
...

The second message comes from acpi_processor_get_info() not being
able to use the string value for _UID that was provided in the DSDT;
the 0xc in the message is actually the buffer size of the returned
value from trying to evaluate _UID.

We correct this by first adding a field called acpi_name to struct
acpi_processor.  Then we add the function acpi_processor_evaluate_uid()
to get the returned _UID object and, if it is an integer, behave exactly
as acpi_processor_get_info() did before, but if it is a string, assign
it an arbitrary integer value (required by all the users of this
struct) and capture the actual string used.  This results in the
functions acpi_processor_add() and acpi_processor_remove() changing
also so that we do not inadvertently forget to free the space used
for the new acpi_name field.

Why RFC and not a straight patch?  I have some concerns that need broader
knowledge than I have at my disposal:

   1) Is there a need to expose the CPU name captured from the ACPI
      namespace in sysfs (or elsewhere)?  I could not think of any
      good reason but I probably just missed something.

   2) Is making last_used_string_cpuid atomic required?  I think it
      is, but only because I think acpi_processor_add() could get called
      on multiple CPUs at roughly the same time.  If that never happens,
      an int would be just fine.

   3) Is it necessary to check that a _UID string is a duplicate of the
      _UID string of some other CPU Device() (_HID ACPI0007)?  The code
      will ensure unique integer IDs, and the firmware writer should not
      have provided duplicate string _UIDs, but things happen.  I would
      need to add this code to this patch.

   4) Testing: I only have one very fragile machine to test this on (the
      firmware is really, really unstable right now); more testing would
      be greatly appreciated.

Signed-off-by: Al Stone <ahs3@redhat.com>
---
 drivers/acpi/acpi_processor.c | 57 ++++++++++++++++++++++++++++++-----
 include/acpi/processor.h      |  1 +
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 449d86d39965..f40163e0edf9 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -32,6 +33,8 @@ ACPI_MODULE_NAME("processor");
 DEFINE_PER_CPU(struct acpi_processor *, processors);
 EXPORT_PER_CPU_SYMBOL(processors);
 
+static atomic_t last_used_string_cpuid;
+
 /* --------------------------------------------------------------------------
                                 Errata Handling
    -------------------------------------------------------------------------- */
@@ -229,6 +232,49 @@ static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
 }
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
+static acpi_status acpi_processor_evaluate_uid(struct acpi_device *device)
+{
+	acpi_status status = AE_OK;
+	struct acpi_processor *pr;
+	union acpi_object object = { 0 };
+	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
+
+	if (!device)
+		return -ENODEV;
+
+	/*
+	 * Declared with "Device" statement; match _UID.
+	 *
+	 * By definition in the ACPI spec, _UID may return either
+	 * an integer or a string.
+	 */
+	pr = acpi_driver_data(device);
+	if (!pr)
+		return -ENODEV;
+
+	status = acpi_evaluate_object(pr->handle, METHOD_NAME__UID,
+				      NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		ACPI_FREE(buffer.pointer);
+		return status;
+	}
+
+	if (object.type == ACPI_TYPE_INTEGER) {
+		pr->acpi_id = object.integer.value;
+		pr->acpi_name = NULL;
+		ACPI_FREE(buffer.pointer);		/* no longer needed */
+	} else if (object.type == ACPI_TYPE_STRING) {
+		/* no need to be clever, just pick an unused number */
+		pr->acpi_id = atomic_inc_return(&last_used_string_cpuid);
+		pr->acpi_name = object.string.pointer;	/* still needed */
+	} else {
+		ACPI_FREE(buffer.pointer);
+		return AE_BAD_DATA;
+	}
+
+	return status;
+}
+
 static int acpi_processor_get_info(struct acpi_device *device)
 {
 	union acpi_object object = { 0 };
@@ -265,12 +311,8 @@ static int acpi_processor_get_info(struct acpi_device *device)
 
 		pr->acpi_id = object.processor.proc_id;
 	} else {
-		/*
-		 * Declared with "Device" statement; match _UID.
-		 * Note that we don't handle string _UIDs yet.
-		 */
-		status = acpi_evaluate_integer(pr->handle, METHOD_NAME__UID,
-						NULL, &value);
+		/* Declared with "Device" statement; match _UID.  */
+		status = acpi_processor_evaluate_uid(device);
 		if (ACPI_FAILURE(status)) {
 			dev_err(&device->dev,
 				"Failed to evaluate processor _UID (0x%x)\n",
@@ -278,7 +320,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
 			return -ENODEV;
 		}
 		device_declaration = 1;
-		pr->acpi_id = value;
 	}
 
 	if (acpi_duplicate_processor_id(pr->acpi_id)) {
@@ -435,6 +476,7 @@ static int acpi_processor_add(struct acpi_device *device,
 	device->driver_data = NULL;
 	per_cpu(processors, pr->id) = NULL;
  err_free_pr:
+	kfree(pr->acpi_name);
 	kfree(pr);
 	return result;
 }
@@ -484,6 +526,7 @@ static void acpi_processor_remove(struct acpi_device *device)
 
  out:
 	free_cpumask_var(pr->throttling.shared_cpu_map);
+	kfree(pr->acpi_name);
 	kfree(pr);
 }
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 1194a4c78d55..115e9eee830b 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -216,6 +216,7 @@ struct acpi_processor_flags {
 struct acpi_processor {
 	acpi_handle handle;
 	u32 acpi_id;
+	char *acpi_name; /* only used if _UID is a string, otherwise null */
 	phys_cpuid_t phys_id;	/* CPU hardware ID such as APIC ID for x86 */
 	u32 id;		/* CPU logical ID allocated by OS */
 	u32 pblk;
-- 
2.21.0

