Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F4D737CD2
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jun 2023 10:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjFUIEb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Jun 2023 04:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjFUIEa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Jun 2023 04:04:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC06170C
        for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2023 01:04:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f9bece8e19so4826425e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2023 01:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687334667; x=1689926667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bdr99ZnsFuaWd7+2tODjIdBaqRk40Wcx2mkyWMKgAl8=;
        b=lFls4G02TYGejcUGf7F2yKuKiyQwm27IZuxaz7ZicOiWbynZJ6m8AknpkLLU8fsxVN
         UFw6M408EmOALQQy3AxLMbgC5k695jz6oQz43eDNvkqg7v+wHHF7ZJyMrPC26sFbVV3i
         zv2gAmHagzux42h5Nhh/OYbvsQr3BNOI/eVgE/44pMs5ZWM3fnDUoUjrmWVEBeOuWVLE
         7JOlsXCv7JWgaBTeGNmukewQHRsVfkX1AOuu7MNeDx2uMOi+S33HLzsYpGN5dgxuYNVC
         or6qB9a2VI+sLmCxPycuQgSmE/i2/qMrOa7ilqnBYYWrcJlUqBajh18WU8fTmJbGu68s
         4iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687334667; x=1689926667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bdr99ZnsFuaWd7+2tODjIdBaqRk40Wcx2mkyWMKgAl8=;
        b=cesj1M22r7E1Pax4ghiUQRpWzqoX+fHle3Mmph4wRgb+al6yqGQxVL9MbnMkJ2vE72
         o0W2YA4kkJX+oWJ3bZHaBszzKiiZBVpaEoA12RULxAQmSaE4WtZYU43dEvdVnswVZ58Z
         netM64PUjLxglYAK9vfdqtw782s/3OUNtxmtfVhXD6+7ACq/Tj85+3FtWntEV8r7Cm4J
         +DMzOND+WNpWbft9Ho2UiSiF7P6+QKnr1REb2Kqum0t8TeR8AOSmuEIqA8Lc2oR3vFwl
         48N4xVDlkfx4OY3Bqit4HDJw/LCsnjTLdGoZZYxb6OihB875Vx39k4LwU/TVbFI7VxWw
         m6jA==
X-Gm-Message-State: AC+VfDxz8fUVGfey167Au5xtv2yNGkZrFiFKpHApFfkGpiSuOrjFap02
        mCsO1Wy1k4JsbNDkR4VGC/GqOClVsX/0aYlwowvEFg==
X-Google-Smtp-Source: ACHHUZ44Io9K//QUtZqsJ0miupjsyJM4Vmg0fqFUuIr/d5lcyjwwOt9RCqOVmeYyxELVEltNdPnj/LtaG/39Zo3R434=
X-Received: by 2002:a7b:ca4e:0:b0:3f9:c00:51d3 with SMTP id
 m14-20020a7bca4e000000b003f90c0051d3mr9855397wml.13.1687334667559; Wed, 21
 Jun 2023 01:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com> <CAP6exY+tqAU0j1TVEMTzTb18M6_mPH5bWWiAS=94gyDGTY3hyQ@mail.gmail.com>
In-Reply-To: <CAP6exY+tqAU0j1TVEMTzTb18M6_mPH5bWWiAS=94gyDGTY3hyQ@mail.gmail.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Wed, 21 Jun 2023 16:04:15 +0800
Message-ID: <CAEEQ3w=wBdpZWnUd2WWVBC3BtFiUp-PQtNAtdXE4cO4n0XT-fg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     ron minnich <rminnich@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks for Ron's suggestions.

Hi Ard,  Mark,
>
> Is there some feeling here that it would be ok to restrict this discussion to risc-v, and not bring in ARM considerations.  WDYT?
>

Hi Ard,  Mark,

Now the coreboot we are using does not support EFI and only supports
one interface DTB. It seems that we have to pass the firmware
information through DTB.

From another point of view, ACPI and SMBIOS are common modules of the
kernel, not only EFI, but also other interfaces can also be connected
to this module, such as 0xF0000 for SMBIOS,
CONFIG_ACPI_LEGACY_TABLES_LOOKUP for ACPI,  this patch is also.

We just use the DTB channel to add a few nodes to complete the
transfer of firmware information, which does not interfere with DTS
itself.

We think it is unnecessary to add an ACPI-supporting framework under
the fdt framework we discussed before. We only need one set of ACPI
framework, but one more set will cause unnecessary trouble.

So, let's move on to this patch, shall we?



Thanks,
Yunhui
