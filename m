Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D3A3EE038
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Aug 2021 01:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhHPXHA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 19:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbhHPXGu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Aug 2021 19:06:50 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898E0C0613CF
        for <linux-acpi@vger.kernel.org>; Mon, 16 Aug 2021 16:06:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k5so9786662lfu.4
        for <linux-acpi@vger.kernel.org>; Mon, 16 Aug 2021 16:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbLlLwK/VNlS75a/X+hMyEwJqBlLcD/FK1WB01XtTs8=;
        b=WienlzZurbN/2XsS69sMGjJeCuTkP8yZTjTDnLvBwquenqVStUoFPE+VJqNf35BhxX
         mUX5EXM5ECSRzpuicp8Xyq+AB6iGK4BRN/VH2jERJLeq/p6F0bCfq/QG3kMrygk6+Mse
         Mgx06QK1x+AG55F1TUzL3CV+qam1vSP7rYnKOdvLqSDyVqdVrJ5uiVXafkvjlx3ZxWat
         MIwtvFSm1nLXRsEHEF/3GMeuIHDlu2/ohXjNXxQITdWTTJhnjwde2EmkYSQRM6WViKjj
         aIMKzqu/2749BDrKfZrFOzUr/CuAZPBB7gSiFjCcQOfxADbG6vZFnP8Zz1hSYnwrSgVO
         pP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbLlLwK/VNlS75a/X+hMyEwJqBlLcD/FK1WB01XtTs8=;
        b=k8X+/DWlb3D8KO/RWsMwQT6sPjKUHLL5ubnofBdP/ciVtwELDQspRYmeKCTUynyB45
         m60WPN5RqzAQtJxNggIA5PMwY8TmXNLiYcLtCud6oOUt+t2htFQ/0a999+18LKbhdmFM
         t2/b3WBSOxOqP5JJuYKiX6dD1r0CfsduICl99MXsLUy0Uocc36JpIFTP5NF4NGTdv1ex
         8IODQX3P7anBGdLq7zOlx3T/eQynD1GeKHJb29SwGqfn8D1U2XFMbOrjD4jnRNszrcLt
         LvShIZye4hBvz3yKRl2vojICaq94xZBibP14r8Fd0VJei15drCJ6H08GaDk/rEyZuMwK
         gD8g==
X-Gm-Message-State: AOAM531oUumRShAMLUoimGsCZk7I481+Xpy/GPZ2riLsiRhjCgDy7HPS
        J6KJQ2ckJlTI4geNLAESDngry+VhR3CR6zZW7bPKeg==
X-Google-Smtp-Source: ABdhPJw7R9OwquiOsdkg97GqKDA+WvX5FSKJp3noOZ+hKqsy3JBsIb5In/u+bx3VfAzyQP2bkD+lGSMmZ18S6r58HV4=
X-Received: by 2002:a05:6512:3250:: with SMTP id c16mr113752lfr.465.1629155176951;
 Mon, 16 Aug 2021 16:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210816115953.72533-1-andriy.shevchenko@linux.intel.com> <20210816115953.72533-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210816115953.72533-7-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Aug 2021 01:06:06 +0200
Message-ID: <CACRpkdavU=_Fo3DQkD_MAT9Ur-RX46v0L-O=tqibpUtdUhe-NA@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] TODO: net: mellanox: mlxbf_gige: Replace
 non-standard interrupt handling
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Thompson <davthompson@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Asmaa Mnebhi <asmaa@nvidia.com>,
        Liming Sun <limings@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 16, 2021 at 2:00 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Since GPIO driver supports interrupt handling, replace custom routine with
> simple IRQ request.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  .../mellanox/mlxbf_gige/mlxbf_gige_gpio.c     | 212 ------------------

Don't you also need to remove this file from Makefile?

Yours,
Linus Walleij
