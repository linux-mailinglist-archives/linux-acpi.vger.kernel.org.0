Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFB2620D98
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Nov 2022 11:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiKHKsQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Nov 2022 05:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiKHKsE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Nov 2022 05:48:04 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A844298D
        for <linux-acpi@vger.kernel.org>; Tue,  8 Nov 2022 02:48:03 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m22so275625eji.10
        for <linux-acpi@vger.kernel.org>; Tue, 08 Nov 2022 02:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NLSZQDOdS774Nz52CcTIDX3lJJfQJqLZXfRGXtR9Ekg=;
        b=Q/9aeYAvohkURoWlz1zGEDYuDkN2MX0lw+Kk0YRLwtj9goOQOAF9xG0NgpAkIK3Vou
         aRnXhbvzVWvGcHLNMfTBTN8fXWdoGK9hQj8Hf+aqs2EDM++WUjhIAR2L7ZimVj11vzkk
         WaT/Hni/SPZACleYu1QbfipP3b0DdDLSxNcTxcNg9hRcEiTN3rH6acxDChexGFMj4kn8
         OWC/amXtKTXEk2ldm5eSpTw/7D7fUjvYWrVveuaf+i2VvBRlmqVfL1vNp+zK5OKwXgZw
         sXFfIQHFxKtjDHZv9q+05JY7Y89zc91ioC3rwXcefBOliuZ/iovPcxJGRvuI47FOy3cl
         2YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLSZQDOdS774Nz52CcTIDX3lJJfQJqLZXfRGXtR9Ekg=;
        b=bjuTwLULrAkNRKu2kJGq/DH/5Q7rd7sBEzHZsUOmUMsFPtDoE8NHdpMDQ+MaI+JyYG
         yOuBkRk0ah3JzrROtQjzbXKD3vgYn9rKnJAWIjfF6VR2hX+xpOg2nPwxIcz5sU5OLes6
         LKr9fXwTOSf+6MuiShOFRQDn2pmGEtrxOUD0u3obNhPgBi31TLB5Z40ZrwwOy0IPj58P
         C9yFQBZo0PkAZxfAqUMdn6Ucj/7o9i5owZIn0UNpkndIMnBev4zszpjLaMP6Ko5r4rlG
         oZTGx9HHY5iR5a3LMnbz1631XNzr7pIWs43bWF2JEJ9URDk7Olnw3BdSmHdS2Qv0EFXX
         LNKw==
X-Gm-Message-State: ACrzQf0XlZ8pAkSAxIOUNlXx8H0wJpa48IdcO76o/eg3sSHpC6VSSCFz
        UtEiOYKaApXyKCpopGu7R8HH7d6khGw/pc+A9YITCQ==
X-Google-Smtp-Source: AMsMyM4AKmqQtElrAYKhu/RuZpiMiFWRy6OpfbPMp/rWEBwBmcX73CFRJ6uB1YEN9d/PjYiVETR77As0iG1GsQhAgS8=
X-Received: by 2002:a17:907:c1e:b0:7ae:31a0:571e with SMTP id
 ga30-20020a1709070c1e00b007ae31a0571emr20557470ejc.690.1667904481920; Tue, 08
 Nov 2022 02:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20221103180643.79352-1-andriy.shevchenko@linux.intel.com> <CAMRc=McicB36evBh5thWPtnMPuzbfY+4m29i6Mp-1tJSw9OvjQ@mail.gmail.com>
In-Reply-To: <CAMRc=McicB36evBh5thWPtnMPuzbfY+4m29i6Mp-1tJSw9OvjQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 11:47:50 +0100
Message-ID: <CACRpkda0aLXxZn4DJdo0BjwhLYWBjmG+_iEtDz84F9e1srqXGA@mail.gmail.com>
Subject: Re: [rft, PATCH v2 1/1] gpiolib: Get rid of not used of_node member
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 4, 2022 at 4:10 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> On Thu, Nov 3, 2022 at 7:06 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > All new drivers should use fwnode and / or parent to provide the
> > necessary information to the GPIO library.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
>
> This looks good to me. I'm thinking about just applying it and giving
> it a spin in next right away.
>
> Linus: any objections?

No objections, sorry for taking some days to respond.

Separation of concerns is always good :)

Yours,
Linus Walleij
