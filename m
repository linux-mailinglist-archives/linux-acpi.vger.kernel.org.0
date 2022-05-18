Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAC652BCF8
	for <lists+linux-acpi@lfdr.de>; Wed, 18 May 2022 16:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiERNvn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 May 2022 09:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238246AbiERNvk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2022 09:51:40 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CD719CEEB
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2022 06:51:39 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2fed823dd32so24746877b3.12
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2022 06:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ezkF+KufCRulaATTf+tA3i0YmPN8Lg/E/OJ5KWGLi9s=;
        b=uGNd03MI81VqlOTp83UbNvG7RNsf4JwdkIUpBemFFroQN/ghPDZN15hQVkSIUo9Y+m
         RFdhHMVM5nbW1OSRcv2fiztcN2rNCYuW03ZVkrmJl3jMIZO9FdAyBMJt7AigMbN9Lyb4
         bL2Mmh06bmrMQ2Pss2J1tW+AgVMFOU8a0pcQccwayaDXEYxlvL4+rUohNDiH2hG62G4R
         vyRU9BoSvX4w5wx6gy6MzyofxQ0LHJ1cbBgRXfxdVHe/wQkybembQwu/7B4cQViqMdsm
         3z+3FMMPKNU0mcLT9JPS4HItaf9sbLRk+z8Rqur7f//JbGqsugsLG2+2Pb6syuJ/NKyU
         cguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezkF+KufCRulaATTf+tA3i0YmPN8Lg/E/OJ5KWGLi9s=;
        b=l6hDGptjDI8ICEFDBUBvLTmkcQyn5KDd6REdJNx4/7WEmeWLzN2R8wU0LfN17Mjmb5
         IH8sHCh+K8fZ4TsX5HkKJabSwQJAUgU+Dg8BdMsf+CZ0BbV/ziycb0H+uw2FCcuzRKfZ
         hyrN5xEq/HCvsv05SNgxQqrkkT6JG5B4I65eQS0Y5UPyrRXYHw4QTntt+m7G0OQcvYjG
         Uj9wSctSTv456M4IKM2RQRrYpDcxrxop1ezL3TPxbFUO2jeLFGlSyozxZmfJrkY4wHbW
         s9QpOBbT2KCdSUnTHmOB44M7jP098jspyo6XkXZqOZ/Non+dHKykVwprYsXuacbnskb6
         00Vw==
X-Gm-Message-State: AOAM532CJVyckEqQ9ZsRZ7yctw+KBjSO6wuhyjq+DTxE2W5y+Smmtomi
        XLmPnwyn9F0gzG63Dz1Kv1yskSnvCAUe4Wl6/vAIjg==
X-Google-Smtp-Source: ABdhPJxpHy6dIs00LRXeGNRMgX921VLukf4liJgNBcyAdsNr2nvvmrO+nqIa6p9eJAUAaA5lDN2SqFDUk598KuThmrQ=
X-Received: by 2002:a81:2154:0:b0:2f4:d79e:35dc with SMTP id
 h81-20020a812154000000b002f4d79e35dcmr31816444ywh.126.1652881898898; Wed, 18
 May 2022 06:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220418141416.27529-1-asmaa@nvidia.com> <CH2PR12MB3895A1FB2977B725ED92AB57D7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdY1uK=73zpEM5zUyXacm5xaUUFYkuKMxi_q6vwmOPy6tw@mail.gmail.com>
 <CH2PR12MB389560A1873030472A7A371DD7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdZhW9XK3opXLLzdMiVLVkGQyJCf7RLZtRQLsmzv-aqwbA@mail.gmail.com>
 <CH2PR12MB38953FF57D91FA75AB9CB102D7CB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdbAhMa2CXvQra3E13n8WfiBxyHNqzEp4dW3qo5upr_=gw@mail.gmail.com> <CH2PR12MB38958CD365876A2106712C3CD7CF9@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB38958CD365876A2106712C3CD7CF9@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 May 2022 15:51:27 +0200
Message-ID: <CACRpkdZp9hx2SHxsmjBm2oj7m3UT-4S+MKw5qqNME0PLjPNV2A@mail.gmail.com>
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

On Mon, May 16, 2022 at 3:00 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:

> So these GPIO pins are assigned one specific HW functionality on the boards
>  and software should never change them.
>
> By default, for security purposes, I think we shouldn't let the user have the option
> to control the GPIO pins since they have a specific HW functionality.
>
> But for bringup/debug purposes, we would like to support the option of software
> being able to change these pin values. We also might have customers that choose
> to change the default HW connection of a certain GPIO pin and connect it to
> control their LEDs for instance.

The fact that the usecase is bringup/debug does not mean we cut
corners and do "quick fixes". The proper APIs have to be implemented,
the alternative is to not submit the driver at all.

What I hear is that these pins have two modes:

1. Used for a device (I2C etc)
2. Used as GPIO by setting a bit in YU_GPIO_FW_CONTROL_SET

This is two pin control multiplexing states already.

So this should have a simple pin control driver as back-end with
the GPIO as front end. A shortcut to enabling pins into GPIO
mode can be provided using .gpio_request_enable() from
struct pinmux_ops.

Please refer to
https://docs.kernel.org/driver-api/pin-control.html

I know this means more work and is kind of complex. But drivers/pinctrl
has a lot of examples you can follow, for example
drivers/pinctrl/pinctrl-sx150x.c and other simple multipurpose
chips.

Yours,
Linus Walleij
