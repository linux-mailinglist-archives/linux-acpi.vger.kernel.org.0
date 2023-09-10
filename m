Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2D4799CF8
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Sep 2023 09:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346424AbjIJHwZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Sep 2023 03:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIJHwZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Sep 2023 03:52:25 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9F4119;
        Sun, 10 Sep 2023 00:52:20 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5733710eecaso2033046eaf.1;
        Sun, 10 Sep 2023 00:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694332340; x=1694937140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUzbkQyUnUnw16/PAooedaB75hvDn/Lqq4EvQow4wqo=;
        b=sR4YvV6osnCPWv9aXrBgWkSvKpJLPf/UZVY9J6EhmnhQWZAW2JlzefQ4rxZ0cnGemi
         8qrNhLzdrZF+JU4EoJIMTaaz/78GjphnWWNow1ChYFrk835iP23jVQ05KbFUcJx+FlnA
         YqpJpa2onA+MiOZ4ExvlJztMuNJs2UnQBWVUzL+a6gCbAv6RweCrNQEEDH1OioCnhbne
         88l5Y8oyAC24FkEZAiwz/GKugTpIvbWFe4+/wNhj/1zyN4LRMdzoUFUd4ALTthx4FBt7
         5s2rQSMDzSMbPazJqOMKX9kb3TK53wL8dBXBUg1nISivgJbvOI4CwI6GgPU6l0ZSuaQe
         RKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694332340; x=1694937140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUzbkQyUnUnw16/PAooedaB75hvDn/Lqq4EvQow4wqo=;
        b=PndA87ErXRNuX9CITX8/e5JH+zRPoaXyGZ2EDDIIZdrJNIgVJOcwkYDYqUadOrwyhh
         m2/CWdEg3E1ME1NO7u8FEvECHvoJgUQRL2nJz1bb3KXypUTbfh/Q/M8tlJ3JZ7A6Cj7y
         9petSAOMsFkpvnvlOMrSMrs9DcEjUsJ582SUgPG18H1ARtwPKmjoNXRzPzs9T1D7f3pn
         XfC4SSccabN7IDh4Ezi2fPjNq0ZKHuD+S8OMgGca7aX3Ik/LAlAAc7LYUNL1EHLuTcbu
         gp0WpwO2SmObcTRLuOu/B3KKnu/3CPDw8z25PyMcbAQ/f/jMb8QS51L8vKKRjHGEKsGC
         1dVA==
X-Gm-Message-State: AOJu0YxC+BWUWzE5df/+WpFuK0O79blcCh81q8CRctaX1wbGQvCt/iYg
        q4fEYQlwjBZDfoXOwSVw1tQYUQGYUAiVBmvE1SfkeL/qAe3D2g==
X-Google-Smtp-Source: AGHT+IGK/ttI78Z2GTMxrNN9NIxY/3tl+ALjMDLU4K0aG0JEE8Y5d2MtCzLgnBbMcPorG5qNeGyu4W6+74WVBaf6P+A=
X-Received: by 2002:a4a:9111:0:b0:56c:820e:7f02 with SMTP id
 k17-20020a4a9111000000b0056c820e7f02mr5485901oog.0.1694332340192; Sun, 10 Sep
 2023 00:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com> <20230909141816.58358-2-hdegoede@redhat.com>
In-Reply-To: <20230909141816.58358-2-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 Sep 2023 10:51:44 +0300
Message-ID: <CAHp75Vds-PLeZ4RNQevZ8hF4wrQjHYea1BGNuFm3cRbHy5A+Dw@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpiolib: acpi: Check if a GPIO is listed in
 ignore_interrupt earlier
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 9, 2023 at 5:18=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> In some cases where a broken AEI is present for a GPIO and the GPIO
> is listed in the ignore_interrupt list to avoid the broken event
> handler, the kernel may want to use the GPIO for another purpose.
>
> Before this change trying to use such a GPIO for another purpose would
> fail, because the ignore_interrupt list was only checked after
> the acpi_request_own_gpiod() call, causing the GPIO to already be
> claimed even though it is listed in the ignore_interrupt list.
>
> Fix this by moving the ignore_interrupt list to above
> the acpi_request_own_gpiod() call.

Not sure if we need a Fixes tag, either way this makes sense,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
