Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD84776460
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 17:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjHIPts (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 11:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHIPts (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 11:49:48 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78C6F1BD9
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 08:49:47 -0700 (PDT)
Received: from 8bytes.org (pd9fe94eb.dip0.t-ipconnect.de [217.254.148.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 0F17E280529;
        Wed,  9 Aug 2023 17:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1691596186;
        bh=CzVTmNvvlosemzzOjEBPXfho0AE1ckTXDIOjya/Oopc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyoveX6MRa9kGR1uQBmJlwszz5AKx16c9aouXoXcDDrtxzeDE3onStHf6UzZH8omj
         d50P9V8tl2jWC2d8IMILLvytXcls7kGitCaijOPo2jMNGVoMa3G8SIrBGjeuB1UQeX
         n/ONdvYRF0eR8sRpQwBPUuQoVtY0OlJYiFUFQGaK/RbQnSFOVZLFF2oefdxsV+H1uj
         YfnBcl0BFFgohd3Ll1eW2iLGvoBOAmjlT5mgd0chI/7/c5/ICjAm7y5icAturoGslT
         hjRWDOqB7f58h8czbpRn58nqQRkMEt474MGiBgd3pLNVBJbgSzQAW7mRRvlsBNr+c5
         AAyFJcPDA5I6Q==
Date:   Wed, 9 Aug 2023 17:49:44 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
Message-ID: <ZNO1mDqas0uX_TVA@8bytes.org>
References: <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 09, 2023 at 11:43:46AM -0300, Jason Gunthorpe wrote:
> Jason Gunthorpe (4):
>   iommu: Provide iommu_probe_device_locked()
>   iommu: Pass in the iommu_device to probe for in bus_iommu_probe()
>   iommu: Do not attempt to re-lock the iommu device when probing
>   iommu: dev->iommu->iommu_dev must be set before ops->device_group()

Applied, thanks for fixing this quickly.
