Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0404417B99D
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2020 10:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgCFJy4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Mar 2020 04:54:56 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45021 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgCFJy4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Mar 2020 04:54:56 -0500
Received: by mail-ot1-f65.google.com with SMTP id v22so1811625otq.11;
        Fri, 06 Mar 2020 01:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZddTJZL3AntI4PKGAxsh5Sq6ETyogrz2w07vElT0QyA=;
        b=myQZfbTYFblT4k5wbPCbvmTxRfJrK050gUAYN2V1aTUjHUbkJCOPlYCc5+RRtlhyGF
         d+jvWoAk4cspOSUe93oyORYRzVF9x0UYslJ4xYYVKWuDLnPbjmaoZFvxGRFtJZqdSt28
         0prI1oCA6ozyBFRTzDRCh+1YSXN9H1MVtLWGLpGVB8Be/X1fy4uVXHAuccM2cHxsX8Rc
         PF/GB22jIqcu62rG1Xfr7+TWaf11meifixlu0zB8wn7GRdy+W0GhEKl1cfjsXiueGm1B
         JLp29EyDC++4SZw4GyYavwLLvkWeWv10T5M7cFqCxlGISSWRA09vgpTatSAh7YPbMI5d
         1l1A==
X-Gm-Message-State: ANhLgQ3uBugUfHFWMDuUJg295WfzAxMG5dArW4T33OyRENcP1uHh9HPD
        jQ1k3taq2iHc81V6nIvQk7ud6aI6SrMYq5JXgxUATg==
X-Google-Smtp-Source: ADFU+vtqRXDBI3R0DZ+1xYRefdIX7rKVaaXBMQIFjIo+Fbyy9C/VEwHjIb8g6CYzSBwDU+IQDzxlfDndhYrUBX/vp6M=
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr1822295otn.262.1583488493901;
 Fri, 06 Mar 2020 01:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20200305013509.GF5972@shao2-debian> <951b0986-bb35-d9a5-1639-0a8cdb3dcd04@intel.com>
 <cbe4887c-d54a-c4aa-e4bf-981b5fcc291d@intel.com> <CAJZ5v0g2vzYQ04GyrpubLx2+B0O4SDbqoTDCvhnSyaj1j1xswA@mail.gmail.com>
 <87zhcuyxce.fsf@yhuang-dev.intel.com>
In-Reply-To: <87zhcuyxce.fsf@yhuang-dev.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Mar 2020 10:54:42 +0100
Message-ID: <CAJZ5v0g3f1Rf0HFLH+hWkbW6q0_E1RjhX2AeUxa_DHfJRQj7Qw@mail.gmail.com>
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

On Fri, Mar 6, 2020 at 4:29 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> Hi, Rafael,
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Thu, Mar 5, 2020 at 9:18 AM Rong Chen <rong.a.chen@intel.com> wrote:
> >>
> >>
> >>
> >> On 3/5/20 3:50 PM, Rafael J. Wysocki wrote:
> >> > On 3/5/2020 2:35 AM, kernel test robot wrote:
> >> >> Greeting,
> >> >>
> >> >> FYI, we noticed a 210.0% improvement of fwq.fwq.med due to commit:
> >> >
> >> > Well, that sounds impressive. :-)
> >> >
> >> >
> >> >>
> >> >> commit: 909c0e9cc11ba39fa5a660583b25c2431cf54deb ("cpufreq:
> >> >> intel_pstate: Use passive mode by default without HWP")
> >> >> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git
> >> >> intel_pstate-passive
> >> >>
> >> >> in testcase: fwq
> >> >> on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz
> >> >> with 48G memory
> >> >> with following parameters:
> >> >>
> >> >>     nr_task: 100%
> >> >>     samples: 100000ss
> >> >>     iterations: 18x
> >> >>     cpufreq_governor: powersave
> >> >
> >> > The governor should be schedutil, though, unless it is explicitly set
> >> > to powersave in the test environment.
> >> >
> >> > Is that the case?
> >> >
> >> >
> >>
> >> Hi Rafael,
> >>
> >> Yes, we set to powersave for this test.
> >
> > I wonder why this is done?  Is there any particular technical reason
> > for doing that?
>
> fwq is a noise benchmark to measure the hardware and software noise
> level.  More information could be found in the following document.
>
> https://asc.llnl.gov/sequoia/benchmarks/FTQ_summary_v1.1.pdf
>
> In 0day, to measure the noise introduced by power management, we will
> run fwq with the performance and powersave governors.  Do you think this
> is reasonable?  Or we should use some other governors?

I think that the schedutil governor should be tested too if present.

Also note that for the intel_pstate driver "powersave" may mean
different things depending on the current operation mode of the
driver.  If scaling_driver is "intel_pstate", then "powersave" is the
driver's built-in algorithm.  If scaling_driver is "intel_cpufreq",
though, "powersave" means running at the minimum frequency all the
time.
