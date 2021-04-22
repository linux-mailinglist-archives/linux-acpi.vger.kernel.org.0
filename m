Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CA53688CF
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 00:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhDVWEV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 18:04:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:56421 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235977AbhDVWEV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Apr 2021 18:04:21 -0400
IronPort-SDR: 5ec561aa3oxhr3bed7DZIeqkcHQydcC+LTfpF134PXbX/ouYgOrGh+6PCP8/1q5bqqUZl+NTv+
 rwLaqjbPI1JQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="259934270"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="259934270"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 15:03:45 -0700
IronPort-SDR: 6YatOzq15BNkNW1fBtVZO+Lh7wqMpQj2WX8FOMBioqgOtcM3VoA5nVeRqephVcyJpTSNMCJwtK
 xckjOpimz4dA==
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="401991792"
Received: from eassadia-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.4.68])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 15:03:44 -0700
Subject: Re: [PATCH v2 0/3] Add multiprocessor wake-up support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210422220113.GG7021@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <54c5642c-f82c-e89c-2969-ad48358bfcaf@linux.intel.com>
Date:   Thu, 22 Apr 2021 15:03:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210422220113.GG7021@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/22/21 3:01 PM, Borislav Petkov wrote:
> On Thu, Apr 22, 2021 at 02:47:05PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Add multiprocessor wakeup support using MADT ACPI table for x86
>> platforms. It uses mailbox based mechanism to wake up the APs. You
>> can get more details about the ACPI table and mailbox protocol in
>> Guest-Host-Communication Interface (GHCI) for Intel Trust Domain
>> Extensions (Intel TDX) specification document (sec 4.1)
>>
>> https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface.pdf
>>
>> Changes since v1:
>>   * Removed signoff from Rob and Erik.
> 
> For the future: please do not resend your patchset immediately but give
> reviewers time to have a look at it.
> 
> Your current patchset comprises of only 3 patches - now imagine if it
> were, 15, or 20 or more? Now also imagine if you were not the only one
> submitter who would resend immediately... you'd soon have maintainers
> drowning in email - not that they don't do so already anyway.
> 
> While waiting, you could read
> 
> Documentation/process/submitting-patches.rst

Sorry for the trouble. I will keep it in mind for next submission.

> 
> for example.
> 
> Thx.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
