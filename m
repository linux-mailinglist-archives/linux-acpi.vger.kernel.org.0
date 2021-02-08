Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F91313F7C
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Feb 2021 20:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhBHTsU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Feb 2021 14:48:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236461AbhBHTrr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Feb 2021 14:47:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 779DB64E92;
        Mon,  8 Feb 2021 19:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612813626;
        bh=U/+E51uWrkFUj4ZO78qAQAKtSNN24kWemmORiGVhfW4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qV/jNlyhVKK6iYV9y31vsr+WPOz0Agt7SyDvuJY5Lajbb9+fc8g0waKmgoewfBpBy
         ahqwfBBN4jD8fwlfMchsSgzuhDCi5JNzXJFgPf5iSJ4BkZRX6nxpeCRAp+/CBMubyr
         Y2Xvi40KH1EQLM6m4I0bKODt98gOrMRrSFXMWNsslCsFAZw/PhBFscl1VjIBpArYl/
         Fcg4kcF+AZu0gUuCJBIlkt8R9d41G34wVDv3ThdlJtzeZqy5h8jEaIg3SrgzCTF+Aq
         t+VQCWa/xSYAMhu0tlPoW24yG2FXBO6WupP8BONUgHHxMXWsQXoMLB0kxp2ZYPVlwk
         xJf4nRB6Mfadw==
Received: by mail-ot1-f46.google.com with SMTP id s107so15284064otb.8;
        Mon, 08 Feb 2021 11:47:06 -0800 (PST)
X-Gm-Message-State: AOAM531Tyl11Gs4G3VHiSsiQHLph0cX/nVS8fmBc+mcCOibCxpq52HYA
        MYWH8vtRFPPOxKVwcURHj3T+A1zFbQTFXwOo0Aw=
X-Google-Smtp-Source: ABdhPJy7CzVwHkBKTAlTGkY1DioKrLrRbAAsTdYM5P2LV1rXIxb8ALdSnjvdCHKkC2PjVWgKLTHu734Hp1o7ZZUNe/E=
X-Received: by 2002:a05:6830:1285:: with SMTP id z5mr4473212otp.90.1612813625708;
 Mon, 08 Feb 2021 11:47:05 -0800 (PST)
MIME-Version: 1.0
References: <20210206084937.20853-1-ardb@kernel.org> <20210206104854.GC27503@dragon>
 <CAJZ5v0hMJnaHhUYib9d3yQ1CMHLE+Hu3UM4VoN=dOiyriTPmOw@mail.gmail.com>
 <MWHPR11MB1599534717CB4A1447A8DE7CF08F9@MWHPR11MB1599.namprd11.prod.outlook.com>
 <CAMj1kXGwedPfS0xBJn9XXoLVVH44eNmKykf7LdGOgOJ4qPqQiw@mail.gmail.com> <MWHPR11MB15993FCF4B43A8B7B877265EF08F9@MWHPR11MB1599.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB15993FCF4B43A8B7B877265EF08F9@MWHPR11MB1599.namprd11.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 8 Feb 2021 20:46:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFNeRkmA-JuQ8HmDz00tpsyxZ1z=5H+27J8jpa2Cu_43A@mail.gmail.com>
Message-ID: <CAMj1kXFNeRkmA-JuQ8HmDz00tpsyxZ1z=5H+27J8jpa2Cu_43A@mail.gmail.com>
Subject: Re: [PATCH] Revert "ACPICA: Interpreter: fix memory leak by using
 existing buffer"
To:     "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 8 Feb 2021 at 20:30, Kaneda, Erik <erik.kaneda@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Ard Biesheuvel <ardb@kernel.org>
> > Sent: Monday, February 8, 2021 11:14 AM
> > To: Kaneda, Erik <erik.kaneda@intel.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>; Shawn Guo
> > <shawn.guo@linaro.org>; Linux ARM <linux-arm-
> > kernel@lists.infradead.org>; ACPI Devel Maling List <linux-
> > acpi@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE
> > (ACPICA) <devel@acpica.org>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>; Moore,
> > Robert <robert.moore@intel.com>
> > Subject: Re: [PATCH] Revert "ACPICA: Interpreter: fix memory leak by using
> > existing buffer"
> >
> > On Mon, 8 Feb 2021 at 20:07, Kaneda, Erik <erik.kaneda@intel.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > > Sent: Monday, February 8, 2021 5:01 AM
> > > > To: Shawn Guo <shawn.guo@linaro.org>; Ard Biesheuvel
> > > > <ardb@kernel.org>; Kaneda, Erik <erik.kaneda@intel.com>
> > > > Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling
> > > > List <linux-acpi@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > > > kernel@vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE
> > > > (ACPICA) <devel@acpica.org>; Wysocki, Rafael J
> > > > <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>; Moore,
> > > > Robert <robert.moore@intel.com>
> > > > Subject: Re: [PATCH] Revert "ACPICA: Interpreter: fix memory leak by
> > using
> > > > existing buffer"
> > > >
> > > > On Sat, Feb 6, 2021 at 11:49 AM Shawn Guo <shawn.guo@linaro.org>
> > wrote:
> > > > >
> > > > > On Sat, Feb 06, 2021 at 09:49:37AM +0100, Ard Biesheuvel wrote:
> > > > > > This reverts commit 32cf1a12cad43358e47dac8014379c2f33dfbed4.
> > > > > >
> > >
> > > Hi Bob, Ard and Rafael,
> > >
> > > > > > The 'exisitng buffer' in this case is the firmware provided table, and
> > > > > > we should not modify that in place. This fixes a crash on arm64 with
> > > > > > initrd table overrides, in which case the DSDT is not mapped with
> > > > > > read/write permissions.
> > >
> > > Since this code runs on basically every _HID and _CID invocation, I would
> > have expected this kind of revert to come in for kernels that do not use initrd
> > override... So it sounds like there is a difference between how pages are
> > mapped for initrd table overrides and tables exposed through the XSDT for
> > ARM.. I think it would be easier for us to make these fixes in the future if we
> > could all come to a consensus on whether if we should assume that these
> > pages are writable or not.
> > >
> > > Should we assume that all ACPI tables are non-writable and read only
> > regardless of initrd override and architecture?
> > >
> >
> > ACPI tables are measured into the TPM on measured boot systems, and
> > checksummed, so I don't think we should ever modify them in place.
>
> I'm not knowledgeable on TPM but I'm curious - what happens when the TPM detects that these ACPI tables are modified?
>

That depends on the policy implemented in user space. The TPM itself
does not detect this change, but these ACPI tables will no longer
match their SHA hashes in the TPM event log, and this is something we
should really avoid.

> >
> > But if we need code like this, it should be conditional at the very
> > least, i.e., it should only rewrite _HIDs and _CIDs if they are
> > incorrect to begin with.
>
> I agree that this would be a more efficient approach
>

Indeed.
