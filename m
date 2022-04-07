Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343C44F8123
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Apr 2022 15:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbiDGOBn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Apr 2022 10:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343798AbiDGOBk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Apr 2022 10:01:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A911BA699
        for <linux-acpi@vger.kernel.org>; Thu,  7 Apr 2022 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Wz4hNkxsawX4PgHGVpqI7DcWA7D+ygHUR+Jezxq/sok=; b=p8lu6HeON3HuIqNpvtMeUF8UAq
        8f/e/8K+TvocGaKgfxOWSnIxVRfDL+25cIGEQltU/vpsnWLs2u/cG7YeDVQXUgeJTiZe8j2EoesMO
        Loeu+j1y4VJZO8fvV1AahrwbE4sG/A7yD4tJRVr6AmEOKACG84SlM1jp/JtepWhAi6LmBp+BOUfit
        ZzxkGfAGEayAyrxcI5txuKnCg1fXhQZD6P7u8aBmmg/d1yEN9g1AP9lVPYA9bu9GpcDVKq2+Jd3E5
        hODo+PqENwnnZJ56le4zI75STD1YwMVBU/WUTN5Qub3jEdLXTyVUXKJ7TBMWmS0f4KEG1o3wCfRSO
        NfTZduow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncSfc-00CGaB-Oy; Thu, 07 Apr 2022 13:59:32 +0000
Date:   Thu, 7 Apr 2022 06:59:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        wanghuiqiang@huawei.com, guohanjun@huawei.com,
        yangyicong@huawei.com, Sami.Mujawar@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 06/11] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Message-ID: <Yk7uRPG1TwGFPbyY@infradead.org>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-7-shameerali.kolothum.thodi@huawei.com>
 <Yk7m8oDPtusDzReK@infradead.org>
 <b50cded6-6777-c9c7-7030-a57f28771bc3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b50cded6-6777-c9c7-7030-a57f28771bc3@arm.com>
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

On Thu, Apr 07, 2022 at 02:53:38PM +0100, Robin Murphy wrote:
> > Why can't this just go into generic_iommu_put_resv_regions?  The idea
> > that the iommu low-level drivers need to call into dma-iommu which is
> > a consumer of the IOMMU API is odd.  Especially if that just calls out
> > to ACPI code and generic IOMMU code only anyway.
> 
> Because assuming ACPI means IORT is not generic. Part of the aim in adding
> the union to iommu_resv_region is that stuff like AMD's unity_map_entry and
> Intel's dmar_rmrr_unit can be folded into it as well, and their reserved
> region handling correspondingly simplified too.
> 
> The iommu_dma_{get,put}_resv_region() helpers are kind of intended to be
> specific to the fwnode mechanism which deals with IORT and devicetree (once
> the reserved region bindings are fully worked out).

But IORT is not driver₋specific code.  So we'll need a USE_IORT flag
somewhere in core IOMMU code instead of trying to stuff this into
driver operations.  and dma-iommu mostly certainly implies IORT even
less than ACPI.
