Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190D26729A1
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jan 2023 21:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjARUo5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Jan 2023 15:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjARUov (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jan 2023 15:44:51 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0085F3BE
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2023 12:44:49 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id e130so10187871yba.7
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2023 12:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lxN0ifRPJLWymSPxr4LmL30NaXej0tc2KddBtHP7xgk=;
        b=o/L/KAVnrxKsg6wfxIIKKTthzenbBpd8Yyjgu45Qrq8xfHYi9SJZ4WC3ePKrhqyRNg
         0YWgPVF65SgQmhgKuSIT8Z35J7QzxNWKbJ7Mch1d4dIbub2+03oxAQhJ3OzwtUGbSDu6
         IeONYzFGg8zICe9wX7jtU34Q+HHNzy3/mSlT0m9BQdc2iwNhYeYVxLOpuafpOJl8J6bV
         es/KDYitXm0tt3HDdtiL2CEMzzYymJFNp2e1nyvq1m7OWfjdXl6a93j+FNHDWO6yHfx+
         NjPLHNd1ZZULF1ATwHQ8s0jR0DUFaww5AQ+dNZmrpw04Vc/hiUi9H2jaK1McDF3hyape
         MYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxN0ifRPJLWymSPxr4LmL30NaXej0tc2KddBtHP7xgk=;
        b=gd6F2BulPjf8LaAFxjTTHMQywDf8Arhc8N4OFrL4u7WfVX5S7tnVfVdVEYyPezaQ8Y
         0HDMQTpt7SdtvcFKjR2FvChMASfEnjowwgo9wOGmYbbV2R6gRKM2l8Fni1IZ0QGs3uAE
         MT0NrIJLMQRQoUjq7WD3cVjbP5wKUsAIEZdKcHZf+cYU4g+9t9BhKf/4cAjFOJnqhYzc
         zlDlIdXdCLMXzf1/5TPzPGm5Y6uoFKIrS8pbLZuGWcdk9QvtsVnAPVpY9mEK2r67wb26
         tAF2x1lzDS8Ir6Lr88mh3VzSq4fHEFXYaa8znpLS/Eiw3HlBG+G50DL/qzEwz8T4xWiC
         Hh5g==
X-Gm-Message-State: AFqh2kovfOWSHww0alXdqJgVCTLtuBew9cbLNV0+9CFRZdZ35wiVwuxZ
        JdHbJd0rFnclwLIOjoyTRjEYhVuRbfJnn3xEzIBN2w==
X-Google-Smtp-Source: AMrXdXsmCi/frVC6VtreQlaKByYSty9vXl8uhPqMcWmgUNLPIBdL7eylfPOfYiXjvhn0Wg/c/y6sw3UwLYqAp0TyoEk=
X-Received: by 2002:a25:9d88:0:b0:7c0:acd2:6300 with SMTP id
 v8-20020a259d88000000b007c0acd26300mr858664ybp.520.1674074689110; Wed, 18 Jan
 2023 12:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20230116193702.31356-1-mario.limonciello@amd.com> <20230116193702.31356-3-mario.limonciello@amd.com>
In-Reply-To: <20230116193702.31356-3-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Jan 2023 21:44:37 +0100
Message-ID: <CACRpkdaX+ZVA7zQDnADEi5KPpfd-gwsxPsKaZo5FxEmgjv4S3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xRU
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        regressions@lists.linux.dev,
        Werner Sembach <wse@tuxedocomputers.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jan 16, 2023 at 8:37 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> However on Clevo NL5xRU there is a mistake in the ACPI tables that the
> TP_ATTN# signal connected to GPIO 9 is configured as ActiveLow and level
> triggered but connected to a pull up. As soon as the system suspends the
> touchpad loses power and then the system wakes up.

Now that is what I call proper root cause analysis. Hats off for this patch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
