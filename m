Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0223A07B1
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 01:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhFHXVk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 19:21:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:13211 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234389AbhFHXVk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Jun 2021 19:21:40 -0400
IronPort-SDR: dsQbvRzjSlK+hSX3+2kcjPSY1uiOHMPy3qGRV/gzAhZqFXpo4fPkeB8k/gPl8mcz/aMDVvCL/2
 k8XbDsXbeqoQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="290592962"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="290592962"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 16:19:46 -0700
IronPort-SDR: i7Ms0x9+i4CvbocdhHNYInqqzjW97ltP0lsLX133WWPol3S1sefgoOTBDtq+C+YYl81ciUVYLs
 sbKtpJRImrPQ==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="402240572"
Received: from dabarred-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.185.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 16:19:45 -0700
Subject: Re: [PATCH v6 1/1] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20210601142103.6378-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJZ5v0htnjWs1e4sSJNx2_S7-bbPtt8V-QiNmkU3UM7RbADGKQ@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b50a5910-4a98-8fdd-fda5-83e9595a2977@linux.intel.com>
Date:   Tue, 8 Jun 2021 16:19:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0htnjWs1e4sSJNx2_S7-bbPtt8V-QiNmkU3UM7RbADGKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 6/1/21 10:36 AM, Rafael J. Wysocki wrote:
>> As per ACPI specification r6.4, sec 5.2.12.19, a new sub
>> structure – multiprocessor wake-up structure - is added to the
>> ACPI Multiple APIC Description Table (MADT) to describe the
>> information of the mailbox. If a platform firmware produces the
>> multiprocessor wake-up structure, then OS may use this new
>> mailbox-based mechanism to wake up the APs.
>>
>> Add ACPI MADT wake table parsing support for x86 platform and if
>> MADT wake table is present, update apic->wakeup_secondary_cpu with
>> new API which uses MADT wake mailbox to wake-up CPU.
>>
>> Co-developed-by: Sean Christopherson<sean.j.christopherson@intel.com>
>> Signed-off-by: Sean Christopherson<sean.j.christopherson@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
>> Reviewed-by: Andi Kleen<ak@linux.intel.com>
> All of my comments have been addressed, so
> 
> Reviewed-by: Rafael J. Wysocki<rafael.j.wysocki@intel.com>

Thomas/Peter Z,

Gentle ping. Any comments?

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
