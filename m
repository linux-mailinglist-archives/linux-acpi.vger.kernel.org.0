Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2343E8EDB
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Aug 2021 12:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbhHKKlE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Aug 2021 06:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:32938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237020AbhHKKlD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Aug 2021 06:41:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7510E60FC3;
        Wed, 11 Aug 2021 10:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628678440;
        bh=MWYsgBQRSHA52IzMe7OkpIpL0S/lsPWSSoypLj4ev5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rr1TiTfXf7kLOQpQAnQMdTKvb6FpJYfiHlPfyzDC4BKNBKnfDcpZ9OG+/ZJp9vnbr
         wmd1JllIpx58JrGj8ML5wvwuqRavxJYmGploaSGWxXf1IMRymCIWH10rXuxE9LNP/O
         S2EC8BP3gDFFvXb0lVvxILCj5uZtsb6D9yoJv1/DIGty6+XC9NZzzYrMQwDTJU9nk5
         +mcCaIHWLxitlQEl4VoDnTRI5G4f3os+LI/Z7+P0B4opUuY0f04Wdtl8hZjq8uxcpZ
         WIRJPnQ9iBo7qQjrkPz471mys1stPbA/eX8LkxC112c6GbNaG+EsMoK0MUuizBy2ZF
         muzSJ66j45toQ==
Received: by mail-ot1-f42.google.com with SMTP id r19-20020a0568301353b029050aa53c3801so2804125otq.2;
        Wed, 11 Aug 2021 03:40:40 -0700 (PDT)
X-Gm-Message-State: AOAM530gMrw8T/fpWJt+4PH5OMA01axVn5cSFwdiv12dK3JdKxj0L5H0
        vXzboY32cMAKKRW3ocvN5akTISaxCSgC5wultWQ=
X-Google-Smtp-Source: ABdhPJzPyKV7zx62nUBCZ2Es0zascWHwk+SGVynlTVLACq+nWngWkUsz8u230ZGhfNyEloS44T/aLWgev5adH1SFKcI=
X-Received: by 2002:a9d:5cc7:: with SMTP id r7mr8041809oti.108.1628678439823;
 Wed, 11 Aug 2021 03:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
 <20210802152359.12623-2-lorenzo.pieralisi@arm.com> <YRKtEDycefrZLB3X@infradead.org>
In-Reply-To: <YRKtEDycefrZLB3X@infradead.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 11 Aug 2021 12:40:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEB1CFj1svCWu7yOoUi_OkEqYEUQnB_XWOd3gD+ejO_6w@mail.gmail.com>
Message-ID: <CAMj1kXEB1CFj1svCWu7yOoUi_OkEqYEUQnB_XWOd3gD+ejO_6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: osl: Add __force attribute in
 acpi_os_map_iomem() cast
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 10 Aug 2021 at 18:46, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Aug 02, 2021 at 04:23:57PM +0100, Lorenzo Pieralisi wrote:
> > Add a __force attribute to the void* cast in acpi_os_map_iomem()
> > to prevent sparse warnings.
>
> Err, no.  These annotation are there for a reason and need to
> be propagated instead.  And independent of that a __force cast
> without a comment explaining it is a complete no-go.

The whole problem we are solving here is that ACPI, being based on
x86, conflates MMIO mappings with memory mappings, and has been using
the same underlying infrastructure for either. On arm64, this is not
sufficient, given that the semantics of uncached memory vs device are
different (the former permits unaligned accesses and clear cacheline
instructions, but the latter doesn't). A recent optimization applied
to memcpy() on arm64 (which now relies more on unaligned accesses for
performance) has uncovered an issue where firmware tables being mapped
non-cacheable by the ACPI core will end up using device mappings,
which causes memcpy() to choke on their contents.

So propagating the annotation makes no sense, as we are creating a
memory mapping using the iomem primitive. I wouldn't object to a
comment being added, but I think the context should have been obvious
to anyone who had bothered to look at the entire series.
