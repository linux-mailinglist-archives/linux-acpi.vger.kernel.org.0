Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5233717A0B0
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2020 08:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgCEHuE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Mar 2020 02:50:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:62923 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgCEHuE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Mar 2020 02:50:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 23:50:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="234335912"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.138.71]) ([10.249.138.71])
  by orsmga008.jf.intel.com with ESMTP; 04 Mar 2020 23:50:01 -0800
Subject: Re: [cpufreq] 909c0e9cc1: fwq.fwq.med 210.0% improvement
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org, lkp@lists.01.org,
        Rafael Wysocki <rafael@kernel.org>
References: <20200305013509.GF5972@shao2-debian>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <951b0986-bb35-d9a5-1639-0a8cdb3dcd04@intel.com>
Date:   Thu, 5 Mar 2020 08:50:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305013509.GF5972@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 3/5/2020 2:35 AM, kernel test robot wrote:
> Greeting,
>
> FYI, we noticed a 210.0% improvement of fwq.fwq.med due to commit:

Well, that sounds impressive. :-)


>
> commit: 909c0e9cc11ba39fa5a660583b25c2431cf54deb ("cpufreq: intel_pstate: Use passive mode by default without HWP")
> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git intel_pstate-passive
>
> in testcase: fwq
> on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 48G memory
> with following parameters:
>
> 	nr_task: 100%
> 	samples: 100000ss
> 	iterations: 18x
> 	cpufreq_governor: powersave

The governor should be schedutil, though, unless it is explicitly set to 
powersave in the test environment.

Is that the case?


