Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF522334C50
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Mar 2021 00:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhCJXPx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Mar 2021 18:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbhCJXPn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Mar 2021 18:15:43 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22260C061760
        for <linux-acpi@vger.kernel.org>; Wed, 10 Mar 2021 15:15:43 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p21so36423271lfu.11
        for <linux-acpi@vger.kernel.org>; Wed, 10 Mar 2021 15:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvgqzQ3J8j30csPWmBVtuOz65ao5kSPhlDNVxVSpFEc=;
        b=I3yoB+2Jz9M77UGRHjOQ21FENV/4rcf8+OthqQA31JhtTKZUynjkLmtKEf0HMj+NLJ
         8jvPlfUVgF98rs95p39XYZc7yFb68WICkPO/kQvt6Q1c8J+jFT7QEG8y7D7kdoqxOKRJ
         DMvE5N7lFIevdpnTIj5+Slb00i7pEud0WDbJWaNU6iv3eZS9zVGUZtE2fpS3+EVmb/ec
         gxuW8mdqT5QZr8E/D68kK+oKbchcF9jIscvwr/plgHJf3SvvLbj/ikY77bD8rHw/9yWj
         yAbzJKsg98OHJB07f4Nlku0qvpt94YACmKgcRBfReIi1j5LWoP2M0muZ8nMy/pBj6pTI
         Bdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvgqzQ3J8j30csPWmBVtuOz65ao5kSPhlDNVxVSpFEc=;
        b=OvzHha/+4nnNZffwzkNPjgq8WjKczyocAlwjb9i/6YOa4cvxI2CbYqLqmgQ8VAkwiI
         XNqsaJqV7X6z8XGZFHQtDMsrvWnvax4lm32lNBvDBhLvRg/4Lawo5y98ycTID4GBhvUY
         H1YY8U7Yx0zwoaUm+kNO9FfckQ/BT1IMmaDYQgN4c2UszyKX0CzR5lQtBh82dVsiUF0U
         oGPVLj4g7/vtkWIFKRBLL0YYXHQDpZjL4wmW4YHuD9Jmuoe3WWilK6Sp36rUreP6XafK
         uc9VNYvZ0XTlGcpaxeWX3vagSUoz/hJLM3nYH8yA7gEpVu0Wgzlh6ezGdo0cUFlr/oXr
         /iCw==
X-Gm-Message-State: AOAM532zVwNNFEDV6hnMW5tEHWZgnCa7u4IEkRHWUV4Ikf1I0dxPodd4
        TSfmJekVLx3FS5Adg3C0P8jrev72uLOPo1bvDUSu/g==
X-Google-Smtp-Source: ABdhPJz6sqRctIaxVCY7bLqYO+NzPpIJ6vlSe8TnV452GfK18RjK/YOYwyudDIEPPPFgwGG+hoX2MGiC29xhnianDGc=
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr508729lfe.29.1615418140326;
 Wed, 10 Mar 2021 15:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20210304201253.14652-1-andriy.shevchenko@linux.intel.com> <20210304201253.14652-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210304201253.14652-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 00:15:29 +0100
Message-ID: <CACRpkdbA+Q24JV3Uct2dHtGfBb1AaF4uHwCbzcrOFAxoGQ4wXQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] irqdomain: Introduce irq_domain_create_simple() API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 4, 2021 at 9:13 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Linus Walleij pointed out that ird_domain_add_simple() gained
> additional functionality and can't be anymore replaced with
> a simple conditional. In preparation to upgrade GPIO library
> to use fwnode, introduce irq_domain_create_simple() API which is
> functional equivalent to the existing irq_domain_add_simple(),
> but takes a pointer to the struct fwnode_handle as a parameter.
>
> While at it, amend documentation to mention irq_domain_create_*()
> functions where it makes sense.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
