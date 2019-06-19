Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9EF24B170
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2019 07:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfFSFd3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 19 Jun 2019 01:33:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:2495 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfFSFd3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Jun 2019 01:33:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 22:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="243210157"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga001.jf.intel.com with ESMTP; 18 Jun 2019 22:33:27 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Jun 2019 22:33:27 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.18]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.232]) with mapi id 14.03.0439.000;
 Tue, 18 Jun 2019 22:33:27 -0700
From:   "Saha, Shaunak" <shaunak.saha@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario_limonciello@dell.com>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: drivers/acpi: Change the lpit function call flow
Thread-Topic: drivers/acpi: Change the lpit function call flow
Thread-Index: AQHVFAKLmGZKFQG42U6YI0ymKhLSm6aarbsAgAcDvoD///8ipA==
Date:   Wed, 19 Jun 2019 05:33:26 +0000
Message-ID: <593AE8A18AD46543B92D8EF146E2AA9408C326BA@ORSMSX107.amr.corp.intel.com>
References: <20190526202750.4614-1-shaunak.saha@intel.com>
 <2151762.asltZFE8WJ@kreacher>,<CAJZ5v0iHRzC=ewqUTa_VUdJ2NOztnP+hDYBeJLtfDydArPkkeA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iHRzC=ewqUTa_VUdJ2NOztnP+hDYBeJLtfDydArPkkeA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTI2YmRmYmEtMzA1OC00YTM5LWJlMGUtZmFmM2Y2NmJlMTZlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicHdXMUdQM1lhSDJPY3pGYzRUUTFBOUh2V1NKS3JIMTBNVW5ZZjdpelZGdmZCbUxvU0w5Y3hWUzNwNWtwUjJJbyJ9
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Thanks for your review comments. Agreed that this patch needs to be fixed. I am working on it. 
1.First off, aborting system suspend because S0ix constraints are not met is a non-starter.  The kernel really cannot refuse to suspend the system for  that reason (and diagnostics can be done after resume anyway).

For this as the LPIT specs says "_DSM function may be invoked when the OS state has reached sufficient criteria
for processor idle state entry matching Entry Trigger defined in LPIT" then  to check that entry trigger from before calling the sleep function would be better approach. Will report an error if that is not met and still go to suspend. Is that a proper way to handle this? please suggest.

2. Second, according to my knowledge, it is not a bug to invoke the ACPI_LPS0_ENTRY _DSM when the constraints are not met.  Do you actually know about any platforms where that may cause real problems to occur?

Actually in the present platform i m working we are seeing the failure to go to suspend whenever this _DSM methods are called. But as you correctly mentioned i found that the bug was not because this function was called early but it's happening because in our case ec seems to be bit noisy and that's why it's coming out of suspend too early. Something is going wrong in the ec polling function it seems in this case.

3. Finally, it is too late to invoke that _DSM from acpi_s2idle_sync(), because that is called after leaving S0ix and resuming some devices.

Agreed. I think moving the call of DSM from s2idle_enter is better if we decide to move it a later stage
________________________________________
From: Rafael J. Wysocki [rafael@kernel.org]
Sent: Tuesday, June 18, 2019 1:44 AM
To: Mario Limonciello
Cc: Saha, Shaunak; ACPI Devel Maling List
Subject: Re: drivers/acpi: Change the lpit function call flow

On Thu, Jun 13, 2019 at 11:37 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Sunday, May 26, 2019 10:27:50 PM CEST Shaunak Saha wrote:
> > In the present implementation sleep function was getting called in
> > acpi_s2idle_prepare and as all the devices may not have suspended
> > at that stage e.g. if we are telling ec about the S0ix then calling early
> > can cause ec reply wrongly interpreted as spurious wake events.
> > Here we call it at much later stage in acpi_s2idle_sync. As per the
> > specification the entry _DSM function may be invoked when the OS state has
> > reached sufficient criteria for processor idle state entry matching
> > Entry Trigger defined in LPIT to be interpreted as a request for the
> > platform to enter a Low Power S0 Idle (LPI) state. Here we are checking if
> > the we reached the minimum D-State defined in the constraint function of
> > the LPIT _DSM method before calling the sleep entry function. Also not
> > checking for constraint in acpi_s2idle_wake anymore and also changed the
> > acpi info loglevel to debug in lpi_check_constraint.
>
> This patch does three different things, two of which are questionable and
> one is done incorrectly.
>
> First off, aborting system suspend because S0ix constraints are not met is
> a non-starter.  The kernel really cannot refuse to suspend the system for
> that reason (and diagnostics can be done after resume anyway).
>
> Second, according to my knowledge, it is not a bug to invoke the
> ACPI_LPS0_ENTRY _DSM when the constraints are not met.  Do you
> actually know about any platforms where that may cause real problems
> to occur?
>
> Finally, it is too late to invoke that _DSM from acpi_s2idle_sync(), because
> that is called after leaving S0ix and resuming some devices.
>
> I can believe the claim that invoking the ACPI_LPS0_ENTRY _DSM in
> acpi_s2idle_prepare() may be too early and it may confuse the EC, say,
> but I'm not sure why the ACPI_LPS0_SCREEN_OFF _DSM would be
> affected by that too.
>
> So overall, the patch below may actually work,

On my Dell XPS13 9360 it clearly makes things worse by causing the EC
to generate spurious wakeup events all the time, so I'm afraid that
this like of reasoning is misguided overall.

> but not the $subject one
> (if evaluating the ACPI_LPS0_ENTRY _DSM when the constraints are not
> met is *really* problematic, it may be necessary to add the check
> for that on top of it).
>
> ---
>  drivers/acpi/sleep.c    |   13 +++++++++----
>  include/linux/suspend.h |    1 +
>  kernel/power/suspend.c  |    8 ++++++--
>  3 files changed, 16 insertions(+), 6 deletions(-)
>
> Index: linux-pm/drivers/acpi/sleep.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -967,8 +967,6 @@ static int acpi_s2idle_prepare(void)
>  {
>         if (lps0_device_handle) {
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> -
>                 acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
>         }
>
> @@ -983,6 +981,12 @@ static int acpi_s2idle_prepare(void)
>         return 0;
>  }
>
> +static void acpi_s2idle_sleep(void)
> +{
> +       if (lps0_device_handle)
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> +}
> +
>  static void acpi_s2idle_wake(void)
>  {
>         if (!lps0_device_handle)
> @@ -1007,6 +1011,8 @@ static void acpi_s2idle_wake(void)
>                  */
>                 acpi_ec_dispatch_gpe();
>         }
> +
> +       acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
>  }
>
>  static void acpi_s2idle_sync(void)
> @@ -1034,8 +1040,6 @@ static void acpi_s2idle_restore(void)
>
>         if (lps0_device_handle) {
>                 acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
> -
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
>         }
>  }
> @@ -1049,6 +1053,7 @@ static void acpi_s2idle_end(void)
>  static const struct platform_s2idle_ops acpi_s2idle_ops = {
>         .begin = acpi_s2idle_begin,
>         .prepare = acpi_s2idle_prepare,
> +       .sleep = acpi_s2idle_sleep,
>         .wake = acpi_s2idle_wake,
>         .sync = acpi_s2idle_sync,
>         .restore = acpi_s2idle_restore,
> Index: linux-pm/include/linux/suspend.h
> ===================================================================
> --- linux-pm.orig/include/linux/suspend.h
> +++ linux-pm/include/linux/suspend.h
> @@ -190,6 +190,7 @@ struct platform_suspend_ops {
>  struct platform_s2idle_ops {
>         int (*begin)(void);
>         int (*prepare)(void);
> +       void (*sleep)(void);
>         void (*wake)(void);
>         void (*sync)(void);
>         void (*restore)(void);
> Index: linux-pm/kernel/power/suspend.c
> ===================================================================
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -136,10 +136,14 @@ static void s2idle_loop(void)
>                  * so prevent them from terminating the loop right away.
>                  */
>                 error = dpm_noirq_suspend_devices(PMSG_SUSPEND);
> -               if (!error)
> +               if (!error) {
> +                       if (s2idle_ops && s2idle_ops->sleep)
> +                               s2idle_ops->sleep();
> +
>                         s2idle_enter();
> -               else if (error == -EBUSY && pm_wakeup_pending())
> +               } else if (error == -EBUSY && pm_wakeup_pending()) {
>                         error = 0;
> +               }
>
>                 if (!error && s2idle_ops && s2idle_ops->wake)
>                         s2idle_ops->wake();
>
>
>
