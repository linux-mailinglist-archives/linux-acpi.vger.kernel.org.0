Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9203519AA
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 20:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhDARzz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 13:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236994AbhDARuA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Apr 2021 13:50:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39E5161398;
        Thu,  1 Apr 2021 17:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617297067;
        bh=PIT2jhNPPa9PR29r77Bt26sck2KltF1OUjlMOqD2BAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WWQ9pVjULcj6wFn4SulQ8mjPjS0KQqpninOcoNTDiJT/MKxV4sXYbZ/4r4JRZIzVN
         UY6rpatTGL7J9Yt9aRVsYpXRHrePcl+HFzlbc0sju7FjMsCgPTirCXKqtBzDxwUuHa
         /ZGL017tvGMyxVh7H0JDMS2WoEbI0X5CNNPzB5YTZu2L5RvuS0qDCxErArsUCojRvZ
         fdJN5chmZLO+kGt1FAqQdIdqJLWyl5Hq7XorKUw/JZ+tRIDeNh75WhFL3dzV5Y1IgW
         mZ1x7ByZLf1em040i9Qe9RPG1JUD7jb03Iou8LO0JJAOeL5mByUXGtWFCBJ7rcB5LV
         Y4CxN2JKHR2Ew==
Date:   Thu, 1 Apr 2021 18:11:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     joro@8bytes.org, vivek.gautam@arm.com, guohanjun@huawei.com,
        linux-acpi@vger.kernel.org, zhangfei.gao@linaro.org,
        lenb@kernel.org, devicetree@vger.kernel.org, kevin.tian@intel.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        rjw@rjwysocki.net, iommu@lists.linux-foundation.org,
        sudeep.holla@arm.com, robin.murphy@arm.com,
        linux-accelerators@lists.ozlabs.org
Subject: Re: [PATCH v14 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <20210401171101.GB9447@willie-the-truck>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
 <20210401154718.307519-11-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401154718.307519-11-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 01, 2021 at 05:47:19PM +0200, Jean-Philippe Brucker wrote:
> The SMMU provides a Stall model for handling page faults in platform
> devices. It is similar to PCIe PRI, but doesn't require devices to have
> their own translation cache. Instead, faulting transactions are parked
> and the OS is given a chance to fix the page tables and retry the
> transaction.
> 
> Enable stall for devices that support it (opt-in by firmware). When an
> event corresponds to a translation error, call the IOMMU fault handler.
> If the fault is recoverable, it will call us back to terminate or
> continue the stall.

Which hardware is this useful for? Stalling adds a fair amount of complexity
to the driver, so I don't think we should support it unless we're likely to
see platforms that both implement it and do something useful with it.

Will
