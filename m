Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14DAE508DA
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2019 12:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfFXKYY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jun 2019 06:24:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63533 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfFXKYX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jun 2019 06:24:23 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 58dfb260c6f90a5e; Mon, 24 Jun 2019 12:24:19 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Robert R. Howell" <RHowell@uwyo.edu>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate on BYT/CHT
Date:   Mon, 24 Jun 2019 12:24:19 +0200
Message-ID: <2830645.pXxymQ5XCC@kreacher>
In-Reply-To: <e650be02-ec9b-742e-b34f-7944631107b5@uwyo.edu>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com> <1588383.bXYZMuyLB9@kreacher> <e650be02-ec9b-742e-b34f-7944631107b5@uwyo.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Saturday, May 25, 2019 7:31:20 AM CEST Robert R. Howell wrote:
> On 5/16/19 5:11 AM, Rafael J. Wysocki wrote:
> > 
> > On Thursday, April 25, 2019 6:38:34 PM CEST Robert R. Howell wrote:
> >> On 4/24/19 1:20 AM, Rafael J. Wysocki wrote:
> >>
> >>> On Tue, Apr 23, 2019 at 10:03 PM Robert R. Howell <RHowell@uwyo.edu> wrote:
> >>>>
> >>>> On 4/23/19 2:07 AM, Rafael J. Wysocki wrote:
> >>>>>
> >>>>> On Sat, Apr 20, 2019 at 12:44 AM Robert R. Howell <RHowell@uwyo.edu> wrote:
> >>>>>>
> >>>>>> On 4/18/19 5:42 AM, Hans de Goede wrote:
> >>>>>>
> >>>>>>>> On 4/8/19 2:16 AM, Hans de Goede wrote:>
> >>>>>>>>>
> >>>>>>>>> Hmm, interesting so you have hibernation working on a T100TA
> >>>>>>>>> (with 5.0 + 02e45646d53b reverted), right ?
> >>>>>>>>>
> >>>>>>
> >>>>>>
> >>>>>> I've managed to find a way around the i2c_designware timeout issues
> >>>>>> on the T100TA's.  The key is to NOT set DPM_FLAG_SMART_SUSPEND,
> >>>>>> which was added in the 02e45646d53b commit.
> >>>>>>
> >>>>>> To test that I've started with a 5.1-rc5 kernel, applied your recent patch
> >>>>>> to acpi_lpss.c, then apply the following patch of mine, removing
> >>>>>> DPM_FLAG_SMART_SUSPEND.  (For the T100 hardware I need to apply some
> >>>>>> other patches as well but those are not related to the i2c-designware or
> >>>>>> acpi issues addressed here.)
> >>>>>>
> >>>>>> On a resume from hibernation I still see one error:
> >>>>>>   "i2c_designware 80860F41:00: Error i2c_dw_xfer called while suspended"
> >>>>>> but I no longer get the i2c_designware timeouts, and audio does now work
> >>>>>> after the resume.
> >>>>>>
> >>>>>> Removing DPM_FLAG_SMART_SUSPEND may not be what you want for other
> >>>>>> hardware, but perhaps this will give you a clue as to what is going
> >>>>>> wrong with hibernate/resume on the T100TA's.
> >>>>>
> >>>>> What if you drop DPM_FLAG_LEAVE_SUSPENDED alone instead?
> >>>>>
> >>>>
> >>>> I did try dropping just DPM_FLAG_LEAVE_SUSPENDED, dropping just
> >>>> DPM_FLAG_SMART_SUSPEND, and dropping both flags.  When I just drop
> >>>> DPM_FLAG_LEAVE_SUSPENDED I still get the i2c_designware timeouts
> >>>> after the resume.  If I drop just DPM_FLAG_SMART_SUSPEND or drop both,
> >>>> then the timeouts go away.
> >>>
> >>> OK, thanks!
> >>>
> >>> Is non-hibernation system suspend affected too?
> >>
> >> I just ran some tests on a T100TA, using the 5.1-rc5 code with Hans' patch applied
> >> but without any changes to i2c-designware-platdrv.c, so the
> >> DPM_FLAG_SMART_PREPARE, DPM_FLAG_SMART_SUSPEND, and DPM_FLAG_LEAVE_SUSPENDED flags
> >> are all set.
> >>
> >> Suspend does work OK, and after resume I do NOT get any of the crippling
> >> i2c_designware timeout errors which cause sound to fail after hibernate.  I DO see one
> >>   "i2c_designware 80860F41:00: Error i2c_dw_xfer call while suspended"
> >> error on resume, just as I do on hibernate.  I've attached a portion of dmesg below.
> >> The "asus_wmi:  Unknown key 79 pressed" error is a glitch which occurs
> >> intermittently on these machines, but doesn't seem related to the other issues.
> >> I had one test run when it was absent but the rest of the messages were the
> >> same -- but then kept getting that unknown key error on all my later tries.
> >>
> >> I did notice the "2sidle" in the following rather than "shallow" or "deep".  A
> >> cat of /sys/power/state shows "freeze mem disk" but a
> >> cat of /sys/power/mem_sleep" shows only "[s2idle] so it looks like shallow and deep
> >> are not enabled for this system.  I did check the input power (or really current)
> >> as it went into suspend and the micro-usb power input drops from about
> >> 0.5 amps to 0.05 amps.  But clearly a lot of devices are still active, as movement
> >> of a bluetooth mouse (the MX Anywhere 2) will wake it from suspend.  That presumably is
> >> why suspend doesn't trigger the same i2c_designware problems as hibernate.
> >>
> >> Let me know if I can do any other tests.
> > 
> > Can you please check if the appended patch makes the hibernate issue go away for you, without any other changes?
> > 
> > ---
> >  drivers/pci/pci-driver.c |   36 ++++++++++--------------------------
> >  1 file changed, 10 insertions(+), 26 deletions(-)
> > 
> > Index: linux-pm/drivers/pci/pci-driver.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pci-driver.c
> > +++ linux-pm/drivers/pci/pci-driver.c
> > @@ -957,15 +957,14 @@ static int pci_pm_freeze(struct device *
> >         }
> > 
> >         /*
> > -        * This used to be done in pci_pm_prepare() for all devices and some
> > -        * drivers may depend on it, so do it here.  Ideally, runtime-suspended
> > -        * devices should not be touched during freeze/thaw transitions,
> > -        * however.
> > +        * Resume all runtime-suspended devices before creating a snapshot
> > +        * image of system memory, because the restore kernel generally cannot
> > +        * be expected to always handle them consistently and pci_pm_restore()
> > +        * always leaves them as "active", so ensure that the state saved in the
> > +        * image will always be consistent with that.
> >          */
> > -       if (!dev_pm_smart_suspend_and_suspended(dev)) {
> > -               pm_runtime_resume(dev);
> > -               pci_dev->state_saved = false;
> > -       }
> > +       pm_runtime_resume(dev);
> > +       pci_dev->state_saved = false;
> > 
> >         if (pm->freeze) {
> >                 int error;
> > @@ -992,9 +991,6 @@ static int pci_pm_freeze_noirq(struct de
> >         struct pci_dev *pci_dev = to_pci_dev(dev);
> >         struct device_driver *drv = dev->driver;
> > 
> > -       if (dev_pm_smart_suspend_and_suspended(dev))
> > -               return 0;
> > -
> >         if (pci_has_legacy_pm_support(pci_dev))
> >                 return pci_legacy_suspend_late(dev, PMSG_FREEZE);
> > 
> > @@ -1024,16 +1020,6 @@ static int pci_pm_thaw_noirq(struct devi
> >         struct device_driver *drv = dev->driver;
> >         int error = 0;
> > 
> > -       /*
> > -        * If the device is in runtime suspend, the code below may not work
> > -        * correctly with it, so skip that code and make the PM core skip all of
> > -        * the subsequent "thaw" callbacks for the device.
> > -        */
> > -       if (dev_pm_smart_suspend_and_suspended(dev)) {
> > -               dev_pm_skip_next_resume_phases(dev);
> > -               return 0;
> > -       }
> > -
> >         if (pcibios_pm_ops.thaw_noirq) {
> >                 error = pcibios_pm_ops.thaw_noirq(dev);
> >                 if (error)
> > @@ -1093,8 +1079,10 @@ static int pci_pm_poweroff(struct device
> > 
> >         /* The reason to do that is the same as in pci_pm_suspend(). */
> >         if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
> > -           !pci_dev_keep_suspended(pci_dev))
> > +           !pci_dev_keep_suspended(pci_dev)) {
> >                 pm_runtime_resume(dev);
> > +               pci_dev->state_saved = false;
> > +       }
> > 
> >         pci_dev->state_saved = false;
> >         if (pm->poweroff) {
> > @@ -1168,10 +1156,6 @@ static int pci_pm_restore_noirq(struct d
> >         struct device_driver *drv = dev->driver;
> >         int error = 0;
> > 
> > -       /* This is analogous to the pci_pm_resume_noirq() case. */
> > -       if (dev_pm_smart_suspend_and_suspended(dev))
> > -               pm_runtime_set_active(dev);
> > -
> >         if (pcibios_pm_ops.restore_noirq) {
> >                 error = pcibios_pm_ops.restore_noirq(dev);
> >                 if (error)
> > 
> > 
> > 
> 
> I've finally managed to complete a reasonable set of tests on my T100TA using your 
> 2nd patch from above, and on a 5.1.4 based kernel with ONLY this patch applied I can 
> successfully suspend and hibernate the system. 

Sorry for the long delay.

I haven't dropped this issue on the floor, I hope that you are still able to follow up here.

Can you please test the appended patch instead of the previous one?

I have found some inconsistencies in the handling of hibernation in the ACPI PM domain
and the LPSS driver that should be covered by this patch.

---
 drivers/acpi/acpi_lpss.c |   63 +++++++++++++++++++++++++++++++++++------------
 drivers/acpi/device_pm.c |   30 ++++++++++++++++++++--
 include/linux/acpi.h     |    4 ++
 3 files changed, 79 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -1171,6 +1171,32 @@ int acpi_subsys_thaw_noirq(struct device
 	return pm_generic_thaw_noirq(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_thaw_noirq);
+
+/**
+ * acpi_subsys_restore_noirq - Run the device driver's "noirq" restore callback.
+ * @dev: Device to handle.
+ */
+int acpi_subsys_restore_noirq(struct device *dev)
+{
+	/* This is analogous to what acpi_subsys_resune_noirq() does. */
+	if (dev_pm_smart_suspend_and_suspended(dev))
+		pm_runtime_set_active(dev);
+
+	return pm_generic_restore_noirq(dev);
+}
+EXPORT_SYMBOL_GPL(acpi_subsys_restore_noirq);
+
+/**
+ * acpi_subsys_restore_early - Restore device using ACPI.
+ * @dev: Device to restore.
+ */
+int acpi_subsys_restore_early(struct device *dev)
+{
+	int ret = acpi_dev_resume(dev);
+	return ret ? ret : pm_generic_restore_early(dev);
+}
+EXPORT_SYMBOL_GPL(acpi_subsys_restore_early);
+
 #endif /* CONFIG_PM_SLEEP */
 
 static struct dev_pm_domain acpi_general_pm_domain = {
@@ -1192,8 +1218,8 @@ static struct dev_pm_domain acpi_general
 		.poweroff = acpi_subsys_suspend,
 		.poweroff_late = acpi_subsys_suspend_late,
 		.poweroff_noirq = acpi_subsys_suspend_noirq,
-		.restore_noirq = acpi_subsys_resume_noirq,
-		.restore_early = acpi_subsys_resume_early,
+		.restore_noirq = acpi_subsys_restore_noirq,
+		.restore_early = acpi_subsys_restore_early,
 #endif
 	},
 };
Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -1069,36 +1069,67 @@ static int acpi_lpss_suspend_noirq(struc
 	return acpi_subsys_suspend_noirq(dev);
 }
 
-static int acpi_lpss_do_resume_early(struct device *dev)
+static int acpi_lpss_resume_noirq(struct device *dev)
 {
-	int ret = acpi_lpss_resume(dev);
+	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
+
+	/* Follow acpi_subsys_resune_noirq(). */
+	if (dev_pm_may_skip_resume(dev))
+		return 0;
+
+	if (dev_pm_smart_suspend_and_suspended(dev))
+		pm_runtime_set_active(dev);
 
-	return ret ? ret : pm_generic_resume_early(dev);
+	if (pdata->dev_desc->resume_from_noirq) {
+		int ret = acpi_lpss_resume(dev);
+		if (ret)
+			return ret;
+	}
+
+	return pm_generic_resume_noirq(dev);
 }
 
 static int acpi_lpss_resume_early(struct device *dev)
 {
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 
-	if (pdata->dev_desc->resume_from_noirq)
-		return 0;
+	if (!pdata->dev_desc->resume_from_noirq) {
+		int ret = acpi_lpss_resume(dev);
+		if (ret)
+			return ret;
+	}
 
-	return acpi_lpss_do_resume_early(dev);
+	return pm_generic_resume_early(dev);
 }
 
-static int acpi_lpss_resume_noirq(struct device *dev)
+static int acpi_lpss_restore_noirq(struct device *dev)
 {
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
-	int ret;
 
-	ret = acpi_subsys_resume_noirq(dev);
-	if (ret)
-		return ret;
+	/* Follow acpi_subsys_restore_noirq(). */
+	if (dev_pm_smart_suspend_and_suspended(dev))
+		pm_runtime_set_active(dev);
+
+	if (pdata->dev_desc->resume_from_noirq) {
+		int ret = acpi_lpss_resume(dev);
+		if (ret)
+			return ret;
+	}
+
+	return pm_generic_restore_noirq(dev);
+}
+
+static int acpi_lpss_restore_early(struct device *dev)
+{
+	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 
-	if (!dev_pm_may_skip_resume(dev) && pdata->dev_desc->resume_from_noirq)
-		ret = acpi_lpss_do_resume_early(dev);
+	if (!pdata->dev_desc->resume_from_noirq) {
+		int ret = acpi_lpss_resume(dev);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
+	return pm_generic_restore_early(dev);
 }
 
 #endif /* CONFIG_PM_SLEEP */
@@ -1140,8 +1171,8 @@ static struct dev_pm_domain acpi_lpss_pm
 		.poweroff = acpi_subsys_suspend,
 		.poweroff_late = acpi_lpss_suspend_late,
 		.poweroff_noirq = acpi_lpss_suspend_noirq,
-		.restore_noirq = acpi_lpss_resume_noirq,
-		.restore_early = acpi_lpss_resume_early,
+		.restore_noirq = acpi_lpss_restore_noirq,
+		.restore_early = acpi_lpss_restore_early,
 #endif
 		.runtime_suspend = acpi_lpss_runtime_suspend,
 		.runtime_resume = acpi_lpss_runtime_resume,
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -925,6 +925,8 @@ int acpi_subsys_freeze(struct device *de
 int acpi_subsys_freeze_late(struct device *dev);
 int acpi_subsys_freeze_noirq(struct device *dev);
 int acpi_subsys_thaw_noirq(struct device *dev);
+int acpi_subsys_restore_noirq(struct device *dev);
+int acpi_subsys_restore_early(struct device *dev);
 #else
 static inline int acpi_dev_resume_early(struct device *dev) { return 0; }
 static inline int acpi_subsys_prepare(struct device *dev) { return 0; }
@@ -938,6 +940,8 @@ static inline int acpi_subsys_freeze(str
 static inline int acpi_subsys_freeze_late(struct device *dev) { return 0; }
 static inline int acpi_subsys_freeze_noirq(struct device *dev) { return 0; }
 static inline int acpi_subsys_thaw_noirq(struct device *dev) { return 0; }
+static inline int acpi_subsys_restore_noirq(struct device *dev) { return 0; }
+static inline int acpi_subsys_restore_early(struct device *dev) { return 0; }
 #endif
 
 #ifdef CONFIG_ACPI



