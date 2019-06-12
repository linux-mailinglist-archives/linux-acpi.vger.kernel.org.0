Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C54447B7
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2019 19:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfFMRB2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 13:01:28 -0400
Received: from cmta20.telus.net ([209.171.16.93]:56657 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729676AbfFLXjM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Jun 2019 19:39:12 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id bCpdho1tDmIDxbCpehR4ah; Wed, 12 Jun 2019 17:39:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1560382749; bh=NkAlskxzscdeR1udzQK+9g7a0lj1WFYO+VNUmciFeO4=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=tHU6jHIt+tCyctkDgAHnArmS1uz4tVBejGFyZPfMGlqs9DqZuUjM1MrL9gm6D9R0/
         bf5GIZizNGLn2SWaPC6bgClvtMsyTrdrnTqA012+jg7sWWWeHU7lEES0KPujAfTSmX
         4yyG3pEeteDkKwCr45rBMmhxxiI8rKe8XmJujCOoqXB4MDMx5gwhN4z/u7sSj0Xyle
         LZ2SKPIrbf8f+2ns+L/NviuKaxpOo2DZ0ih9VJADkE5MfgzZfElL84mWdjZRizg/dx
         Sgmk3mT6Im7p19dxWTgynq0YNpxaI1SegIe+PciWzKICIre/U4zcKXyRPOLmLy8OIT
         ZyhiCjIMmlvMQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=Tq+Yewfh c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=aatUQebYAAAA:8 a=M5e_aTnQhfenkqaycmAA:9 a=QEXdDO2ut3YA:10
 a=7715FyvI7WU-l6oqrZBK:22
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
        "'the arch/x86 maintainers'" <x86@kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <20190609111732.GA2885@amd> <007701d520c7$c397bda0$4ac738e0$@net> <CAJZ5v0j2pb2WxSA+S44Mr-6bpOx-P9A_T2-sDG3CiWSqLMg3sA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j2pb2WxSA+S44Mr-6bpOx-P9A_T2-sDG3CiWSqLMg3sA@mail.gmail.com>
Subject: RE: 5.2-rc2: low framerate in flightgear, cpu not running at full speed, thermal related?
Date:   Wed, 12 Jun 2019 16:39:04 -0700
Message-ID: <008f01d52178$07b3be70$171b3b50$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdUhaAyoVaNrS0lJQFeu7feFwtatGwABXsmg
Content-Language: en-ca
X-CMAE-Envelope: MS4wfKWWA2PE6GCEhygvHrMKC5TKX76lYBBxCksFr6o5c317Qh9TFUY9Xd0FqOf0Muz+2eh0pg8epTL8td+N3EUJlV8I5UlZgoxHwHX5mwwiungH3c4N7ufj
 DlhTMMdkXIf8BS8tEwY+yYvKFNFyH1P6VZ6POpMqXHo/SpgKpEmoPDJbQA9LallEmq5kasHdpJ37sFl9L+dADFzRrmjA+7IBtFr/jyoYKALMiAscfRIKlscV
 G+Wu138uliJPRo0u4EeUs8uZlEekJ0LVyn/XAsW71YACasP3M+vmHl3szCD9E7KF5E1IMaBo8L7yoLi3dSOSS1O2Uaw6Q1VPanb3oEOAC2BKKwUOYzNsV2Y+
 pb2liYm2oqji1wiYWQhbeDgu2HcOEu5G1ECPSmioO5GO9aRbMZxlSI4L9sFS4iO+Jkzlr6kWzGgTsiWmdDhiXHOV7sL/oLNe6L3foJxYXnFq/Z0fcuY0W6gS
 0qfQWEZnBQg6AtcwKTKCcn6i2Cov7N5du79o3tZXWAuxdPD/dsnwtRL3d7NdlwOLGRVk3adAdPRy8dIm
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019.06.12 14:25 Rafael J. Wysocki wrote:
> On Wed, Jun 12, 2019 at 4:45 AM Doug Smythies <dsmythies@telus.net> wrote:
>>
>> So, currently there seems to be 3 issues in this thread
>> (and I am guessing a little, without definitive data):
>>
>> 1.) On your system Kernel 5.4-rc2 (or 4) defaults to the intel_pstate CPU frequency
>> scaling driver and the powersave governor, but kernel 4.6 defaults to the
>> acpi-cpufreq CPU frequency scaling driver and the ondemand governor.
>
> Which means that intel_pstate works in the active mode by default and
> so it uses its internal governor.

Note sure what you mean by "internal governor"?
If you meant HWP (Hardware P-state), Pavel's processor doesn't have it.
If you meant the active powersave governor code within the driver, then agreed.

> That governor is more performance-oriented than ondemand and it very
> well may cause more power to be allocated for the processor - at the
> expense of the GPU.

O.K. I mainly use servers and so have no experience with possible GPU
verses CPU tradeoffs.

However, I did re-do my tests measuring energy instead of CPU frequency
and found very little difference between the acpi-cpufreq/ondemand verses
intel_pstate/powersave as a function of single threaded load. Actually,
I did the test twice, one at 20 hertz work/sleep frequency and also
at 67 hertz work/sleep frequency. (Of course, Pavel's processor might
well have a different curve, but it is a similar vintage to mine
i5-2520M verses i7-2600K.) The worst difference was approximately
1.1 extra processor package watts (an extra 5.5%) in the 80% to 85%
single threaded load range at 67 hertz work/sleep frequency for
the intel-pstate/powersave driver/governor. 

What am I saying? For a fixed amount of work to do per work/sleep cycle
(i.e. maybe per video frame related type work) while the CPU frequency Verses load
curves might differ, the resulting processor energy curve differs much less.
(i.e. the extra power for higher CPU frequency is for less time because it gets
the job done faster.) So, myself, I don't yet understand why only the one method
would have hit thermal throttling, but not the other (if indeed it doesn't).
Other differences between kernel 4.6 and 5.2-rc? might explain it. I did all
my tests on kernel 5.2-rc3, except that one example from kernel 4.4 on my
earlier reply, so that were not other variables than CPU scaling driver and
governor changes.

> The lower-than-expected frame rate may result from that, in principle.

> One way to mitigate that might be to use intel_pstate in the passive
> mode (pass intel_pstate=passive to the kernel in the command line)
> along with either ondemand or schedutil as the governor.

The CPU frequency verses load curves for this those two governors are very similar
for both the acpi_cpufreq and intel_cpufreq (which is the intel_pstate driver
in passive mode) drivers.

Just for information: CPU frequency verses single threaded load curves
for the conservative governor is quite different between the two drivers.
(tests done in February, perhaps I should re-do and also look at energy
at the same time, or instead of CPU frequency.)

... Doug


