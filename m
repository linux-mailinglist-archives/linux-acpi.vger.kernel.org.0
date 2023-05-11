Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1E56FF6CA
	for <lists+linux-acpi@lfdr.de>; Thu, 11 May 2023 18:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbjEKQIO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 11 May 2023 12:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbjEKQIM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 May 2023 12:08:12 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE3B7DBC;
        Thu, 11 May 2023 09:08:03 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id fc5c505b103c4cc6; Thu, 11 May 2023 18:08:01 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B814B961D7C;
        Thu, 11 May 2023 18:08:00 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v8 01/10] ACPI: scan: Remove the second DSDT traversal
Date:   Thu, 11 May 2023 18:08:00 +0200
Message-ID: <4845818.31r3eYUQgx@kreacher>
In-Reply-To: <ZFqx0SB71Ht3IpQ3@kekkonen.localdomain>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com> <CAJZ5v0gzSjDS16Sq9oAs_9BSEgmM6VPPFF4vrd2cyK++UP7=_w@mail.gmail.com> <ZFqx0SB71Ht3IpQ3@kekkonen.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegkedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnheptddvfeegledvfedvveevhedvteeffeehvdeuiedukeeiledttefgvdeihffgteetnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehsrghkrghrihdrrghilhhusheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhgvughirgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
 nhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, May 9, 2023 10:49:21 PM CEST Sakari Ailus wrote:
> Hi Rafael,
> 
> Thank you for the review.
> 
> On Tue, May 09, 2023 at 08:06:28PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Mar 29, 2023 at 12:10 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Collect the devices with _DEP into a list and continue processing them
> > > after a full traversal, instead of doing a full second traversal of the
> > > tree.
> > >
> > > This makes the second DSDT traversal pass unnecessary as we already have
> > > the nodes we're interested in in a linked list.
> > 
> > The second traversal of the ACPI namespace (it may not be just the
> > DSDT at that point to be precise) is not really about _DEP handling.
> > In fact, the latter has been added on top of it.
> > 
> > It is about the PCI enumeration.  Namely, when acpi_pci_root_add()
> > runs for the PCI host bridge object in the ACPI namespace, the entire
> > device hierarchy below it is walked and all of the ACPI device objects
> > corresponding to the PCI devices on the bus are assumed to be present.
> > This means that all of the ACPI device objects need to be created in
> > the first walk, without binding any ACPI drivers or scan handlers to
> > them, and the second walk is to find out what is actually represented
> > by those objects.
> > 
> > It cannot be eliminated in any simple way.
> 
> My understanding still remains that this patch does not (or other patches
> in this set) change the above. It is just how those nodes are reached:
> instead of traversing the entire tree and ignoring the devices that have
> already an acpi_device created for them, a linked list of devices of
> interest is traversed.
> 
> Of course it is possible that I have missed something. The codebase isn't
> entirely trivial.

You are right and I see what it is about now.

However, the implementation is rather fragile and the list added by the
$subject patch is redundant AFAICS, because all of the objects in it
are also present in acpi_dep_list as consumers (adding an object to
acpi_dep_list as a consumer is necessary for that object to be added to the
new list too).  Of course, there may be multiple acpi_dep_list for the same
consumer object, but it is not a fundamental problem.

So overall I'd prefer to do something like the appended (untested) patch
instead.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] ACPI: scan: Reduce overhead related to devices with dependencies

Notice that all of the objects for which the acpi_scan_check_dep()
return value is greater than 0 are present in acpi_dep_list as consumers
(there may be multiple entries for one object, but that is not a
problem), so after carrying out the initial ACPI namespace walk in which
devices with dependencies are skipped, acpi_bus_scan() can simply walk
acpi_dep_list and enumerate all of the unique consumer objects from
there and their descendants instead of walking the entire target branch
of the ACPI namespace and looking for device objects that have not been
enumerated yet in it.

Because walking acpi_dep_list is generally less overhead than walking
the entire ACPI namespace, use the observation above to reduce the
system initialization overhead related to ACPI, which is particularly
important on large systems.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c     |   71 ++++++++++++++++++++++++++++++++++--------------
 include/acpi/acpi_bus.h |    2 +
 2 files changed, 53 insertions(+), 20 deletions(-)

Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -289,6 +289,8 @@ struct acpi_dep_data {
 	acpi_handle supplier;
 	acpi_handle consumer;
 	bool honor_dep;
+	bool met;
+	bool free_when_met;
 };
 
 /* Performance Management */
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2029,8 +2029,6 @@ static u32 acpi_scan_check_dep(acpi_hand
 	return count;
 }
 
-static bool acpi_bus_scan_second_pass;
-
 static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
 				      struct acpi_device **adev_p)
 {
@@ -2050,10 +2048,8 @@ static acpi_status acpi_bus_check_add(ac
 			return AE_OK;
 
 		/* Bail out if there are dependencies. */
-		if (acpi_scan_check_dep(handle, check_dep) > 0) {
-			acpi_bus_scan_second_pass = true;
+		if (acpi_scan_check_dep(handle, check_dep) > 0)
 			return AE_CTRL_DEPTH;
-		}
 
 		fallthrough;
 	case ACPI_TYPE_ANY:	/* for ACPI_ROOT_OBJECT */
@@ -2311,8 +2307,12 @@ static int acpi_scan_clear_dep(struct ac
 			acpi_dev_put(adev);
 	}
 
-	list_del(&dep->node);
-	kfree(dep);
+	if (dep->free_when_met) {
+		list_del(&dep->node);
+		kfree(dep);
+	} else {
+		dep->met = true;
+	}
 
 	return 0;
 }
@@ -2406,6 +2406,49 @@ struct acpi_device *acpi_dev_get_next_co
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_next_consumer_dev);
 
+static void acpi_scan_postponed(acpi_handle handle)
+{
+	struct acpi_device *adev = NULL;
+	struct acpi_dep_data *dep, *tmp;
+
+	mutex_lock(&acpi_dep_list_lock);
+
+	list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
+		acpi_handle handle = dep->consumer;
+
+		/*
+		 * Even though the lock is released here, tmp is guaranteed to
+		 * be valid, because none of the list entries following dep is
+		 * marked as "free when met" and so they cannot be deleted.
+		 */
+		mutex_unlock(&acpi_dep_list_lock);
+
+		/*
+		 * In case there are multiple acpi_dep_list entries with the
+		 * same consumer, skip the current entry if the consumer device
+		 * object corresponding to it is present already.
+		 */
+		if (!acpi_fetch_acpi_dev(handle) &&
+		    ACPI_SUCCESS(acpi_bus_check_add(handle, false, &adev))) {
+			acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
+					    acpi_bus_check_add_2, NULL, NULL,
+					    (void **)&adev);
+			acpi_bus_attach(adev, NULL);
+		}
+
+		mutex_lock(&acpi_dep_list_lock);
+
+		if (dep->met) {
+			list_del(&dep->node);
+			kfree(dep);
+		} else {
+			dep->free_when_met = true;
+		}
+	}
+
+	mutex_unlock(&acpi_dep_list_lock);
+}
+
 /**
  * acpi_bus_scan - Add ACPI device node objects in a given namespace scope.
  * @handle: Root of the namespace scope to scan.
@@ -2424,8 +2467,6 @@ int acpi_bus_scan(acpi_handle handle)
 {
 	struct acpi_device *device = NULL;
 
-	acpi_bus_scan_second_pass = false;
-
 	/* Pass 1: Avoid enumerating devices with missing dependencies. */
 
 	if (ACPI_SUCCESS(acpi_bus_check_add(handle, true, &device)))
@@ -2438,19 +2479,9 @@ int acpi_bus_scan(acpi_handle handle)
 
 	acpi_bus_attach(device, (void *)true);
 
-	if (!acpi_bus_scan_second_pass)
-		return 0;
-
 	/* Pass 2: Enumerate all of the remaining devices. */
 
-	device = NULL;
-
-	if (ACPI_SUCCESS(acpi_bus_check_add(handle, false, &device)))
-		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
-				    acpi_bus_check_add_2, NULL, NULL,
-				    (void **)&device);
-
-	acpi_bus_attach(device, NULL);
+	acpi_scan_postponed(handle);
 
 	return 0;
 }



