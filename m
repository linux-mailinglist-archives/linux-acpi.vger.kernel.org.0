Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83CD70AA
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 10:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfJOIDP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Oct 2019 04:03:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:45311 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfJOIDP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Oct 2019 04:03:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 01:03:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,298,1566889200"; 
   d="scan'208";a="395453395"
Received: from fyin-mobl.ccr.corp.intel.com (HELO [10.239.205.86]) ([10.239.205.86])
  by fmsmga005.fm.intel.com with ESMTP; 15 Oct 2019 01:03:13 -0700
Subject: Re: [RESEND] ACPI / processor_idle: use dead loop instead of io port
 access for wait
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190909073937.31554-1-fengwei.yin@intel.com>
 <12278756.3dKznOqol2@kreacher>
 <8a65bf97-c066-8e5e-ba82-75e2a6fd5b45@intel.com>
 <3727681.FYoUZqeJdN@kreacher>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
Message-ID: <187d70f6-3c41-a42f-26f1-9f3317ccb7da@intel.com>
Date:   Tue, 15 Oct 2019 16:03:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3727681.FYoUZqeJdN@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10/14/2019 5:38 PM, Rafael J. Wysocki wrote:
> On Friday, October 11, 2019 3:30:41 PM CEST Yin, Fengwei wrote:
>>
>> On 10/11/2019 5:05 PM, Rafael J. Wysocki wrote:
>>> Sorry for the delay.
>> No problem.
>>
>>>
>>> On Monday, September 9, 2019 9:39:37 AM CEST Yin Fengwei wrote:
>>>> In function acpi_idle_do_entry(), we do an io port access to guarantee
>>>> hardware behavior. But it could trigger unnecessary vmexit for
>>>> virtualization environemnt.
>>>
>>> Is this a theoretical problem, or do you actually see it?
>>>
>>> If you see it, I'd like to have a pointer to a bug report regarding it
>>> or similar.
>> We did see this issue when we run linux as guest with ACRN hypervisor
>> instead of kvm or xen. In our case, we export all native C states to
>> guest and let guest choose which C state it will enter.
>>
>> And we observed many pm timer port access when guest tried to enter
>> deeper C state (Yes, we emulate pm timer so pm timer access will trigger
>> vmexit).
> 
> Can you please put this information into the changelog of your patch?
I added this information to the patch commit message and sent out v2.
Thanks a lot for reviewing and comments.

Regards
Yin, Fengwei

> 
> It works very well as a rationale for me. :-)
> 
> 
> 


