Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADF45ABF43
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Sep 2022 16:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiICOPx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Sep 2022 10:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiICOPv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Sep 2022 10:15:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB0546DAB;
        Sat,  3 Sep 2022 07:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C90BDB801BF;
        Sat,  3 Sep 2022 14:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810F9C433C1;
        Sat,  3 Sep 2022 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662214546;
        bh=/jP8MIyDHUYJ8U6z6dijSBnbvT/6bOxlL9l4q7SCjIE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vmg6+/RGxAjjT8tBBM2A/0QujfJq9FLMt6fdyGlWDkUWHYVkpG7LwVZ8QHehi6LoP
         aTS/O3tzmjDp3TbqSfODHJWhpjrdAncizb/LVOB5DMHp52EfecJ+jNX8URczcjdw9L
         uzHjoVdR5AV0IJMyRmOlrVPDSw+YgdEqSdFUs3FI2Y4FK+nCyK3Sb7DGRGF5GVdK3M
         pRS+tGuCo0ai6ht/ZmNIQ2lkmayyG4DLFHN4zw8G0+ghGUp7ffxLPYF/wc+hZh/ocf
         qLQ7iK+Kb6hP6hG5BKI5d7LOZ6g+UN8iAsmATZkhyzcO0sAmHIr+MClg6pIo6fb2uQ
         b1cryDuUhoM+Q==
Received: by mail-vs1-f54.google.com with SMTP id d126so4725720vsd.13;
        Sat, 03 Sep 2022 07:15:46 -0700 (PDT)
X-Gm-Message-State: ACgBeo3ikny5BXX32+9BCbT6Aer112TJRrPqlNotxilqVNbVlyC8g1e+
        vrrGcEDSgBvkq1w9VNvEj5fmNuTdGH8XpNWiNcc=
X-Google-Smtp-Source: AA6agR4Mm5CDbSVzGUuU9Le1jrraNppoFx9hZxmyR0Mx07jBrk3YAqwYjgTaCXwombY3RjovNF6IxEXvdbwQRT1wnl0=
X-Received: by 2002:a05:6102:390d:b0:387:78b9:bf9c with SMTP id
 e13-20020a056102390d00b0038778b9bf9cmr12500187vsu.43.1662214545467; Sat, 03
 Sep 2022 07:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662190009.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1662190009.git.zhoubinbin@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 3 Sep 2022 22:15:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5+7_o1znvnOdbASwxL09NxSr6vAFpiZZC16DHGtt5f9w@mail.gmail.com>
Message-ID: <CAAhV-H5+7_o1znvnOdbASwxL09NxSr6vAFpiZZC16DHGtt5f9w@mail.gmail.com>
Subject: Re: [PATCH 0/7] rtc: ls2x: Add support for the Loongson-2K/LS7A RTC
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        devicetree@vger.kernel.org, loongarch@lists.linux.dev,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Qing Zhang <zhangqing@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Binbin,

On Sat, Sep 3, 2022 at 5:35 PM Binbin Zhou <zhoubinbin@loongson.cn> wrote:
>
> Hi all:
>
> The initial DT-base ls2x rtc driver was written by Wang Xuerui, he has
> released five versions of patchset before, and all related mail records
> are shown below if you are interested:
>
> https://lore.kernel.org/all/?q=ls2x-rtc
>
> In this series of patches, based on the code above, I have added the
> following support:
>
> 1. Add ACPI-related support, as Loongson-3 + LS7A is now ACPI-base
>    by default on LoonArch;
> 2. Add rtc alarm/walarm related functions.
>
> Unfortunately, I have only tested the Loongson-3A4000+LS7A1000/LS7A2000
> under LoongArch architecture.
I think Loongson-3A4000 should be Loongson-3A5000 here. And I think
Qing Zhang can help us to test on Loongson-2K platform.

Huacai
>
> NOTE:
> The related functions of rtc alarm/walarm depend on ACPI registers, so rtc
> alarm may not be available on the DT-base environment. Such as Loongson-2k/3
> under MIPS.
>
> Thanks.
>
> Binbin Zhou (2):
>   rtc: ls2x: Add support for the Loongson-2K/LS7A RTC
>   LoongArch: Enable LS2X RTC in loongson3_defconfig
>
> WANG Xuerui (5):
>   dt-bindings: rtc: Add bindings for LS2X RTC
>   MIPS: Loongson64: DTS: Add RTC support to LS7A
>   MIPS: Loongson: Enable LS2X RTC in loongson3_defconfig
>   MIPS: Loongson64: DTS: Add RTC support to Loongson-2K
>   MIPS: Loongson: Enable LS2X RTC in loongson2k_defconfig
>
>  .../devicetree/bindings/rtc/trivial-rtc.yaml  |   2 +
>  arch/loongarch/configs/loongson3_defconfig    |   1 +
>  .../boot/dts/loongson/loongson64-2k1000.dtsi  |   5 +
>  arch/mips/boot/dts/loongson/ls7a-pch.dtsi     |   5 +
>  arch/mips/configs/loongson2k_defconfig        |   1 +
>  arch/mips/configs/loongson3_defconfig         |   1 +
>  drivers/rtc/Kconfig                           |  11 +
>  drivers/rtc/Makefile                          |   1 +
>  drivers/rtc/rtc-ls2x.c                        | 366 ++++++++++++++++++
>  9 files changed, 393 insertions(+)
>  create mode 100644 drivers/rtc/rtc-ls2x.c
>
> --
> 2.31.1
>
>
