Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCE414DD56
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jan 2020 15:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgA3Own (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Jan 2020 09:52:43 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64267 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgA3Own (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jan 2020 09:52:43 -0500
Received: from 79.184.253.19.ipv4.supernova.orange.pl (79.184.253.19) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 0ffe0130fbb58b34; Thu, 30 Jan 2020 15:52:40 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: [PATCH] Documentation: admin-guide: PM: Update sleep states documentation
Date:   Thu, 30 Jan 2020 15:52:40 +0100
Message-ID: <1846497.NDve8E0jfu@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is some information in Documentation/power/interface.rst that
is still missing from Documentation/admin-guide/pm/sleep-states.rst
and really should be present in there, so update the latter by
adding that information to it and delete the former (as it becomes
redundant after that and it is somewhat outdated).

While at it, clean up some assorted pieces of sleep-states.rst a bit.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/sleep-states.rst |   76 +++++++++++++++++++------
 Documentation/power/interface.rst             |   79 --------------------------
 2 files changed, 59 insertions(+), 96 deletions(-)

Index: linux-pm/Documentation/admin-guide/pm/sleep-states.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/sleep-states.rst
+++ linux-pm/Documentation/admin-guide/pm/sleep-states.rst
@@ -153,8 +153,11 @@ for the given CPU architecture includes
 Basic ``sysfs`` Interfaces for System Suspend and Hibernation
 =============================================================
 
-The following files located in the :file:`/sys/power/` directory can be used by
-user space for sleep states control.
+The power management subsystem provides userspace with a unified ``sysfs``
+interface for system sleep regardless of the underlying system architecture or
+platform.  That interface is located in the :file:`/sys/power/` directory
+(assuming that ``sysfs`` is mounted at :file:`/sys`) and it consists of the
+following attributes (files):
 
 ``state``
 	This file contains a list of strings representing sleep states supported
@@ -162,9 +165,9 @@ user space for sleep states control.
 	to start a transition of the system into the sleep state represented by
 	that string.
 
-	In particular, the strings "disk", "freeze" and "standby" represent the
+	In particular, the "disk", "freeze" and "standby" strings represent the
 	:ref:`hibernation <hibernation>`, :ref:`suspend-to-idle <s2idle>` and
-	:ref:`standby <standby>` sleep states, respectively.  The string "mem"
+	:ref:`standby <standby>` sleep states, respectively.  The "mem" string
 	is interpreted in accordance with the contents of the ``mem_sleep`` file
 	described below.
 
@@ -177,7 +180,7 @@ user space for sleep states control.
 	associated with the "mem" string in the ``state`` file described above.
 
 	The strings that may be present in this file are "s2idle", "shallow"
-	and "deep".  The string "s2idle" always represents :ref:`suspend-to-idle
+	and "deep".  The "s2idle" string always represents :ref:`suspend-to-idle
 	<s2idle>` and, by convention, "shallow" and "deep" represent
 	:ref:`standby <standby>` and :ref:`suspend-to-RAM <s2ram>`,
 	respectively.
@@ -185,15 +188,17 @@ user space for sleep states control.
 	Writing one of the listed strings into this file causes the system
 	suspend variant represented by it to be associated with the "mem" string
 	in the ``state`` file.  The string representing the suspend variant
-	currently associated with the "mem" string in the ``state`` file
-	is listed in square brackets.
+	currently associated with the "mem" string in the ``state`` file is
+	shown in square brackets.
 
 	If the kernel does not support system suspend, this file is not present.
 
 ``disk``
-	This file contains a list of strings representing different operations
-	that can be carried out after the hibernation image has been saved.  The
-	possible options are as follows:
+	This file controls the operating mode of hibernation (Suspend-to-Disk).
+	Specifically, it tells the kernel what to do after creating a
+	hibernation image.
+
+	Reading from it returns a list of supported options encoded as:
 
 	``platform``
 		Put the system into a special low-power state (e.g. ACPI S4) to
@@ -201,6 +206,11 @@ user space for sleep states control.
 		platform firmware to take a simplified initialization path after
 		wakeup.
 
+		It is only available if the platform provides a special
+		mechanism to put the system to sleep after creating a
+		hibernation image (platforms with ACPI do that as a rule, for
+		example).
+
 	``shutdown``
 		Power off the system.
 
@@ -214,22 +224,53 @@ user space for sleep states control.
 		the hibernation image and continue.  Otherwise, use the image
 		to restore the previous state of the system.
 
+		It is available if system suspend is supported.
+
 	``test_resume``
 		Diagnostic operation.  Load the image as though the system had
 		just woken up from hibernation and the currently running kernel
 		instance was a restore kernel and follow up with full system
 		resume.
 
-	Writing one of the listed strings into this file causes the option
+	Writing one of the strings listed above into this file causes the option
 	represented by it to be selected.
 
-	The currently selected option is shown in square brackets which means
+	The currently selected option is shown in square brackets, which means
 	that the operation represented by it will be carried out after creating
-	and saving the image next time hibernation is triggered by writing
-	``disk`` to :file:`/sys/power/state`.
+	and saving the image when hibernation is triggered by writing ``disk``
+	to :file:`/sys/power/state`.
 
 	If the kernel does not support hibernation, this file is not present.
 
+``image_size``
+	This file controls the size of hibernation images.
+
+	It can be written a string representing a non-negative integer that will
+	be used as a best-effort upper limit of the image size, in bytes.  The
+	hibernation core will do its best to ensure that the image size will not
+	exceed that number, but if that turns out to be impossible to achieve, a
+	hibernation image will still be created and its size will be as small as
+	possible.  In particular, writing '0' to this file causes the size of
+	hibernation images to be minimum.
+
+	Reading from it returns the current image size limit, which is set to
+	around 2/5 of the available RAM size by default.
+
+``pm_trace``
+	This file controls the "PM trace" mechanism saving the last suspend
+	or resume event point in the RTC memory across reboots.  It helps to
+	debug hard lockups or reboots due to device driver failures that occur
+	during system suspend or resume (which is more common) more effectively.
+
+	If it contains "1", the fingerprint of each suspend/resume event point
+	in turn will be stored in the RTC memory (overwriting the actual RTC
+	information), so it will survive a system crash if one occurs right
+	after storing it and it can be used later to identify the driver that
+	caused the crash to happen.
+
+	It contains "0" by default, which may be changed to "1" by writing a
+	string representing a nonzero integer into it.
+
 According to the above, there are two ways to make the system go into the
 :ref:`suspend-to-idle <s2idle>` state.  The first one is to write "freeze"
 directly to :file:`/sys/power/state`.  The second one is to write "s2idle" to
@@ -244,6 +285,7 @@ system go into the :ref:`suspend-to-RAM
 The default suspend variant (ie. the one to be used without writing anything
 into :file:`/sys/power/mem_sleep`) is either "deep" (on the majority of systems
 supporting :ref:`suspend-to-RAM <s2ram>`) or "s2idle", but it can be overridden
-by the value of the "mem_sleep_default" parameter in the kernel command line.
-On some ACPI-based systems, depending on the information in the ACPI tables, the
-default may be "s2idle" even if :ref:`suspend-to-RAM <s2ram>` is supported.
+by the value of the ``mem_sleep_default`` parameter in the kernel command line.
+On some systems with ACPI, depending on the information in the ACPI tables, the
+default may be "s2idle" even if :ref:`suspend-to-RAM <s2ram>` is supported in
+principle.
Index: linux-pm/Documentation/power/interface.rst
===================================================================
--- linux-pm.orig/Documentation/power/interface.rst
+++ /dev/null
@@ -1,79 +0,0 @@
-===========================================
-Power Management Interface for System Sleep
-===========================================
-
-Copyright (c) 2016 Intel Corp., Rafael J. Wysocki <rafael.j.wysocki@intel.com>
-
-The power management subsystem provides userspace with a unified sysfs interface
-for system sleep regardless of the underlying system architecture or platform.
-The interface is located in the /sys/power/ directory (assuming that sysfs is
-mounted at /sys).
-
-/sys/power/state is the system sleep state control file.
-
-Reading from it returns a list of supported sleep states, encoded as:
-
-- 'freeze' (Suspend-to-Idle)
-- 'standby' (Power-On Suspend)
-- 'mem' (Suspend-to-RAM)
-- 'disk' (Suspend-to-Disk)
-
-Suspend-to-Idle is always supported.  Suspend-to-Disk is always supported
-too as long the kernel has been configured to support hibernation at all
-(ie. CONFIG_HIBERNATION is set in the kernel configuration file).  Support
-for Suspend-to-RAM and Power-On Suspend depends on the capabilities of the
-platform.
-
-If one of the strings listed in /sys/power/state is written to it, the system
-will attempt to transition into the corresponding sleep state.  Refer to
-Documentation/admin-guide/pm/sleep-states.rst for a description of each of
-those states.
-
-/sys/power/disk controls the operating mode of hibernation (Suspend-to-Disk).
-Specifically, it tells the kernel what to do after creating a hibernation image.
-
-Reading from it returns a list of supported options encoded as:
-
-- 'platform' (put the system into sleep using a platform-provided method)
-- 'shutdown' (shut the system down)
-- 'reboot' (reboot the system)
-- 'suspend' (trigger a Suspend-to-RAM transition)
-- 'test_resume' (resume-after-hibernation test mode)
-
-The currently selected option is printed in square brackets.
-
-The 'platform' option is only available if the platform provides a special
-mechanism to put the system to sleep after creating a hibernation image (ACPI
-does that, for example).  The 'suspend' option is available if Suspend-to-RAM
-is supported.  Refer to Documentation/power/basic-pm-debugging.rst for the
-description of the 'test_resume' option.
-
-To select an option, write the string representing it to /sys/power/disk.
-
-/sys/power/image_size controls the size of hibernation images.
-
-It can be written a string representing a non-negative integer that will be
-used as a best-effort upper limit of the image size, in bytes.  The hibernation
-core will do its best to ensure that the image size will not exceed that number.
-However, if that turns out to be impossible to achieve, a hibernation image will
-still be created and its size will be as small as possible.  In particular,
-writing '0' to this file will enforce hibernation images to be as small as
-possible.
-
-Reading from this file returns the current image size limit, which is set to
-around 2/5 of available RAM by default.
-
-/sys/power/pm_trace controls the PM trace mechanism saving the last suspend
-or resume event point in the RTC across reboots.
-
-It helps to debug hard lockups or reboots due to device driver failures that
-occur during system suspend or resume (which is more common) more effectively.
-
-If /sys/power/pm_trace contains '1', the fingerprint of each suspend/resume
-event point in turn will be stored in the RTC memory (overwriting the actual
-RTC information), so it will survive a system crash if one occurs right after
-storing it and it can be used later to identify the driver that caused the crash
-to happen (see Documentation/power/s2ram.rst for more information).
-
-Initially it contains '0' which may be changed to '1' by writing a string
-representing a nonzero integer into it.



