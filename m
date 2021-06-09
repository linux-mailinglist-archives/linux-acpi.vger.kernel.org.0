Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015713A1DE1
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 21:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhFIT7b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 15:59:31 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:43846 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFIT7b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 15:59:31 -0400
Received: by mail-pf1-f172.google.com with SMTP id m7so6426442pfa.10
        for <linux-acpi@vger.kernel.org>; Wed, 09 Jun 2021 12:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ed3c0CY6+ZiTf8IgpI3kXf3HcsCngM7z14+9/Ftg5SE=;
        b=iAnBkfqu6IpZOHIQ9qwPj68RXJTgOIX/Pny9DDjzHNjHvSjw7+a5U/YiDcyskXJ5cV
         MYvniHJ4OxJQ6VBZOLHnhlKb9pRLoaP6jO1VT+Uwn0xhuYYh3WaN1gtVKAh37kzqxXml
         JLIRC/M4xWWeLXLfxEfnwV/7v+JkZXaro+2c5EI2smEroaRC2JEhYzzMAE//A5hKI8l6
         /NGIGe83+SXoEiWUVmRLZlwpqgT14Q9aUw1ho737/uZA2BWQ971gd0p1wM2CuBVtJFSQ
         ldaQt8UMlBRfHm73apH+Y30XBsf54t9J1HVRCNoIkUCSpr7XqyezcGzzlEmZhzZ+b4Rh
         YQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ed3c0CY6+ZiTf8IgpI3kXf3HcsCngM7z14+9/Ftg5SE=;
        b=twI1vmn+5n2x0K44iWM4mnbhSQxTXaNa4X/AOgTpOyJMxkthQfUIftZ5ZiEHMB7X7H
         V0zntipCAV57x+/ZdLfzDD1WmpUNkAKJY/VBqmNXgSI8b5c9hInK7HYEMMkyBvGlQwLt
         UeXUsPNUvPUiERXQ3RHeRXupwpChNsrKq6B+9+68MY+KbksgYkyMkfTT1M2lVfNMBNIu
         /HUwpRbpddFjHvMKrl13N88M2h3NwE3pJCb8LGqBqS582yOrrZsppXlqMAAAOfoXKefO
         lnpm+LlY/KwsmRV9VfKk0MA+7AWkPdXw/RkWDTk6sd1OsKtt8VQWLB+ae7LGzm1hqbVy
         LDSw==
X-Gm-Message-State: AOAM530fxLLYXx5WhqP/hP55evdFtVNY/83vvwQ68gs6Yv86DSd+7Pf+
        rookkEMZw0/lMJHJGloyKuiWrVH9n3ugw7cli8KWNA==
X-Google-Smtp-Source: ABdhPJxDJ/e/nzDP4k49vLkESWIf4iyvke2cp/k6UU8JGvGgWmYdgvNJPiY51jIJT4i+Rr9VpLd2zSJ87fKD4mXGN8E=
X-Received: by 2002:aa7:952b:0:b029:2e9:eef1:8e17 with SMTP id
 c11-20020aa7952b0000b02902e9eef18e17mr1408582pfp.70.1623268596069; Wed, 09
 Jun 2021 12:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <973add45-9fd2-7abc-3a97-96a26c263ea0@linux.intel.com> <20210609194926.1949859-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210609194926.1949859-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Jun 2021 12:56:25 -0700
Message-ID: <CAPcyv4gQiSLdyXiBB+3zz7=eOX1C0Uuo47846sb675hSZ0GHiQ@mail.gmail.com>
Subject: Re: [RFC v2-fix-v5 1/1] x86: Skip WBINVD instruction for VM guest
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[ add back linux-acpi and Rafael ]


On Wed, Jun 9, 2021 at 12:49 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> VM guests that supports ACPI, use standard ACPI mechanisms to
> signal sleep state entry (including reboot) to the host. The
> ACPI specification mandates WBINVD on any sleep state entry
> with the expectation that the platform is only responsible for
> maintaining the state of memory over sleep states, not
> preserving dirty data in any CPU caches. ACPI cache flushing
> requirements pre-date the advent of virtualization. Given guest
> sleep state entry does not affect any host power rails it is not
> required to flush caches. The host is responsible for maintaining
> cache state over its own bare metal sleep state transitions that
> power-off the cache. A TDX guest, unlike a typical guest, will
> machine check if the CPU cache is powered off.

Looks like you are wrapping at column 62 than 72, double check that
for the final submission of this series. Other than that this looks
good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
