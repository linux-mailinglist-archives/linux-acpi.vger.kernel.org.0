Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AD3509840
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Apr 2022 09:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385308AbiDUGwD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Apr 2022 02:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385201AbiDUGvx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Apr 2022 02:51:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506B81902B
        for <linux-acpi@vger.kernel.org>; Wed, 20 Apr 2022 23:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qRe7vVjPJnHyP0cePRDkMY8xq1/p2U8RyI0nOsV3x/Y=; b=gXTsIB/cqOFjcI2VVEPlTTOA/z
        JkDaeAbQkTqWCmZQWPF2ud1tjTcCPl9gGvqF1cbbelDgbwib3XeammJKt5j6sFWVIOEU+dzKg7iSN
        yMZ2/K34n1kAt9TEZmdH+AadMMJ8x/SxyO96p7sMhG/8SiHufQvCmfTxVUK4J/O1zxY3hKzvRc5W7
        112L3TTd3hsNoKEUhHo1/RudxRQNIg4jeruHz1cfxbA15O8FvZN+JbMufRnYg++ECHv/w3OLD29nn
        xSimUZI8scvoZRvioaHzZXORXk3dRwdPdKYeX/5c0WPMTsPIG6w9kdEk2EQZqurSseYK4MsCdwIju
        cVmW2Y8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhQa8-00Bpjs-FO; Thu, 21 Apr 2022 06:46:24 +0000
Date:   Wed, 20 Apr 2022 23:46:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        lorenzo.pieralisi@arm.com, joro@8bytes.org, robin.murphy@arm.com,
        will@kernel.org, wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, laurentiu.tudor@nxp.com, hch@infradead.org
Subject: Re: [PATCH v10 1/9] iommu: Introduce a union to struct
 iommu_resv_region
Message-ID: <YmD9wBhR8/j8HOaX@infradead.org>
References: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
 <20220420164836.1181-2-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420164836.1181-2-shameerali.kolothum.thodi@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 20, 2022 at 05:48:28PM +0100, Shameer Kolothum wrote:
> @@ -141,6 +149,11 @@ struct iommu_resv_region {
>  	size_t			length;
>  	int			prot;
>  	enum iommu_resv_type	type;
> +	union {
> +		struct iommu_iort_rmr_data rmr;
> +	} fw_data;
> +	void (*resv_region_free_fw_data)(struct device *dev,
> +					 struct iommu_resv_region *region);

I'd shorten the name to just free.  Also any reason the call to this
method isn't also added in this patch as it logically belongs here?
