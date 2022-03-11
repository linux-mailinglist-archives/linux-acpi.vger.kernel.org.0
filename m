Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A44B4D5D03
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Mar 2022 09:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240944AbiCKIHr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Mar 2022 03:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347359AbiCKIHq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Mar 2022 03:07:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD23E1B8BE4
        for <linux-acpi@vger.kernel.org>; Fri, 11 Mar 2022 00:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646986002;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vgP2Kr6cQT3iIV3nMtr5LhvA/+AXCJWjko3NF+tsE8k=;
        b=c4AtF5KXADrR06AifIeck0xWgaKw3/Yrr+oVrgETsMW/MYbLFc40xYGN556jdmXwEd+oOA
        WrnS/1DhPvm/UbgigfAuogRnwIp134IB5okPEWuEBgxzof+fp61Knmh0m+5twO50ADfp75
        nydZS0J2Z4CZzDKtAnd/T25BqRi84CI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-dltDu4JzP-uUD_ldiFIP_A-1; Fri, 11 Mar 2022 03:06:41 -0500
X-MC-Unique: dltDu4JzP-uUD_ldiFIP_A-1
Received: by mail-wr1-f69.google.com with SMTP id w17-20020adfec51000000b001f068bc3342so2524092wrn.6
        for <linux-acpi@vger.kernel.org>; Fri, 11 Mar 2022 00:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=vgP2Kr6cQT3iIV3nMtr5LhvA/+AXCJWjko3NF+tsE8k=;
        b=MHooqXUTEUpK0Ana18fZWBGOZ1lBZ3VStSsgRaA+NvTdUvVmyGineYSOm0A5mLwdF7
         ag9rSoyJr9nCZCx39ESQTulHV3hwDwNscYTQIUzbGV/+DIYzmypnC5/u1EVlubzxvAE7
         tuoZtWrl5an6UF4XYHo91HqNHSgR1hej3fyMnhiPh9Q69jVe0R/JlO9hacGhvF2WWU+2
         h1J5IinPxe1umid7D8PmMbckwJVA62VdVK03aURV88d0SUqOoZz3IfqCFvG4hLX2/dzw
         QK+wTqnbVg8RIpnTES6xav/OH6t0AsnuPW8WwosNoDIDaN80x+C0Q7eN7xiWAiTAnQAY
         qfHw==
X-Gm-Message-State: AOAM533ufEaymo/ELYOWFdYfkR7/b378UJXQRIAFqGTLMx/M3ktIv+Sk
        rY8/sO4XOnIkOEkI2ZjO7v4J0gxDAmDgBwHtUGrWewFuUs0JtnXSEDO5VGeLAzMqRZxI6Xtvsjm
        ORY/5zukbYm/NDwhlbBK7rQ==
X-Received: by 2002:adf:ed0c:0:b0:1f0:63a5:36aa with SMTP id a12-20020adfed0c000000b001f063a536aamr6305558wro.588.1646986000398;
        Fri, 11 Mar 2022 00:06:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2Vm6KkbbdN49P08cPdti6Bocnw762oiUUP6ZqnjAq5tnsFyAkAMa6xeqMtfYWEzcvFxaUkQ==
X-Received: by 2002:adf:ed0c:0:b0:1f0:63a5:36aa with SMTP id a12-20020adfed0c000000b001f063a536aamr6305537wro.588.1646986000119;
        Fri, 11 Mar 2022 00:06:40 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id e20-20020adfa454000000b001f01a14dce8sm6107441wra.97.2022.03.11.00.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 00:06:39 -0800 (PST)
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
Message-ID: <0f9634c1-8401-7814-7783-c1c042e8fb42@redhat.com>
Date:   Fri, 11 Mar 2022 09:06:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

I tested it on guest side for host MSI SW RESV region flat mapping
(using both the old single mapping layout and the now allowed multiple
RID ID mapping format) and this worked for me. Feel free to add my

Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


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

