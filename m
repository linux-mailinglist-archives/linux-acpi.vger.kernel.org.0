Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5631EE9AF
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jun 2020 19:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgFDRqu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jun 2020 13:46:50 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47430 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbgFDRqu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jun 2020 13:46:50 -0400
Received: from 89-64-85-58.dynamic.chello.pl (89.64.85.58) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 96f3bf1fcf2b2e54; Thu, 4 Jun 2020 19:46:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <guenter@roeck-us.net>
Subject: [PATCH] kobject: Avoid premature parent object freeing in kobject_cleanup()
Date:   Thu, 04 Jun 2020 19:46:46 +0200
Message-ID: <1908555.IiAGLGrh1Z@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

If kobject_del() is invoked by kobject_cleanup() to delete the
target kobject, it may cause its parent kobject to be freed
before invoking the target kobject's ->release() method, which
effectively means freeing the parent before dealing with the
child entirely.

That is confusing at best and it may also lead to functional
issues if the callers of kobject_cleanup() are not careful enough
about the order in which these calls are made, so avoid the
problem by making kobject_cleanup() drop the last reference to
the target kobject's parent at the end, after invoking the target
kobject's ->release() method.

[ rjw: Rewrite the subject and changelog, make kobject_cleanup()
  drop the parent reference only when __kobject_del() has been
  called. ]

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: kernel test robot <rong.a.chen@intel.com>
Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Hi Greg,

This is a replacement for commit 4ef12f719802 ("kobject: Make sure the parent
does not get released before its children"), that you reverted, because it
broke things and the reason why was that it was incorrect.

Namely, it called kobject_put() on the target kobject's parent in
kobject_cleanup() unconditionally, but it should only call it after
invoking __kobject_del() on the target kobject.

That problem is fixed in this patch and a functionally equivalent patch has
been tested by Guenter without issues.

The underlying issue addressed by the reverted commit is still there and
it may show up again even though the test that triggered it originally was
fixed in the meantime.  IMO it is worth fixing even though it may not be
readily visible in the current kernel, so please consider this one for
applying.

Cheers!

---
 lib/kobject.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

Index: linux-pm/lib/kobject.c
===================================================================
--- linux-pm.orig/lib/kobject.c
+++ linux-pm/lib/kobject.c
@@ -599,14 +599,7 @@ out:
 }
 EXPORT_SYMBOL_GPL(kobject_move);
 
-/**
- * kobject_del() - Unlink kobject from hierarchy.
- * @kobj: object.
- *
- * This is the function that should be called to delete an object
- * successfully added via kobject_add().
- */
-void kobject_del(struct kobject *kobj)
+static void __kobject_del(struct kobject *kobj)
 {
 	struct kernfs_node *sd;
 	const struct kobj_type *ktype;
@@ -625,9 +618,23 @@ void kobject_del(struct kobject *kobj)
 
 	kobj->state_in_sysfs = 0;
 	kobj_kset_leave(kobj);
-	kobject_put(kobj->parent);
 	kobj->parent = NULL;
 }
+
+/**
+ * kobject_del() - Unlink kobject from hierarchy.
+ * @kobj: object.
+ *
+ * This is the function that should be called to delete an object
+ * successfully added via kobject_add().
+ */
+void kobject_del(struct kobject *kobj)
+{
+	struct kobject *parent = kobj->parent;
+
+	__kobject_del(kobj);
+	kobject_put(parent);
+}
 EXPORT_SYMBOL(kobject_del);
 
 /**
@@ -663,6 +670,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
  */
 static void kobject_cleanup(struct kobject *kobj)
 {
+	struct kobject *parent = kobj->parent;
 	struct kobj_type *t = get_ktype(kobj);
 	const char *name = kobj->name;
 
@@ -684,7 +692,10 @@ static void kobject_cleanup(struct kobje
 	if (kobj->state_in_sysfs) {
 		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
 			 kobject_name(kobj), kobj);
-		kobject_del(kobj);
+		__kobject_del(kobj);
+	} else {
+		/* avoid dropping the parent reference unnecessarily */
+		parent = NULL;
 	}
 
 	if (t && t->release) {
@@ -698,6 +709,8 @@ static void kobject_cleanup(struct kobje
 		pr_debug("kobject: '%s': free name\n", name);
 		kfree_const(name);
 	}
+
+	kobject_put(parent);
 }
 
 #ifdef CONFIG_DEBUG_KOBJECT_RELEASE



