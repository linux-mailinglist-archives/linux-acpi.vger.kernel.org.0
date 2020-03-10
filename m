Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFC117F23C
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Mar 2020 09:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgCJIqJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Mar 2020 04:46:09 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45624 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgCJIqI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2020 04:46:08 -0400
Received: by mail-oi1-f195.google.com with SMTP id v19so13023372oic.12;
        Tue, 10 Mar 2020 01:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A8GV2HuSqXBx4DrwJWUZYgLB27q46+xOcdSszllMiCI=;
        b=DGv3qAG1QgxxigCW9HuiJuOeSKZYMK6T34h194WrqL+gsB3Q5ld+HHou2A1Zz4+z9J
         uImch6vMK9FyIYY6Ya6L6S+dZ3UVU+gHIDiCzSAnqvHr0K9mO06W3WsyCgB6Y4p8nTDu
         S0gQ6FJlEBGNzwbv8HaS/ECUZKn9Bc8TkT8vsw7quDD7gQnUMsTdsxmZ5QLVEkVQPPsP
         cNwuTHFjk+q1bscL27o6Sw0oCgTra+pEoKiLHvUSGPOY6B3+j1kejR1HynCfJ7dFWqUG
         A7o84tvVLQIVaBcUz1WVnFJzrMlP6eRIB7wUL6vMmtk27391Hi3mct10W7Q8DMnXs3Hz
         rX0g==
X-Gm-Message-State: ANhLgQ33OkQs4zM74hAMkqDUvDyvjxqwbvfeHTKosMsfrxiAMGUG0yA9
        mCSr6xKIM3EPUrvEvlUgL2aXk19EAobyQ++mJEU=
X-Google-Smtp-Source: ADFU+vttQqetvNaCij6CJgxOr6ZhOH0rw6dT6OZELsXWp4+In7/oAlCGDZCXVnl7OX4oCGpGQHis/ArFx874qPoc7Zk=
X-Received: by 2002:aca:df0b:: with SMTP id w11mr352964oig.68.1583829968022;
 Tue, 10 Mar 2020 01:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200305013509.GF5972@shao2-debian> <951b0986-bb35-d9a5-1639-0a8cdb3dcd04@intel.com>
 <cbe4887c-d54a-c4aa-e4bf-981b5fcc291d@intel.com> <CAJZ5v0g2vzYQ04GyrpubLx2+B0O4SDbqoTDCvhnSyaj1j1xswA@mail.gmail.com>
 <87zhcuyxce.fsf@yhuang-dev.intel.com> <CAJZ5v0g3f1Rf0HFLH+hWkbW6q0_E1RjhX2AeUxa_DHfJRQj7Qw@mail.gmail.com>
 <87imjez5rl.fsf@yhuang-dev.intel.com>
In-Reply-To: <87imjez5rl.fsf@yhuang-dev.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Mar 2020 09:45:57 +0100
Message-ID: <CAJZ5v0hdAnN-mu8b9g19cM8AqYGXDbs1qVxLu-qE-3P6fP1=XA@mail.gmail.com>
Subject: Re: [LKP] Re: [cpufreq] 909c0e9cc1: fwq.fwq.med 210.0% improvement
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rong Chen <rong.a.chen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>, lkp@lists.01.org,
        Andi Kleen <andi.kleen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 9, 2020 at 2:17 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Fri, Mar 6, 2020 at 4:29 AM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Hi, Rafael,
> >>
> >> "Rafael J. Wysocki" <rafael@kernel.org> writes:
> >>
> >> > On Thu, Mar 5, 2020 at 9:18 AM Rong Chen <rong.a.chen@intel.com> wrote:
> >> >>
> >> >>
> >> >>
> >> >> On 3/5/20 3:50 PM, Rafael J. Wysocki wrote:
> >> >> > On 3/5/2020 2:35 AM, kernel test robot wrote:
> >> >> >> Greeting,
> >> >> >>
> >> >> >> FYI, we noticed a 210.0% improvement of fwq.fwq.med due to commit:
> >> >> >
> >> >> > Well, that sounds impressive. :-)
> >> >> >
> >> >> >
> >> >> >>
> >> >> >> commit: 909c0e9cc11ba39fa5a660583b25c2431cf54deb ("cpufreq:
> >> >> >> intel_pstate: Use passive mode by default without HWP")
> >> >> >> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git
> >> >> >> intel_pstate-passive
> >> >> >>
> >> >> >> in testcase: fwq
> >> >> >> on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz
> >> >> >> with 48G memory
> >> >> >> with following parameters:
> >> >> >>
> >> >> >>     nr_task: 100%
> >> >> >>     samples: 100000ss
> >> >> >>     iterations: 18x
> >> >> >>     cpufreq_governor: powersave
> >> >> >
> >> >> > The governor should be schedutil, though, unless it is explicitly set
> >> >> > to powersave in the test environment.
> >> >> >
> >> >> > Is that the case?
> >> >> >
> >> >> >
> >> >>
> >> >> Hi Rafael,
> >> >>
> >> >> Yes, we set to powersave for this test.
> >> >
> >> > I wonder why this is done?  Is there any particular technical reason
> >> > for doing that?
> >>
> >> fwq is a noise benchmark to measure the hardware and software noise
> >> level.  More information could be found in the following document.
> >>
> >> https://asc.llnl.gov/sequoia/benchmarks/FTQ_summary_v1.1.pdf
> >>
> >> In 0day, to measure the noise introduced by power management, we will
> >> run fwq with the performance and powersave governors.  Do you think this
> >> is reasonable?  Or we should use some other governors?
> >
> > I think that the schedutil governor should be tested too if present.
> >
> > Also note that for the intel_pstate driver "powersave" may mean
> > different things depending on the current operation mode of the
> > driver.  If scaling_driver is "intel_pstate", then "powersave" is the
> > driver's built-in algorithm.  If scaling_driver is "intel_cpufreq",
> > though, "powersave" means running at the minimum frequency all the
> > time.
>
> Thanks for your guidance.  We will test schedutil governor in the future
> too.
>
> As for powersave, should we stop testing it?

You cannot stop testing it, because it is the default governor
algorithm for intel_pstate working in the active mode.

>  Or just pay attention to the possible issue you pointed out?

Yes, please!

Basically, I would recommend to test the following configurations by default:

(1) scaling_driver = intel_pstate + scaling_governor = powersave

(2) scaling_driver = intel_cpufreq + scaling_governor = schedutil

The other ones are kind of less interesting.

[Note that in order to switch over from intel_pstate to intel_cpufreq,
you need to write "passive" into
/sys/devices/system/cpu/intel_pstate/status and if that write fails,
configuration (2) is not available and may be skipped.]

> Should we add ondemand governor?

Not necessarily, maybe as a reference only if you have spare cycles.

Thanks!
