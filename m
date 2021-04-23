Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2113A3698C2
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 19:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhDWR7Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 13:59:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:3919 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243414AbhDWR7Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Apr 2021 13:59:16 -0400
IronPort-SDR: NBlRA/JQ+kUDWCx3ljh4tEaz7WBu1MP/rB+pnv9hP23KSpax/4krUkAT+WpUKwcNt4NKQHmnPk
 485k6Pk01+rA==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="183588844"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="183588844"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 10:58:37 -0700
IronPort-SDR: 1QueziNWla9gBTeipZoFde/DyjkitLQ9uxKZA9iB9OrcnFPty8Z46XsXyE2klSgpO773fMBbuF
 Vrt0+mWp4owA==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="456307503"
Received: from aberdasc-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.2.101])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 10:58:36 -0700
Subject: Re: [PATCH v2 3/3] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210422214708.716164-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJZ5v0iv0r3x0rDiB6+M+CZcAPcFK8i6R1n=v1NPcNg16invTQ@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <789781a4-026b-f023-6192-5a0099fd88fd@linux.intel.com>
Date:   Fri, 23 Apr 2021 10:58:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iv0r3x0rDiB6+M+CZcAPcFK8i6R1n=v1NPcNg16invTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/23/21 6:05 AM, Rafael J. Wysocki wrote:
> Although I've looked at this patch already, I now realize that
> according to the spec the mailbox is only suitable for the first AP
> wakeup during system initialization.
> 
> Shouldn't the original handler be restored then to handle subsequent wakeups?

For TDX use case, since it does not support CPU hotplug/offline features, once
the AP is turned on, it will never be off-lined and hence need not support
subsequent wakeups.

AFAIK, this MADT wake table is mainly defined for TDX use case.

Please also check the TDX GHCI spec, sec 4.1.

For each TD-guest, application processor, the mailbox can be used once for the
wakeup command. After the guest-application processor takes the action according
to the command, the intention is the mailbox will no longer be checked by the
guest-application processor. Other guest processors can continue using the mailbox
for the next command.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
