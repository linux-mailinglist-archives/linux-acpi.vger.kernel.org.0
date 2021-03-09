Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E06332C2A
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 17:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhCIQei (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 11:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhCIQeP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Mar 2021 11:34:15 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E404C06174A
        for <linux-acpi@vger.kernel.org>; Tue,  9 Mar 2021 08:34:15 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id p15so21420022ljc.13
        for <linux-acpi@vger.kernel.org>; Tue, 09 Mar 2021 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EInm0LEnIi7XLKD6zyKq8F4CqLBLvPBrEiCalMxA2ew=;
        b=QFCUfjyZ4xnhe0B+dyRwT4L7N42IypkyBWHBEcDUQLyrvB1LT+5M1yqzKzbOba5dQ4
         RsmcLSF8OBfOJotv21zMWOFayWlqRkAvd6OaQaKUZrSFzfCx7VThVzmcMyprHOix0c3z
         Ft6zo0djGIu9DR/IZJNnJmPEuDUibch6vSohkq3tH5bnOIB8nilOj0y2BdkeVxZzxR51
         hxQ8qQ2Ukx+t1Tf0q5JBwOD9wdfugEvno+I4uDWrEgwP49b0GCsQ8A6EGAIQj1i9VwTz
         zPigDd3wds5T7tibLYVgBzIBpTJiUNO0ZTOnaR41f+d1Cg1uwExHIPs7xtsCnjCZS7eU
         K5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EInm0LEnIi7XLKD6zyKq8F4CqLBLvPBrEiCalMxA2ew=;
        b=hcEeZenJJ0c7w6w+ek/wRgQOnZEDhrv10NDK449M3zevuARXxKdIy6VbC9TthwF+q9
         nI4v/ThGINfnIopFmD/WPp54shlPtKZxNKaJhIDICHjvS7XqtsOSYpCALOoNO/wYA12H
         103D9Ks9mDDcArQIkXRLxN0HodS8wff5sxMt2tyy2yhlhuLRpoVJHrucYJqzlI7/H5ue
         FuspdRM7uad+TwHTnmduYCN6dBV+q7W0vkKpGTwwn2BFirW4Tq7x3CuJOqZtSB3onycg
         PzlgsxIyzqN6I7Iuiyu/FDibTOMGPsMBWMGy5Ax6ZRFrAi7Y7K/eGmXocb9p3XHLllVE
         QW3Q==
X-Gm-Message-State: AOAM530sDHddkMzRtc67swcrrN5GuNtrB4bPoQZBZ4z3A2MPHi2UxGzC
        yfsIbMnenNQmBrUiXjy/LxUQ5q2YunruHreF1QV0NehMs9NgMqxg
X-Google-Smtp-Source: ABdhPJwNXAb9NrkkJhTzXglp6OzgZuNzRajKOhmHnYIlN9N9Kod+C9/W2ePM1dzVD0/tuS4O8FWQKlypJ/aXUx+mFvQ=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr16949254ljj.467.1615307653884;
 Tue, 09 Mar 2021 08:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20210308194535.66394-1-andriy.shevchenko@linux.intel.com> <20210308194535.66394-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210308194535.66394-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Mar 2021 17:34:02 +0100
Message-ID: <CACRpkdZO7TPcz6p8Gfavqd1SboCt7ZXwFa4+4TuWNTZuoXZqgg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] irqdomain: Introduce irq_domain_create_simple() API
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

On Mon, Mar 8, 2021 at 8:45 PM Andy Shevchenko
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
> Acked-by: Marc Zyngier <maz@kernel.org>

Excellent work Andy!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suggest Bartosz just apply this with the rest to the GPIO tree.

Yours,
Linus Walleij
