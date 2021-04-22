Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7222D368766
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Apr 2021 21:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbhDVTqw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 15:46:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:22671 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236822AbhDVTqv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Apr 2021 15:46:51 -0400
IronPort-SDR: yqNpXkex2u46diCli/Yg6soyB4By0kLO0W0WMHenut3o53x8z7MVwHKse7EY6wfUqhEmrJupFn
 BPEVHgj+XleA==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="192773847"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="192773847"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 12:46:16 -0700
IronPort-SDR: LfMA9WDPEJX34pjQApUJIbiAmBRaCBOWnkHBSUknuh52pzdaZ8XHLRiSOuDeh9R08s8EEYW5jw
 dgXqk7/4UrcA==
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="401957685"
Received: from eassadia-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.4.68])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 12:46:15 -0700
Subject: Re: [PATCH 1/3] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup
 Mailbox Structure
To:     Dave Hansen <dave.hansen@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210422192442.706906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210422192442.706906-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <98a81d5c-251b-bdb1-f5e4-5925de93f0d7@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <8928afc9-ab59-62f3-45b5-a6d26d96d90e@linux.intel.com>
Date:   Thu, 22 Apr 2021 12:46:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <98a81d5c-251b-bdb1-f5e4-5925de93f0d7@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/22/21 12:37 PM, Dave Hansen wrote:
> On 4/22/21 12:24 PM, Kuppuswamy Sathyanarayanan wrote:
>> ACPICA commit f1ee04207a212f6c519441e7e25397649ebc4cea
>>
>> Add Multiprocessor Wakeup Mailbox Structure definition. It is useful
>> in parsing MADT Wake table.
>>
>> Link: https://github.com/acpica/acpica/commit/f1ee0420
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Signed-off-by: Bob Moore <robert.moore@intel.com>
>> Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
> 
> This SoB chain doesn't look right.  This is what it would have been if
> You sent it to Bob who sent it to Erik, who submitted it.
Internally, its submitted to Bob and Erik for ACPICA merge.
I think Sign-off is added to track it.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
