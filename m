Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFABB1B07C1
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Apr 2020 13:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDTLml (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Apr 2020 07:42:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbgDTLmk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Apr 2020 07:42:40 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AF3E21927
        for <linux-acpi@vger.kernel.org>; Mon, 20 Apr 2020 11:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587382959;
        bh=dP1oVcmvIppxFO3KTVGqSn4HmzrD4AZiENin5O5hyrI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FxlSC0s8L8mYBVyCpv9L7Qi7IsLFzhlEG1C1myoEfRKG5ds9VRJflaW9pocyEjVe7
         SUQh5Kvb9OZW+ZRp9v4Bkf6iAFK949hy2kZizxLLthIT4yUuJfKS5n64fKx8+impXx
         ljjfrfnwhu4TanweWIQsPiD3imft6Ym9G065sX0A=
Received: by mail-io1-f51.google.com with SMTP id i19so10517904ioh.12
        for <linux-acpi@vger.kernel.org>; Mon, 20 Apr 2020 04:42:39 -0700 (PDT)
X-Gm-Message-State: AGi0PuZEEHqD8Gmg5tTbv8lJK72MXHw4SUDzkQU95O87J22v4JWTGzry
        DtDGA64a+rIXHL2nePxpQtQVdlEfynCL+btgPaA=
X-Google-Smtp-Source: APiQypKfR/5hkO0sBi162Lm2FAb7ByMjVLqWpLIa5KSMM3Jh0iMdkDzJ9L41KIXcv8H1DlI1xdnQzoEiZvTYyvhDCuk=
X-Received: by 2002:a02:969a:: with SMTP id w26mr14759250jai.71.1587382958899;
 Mon, 20 Apr 2020 04:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200420081131.16822-1-ardb@kernel.org> <20200420093055.GA7393@e121166-lin.cambridge.arm.com>
 <f71002a8-fc32-f271-1586-807fc6f50107@arm.com>
In-Reply-To: <f71002a8-fc32-f271-1586-807fc6f50107@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 20 Apr 2020 13:42:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFr8WfmLqfEhYUyCBCF5hNrkhWLJWMHhS9wMb8RUS+_EQ@mail.gmail.com>
Message-ID: <CAMj1kXFr8WfmLqfEhYUyCBCF5hNrkhWLJWMHhS9wMb8RUS+_EQ@mail.gmail.com>
Subject: Re: [PATCH] acpi: arm64/iort: Ensure DMA mask does not exceed device limit
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-acpi@vger.kernel.org, sudeep.holla@arm.com,
        guohanjun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 20 Apr 2020 at 13:23, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-04-20 10:30 am, Lorenzo Pieralisi wrote:
> > [+Robin]
> >
> > On Mon, Apr 20, 2020 at 10:11:31AM +0200, Ard Biesheuvel wrote:
> >> When calculating the DMA mask from the address limit provided by the
> >> firmware, we add one to the ilog2() of the end address, and pass the
> >> result to DMA_BIT_MASK().
> >>
> >> For an end address that is not a power-of-2 minus 1, this will result
> >> in the mask to be wider than the limit, and cover memory that is not
> >> addressable by the device. Instead, we should add 1 to 'end' before
> >> taking the log, so that a limit of, say, 0x3fffffff gets translated
> >> to a mask of 30, but any value below it gets translated to 29.
> >>
> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >> ---
> >>   drivers/acpi/arm64/iort.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Need Robin's feedback on this - I was looking at:
> >
> > a7ba70f1787f ("dma-mapping: treat dev->bus_dma_mask as a DMA limit")
> >
> > I assume current code is *intended* but I shall let Robin comment
> > on this.
>
> The device masks represent what bits the device is capable of driving,
> so rounding up is the correct and intended behaviour - if the
> interconnect address map imposes a non-power-of-two limit, say 3.75GB,
> and the device can physically access all of that, then claiming the
> device can't drive bit 31 and trying to prevent it from accessing the
> upper 1.75GB is nonsense.
>

Fair enough.

> Although TBH none of this really matters much any more - as long as the
> limit is set correctly nothing bad will happen, and drivers are expected
> to replace these default masks anyway. In fact ancient drivers that
> still don't explicitly set their masks will be assuming the defaults are
> 32-bit, so replacing them with something potentially wider actually
> invites a whole other set of problems. In the case of
> of_dma_configure(), it kept the code that combines (*not* replaces) the
> default device masks with a limit-based mask because it didn't do any
> harm, but equally it should now be entirely unnecessary, and confusion
> like this seems like an argument for finally removing it.
>

Indeed :-)

Thanks for the explanation.
