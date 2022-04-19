Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AF1506762
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Apr 2022 11:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350281AbiDSJHf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Apr 2022 05:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350139AbiDSJHe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Apr 2022 05:07:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAEB2637
        for <linux-acpi@vger.kernel.org>; Tue, 19 Apr 2022 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QWoz5w92bsn0XGI4LeiFcttEdCIBZSDFKXBIU0wXer4=; b=BIzQRnisGfTGDfL97WMA3PzLmc
        xsDJTaLV0nKgzVAu11WPScdZwynMwIualnkmCLH3RYwFx1g/L9p4X1cBVHxy2TDjvxDZ/2PMg0BQn
        hA53WFBIauHqH1rAgstK/5Bo5Itkxv/lLD3oSVZkogndd58/9KzLJmN5NNRXwB6+TJBKxrvfwsw/m
        mnD/WGhJMO3Am8hW5hQqwgpa20fZD6JDsyt+4k5cw8a4olQbFbseHYmSTxYVqNb84Xu9ejpzYUFJu
        +QgBMw7oLphyHLQnTsXCNdTSDPFsgvsANBK6hYxaid9YkmHLawdVXuVhi/mH++qYaApcdAzT2pogp
        2rsJ2BAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngjmw-002Txg-KW; Tue, 19 Apr 2022 09:04:46 +0000
Date:   Tue, 19 Apr 2022 02:04:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Subject: Re: [PATCH v9 06/11] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Message-ID: <Yl57LuiR0JC4AZrw@infradead.org>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-7-shameerali.kolothum.thodi@huawei.com>
 <Yk7m8oDPtusDzReK@infradead.org>
 <b50cded6-6777-c9c7-7030-a57f28771bc3@arm.com>
 <Yk7uRPG1TwGFPbyY@infradead.org>
 <955601f02f3b474da3327963fb1630f0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <955601f02f3b474da3327963fb1630f0@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 19, 2022 at 08:31:55AM +0000, Shameerali Kolothum Thodi via iommu wrote:
> Sorry for the delayed response(was on holidays). So if we move the
> iommu_dma_put_resv_region() call to generic_iommu_put_resv_regions() ,
> will that address the concerns here?
> 
> I think it will resolve the issue in 05/11 as well pointed out by Christoph
> where we end up not releasing reserved regions when
> CONFIG_IOMMU_DMA is not set.

As Robin pointed out we might not really deduct that ACPI means RMR.

I suspect the best would be to just attach a free callback to the
regions.  Either by adding it directly to struct iommu_resv_region
if we thing there are few enough regions to not be worried about
the memory use, or other by adding a container struct for the list_head
that contains the free callback.
