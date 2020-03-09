Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC4B317D7B0
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2020 02:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgCIBRG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 8 Mar 2020 21:17:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:17101 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgCIBRG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 8 Mar 2020 21:17:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2020 18:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,530,1574150400"; 
   d="scan'208";a="235513376"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga008.jf.intel.com with ESMTP; 08 Mar 2020 18:17:02 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list\:ACPI COMPONENT ARCHITECTURE \(ACPICA\)" 
        <devel@acpica.org>, Linux PM <linux-pm@vger.kernel.org>,
        <lkp@lists.01.org>, Andi Kleen <andi.kleen@intel.com>
Subject: Re: [LKP] Re: [cpufreq] 909c0e9cc1: fwq.fwq.med 210.0% improvement
References: <20200305013509.GF5972@shao2-debian>
        <951b0986-bb35-d9a5-1639-0a8cdb3dcd04@intel.com>
        <cbe4887c-d54a-c4aa-e4bf-981b5fcc291d@intel.com>
        <CAJZ5v0g2vzYQ04GyrpubLx2+B0O4SDbqoTDCvhnSyaj1j1xswA@mail.gmail.com>
        <87zhcuyxce.fsf@yhuang-dev.intel.com>
        <CAJZ5v0g3f1Rf0HFLH+hWkbW6q0_E1RjhX2AeUxa_DHfJRQj7Qw@mail.gmail.com>
Date:   Mon, 09 Mar 2020 09:17:02 +0800
In-Reply-To: <CAJZ5v0g3f1Rf0HFLH+hWkbW6q0_E1RjhX2AeUxa_DHfJRQj7Qw@mail.gmail.com>
        (Rafael J. Wysocki's message of "Fri, 6 Mar 2020 10:54:42 +0100")
Message-ID: <87imjez5rl.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Fri, Mar 6, 2020 at 4:29 AM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Hi, Rafael,
>>
>> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>>
>> > On Thu, Mar 5, 2020 at 9:18 AM Rong Chen <rong.a.chen@intel.com> wrote:
>> >>
>> >>
>> >>
>> >> On 3/5/20 3:50 PM, Rafael J. Wysocki wrote:
>> >> > On 3/5/2020 2:35 AM, kernel test robot wrote:
>> >> >> Greeting,
>> >> >>
>> >> >> FYI, we noticed a 210.0% improvement of fwq.fwq.med due to commit:
>> >> >
>> >> > Well, that sounds impressive. :-)
>> >> >
>> >> >
>> >> >>
>> >> >> commit: 909c0e9cc11ba39fa5a660583b25c2431cf54deb ("cpufreq:
>> >> >> intel_pstate: Use passive mode by default without HWP")
>> >> >> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git
>> >> >> intel_pstate-passive
>> >> >>
>> >> >> in testcase: fwq
>> >> >> on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz
>> >> >> with 48G memory
>> >> >> with following parameters:
>> >> >>
>> >> >>     nr_task: 100%
>> >> >>     samples: 100000ss
>> >> >>     iterations: 18x
>> >> >>     cpufreq_governor: powersave
>> >> >
>> >> > The governor should be schedutil, though, unless it is explicitly set
>> >> > to powersave in the test environment.
>> >> >
>> >> > Is that the case?
>> >> >
>> >> >
>> >>
>> >> Hi Rafael,
>> >>
>> >> Yes, we set to powersave for this test.
>> >
>> > I wonder why this is done?  Is there any particular technical reason
>> > for doing that?
>>
>> fwq is a noise benchmark to measure the hardware and software noise
>> level.  More information could be found in the following document.
>>
>> https://asc.llnl.gov/sequoia/benchmarks/FTQ_summary_v1.1.pdf
>>
>> In 0day, to measure the noise introduced by power management, we will
>> run fwq with the performance and powersave governors.  Do you think this
>> is reasonable?  Or we should use some other governors?
>
> I think that the schedutil governor should be tested too if present.
>
> Also note that for the intel_pstate driver "powersave" may mean
> different things depending on the current operation mode of the
> driver.  If scaling_driver is "intel_pstate", then "powersave" is the
> driver's built-in algorithm.  If scaling_driver is "intel_cpufreq",
> though, "powersave" means running at the minimum frequency all the
> time.

Thanks for your guidance.  We will test schedutil governor in the future
too.

As for powersave, should we stop testing it?  Or just pay attention to
the possible issue you pointed out?

Should we add ondemand governor?

Best Regards,
Huang, Ying
