Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0D027F024
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Sep 2020 19:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgI3RTO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Sep 2020 13:19:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgI3RTO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Sep 2020 13:19:14 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37908207C3;
        Wed, 30 Sep 2020 17:19:10 +0000 (UTC)
Date:   Wed, 30 Sep 2020 18:19:08 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v3 1/2] arm64/acpi: disallow AML memory opregions to
 access kernel memory
Message-ID: <20200930171908.GA1732@gaia>
References: <20200626155832.2323789-1-ardb@kernel.org>
 <20200626155832.2323789-2-ardb@kernel.org>
 <20200928170216.00006ff2@huawei.com>
 <CAMj1kXH1LZ15gzfW+7X5A4dMCD33DqNLnVrnLRo1zpw1Ekg+Lw@mail.gmail.com>
 <20200928181755.000019bf@huawei.com>
 <CAMj1kXGLVgAc0u9pSy0cKkmQXntdqjkkoM5wpdwLiwZfKOXKPA@mail.gmail.com>
 <20200930102722.00000bff@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930102722.00000bff@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jonathan,

On Wed, Sep 30, 2020 at 10:27:22AM +0100, Jonathan Cameron wrote:
> On Tue, 29 Sep 2020 11:29:48 +0200 Ard Biesheuvel <ardb@kernel.org> wrote:
> > Could you try the patch below? Since the memory holding the tables is
> > already memblock_reserve()d, we can just mark it NOMAP, and permit r/o
> > remapping of NOMAP regions.
> 
> Looks good.  Thanks.
> 
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Could you please try the updated patch that Ard posted. There are a few
minor differences:

https://lore.kernel.org/linux-acpi/20200929132522.18067-1-ardb@kernel.org/

Thanks.

-- 
Catalin
