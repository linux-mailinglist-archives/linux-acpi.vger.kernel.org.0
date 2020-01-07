Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11E751323B4
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2020 11:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgAGKfa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jan 2020 05:35:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37858 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgAGKfa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jan 2020 05:35:30 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so38523211lfc.4
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jan 2020 02:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9L6amKhoYyOrux9bnk+af4N4r2mBmGPfOuS8aRLMwhg=;
        b=b3uBNQ9bL0Rm0U0fYnJKypGOuWiZl+gYV3Zab1iuTg+6OVZlBzuFugeCNw1MQTCFkN
         3g54n3ju0EKUXogzFtXgt9xSBLz2zNbeoKAx7o3LzBdhmnQIVQ7fXB1R3MJlsbbnIpEc
         Td0NHo20vQ6szBG2bWBCkJx9rt/WUX30CqdQKpxw53+edrtwryaUWeFUnCACCEhUolaJ
         MtPBNVNqkqD+OGmtWv9INMWt6bRyGteMhAYtku/o8/bPQy0quOn5PE1P4MJeiTIbPHPj
         ALu3+vvLSEQPa4knxZt8cB4DuXmTgFK6kdL50DcdLKBE1qJMpj6gWXbJUQjLUKNQdr9O
         2ViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9L6amKhoYyOrux9bnk+af4N4r2mBmGPfOuS8aRLMwhg=;
        b=DbTY6N8FQGdWDmymPRWAXWPjF5AbygwHR6n3yFvRqMCJYEX2UebhN4sY6/ug93pfAn
         RjaLAbYktu0rpE+JElSwc1Uv50/nAP91SMIpdaM4hKJKhb0Nh+IbECYOBbi+EKoc22RY
         Tt/4fQNGJwhNIdCM3Qi/Tt4beKPSo3IzRGHs4FIv+/MMo6mhw5QiglAyYtTTILBH6Wbd
         GaZZp2JGs7dt9qwwsXJ1Ff/W+p7z0tjhzzXMSUKl3FTqX53xv1h8J7RrxULGenvpDVGG
         9Iw2DM0rjmqforpnxufcwXznkHoxzn+agk2DB2ZaoFGjDNCyMXy/OGzqjMUIzOGy0utK
         5o2w==
X-Gm-Message-State: APjAAAXOTvLH3MBiq02rG5C4hI3ITM2wCWjm8pD+wtnSpizSqdPZ+S3v
        xb+v33sCf55pDOHg6IBLqMd4VQn7mztToYKlpN1nWyrOBlg=
X-Google-Smtp-Source: APXvYqwnBmZ4C+qwBklDTAQj/VsW+ZK44EVkNgdlyTwnOhfThUt0pp3AtFsnFlSbQJX3beIx2opfQ6TrxZqyuOD8rVs=
X-Received: by 2002:a19:c648:: with SMTP id w69mr58975631lff.44.1578393328640;
 Tue, 07 Jan 2020 02:35:28 -0800 (PST)
MIME-Version: 1.0
References: <20191227230447.32458-1-hdegoede@redhat.com>
In-Reply-To: <20191227230447.32458-1-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 11:35:17 +0100
Message-ID: <CACRpkdaR4vFp=huuqvsnZTFnAmKNJmjpwM8sPpVX2aERp-LogA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: baytrail: Do not clear IRQ flags on direct-irq
 enabled pins
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Dec 28, 2019 at 12:04 AM Hans de Goede <hdegoede@redhat.com> wrote:

> Suspending Goodix touchscreens requires changing the interrupt pin to
> output before sending them a power-down command. Followed by wiggling
> the interrupt pin to wake the device up, after which it is put back
> in input mode.
>
> On Bay Trail devices with a Goodix touchscreen direct-irq mode is used
> in combination with listing the pin as a normal GpioIo resource.
>
> This works fine, until the goodix driver gets rmmod-ed and then insmod-ed
> again. In this case byt_gpio_disable_free() calls
> byt_gpio_clear_triggering() which clears the IRQ flags and after that the
> (direct) IRQ no longer triggers.
>
> This commit fixes this by adding a check for the BYT_DIRECT_IRQ_EN flag
> to byt_gpio_clear_triggering().
>
> Note that byt_gpio_clear_triggering() only gets called from
> byt_gpio_disable_free() for direct-irq enabled pins, as these are excluded
> from the irq_valid mask by byt_init_irq_valid_mask().
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied as non-critical fix for v5.6 with Mika's ACK.
(Tell me if it's critical.)

Yours,
Linus Walleij
