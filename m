Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83363ABF2A
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 20:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390181AbfIFSNF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 14:13:05 -0400
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:57642 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731928AbfIFSNF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Sep 2019 14:13:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2A06A181D341A;
        Fri,  6 Sep 2019 18:13:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,::::::::::::::::::::::::::::::::::::::::::,RULES_HIT:1:2:41:355:379:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1593:1594:1730:1747:1777:1792:1801:2198:2199:2393:2538:2553:2559:2562:2828:2896:2910:3138:3139:3140:3141:3142:3354:3622:3865:3867:3868:3871:3872:4051:4250:4321:4605:5007:6117:6120:6742:6743:7875:7901:10004:10848:11026:11232:11473:11657:11658:11914:12043:12297:12438:12555:12679:12740:12760:12895:12986:13439:13972:14659:21080:21094:21323:21433:21611:21627:30029:30054:30060:30064:30067:30070:30075:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: hand82_546059634e43e
X-Filterd-Recvd-Size: 10002
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Sep 2019 18:12:59 +0000 (UTC)
Message-ID: <1b1cfc9c8c13b58c47d1d123763c8bc412abf9d4.camel@perches.com>
Subject: [RFC PATCH] tools: Add SPDX license to man pages
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jessica Yu <jeyu@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb <linux-usb@vger.kernel.org>
Date:   Fri, 06 Sep 2019 11:12:58 -0700
In-Reply-To: <20190906083457.7e7934ec@coco.lan>
References: <20190905055614.7958918b@coco.lan>
         <88e638eb959095ab6657d295f9f8c27169569bf2.1567675272.git.mchehab+samsung@kernel.org>
         <20190905092703.GA30899@kroah.com> <20190905090701.37dcf75e@coco.lan>
         <b32c2e46b91e7bcda2a9bd140673f06d71b2487a.camel@perches.com>
         <20190906083457.7e7934ec@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 2019-09-06 at 08:34 -0300, Mauro Carvalho Chehab wrote:
> Warning: SPDX header for file tools/thermal/tmon/tmon.8 is at line 2
[]
> The last one is interesting... what's the "very first line" where a
> SPDX header tag should be on a man page?

just fyi:

It looks like .man pages could use a comment form
using '.\"' like this example on the first line:

$ head -5 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
.\"  This page Copyright (C) 2010 - 2015 Len Brown <len.brown@intel.com>
.\"  Distributed under the GPL, Copyleft 1994.
.TH X86_ENERGY_PERF_POLICY 8
.SH NAME
x86_energy_perf_policy \- Manage Energy vs. Performance Policy via x86 Model Specific Registers

So maybe:
---
 tools/power/acpi/man/acpidump.8                                 | 1 +
 tools/power/cpupower/man/cpupower-frequency-info.1              | 1 +
 tools/power/cpupower/man/cpupower-frequency-set.1               | 1 +
 tools/power/cpupower/man/cpupower-idle-info.1                   | 1 +
 tools/power/cpupower/man/cpupower-idle-set.1                    | 1 +
 tools/power/cpupower/man/cpupower-info.1                        | 1 +
 tools/power/cpupower/man/cpupower-monitor.1                     | 1 +
 tools/power/cpupower/man/cpupower-set.1                         | 1 +
 tools/power/cpupower/man/cpupower.1                             | 1 +
 tools/power/pm-graph/bootgraph.8                                | 1 +
 tools/power/pm-graph/sleepgraph.8                               | 1 +
 tools/power/x86/turbostat/turbostat.8                           | 1 +
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8 | 1 +
 tools/thermal/tmon/tmon.8                                       | 1 +
 tools/usb/usbip/doc/usbip.8                                     | 1 +
 tools/usb/usbip/doc/usbipd.8                                    | 1 +
 16 files changed, 16 insertions(+)

diff --git a/tools/power/acpi/man/acpidump.8 b/tools/power/acpi/man/acpidump.8
index 79e2d1d435d1..31513ea4bc6b 100644
--- a/tools/power/acpi/man/acpidump.8
+++ b/tools/power/acpi/man/acpidump.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH ACPIDUMP 8
 .SH NAME
 acpidump \- dump a system's ACPI tables to an ASCII file
diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
index 6aa8d239dff9..e3f46215c3b6 100644
--- a/tools/power/cpupower/man/cpupower-frequency-info.1
+++ b/tools/power/cpupower/man/cpupower-frequency-info.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH "CPUPOWER\-FREQUENCY\-INFO" "1" "0.1" "" "cpupower Manual"
 .SH "NAME"
 .LP 
diff --git a/tools/power/cpupower/man/cpupower-frequency-set.1 b/tools/power/cpupower/man/cpupower-frequency-set.1
index b50570221a5b..f6b4619e7ef6 100644
--- a/tools/power/cpupower/man/cpupower-frequency-set.1
+++ b/tools/power/cpupower/man/cpupower-frequency-set.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH "CPUPOWER\-FREQUENCY\-SET" "1" "0.1" "" "cpupower Manual"
 .SH "NAME"
 .LP 
diff --git a/tools/power/cpupower/man/cpupower-idle-info.1 b/tools/power/cpupower/man/cpupower-idle-info.1
index 80a1311fa747..d05728573bd9 100644
--- a/tools/power/cpupower/man/cpupower-idle-info.1
+++ b/tools/power/cpupower/man/cpupower-idle-info.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH "CPUPOWER-IDLE-INFO" "1" "0.1" "" "cpupower Manual"
 .SH "NAME"
 .LP
diff --git a/tools/power/cpupower/man/cpupower-idle-set.1 b/tools/power/cpupower/man/cpupower-idle-set.1
index 21916cff7516..746322ea9b3e 100644
--- a/tools/power/cpupower/man/cpupower-idle-set.1
+++ b/tools/power/cpupower/man/cpupower-idle-set.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH "CPUPOWER-IDLE-SET" "1" "0.1" "" "cpupower Manual"
 .SH "NAME"
 .LP
diff --git a/tools/power/cpupower/man/cpupower-info.1 b/tools/power/cpupower/man/cpupower-info.1
index 340bcd0be7de..d77b34bcf1f3 100644
--- a/tools/power/cpupower/man/cpupower-info.1
+++ b/tools/power/cpupower/man/cpupower-info.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH CPUPOWER\-INFO "1" "22/02/2011" "" "cpupower Manual"
 .SH NAME
 cpupower\-info \- Shows processor power related kernel or hardware configurations
diff --git a/tools/power/cpupower/man/cpupower-monitor.1 b/tools/power/cpupower/man/cpupower-monitor.1
index 70a56476f4b0..4027cf424ea0 100644
--- a/tools/power/cpupower/man/cpupower-monitor.1
+++ b/tools/power/cpupower/man/cpupower-monitor.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH CPUPOWER\-MONITOR "1" "22/02/2011" "" "cpupower Manual"
 .SH NAME
 cpupower\-monitor \- Report processor frequency and idle statistics
diff --git a/tools/power/cpupower/man/cpupower-set.1 b/tools/power/cpupower/man/cpupower-set.1
index 2bcc696f4496..77dec3ec4c10 100644
--- a/tools/power/cpupower/man/cpupower-set.1
+++ b/tools/power/cpupower/man/cpupower-set.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH CPUPOWER\-SET "1" "22/02/2011" "" "cpupower Manual"
 .SH NAME
 cpupower\-set \- Set processor power related kernel or hardware configurations
diff --git a/tools/power/cpupower/man/cpupower.1 b/tools/power/cpupower/man/cpupower.1
index baf741d06e82..0a8b08a1fd90 100644
--- a/tools/power/cpupower/man/cpupower.1
+++ b/tools/power/cpupower/man/cpupower.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH CPUPOWER "1" "07/03/2011" "" "cpupower Manual"
 .SH NAME
 cpupower \- Shows and sets processor power related values
diff --git a/tools/power/pm-graph/bootgraph.8 b/tools/power/pm-graph/bootgraph.8
index 64d513f80a2a..4a8981356e1a 100644
--- a/tools/power/pm-graph/bootgraph.8
+++ b/tools/power/pm-graph/bootgraph.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH BOOTGRAPH 8
 .SH NAME
 bootgraph \- Kernel boot timing analysis
diff --git a/tools/power/pm-graph/sleepgraph.8 b/tools/power/pm-graph/sleepgraph.8
index 43aee64316df..ce456d1b7da9 100644
--- a/tools/power/pm-graph/sleepgraph.8
+++ b/tools/power/pm-graph/sleepgraph.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH SLEEPGRAPH 8
 .SH NAME
 sleepgraph \- Suspend/Resume timing analysis
diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index a6db83a88e85..48ac735526df 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH TURBOSTAT 8
 .SH NAME
 turbostat \- Report processor frequency and idle statistics
diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8 b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
index 78c6361898b1..e702d2117062 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .\"  This page Copyright (C) 2010 - 2015 Len Brown <len.brown@intel.com>
 .\"  Distributed under the GPL, Copyleft 1994.
 .TH X86_ENERGY_PERF_POLICY 8
diff --git a/tools/thermal/tmon/tmon.8 b/tools/thermal/tmon/tmon.8
index 2f122de5841b..cffaa0d65478 100644
--- a/tools/thermal/tmon/tmon.8
+++ b/tools/thermal/tmon/tmon.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH TMON 8
 # SPDX-License-Identifier: GPL-2.0
 .SH NAME
diff --git a/tools/usb/usbip/doc/usbip.8 b/tools/usb/usbip/doc/usbip.8
index a6097be25d28..7430d80d5f66 100644
--- a/tools/usb/usbip/doc/usbip.8
+++ b/tools/usb/usbip/doc/usbip.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH USBIP "8" "February 2009" "usbip" "System Administration Utilities"
 .SH NAME
 usbip \- manage USB/IP devices
diff --git a/tools/usb/usbip/doc/usbipd.8 b/tools/usb/usbip/doc/usbipd.8
index ac4635db3f03..5f2f4e2d0c9b 100644
--- a/tools/usb/usbip/doc/usbipd.8
+++ b/tools/usb/usbip/doc/usbipd.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH USBIP "8" "February 2009" "usbip" "System Administration Utilities"
 .SH NAME
 usbipd \- USB/IP server daemon


