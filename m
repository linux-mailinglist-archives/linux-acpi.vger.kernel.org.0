Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BCE1FC916
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jun 2020 10:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgFQIma (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Jun 2020 04:42:30 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:60767 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgFQIm3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Jun 2020 04:42:29 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id b17dc5b8;
        Wed, 17 Jun 2020 08:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=E3dus0mAltY1TrmmLK9MI4DIxAo=; b=kNHdvK
        3FaQNYPUv5TymrpkWVzfZzVTDe507P8fhJ03uL/03VzTw+Qg21NKlUH9M3N4BOEh
        56nXQ2H2yWz9xb/rWcckNYXaIFR4sO0YGMzUXGDRBbLPU6iSx5AHaT6U4zq20E7J
        qFYTpQZe29DcZcbqDzEvpBK4fASn87ZPn2RWUft/Ls7ykyBjBWSPd1T7myDkuaEJ
        vB4w0fZBSUKUmHFYPcrGSGGqIULaIBlkMkHFTqtM/ieSXF3j/Lmuh117ECYdCaeA
        vZ1bUbzIyml3Ok3KToC58msuB5QP3ZU4E0eAwxEdvIt3O1H0sTZKTULS+9P7d8AW
        mW0L6Q4ZWdnaXvyw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1b7c5c05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 17 Jun 2020 08:24:23 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id 9so1318086ilg.12;
        Wed, 17 Jun 2020 01:42:27 -0700 (PDT)
X-Gm-Message-State: AOAM5306PkNhTu3gBiu5wb/2/UjcMDUC1uja3pUsZNxhblwrTXs6IqOs
        lxUpYGFo0de6+wJYhMFVn8QFjCSmODkX2eL+sKs=
X-Google-Smtp-Source: ABdhPJzTYz/LscR65/jJ5KTsW005C2jHQ0GnnD/0q1WTL5nI6l6/fHsGGDp5lRZC/lYo1q8nIBivZ/dL9+SC3Q1A6mI=
X-Received: by 2002:a92:c852:: with SMTP id b18mr7539915ilq.224.1592383346674;
 Wed, 17 Jun 2020 01:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rmAznrAmEQTOaLeMM82iMFTfCNfpxDGXw4CJjuVEF_gQ@mail.gmail.com>
 <20200615104332.901519-1-Jason@zx2c4.com> <CAHmME9oemScgo2mg8fzqtJCbKJfu-op0WvG5RcpBCS1hHNmpZw@mail.gmail.com>
 <CAMj1kXGWma7T+C5TJ2wYZ22MJr=3FQRqDjF--YuGuzFdAygP-g@mail.gmail.com>
In-Reply-To: <CAMj1kXGWma7T+C5TJ2wYZ22MJr=3FQRqDjF--YuGuzFdAygP-g@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 17 Jun 2020 02:42:15 -0600
X-Gmail-Original-Message-ID: <CAHmME9oJGOH-LwAocAknHFm385Ee_v_itMV4UKj1Sq00SiM4ng@mail.gmail.com>
Message-ID: <CAHmME9oJGOH-LwAocAknHFm385Ee_v_itMV4UKj1Sq00SiM4ng@mail.gmail.com>
Subject: Re: [PATCH] acpi: disallow loading configfs acpi tables when locked down
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 17, 2020 at 2:38 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 17 Jun 2020 at 00:21, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi Rafael, Len,
> >
> > Looks like I should have CC'd you on this patch. This is probably
> > something we should get into 5.8-rc2, so that it can then get put into
> > stable kernels, as some people think this is security sensitive.
> > Bigger picture is this:
> >
> > https://data.zx2c4.com/american-unsigned-language-2.gif
> > https://data.zx2c4.com/american-unsigned-language-2-fedora-5.8.png
> >
> > Also, somebody mentioned to me that Microsoft's ACPI implementation
> > disallows writes to system memory as a security mitigation. I haven't
> > looked at what that actually entails, but I wonder if entirely
> > disabling support for ACPI_ADR_SPACE_SYSTEM_MEMORY would be sensible.
> > I haven't looked at too many DSDTs. Would that break real hardware, or
> > does nobody do that? Alternatively, the range of acceptable addresses
> > for SystemMemory could exclude kernel memory. Would that break
> > anything? Have you heard about Microsoft's mitigation to know more
> > details on what they figured out they could safely restrict without
> > breaking hardware? Either way, food for thought I suppose.
> >
>
> ACPI_ADR_SPACE_SYSTEM_MEMORY may be used for everything that is memory
> mapped, i.e., PCIe ECAM space, GPIO control registers etc.
>
> I agree that using ACPI_ADR_SPACE_SYSTEM_MEMORY for any memory that is
> under the kernel's control is a bad idea, and this should be easy to
> filter out: the SystemMemory address space handler needs the ACPI
> support routines to map the physical addresses used by AML into
> virtual kernel addresses, so all these accesses go through
> acpi_os_ioremap(). So as a first step, it should be reasonable to put
> a lockdown check there, and fail any access to OS owned memory if
> lockdown is enabled, and print a warning if it is not.

Makes sense. Though I was thinking of doing this unconditionally, not
just for lockdown, as a "realer" security mitigation (hence CCing
kernel-hardening), against bugs that manage to mess with acpi things.
A second mitigation might be marking inmemory acpi bytecode pages as
read only.
