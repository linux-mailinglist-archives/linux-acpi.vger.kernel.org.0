Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E65619B0E
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Nov 2022 16:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiKDPKP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Nov 2022 11:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiKDPKN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Nov 2022 11:10:13 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E02DCE32
        for <linux-acpi@vger.kernel.org>; Fri,  4 Nov 2022 08:10:11 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id n68so4619115vsc.3
        for <linux-acpi@vger.kernel.org>; Fri, 04 Nov 2022 08:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YAwBDkIAtIBDNt5L2u1kCaJTDfLOL3ZRkXytH05z5qg=;
        b=x8MXBUA56mMRv9UOLz5WNRX0Ob0S78eUI08o1E1lcX3wI4ykcSk0SAplzbeFlbtg5X
         KFFBDk9R2XF1UMvdDd6AXgwkh+3p/L8d98+eXXxqdA+vkMdpjRBMOnBhT2Pve/QMowxl
         Z6Pw1QiR6M2NCUK19NmE/4kH4Uem0vVrmkqPnm8ATukqxavrw4VYsMSsLHC3G6AXFvEQ
         +Nd3zfToovh6czTQyCQ5cXybtaDGjM8zB0u51ZGrAJwd6BK2ddZcsGsGbPYY4OFcCW43
         OU9fSYVCaAOhgF1JPWiJFj305PXm5+WKNu6qZ3rRs2qjfzh27l6BXp/vz0xo9/18oOaP
         v54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAwBDkIAtIBDNt5L2u1kCaJTDfLOL3ZRkXytH05z5qg=;
        b=J7Snsikvq1sfzl8zRqzrMtYEOWwxu1WlNw4MmWkd6sWe+iskdCvuwtzFlZVFiHEPjM
         2Qz9aJfunANcDrX9z2eC2c4CkeAp1/tSF4+k9RzQZpG4IszV6nQUT4FBumdhDBglhGH/
         zM454FcdL2n7HsmRGObHIJ1qCzFyxvRP4GR6li0bCtNe5uPKyOdUKuyWWHwPf8u32fti
         ojXY/O/55szPPAaiDmHY4JoO7egs47Zho/koJqyi21eeJh7BmRDkDZE5hNMl2CaDwiP5
         CtilOJYVKdhLlJ9Zc6kjeOug6hco8m8K4iXG7Aojmn1vLftwYFkNUOnl4Ut+XDD6WhiE
         5SYA==
X-Gm-Message-State: ACrzQf1Zon5jsvLrFGvFHDsDDDxv9wFlMV/NX7KxIB6cCy9sXBfQ374d
        ggVmQbE803GpAX1h7tmKkseFaHPtfusorGYuliJ03A==
X-Google-Smtp-Source: AMsMyM6oV2D5vVn+fC0RSecgHmq+3QWbsUa/GttIAESJ1hfdNfvX1EhVWoSsO52NlgsXJf2lEiiz7sptGJZOBd6EE48=
X-Received: by 2002:a05:6102:11a:b0:3a7:769c:6dee with SMTP id
 z26-20020a056102011a00b003a7769c6deemr295005vsq.13.1667574610136; Fri, 04 Nov
 2022 08:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221103180643.79352-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221103180643.79352-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 4 Nov 2022 16:09:59 +0100
Message-ID: <CAMRc=McicB36evBh5thWPtnMPuzbfY+4m29i6Mp-1tJSw9OvjQ@mail.gmail.com>
Subject: Re: [rft, PATCH v2 1/1] gpiolib: Get rid of not used of_node member
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 3, 2022 at 7:06 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> All new drivers should use fwnode and / or parent to provide the
> necessary information to the GPIO library.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

This looks good to me. I'm thinking about just applying it and giving
it a spin in next right away.

Linus: any objections?

Bartosz
