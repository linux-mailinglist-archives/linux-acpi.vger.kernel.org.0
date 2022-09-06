Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A057F5AEFFD
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Sep 2022 18:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiIFQLd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Sep 2022 12:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiIFQLJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Sep 2022 12:11:09 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FF69D67D;
        Tue,  6 Sep 2022 08:35:46 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id m5so8442108qkk.1;
        Tue, 06 Sep 2022 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=B1nLx7OoVE2iJLBf662NA/6uPa0hL0tfjj0xV5A5JwE=;
        b=KyLnvCFNtl1vS7lqTBYFzyVn96UTNw1UtCJfRvlvxChOCyk4ViH1zG2N9gJRUETjva
         NB2Kh6yZuisVcrBeOwEIwA+3FzGOXwmDT7qDFwsP2aGXSc00qDMkHY0Xtc/w5xMxpHkc
         Qx+CZtvh1lDMe5u9Jm/h3ANbysNk8PnfkgapTmoWEFuyi0O/MoPKOAzhKbBNd1QtKll+
         9E5sUiVe5wWREqQrl5giXgCs1NjJHiO59F+H8SGeEvbj5wEc+MtVp2l5fUr7X21gXq+j
         CK35MP9iMfJq75J4FH4wPKmsJwKvwqQ1nVT1zT2Q+sLfOwzCVapv3R3kRT4A8JspKjtP
         8A0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=B1nLx7OoVE2iJLBf662NA/6uPa0hL0tfjj0xV5A5JwE=;
        b=fTo4e+P1HNqbvd1QfYjKx+KIYuD6dIXPALTb/KN8teEMb0b1QlmZuOZObFfeeUVlm/
         wESS4RduMStaz68RyMUrgwaoprluzmNAgvK5hDjz5NzbaO8birJNGhD2yg+qknFBeV+5
         lv+WfyC78r8uC15Ai/0vNDEvHA+hMTzMibmLr4yXm4MssgApddhH5zVRMyM1eFjBqbnw
         UHYixMFJ8a0ceNeALn52Y6pHlRS/zOl8Xf/tCGiLQHRg92vEB5H9x5ijoFs55yHNt9qB
         8NgOlqtKZMCubLZ+wbzoaaPrFoZ9FCxoJPuCXPibvuZrpalp8r0dnfbSOTBMrymN0nZG
         SkPQ==
X-Gm-Message-State: ACgBeo3pI5Qh1UWiwRMPC8fpClT69RrLfBzC1bIvOLdPmHQFwdskPnXn
        /mkzxy5fxXErDW2G8+xp+iqukSzGdcTAp3GpyYY=
X-Google-Smtp-Source: AA6agR5s5OyR/c7EiS1x6fQLfWbXYhQQDXm62DJk5gxHUpMPj4rHxmkXnxHBEa0JbQeSdtKgEIFgl52/pZK84yIcEas=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr36442218qkf.320.1662478545225; Tue, 06
 Sep 2022 08:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220418141416.27529-1-asmaa@nvidia.com> <CH2PR12MB3895A1FB2977B725ED92AB57D7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdY1uK=73zpEM5zUyXacm5xaUUFYkuKMxi_q6vwmOPy6tw@mail.gmail.com>
 <CH2PR12MB389560A1873030472A7A371DD7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdZhW9XK3opXLLzdMiVLVkGQyJCf7RLZtRQLsmzv-aqwbA@mail.gmail.com>
 <CH2PR12MB38953FF57D91FA75AB9CB102D7CB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdbAhMa2CXvQra3E13n8WfiBxyHNqzEp4dW3qo5upr_=gw@mail.gmail.com>
 <CH2PR12MB38958CD365876A2106712C3CD7CF9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdZp9hx2SHxsmjBm2oj7m3UT-4S+MKw5qqNME0PLjPNV2A@mail.gmail.com>
 <CH2PR12MB3895B4E89237E6D6F635F252D77A9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdaHuQhzqqQbayGaRqYAcnyv2rmocX7YhcR_qj0HRVHkgQ@mail.gmail.com> <CH2PR12MB3895981F3DBB2F551DA6AE95D77E9@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3895981F3DBB2F551DA6AE95D77E9@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 6 Sep 2022 18:35:09 +0300
Message-ID: <CAHp75VfLjvEVsFqw2+fu8M60uU4LEbsirg7vBKdHd7WsxWN5Rw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Add driver for Mellanox BlueField-3 GPIO controller
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 6, 2022 at 5:08 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:
> -----Original Message-----
> From: Linus Walleij <linus.walleij@linaro.org>
> Sent: Friday, September 2, 2022 5:55 PM
> On Fri, Sep 2, 2022 at 5:55 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:

...

> > I would like that to be controlled by the ACPI table only.
>
> I don't know if it is possible to restrict GPIOs to just be used from ACPI.

On Intel platforms that's done with HW assistance, i.e. firmware
configures special registers inside pin control / GPIO address space
that reflect ownership. The driver rejects any attempts to request
such GPIOs. As a workaround one may simply disable all user space
interfaces (as you already discussed in this thread).

-- 
With Best Regards,
Andy Shevchenko
