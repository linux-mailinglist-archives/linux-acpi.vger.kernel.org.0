Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBC02B0A4D
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 17:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgKLQmR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 11:42:17 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:34926 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgKLQmR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 11:42:17 -0500
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 89C133B14FE
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 16:36:41 +0000 (UTC)
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 0518A24000E;
        Thu, 12 Nov 2020 16:36:17 +0000 (UTC)
Date:   Thu, 12 Nov 2020 17:36:17 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Tin Huynh <tnhuynh@apm.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 1/3] rtc: ds1307: Remove non-valid ACPI IDs
Message-ID: <20201112163617.GE4556@piout.net>
References: <20201112155753.36834-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112155753.36834-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/11/2020 17:57:51+0200, Andy Shevchenko wrote:
> The commit 9c19b8930d2c ("rtc: ds1307: Add ACPI support") added non-valid
> ACPI IDs (all of them abusing ACPI specification). Moreover there is
> no even a single evidence that vendor registered any of such device.
> 
> Remove broken ACPI IDs from the driver. For prototyping one may use PRP0001
> with device tree defined bindings. The following patches will add support
> of that to the driver.

I'm intrigued, how does PRP0001 work? Where would the device tree come
from?

You probably want to have a look at:
https://lore.kernel.org/linux-rtc/20201112130734.331094-3-ch@denx.de/T/#u

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
