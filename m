Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA66D17A116
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2020 09:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgCEISi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Mar 2020 03:18:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:9391 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgCEISh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Mar 2020 03:18:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 00:18:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="234342532"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga008.jf.intel.com with ESMTP; 05 Mar 2020 00:18:34 -0800
Subject: Re: [cpufreq] 909c0e9cc1: fwq.fwq.med 210.0% improvement
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org, lkp@lists.01.org,
        Rafael Wysocki <rafael@kernel.org>
References: <20200305013509.GF5972@shao2-debian>
 <951b0986-bb35-d9a5-1639-0a8cdb3dcd04@intel.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <cbe4887c-d54a-c4aa-e4bf-981b5fcc291d@intel.com>
Date:   Thu, 5 Mar 2020 16:18:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <951b0986-bb35-d9a5-1639-0a8cdb3dcd04@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 3/5/20 3:50 PM, Rafael J. Wysocki wrote:
> On 3/5/2020 2:35 AM, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed a 210.0% improvement of fwq.fwq.med due to commit:
>
> Well, that sounds impressive. :-)
>
>
>>
>> commit: 909c0e9cc11ba39fa5a660583b25c2431cf54deb ("cpufreq: 
>> intel_pstate: Use passive mode by default without HWP")
>> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git 
>> intel_pstate-passive
>>
>> in testcase: fwq
>> on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz 
>> with 48G memory
>> with following parameters:
>>
>>     nr_task: 100%
>>     samples: 100000ss
>>     iterations: 18x
>>     cpufreq_governor: powersave
>
> The governor should be schedutil, though, unless it is explicitly set 
> to powersave in the test environment.
>
> Is that the case?
>
>

Hi Rafael,

Yes, we set to powersave for this test.

user  :notice: [  +0.061763] 2020-03-04 21:15:33
user  :notice: [  +0.057012] for cpu_dir in 
/sys/devices/system/cpu/cpu[0-9]*
user  :notice: [  +0.059494] do
user  :notice: [  +0.046899]    online_file="$cpu_dir"/online
user  :notice: [  +0.074995]    [ -f "$online_file" ] && [ "$(cat 
"$online_file")" -eq 0 ] && continue
user  :notice: [  +0.080600] file="$cpu_dir"/cpufreq/scaling_governor
user  :notice: [  +0.067584]    [ -f "$file" ] && echo "powersave" > "$file"
user  :notice: [  +0.050203] done
user  :notice: [  +0.084039]    Internal Reference Designator: IPMI_LAN
user  :notice: [  +0.059001]    External Reference Designator: IPMI_LAN
user  :notice: [  +0.056562] IPMI Device Information
user  :notice: [  +0.058074] BMC ARP Control         : ARP Responses 
Enabled, Gratuitous ARP Disabled
user  :notice: [  +0.053677] 2020-03-04 21:15:34 ./t_fwq -n 100000 -w 18 
-t 16
user  :notice: [Mar 4 21:22] numthreads = 16
user  :notice: [  +0.007123] thread number 1 being created.
user  :notice: [  +0.008334] thread number 2 being created.
user  :notice: [  +0.008335] thread number 3 being created.
user  :notice: [  +0.008222] thread number 4 being created.
user  :notice: [  +0.008359] thread number 5 being created.
user  :notice: [  +0.008360] thread number 6 being created.
user  :notice: [  +0.008128] thread number 7 being created.
user  :notice: [  +0.008409] thread number 8 being created.
user  :notice: [  +0.008317] thread number 9 being created.
user  :notice: [  +0.008352] thread number 10 being created.
user  :notice: [  +0.008480] thread number 11 being created.
user  :notice: [  +0.008393] thread number 12 being created.
user  :notice: [  +0.008519] thread number 13 being created.
user  :notice: [  +0.008518] thread number 14 being created.
user  :notice: [  +0.008266] thread number 15 being created.
user  :notice: [  +0.009492] Starting FWQ_CORE with work_length = 262144
user  :notice: [  +0.010539] Starting FWQ_CORE with work_length = 262144
user  :notice: [  +0.010499] Starting FWQ_CORE with work_length = 262144
user  :notice: [  +0.010492] Starting FWQ_CORE with work_length = 262144
user  :notice: [  +0.010473] Starting FWQ_CORE with work_length = 262144
user  :notice: [  +0.010255] Starting FWQ_CORE with work_length = 262144
user  :notice: [  +0.010525] Starting FWQ_CORE with work_length = 262144
user  :notice: [  +0.013377] Starting FWQ_CORE with work_length = 262144
user  :notice: [  +0.013653] Starting FWQ_CORE with work_length = 262144
user  :notice: [  +0.013755] Starting FWQ_CORE with work_length = 262144
user  :notice: [  +0.013936] Starting FWQ_CORE with work_length = 262144
user  :notice: [  +0.013843] Starting FWQ_CORE with work_length = 262144
user  :notice: [  +0.013884] Starting FWQ_CORE with work_length = 262144
user  :notice: [  +0.013685] Starting FWQ_CORE with work_length = 262144
user  :notice: [  +0.013835] Starting FWQ_CORE with work_length = 262144
user  :notice: [  +0.013927] Starting FWQ_CORE with work_length = 262144


Best Regards,
Rong Chen
