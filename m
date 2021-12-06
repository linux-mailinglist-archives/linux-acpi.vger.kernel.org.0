Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2286946A379
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Dec 2021 18:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344731AbhLFRyr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Dec 2021 12:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbhLFRyr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Dec 2021 12:54:47 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ACBC0613F8
        for <linux-acpi@vger.kernel.org>; Mon,  6 Dec 2021 09:51:18 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g18so10869967pfk.5
        for <linux-acpi@vger.kernel.org>; Mon, 06 Dec 2021 09:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ESPc86/WR8zjQO6sLQzuGtCJWQp0GHtvc/0bwINti8=;
        b=mEM23FJPPrJVfglUbFra6ClSwRonXW32XC/+wLGHpPDWAkmW/LDcwdzmrWez8wzm3G
         6ATc9q2mngUTLLKpHZMh3ucS60Ih3vinZuo01DGvD6T4lp52V+llHU6AbL00S7fl40yb
         Z20Bm2OdU4qocuGZ3CH1yEK0gbodUlNEE+qOFQ92Mtv78eGEguGPXrc+9cslWdk80C2S
         212+rk+y66B8WqR/dH2IDQcb3Z+01jCxkRGQ9ZJsWnppyWAsFfk6qLyPanO458YJbxbn
         hXdLcBOhFjYyRQD6uIuJ9ewh4rSht7lk6AguHfFzSMYHgSitep+herROVghcOmJg70E/
         LI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ESPc86/WR8zjQO6sLQzuGtCJWQp0GHtvc/0bwINti8=;
        b=A8ru0EVg2ZhobQV/3Bb7DeIfXdKLXgNLCNtj0O2t5tdDyNR16hIiG4APG7lyO9I/n2
         ZM7DNljTL/UnnJSHyfF/7zt0F41f8xJvu4ELQDlO1pAr8mBV5hKO5Z3lVZDIuo7FCxqa
         wrz+c8pbfeDBvd+eVfh6UAjFW0R/2iJDgk7DRUVqY6hWt8UchC1SmZAMLpkF2a3mYOuV
         1cy8IcTyRsEt8uEmqZRc/Jv/gw48C3K5nDxzHsn29ceXXtZL7RJUNg8Nw0K2CVXH/S4g
         uE1aCVy6WFsMoIElFX7Uyv923Oj0kfO+httBzqEKtcImt5BHLoIuLsuwaQ18bVlTc50G
         +h/A==
X-Gm-Message-State: AOAM533LhkWNldbeRx+2vymb+Q8MoKDlgScZ44XA0zPqzR8Ft7xLJTAM
        +D2sbHGCZwTiao4aGt7JfEwczz8LLFPcnKrUMZ2Lng==
X-Google-Smtp-Source: ABdhPJypgCH8IfPe2R8TbHORE195DoPYN1vP/sOAAUnmOfh4uWrncbqrxnflmO2jZEe1R5GUySlwHpsMHR9I5pnaZAk=
X-Received: by 2002:a62:7ec4:0:b0:4a3:219b:7008 with SMTP id
 z187-20020a627ec4000000b004a3219b7008mr38300104pfc.3.1638813077797; Mon, 06
 Dec 2021 09:51:17 -0800 (PST)
MIME-Version: 1.0
References: <YZPbQVwWOJCrAH78@zn.tnic> <20211119040330.4013045-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87pmqpjcef.ffs@tglx> <20211202222109.pcsgm2jska3obvmx@black.fi.intel.com>
 <87lf126010.ffs@tglx> <20211203234915.jw6kdd2qnfrionch@black.fi.intel.com>
 <2519e6b6-4f74-e2f8-c428-0fceb0e16472@intel.com> <20211204005427.ccinxlwwab3jsuct@black.fi.intel.com>
 <5bc40889-445d-5cac-3396-d39d53ee92c7@intel.com> <CAPcyv4gHK=-gxxYexV8jtycPGE15yDWe7jYutbcqKc-1Zhmx8Q@mail.gmail.com>
 <e84556f2-a724-5f90-d950-b4e017eee989@intel.com>
In-Reply-To: <e84556f2-a724-5f90-d950-b4e017eee989@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 6 Dec 2021 09:51:07 -0800
Message-ID: <CAPcyv4gMaXeubx9pD18yKCZJHs60ULcMFrgsOhjBV+VFZgDy_Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Skip WBINVD instruction for VM guest
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 6, 2021 at 8:54 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 12/6/21 8:39 AM, Dan Williams wrote:
> >> But, the trick is that we need a contract.  A contract requires a
> >> "meeting of the minds" first.
> > The WBINVD requirement in sleep states is about getting cache contents
> > out to to power preserved domain before the CPU turns off. The bare
> > metal host handles that requirement. The conversation that needs to be
> > had is with the ACPI specification committee to clarify that virtual
> > machines have no responsibility to flush caches. We can do that as a
> > Code First proposal to the ACPI Specification Working Group.
>
> Sounds sane to me.  So, we effectively go to the ACPI folks and say that
> Linux isn't going to do WBINVD in virtualized environments any more.
> That was effectively the approach that the first patch in this thread did:
>
> > https://lore.kernel.org/all/20211116005027.2929297-1-sathyanarayanan.kuppuswamy@linux.intel.com/
>
> Right?

Correct, my reviewed-by was based on that observation, and now we can
close the loop by proposing the specification change.
