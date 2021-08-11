Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990793E9259
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Aug 2021 15:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhHKNPf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Aug 2021 09:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhHKNPf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Aug 2021 09:15:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4F9C0613D5
        for <linux-acpi@vger.kernel.org>; Wed, 11 Aug 2021 06:15:11 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id h17so4448453ljh.13
        for <linux-acpi@vger.kernel.org>; Wed, 11 Aug 2021 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnPec/eU3m5mrGi8LuznMYLQZYcf94FA0C0JW0LKAsE=;
        b=Z4BGEDcFQm40VEQZa5db/CsHBKubqcnothoCk6vr63Kwm23e7kpfoTtbP9DkxWfq/k
         OBwPNlz/60Okj2o50QasFWalTeAD/fPzCn4fyX4SPIdcwFBFKcSX01jhHr1Mt+jf8ohx
         KM1+id+XqrMN2DDKx51q7KnlSRDnN14Bfd7nnw4ulJTXzQyPBb8/epwSZUb17GURgoe5
         zI+jLan16F1BAo3FKdCbX5cc8vVIXN5f0/oPkS4wC9tkyNTQdsopFxXJBOAwdsH2G/3D
         5JcwGmw0v/q7CuKUqxvWgxym/CKP2Iz2f+jC3YcCINT+ogwGHQqR/uHlOgjJeUvwDweN
         nbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnPec/eU3m5mrGi8LuznMYLQZYcf94FA0C0JW0LKAsE=;
        b=SYXsV16hkmoz9rC6huAVlGBvy571jyiAP1mo7cekiXeqjJWrtHBoYZwS7KXrpaVWtB
         u5Ch57KQStl8zHy0Jx+i/swcNS/PUftBmnt5jIYeCrWn6dt7OKp6mJRowQysZQ1LkB/p
         AowtlO8acxfL+3S7MkSVLpQyu1jzPKJUeQQxL2B0Iv8l7unIcw4VkssSMc8QHmA74XYh
         +m0thHGQgzZsU++7CHONaMHOZlPoSQrhFT8q2ZLpL5EVRXaVAEHnvpv8II1uvGb7FlCc
         CMH54mjstthRajnnSGIouyFPjq/0C718Ggnr9KXP1Hy4AuEj4g3+dqVPYbG0g0PhLC1j
         03Qw==
X-Gm-Message-State: AOAM532wbhraTEsRqjnpQm3b8rIj2QA/g4exD0ziUZwtMkkL5TUG8Kls
        rxP/hocK6C0wLOajPCA8eLHL6DlDqFjo/5WlVKHZhg==
X-Google-Smtp-Source: ABdhPJzQ49y/p7eQbXtrGCUwcwb6bOnAuZY/TiJOLyqHA715bqGHS/zInWLNhWv/fFJqtrPHcKCUiQBx2ORHGgB2UZw=
X-Received: by 2002:a2e:a231:: with SMTP id i17mr12773519ljm.467.1628687709990;
 Wed, 11 Aug 2021 06:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210806143711.37553-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210806143711.37553-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 15:14:59 +0200
Message-ID: <CACRpkda+t4ZhL1bP1a6Cwnh9rYH9Hj59_7VLg45KV+Va5iBR9w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] x86/platform: Increase maximum GPIO number for X86_64
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 6, 2021 at 4:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> By default the 512 GPIOs is a maximum on any x86 platform.
> With, for example, Intel Tiger Lake-H the SoC based controller
> occupies up to 480 pins. This leaves only 32 available for
> GPIO expanders or other drivers, like PMIC. Hence, bump the
> maximum GPIO number to 1024 for X86_64 and leave 512 for X86_32.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks reasonable to me.
The goal with the whole descriptor refactoring is to get this
completely dynamic but it turns out to take forever. It is as it
is.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
