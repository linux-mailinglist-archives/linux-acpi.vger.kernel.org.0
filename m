Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D548131A8D7
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Feb 2021 01:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhBMAhp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 19:37:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhBMAhn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Feb 2021 19:37:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 114BF600EF;
        Sat, 13 Feb 2021 00:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613176623;
        bh=piCxSYqyaRHUq0PJ0knbPXrBei/xJDhxVO2a2ca10jw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hXeGnHSIEyZOzMpm9rArG5rX0aeTeRIi/cJd+3AhH70qUvgxeDbFSmZYSNGH/gaOZ
         /3o4QiqURfA+gippC46uJsp2mLYT4+6SBWPjMpk4x3Y3DzXsPzTGBlSnyrpnPFQCaI
         5jF10OY04XCtMJ149AZUCZeN0TCz92IlXxa09oQhXvmYgwiTUyT/ZIRewlkRSjpc87
         Z9AAhbxyTwietL8/yUE4w67QYJwfbZNQBl8Mm0tJtW0zsghwS4fDXxSDpoRVVf6bko
         IIdlgq8CdlT71mIgLtGrkRdVbsyPYReYvgpWPejZEh3V4Mf669MkHJp5PnNY+ICYRU
         vdVh2NEqlF0cQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YCUqgwrCREvPqEz+@kroah.com>
References: <20210205222644.2357303-9-saravanak@google.com> <20210210114435.122242-1-tudor.ambarus@microchip.com> <20210210114435.122242-2-tudor.ambarus@microchip.com> <YCUqgwrCREvPqEz+@kroah.com>
Subject: Re: [PATCH] clk: Mark fwnodes when their clock provider is added
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     corbet@lwn.net, rafael@kernel.org, khilman@kernel.org,
        ulf.hansson@linaro.org, len.brown@intel.com, lenb@kernel.org,
        pavel@ucw.cz, mturquette@baylibre.com, robh+dt@kernel.org,
        frowand.list@gmail.com, maz@kernel.org, tglx@linutronix.de,
        saravanak@google.com, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, m.szyprowski@samsung.com,
        geert@linux-m68k.org, kernel-team@android.com
To:     Greg KH <gregkh@linuxfoundation.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Date:   Fri, 12 Feb 2021 16:37:01 -0800
Message-ID: <161317662151.1254594.5584491663697731523@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Quoting Greg KH (2021-02-11 05:00:51)
> On Wed, Feb 10, 2021 at 01:44:35PM +0200, Tudor Ambarus wrote:
> > This is a follow-up for:
> > commit 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is ad=
ded/removed")
> >=20
> > The above commit updated the deprecated of_clk_add_provider(),
> > but missed to update the preferred of_clk_add_hw_provider().
> > Update it now.
> >=20
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
