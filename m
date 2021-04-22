Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1923368779
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Apr 2021 21:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbhDVT4W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 15:56:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55210 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236058AbhDVT4V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Apr 2021 15:56:21 -0400
Received: from zn.tnic (p200300ec2f0e2900329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:2900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A04F51EC030F;
        Thu, 22 Apr 2021 21:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619121344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0Q61lNercIC4ES7Q4Z8ZJik9bzw32TQXhIg0Y6vVvAM=;
        b=rPzjFsUGQg+uTPE8TNluD41oLtLD9jCuqOCwzZ/PNuALfABDDhnGzawHJowE/480UecoKe
        1S6kgcNCU4TATxfNhD07kUU5FmpqIu/XPrvNkKR8isbLLTV1GPyW93/5gxelo1eV0O/m/M
        M7cK7dEt5mEtfyZah4kmb9kNCknxN68=
Date:   Thu, 22 Apr 2021 21:55:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/3] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup
 Mailbox Structure
Message-ID: <20210422195543.GF7021@zn.tnic>
References: <20210422192442.706906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210422192442.706906-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <98a81d5c-251b-bdb1-f5e4-5925de93f0d7@intel.com>
 <8928afc9-ab59-62f3-45b5-a6d26d96d90e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8928afc9-ab59-62f3-45b5-a6d26d96d90e@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 22, 2021 at 12:46:13PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> > This SoB chain doesn't look right.  This is what it would have been if
> > You sent it to Bob who sent it to Erik, who submitted it.
> Internally, its submitted to Bob and Erik for ACPICA merge.
> I think Sign-off is added to track it.

This is not how this works - when Erik/Bob merge it, *then* they add
their SOB. Right now it should have only your SOB.

Documentation/process/submitting-patches.rst, section "Sign your work -
the Developer's Certificate of Origin"

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
