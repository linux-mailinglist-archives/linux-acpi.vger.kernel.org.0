Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8661A7E40
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 10:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfIDIqx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 04:46:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:7115 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbfIDIqx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Sep 2019 04:46:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 01:46:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; 
   d="scan'208";a="185046029"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga003.jf.intel.com with ESMTP; 04 Sep 2019 01:46:50 -0700
Subject: Re: [kbuild-all] [PATCH v1] ACPI / platform: Unregister stale
 platform devices
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild test robot <lkp@intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ferry Toth <fntoth@gmail.com>, linux-acpi@vger.kernel.org,
        kbuild-all@01.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>
References: <20190830143432.21695-1-andriy.shevchenko@linux.intel.com>
 <201909021425.8xcQQHYK%lkp@intel.com>
 <20190902095249.GU2680@smile.fi.intel.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <b664df76-f9a8-6c18-aaf5-877d10b9e36b@intel.com>
Date:   Wed, 4 Sep 2019 16:46:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190902095249.GU2680@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 9/2/19 5:52 PM, Andy Shevchenko wrote:
> On Mon, Sep 02, 2019 at 02:38:05PM +0800, kbuild test robot wrote:
>> Hi Andy,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [cannot apply to v5.3-rc6 next-20190830]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/ACPI-platform-Unregister-stale-platform-devices/20190902-001307
>> config: x86_64-lkp (attached as .config)
>> compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
>> reproduce:
>>          # save the attached .config to linux build tree
>>          make ARCH=x86_64
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     drivers//acpi/acpi_platform.c: In function 'acpi_platform_device_find_by_adev':
>>>> drivers//acpi/acpi_platform.c:38:8: error: implicit declaration of function 'bus_find_device_by_acpi_dev'; did you mean 'bus_find_device_by_name'? [-Werror=implicit-function-declaration]
> False positive, it has Depends-on tag for the dependency which is not yet in
> upstream.
>
> Btw, have you noticed double slash in the paths in your scripts for LKP?
> (Look above)

Hi Andy,

Thanks for the new finding, The double slash not always appears .
I think the double slash is not from our scripts.

Best Regards,
Rong Chen
