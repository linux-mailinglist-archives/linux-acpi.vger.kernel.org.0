Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0710B1FC8FC
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jun 2020 10:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgFQIiF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Jun 2020 04:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgFQIiE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Jun 2020 04:38:04 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06C0B212CC;
        Wed, 17 Jun 2020 08:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592383084;
        bh=eWxs3nB/7UcJdvfwSzWTNvyv1bWD2Dy3QiER8xtR+Qo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E5Pk/q21L4XYpxwsPRqpQvJFKWBqQfH+fQbSfBBfdgjkN2G2l+qH5bfVBVKN5b3zV
         RFdwLJkO66yeNRhrwzK/X/NwGgJyf3k8yhT4nSlZ3UZxgXSzrNJp4JfGoIRc/dfHaw
         S+/yBwBXAg3GryE113CQ8pbAaumSZ7nQ0HV4/VCM=
Received: by mail-ot1-f54.google.com with SMTP id m2so962168otr.12;
        Wed, 17 Jun 2020 01:38:03 -0700 (PDT)
X-Gm-Message-State: AOAM533k56lQ6d9JJ9xFX0FtFrZFn+G22QNlDOv8HZSYz2YeO3Tm3+i6
        J/Xb5NRJ0IfTTyP03jIz9L3A9GAUG0+ylbuPgzs=
X-Google-Smtp-Source: ABdhPJznxjKPV69wdlQPGPVd/LwNYP59TKkGepzbjZIAhXvJ+C+a7wEcmwlw4MwfiLqy0B/zTH9gnBN96UqNEJURyu8=
X-Received: by 2002:a9d:476:: with SMTP id 109mr6237581otc.77.1592383083393;
 Wed, 17 Jun 2020 01:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rmAznrAmEQTOaLeMM82iMFTfCNfpxDGXw4CJjuVEF_gQ@mail.gmail.com>
 <20200615104332.901519-1-Jason@zx2c4.com> <CAHmME9oemScgo2mg8fzqtJCbKJfu-op0WvG5RcpBCS1hHNmpZw@mail.gmail.com>
In-Reply-To: <CAHmME9oemScgo2mg8fzqtJCbKJfu-op0WvG5RcpBCS1hHNmpZw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 Jun 2020 10:37:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGWma7T+C5TJ2wYZ22MJr=3FQRqDjF--YuGuzFdAygP-g@mail.gmail.com>
Message-ID: <CAMj1kXGWma7T+C5TJ2wYZ22MJr=3FQRqDjF--YuGuzFdAygP-g@mail.gmail.com>
Subject: Re: [PATCH] acpi: disallow loading configfs acpi tables when locked down
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
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

On Wed, 17 Jun 2020 at 00:21, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Rafael, Len,
>
> Looks like I should have CC'd you on this patch. This is probably
> something we should get into 5.8-rc2, so that it can then get put into
> stable kernels, as some people think this is security sensitive.
> Bigger picture is this:
>
> https://data.zx2c4.com/american-unsigned-language-2.gif
> https://data.zx2c4.com/american-unsigned-language-2-fedora-5.8.png
>
> Also, somebody mentioned to me that Microsoft's ACPI implementation
> disallows writes to system memory as a security mitigation. I haven't
> looked at what that actually entails, but I wonder if entirely
> disabling support for ACPI_ADR_SPACE_SYSTEM_MEMORY would be sensible.
> I haven't looked at too many DSDTs. Would that break real hardware, or
> does nobody do that? Alternatively, the range of acceptable addresses
> for SystemMemory could exclude kernel memory. Would that break
> anything? Have you heard about Microsoft's mitigation to know more
> details on what they figured out they could safely restrict without
> breaking hardware? Either way, food for thought I suppose.
>

ACPI_ADR_SPACE_SYSTEM_MEMORY may be used for everything that is memory
mapped, i.e., PCIe ECAM space, GPIO control registers etc.

I agree that using ACPI_ADR_SPACE_SYSTEM_MEMORY for any memory that is
under the kernel's control is a bad idea, and this should be easy to
filter out: the SystemMemory address space handler needs the ACPI
support routines to map the physical addresses used by AML into
virtual kernel addresses, so all these accesses go through
acpi_os_ioremap(). So as a first step, it should be reasonable to put
a lockdown check there, and fail any access to OS owned memory if
lockdown is enabled, and print a warning if it is not.
