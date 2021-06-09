Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44913A082F
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 02:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhFIAQa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 20:16:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:4175 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhFIAQ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Jun 2021 20:16:29 -0400
IronPort-SDR: MvBEZm//Z8J3D+pjoZykagE0btMljcoZO9zTaYzy7trcT4fpbzLjWiSzKfb1rRtk1dsck3+jqp
 PyFdKpRzAaNA==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="266124572"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="266124572"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 17:14:30 -0700
IronPort-SDR: 2xWcijKOdpvoNS8cRIbYCXIYenvA7GZHR02vLpXTl6lr7suL2urtNT6I0RqbTCnhMNGeAJNkbk
 xiEYJY3dlkBQ==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="402254387"
Received: from dabarred-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.185.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 17:14:29 -0700
Subject: Re: [RFC v2-fix-v3 1/1] x86/tdx: Skip WBINVD instruction for TDX
 guest
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
References: <CAPcyv4jQ=Fcga3jyUzthjPW9O962vhy3L5XUM6jqR5Z_Zq83LQ@mail.gmail.com>
 <20210608213527.739474-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4hoxc2+50EOFuq8NOa_CBFKX_A549Vw4U24V5SG25ftxQ@mail.gmail.com>
 <9d88cb37-f594-534a-ae2a-5a51f97db2a8@intel.com>
 <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <bdc8b13a-24b9-7383-6725-f3ecfff9e2b1@linux.intel.com>
Date:   Tue, 8 Jun 2021 17:14:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 6/8/21 5:07 PM, Dan Williams wrote:
> That works too, but I assume if ACPI_FLUSH_CPU_CACHE() itself is going
> to be changed rather than sprinkling protected_guest_has() checks in a
> few places it will need to assert why changing all of those at once is
> correct. Otherwise I expect Rafael to ask why this global change of
> the ACPI_FLUSH_CPU_CACHE() policy is ok.

Yes. I am fixing it as below.

--- a/arch/x86/include/asm/acenv.h
+++ b/arch/x86/include/asm/acenv.h
@@ -10,10 +10,15 @@
  #define _ASM_X86_ACENV_H

  #include <asm/special_insns.h>
+#include <asm/protected_guest.h>

  /* Asm macros */

-#define ACPI_FLUSH_CPU_CACHE() wbinvd()
+#define ACPI_FLUSH_CPU_CACHE()                         \
+do {                                                   \
+       if (!prot_guest_has(PR_GUEST_DISABLE_WBINVD))   \
+               wbinvd();                               \
+} while (0)


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
