Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6148A49BEB
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2019 10:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfFRIUN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Jun 2019 04:20:13 -0400
Received: from cmta16.telus.net ([209.171.16.89]:34891 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfFRIUK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jun 2019 04:20:10 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id d9LXhkQAbJEJsd9LYhWqCu; Tue, 18 Jun 2019 02:20:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1560846007; bh=4oPnwPccYRR1HWBEOAYMNKpBGHqaXPUaoIs8esJCsdM=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=IrGQrcLKhPSDSu46s/k6Lyp+VUXzrlo9EPuihEk1wwWzRhRDj/ki/fBn9SlO0fPpO
         pafZDfVx3n890ibEY0W1Hz74vvuUah0aE1kBLpBWHTk5aTo/I+LYFXBROk14+xBr1e
         I/5zs4ol9ETMuzEsHL3amNg0VDDEFvfWP+NlKdLZsIsQeOCq5JVDKxsCsW0uHJsNQG
         Q/YPDSqt+k5oNfkR1rgqQajvmXS3+iOqHcu76+jsX9zsR6zRD9FxV4fjhaCiuY/JMe
         4WI8PVGsRuf8stWB76IQUslsqTmuyZ06wSyAjq6GuIopDN6mgQRjKwBxQXo8eaI4va
         YGjS31uxOcnUQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=S/CnP7kP c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=QS1IdDQa8Ckz10EETwYA:9 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Pavel Machek'" <pavel@ucw.cz>
Cc:     "'kernel list'" <linux-kernel@vger.kernel.org>,
        "'ACPI Devel Maling List'" <linux-acpi@vger.kernel.org>,
        "'Zhang, Rui'" <rui.zhang@intel.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Ingo Molnar'" <mingo@redhat.com>,
        "'Borislav Petkov'" <bp@alien8.de>,
        "'H. Peter Anvin'" <hpa@zytor.com>,
        "'the arch/x86 maintainers'" <x86@kernel.org>
References: <20190609111732.GA2885@amd> <007701d520c7$c397bda0$4ac738e0$@net> <CAJZ5v0j2pb2WxSA+S44Mr-6bpOx-P9A_T2-sDG3CiWSqLMg3sA@mail.gmail.com> <008f01d52178$07b3be70$171b3b50$@net> <CAJZ5v0gRaDe6Fajdx3wqaLz9LQr6Z6iD+2yrrZeXJV+3HiAOZg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gRaDe6Fajdx3wqaLz9LQr6Z6iD+2yrrZeXJV+3HiAOZg@mail.gmail.com>
Subject: RE: 5.2-rc2: low framerate in flightgear, cpu not running at full speed, thermal related?
Date:   Tue, 18 Jun 2019 01:20:01 -0700
Message-ID: <002601d525ae$a2c00c90$e84025b0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdUhxW5L2+X8gHmoRpu1acL6KWj0kQD3alWQ
X-CMAE-Envelope: MS4wfPt4TjqDa3lkNrtkLRJ7l+GxZI+64X6DIAhzIQwktquJuXetmXtzUvUbr4bCJRZTm036DHxCc2Br6CpS8LwPxIbb54bgeXuTdmwHTFkaqfWwt63393OL
 HfOjyCwZtWXemveAXMSx05U1okSBlMTh+Eny4poX52zkMNkKn150DXUYCKHMx1hVFXz4v7WK+AhAkio+r2qpEuINYVIdZ5bCur6skf+Brqy6BsMSCLgsOGv9
 l/HziNxXTfXl7D/WikS51LvRsyV6xVvsmWxdxDD8oM1StHJbyITLsyVEEIDt7iicz9zzOjeGFFAc5oP8SBE3IXs2/TQFeYcIZZZQtOZZKZuVY0jZrGdagXdV
 BIIFDiwXqz3bMu2p/cX8QOp8QpJ6wLO1ERDSYGzf9ZyB9piRSATjVjvddH7vuW9EL0A++UldJuJ1JeCKW7PdVloQe4oMBXKsU6sWoVnsGc/S7lP9zuYnHfrg
 IIcp6S+pBWE0xjaZ3iYIW7aUD6aeSDoQ8jn/9MK6h7f5XaOWTNwDG5p16VM=
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019.06.13 01:53 Rafael J. Wysocki wrote:

> I personally doubt that any thermal throttling is involved here.

In earlier e-mails on this thread, Pavel showed his core and package
temperatures as 97 and 98 degrees. If thermal throttling is not
involved, it should be. The description of the observed CPU
frequencies also matched my experiences with thermal throttling
for the intel-pstate/powersave example. Myself, I can not determine
if throttling is involved for the acpi-cpufreq/ondemand
case, just from the clock frequencies, because,
at least on my system, it uses the kidle_inject method
instead of the pstate method.

I continued doing experiments, enabling thermald (normally
disabled on my system) and forcing thermal throttling on
my test server. My system never gets hot enough, so I used
a low trip point of 55 degrees.

The intel_pstate/powersave and intel_cpufreq/ondemand,
which both used the pstate method, outperformed the
acpi-cpufreq/ondemand by 30%, in a constant thermal
throttling mode. This seems the opposite of Pavel's
results, if indeed his system is thermal throttling.
(I can write these experiments up in more detail
if desired.)

On 2019.06.13 Pavel Machek wrote:

> But it seems that your assumptions are incorrect for my workload.

Fair enough. I don't have the appropriate hardware for this, and
am trying to guess at a similar workflow for testing.
Perhaps, just mudding things here rather than helping.

>
> flightgear is single-threaded, and in my configuration saturates the
> CPU, because it would like to achieve higher framerate than my system
> is capable of.

Are you sure? Use turbostat and observe.
Example 1:
intel_cpufreq/ondemand, kernel 5.2-rc3, two 100% loads:

doug@s15:~$ sudo turbostat --quiet --hide IRQ,Avg_MHz,SMI,\
> GFXMHz,TSC_MHz,CorWatt,CoreTmp,GFX%rc6,Pkg%pc2,Pkg%pc3,\
> Pkg%pc6,POLL,C1,C1E,C3,C6,C1%,C1E%,C3%,C6% \
> --interval 5
Core    CPU     Busy%   Bzy_MHz POLL%   CPU%c1  CPU%c3  CPU%c6  CPU%c7  PkgTmp  PkgWatt GFXWatt
-       -       25.24   2780    0.00    25.70   0.01    49.05   0.00    56      23.82   0.12
0       0       1.62    2781    0.00    1.90    0.02    96.46   0.00    56      23.82   0.12
0       4       0.05    2833    0.00    3.47
1       1       100.00  2780    0.00    0.00    0.00    0.00    0.00
1       5       0.03    2893    0.00    99.97
2       2       0.03    2906    0.00    99.97   0.00    0.00    0.00
2       6       100.00  2780    0.00    0.00
3       3       0.07    2797    0.00    0.18    0.01    99.74   0.00
3       7       0.10    2834    0.00    0.14

Example 2:
acpi_cpufreq/ondemand, kernel 5.2-rc3, two 100% loads:

doug@s15:~$ sudo turbostat --quiet --hide IRQ,Avg_MHz,SMI,\
> GFXMHz,TSC_MHz,CorWatt,CoreTmp,GFX%rc6,Pkg%pc2,Pkg%pc3,\
> Pkg%pc6,POLL,C1,C1E,C3,C6,C1%,C1E%,C3%,C6% \
> --interval 5
Core    CPU     Busy%   Bzy_MHz POLL%   CPU%c1  CPU%c3  CPU%c6  CPU%c7  PkgTmp  PkgWatt GFXWatt
-       -       18.06   3069    0.00    18.45   0.01    63.47   0.00    55      21.50   0.12
0       0       15.55   3049    0.00    1.31    0.02    83.12   0.00    55      21.50   0.12
0       4       0.64    2651    0.00    16.22
1       1       62.43   3075    0.00    8.15    0.00    29.43   0.00
1       5       7.71    3068    0.00    62.81
2       2       50.56   3091    0.00    0.78    0.00    48.66   0.00
2       6       0.44    2346    0.00    50.89
3       3       2.30    2901    0.00    5.00    0.01    92.69   0.00
3       7       4.79    3016    0.00    2.49

With the additional C6 % coming from the kidle_inj tasks.
Observation 1: The loaded CPUs migrate much more often in this scenario.
Observation 2: While the package watts are different by over 2 watts,
the long term (done over many hours) average was the same for all methods.

... Doug


