Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C27D5ABF4C
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Sep 2022 16:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiICOUP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Sep 2022 10:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiICOUO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Sep 2022 10:20:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EAA52FD9;
        Sat,  3 Sep 2022 07:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2A17B80966;
        Sat,  3 Sep 2022 14:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E69C43470;
        Sat,  3 Sep 2022 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662214810;
        bh=0aD+VSuyqXxSIVEFulDlAaMzWs8mG1JCiPYrFvQbHqk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nXtwWlB287xOlDtpAHhVfl9tPu1xM3cR2NWG5pr9+m3HgOkV32Ou69hgAeGG7anmP
         9vgQpEnwRDQdGij523rA5e3A6+g6VWHQfONrCeiZBbg8sCWW719hUzFtWf/E7+ICPh
         YbGrLEsasbuQNEZc2LTc1tjCKOoyVSsGh10qw0qvvZk65xVoGL6WQofHN9cV3PXKXf
         h9R2KOJKUHBiCOfc9twQPCvhHq5RWxVCGQ/rSJrJ9Xvrv667EDXCdteNQRwhnHqmDq
         rXPZk0LklN7vT1GjywGscy8ifC+1ThJlqEGxLoum+VF06pyrsf84aszxg5mAly9Y/J
         q/QWXeq+oz3og==
Received: by mail-vk1-f172.google.com with SMTP id c2so2240942vkm.9;
        Sat, 03 Sep 2022 07:20:10 -0700 (PDT)
X-Gm-Message-State: ACgBeo3SXKi3/Qvvt1kXEmBWO1MaL+GKh//Fx/4BZ8q73eSGNe2OdQRw
        GUa3Gl9eDtwnmtjD87c+ArY4v7gAyGkHkiPPs0w=
X-Google-Smtp-Source: AA6agR4DjVYs1Z7O7YPPXaanoHXU3FRdvt+fv4WSmMa7CoMVispaaGhUAL5QcuLgVa9t520FJ2ydXbrkcTwKD8AFeaQ=
X-Received: by 2002:ac5:cd82:0:b0:397:7f8d:95f7 with SMTP id
 i2-20020ac5cd82000000b003977f8d95f7mr2019923vka.18.1662214809526; Sat, 03 Sep
 2022 07:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662190009.git.zhoubinbin@loongson.cn> <6d01148014a62d8d412790dc8442af40368c6f8f.1662190009.git.zhoubinbin@loongson.cn>
 <bf3e7516c351f793de08d5311aff10c379720798.camel@xry111.site>
In-Reply-To: <bf3e7516c351f793de08d5311aff10c379720798.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 3 Sep 2022 22:19:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4QXyaK+H-vMsDgXY+9J1FONKzEi-fm37J9NOr0n+tqOg@mail.gmail.com>
Message-ID: <CAAhV-H4QXyaK+H-vMsDgXY+9J1FONKzEi-fm37J9NOr0n+tqOg@mail.gmail.com>
Subject: Re: [PATCH 2/7] LoongArch: Enable LS2X RTC in loongson3_defconfig
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        devicetree@vger.kernel.org, loongarch@lists.linux.dev,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        WANG Xuerui <git@xen0n.name>
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

Hi, Ruoyao,

On Sat, Sep 3, 2022 at 6:45 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Sat, 2022-09-03 at 17:34 +0800, Binbin Zhou wrote:
> > This is now supported, enable for Loongson-3 systems.
> > Other systems are unaffected.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > Cc: Huacai Chen <chenhuacai@kernel.org>
> > Cc: WANG Xuerui <git@xen0n.name>
> > Cc: loongarch@lists.linux.dev
> > ---
> >  arch/loongarch/configs/loongson3_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/loongarch/configs/loongson3_defconfig
> > b/arch/loongarch/configs/loongson3_defconfig
> > index 4083d3051109..b240bc4e2021 100644
> > --- a/arch/loongarch/configs/loongson3_defconfig
> > +++ b/arch/loongarch/configs/loongson3_defconfig
> > @@ -660,6 +660,7 @@ CONFIG_USB_GADGET=y
> >  CONFIG_INFINIBAND=m
> >  CONFIG_RTC_CLASS=y
> >  CONFIG_RTC_DRV_EFI=y
> > +CONFIG_RTC_DRV_LS2X=y
>
> We already have RTC_DRV_EFI=y, IIUC this means we leave LS7A RTC for the
> firmware to drive and operate it through EFI service.  So is this really
> needed for LoongArch systems?  And if we enable both RTC_DRV_EFI and
> RTC_DRV_LS2X, will some bad thing (a conflict) happen?
Don't worry, please. EFI RTC depends on EFI runtime, so we need an
available RTC if EFI runtime is disabled (by command line or any other
reasons). On the other hand, multi RTCs can perfectly co-exist, they
will be rtc0 and rtc1 under sysfs and rtc0 is the default one.

Huacai
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>
