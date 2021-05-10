Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4322379900
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 23:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhEJVQn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 17:16:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:45546 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231513AbhEJVQl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 May 2021 17:16:41 -0400
IronPort-SDR: ecENmbDRyXll9+PZnfYA0vsBspDsd4YXYtWsegyLRC9K4T3VcpgVPE1MkEcUQmmwB4XTiKAgFi
 Z8tumezBIeog==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="198967440"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="198967440"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 14:15:33 -0700
IronPort-SDR: 58WND2tgoU/dRxyOi3LBPnEIt1gw3O3ZPDFupLGoKUvC1YHpM0pz7dkmtZ3OAIKRKL03mFCBQb
 KcS663lLOZfA==
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="609240214"
Received: from kcmorris-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.165.53])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 14:15:31 -0700
Subject: Re: [PATCH v3 3/3] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20210426023941.729334-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210426023941.729334-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <97e14cdc-ea98-18b8-0c89-db52440a7716@linux.intel.com>
 <CAJZ5v0gsqyXSr+Kw603333PZ=gnsBizNhyLAcu588OChEHT=AQ@mail.gmail.com>
 <4fa40e7a-bcb2-db0f-8dc5-28728b14377d@linux.intel.com>
 <20210510172237.GU4032392@tassilo.jf.intel.com>
 <CAJZ5v0iFsBWwXhqtLbTMicBSFme0HCvg+2xgtMgpkFMupk_Rkw@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <bc14b461-6431-c5ce-7117-854af8454900@linux.intel.com>
Date:   Mon, 10 May 2021 14:15:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iFsBWwXhqtLbTMicBSFme0HCvg+2xgtMgpkFMupk_Rkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 5/10/21 10:24 AM, Rafael J. Wysocki wrote:
> The wakeup function can return an error when it is called for the
> second time on the same CPU.

To do this, we can only maintain the wakeup status of the CPUs. Can
you check whether following physid_mask based status maintenance is
acceptable?

--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -67,6 +67,7 @@ static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;

  static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
  static u64 acpi_mp_wake_mailbox_paddr;
+static physid_mask_t apic_id_wakemap = PHYSID_MASK_NONE;

  #ifdef CONFIG_X86_IO_APIC
  /*
@@ -347,6 +348,13 @@ static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)

         acpi_mp_wake_mailbox_init();

+       /* Check if the given CPU (apicid) is already awake */
+       if (physid_isset(apicid, apic_id_wakemap)) {
+               pr_err("APIC ID %x is already awake, so failed to wakeup\n",
+                               apicid);
+               return -EINVAL;
+       }
+
         if (!acpi_mp_wake_mailbox)
                 return -EINVAL;

@@ -374,8 +382,18 @@ static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
         while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
                 cpu_relax();

-       /* If timedout, return error */
-       return timeout ? 0 : -EIO;
+       if (timeout) {
+               /*
+                * If the CPU wakeup process is successful, store the
+                * status in apic_id_wakemap to prevent re-wakeup
+                * requests.
+                */
+               physid_set(apicid, apic_id_wakemap);
+               return 0;
+       }
+
+       /* If timed out (timeout == 0), return error */
+       return -EIO;
  }


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
