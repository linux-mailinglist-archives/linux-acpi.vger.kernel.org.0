Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5C27080BC
	for <lists+linux-acpi@lfdr.de>; Thu, 18 May 2023 14:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjERMH6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 May 2023 08:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjERMH6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 May 2023 08:07:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA3611B;
        Thu, 18 May 2023 05:07:56 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QMTBc3F6czTkkS;
        Thu, 18 May 2023 20:03:04 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 20:07:53 +0800
Subject: Re: [PATCH 3/3] Documentation/arm64: Update ACPI tables from BBR
To:     Jose Marinho <jose.marinho@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        James Morse <James.Morse@arm.com>,
        Rob Herring <Rob.Herring@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
References: <20230518105202.451739-1-jose.marinho@arm.com>
 <20230518105202.451739-4-jose.marinho@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <0969894f-d653-482c-f043-2a085ee3b404@huawei.com>
Date:   Thu, 18 May 2023 20:07:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20230518105202.451739-4-jose.marinho@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jose,

On 2023/5/18 18:52, Jose Marinho wrote:
> The BBR specification requires (or conditionally requires) a set of ACPI
> tables for a proper working system.
> This commit updates:
> - the list of ACPI tables to reflect the contents of
> BBR version 2.0 (see https://developer.arm.com/documentation/den0044/g).
> - the list of ACPI tables in acpi_object_usage. This last update ensures
> that both files remain coherent.

Thanks for the update, some comments inline.

> 
> Signed-off-by: Jose Marinho <jose.marinho@arm.com>
> Reviewed-by: Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
> ---
>   Documentation/arm64/acpi_object_usage.rst | 81 +++++++++++++++++++++--
>   Documentation/arm64/arm-acpi.rst          | 71 +++++++++++++++++---
>   2 files changed, 139 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/arm64/acpi_object_usage.rst b/Documentation/arm64/acpi_object_usage.rst
> index 484ef9676653..1da22200fdf8 100644
> --- a/Documentation/arm64/acpi_object_usage.rst
> +++ b/Documentation/arm64/acpi_object_usage.rst
> @@ -17,16 +17,37 @@ For ACPI on arm64, tables also fall into the following categories:
>   
>          -  Recommended: BERT, EINJ, ERST, HEST, PCCT, SSDT
>   
> -       -  Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, IBFT,
> -          IORT, MCHI, MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT,
> -          STAO, TCPA, TPM2, UEFI, XENV
> +       -  Optional: AGDI, BGRT, CEDT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT,
> +          HMAT, IBFT, IORT, MCHI, MPAM, MPST, MSCT, NFIT, PMTT, PPTT, RASF, SBST,
> +          SDEI, SLIT, SPMI, SRAT, STAO, TCPA, TPM2, UEFI, XENV
>   
> -       -  Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IVRS, LPIT, MSDM, OEMx,
> -          PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
> +       -  Not supported: AEST, APMT, BOOT, DBGP, DMAR, ETDT, HPET, IVRS, LPIT,

AEST is ARM Error Source Table, and it can be used for ARM platforms, so
I thinsk AEST is not belong to "Not supportted", "Optional" instead.

and APMT is the same.

> +          MSDM, OEMx, PDTT, PSDT, RAS2, RSDT, SLIC, WAET, WDAT, WDRT, WPBT

PDTT and RAS2 are now used for ARM too, please move it to Optional :)

[...]

>   
>          **Software LIcensing table**
> diff --git a/Documentation/arm64/arm-acpi.rst b/Documentation/arm64/arm-acpi.rst
> index 01171b10828a..49a69a1cc463 100644
> --- a/Documentation/arm64/arm-acpi.rst
> +++ b/Documentation/arm64/arm-acpi.rst
> @@ -170,7 +170,7 @@ hardware reduced mode must be set to zero.
>   
>   For the ACPI core to operate properly, and in turn provide the information
>   the kernel needs to configure devices, it expects to find the following
> -tables (all section numbers refer to the ACPI 6.1 specification):
> +tables (all section numbers refer to the ACPI 6.5 specification):
>   
>       -  RSDP (Root System Description Pointer), section 5.2.5
>   
> @@ -185,20 +185,75 @@ tables (all section numbers refer to the ACPI 6.1 specification):
>   
>       -  GTDT (Generic Timer Description Table), section 5.2.24
>   
> +    -  PPTT (Processor Properties Topology Table), section 5.2.30
> +
> +    -  DBG2 (DeBuG port table 2), section 5.2.6, specifically Table 5-6.
> +
> +    -  APMT (Arm Performance Monitoring unit Table), section 5.2.6, specifically Table 5-6.
> +
> +    -  AGDI (Arm Generic diagnostic Dump and Reset Device Interface Table), section 5.2.6, specifically Table 5-6.
> +
>       -  If PCI is supported, the MCFG (Memory mapped ConFiGuration
> -       Table), section 5.2.6, specifically Table 5-31.
> +       Table), section 5.2.6, specifically Table 5-6.
>   
>       -  If booting without a console=<device> kernel parameter is
>          supported, the SPCR (Serial Port Console Redirection table),
> -       section 5.2.6, specifically Table 5-31.
> +       section 5.2.6, specifically Table 5-6.
>   
>       -  If necessary to describe the I/O topology, SMMUs and GIC ITSs,
>          the IORT (Input Output Remapping Table, section 5.2.6, specifically
> -       Table 5-31).
> +       Table 5-6).
> +
> +    -  If NUMA is supported, the following tables are required:
> +
> +       - SRAT (System Resource Affinity Table), section 5.2.16
> +
> +       - SLIT (System Locality distance Information Table), section 5.2.17
> +
> +       - HMAT (Heterogeneous Memory Attribute Table), section 5.2.28

HMAT is for heterogeneous memory, so it's optional if no heterogeneous
memory in the hardware.

> +
> +    -  If the ACPI Platform Error Interfaces are required, the following
> +       tables are required:

Maybe "are conditionally required" is better, as SDEI, AEST and RAS2 are
optional I think.

Thanks
Hanjun
