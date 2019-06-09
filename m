Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2555D3A651
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2019 16:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfFIONA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 9 Jun 2019 10:13:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:13139 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbfFIOM7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 9 Jun 2019 10:12:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jun 2019 07:12:59 -0700
X-ExtLoop1: 1
Received: from xinzhanz-mobl1.ccr.corp.intel.com ([10.255.29.135])
  by orsmga006.jf.intel.com with ESMTP; 09 Jun 2019 07:12:55 -0700
Message-ID: <1560089580.2363.10.camel@intel.com>
Subject: Re: 5.2-rc2: low framerate in flightgear, cpu not running at full
 speed, thermal related?
From:   Zhang Rui <rui.zhang@intel.com>
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org
Date:   Sun, 09 Jun 2019 22:13:00 +0800
In-Reply-To: <20190609121212.GA4520@amd>
References: <20190609111732.GA2885@amd> <20190609112340.GA9966@amd>
         <20190609121212.GA4520@amd>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 日, 2019-06-09 at 14:12 +0200, Pavel Machek wrote:
> Hi!
> 
> > 
> > > 
> > > When I start flightgear, I get framerates around 20 fps and cpu
> > > at
> > > 3GHz:
> > > 
> > > pavel@duo:~/bt$ cat /proc/cpuinfo  | grep MHz
> > > cpu MHz		    : 3027.471
> > > cpu MHz		      : 2981.863
> > > cpu MHz		      	: 2958.352
> > > cpu MHz			  : 2864.001
> > > pavel@duo:~/bt$
> > > 
> > > (Ok, fgfs is really only running at single core, so why do both
> > > cores
> > > run at 3GHz?)
> > > 
> > > But temperatures get quite high:
> > > 
> > > pavel@duo:~/bt$ sensors
> > > thinkpad-isa-0000
> > > Adapter: ISA adapter
> > > fan1:        4485 RPM
> > > 
> > > coretemp-isa-0000
> > > Adapter: ISA adapter
> > > Package id 0:  +98.0°C  (high = +86.0°C, crit = +100.0°C)
> > > Core 0:        +98.0°C  (high = +86.0°C, crit = +100.0°C)
> > > Core 1:        +91.0°C  (high = +86.0°C, crit = +100.0°C)
> > > 
> > > And soon cpu goes to 1.5GHz range, with framerates going down to
> > > 12fps. That's a bit low.
> > > 
> > > Room temperature is 26Celsius.
> > > 
> > > The CPU is Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz . I guess it
> > > means
> > > it should be able to sustain both cores running at 2.5GHz?
> > > 
> > > Any ideas? Were there any recent changes in that area?
> > I tried kernel compile. It keeps both cores at 3GHz, temperature
> > goes
> > up over 95C, and then cpus start going down to 2.3GHz... and then
> > down
> > to 2GHz... and down to 1.9GHz.
> > 
> > watch bash -c 'sensors;  cat /proc/cpuinfo | grep MHz'
> Situation is very different with v4.6 distro based kernel.
> 
> CPU MHz is only getting values round to 100MHz. It does not go above
> 2.5GHz, but it does not go below 2.5GHz under the load, either.
> 
> ACPI adapter appears in sensors output.

what temperature does coretemp report?
can you please provide the sensors output in 4.6 during kernel
compiling?

can you attach the output of "grep . /sys/class/thermal/thermal*/*"
when the temperature goes high in both kernels?

thanks,
rui
> 
> Now I tried going to 5.2-rc4. It behaves the same as 5.2-rc2. Goes up
> to 3GHz briefly but then down to 2.0GHz and below under load.
> 
> Ideas welcome.
> 
> Best regards,
> 									
> Pavel
