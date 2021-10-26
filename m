Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB05643BD0D
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 00:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbhJZWNk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 18:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbhJZWNc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2021 18:13:32 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4E3C061236
        for <linux-acpi@vger.kernel.org>; Tue, 26 Oct 2021 15:10:49 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h11so1339333ljk.1
        for <linux-acpi@vger.kernel.org>; Tue, 26 Oct 2021 15:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FeJxrETo5kkHC6yy5/z3/zb2XGiSNYC+KlW60qSUBa4=;
        b=IGRo583RkjYHRXrdCbB2VtjMRMnIkzIotxUIb344Yg0+X2k+LZZ44x9PLWUupfLfXM
         aa3MfmufNZMIOtCn8Sdx5GErCS334lOiLPg1xe2O/saDViWnOiPfN9te4fJnYGSdlobZ
         bc8VUKmmke2U/XMI2xp3OP4iKKpxdAsC50gE5o2J7Q405Y0U6u11DbxbRDn33b4wZw1V
         pVpwzAtXUR8FSIeKPCX1b5dCdSQUt8eV6aAze1TLGfHbpRYWMImBTG0zXCQcY2d2Mj4h
         N8M1/sJrEiQ9QqRdk574feqFG1xLRk+DgKLBN9B/BmTVnNMA78leWGosbuID7PkPx07T
         JZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FeJxrETo5kkHC6yy5/z3/zb2XGiSNYC+KlW60qSUBa4=;
        b=XylJu8BUfzLwBZ+O6YvfKcObrqTFI+YCVvY0F/KdErxndGU0LngnQ2eYPk2e7M2aHH
         D4eK9A2QMO6pyAqVBjc9myS2u3P/LWjxd9s02+dAUEBwRH+CqJbf6im+d0t0I0oxAFBa
         HtT/S8I6M3hrgO7NlYItL1eOi9WCzwG8VIr7oEJozEZ6tkzxHwW9VTOf3ExkABlZXdq+
         FUkp02ovFiqRNfrTQ4Hs6v5N/cTwbl3mWm+u80XyCXzHQOXX/q1NnC3hPUPtvuMmAA6l
         mDDvg1w3pxdQ7/5rkaSE2gagIgN4xAI1qcwGyZsIDfBjI4S16TxcgULhZPK/Z80nlUH2
         b2qg==
X-Gm-Message-State: AOAM5311tp//xLHCH4v2jeP2dqeN1e1qSI0G8G87s+dPcANC5jWUhgaF
        oblPtVZmmqkbvb7yGvCQdmELSLYtESSK3KXWUnNKBw==
X-Google-Smtp-Source: ABdhPJzMiEfUftf3AQCYeJTd8EgA3PuLtgAofwFO1J7XgnTbj+hNXjSb/i3L0yrGwvrWcwZe6l9j1qocEPmvn5WPDNY=
X-Received: by 2002:a05:651c:111:: with SMTP id a17mr28176160ljb.145.1635286247771;
 Tue, 26 Oct 2021 15:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211026171313.50-1-mario.limonciello@amd.com>
In-Reply-To: <20211026171313.50-1-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Oct 2021 00:10:36 +0200
Message-ID: <CACRpkdYAv5w5AfKPQgCqXgKSYnS7wvCkE3qTj_Q9hyvOS=xsvQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ACPI: Add stubs for wakeup handler functions
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 26, 2021 at 7:13 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> The commit ddfd9dcf270c ("ACPI: PM: Add acpi_[un]register_wakeup_handler()")
> added new functions for drivers to use during the s2idle wakeup path, but
> didn't add stubs for when CONFIG_ACPI wasn't set.
>
> Add those stubs in for other drivers to be able to use.
>
> Fixes: ddfd9dcf270c ("ACPI: PM: Add acpi_[un]register_wakeup_handler()")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I need an ACK from an ACPI maintainer to take this with the
other fix into the pinctrl tree.

Alternatively both can be merged into the ACPI tree.

Should these two patches be tagged for stable?

Yours,
Linus Walleij
