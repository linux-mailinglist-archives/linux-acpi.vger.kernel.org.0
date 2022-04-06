Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39C24F67DE
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 19:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbiDFRns (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Apr 2022 13:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239531AbiDFRnc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Apr 2022 13:43:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CF941A54DC
        for <linux-acpi@vger.kernel.org>; Wed,  6 Apr 2022 08:53:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 069AC12FC;
        Wed,  6 Apr 2022 08:53:10 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.21.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5D073F73B;
        Wed,  6 Apr 2022 08:53:07 -0700 (PDT)
Date:   Wed, 6 Apr 2022 16:53:08 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        joro@8bytes.org, robin.murphy@arm.com, will@kernel.org,
        wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, laurentiu.tudor@nxp.com,
        yangyicong@huawei.com
Subject: Re: [PATCH v9 01/11] ACPI/IORT: Add temporary RMR node flag
 definitions
Message-ID: <20220406155308.GD27518@lpieralisi>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-2-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404124209.1086-2-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 04, 2022 at 01:41:59PM +0100, Shameer Kolothum wrote:
> IORT rev E.d introduces more details into the RMR node Flags
> field. Add temporary definitions to describe and access these
> Flags field until ACPICA header is updated to support E.d.
> 
> This patch can be reverted once the include/acpi/actbl2.h has
> all the relevant definitions.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> Please find the ACPICA E.d related changes pull request here,
> https://github.com/acpica/acpica/pull/765
> 
> This is now merged to acpica:master.

I assume we can drop this patch when ACPICA Linuxized patches hit
Rafael's tree.

> ---
>  drivers/acpi/arm64/iort.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index f2f8f05662de..fd06cf43ba31 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -25,6 +25,30 @@
>  #define IORT_IOMMU_TYPE		((1 << ACPI_IORT_NODE_SMMU) |	\
>  				(1 << ACPI_IORT_NODE_SMMU_V3))
>  
> +/*
> + * The following RMR related definitions are temporary and
> + * can be removed once ACPICA headers support IORT rev E.d
> + */
> +#ifndef ACPI_IORT_RMR_REMAP_PERMITTED
> +#define ACPI_IORT_RMR_REMAP_PERMITTED	(1)
> +#endif
> +
> +#ifndef ACPI_IORT_RMR_ACCESS_PRIVILEGE
> +#define ACPI_IORT_RMR_ACCESS_PRIVILEGE	(1 << 1)
> +#endif
> +
> +#ifndef ACPI_IORT_RMR_ACCESS_ATTRIBUTES
> +#define ACPI_IORT_RMR_ACCESS_ATTRIBUTES(flags)	(((flags) >> 2) & 0xFF)
> +#endif
> +
> +#ifndef ACPI_IORT_RMR_ATTR_DEVICE_GRE
> +#define ACPI_IORT_RMR_ATTR_DEVICE_GRE	0x03
> +#endif
> +
> +#ifndef ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB
> +#define ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB	0x05
> +#endif
> +
>  struct iort_its_msi_chip {
>  	struct list_head	list;
>  	struct fwnode_handle	*fw_node;
> -- 
> 2.25.1
> 
