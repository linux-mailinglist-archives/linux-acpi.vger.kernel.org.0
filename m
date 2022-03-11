Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BF44D5D24
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Mar 2022 09:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiCKIUY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Mar 2022 03:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiCKIUX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Mar 2022 03:20:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 089301B3A5D
        for <linux-acpi@vger.kernel.org>; Fri, 11 Mar 2022 00:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646986758;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8AGBOXeSleA1IuyfT69wuJp+6zvr7dHRVBmDnVZmB7g=;
        b=K+EcTfwga8QTg9QUCI1Jbadz4Xi4u4xIM0Wio2dFM++H4fGDiq3GTodBI6D+6wrKqftDuA
        ep8h7obMVtWUQMBTq934aP1p31dXi4DNhIFjOE21GtD0xXeLkcBocsGwKB7XagbRkt4TJq
        9OXEoGFettPKJ5LHpLcBYUyWppgiB6A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-d05VuiUHNzOwCy1UZx2rIA-1; Fri, 11 Mar 2022 03:19:17 -0500
X-MC-Unique: d05VuiUHNzOwCy1UZx2rIA-1
Received: by mail-wr1-f71.google.com with SMTP id l10-20020a05600012ca00b001f1e4669c98so2517494wrx.23
        for <linux-acpi@vger.kernel.org>; Fri, 11 Mar 2022 00:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=8AGBOXeSleA1IuyfT69wuJp+6zvr7dHRVBmDnVZmB7g=;
        b=x3b+MlAWbPFYYeNVOeW6z/Dy1YmhSSclUeAs06w8Kwd3cyeDTIsdR4AU15YR1oGhKG
         gRYqHurYygqZ1NTbjFNMNv+vcwd37jPCyR3lzAUB+6aHETUf3HONKNnXn6h/HAWzsk2d
         ktXXUQDpToEc0GU6Y/fnwYwxapKNsIMjn6PvDwG2Otfb/U7TXm2wqvs3gDrN5OzrhY6T
         hNsMh58lTmLDsA+Bd5ZYV084mMBdhdZLYaeua1f+scEW9KwAB3EwHmw3Rls0YyecIXpD
         VDsksV+A1KyjpRnL+1/s3pmzx4JWTNiVUH+9Bvb+aF2pLHUxCxye0AauieSCihVXVAc1
         7YnQ==
X-Gm-Message-State: AOAM5313BP/y5qT/Jkjn6OISVTC8GwS0yEk9UTAUiNIStX5p/U8sMsju
        l2ZMwZAYow0CK8dIzcapldx4PLtOioibdKa7n+k2DXYxjdgNHyESAk+ZY8mPa+U4ccX9C824eXk
        QxWABJaFFPYCW5CKFp81X5Q==
X-Received: by 2002:a5d:58d3:0:b0:1f1:dfb1:ab63 with SMTP id o19-20020a5d58d3000000b001f1dfb1ab63mr6559776wrf.326.1646986756034;
        Fri, 11 Mar 2022 00:19:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwerKE4N1pKS+KaYDddjpq12y53SjIesUYPI8D5gzCRx+rCUaQVVVwdH//6D1UiLOzeAFP89w==
X-Received: by 2002:a5d:58d3:0:b0:1f1:dfb1:ab63 with SMTP id o19-20020a5d58d3000000b001f1dfb1ab63mr6559718wrf.326.1646986755349;
        Fri, 11 Mar 2022 00:19:15 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c4f8f00b003842f011bc5sm10353512wmq.2.2022.03.11.00.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 00:19:14 -0800 (PST)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        robin.murphy@arm.com, will@kernel.org, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, steven.price@arm.com, Sami.Mujawar@arm.com,
        jon@solid-run.com, yangyicong@huawei.com
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <bb3688c7-8f42-039e-e22f-6529078da97d@redhat.com>
Date:   Fri, 11 Mar 2022 09:19:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi guys,

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
I still have a question on the IORT E.d spec (unrelated to this series).

The spec mandates that if RMR nodes are presented in the IORT,
_DSM function #5 for the PCIe host bridge ACPI device object must return
0, indicating the OS must honour the PCI config that the FW computed at
boot time.

However implementing this _DSM #5 as above is known to prevent PCI
devices with IO ports from working, on aarch64 linux.

"
The reason is that EFI creates I/O port mappings below
    0x1000 (in fact, at 0). However Linux, for legacy reasons, does not
    support I/O ports <= 0x1000 on PCI, so the I/O assignment created by EFI
    is rejected.
   
    EFI creates the mappings primarily for itself, and up until DSM #5
    started to be enforced, all PCI resource allocations that existed at
    boot were ignored by Linux and recreated from scratch.
"

This is an excerpt of a qemu commit message that reverted the _DMS #5
change (Revert "acpi/gpex: Inform os to keep firmware resource map").
Has the situation changed since July 2021 (ie. has UEFI been reworked?).
[+ Ard]

Thank you in advance

Regards

Eric




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

