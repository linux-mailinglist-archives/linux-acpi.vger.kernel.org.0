Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4005F379514
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 19:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhEJRLf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 13:11:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:31005 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232257AbhEJRLe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 May 2021 13:11:34 -0400
IronPort-SDR: hwnvxmIjXvMcycRLP/vUibeRrQ7ZfHhpigzQvdU8DEBKnsxyP/64vSK59whlQ7qAs1VU5ZWu3J
 AkvWel+ySOUQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199293560"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="199293560"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 10:10:29 -0700
IronPort-SDR: MpzzGUG81YEdtnulXS6mm5YxyVMl3ny2tOSrfCyNZe8SoV+AYDtSsxrIvuLO6c5oF6WSPUUJB4
 epuDP1jMX2Rg==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="391989907"
Received: from kmlaurix-mobl3.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.3.156])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 10:10:27 -0700
Subject: Re: [PATCH v3 3/3] x86/acpi, x86/boot: Add multiprocessor wake-up
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
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20210426023941.729334-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210426023941.729334-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <97e14cdc-ea98-18b8-0c89-db52440a7716@linux.intel.com>
 <CAJZ5v0gsqyXSr+Kw603333PZ=gnsBizNhyLAcu588OChEHT=AQ@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4fa40e7a-bcb2-db0f-8dc5-28728b14377d@linux.intel.com>
Date:   Mon, 10 May 2021 10:10:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gsqyXSr+Kw603333PZ=gnsBizNhyLAcu588OChEHT=AQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 5/10/21 9:55 AM, Rafael J. Wysocki wrote:
> I'm not sure how my comment regarding the fact that for a given CPU
> this function is only usable once has been addressed.
> 
> While it may not be a practical concern in the use case that you are
> after (TDX), this is a generic mechanism and it needs to cover other
> possible usage scenarios.

For the same CPU, if we try to use mailbox again, firmware will not
respond to it. So the command will timeout and return error.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
