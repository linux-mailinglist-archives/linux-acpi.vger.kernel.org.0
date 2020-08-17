Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFFE2466C8
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Aug 2020 14:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgHQM7e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Aug 2020 08:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgHQM7d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Aug 2020 08:59:33 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20ED207FF
        for <linux-acpi@vger.kernel.org>; Mon, 17 Aug 2020 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597669173;
        bh=m3af21kdIw+HmBFs1JFNkZRJOOiyPfdqCvtgLL9r1Dw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jmcv+lczJSDLenSbWzb2yxMGO+yfzDdV5C+dpCF7iT9Z53v8mWJo2ivZ+cQdEXk2u
         y9IqB/4mLOZAYUXMum+0XjGN3hQl9tU5QbGrw8ho54Um8Wixd9Z9+KytoTLUiZeOru
         0+RazlhiZ2cPgFJSsLcDlw/82RMN75aRWvGkR9io=
Received: by mail-oi1-f178.google.com with SMTP id o21so14657909oie.12
        for <linux-acpi@vger.kernel.org>; Mon, 17 Aug 2020 05:59:32 -0700 (PDT)
X-Gm-Message-State: AOAM533DIo0huRBPxolgaPo2BjW1kJTkKVqWxRx4TGyr9Cz4RTcEn6Ql
        gzwg+6ertJN7SSC1h12eE+CdWzQAmvEDN8v3GC4=
X-Google-Smtp-Source: ABdhPJwVHjWWfg8HGQyCOC/nV/lN+pcw+BS8DZVZqwppvYhQSugaDmefMp0UjmEF/63d4KMCxdI6JjkujHX5Ld1gnNA=
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr9767904oij.174.1597669172213;
 Mon, 17 Aug 2020 05:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200817120431.32233-1-ardb@kernel.org> <20200817124022.GA27387@infradead.org>
In-Reply-To: <20200817124022.GA27387@infradead.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Aug 2020 14:59:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEKorXvBpjkBfcr3+Z-_4hUqX1xPBWR7jhP1S2WDm1Ohg@mail.gmail.com>
Message-ID: <CAMj1kXEKorXvBpjkBfcr3+Z-_4hUqX1xPBWR7jhP1S2WDm1Ohg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: ioremap: avoid redundant rounding to OS page size
To:     Christoph Hellwig <hch@infradead.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 17 Aug 2020 at 14:40, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Aug 17, 2020 at 02:04:31PM +0200, Ard Biesheuvel wrote:
> > The arm64 implementation of acpi_os_ioremap() was recently updated to
> > tighten the checks around which parts of memory are permitted to be
> > mapped by ACPI code, which generally only needs access to memory regions
> > that are statically described by firmware, and any attempts to access
> > memory that is in active use by the OS is generally a bug or a hacking
> > attempt. This tightening is based on the EFI memory map, which describes
> > all memory in the system.
> >
> > The AArch64 architecture permits page sizes of 16k and 64k in addition
> > to the EFI default, which is 4k, which means that the EFI memory map may
> > describe regions that cannot be mapped seamlessly if the OS page size is
> > greater than 4k. This is usually not a problem, given that the EFI spec
> > does not permit memory regions requiring different memory attributes to
> > share a 64k page frame, and so the usual rounding to page size performed
> > by ioremap() is sufficient to deal with this. However, this rounding does
> > complicate our EFI memory map permission check, due to the loss of
> > information that occurs when several small regions share a single 64k
> > page frame (where rounding each of them will result in the same 64k
> > single page region).
> >
> > However, due to the fact that the region check occurs *before* the call
> > to ioremap() where the necessary rounding is performed, we can deal
> > with this issue simply by removing the redundant rounding performed by
> > acpi_os_map_iomem(), as it appears to be the only place where the
> > arguments to a call to acpi_os_ioremap() are rounded up. So omit the
> > rounding in the call, and instead, apply the necessary offset to the
> > result of kmap().
> >
> > Fixes: 1583052d111f ("arm64/acpi: disallow AML memory opregions to access kernel memory")
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> To me the whole acpi_map() / acpi_os_map_iomem() concept looks bogus,
> especially as it mixes up iomem and RAM pages in a really bad way,
> and then throws in staic fixmap-like mappings as well.
>
> Also looking at the callers I see no point in keeping a list of the
> memory mappings.  Does anyone have an idea where this craziness comes
> from?  Which of the callers actually has to deal both with iomem and
> RAM mappings at the same time?
>
> It seems like we should be able to untangle the few callers and remove
> this mess entirely.

That would be my preference as well. However, this code is used by
x86, ia64 and arm64, and I'd like to get this piece in as a fix, given
that the referenced patch was merged in v5.9-rc1, and causes issues on
64k kernels running on older arm64 systems with not-quite-compliant
EFI firmware.
