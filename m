Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60B72DE20
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Apr 2019 10:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfD2Ikk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Apr 2019 04:40:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42376 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfD2Ikj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Apr 2019 04:40:39 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 3f40e1ef396ec110; Mon, 29 Apr 2019 10:40:37 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Yue Haibing <yuehaibing@huawei.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3] gpio: merrifield: Fix build err without CONFIG_ACPI
Date:   Mon, 29 Apr 2019 10:40:37 +0200
Message-ID: <1693119.KP9SAZBlm1@kreacher>
In-Reply-To: <20190426122317.GP9224@smile.fi.intel.com>
References: <20190405142112.26592-1-yuehaibing@huawei.com> <CACRpkda_xw2rdzSLcreHnfdwsmUMTR=+BRHJWjrE31COaZhtZw@mail.gmail.com> <20190426122317.GP9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, April 26, 2019 2:23:17 PM CEST Andy Shevchenko wrote:
> On Tue, Apr 23, 2019 at 11:17:32AM +0200, Linus Walleij wrote:
> > On Fri, Apr 12, 2019 at 5:20 PM Yue Haibing <yuehaibing@huawei.com> wrote:
> > 
> > > From: YueHaibing <yuehaibing@huawei.com>
> > >
> > > When building CONFIG_ACPI is not set
> > > gcc warn this:
> > >
> > > drivers/gpio/gpio-merrifield.c: In function mrfld_gpio_get_pinctrl_dev_name:
> > > drivers/gpio/gpio-merrifield.c:388:19: error: dereferencing pointer to incomplete type struct acpi_device
> > >    put_device(&adev->dev);
> > >                    ^~
> > >
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Fixes:d00d2109c367 ("gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()")
> > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > 
> > This doesn't apply cleanly to any GPIO branch (devel or fixes)
> > so I assume it is supposed to be applied to the ACPI tree.
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Thanks!
> Rafael, can this be applied to your tree?

Done already, thanks!



