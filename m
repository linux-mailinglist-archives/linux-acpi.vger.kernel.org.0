Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB041A76
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2019 04:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406444AbfFLCpc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jun 2019 22:45:32 -0400
Received: from cmta18.telus.net ([209.171.16.91]:37177 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406202AbfFLCpc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Jun 2019 22:45:32 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id at8YhJqoh7TgTat8ahtix1; Tue, 11 Jun 2019 20:37:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1560307044; bh=C7iEK0Eke4ArMRvKEyNha/brZ+KNznkDvwK77Ge8lOg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=P3uoWMoGegghqpSztiStgmXBWm+W0X9WudvpXe4c8p6JeSvO/cDnXucs70vRVvSEs
         ZUpUN+DMkhwou6C5C18T75CJ0p9msJWgktFpupK4OriITLTBhuJhxtP0kvhhNDXgG2
         4SIIBYGbC3Uj9RurAplrmOmzsoiWmuuyxUc4dPh1Tn9nWGVrWRgsfDENQUpd/SxLRc
         lxvukdrPKrn/8GP+BBNEO+8bEaDCVsSdl/+iAUW77bEIlSBsOLSCEm+wAOKc/NLDUk
         dqWAQdYMGLDL4Nmp3ry4l5esS5Sj1gBpbHH847jV9BhJ9g59Ld1A0ucHbfWvyiOzyw
         VR7AJILT9wmbQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=e6N4tph/ c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=SNZtMsJpNjCDGohZwB4A:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Pavel Machek'" <pavel@ucw.cz>
Cc:     "'kernel list'" <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <rui.zhang@intel.com>,
        <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <x86@kernel.org>, "Doug Smythies" <dsmythies@telus.net>
References: <20190609111732.GA2885@amd>
In-Reply-To: <20190609111732.GA2885@amd>
Subject: RE: 5.2-rc2: low framerate in flightgear, cpu not running at full speed, thermal related?
Date:   Tue, 11 Jun 2019 19:37:17 -0700
Message-ID: <007701d520c7$c397bda0$4ac738e0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdUetT93sqqDOHM9SxGXaHA1lUJq/QB+0mKg
Content-Language: en-ca
X-CMAE-Envelope: MS4wfBYcp50dSmfNdIkD1x2A539XcokdexQ+6aPs+biVhnZkgF93098xHHUdmfH24aEmIYBb41wOmzZWbAYDGIfXRKq50MKLjXbFDTghK0xduBB8/ZobvidT
 gpqSYXX8Cr6MWiSL7C+8hfFJKnuWCPNyaJAJWILtiFFbGyT0+Qh0K4nsg12f+t2ThpeZx2VVoCqUjOvqQspfAaL91ev8iXBC3znWehwP3ns9w/8CISUipONg
 06P+zg9MfgSnnWXaRLCdtXITdMtpoDp+vJZzaZsM6Sp/1BM0MjF/cOX83ocv2Y0gzy/cslsgarJls9Klx71dknyG7NpmduavN9we1fxQ9PupySIX87hUmDAi
 KM5cxcRKWg6kxjDAj19iVwskEZOwoFlg1OvFvzx3Wm2ww1dy/5i5LOZp2mEy4ebbxIFmDdxx/HIAQJxBnKEe69K1HxQ3e1kCCWZWQByQYIDs66CvbCnuPYXB
 hIlS5viOl2Pv28vYEmXlMPd9BC20kn3d275gUi9cofj5/lPmU5sWBi03BIE=
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

So, currently there seems to be 3 issues in this thread
(and I am guessing a little, without definitive data):

1.) On your system Kernel 5.4-rc2 (or 4) defaults to the intel_pstate CPU frequency
scaling driver and the powersave governor, but kernel 4.6 defaults to the
acpi-cpufreq CPU frequency scaling driver and the ondemand governor.

Suggest to check the related kernel configuration parameters.

$ grep -A 10 -i "CPU frequency scaling drivers" .config
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=y
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_P4_CLOCKMOD=m

2.) With kernel 5.2-rc2 there is thermal throttling (thermald?), but for 
Kernel 4.6 it either doesn't hit the throttling threshold or is not enabled.

I don't have input here.

However note that the CPU frequency verses load graphs are quite different
between acpi-cpufreq/ondemand and intel-pstate/powersave, with higher
CPU frequencies at lower loads for the acpi-cpufreq driver and higher
CPU frequencies at higher loads for the intel_pstate driver. The crossover
point is about 35% load. So, the two driver/governors might well end up at
different operating pointing terms of CPU frequencies. I do not have energy
data for the CPU frequency verses load tests, which is really what matters.

3.) The older kernel is still using the older acpi-cpufreq stuff where
some CPU frequency memory registers show what was asked for and not what
the system is actually giving.

See below.

On 2019.06.09 04:18 Pavel Machek wrote:

> When I start flightgear, I get framerates around 20 fps and cpu at
> 3GHz:
> 
> pavel@duo:~/bt$ cat /proc/cpuinfo  | grep MHz
> cpu MHz		    : 3027.471
> cpu MHz		      : 2981.863
> cpu MHz		      	: 2958.352
> cpu MHz			  : 2864.001
> pavel@duo:~/bt$
>
> (Ok, fgfs is really only running at single core, so why do both cores
> run at 3GHz?)

There is only 1 PLL (Phase Locked Loop) master clock generator in your
processor. Basically, the CPU with the highest frequency demand wins.
What is not shown in your data is that the not busy core is also
probably in a deep idle state for most of the time, consuming little or no
energy. Below is an example from my processor (i7-2600K) using
turbostat (note C6 is my deepest idle state, and only it is shown
for simplicity):

Core    CPU     Busy%   Bzy_MHz CPU%c6  PkgTmp  PkgWatt
-       -       12.52   3799    74.88   54      23.87
0       0       0.05    3664    99.89   54      23.87
0       4       0.00    3695
1       1       0.07    3676    99.87
1       5       0.00    3667
2       2       0.09    3669    99.78
2       6       0.00    3666
3       3       0.04    3786    0.00
3       7       99.92   3800

Observe the busy core spending no time in C6, but the other 3
spend most of the time there. However, for the little time that they are active,
CPU 7 is the one demanding the high CPU frequency.

Anticipated question:
"Then why aren't all the CPU frequencies exactly the same?"
My processor's max turbo frequency is a function of how many cores
are active, and so actually varies under peak demand. Excerpt from
turbostat, not in quiet mode:

35 * 100.0 = 3500.0 MHz max turbo 4 active cores
36 * 100.0 = 3600.0 MHz max turbo 3 active cores
37 * 100.0 = 3700.0 MHz max turbo 2 active cores
38 * 100.0 = 3800.0 MHz max turbo 1 active cores

> The CPU is Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz . I guess it means
> it should be able to sustain both cores running at 2.5GHz?

No, that is more a function of your hardware's ability (or lack of) to move
the waste heat away.

> Situation is very different with v4.6 distro based kernel.
> 
> CPU MHz is only getting values round to 100MHz. It does not go above
> 2.5GHz, but it does not go below 2.5GHz under the load, either.

Yes, it is going above 2.5 GHz, see below.

> v4.6:

> cpu MHz         : 2501.000
> cpu MHz         : 2501.000
> cpu MHz         : 2501.000
> cpu MHz         : 2501.000

That seems to be the old acpi-cpufreq information,
which is telling you what it's asking for and not what
it actually is. And the "01" means it is asking for turbo
range frequencies. Example from my system, while running the
above CPU 7 busy test:

Conditions: Old kernel (4.4), acpi-cpufreq driver, ondemand gov.

doug@s15:~$ grep MHz /proc/cpuinfo
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 3401.000

CPUs 0-6 have very little load and are asking for the minimum
available frequency. CPU 7 is asking for turbo.
The turbostat data tells a different story.

Conditions: New kernel (5.2-rc3), acpi-cpufreq driver, ondemand gov.

doug@s15:~$ grep MHz /proc/cpuinfo
cpu MHz         : 3611.623
cpu MHz         : 3638.843
cpu MHz         : 3662.703
cpu MHz         : 3634.156
cpu MHz         : 3611.601
cpu MHz         : 3668.422
cpu MHz         : 3611.471
cpu MHz         : 3738.445

Conditions: New kernel (5.2-rc3), intel_pstate driver, powersave gov.

doug@s15:~$ grep MHz /proc/cpuinfo
cpu MHz         : 3651.506
cpu MHz         : 3643.422
cpu MHz         : 3611.678
cpu MHz         : 3674.237
cpu MHz         : 3612.469
cpu MHz         : 3670.185
cpu MHz         : 3612.050
cpu MHz         : 3727.283

turbosat (tools/power/x86/turbostat/turbostat.c) commands used above:

sudo turbostat --quiet --hide IRQ,Avg_MHz,SMI,\
GFXMHz,TSC_MHz,GFXWatt,CorWatt,POLL%,CPU%c1,\
CPU%c3,CPU%c7,CoreTmp,GFX%rc6,Pkg%pc2,Pkg%pc3,\
Pkg%pc6,POLL,C1,C1E,C3,C6,C1%,C1E%,C3%,C6% \
--interval 5

And:

sudo turbostat

... Doug


