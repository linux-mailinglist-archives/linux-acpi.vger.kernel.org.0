Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13568525674
	for <lists+linux-acpi@lfdr.de>; Thu, 12 May 2022 22:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358404AbiELUjH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 May 2022 16:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358386AbiELUjG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 May 2022 16:39:06 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C5D562E1
        for <linux-acpi@vger.kernel.org>; Thu, 12 May 2022 13:39:05 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id j2so12024143ybu.0
        for <linux-acpi@vger.kernel.org>; Thu, 12 May 2022 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TT4lL4nJPIlrm8rD9ghU4YRsH+JtLY+APGdrNigMTDc=;
        b=rIE5OTkU3kdGVZ4x0jGH5zzCzbD9+DQSiGdo2MzIA58gs9L5KEk92YqQ6BF2GB/mXE
         R0pqfpz01HPr+8ClwNkIQZxTVI0lVRGEUGlHCpEKWjHMiZA1eVAYHstP7YVetzMnrbPh
         Rvi0h9NTn0xXFyTIqrukBaLpmXsoeNfU1r6EtypgrU4YRrshBc2cTnRVpV9L0N2uOZDm
         RisEsGpw3aBR7OXmHpi4BDqZpLjAWXYwuqa7K11/5LAkFxjMHaIO6SjBvJeWnO3WOT8w
         x2oMM5J8OySWseUj+rs+S6DWY0gOFmson02qASbkLDVqLTJ6eC/gUieEAxJLOi2ASxRt
         siQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TT4lL4nJPIlrm8rD9ghU4YRsH+JtLY+APGdrNigMTDc=;
        b=hijtHZYTfgLQiulcjgcHJW2vklp7QK+ycrC7jq0CMsHh8/ktuG6950GpGBaIrqE1mD
         eE6OI2k8ABj9Tkq85y+cagl/L0j0zwOBUcn8gPpKZWuseeGHel8Ws9WmwjzlOJxaRZiR
         oe/uy1fTH3I807CJsUhnDgzhBQ06R6VPIn2HZi6F3raPYAVKP67BJNvRCN20kIZ1rAtx
         njRSj5CNQoXcaP9xxXI+nEOotSI/xYXydYgIJIMGT85XyX2SMieelehmfihOfWgMRyLR
         dfy9VN6gqY2RAR2w2p8X7USdmJ9wtfidMpszM0Zy+BXsbM+7wG8e3tG1XE9QWRV7YZ8/
         bU8w==
X-Gm-Message-State: AOAM532xHasOmxE0vVubHyo0ZLk3aY6ckTrF69frcppNuiMKoc6AapQ2
        /3upYY3sFA9m6o9pLvPSy9b89HKEK5C7aiU/DxE2IPfJ/IaPETRz
X-Google-Smtp-Source: ABdhPJwDlLDazzf5DdzLJ+nYe6bQMnz68H7QQnKp7vIEP6LxcS3BpSGoaEwkxHsjrhsCFuMry95CLi9sjmSO+ZpwZw4=
X-Received: by 2002:a25:aa94:0:b0:648:62f2:ef4e with SMTP id
 t20-20020a25aa94000000b0064862f2ef4emr1559414ybi.626.1652387944764; Thu, 12
 May 2022 13:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220418141416.27529-1-asmaa@nvidia.com> <CH2PR12MB3895A1FB2977B725ED92AB57D7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdY1uK=73zpEM5zUyXacm5xaUUFYkuKMxi_q6vwmOPy6tw@mail.gmail.com> <CH2PR12MB389560A1873030472A7A371DD7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB389560A1873030472A7A371DD7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 May 2022 22:38:52 +0200
Message-ID: <CACRpkdZhW9XK3opXLLzdMiVLVkGQyJCf7RLZtRQLsmzv-aqwbA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Add driver for Mellanox BlueField-3 GPIO controller
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 5, 2022 at 7:01 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:

>> Why isn't FW_CONTROL_CLEAR/SET used when making  a line into an output?
>> Seems unsymmetric? At least put a comment in the code why this is different from
>> making a line into input.
>
> Ok I will add a comment.
>
> All GPIOs are always controlled by HW by default.
> FW_CONTROL_SET is used when we want to release
> control of the GPIO by HW and give the control to
> software instead.

What does that mean in practice? What way does hardware
control a GPIO?

It's not some way of remuxing the pins is it, so you what you
are calling "controlled by hardware" is actually that it is
controlled by e.g. I2C and other stuff that may be muxed in?

Yours,
Linus Walleij
