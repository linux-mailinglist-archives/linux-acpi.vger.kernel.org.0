Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D49102EE5
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 23:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKSWN6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 17:13:58 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60596 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfKSWN5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Nov 2019 17:13:57 -0500
Received: from 79.184.253.244.ipv4.supernova.orange.pl (79.184.253.244) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 1bb4ebfdd68c6764; Tue, 19 Nov 2019 23:13:54 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 1/3] PM: QoS: Introduce frequency QoS
Date:   Tue, 19 Nov 2019 23:13:53 +0100
Message-ID: <6710300.onecg0m5mP@kreacher>
In-Reply-To: <CAJZ5v0i1iAjpWju6FiCjP3RvspKDRfSwz4=b_3qgGhhfz8sSrw@mail.gmail.com>
References: <2811202.iOFZ6YHztY@kreacher> <000401d59ee6$959e3da0$c0dab8e0$@net> <CAJZ5v0i1iAjpWju6FiCjP3RvspKDRfSwz4=b_3qgGhhfz8sSrw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, November 19, 2019 8:17:05 PM CET Rafael J. Wysocki wrote:
> On Tue, Nov 19, 2019 at 3:35 PM Doug Smythies <dsmythies@telus.net> wrote:
> >
> > On 2019.11.17 08:13 Doug Smythies wrote:
> > > On 2019.11.16 23:35 Doug Smythies wrote:
> >
> > >> Hi Rafael,
> > >>
> > >> Not sure, but I think it is this one that
> > >> causes complaining when I try to set the
> > >> intel_pstate driver to passive mode.
> > >> I started from active mode, powersave governor,
> > >> no HWP.
> > >>
> > >> Kernel: 5.4-rc7
> > >>
> > >> I did not go back and try previous 5.4 RCs.
> >
> > After looking at the git tags for this patch,
> > I tried kernel 5.4-rc2, which was the closest
> > Kernel I had to before the patch set was added.
> > It worked fine, as expected.
> >
> > >> I did try kernel 5.3-rc8, because I already had
> > >> it installed, and it worked fine.
> > >>
> > >> I use a script (for years), run as sudo:
> > >>
> > >> doug@s15:~/temp$ cat set_cpu_passive
> > >> #! /bin/bash
> > >> cat /sys/devices/system/cpu/intel_pstate/status
> > >> echo passive > /sys/devices/system/cpu/intel_pstate/status
> > >> cat /sys/devices/system/cpu/intel_pstate/status
> > >>
> > >> And I get this (very small excerpt):
> > >>
> > >> freq_qos_add_request() called for active request
> > >> WARNING: CPU: 1 PID: 2758 at kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0
> > >> CPU: 1 PID: 2758 Comm: set_cpu_passive Not tainted 5.4.0-rc7-stock #727
> > >> Failed to add freq constraint for CPU0 (-22)
> > >>
> > >> freq_qos_add_request() called for active request
> > >> WARNING: CPU: 1 PID: 2758 at kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0
> > >> CPU: 1 PID: 2758 Comm: set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727
> > >> Failed to add freq constraint for CPU1 (-22)
> >
> > Updated summary of previous emails:
> > This patch or patch set breaks the after boot
> > ability to change CPU frequency scaling drivers.
> >
> > Using a workaround of booting with
> > "intel_pstate=passive" seems to prevent the errors.
> >
> > Changing between the intel_pstate and intel_cpufreq drivers
> > (i.e. between active and passive modes)
> > after boot, either way, causes the errors. i.e.
> >
> > Failed to add freq constraint for CPU7 (-22)
> > (2 per CPU per attempt)
> 
> These messages come from acpi_processor_ppc_init() and
> acpi_thermal_cpufreq_init(), AFAICS, which are invoked by
> acpi_processor_notifier() and that is invoked by the
> blocking_notifier_call_chain() in cpufreq_online() which tirggers for
> new policies after adding the max freq QoS request to
> policy->constraints.
> 
> The requests added by them should be removed by
> acpi_processor_ppc_exit() and acpi_thermal_cpufreq_exit(),
> respectively, invoked by the blocking_notifier_call_chain() in
> cpufreq_policy_free(), but it looks like that doesn't happen.
> 
> However, I now also see that freq_qos_remove_request() doesn't clear
> the qos field in req which is should do, so freq_qos_add_request()
> will complain and fail if the object pointed to by req is passed to it
> again.
> 
> I'll send a patch to test for this later today.
> 

The patch is appended.  Please test it (on top of 5.4-rc8) and report back.


---
 kernel/power/qos.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-pm/kernel/power/qos.c
===================================================================
--- linux-pm.orig/kernel/power/qos.c
+++ linux-pm/kernel/power/qos.c
@@ -814,6 +814,8 @@ EXPORT_SYMBOL_GPL(freq_qos_update_reques
  */
 int freq_qos_remove_request(struct freq_qos_request *req)
 {
+	int ret;
+
 	if (!req)
 		return -EINVAL;
 
@@ -821,7 +823,11 @@ int freq_qos_remove_request(struct freq_
 		 "%s() called for unknown object\n", __func__))
 		return -EINVAL;
 
-	return freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
+	ret = freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
+	req->qos = NULL;
+	req->type = 0;
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(freq_qos_remove_request);
 



