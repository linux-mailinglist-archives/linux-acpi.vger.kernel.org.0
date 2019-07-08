Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105E6629D7
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jul 2019 21:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404188AbfGHToy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 8 Jul 2019 15:44:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:7529 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729234AbfGHTox (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Jul 2019 15:44:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 12:44:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="scan'208";a="248923840"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2019 12:44:52 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 8 Jul 2019 12:44:52 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.186]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.114]) with mapi id 14.03.0439.000;
 Mon, 8 Jul 2019 12:44:51 -0700
From:   "Saha, Shaunak" <shaunak.saha@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Mario Limonciello <mario_limonciello@dell.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: drivers/acpi: Change the lpit function call flow
Thread-Topic: drivers/acpi: Change the lpit function call flow
Thread-Index: AQHVFAKLmGZKFQG42U6YI0ymKhLSm6aarbsAgAcDvoD///8ipIABjtKAgB4jZrg=
Date:   Mon, 8 Jul 2019 19:44:51 +0000
Message-ID: <593AE8A18AD46543B92D8EF146E2AA9408C4CDC1@ORSMSX107.amr.corp.intel.com>
References: <20190526202750.4614-1-shaunak.saha@intel.com>
 <2151762.asltZFE8WJ@kreacher>
 <CAJZ5v0iHRzC=ewqUTa_VUdJ2NOztnP+hDYBeJLtfDydArPkkeA@mail.gmail.com>
 <593AE8A18AD46543B92D8EF146E2AA9408C326BA@ORSMSX107.amr.corp.intel.com>,<CAJZ5v0i7AT5Abkpudk+t-aid6wiCMkrBYE2y8xVY1XS9Ggqf-A@mail.gmail.com>
In-Reply-To: <CAJZ5v0i7AT5Abkpudk+t-aid6wiCMkrBYE2y8xVY1XS9Ggqf-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.3.86.137]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks a lot for your time to review and test this patch. Here are some explanation why we started to look into the LPIT call flow and the outcome.

Problem statement:
--------------------
We are working on a chrome book using wilco ec. For this ec we have the _DSM implemented in the asl code for the s0ix entry/exit. We are seeing that while going to suspend in the suspend path system resumes and then goes back to suspend again. In mosys eventlog which shows the smbios info we see 2 entries for suspend entry/exit. Also when sdcard is inserted s0ix fails. 


Debug:
-----------
Initially I suspected that executing the DSM calls too early in suspend path is causing this. But as you reviewed the patch and mentioned that early call cannot really casue the issue. On further debug i found that In the ec polling from the ec transaction we check the guarding period before polling ec status. In the guarding period ec does busy/wait polling. Before entering the noirq stage always wait polling is done and noirq is called by PM after the LPIT dsm is executed. In the scenerio where ec is noisy and we try
to execute the LPIT dsm call ec does wait polling and calls wait_event_timeout till transaction is completed which results in wake up events. 
Here in our scenerio We are seeing an EC interrupt after setting the EC RAM offset that indicates that the EC should transition to S0ix mode and this is preventing the kernel from going into S0ix on the first try. In the kernel code for advance_transaction adding some extra condition/debug i saw that it is doing some extra loop based on what it reads from the ec ram.

Solution:
----------
As a workaround if we read back from the EC RAM while still in the _DSM handler it seems to prevent this problem. 
Also i tried the below patch where i made ec to enter the busy polling stage for the entire LPIT dsm transaction.

 drivers/acpi/ec.c       | 6 ++++++
 drivers/acpi/internal.h | 1 +
 drivers/acpi/sleep.c    | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 49e16f0..cda1b58 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1070,6 +1070,12 @@ void acpi_ec_set_gpe_wake_mask(u8 action)
        if (first_ec && !ec_no_wakeup)
                acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
 }
+void acpi_ec_set_busy_polling(bool polling_state)
+{
+       struct acpi_ec *ec = first_ec;
+       /* When set to true ec does not perform the wait polling */
+       ec->busy_polling = polling_state;
+}

 void acpi_ec_dispatch_gpe(void)
 {
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index f59d0b9..9aee878 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -190,6 +190,7 @@ void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
 void acpi_ec_mark_gpe_for_wake(void);
 void acpi_ec_set_gpe_wake_mask(u8 action);
+void acpi_ec_set_busy_polling(bool polling_state);
 void acpi_ec_dispatch_gpe(void);
 int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
                              acpi_handle handle, acpi_ec_query_func func,
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 6bd58d7..8599c33 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -903,11 +903,13 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func)
        if (!(lps0_dsm_func_mask & (1 << func)))
                return;

+       acpi_ec_set_busy_polling(true);
        out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, 1, func, NULL);
        ACPI_FREE(out_obj);

        acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
                          func, out_obj ? "successful" : "failed");
+       acpi_ec_set_busy_polling(false);
 }

Please review and suggest if this kernel change can be an acceptable solution.

________________________________________
From: Rafael J. Wysocki [rafael@kernel.org]
Sent: Wednesday, June 19, 2019 1:29 AM
To: Saha, Shaunak
Cc: Rafael J. Wysocki; Mario Limonciello; ACPI Devel Maling List
Subject: Re: drivers/acpi: Change the lpit function call flow

On Wed, Jun 19, 2019 at 7:33 AM Saha, Shaunak <shaunak.saha@intel.com> wrote:
>
> Hi Rafael,
>
> Thanks for your review comments. Agreed that this patch needs to be fixed. I am working on it.
> 1.First off, aborting system suspend because S0ix constraints are not met is a non-starter.  The kernel really cannot refuse to suspend the system for  that reason (and diagnostics can be done after resume anyway).
>
> For this as the LPIT specs says "_DSM function may be invoked when the OS state has reached sufficient criteria
> for processor idle state entry matching Entry Trigger defined in LPIT" then  to check that entry trigger from before calling the sleep function would be better approach. Will report an error if that is not met and still go to suspend. Is that a proper way to handle this? please suggest.
>
> 2. Second, according to my knowledge, it is not a bug to invoke the ACPI_LPS0_ENTRY _DSM when the constraints are not met.  Do you actually know about any platforms where that may cause real problems to occur?
>
> Actually in the present platform i m working we are seeing the failure to go to suspend whenever this _DSM methods are called. But as you correctly mentioned i found that the bug was not because this function was called early but it's happening because in our case ec seems to be bit noisy and that's why it's coming out of suspend too early. Something is going wrong in the ec polling function it seems in this case.
>
> 3. Finally, it is too late to invoke that _DSM from acpi_s2idle_sync(), because that is called after leaving S0ix and resuming some devices.
>
> Agreed. I think moving the call of DSM from s2idle_enter is better if we decide to move it a later stage

As I have just tested on one of my systems, moving the invocation of
the ACPI_LPS0_ENTRY _DSM to a later stage causes problems to happen
(spurious wakeups generated by the EC), so this generally doesn't
work.

I thus don't see a reason to change the code in the area at hand.



> ________________________________________
> From: Rafael J. Wysocki [rafael@kernel.org]
> Sent: Tuesday, June 18, 2019 1:44 AM
> To: Mario Limonciello
> Cc: Saha, Shaunak; ACPI Devel Maling List
> Subject: Re: drivers/acpi: Change the lpit function call flow
>
> On Thu, Jun 13, 2019 at 11:37 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Sunday, May 26, 2019 10:27:50 PM CEST Shaunak Saha wrote:
> > > In the present implementation sleep function was getting called in
> > > acpi_s2idle_prepare and as all the devices may not have suspended
> > > at that stage e.g. if we are telling ec about the S0ix then calling early
> > > can cause ec reply wrongly interpreted as spurious wake events.
> > > Here we call it at much later stage in acpi_s2idle_sync. As per the
> > > specification the entry _DSM function may be invoked when the OS state has
> > > reached sufficient criteria for processor idle state entry matching
> > > Entry Trigger defined in LPIT to be interpreted as a request for the
> > > platform to enter a Low Power S0 Idle (LPI) state. Here we are checking if
> > > the we reached the minimum D-State defined in the constraint function of
> > > the LPIT _DSM method before calling the sleep entry function. Also not
> > > checking for constraint in acpi_s2idle_wake anymore and also changed the
> > > acpi info loglevel to debug in lpi_check_constraint.
> >
> > This patch does three different things, two of which are questionable and
> > one is done incorrectly.
> >
> > First off, aborting system suspend because S0ix constraints are not met is
> > a non-starter.  The kernel really cannot refuse to suspend the system for
> > that reason (and diagnostics can be done after resume anyway).
> >
> > Second, according to my knowledge, it is not a bug to invoke the
> > ACPI_LPS0_ENTRY _DSM when the constraints are not met.  Do you
> > actually know about any platforms where that may cause real problems
> > to occur?
> >
> > Finally, it is too late to invoke that _DSM from acpi_s2idle_sync(), because
> > that is called after leaving S0ix and resuming some devices.
> >
> > I can believe the claim that invoking the ACPI_LPS0_ENTRY _DSM in
> > acpi_s2idle_prepare() may be too early and it may confuse the EC, say,
> > but I'm not sure why the ACPI_LPS0_SCREEN_OFF _DSM would be
> > affected by that too.
> >
> > So overall, the patch below may actually work,
>
> On my Dell XPS13 9360 it clearly makes things worse by causing the EC
> to generate spurious wakeup events all the time, so I'm afraid that
> this like of reasoning is misguided overall.
>
> > but not the $subject one
> > (if evaluating the ACPI_LPS0_ENTRY _DSM when the constraints are not
> > met is *really* problematic, it may be necessary to add the check
> > for that on top of it).
> >
> > ---
> >  drivers/acpi/sleep.c    |   13 +++++++++----
> >  include/linux/suspend.h |    1 +
> >  kernel/power/suspend.c  |    8 ++++++--
> >  3 files changed, 16 insertions(+), 6 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/sleep.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/sleep.c
> > +++ linux-pm/drivers/acpi/sleep.c
> > @@ -967,8 +967,6 @@ static int acpi_s2idle_prepare(void)
> >  {
> >         if (lps0_device_handle) {
> >                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
> > -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> > -
> >                 acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
> >         }
> >
> > @@ -983,6 +981,12 @@ static int acpi_s2idle_prepare(void)
> >         return 0;
> >  }
> >
> > +static void acpi_s2idle_sleep(void)
> > +{
> > +       if (lps0_device_handle)
> > +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> > +}
> > +
> >  static void acpi_s2idle_wake(void)
> >  {
> >         if (!lps0_device_handle)
> > @@ -1007,6 +1011,8 @@ static void acpi_s2idle_wake(void)
> >                  */
> >                 acpi_ec_dispatch_gpe();
> >         }
> > +
> > +       acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> >  }
> >
> >  static void acpi_s2idle_sync(void)
> > @@ -1034,8 +1040,6 @@ static void acpi_s2idle_restore(void)
> >
> >         if (lps0_device_handle) {
> >                 acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
> > -
> > -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> >                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
> >         }
> >  }
> > @@ -1049,6 +1053,7 @@ static void acpi_s2idle_end(void)
> >  static const struct platform_s2idle_ops acpi_s2idle_ops = {
> >         .begin = acpi_s2idle_begin,
> >         .prepare = acpi_s2idle_prepare,
> > +       .sleep = acpi_s2idle_sleep,
> >         .wake = acpi_s2idle_wake,
> >         .sync = acpi_s2idle_sync,
> >         .restore = acpi_s2idle_restore,
> > Index: linux-pm/include/linux/suspend.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/suspend.h
> > +++ linux-pm/include/linux/suspend.h
> > @@ -190,6 +190,7 @@ struct platform_suspend_ops {
> >  struct platform_s2idle_ops {
> >         int (*begin)(void);
> >         int (*prepare)(void);
> > +       void (*sleep)(void);
> >         void (*wake)(void);
> >         void (*sync)(void);
> >         void (*restore)(void);
> > Index: linux-pm/kernel/power/suspend.c
> > ===================================================================
> > --- linux-pm.orig/kernel/power/suspend.c
> > +++ linux-pm/kernel/power/suspend.c
> > @@ -136,10 +136,14 @@ static void s2idle_loop(void)
> >                  * so prevent them from terminating the loop right away.
> >                  */
> >                 error = dpm_noirq_suspend_devices(PMSG_SUSPEND);
> > -               if (!error)
> > +               if (!error) {
> > +                       if (s2idle_ops && s2idle_ops->sleep)
> > +                               s2idle_ops->sleep();
> > +
> >                         s2idle_enter();
> > -               else if (error == -EBUSY && pm_wakeup_pending())
> > +               } else if (error == -EBUSY && pm_wakeup_pending()) {
> >                         error = 0;
> > +               }
> >
> >                 if (!error && s2idle_ops && s2idle_ops->wake)
> >                         s2idle_ops->wake();
> >
> >
> >
