Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3855C351155
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 10:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhDAI6D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 04:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233650AbhDAI6A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Apr 2021 04:58:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBF966023B;
        Thu,  1 Apr 2021 08:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617267480;
        bh=qO5GnDQBxqX1f7x9zAi73eBzkaFPHd3HL6PpBB85bdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMfEcbl8tYPuX5WDV/d/OgcbQ4JUHkcqvauo65fQCWGZLSdEOyJdCKSebhVJ5N139
         /fRmtaxVbip3YDuWsFYMDKtqOs4Xd6epo3gS2N5xpJGPgHVdEmamYy7AzcvpXEosP2
         qaAd6IDmnhCg0n7BzRjeM+uRDfm+lbEw99nW4yPoCwBO0cqaESOj+V5MerHHeW8TwP
         w/xULX4IvKezvZLKNY9Q++cRvNJE/SGXScv/NODcscd25v0fvpY8fZHzqK5YpQ/PLl
         VRd1Aqr7RG76L5N8GCV0LhxcM4vdJWBwAMaTWReNAjFSSH9L/gNBndS5BG4l0MiV54
         I1y0PfrhuBuIw==
Date:   Thu, 1 Apr 2021 09:57:52 +0100
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     joro@8bytes.org, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        zhukeqian1@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH v13 00/10] iommu: I/O page faults for SMMUv3
Message-ID: <20210401085752.GA8781@willie-the-truck>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
 <YGNdQ863Mohizx7A@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGNdQ863Mohizx7A@myrica>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 30, 2021 at 07:17:55PM +0200, Jean-Philippe Brucker wrote:
> On Tue, Mar 02, 2021 at 10:26:36AM +0100, Jean-Philippe Brucker wrote:
> > Add stall support to the SMMUv3 driver, along with a common I/O Page
> > Fault handler.
> 
> I only have review/ack tags and one assert_lockdep to add to this series.
> Should I send a v14 now or wait a little longer?  Just making sure we can
> get at least patches 1-6 in v5.13.

Easiest thing is probably to send a v14 containing just the patches
targetting v5.13, so that Joerg can queue them up.

Will
