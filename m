Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0675ABE92
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Sep 2022 12:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiICKpm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Sep 2022 06:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiICKpm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Sep 2022 06:45:42 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121215AA09
        for <linux-acpi@vger.kernel.org>; Sat,  3 Sep 2022 03:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1662201937;
        bh=NpdQCn4KmvmvSGsHfe8yzzWa+Ld9oIfoQgHzoFTZQdk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XtVwm3DmdJIuAhl9nNhc+5P9Xd9cDGFUSX17CTClO14WWZv36RoG347rydVcAu1t4
         06QImuBntf1os11mm61CnnaFqr8qxhF5XmlBD9ir9qTR3gjfBN8wbLyTA0wAXc+OZ8
         dt29W3c69LGyIxOZFkw67Ie5ltchQxK79+9j8euE=
Received: from [IPv6:240e:358:1104:1500:dc73:854d:832e:4] (unknown [IPv6:240e:358:1104:1500:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 0861D667F7;
        Sat,  3 Sep 2022 06:45:30 -0400 (EDT)
Message-ID: <bf3e7516c351f793de08d5311aff10c379720798.camel@xry111.site>
Subject: Re: [PATCH 2/7] LoongArch: Enable LS2X RTC in loongson3_defconfig
From:   Xi Ruoyao <xry111@xry111.site>
To:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>
Date:   Sat, 03 Sep 2022 18:45:22 +0800
In-Reply-To: <6d01148014a62d8d412790dc8442af40368c6f8f.1662190009.git.zhoubinbin@loongson.cn>
References: <cover.1662190009.git.zhoubinbin@loongson.cn>
         <6d01148014a62d8d412790dc8442af40368c6f8f.1662190009.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 2022-09-03 at 17:34 +0800, Binbin Zhou wrote:
> This is now supported, enable for Loongson-3 systems.
> Other systems are unaffected.
>=20
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <git@xen0n.name>
> Cc: loongarch@lists.linux.dev
> ---
> =C2=A0arch/loongarch/configs/loongson3_defconfig | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/arch/loongarch/configs/loongson3_defconfig
> b/arch/loongarch/configs/loongson3_defconfig
> index 4083d3051109..b240bc4e2021 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -660,6 +660,7 @@ CONFIG_USB_GADGET=3Dy
> =C2=A0CONFIG_INFINIBAND=3Dm
> =C2=A0CONFIG_RTC_CLASS=3Dy
> =C2=A0CONFIG_RTC_DRV_EFI=3Dy
> +CONFIG_RTC_DRV_LS2X=3Dy

We already have RTC_DRV_EFI=3Dy, IIUC this means we leave LS7A RTC for the
firmware to drive and operate it through EFI service.  So is this really
needed for LoongArch systems?  And if we enable both RTC_DRV_EFI and
RTC_DRV_LS2X, will some bad thing (a conflict) happen?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
