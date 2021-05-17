Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAAD382B78
	for <lists+linux-acpi@lfdr.de>; Mon, 17 May 2021 13:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbhEQLwU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 07:52:20 -0400
Received: from 8bytes.org ([81.169.241.247]:39402 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229982AbhEQLwU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 May 2021 07:52:20 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 92F9C2E7; Mon, 17 May 2021 13:51:02 +0200 (CEST)
Date:   Mon, 17 May 2021 13:51:01 +0200
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
Subject: Re: [PATCH v2 0/6] Add support for ACPI VIOT
Message-ID: <YKJYpZUddMLM+A1M@8bytes.org>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423113836.3974972-1-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean-Philippe,

On Fri, Apr 23, 2021 at 01:38:31PM +0200, Jean-Philippe Brucker wrote:
> Jean-Philippe Brucker (6):
>   ACPI: arm64: Move DMA setup operations out of IORT
>   ACPI: Move IOMMU setup code out of IORT
>   ACPI: Add driver for the VIOT table
>   iommu/dma: Pass address limit rather than size to
>     iommu_setup_dma_ops()
>   iommu/dma: Simplify calls to iommu_setup_dma_ops()
>   iommu/virtio: Enable x86 support

This looks good to me, I think this all can go through the IOMMU tree?
In this case I will apply them once the ACPI parts have the Acks
maintainers ack.

Regards,

	Joerg
