Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DB24F8082
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Apr 2022 15:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbiDGNaS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Apr 2022 09:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiDGNaS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Apr 2022 09:30:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DE51CC402
        for <linux-acpi@vger.kernel.org>; Thu,  7 Apr 2022 06:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WXMXF9kTfNByY6iB1S9IPFjIYZPUguzDj/Fd9M8O6GQ=; b=hfsYuBCTQR2kUqLL08ZDAMLkKI
        xOS2Smt2JxMOzsBm4Cj3Xd1TuoOo5JqDLDh6GkEQRT9ejahjJ3gzXMPRBF9u42R8epj99Oiqj/lMs
        FshlyVYurXZ1aj3cnQk6Jo2MiKokkjHrJUoRKBX8GCXjISeu2s33uUiHpuRuIL2vxoJ8dBHqdCn5B
        qHiGvdkX7W16zh4tY0qg8WMrSGkQYWoMPb3wUrOxtWh+Mc4o/2QLAJvJsN8eWA0l4cj+d0TsmQ1oz
        Eo5KRcq3nKQhfw54ZPv3M8FXeCAzIycDXfVuM6PFTBLb6i2dKFVoA6AVM0qF3J0FlOpgzmKTRZV4t
        Z669NKpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncSBO-00C8Ri-Az; Thu, 07 Apr 2022 13:28:18 +0000
Date:   Thu, 7 Apr 2022 06:28:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
        guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
        will@kernel.org, wanghuiqiang@huawei.com
Subject: Re: [PATCH v9 06/11] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Message-ID: <Yk7m8oDPtusDzReK@infradead.org>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-7-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404124209.1086-7-shameerali.kolothum.thodi@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> +static void iort_rmr_desc_check_overlap(struct acpi_iort_rmr_desc *desc, u32 count)

Overly long line.

>  void iommu_dma_put_resv_regions(struct device *dev, struct list_head *list)
>  {
> +	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
> +		iort_iommu_put_resv_regions(dev, list);
> +
>  	generic_iommu_put_resv_regions(dev, list);
>  }

Why can't this just go into generic_iommu_put_resv_regions?  The idea
that the iommu low-level drivers need to call into dma-iommu which is
a consumer of the IOMMU API is odd.  Especially if that just calls out
to ACPI code and generic IOMMU code only anyway.
