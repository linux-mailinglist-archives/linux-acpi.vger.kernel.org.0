Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AA64DA19E
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Mar 2022 18:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbiCORyo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Mar 2022 13:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350757AbiCORyn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Mar 2022 13:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA1B149F1F
        for <linux-acpi@vger.kernel.org>; Tue, 15 Mar 2022 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647366808;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/yckfNRZbm4EhSd/3o0sHKLktNUAlNSpqA9x4v1UNDA=;
        b=BcTEcko+YU3OgfI2uLtPIK0PgaMUtY4BzWjlHj8rTYiaOSlx1+KIUpS/1Y40RAEjkWiNUz
        fULwtm7k7PWicv4E8EupVE/AZOH+JcMnxJmqCXdna6+sBJmVAUI96ASlN7zmR+V+D8xo55
        C3P0nmRfGddo1QRL4Wnm2S5R+Jni6ck=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-3FEmasHqNgaBha8Ov_9Iww-1; Tue, 15 Mar 2022 13:53:27 -0400
X-MC-Unique: 3FEmasHqNgaBha8Ov_9Iww-1
Received: by mail-wm1-f71.google.com with SMTP id v184-20020a1cacc1000000b0038a12dbc23bso1519950wme.5
        for <linux-acpi@vger.kernel.org>; Tue, 15 Mar 2022 10:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=/yckfNRZbm4EhSd/3o0sHKLktNUAlNSpqA9x4v1UNDA=;
        b=KODWelbfzw4RAhYGzZZEVcnavhcTqEk0Rb5+BB5oymEleadv4p0slrsSfz6yMSfRjD
         qvR4dE8H5XDGCEJLBMAU3OGwDH4QIQ64JcIQzsdciSVqSE3Gsw7FVTHWlSTTYk8sxF4Q
         WXm89i3fTP87nJAhrGfDDB/b1bcIE075YYRvWSp+wDsSbAmXZmNctt5fR/GHHoVbkvWC
         6kYy2mSnPkKOs101ThyMKSFMGuYn6Lsc9wipQx8nFWL8H068m6g73U4kSksbhYIDYYeT
         i3wnG+dR2uBJo8oVuOO9Z4yiJLOFMLxtt+ZDH2Tu5F2mr+0UtIKomK65kz1KYetXDoRy
         Y3tA==
X-Gm-Message-State: AOAM531RFNWPR4tL9etJ5hK8Y4Zs3AkmPBqmYzTt64sKiWCh/IIciOwh
        nBdidqfua18zdROrmkEJA8UDoY11oU9qLnkHJVXDcxx2BR8PwXkyEyXUBJWmmDB9qLbwto3GlL9
        GvaLwoq9a/u7+qVVkZJomOA==
X-Received: by 2002:a05:600c:3c9d:b0:37f:a5c3:fccf with SMTP id bg29-20020a05600c3c9d00b0037fa5c3fccfmr4133684wmb.13.1647366806339;
        Tue, 15 Mar 2022 10:53:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynGJfIupJwDxJtzzf700kKsr6SmaTl2v42mpNIvbie9DtlPp9iqXjPU7blEwcvfvRk4ylyCw==
X-Received: by 2002:a05:600c:3c9d:b0:37f:a5c3:fccf with SMTP id bg29-20020a05600c3c9d00b0037fa5c3fccfmr4133660wmb.13.1647366806070;
        Tue, 15 Mar 2022 10:53:26 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id i14-20020a0560001ace00b00203da1fa749sm1637841wry.72.2022.03.15.10.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 10:53:25 -0700 (PDT)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        robin.murphy@arm.com, will@kernel.org, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, steven.price@arm.com, Sami.Mujawar@arm.com,
        jon@solid-run.com, yangyicong@huawei.com
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <640df5d4-e2f6-aa24-6b60-9cfaf3915060@redhat.com>
Date:   Tue, 15 Mar 2022 18:53:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Shameer,
On 2/21/22 4:43 PM, Shameer Kolothum wrote:
> Hi,
>
> Since we now have an updated verion[0] of IORT spec(E.d) which
> addresses the memory attributes issues discussed here [1],
> this series now make use of it.
>
> The pull request for ACPICA E.d related changes are already
> raised and can be found here,
> https://github.com/acpica/acpica/pull/752
>
> v7 --> v8
>   - Patch #1 has temp definitions for RMR related changes till
>     the ACPICA header changes are part of kernel.
>   - No early parsing of RMR node info and is only parsed at the
>     time of use.
>   - Changes to the RMR get/put API format compared to the
>     previous version.
>   - Support for RMR descriptor shared by multiple stream IDs.
>
> Please take a look and let me know your thoughts.
>
> Thanks,
> Shameer
> [0] https://developer.arm.com/documentation/den0049/ed/
> [1] https://lore.kernel.org/linux-acpi/20210805160319.GB23085@lpieralisi/
>
> From old:
> We have faced issues with 3408iMR RAID controller cards which
> fail to boot when SMMU is enabled. This is because these
> controllers make use of host memory for various caching related
> purposes and when SMMU is enabled the iMR firmware fails to
> access these memory regions as there is no mapping for them.
> IORT RMR provides a way for UEFI to describe and report these
> memory regions so that the kernel can make a unity mapping for
> these in SMMU.
>
> Change History:
>
> v6 --> v7
>  -fix pointed out by Steve to the SMMUv2 SMR bypass install in patch #8.
>
> v5 --> v6
> - Addressed comments from Robin & Lorenzo.
>   : Moved iort_parse_rmr() to acpi_iort_init() from
>     iort_init_platform_devices().
>   : Removed use of struct iort_rmr_entry during the initial
>     parse. Using struct iommu_resv_region instead.
>   : Report RMR address alignment and overlap errors, but continue.
>   : Reworked arm_smmu_init_bypass_stes() (patch # 6).
> - Updated SMMUv2 bypass SMR code. Thanks to Jon N (patch #8).
> - Set IOMMU protection flags(IOMMU_CACHE, IOMMU_MMIO) based
>   on Type of RMR region. Suggested by Jon N.
>
> v4 --> v5
>  -Added a fw_data union to struct iommu_resv_region and removed
>   struct iommu_rmr (Based on comments from Joerg/Robin).
>  -Added iommu_put_rmrs() to release mem.
>  -Thanks to Steve for verifying on SMMUv2, but not added the Tested-by
>   yet because of the above changes.
>
> v3 -->v4
> -Included the SMMUv2 SMR bypass install changes suggested by
>  Steve(patch #7)
> -As per Robin's comments, RMR reserve implementation is now
>  more generic  (patch #8) and dropped v3 patches 8 and 10.
> -Rebase to 5.13-rc1
>
> RFC v2 --> v3
>  -Dropped RFC tag as the ACPICA header changes are now ready to be
>   part of 5.13[0]. But this series still has a dependency on that patch.
>  -Added IORT E.b related changes(node flags, _DSM function 5 checks for
>   PCIe).
>  -Changed RMR to stream id mapping from M:N to M:1 as per the spec and
>   discussion here[1].
>  -Last two patches add support for SMMUv2(Thanks to Jon Nettleton!)
>
> Jon Nettleton (1):
>   iommu/arm-smmu: Get associated RMR info and install bypass SMR
>
> Shameer Kolothum (10):
>   ACPI/IORT: Add temporary RMR node flag definitions
>   iommu: Introduce a union to struct iommu_resv_region
>   ACPI/IORT: Add helper functions to parse RMR nodes
>   iommu/dma: Introduce generic helper to retrieve RMR info
>   ACPI/IORT: Add a helper to retrieve RMR memory regions
>   iommu/arm-smmu-v3: Introduce strtab init helper
>   iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
>     bypass
>   iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
>   iommu/arm-smmu-v3: Reserve any RMR regions associated with a dev
>   iommu/arm-smmu: Reserve any RMR regions associated with a dev
fyi, the last 2 patches have conflicts with
[PATCH v4 9/9] iommu: Split struct iommu_ops
which was applied on core branch.

Thanks

Eric
>
>  drivers/acpi/arm64/iort.c                   | 305 ++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  91 ++++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  65 ++++-
>  drivers/iommu/dma-iommu.c                   |  25 ++
>  include/linux/acpi_iort.h                   |  14 +
>  include/linux/dma-iommu.h                   |  14 +
>  include/linux/iommu.h                       |   9 +
>  7 files changed, 504 insertions(+), 19 deletions(-)
>

