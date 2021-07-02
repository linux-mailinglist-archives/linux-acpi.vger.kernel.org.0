Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D74A3BA1DF
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jul 2021 16:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhGBOFL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jul 2021 10:05:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:23721 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232537AbhGBOFL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Jul 2021 10:05:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10033"; a="196022697"
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="196022697"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 07:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="482452300"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jul 2021 07:02:11 -0700
Subject: Re: [PATCH 2/2] ACPI: let BIOS fall back to legacy handling if PRM
 disabled
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <1625209430-19934-1-git-send-email-aubrey.li@intel.com>
 <1625209430-19934-2-git-send-email-aubrey.li@intel.com>
 <CAJZ5v0jq=-97bW_s7dx2U=y-3rZoJsLtFre2XXYAaQgAdbQdXA@mail.gmail.com>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <f8f0b7ee-b225-eff0-cfcc-bb43e9e520dc@linux.intel.com>
Date:   Fri, 2 Jul 2021 22:02:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jq=-97bW_s7dx2U=y-3rZoJsLtFre2XXYAaQgAdbQdXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 7/2/21 7:37 PM, Rafael J. Wysocki wrote:
> On Fri, Jul 2, 2021 at 9:03 AM Aubrey Li <aubrey.li@intel.com> wrote:
>>
>> Based on _OSC PRM bit, BIOS can choose switch from legacy handling
>> to using PRM. So if CONFIG_ACPI_PRMT is disabled, this bit should
>> not be set to let BIOS fall back to the legacy handling (such as SMI).
>>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>> ---
>>  drivers/acpi/bus.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 60fb6a84..30a3d4a 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -303,7 +303,9 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>>
>>         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
>>         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
>> +#ifdef CONFIG_ACPI_PRMT
>>         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PRM_SUPPORT;
>> +#endif
> 
> What about using if (IS_ENABLED()) instead of #ifdef?

aha, sorry, using if (IS_ENABLED()) is better, will come up with a new version soon.

Thanks,
-Aubrey
