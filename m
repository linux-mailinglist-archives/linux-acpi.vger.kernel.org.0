Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A37210A6
	for <lists+linux-acpi@lfdr.de>; Fri, 17 May 2019 00:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfEPWmv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 May 2019 18:42:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51391 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfEPWmv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 May 2019 18:42:51 -0400
Received: from 79.184.255.148.ipv4.supernova.orange.pl (79.184.255.148) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 9390007ae767d244; Fri, 17 May 2019 00:42:46 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Robert R. Howell" <RHowell@uwyo.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate on BYT/CHT
Date:   Fri, 17 May 2019 00:42:46 +0200
Message-ID: <20527023.VNImpdbrUu@kreacher>
In-Reply-To: <7eef3905-9c74-7ed8-09e4-a255c8f7d959@uwyo.edu>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com> <1588383.bXYZMuyLB9@kreacher> <7eef3905-9c74-7ed8-09e4-a255c8f7d959@uwyo.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, May 16, 2019 6:35:40 PM CEST Robert R. Howell wrote:
> Hi Rafael
> 
> 
> On 5/16/19 5:11 AM, Rafael J. Wysocki wrote:
> 
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
> Thanks for the patch.  I'm traveling right now so I'm away from the machines I need to test this, 
> but I'll be back home by the end of the week and will test the patch then.

Thanks!

It would be better to test the one appended below instead, though, so please do that.

---
 drivers/acpi/device_pm.c |    9 +--------
 drivers/pci/pci-driver.c |   12 ++----------
 2 files changed, 3 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -1119,14 +1119,7 @@ EXPORT_SYMBOL_GPL(acpi_subsys_resume_ear
  */
 int acpi_subsys_freeze(struct device *dev)
 {
-	/*
-	 * This used to be done in acpi_subsys_prepare() for all devices and
-	 * some drivers may depend on it, so do it here.  Ideally, however,
-	 * runtime-suspended devices should not be touched during freeze/thaw
-	 * transitions.
-	 */
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
-		pm_runtime_resume(dev);
+	pm_runtime_resume(dev);
 
 	return pm_generic_freeze(dev);
 }
Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -956,16 +956,8 @@ static int pci_pm_freeze(struct device *
 		return 0;
 	}
 
-	/*
-	 * This used to be done in pci_pm_prepare() for all devices and some
-	 * drivers may depend on it, so do it here.  Ideally, runtime-suspended
-	 * devices should not be touched during freeze/thaw transitions,
-	 * however.
-	 */
-	if (!dev_pm_smart_suspend_and_suspended(dev)) {
-		pm_runtime_resume(dev);
-		pci_dev->state_saved = false;
-	}
+	pm_runtime_resume(dev);
+	pci_dev->state_saved = false;
 
 	if (pm->freeze) {
 		int error;



