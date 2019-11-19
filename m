Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1DF1026E9
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 15:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfKSOfc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 09:35:32 -0500
Received: from cmta16.telus.net ([209.171.16.89]:38618 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbfKSOfb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 09:35:31 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id X4bGiIrObFXoiX4bHild2S; Tue, 19 Nov 2019 07:35:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1574174129; bh=63LOnJc30pBSREJO4wJYShoRYdLEO0kEt45oadjC+os=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=T4Ten+hDuivTIJWRrZY7rqjP2VeElc6BzCjlCqBXu2EyHRlZjJ1C1yX8+28Tyjnxw
         CnaaSdbbn3MpSkswl8qcWvlfX5axjhzlf9f9Qb21eLlHndiYTtdoUFjEiO2Ez8sTDd
         P2p3vHBN5KP65OSlAVlTcUUVegve2Aw8KkNHbezVLnHMG64rP4gY+zJZbzxIyPV4+h
         pEqaYmUe8bx0KsyjzRiJ9JbnR/xRdTqHO+WOpnlS8JMHHRqbcZgwamwZFIP8qnTlR+
         fsmthn7rdRji8aua5AZHzOg97ZEDOZWQT0Qz2os5KQy6bkfxjJKsJ+K3AP+Q1B2iBP
         pqbpCmXfPaUrA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=HoEI5HbS c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=eoc6EyjFvRJxczR-1ZoA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
Cc:     "'Linux ACPI'" <linux-acpi@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Sudeep Holla'" <sudeep.holla@arm.com>,
        "'Dmitry Osipenko'" <digetx@gmail.com>
References: <2811202.iOFZ6YHztY@kreacher> <4551555.oysnf1Sd0E@kreacher>  <000001d59d61$eb4e6670$c1eb3350$@net>
In-Reply-To: <000001d59d61$eb4e6670$c1eb3350$@net>
Subject: RE: [RFT][PATCH 1/3] PM: QoS: Introduce frequency QoS
Date:   Tue, 19 Nov 2019 06:35:23 -0800
Message-ID: <000401d59ee6$959e3da0$c0dab8e0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdWED0vlByLFQ8J4Rz2jUgcX377w8gZBYsHgABMAilAARNHnkA==
Content-Language: en-ca
X-CMAE-Envelope: MS4wfGlZrt8fA0JDBbp+rsXg0s950oIfnn+/5U3Qm7Roij26fEaS19MOqBw4jeWFATeCWVBexqn8CudFMysYBwgIZfgQQY3dT+dVkuEK0GK9dAXNyVvOG1AJ
 nly4uNkrMp0yuqm0IJMHZhBcRPmkNwi19v/U7bA4KlKXTCKN4RvIfW/H9HUnMJD6wVvhh/E0wfN00I4E88G2GnqKQvUC0d1582yNNJY323aPxQqPnuQzZ5A2
 lzU0491n5rWctVVvQN6vo2RbwVHE6oQjzIbwr9LYUntar2wuYniBshX88VGQibAb3QnH6AA1Q/jGu0FPp1BI4b++SSB8bMb3XjayolNKfiBJ9ChsiFWIMpom
 xIJ2RboYQFNYuOq98YrWSnBjRiWgdA==
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019.11.17 08:13 Doug Smythies wrote:
> On 2019.11.16 23:35 Doug Smythies wrote:

>> Hi Rafael,
>>
>> Not sure, but I think it is this one that
>> causes complaining when I try to set the
>> intel_pstate driver to passive mode.
>> I started from active mode, powersave governor,
>> no HWP.
>>
>> Kernel: 5.4-rc7
>>
>> I did not go back and try previous 5.4 RCs.

After looking at the git tags for this patch,
I tried kernel 5.4-rc2, which was the closest
Kernel I had to before the patch set was added.
It worked fine, as expected.

>> I did try kernel 5.3-rc8, because I already had
>> it installed, and it worked fine.
>>
>> I use a script (for years), run as sudo:
>>
>> doug@s15:~/temp$ cat set_cpu_passive
>> #! /bin/bash
>> cat /sys/devices/system/cpu/intel_pstate/status
>> echo passive > /sys/devices/system/cpu/intel_pstate/status
>> cat /sys/devices/system/cpu/intel_pstate/status
>>
>> And I get this (very small excerpt):
>>
>> freq_qos_add_request() called for active request
>> WARNING: CPU: 1 PID: 2758 at kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0
>> CPU: 1 PID: 2758 Comm: set_cpu_passive Not tainted 5.4.0-rc7-stock #727
>> Failed to add freq constraint for CPU0 (-22)
>>
>> freq_qos_add_request() called for active request
>> WARNING: CPU: 1 PID: 2758 at kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0
>> CPU: 1 PID: 2758 Comm: set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727
>> Failed to add freq constraint for CPU1 (-22)

Updated summary of previous emails:
This patch or patch set breaks the after boot
ability to change CPU frequency scaling drivers.

Using a workaround of booting with
"intel_pstate=passive" seems to prevent the errors.

Changing between the intel_pstate and intel_cpufreq drivers
(i.e. between active and passive modes)
after boot, either way, causes the errors. i.e.

Failed to add freq constraint for CPU7 (-22)
(2 per CPU per attempt)

This is 100% repeatable.

> I forgot to mention, other than the error messages,
> things seems to work fine.

Correction: It is actually quite bad. Eventually,
there will be a "Segmentation fault (core dumped)",
and then even re-boot gets stuck and the only
recourse seems to be the reset button.

This is not 100% repeatable.

I did this (kernel 5.4-rc8):

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8ab3170..24c7a6b 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2491,6 +2491,8 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 {
        int ret;

+       pr_info("Intel P-state register driver .... \n");
+
        memset(&global, 0, sizeof(global));
        global.max_perf_pct = 100;

@@ -2508,6 +2510,8 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)

 static int intel_pstate_unregister_driver(void)
 {
+       pr_info("Intel P-state unregister driver .... \n");
+
        if (hwp_active)
                return -EBUSY;

And got this (dmesg | grep -i pstate):

[    2.024876] intel_pstate: Intel P-state driver initializing
[    2.024883] intel_pstate: Intel P-state register driver ....

Attempt to change from the booted passive mode to active mode:

[  175.903031] intel_pstate: Intel P-state unregister driver ....
[  175.975543] intel_pstate: Intel P-state register driver ....
[  175.975754]  intel_pstate_register_driver+0x4b/0x90
[  175.975756]  ? intel_pstate_unregister_driver+0x31/0x40
[  175.977728]  intel_pstate_register_driver+0x4b/0x90
[  175.977730]  ? intel_pstate_unregister_driver+0x31/0x40
[  175.979644]  intel_pstate_register_driver+0x4b/0x90
[  175.979647]  ? intel_pstate_unregister_driver+0x31/0x40
[  175.981424]  intel_pstate_register_driver+0x4b/0x90
[  175.981427]  ? intel_pstate_unregister_driver+0x31/0x40
[  175.982428]  intel_pstate_register_driver+0x4b/0x90
[  175.982430]  ? intel_pstate_unregister_driver+0x31/0x40
[  175.983127]  intel_pstate_register_driver+0x4b/0x90
[  175.983128]  ? intel_pstate_unregister_driver+0x31/0x40
[  175.983829]  intel_pstate_register_driver+0x4b/0x90
[  175.983832]  ? intel_pstate_unregister_driver+0x31/0x40
[  175.984434]  intel_pstate_register_driver+0x4b/0x90
[  175.984435]  ? intel_pstate_unregister_driver+0x31/0x40
[  175.985040]  intel_pstate_register_driver+0x4b/0x90
[  175.985041]  ? intel_pstate_unregister_driver+0x31/0x40
[  175.985598]  intel_pstate_register_driver+0x4b/0x90
[  175.985600]  ? intel_pstate_unregister_driver+0x31/0x40
[  175.986178]  intel_pstate_register_driver+0x4b/0x90
[  175.986179]  ? intel_pstate_unregister_driver+0x31/0x40
[  175.986721]  intel_pstate_register_driver+0x4b/0x90
[  175.986723]  ? intel_pstate_unregister_driver+0x31/0x40
[  175.987301]  intel_pstate_register_driver+0x4b/0x90
[  175.987302]  ? intel_pstate_unregister_driver+0x31/0x40
[  175.987828]  intel_pstate_register_driver+0x4b/0x90
[  175.987830]  ? intel_pstate_unregister_driver+0x31/0x40
[  175.988420]  intel_pstate_register_driver+0x4b/0x90
[  175.988421]  ? intel_pstate_unregister_driver+0x31/0x40
[  175.988920]  intel_pstate_register_driver+0x4b/0x90
[  175.988921]  ? intel_pstate_unregister_driver+0x31/0x40

Sometimes I get this:

grep . /sys/devices/system/cpu/intel_pstate/*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:100
/sys/devices/system/cpu/intel_pstate/min_perf_pct:42

Instead of this:

grep . /sys/devices/system/cpu/intel_pstate/*
/sys/devices/system/cpu/intel_pstate/max_perf_pct:100
/sys/devices/system/cpu/intel_pstate/min_perf_pct:42
/sys/devices/system/cpu/intel_pstate/no_turbo:0
/sys/devices/system/cpu/intel_pstate/num_pstates:23
/sys/devices/system/cpu/intel_pstate/status:active
/sys/devices/system/cpu/intel_pstate/turbo_pct:18

But do not yet know the exact way to reliably
create it.

This is as far as I got so far.

... Doug


