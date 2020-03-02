Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCEAD1759D1
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 12:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgCBL5X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Mar 2020 06:57:23 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:46439 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbgCBL5X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Mar 2020 06:57:23 -0500
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E4BE340016;
        Mon,  2 Mar 2020 11:57:18 +0000 (UTC)
Message-ID: <daeec373292e14c6aea179ddf690a5dace6c83f7.camel@hadess.net>
Subject: Re: [PATCH v3 2/2] touchscreen: goodix: define GPIO mapping for GPD
 P2 Max
From:   Bastien Nocera <hadess@hadess.net>
To:     Peter Cai <peter@typeblog.net>, Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Date:   Mon, 02 Mar 2020 12:57:18 +0100
In-Reply-To: <20190902124352.12291-2-peter@typeblog.net>
References: <20190831030916.13172-1-peter@typeblog.net>
         <20190902124352.12291-1-peter@typeblog.net>
         <20190902124352.12291-2-peter@typeblog.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.35.91 (3.35.91-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2019-09-02 at 20:43 +0800, Peter Cai wrote:
> The firmware of GPD P2 Max could not handle panel resets although
> code
> is present in DSDT. The kernel needs to take on this job instead, but
> the DSDT does not provide _DSD, rendering kernel helpless when trying
> to
> find the respective GPIO pins.
> 
> Fortunately, this time GPD has proper DMI vendor / product strings
> that
> we could match against. We simply apply an acpi_gpio_mapping table
> when
> GPD P2 Max is matched.
> 
> Additionally, the DSDT definition of the irq pin specifies a wrong
> polarity. The new quirk introduced in the previous patch
> (ACPI_GPIO_QUIRK_OVERRIDE_POLARITY) is applied to correct this.

Hans has posted a patchset which reworks GPIO access for ACPI devices.

Could you please check whether you could rebase your patch on top of
that?

I also think the comment in "Input: goodix - Add support for getting
IRQ + reset GPIOs on Cherry Trail devices" might also be of use:

+       case irq_pin_access_acpi_gpio:
+               /*
+                * The IRQ pin triggers on a falling edge, so its gets
marked
+                * as active-low, use output_raw to avoid the value
inversion.
+                */

Cheers

