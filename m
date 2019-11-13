Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B000AFAD93
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2019 10:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKMJsN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Nov 2019 04:48:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43527 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfKMJsN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Nov 2019 04:48:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id y23so1781457ljh.10
        for <linux-acpi@vger.kernel.org>; Wed, 13 Nov 2019 01:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8wWPeVlxP12uFhWBWhUM2EQL5na81+2nwYPn3zw0yc=;
        b=gDtzJC28NlmXeZiJmIKE9Qz+Nir1oEniQBbLai/rrcacDhIUd+glk2A11lbxsk7w4Y
         qJtL2hFy1wUrl5w/bFUgWydUJ4p/Sz82Q99D0kDF5A1F7IOfNIJdCk1IpHN0RVpqkfVK
         FXTmmrjXsRyOr6giqiH+jsppUR10snvjXB20YR7sJrqYbBWS+/ruQeer2N041sgzgi3Y
         dWvAqNpGI69gyF5c8sYzYCTFDsjkrA82k+iOgIXS+iDlEJCNHpokg3521gCxH9Y1n8p/
         1aOW5Cktd8OpCwcILp1P3MIuKdXI2N07ziDh5DYsYd4BcUjmqU0RMMOY/nMSs8WcQUgX
         n3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8wWPeVlxP12uFhWBWhUM2EQL5na81+2nwYPn3zw0yc=;
        b=mnXgLm/RxCCfhl6QravgOL1pbPeLpIACj+jBXMvGQJj4Aero8EuSiUORuUFm6/W4yy
         3YMa4Zs6/voWziQ5SsSk8xrPhwwKbYVB0LUpdIq7kfjlVP+I2DHCygOiaCYePFX6VEJn
         oEx8AzR7P/wVC/jOnloy7f7Gewcfqm4NYq+azFhbl+NmhdhHHh60xZQVD8Qyiv2OL+PG
         HLkpzOIqXac/7eobAi2GITHKKs9yI9XhPycXc88mfcPN0GmaRzuqYSffWRW2Su+F2lH1
         Z4I4gzn4Olew0UqnncfpGvw1ZvQww7Um1yPrChI5uSpAVEFjnHHkoZdkYDD0zb/18Dcw
         G3Kg==
X-Gm-Message-State: APjAAAWmgF4zY9K6FfzZfRklsYZKVcR5zyuVa0g0FLs6NCvy66Db2pmu
        wvooBuBc+nHoTldyQndQzITyUWgAhHVK+hSdxO72CBJI/+w=
X-Google-Smtp-Source: APXvYqx+oO/wZZVcmNlHrY/wGD3B3azI1/sGwCtgVyPgIZiRzdhe/sAfrwTVxdFm9E0QYhm1PmbdJlXPZOUS6ScYo5U=
X-Received: by 2002:a2e:5c46:: with SMTP id q67mr1840767ljb.42.1573638490344;
 Wed, 13 Nov 2019 01:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20191106115109.119346-1-hdegoede@redhat.com>
In-Reply-To: <20191106115109.119346-1-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Nov 2019 10:47:58 +0100
Message-ID: <CACRpkdbchDjcqfR2dgebNxJds206HTmKbQXXzoy8A2s-J85soA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add Terra Pad 1061 to the run_edge_events_on_boot_blacklist
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 6, 2019 at 12:51 PM Hans de Goede <hdegoede@redhat.com> wrote:

> The Terra Pad 1061 has the usual micro-USB-B id-pin handler, but instead
> of controlling the actual micro-USB-B it turns the 5V boost for the
> tablet's USB-A connector and its keyboard-cover connector off.
>
> The actual micro-USB-B connector on the tablet is wired for charging only,
> and its id pin is *not* connected to the GPIO which is used for the
> (broken) id-pin event handler in the DSDT.
>
> While at it not only add a comment why the Terra Pad 1061 is on the
> blacklist, but also fix the missing comment for the Minix Neo Z83-4 entry.
>
> Fixes: 61f7f7c8f978 ("gpiolib: acpi: Add gpiolib_acpi_run_edge_events_on_boot option and blacklist")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied for fixes.

Yours,
Linus Walleij
