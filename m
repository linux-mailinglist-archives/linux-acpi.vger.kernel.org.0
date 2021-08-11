Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1033E934F
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Aug 2021 16:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhHKOKS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Aug 2021 10:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhHKOKR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Aug 2021 10:10:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01219C061765;
        Wed, 11 Aug 2021 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6de5f1CHYWUoF/nzjynDUSvxATwDyMoWSPF0pDGm5XU=; b=eM12qi1hSd1qymPbnnzmRIklfs
        0S++2PUuneV36qq6sFOvdoavU6paqQq57Lk2dhxKdaGR2F9i5p3e1KflxJX+VyILry9w1qiLHZHd4
        jsnNcgUGjaWshyFTehQSUgGXbYL2BpD/WM8QNWi+h7rzk7ZYwHZE0RTMSwHPjyasP8O/PxqFF/ath
        aDXzXwpYKliVXymf1auHsI/KgvZ/yHiagzjqZwh4KaLzK5U5oYNKmFnlYTV9nL5Adtpyi9jA3vZQn
        WoTcNSARF6vQuR+5bEPfi5P423GcGnrsWEbhr2M0c7k/vR3SHLGnDwo1Ub0SibWiukHiio5TtPLtR
        qxAgavEA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDou8-00DUX4-3n; Wed, 11 Aug 2021 14:08:34 +0000
Date:   Wed, 11 Aug 2021 15:08:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Subject: Re: [PATCH v2 1/3] ACPI: osl: Add __force attribute in
 acpi_os_map_iomem() cast
Message-ID: <YRPZ2Kqb/MFggHzQ@infradead.org>
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
 <20210802152359.12623-2-lorenzo.pieralisi@arm.com>
 <YRKtEDycefrZLB3X@infradead.org>
 <CAMj1kXEB1CFj1svCWu7yOoUi_OkEqYEUQnB_XWOd3gD+ejO_6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEB1CFj1svCWu7yOoUi_OkEqYEUQnB_XWOd3gD+ejO_6w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 11, 2021 at 12:40:28PM +0200, Ard Biesheuvel wrote:
> The whole problem we are solving here is that ACPI, being based on
> x86, conflates MMIO mappings with memory mappings, and has been using
> the same underlying infrastructure for either.

So let's fix that problem instead of papering over it.
