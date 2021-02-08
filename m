Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0872313EA4
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Feb 2021 20:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhBHTPd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Feb 2021 14:15:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233264AbhBHTOt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Feb 2021 14:14:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E96C264E85;
        Mon,  8 Feb 2021 19:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612811647;
        bh=3Sei4KZaQlN8EaRCqEQMXisB257JKwJryVwgk/STYDk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WNAS3BdoCkEttS26MrYDbXFy3SvlCHWPM3VfUA1EdBbc0MeCMtU4i0QdgJDytzKIe
         sdjM6G337PjWO+LFk+sOq8YJaQjrjY6FailaNzYjw76iDDWd6fN1tYsjFJTIdsIJ3K
         5FCpzInLBPcvlMhfebIadkGRV+KIIIgJenZLfcCBlrTT78XolCcKblTkipvqX+CPxT
         6B/ivpZXuzhO0IaNwhR/JBzDP71AdPE/QTl5sp7sRDsKuvItMqsghatcvjyvx+aR2N
         Z7zZtjvrTPteLurZhWDvpGGHtVfYMxHY0Ebl+O77DNG/8CY9IPB3TGXyZ0HFt4IW1Z
         KCvTLA3pP6DYA==
Received: by mail-oo1-f41.google.com with SMTP id x23so3705486oop.1;
        Mon, 08 Feb 2021 11:14:06 -0800 (PST)
X-Gm-Message-State: AOAM531fUqnstvwBF45d+yXDxvUVW7AkV1anVS1WJan2PZyqFVbWYzwm
        Ve+pH+nMsnztjxcRo8i0B8PgsaBUck1WYBWhYNU=
X-Google-Smtp-Source: ABdhPJw3XTzqxW3OFTHMSzJd7y1Ol2wtSnt7gTxERVrhr4y3BkXeUt+/ciIM58QJEmyfK0xdBlHnZvpXJJcri/SiTe4=
X-Received: by 2002:a4a:e1e4:: with SMTP id u4mr13654774ood.41.1612811646204;
 Mon, 08 Feb 2021 11:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20210206084937.20853-1-ardb@kernel.org> <20210206104854.GC27503@dragon>
 <CAJZ5v0hMJnaHhUYib9d3yQ1CMHLE+Hu3UM4VoN=dOiyriTPmOw@mail.gmail.com> <MWHPR11MB1599534717CB4A1447A8DE7CF08F9@MWHPR11MB1599.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1599534717CB4A1447A8DE7CF08F9@MWHPR11MB1599.namprd11.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 8 Feb 2021 20:13:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGwedPfS0xBJn9XXoLVVH44eNmKykf7LdGOgOJ4qPqQiw@mail.gmail.com>
Message-ID: <CAMj1kXGwedPfS0xBJn9XXoLVVH44eNmKykf7LdGOgOJ4qPqQiw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 8 Feb 2021 at 20:07, Kaneda, Erik <erik.kaneda@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Monday, February 8, 2021 5:01 AM
> > To: Shawn Guo <shawn.guo@linaro.org>; Ard Biesheuvel
> > <ardb@kernel.org>; Kaneda, Erik <erik.kaneda@intel.com>
> > Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling
> > List <linux-acpi@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE
> > (ACPICA) <devel@acpica.org>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>; Moore,
> > Robert <robert.moore@intel.com>
> > Subject: Re: [PATCH] Revert "ACPICA: Interpreter: fix memory leak by us=
ing
> > existing buffer"
> >
> > On Sat, Feb 6, 2021 at 11:49 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > >
> > > On Sat, Feb 06, 2021 at 09:49:37AM +0100, Ard Biesheuvel wrote:
> > > > This reverts commit 32cf1a12cad43358e47dac8014379c2f33dfbed4.
> > > >
>
> Hi Bob, Ard and Rafael,
>
> > > > The 'exisitng buffer' in this case is the firmware provided table, =
and
> > > > we should not modify that in place. This fixes a crash on arm64 wit=
h
> > > > initrd table overrides, in which case the DSDT is not mapped with
> > > > read/write permissions.
>
> Since this code runs on basically every _HID and _CID invocation, I would=
 have expected this kind of revert to come in for kernels that do not use i=
nitrd override... So it sounds like there is a difference between how pages=
 are mapped for initrd table overrides and tables exposed through the XSDT =
for ARM.. I think it would be easier for us to make these fixes in the futu=
re if we could all come to a consensus on whether if we should assume that =
these pages are writable or not.
>
> Should we assume that all ACPI tables are non-writable and read only rega=
rdless of initrd override and architecture?
>

ACPI tables are measured into the TPM on measured boot systems, and
checksummed, so I don't think we should ever modify them in place.

But if we need code like this, it should be conditional at the very
least, i.e., it should only rewrite _HIDs and _CIDs if they are
incorrect to begin with.
