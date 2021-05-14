Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8298A380780
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 12:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhENKka (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 06:40:30 -0400
Received: from foss.arm.com ([217.140.110.172]:46978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229964AbhENKka (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 May 2021 06:40:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD8BF1713;
        Fri, 14 May 2021 03:39:18 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EFCD3F719;
        Fri, 14 May 2021 03:39:17 -0700 (PDT)
Date:   Fri, 14 May 2021 11:39:12 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI/IORT: Handle device properties with software node
 API
Message-ID: <20210514103912.GA16131@lpieralisi>
References: <20210511125528.18525-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511125528.18525-1-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 11, 2021 at 03:55:28PM +0300, Heikki Krogerus wrote:
> The older device property API is going to be removed.
> Replacing the device_add_properties() call with software
> node API equivalent device_create_managed_software_node().
> 
> Fixes: 434b73e61cc6 ("iommu/arm-smmu-v3: Use device properties for pasid-num-bits")

Is this really fixing anything ? I am not sure I understand what you
would like to achieve with this tag.

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/acpi/arm64/iort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

With the above comment clarified:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 3912a1f6058e5..e34937e11186a 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -976,7 +976,7 @@ static void iort_named_component_init(struct device *dev,
>  				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
>  						nc->node_flags));
>  
> -	if (device_add_properties(dev, props))
> +	if (device_create_managed_software_node(dev, props, NULL))
>  		dev_warn(dev, "Could not add device properties\n");
>  }
>  
> -- 
> 2.30.2
> 
