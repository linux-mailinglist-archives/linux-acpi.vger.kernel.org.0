Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8224C3443D2
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Mar 2021 13:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhCVMyo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Mar 2021 08:54:44 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40152 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232816AbhCVMww (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Mar 2021 08:52:52 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1lOK32-00COle-Gt; Mon, 22 Mar 2021 13:52:44 +0100
Date:   Mon, 22 Mar 2021 13:52:44 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] gpio: Support interrupts in gpio-mlxbf2.c
Message-ID: <YFiTHIy5Amf583X3@lunn.ch>
References: <1614120685-7452-1-git-send-email-Asmaa@mellanox.com>
 <1614120685-7452-2-git-send-email-Asmaa@mellanox.com>
 <CH2PR12MB38958655696585998CFDF67BD7919@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdYVBCByG-g8jCrzdQMwdQ_7Vm0_adtVyGFzUiJJWAeNPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYVBCByG-g8jCrzdQMwdQ_7Vm0_adtVyGFzUiJJWAeNPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 22, 2021 at 01:41:58PM +0100, Linus Walleij wrote:
> On Wed, Mar 10, 2021 at 9:38 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:
> 
> > > That's fine, the hardware description model (I guess in your case
> > > ACPI) should take care of that.
> > >
> > We cannot really pass it through the ACPI table because the ACPI
> > table is common to all BlueField-2 boards. And each board may have
> > a different GPIO pin associated with a particular function. This is
> > why we use ACPI properties instead of GpioInt(). So that the
> > bootloader can change the GPIO pin value based on the board
> > id detected at boot time.
> (...)
> > Yes. It would belong in the ACPI table if we had a different ACPI
> > table for each board. But unfortunately that is not the case.
> 
> You have to agree with Andy about all ACPI details.
> 
> Andy is the ACPI GPIO maintainer and we cannot merge
> a patch with any kind of ACPI support without his ACK,
> so hash it out as he wants it. The only people on the
> planet that can make me think otherwise is if Rafael
> Wysocki and Mika Westerberg say something else,
> which is *extremely* unlikely.

+1

And given this is burried inside a network driver, you are also going
to get push back from the networking maintainers to do this correctly.

   Andrew
