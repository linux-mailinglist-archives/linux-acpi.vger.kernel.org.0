Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96833B4401
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jun 2021 15:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFYNGa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Jun 2021 09:06:30 -0400
Received: from 8bytes.org ([81.169.241.247]:52218 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231283AbhFYNG2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Jun 2021 09:06:28 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7C4C73FC; Fri, 25 Jun 2021 15:04:06 +0200 (CEST)
Date:   Fri, 25 Jun 2021 15:03:59 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, mst@redhat.com,
        will@kernel.org, catalin.marinas@arm.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com
Subject: Re: [PATCH v5 0/5] Add support for ACPI VIOT
Message-ID: <YNXUP3wSeRo504sU@8bytes.org>
References: <20210618152059.1194210-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618152059.1194210-1-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 18, 2021 at 05:20:55PM +0200, Jean-Philippe Brucker wrote:
> Jean-Philippe Brucker (5):
>   ACPI: arm64: Move DMA setup operations out of IORT
>   ACPI: Move IOMMU setup code out of IORT
>   ACPI: Add driver for the VIOT table
>   iommu/dma: Pass address limit rather than size to
>     iommu_setup_dma_ops()
>   iommu/virtio: Enable x86 support

Applied all for v5.14, thanks Jean-Philippe for driving this effort and
the patience to do it right!
