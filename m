Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F148A024
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2019 15:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfHLNzV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Aug 2019 09:55:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:45219 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbfHLNzV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Aug 2019 09:55:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 06:55:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="scan'208";a="187434113"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.80.195]) ([10.252.80.195])
  by orsmga002.jf.intel.com with ESMTP; 12 Aug 2019 06:55:17 -0700
Subject: Re: [PATCH v3 0/8] PM / ACPI: sleep: Additional changes related to
 suspend-to-idle
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <5997740.FPbUVk04hV@kreacher>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <a5548466-2e8e-84d0-357d-e2ca0c72097c@linux.intel.com>
Date:   Mon, 12 Aug 2019 19:25:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5997740.FPbUVk04hV@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael

On 02-Aug-19 4:03 PM, Rafael J. Wysocki wrote:
> Hi All,
>
>>> On top of the "Simplify the suspend-to-idle control flow" patch series
>>> posted previously:
>>>
>>> https://lore.kernel.org/lkml/71085220.z6FKkvYQPX@kreacher/
>>>
>>> sanitize the suspend-to-idle flow even further.
>>>
>>> First off, decouple EC wakeup from the LPS0 _DSM processing (patch 1).
>>>
>>> Next, reorder the code to invoke LPS0 _DSM Functions 5 and 6 in the
>>> specification-compliant order with respect to suspending and resuming
>>> devices (patch 2).
>>>
>>> Finally, rearrange lps0_device_attach() (patch 3) and add a command line
>>> switch to prevent the LPS0 _DSM from being used.
>> The v2 is because I found a (minor) bug in patch 1, decided to use a module
>> parameter instead of a kernel command line option in patch 4.  Also, there
>> are 4 new patches:
>>
>> Patch 5: Switch the EC over to polling during "noirq" suspend and back
>> during "noirq" resume.
>>
>> Patch 6: Eliminate acpi_sleep_no_ec_events().
>>
>> Patch 7: Consolidate some EC code depending on PM_SLEEP.
>>
>> Patch 8: Add EC GPE dispatching debug message.
> The v3 is just a rearranged v2 so as to move the post sensitive patch (previous patch 2)
> to the end of the series.   [After applying the full series the code is the same as before.]
>
> For easier testing, the series (along with some previous patches depended on by it)
> is available in the pm-s2idle-testing branch of the linux-pm.git tree at kernel.org:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=pm-s2idle-testing
>
> Please refer to the changelogs for details.


I have tested both pm-s2idle-testing and pm-s2idle-rework branches 
including recently introduced commit "PM: suspend: Fix 
platform_suspend_prepare_noirq()".

Works fine for me on Ice Lake platform.

  Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>


> Thanks,
> Rafael
>
>
>
