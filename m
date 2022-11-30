Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168BF63DCAF
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Nov 2022 19:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiK3SHW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Nov 2022 13:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiK3SHQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Nov 2022 13:07:16 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B541F7BF89
        for <linux-acpi@vger.kernel.org>; Wed, 30 Nov 2022 10:07:11 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s196so16817899pgs.3
        for <linux-acpi@vger.kernel.org>; Wed, 30 Nov 2022 10:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U/XxTMPICDie9ymNdj/MdgVV0xGRFOD3AAJXtRn0C+A=;
        b=BUG7pdc6PPVgQrMC7CiGj2Cl3eIK6wgTQyCCd4Dbienm0CJNV7xL6LPRfKROL+QbPy
         PUZ3tiRzLrEDxwF860wzhgXU5H2SbuQDAg7vva0vZRvRLq+N0atW72fRVeTH17CMqkdx
         bZTV7NunSIMjvQ/f/p08lsxbdONCK/g78arTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/XxTMPICDie9ymNdj/MdgVV0xGRFOD3AAJXtRn0C+A=;
        b=MnZVQAsgs9TAwJSokmNzAO+LKcvI6wHXBYC8B4t3JxY5/EYBndCsnrDdV71pX6Vkhi
         IgNcYchnTQFZpFL1Q21v8LZ6sTCqLV0330UEapqPtEPqQIuJ3j+29BbaQenJouNGMC8Q
         zVrT8tf/EQJGjWYv9TtVvd8pZRPWQkgONf5LErXlDbvQX2DEKz86jLbtGKw72/sujXuY
         zQyTbwuLA/d7fFNpxRhGcyiNVFi32zy4Fvh7XUxHSsI3CUpP4khSyWiEBQqn10Y1F/DD
         KMKa3n/YKHgW9E5gn/ISf8TE2+Ncnrp09BNMNw0ug8aMKYSO/HxRGCoPsH9ggOo6Ps2Z
         90Ew==
X-Gm-Message-State: ANoB5plhtEfcwxkpujGKLFk8orClr0MBmTRjc+gRdZAIHc/IgPUC3H5s
        wP7XJpefuYC0OrG74xRdQeM5VOdQ7ulz/Q==
X-Google-Smtp-Source: AA0mqf5RcBDjkmhbI6TMIt6pR2GnqwA6/GTwauT45ctfQvaC6hLNOlWIZyLqc9shCYRj4E8V2WnYPg==
X-Received: by 2002:a63:e50f:0:b0:477:bac2:e57f with SMTP id r15-20020a63e50f000000b00477bac2e57fmr32491211pgh.614.1669831630916;
        Wed, 30 Nov 2022 10:07:10 -0800 (PST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com. [209.85.215.174])
        by smtp.gmail.com with ESMTPSA id z188-20020a6233c5000000b0056d7cc80ea4sm1673779pfz.110.2022.11.30.10.07.09
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 10:07:10 -0800 (PST)
Received: by mail-pg1-f174.google.com with SMTP id 6so16795483pgm.6
        for <linux-acpi@vger.kernel.org>; Wed, 30 Nov 2022 10:07:09 -0800 (PST)
X-Received: by 2002:aa7:81cb:0:b0:56e:1092:1272 with SMTP id
 c11-20020aa781cb000000b0056e10921272mr44887867pfn.31.1669831629238; Wed, 30
 Nov 2022 10:07:09 -0800 (PST)
MIME-Version: 1.0
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.9.I2efb7f551e0aa2dc4c53b5fd5bbea91a1cdd9b32@changeid> <Y3uP+Kx1xLWRVUAX@smile.fi.intel.com>
In-Reply-To: <Y3uP+Kx1xLWRVUAX@smile.fi.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 30 Nov 2022 11:06:57 -0700
X-Gmail-Original-Message-ID: <CAHQZ30CArSjaJUt2pg-3MQpbK4Zux7WXnr5E8vmnDrMyj0sN5w@mail.gmail.com>
Message-ID: <CAHQZ30CArSjaJUt2pg-3MQpbK4Zux7WXnr5E8vmnDrMyj0sN5w@mail.gmail.com>
Subject: Re: [PATCH v6 09/13] HID: i2c-hid: acpi: Stop setting wakeup_capable
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, hdegoede@redhat.com, rafael@kernel.org,
        mika.westerberg@linux.intel.com, mario.limonciello@amd.com,
        timvp@google.com, linus.walleij@linaro.org, jingle.wu@emc.com.tw,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 21, 2022 at 7:49 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Sep 29, 2022 at 10:19:13AM -0600, Raul E Rangel wrote:
> > This is now handled by the i2c-core driver.
>
> What happened to this patch? I don't see it in the Linux Next...
>

This was just merged into dtor's next branch a few days ago:
https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?id=1796f808e4bb2c074824dc32258ed1e719370cb3

> --
> With Best Regards,
> Andy Shevchenko
>
>
