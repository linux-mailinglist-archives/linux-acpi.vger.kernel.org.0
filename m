Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D8A21A2D8
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jul 2020 16:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgGIO5R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jul 2020 10:57:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41066 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgGIO5R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jul 2020 10:57:17 -0400
Received: from 89-64-83-236.dynamic.chello.pl (89.64.83.236) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 6f4b9f3a7ac1aaf9; Thu, 9 Jul 2020 16:57:14 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and callback for firmware activation
Date:   Thu, 09 Jul 2020 16:57:12 +0200
Message-ID: <23449996.3uVv1d17cZ@kreacher>
In-Reply-To: <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com> <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, July 7, 2020 3:59:32 AM CEST Dan Williams wrote:
> The runtime firmware activation capability of Intel NVDIMM devices
> requires memory transactions to be disabled for 100s of microseconds.
> This timeout is large enough to cause in-flight DMA to fail and other
> application detectable timeouts. Arrange for firmware activation to be
> executed while the system is "quiesced", all processes and device-DMA
> frozen.
> 
> It is already required that invoking device ->freeze() callbacks is
> sufficient to cease DMA. A device that continues memory writes outside
> of user-direction violates expectations of the PM core to be to
> establish a coherent hibernation image.
> 
> That said, RDMA devices are an example of a device that access memory
> outside of user process direction. RDMA drivers also typically assume
> the system they are operating in will never be hibernated. A solution
> for RDMA collisions with firmware activation is outside the scope of
> this change and may need to rely on being able to survive the platform
> imposed memory controller quiesce period.

Thanks for following my suggestion to use the hibernation infrastructure
rather than the suspend one, but I think it would be better to go a bit
further with that.

Namely, after thinking about this a bit more I have come to the conclusion
that what is needed is an ability to execute a function, inside of the
kernel, in a "quiet" environment in which memory updates are unlikely.

While the hibernation infrastructure as is can be used for that, kind of, IMO
it would be cleaner to introduce a helper for that, like in the (untested)
patch below, so if the "quiet execution environment" is needed, whoever
needs it may simply pass a function to hibernate_quiet_exec() and provide
whatever user-space I/F is suitable on top of that.

Please let me know what you think.

Cheers!

---
 include/linux/suspend.h  |    6 ++
 kernel/power/hibernate.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

Index: linux-pm/kernel/power/hibernate.c
===================================================================
--- linux-pm.orig/kernel/power/hibernate.c
+++ linux-pm/kernel/power/hibernate.c
@@ -795,6 +795,103 @@ int hibernate(void)
 	return error;
 }
 
+/**
+ * hibernate_quiet_exec - Execute a function with all devices frozen.
+ * @func: Function to execute.
+ * @data: Data pointer to pass to @func.
+ *
+ * Return the @func return value or an error code if it cannot be executed.
+ */
+int hibernate_quiet_exec(int (*func)(void *data), void *data)
+{
+	int error, nr_calls = 0;
+
+	lock_system_sleep();
+
+	if (!hibernate_acquire()) {
+		error = -EBUSY;
+		goto unlock;
+	}
+
+	pm_prepare_console();
+
+	error = __pm_notifier_call_chain(PM_HIBERNATION_PREPARE, -1, &nr_calls);
+	if (error) {
+		nr_calls--;
+		goto exit;
+	}
+
+	error = freeze_processes();
+	if (error)
+		goto exit;
+
+	lock_device_hotplug();
+
+	pm_suspend_clear_flags();
+
+	error = platform_begin(true);
+	if (error)
+		goto thaw;
+
+	error = freeze_kernel_threads();
+	if (error)
+		goto thaw;
+
+	error = dpm_prepare(PMSG_FREEZE);
+	if (error)
+		goto dpm_complete;
+
+	suspend_console();
+
+	error = dpm_suspend(PMSG_FREEZE);
+	if (error)
+		goto dpm_resume;
+
+	error = dpm_suspend_end(PMSG_FREEZE);
+	if (error)
+		goto dpm_resume;
+
+	error = platform_pre_snapshot(true);
+	if (error)
+		goto skip;
+
+	error = func(data);
+
+skip:
+	platform_finish(true);
+
+	dpm_resume_start(PMSG_THAW);
+
+dpm_resume:
+	dpm_resume(PMSG_THAW);
+
+	resume_console();
+
+dpm_complete:
+	dpm_complete(PMSG_THAW);
+
+	thaw_kernel_threads();
+
+thaw:
+	platform_end(true);
+
+	unlock_device_hotplug();
+
+	thaw_processes();
+
+exit:
+	__pm_notifier_call_chain(PM_POST_HIBERNATION, nr_calls, NULL);
+
+	pm_restore_console();
+
+	hibernate_release();
+
+unlock:
+	unlock_system_sleep();
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(hibernate_quiet_exec);
 
 /**
  * software_resume - Resume from a saved hibernation image.
Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -453,6 +453,8 @@ extern bool hibernation_available(void);
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
 int pfn_is_nosave(unsigned long pfn);
+
+int hibernate_quiet_exec(int (*func)(void *data), void *data);
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
 static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
@@ -464,6 +466,10 @@ static inline void hibernation_set_ops(c
 static inline int hibernate(void) { return -ENOSYS; }
 static inline bool system_entering_hibernation(void) { return false; }
 static inline bool hibernation_available(void) { return false; }
+
+static inline hibernate_quiet_exec(int (*func)(void *data), void *data) {
+	return -ENOTSUPP;
+}
 #endif /* CONFIG_HIBERNATION */
 
 #ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV



