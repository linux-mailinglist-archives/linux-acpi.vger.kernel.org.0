Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301CE6295C3
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Nov 2022 11:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbiKOK1D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Nov 2022 05:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiKOK1C (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2022 05:27:02 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA0919027
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2022 02:26:58 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id t14so14201389vsr.9
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2022 02:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SVCnJQpMcMQCVwz0r5ZgEBXxiRKbY9GCOrk5WczFNDs=;
        b=PXwdtpTlp1XzoUK0q0GeiJCQsn9TaExdGjx78z+DsVE/c9wY1kA7UBP5FmWcWNeD2p
         gi8tuqmFak2uVHbUnnnERm3sU3zN9/CMj+qbYRZXNwDLInk9AnBe9rfW7fNKje8xmBFY
         BK5SnDyeDHbSYLOemlxUtWncE4TS6egEhhdkwukCtEUagYdo9ptqzr765bzO1cVAzZ7m
         WygbFyZ9QWWnLUScoe/8Y/bTMps1eIQMAUYP7UXOYsNhfKjYTSt3a5UkVBo39hwsP9Tv
         xV1ti5Ivs41UOmTkN13NJV3eUfaIwEzq7Qu5CbLg6ZCrDxd+kaL/SWMBkf2Nzb1QPCIv
         qV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVCnJQpMcMQCVwz0r5ZgEBXxiRKbY9GCOrk5WczFNDs=;
        b=QR7xnWedLieOAVC6xRT3Q2ZgkPs37PnjqPMNmR8l+p7zN0oU3ZgeOE7OtiRZaXOm8j
         eML6M2hZYV0y8PQR8d+Xzyy4eqWlKXplT9gLDqnVIv4W9siqZUElxAelF1GnQ5Ak7/xg
         jIy0Kwh4qYGVPJoF2DalxNGhFeamF05RKKPRtpBUzAExNNSQJhlCOFQ3ZD/DShj+FXdM
         8Czjz/3+pEnINhwQHBXuowcsUQNjpGc55pio9lTOBzsdCXLpkq0DXR1TUqyBzygedrAR
         GjdT8d0wyeakRkBni7oh9D5Z09gFhRFMle8nzAU4tTE5qLr3W64+69xKQqHkNVUxN5S7
         fCiA==
X-Gm-Message-State: ANoB5pkDH+wSV/HFmM/gLbeEGmfb43TnDJUSrpbjDtNqNysA2GnTlSnn
        AYuoKbO6J7u/5ROLb16Bg9bYa4Y9TgXwXb9wPeSxMg==
X-Google-Smtp-Source: AA0mqf7YJuZeJwIpvn57X3OEJn8MwvZXf0YU9fYC5EkmZvsNYW4RZHKmcL8HW6XJxwsBDd1AWK26r38rBEzkPp1xncs=
X-Received: by 2002:a67:6b03:0:b0:398:6504:9ece with SMTP id
 g3-20020a676b03000000b0039865049ecemr8278655vsc.16.1668508017297; Tue, 15 Nov
 2022 02:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20221031-gpiolib-swnode-v4-0-6c1671890027@gmail.com>
 <20221031-gpiolib-swnode-v4-5-6c1671890027@gmail.com> <Y3DsJubv/t0nDCa7@smile.fi.intel.com>
In-Reply-To: <Y3DsJubv/t0nDCa7@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 15 Nov 2022 11:26:46 +0100
Message-ID: <CAMRc=MfwMdN=OyauDLtOO7cZ4UybUJx4fOM8=2W_YFjZPDcAzw@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] gpiolib: consolidate GPIO lookups
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Nov 13, 2022 at 2:07 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Nov 11, 2022 at 02:19:07PM -0800, Dmitry Torokhov wrote:
> > Ensure that all paths to obtain/look up GPIOD from generic
> > consumer-visible APIs go through the new gpiod_find_and_request()
> > helper, so that we can easily extend it with support for new firmware
> > mechanisms.
> >
> > The only exception is OF-specific [devm_]gpiod_get_from_of_node() API
> > that is still being used by a couple of drivers and will be removed as
> > soon as patches converting them to use generic fwnode/device APIs are
> > accepted.
>
> ...
>
> > +static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
> > +                                             struct fwnode_handle *fwnode,
> > +                                             const char *con_id,
> > +                                             unsigned int idx,
> > +                                             enum gpiod_flags flags,
> > +                                             const char *label,
> > +                                             bool platform_lookup_allowed)
> > +{
> > +     struct gpio_desc *desc = ERR_PTR(-ENOENT);
> > +     unsigned long lookupflags;
> > +     int ret;
>
> > +     if (!IS_ERR_OR_NULL(fwnode))
>
> Just for the record. I haven't given my tag to this patch, because I think that
> the above check (and respective assignment above) are redundant. Even comment
> inside the below condition clarifies the point of the meaning of descriptor
> being not found. Besides that many of device property APIs designed the way
> that input fwnode can be invalid.
>
> Nevertheless, we agreed with Dmitry that this disagreement should be solved on
> maintainer's level, while it doesn't affect code functionality.
>
> The rest of the patch is fine.
>

Noted. :)

I'm fine with Dmitry's explanation. It doesn't hurt so let's go with
the author's intention.

Bart
