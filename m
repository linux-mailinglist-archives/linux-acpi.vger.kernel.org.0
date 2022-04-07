Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EBA4F807C
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Apr 2022 15:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbiDGN2t (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Apr 2022 09:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiDGN2s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Apr 2022 09:28:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F4FFFB65
        for <linux-acpi@vger.kernel.org>; Thu,  7 Apr 2022 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mDNPBdIxUmUHG8SJ7MeeqPWQKsy0BA3146FhhfZqyjU=; b=JfeHaW2RKEgrbGW6YO9yOfWc66
        10aZDQX4B3pQ5N+zIjv6x9wqODHHSt28l+sMw04wINvwYvpXfl8mmAjP4SV9zWZ0JmFvj255X6TtG
        ENHDChoD61tcQ42Cjfj05hdYWfImC0fjvGS17IdkIcfY6sc7FGlp+/YwMCVZ2Za1+CMy+jlggJoFW
        DUR22ECxowZI+SJFMipDyJEM6OO/kSZ9GR2xKLwMg/5HYiAIbdSIcptECdagodEzNAMf3Q8vjVBhh
        KlTjhhI1l4tt1pvlF8LHU5VPArMyHNgSqkl4rMwcT9FodHvCjfulNNoyP/cK7TC4t9Es0PVpl9FNi
        8ypXELOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncS9s-00C8AT-Bp; Thu, 07 Apr 2022 13:26:44 +0000
Date:   Thu, 7 Apr 2022 06:26:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
        guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
        will@kernel.org, wanghuiqiang@huawei.com
Subject: Re: [PATCH v9 05/11] iommu/dma: Introduce a helper to remove
 reserved regions
Message-ID: <Yk7mlMjnRZjDoUqb@infradead.org>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-6-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404124209.1086-6-shameerali.kolothum.thodi@huawei.com>
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

>  
> +static inline void iommu_dma_put_resv_regions(struct device *dev, struct list_head *list)
> +{
> +}
> +
>  #endif	/* CONFIG_IOMMU_DMA */

This changes behavior when CONFIG_IOMMU_DMA is not set.  So e.g. on
ARM all the drivers that are using the new helper now fail to release
reserved regions.
