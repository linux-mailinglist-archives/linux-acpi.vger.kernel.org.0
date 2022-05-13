Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A99C526BFE
	for <lists+linux-acpi@lfdr.de>; Fri, 13 May 2022 22:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384385AbiEMU6R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 May 2022 16:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376690AbiEMU6Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 May 2022 16:58:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BAB36E1F
        for <linux-acpi@vger.kernel.org>; Fri, 13 May 2022 13:58:16 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e12so17244515ybc.11
        for <linux-acpi@vger.kernel.org>; Fri, 13 May 2022 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxwjdHb6GEM+MgL/h9hAhwGzHrI9ED16/yD6d7+q8kA=;
        b=AJ3MMUdAsy2KYM6tgO45ka5ahx9U/xhqfbNZjeeHg3jIAt/iBzi8WLflrczDE4+PII
         OoYT6T73obpj++O0t4+GGkV+321SwZ4zBrYCw0mW1JstsxDHi6JyA57YnjPPAZKTLUXr
         1Hzp41aUGjG1RW5GjHCX6zW6Ip+wSXpX0eW3nUDv4KW3wgO4hIdV652ECemIk5sXRfEf
         wPUllUJgx53nIgqWg8f6lsljBHYBcxiE18NPSsj5b+cNcMFzqodss+l6ei48I6z91ign
         vup4RjkNfem4VLELvD38b9MziK8rFFm1lERIPwCkQ3L5Xr2zWMYwSPHWzKgLey0SL3L5
         b0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxwjdHb6GEM+MgL/h9hAhwGzHrI9ED16/yD6d7+q8kA=;
        b=dpzlyldalemVQibBRy4w1SkGdcu4ymYRg1KMTBRErfo4f9XZQq3HVhh/CJ3+68U1ye
         wjnsKVLXT73B192+uGdUNFRwmYd0cGkbghi8CDsMCnr1HGSwH/z89LrClt2To03g+gIu
         46jB0ACFR6Uq757jYJfGUftLP2LFq7c11jMkHTJ+CB1GHCphNuTDzAg/xtyiRsq9Ce0M
         43yBlO8N3zYhDvhwJmaYboILfIqo3zdc2/TQ429KHn4ohUNQg4mzOHzI2NLebHRYDFJ3
         u2ZDLsJTPu7HkgLcU1fSiXRj4nCRkVIsLZF2Pv3J5anqffvdSdKK/W+e8u63C0GCwrgc
         J14g==
X-Gm-Message-State: AOAM531pNLNes0spvCCL87A1L4w1E9iWZu4OckZmgCRgxcg6WAnZSTWW
        Qo4ow2yrxtTNboLoEiUbfWoaZ6+3tuSIqDwoEdbdWA==
X-Google-Smtp-Source: ABdhPJyHjpfKqAU2CtfRT/4oUKgGz53TWH1vkCd306prnkDRzhu+I/QTvLdJ0kqhCkoyvyNqCpTxaev682mnkvqkIu0=
X-Received: by 2002:a25:bcc3:0:b0:648:7360:8e75 with SMTP id
 l3-20020a25bcc3000000b0064873608e75mr6796741ybm.533.1652475495308; Fri, 13
 May 2022 13:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220418141416.27529-1-asmaa@nvidia.com> <CH2PR12MB3895A1FB2977B725ED92AB57D7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdY1uK=73zpEM5zUyXacm5xaUUFYkuKMxi_q6vwmOPy6tw@mail.gmail.com>
 <CH2PR12MB389560A1873030472A7A371DD7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdZhW9XK3opXLLzdMiVLVkGQyJCf7RLZtRQLsmzv-aqwbA@mail.gmail.com> <CH2PR12MB38953FF57D91FA75AB9CB102D7CB9@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB38953FF57D91FA75AB9CB102D7CB9@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 May 2022 22:58:03 +0200
Message-ID: <CACRpkdbAhMa2CXvQra3E13n8WfiBxyHNqzEp4dW3qo5upr_=gw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Add driver for Mellanox BlueField-3 GPIO controller
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 12, 2022 at 10:45 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:

>> > All GPIOs are always controlled by HW by default.
>> > FW_CONTROL_SET is used when we want to release control of the GPIO by
>> > HW and give the control to software instead.
>>
>> What does that mean in practice? What way does hardware control a GPIO?
>>
>> It's not some way of remuxing the pins is it, so you what you are calling
>> "controlled by hardware" is actually that it is controlled by e.g. I2C and
>> other stuff that may be muxed in?
>
> Yes exactly. These GPIO pins are already assigned a specific HW
> functionality like I2C SDA/SCL, MDIO etc... but we would like to
> support the option to control them from software if desired.

But how does that play with your pin controller?

I mean: is the multiplexing of different other devices also software
controlled, so this should have a proper pin control driver rather
than just a GPIO driver?

Yours,
Linus Walleij
