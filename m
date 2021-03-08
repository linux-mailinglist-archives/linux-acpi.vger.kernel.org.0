Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2517F3315D1
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 19:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCHSWa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 13:22:30 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:34406 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCHSWO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Mar 2021 13:22:14 -0500
Received: by mail-oi1-f169.google.com with SMTP id x78so11994060oix.1;
        Mon, 08 Mar 2021 10:22:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UnjQ2wPecXS8s9DsmO8FMVOXE9Rl+/KN9deAHDlCATo=;
        b=M8QOQYSrOSUzO6wZz7t7/fw45e6tVefMyLRuon+iXHFhglTI+vYgOT9cK+BBirUefB
         9ykoFPxYSJjrwrJjBLd9vJSJzmbV+4legGrCMl3CJmVy6BP0lLkkg4WRS8AEjGI6o6df
         MA6G4kMgGMDkabphMuRkC4gvn/NrXQSC6eUL2GCF5SEoMPdvB27wLIKEYv8lQEt3CDv1
         mLW3pDmqykohws0fxcPkA3xlA4Ous89FpRdEiLQsa4WOQiBGdaT4KN3IgnFXJ9DgqyDc
         k730txZrlHJf2aVxanVhR8Q9zXxkgxusQBNpSBXQu3SOBeXHDup5doLggVWd215uW9Qz
         A6OA==
X-Gm-Message-State: AOAM530gyaJboGFBxLtalOGs1hfQ90zHN9IEYlvzfiT1lMfiSOuK/rDG
        ItpOSU78SFqcpmS4MyS3WeHSiXwjEpDmZdsZNbY=
X-Google-Smtp-Source: ABdhPJzyrorBBnxfzWygYPvRZujw3o3UGZXv0kmeuEiTCfnrwxfKRX1zqukpOGcKKBzUKS9gJ0yq0dktcRlvSWDrQt4=
X-Received: by 2002:aca:3d85:: with SMTP id k127mr68539oia.157.1615227734294;
 Mon, 08 Mar 2021 10:22:14 -0800 (PST)
MIME-Version: 1.0
References: <20210304201253.14652-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210304201253.14652-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Mar 2021 19:22:03 +0100
Message-ID: <CAJZ5v0gR=gN2ROo9JSOGHokw5imscMBwDERni8X83p0eWt634w@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] gpiolib: switch to fwnode in the core
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
>
> GPIO library uses of_node and fwnode in the core in non-unified way.
> The series cleans this up and improves IRQ domain creation for non-OF cases
> where currently the names of the domain are 'unknown'.
>
> This has been tested on Intel Galileo Gen 2.
>
> In v3:
> - fix subtle bug in gpiod_count
> - make irq_domain_add_simple() static inline (Marc)
>
> In v2:
> - added a new patch due to functionality in irq_comain_add_simple() (Linus)
> - tagged patches 2-4 (Linus)
> - Cc'ed to Rafael
>
> Andy Shevchenko (5):
>   irqdomain: Introduce irq_domain_create_simple() API
>   gpiolib: Unify the checks on fwnode type
>   gpiolib: Move of_node operations to gpiolib-of and correct fwnode use
>   gpiolib: Introduce acpi_gpio_dev_init() and call it from core
>   gpiolib: Reuse device's fwnode to create IRQ domain

[1-4/5] applied as 5.13 material and I have a minor comment regarding
the last patch (will send separately).

Thanks!
