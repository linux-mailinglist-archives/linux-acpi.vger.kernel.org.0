Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB0D2A2AF7
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 13:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgKBMtu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Nov 2020 07:49:50 -0500
Received: from foss.arm.com ([217.140.110.172]:59080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728599AbgKBMtu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Nov 2020 07:49:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7114F30E;
        Mon,  2 Nov 2020 04:49:49 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A46F13F66E;
        Mon,  2 Nov 2020 04:49:48 -0800 (PST)
Date:   Mon, 2 Nov 2020 12:49:43 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: scan: Fix acpi_dma_configure_id() kerneldoc name
Message-ID: <20201102124943.GA3161@e121166-lin.cambridge.arm.com>
References: <1604315971-89149-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604315971-89149-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 02, 2020 at 07:19:31PM +0800, John Garry wrote:
> For some reason building with W=1 doesn't pick up on this, but the
> kerneldoc name for acpi_dma_configure_id() is not right, so fix it up.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a896e5e87c93..bc6a79e33220 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> @@ -1453,7 +1453,7 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>  }
>  
>  /**
> - * acpi_dma_configure - Set-up DMA configuration for the device.
> + * acpi_dma_configure_id - Set-up DMA configuration for the device.
>   * @dev: The pointer to the device
>   * @attr: device dma attributes
>   * @input_id: input device id const value pointer
> -- 
> 2.26.2
> 
