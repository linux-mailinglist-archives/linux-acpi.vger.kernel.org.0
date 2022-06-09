Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38F054512E
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jun 2022 17:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbiFIPrL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jun 2022 11:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbiFIPrK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jun 2022 11:47:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577274BBA8
        for <linux-acpi@vger.kernel.org>; Thu,  9 Jun 2022 08:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1899DB82E1D
        for <linux-acpi@vger.kernel.org>; Thu,  9 Jun 2022 15:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC149C3411B;
        Thu,  9 Jun 2022 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654789626;
        bh=Ig3PZxq6X7jjVwsOQX/FxhA7SqMs07gOu2FyHVJ6vds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWYeGUMlnWf18Seq6J3rYnR5qb1T+QvCJdhi1QQAEYXfX0OkszfpEmywzR1JX8CeY
         zOQq6h8GVilu1KKQRTNi1bMrZfMxk79C2tQ2svu3P+6HKgfbtz+SjveJPX/mIPUC/7
         Q4D7ilZRcN8rXgUVgoJJPrZ1DSlItZck2rl4A0V6+40DTjrrxgMcr83ydAImqK352i
         uFMY/yiIgcFn0ICWk3RW2HFnS7G6kP8z+BfnyZkaSd+g9GjsEHbG5QxbESSebPBxev
         FET8oI2h6MfdMt1Pnv42g1N7l6IG2/7qd7q7ma0QVD4r77mjtNYr2y0FExR6S8JpPx
         Xcd7D7BQPR6jw==
Date:   Thu, 9 Jun 2022 16:47:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        lorenzo.pieralisi@arm.com, joro@8bytes.org, robin.murphy@arm.com,
        wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, laurentiu.tudor@nxp.com, hch@infradead.org
Subject: Re: [PATCH v12 6/9] iommu/arm-smmu-v3: Introduce strtab init helper
Message-ID: <20220609154656.GB3444@willie-the-truck>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
 <20220503163330.509-7-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503163330.509-7-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 03, 2022 at 05:33:27PM +0100, Shameer Kolothum wrote:
> Introduce a helper to check the sid range and to init the l2 strtab
> entries(bypass). This will be useful when we have to initialize the
> l2 strtab with bypass for RMR SIDs.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 28 +++++++++++----------
>  1 file changed, 15 insertions(+), 13 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
