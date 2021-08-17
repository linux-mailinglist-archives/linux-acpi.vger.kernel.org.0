Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C533EEDD3
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Aug 2021 15:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhHQN40 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Aug 2021 09:56:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:64233 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234446AbhHQN40 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Aug 2021 09:56:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="203294919"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="203294919"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 06:55:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="510482027"
Received: from favalosr-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.164.120])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 06:55:50 -0700
Subject: Re: [PATCH v7 1/1] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20210720042506.2123009-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c881e659-bb31-3d08-d7eb-0b260bb90525@linux.intel.com>
Date:   Tue, 17 Aug 2021 06:55:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720042506.2123009-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/19/21 9:25 PM, Kuppuswamy Sathyanarayanan wrote:
> As per ACPI specification r6.4, sec 5.2.12.19, a new sub
> structure – multiprocessor wake-up structure - is added to the
> ACPI Multiple APIC Description Table (MADT) to describe the
> information of the mailbox. If a platform firmware produces the
> multiprocessor wake-up structure, then OS may use this new
> mailbox-based mechanism to wake up the APs.
> 
> Add ACPI MADT wake table parsing support for x86 platform and if
> MADT wake table is present, update apic->wakeup_secondary_cpu with
> new API which uses MADT wake mailbox to wake-up CPU.
> 
> Co-developed-by: Sean Christopherson<sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson<sean.j.christopherson@intel.com>
> Reviewed-by: Andi Kleen<ak@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v6:
>   * Rebased on top of v5.14-rc1.
> 
> Changes since v5:
>   * None ( CCed ACPI list)
> 
> Changes since v4:
>   * Used smp_store_release() in place of WRITE_ONCE().
>   * Addressed some checkpatch warnings.
> 
> Changes since v3:
>   * Removed acpi_mp_wake_mailbox_init() and moved init code to
>     acpi_wakeup_cpu().
>   * Removed redundant NULL pointer check for acpi_mp_wake_mailbox.
>   * Added comments/debug prints as per Rafael's suggestion.
>   * Removed MADT/SVKL ACPI patches from this patchset. It will be
>     merged via ACPICA submission.


Gentle ping! Any comments on this patch?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
