Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8B850C77D
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Apr 2022 07:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiDWFRI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 23 Apr 2022 01:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiDWFRI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Apr 2022 01:17:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86746245473
        for <linux-acpi@vger.kernel.org>; Fri, 22 Apr 2022 22:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u4JtFCq+KhE1NWmHJFTGoIgxVTQAJnln2oyi+cNip2U=; b=o2G32xQoAunS3XeRbIXIPCi+Tn
        NTVakwVpG3T2ytZB8EQ2I9S6cP0FQXw/Gjwb/qN1hwVo4lS2fVlTGSuVlzkhaysbTUnTkZVshbIUp
        0aMbzylEtEYIzcyZ+54AgXhP9P7nkqwD8RyDKdI8LWSKSQkviARvxSQ+S/bzeaHIraRTYKiN71K9T
        qMpSPXsckHKo3P4huFIMrGUhVpqNJpjnsMcmEH+ULxJtQcjmHr8/Wl/Ro70WiMxwdYKIEkoZeeWEI
        qNovEAVRNk+3MI0r6o8ZK3RgIcEaGe8yke0gVfTNqmq9wvY+HS/lw1kcZ8eg5peqJ2MPH37rgXyR5
        WTdnGq4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ni85q-003SMm-Dr; Sat, 23 Apr 2022 05:14:02 +0000
Date:   Fri, 22 Apr 2022 22:14:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
        hch@infradead.org, guohanjun@huawei.com, Sami.Mujawar@arm.com,
        will@kernel.org, wanghuiqiang@huawei.com
Subject: Re: [PATCH v11 1/9] iommu: Introduce a callback to struct
 iommu_resv_region
Message-ID: <YmOLGsaMa7hCjMzx@infradead.org>
References: <20220422162907.1276-1-shameerali.kolothum.thodi@huawei.com>
 <20220422162907.1276-2-shameerali.kolothum.thodi@huawei.com>
 <03e94ba9-f558-954f-e84b-cd8a9e693aea@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e94ba9-f558-954f-e84b-cd8a9e693aea@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Apr 23, 2022 at 10:04:39AM +0800, Lu Baolu wrote:
> The generic_iommu_put_resv_regions() itself is a callback. Why bothering
> adding another callback from the same iommu driver in it? Or, you are
> going to remove the put_resv_regions from the iommu ops?

It is a driver method, but these reserved entries are not actually
allocated by the driver.  And I do have a patch pending removing this
driver method that should never have been a driver method, check
the iomm list archives for

    iommu: remove the put_resv_regions method

