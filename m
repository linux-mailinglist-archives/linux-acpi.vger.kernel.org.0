Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48B43688AF
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Apr 2021 23:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbhDVVkw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 17:40:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:64973 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237132AbhDVVkw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Apr 2021 17:40:52 -0400
IronPort-SDR: WtHpImADdHjVFsJWzoAnhtWg3nZfeoUoKMtTMNupHm1X5dldNL7PyWrsl33/yBGhbREl3ssf5T
 wTrEjnp4ImOA==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="257284552"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="257284552"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 14:40:15 -0700
IronPort-SDR: dH98Ev7/CSipN/hR9XXSmLaap3kK5m8LPpTHT5x5mGbednv2QsDFStVMFXb+dzO/dQg6Fl9/h2
 Y1Whr4zSjmnA==
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="401985061"
Received: from eassadia-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.4.68])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 14:40:14 -0700
Subject: Re: [PATCH 1/3] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup
 Mailbox Structure
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
References: <20210422192442.706906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210422192442.706906-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <98a81d5c-251b-bdb1-f5e4-5925de93f0d7@intel.com>
 <8928afc9-ab59-62f3-45b5-a6d26d96d90e@linux.intel.com>
 <20210422195543.GF7021@zn.tnic>
 <MWHPR11MB1599BAA9352B8C67B5EB9373F0469@MWHPR11MB1599.namprd11.prod.outlook.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <895dc0f0-bd5d-937f-aecb-a5c8c768c7e7@linux.intel.com>
Date:   Thu, 22 Apr 2021 14:40:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1599BAA9352B8C67B5EB9373F0469@MWHPR11MB1599.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/22/21 1:51 PM, Kaneda, Erik wrote:
>> This is not how this works - when Erik/Bob merge it,*then*  they add
>> their SOB. Right now it should have only your SOB.
> Sorry about that. The script to format the ACPICA upstream to Linux ACPICA automatically adds signed off-by tags from me and Bob to the patch. This would work if we go through the normal process of running the Linux script after we do an ACPICA release. We decided to submit this earlier to meet Sathya's deadline.
> 
> Sathya, Please drop these lines from this patch and the SVKL patch.

Will remove it.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
