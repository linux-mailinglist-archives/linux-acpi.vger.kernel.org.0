Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C92D746CED
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jul 2023 11:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGDJL4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Jul 2023 05:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjGDJLy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Jul 2023 05:11:54 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7D4B3
        for <linux-acpi@vger.kernel.org>; Tue,  4 Jul 2023 02:11:53 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-c4dfe2a95fbso3117570276.3
        for <linux-acpi@vger.kernel.org>; Tue, 04 Jul 2023 02:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688461912; x=1691053912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r37X64MkxE2953+nhgmVZSnQSf+m5XeSlLa0brc2dAY=;
        b=Hx/g88ElX/Kct0Oy36/KaEGVCIotyUj5L99gcUNRYKqofPwIM/ZB3QyqfIedV8lmTN
         9VIMiYDxyl3wItImuVqVYe50uvNifb3GFAhHQVxLRzhhCuF4piMZcOf+Cl4yNPtbgvH5
         fd14FkfdxvtboKKfxvb847yLg7XVjEgDxQkXtUKEDILN6C0h6m/IE3+YW5Ay2RNOSGPS
         W88L0EcYBrbztf6U4cnYynpha8DrFW9NAJ3IwOXyNCSwu7evkKx7p4cr4ou88xeZ0+OD
         pme3S+xJ8B7l7ZXZG4j5hWZaVF4Go1xTiKv456+GGbefInmn5U1gVgcXBNIJrYMLUqOq
         ZDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688461912; x=1691053912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r37X64MkxE2953+nhgmVZSnQSf+m5XeSlLa0brc2dAY=;
        b=Gv72wQ5PPOIRfbr+yPFNjSeFnUBWPqmNHwhJcQhRIOGv+ViggFCcQS8AkdOspP2AnT
         JxQ3Vh8pMhAnsGMbn/zArIFHHAKRCIgdRNtIfSjol9emXPMqQ1try0mmdo7PQDqtkO1/
         1hzdzRPvde44/e674j10UxZ/7Fq+GhryySozyib5eHP4JE4AIZWUTmn5IHTek/6HM7Ql
         Jj5uUW4yBZOyMu58TbTXtyHNaYYVueEb9cIhopMOP7/41VuS6ZtMvRO8bPfkx7thUuTQ
         f4A2RYHidkncQgKxppVycv5pj7XyJa8+yUsNaexkM0MsJKOEBvukxy3qIToghW0WarGT
         mDuQ==
X-Gm-Message-State: ABy/qLa6aWxql9xObJFFa/zJ9eLdM+NYN38H1nkne7K7Tgo6PHGYRILi
        gnO348rzrmAlWUEnRdGqr/PXrUkHdhQvuTuFjwuuxg==
X-Google-Smtp-Source: APBJJlHcnv/nKMQJPCeCeIg0yBEb03QMd6LqU0leNGr8Zuxowp+WgPrAEmz1kAOu4naw9cbKn17JcmpvnO2n2/NJGxU=
X-Received: by 2002:a25:fc15:0:b0:ba8:2e05:3e9c with SMTP id
 v21-20020a25fc15000000b00ba82e053e9cmr11654496ybd.24.1688461912722; Tue, 04
 Jul 2023 02:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142308.5772-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230703142308.5772-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Jul 2023 11:11:41 +0200
Message-ID: <CACRpkdat-z3K4GxGXYMYtv1NAWbGY2K3DvutY+y1V5Bkyy7=UA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpiolib: Avoid modifying GPIO chip fwnode
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 3, 2023 at 4:23=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Ideally the GPIO chip data structure has to be constant.
> In real life it's not true, but we can make it closer to
> that. Hence the series.

The series looks completely reasonable to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
