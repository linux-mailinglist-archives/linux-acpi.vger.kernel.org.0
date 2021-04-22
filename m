Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FE43688CD
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 00:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhDVWBs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 18:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbhDVWBr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Apr 2021 18:01:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4C9C06174A;
        Thu, 22 Apr 2021 15:01:12 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e2900329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:2900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 998F01EC01B7;
        Fri, 23 Apr 2021 00:01:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619128870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VlMJC2oW43XTzBbn/2xdGJb49tZeNUkt/0aJRgOvtws=;
        b=mJyz85i8jpAEkl9MumkGeq9Mov31I21JaneA3Q7XRXUyEbSfGSh/ru9vvinoPW2C5U26lx
        TLDJrHHMe8VVJ3rrYIAlvlMlaEEgNaA4dG5DYdWfs5UluO7mS7IzUSga4r27y0iRZ1gxFz
        K/oi6/oy2loRpWa3yVghxgKsbryZkJA=
Date:   Fri, 23 Apr 2021 00:01:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
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
Subject: Re: [PATCH v2 0/3] Add multiprocessor wake-up support
Message-ID: <20210422220113.GG7021@zn.tnic>
References: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 22, 2021 at 02:47:05PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Add multiprocessor wakeup support using MADT ACPI table for x86
> platforms. It uses mailbox based mechanism to wake up the APs. You
> can get more details about the ACPI table and mailbox protocol in
> Guest-Host-Communication Interface (GHCI) for Intel Trust Domain
> Extensions (Intel TDX) specification document (sec 4.1)
> 
> https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface.pdf
> 
> Changes since v1:
>  * Removed signoff from Rob and Erik.

For the future: please do not resend your patchset immediately but give
reviewers time to have a look at it.

Your current patchset comprises of only 3 patches - now imagine if it
were, 15, or 20 or more? Now also imagine if you were not the only one
submitter who would resend immediately... you'd soon have maintainers
drowning in email - not that they don't do so already anyway.

While waiting, you could read

Documentation/process/submitting-patches.rst

for example.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
