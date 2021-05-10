Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A78037954C
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 19:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhEJRXq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 13:23:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:29432 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231381AbhEJRXo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 May 2021 13:23:44 -0400
IronPort-SDR: cTZIc3Dy8vCfZOSHClJhgvQEwgslemH6yffgZXYF+jtqB4+lIz5287ItzpN9zonT9XpK3oKOfL
 2REb5A88CPXQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186380052"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="186380052"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 10:22:38 -0700
IronPort-SDR: yeBh7/THipK27vGT9BNdOezKYbGpTBar79hWpMunY4quKozgF+1gaCutIBcxq2EY/oBWAm8oku
 W9DaNfmASv+g==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="536492536"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 10:22:38 -0700
Date:   Mon, 10 May 2021 10:22:37 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
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
Subject: Re: [PATCH v3 3/3] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
Message-ID: <20210510172237.GU4032392@tassilo.jf.intel.com>
References: <20210426023941.729334-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210426023941.729334-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <97e14cdc-ea98-18b8-0c89-db52440a7716@linux.intel.com>
 <CAJZ5v0gsqyXSr+Kw603333PZ=gnsBizNhyLAcu588OChEHT=AQ@mail.gmail.com>
 <4fa40e7a-bcb2-db0f-8dc5-28728b14377d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fa40e7a-bcb2-db0f-8dc5-28728b14377d@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 10, 2021 at 10:10:24AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 5/10/21 9:55 AM, Rafael J. Wysocki wrote:
> > I'm not sure how my comment regarding the fact that for a given CPU
> > this function is only usable once has been addressed.
> > 
> > While it may not be a practical concern in the use case that you are
> > after (TDX), this is a generic mechanism and it needs to cover other
> > possible usage scenarios.
> 
> For the same CPU, if we try to use mailbox again, firmware will not
> respond to it. So the command will timeout and return error.

Right because the firmware code doesn't run anymore.

The only possibility would be for Linux to put back some code that spins
and waits again, but that would be quite pointless and wasteful.

-Andi
