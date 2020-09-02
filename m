Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7917C25A8DF
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Sep 2020 11:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgIBJsQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Sep 2020 05:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgIBJsL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Sep 2020 05:48:11 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E49204FD;
        Wed,  2 Sep 2020 09:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599040091;
        bh=Fvp6GtErygK3d+qTR+zVYuca+8Xt8w10C5RDoh0HRUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=maGZNk/FRrK/iNABWG4A6gb9SkEbUHXF3FFmsaaYPFpxJABAmKx0bRSsL9LeVS2iI
         s03ND2pH+cVTVgW9sYzzsjV70C9JRUIJ13tOBIRIprXZMTfGd/dlhtP4Dw+PpKkH7V
         bU7C5LoRHv/+gqvWVj6vSY5xb4fpDLTwN4oe3ayU=
Date:   Wed, 2 Sep 2020 10:48:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Zenghui Yu <yuzenghui@huawei.com>, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH v2 0/2] ACPI/IORT: Code cleanups
Message-ID: <20200902094806.GA5567@willie-the-truck>
References: <3142b38e-fef0-a7cf-319e-96c5da04967c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3142b38e-fef0-a7cf-319e-96c5da04967c@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 02, 2020 at 05:17:43PM +0800, Hanjun Guo wrote:
> +Cc Will
> 
> On 2020/8/18 17:16, Hanjun Guo wrote:
> > On 2020/8/18 14:36, Zenghui Yu wrote:
> > > * From v1 [1]:
> > >    - As pointed out by Hanjun, remove two now unused inline functions.
> > >      Compile tested with CONFIG_IOMMU_API is not selected.
> > > 
> > > [1] https://lore.kernel.org/r/20200817105946.1511-1-yuzenghui@huawei.com
> > > 
> > > Zenghui Yu (2):
> > >    ACPI/IORT: Drop the unused @ops of iort_add_device_replay()
> > >    ACPI/IORT: Remove the unused inline functions
> > > 
> > >   drivers/acpi/arm64/iort.c | 10 ++--------
> > >   1 file changed, 2 insertions(+), 8 deletions(-)
> > 
> > Nice cleanup.
> > 
> > Acked-by: Hanjun Guo <guohanjun@huawei.com>
> 
> Will, would you mind taking this patch set via ARM64 tree?

Sure, no problem. I'll queue this for 5.10 later this week.

Will
