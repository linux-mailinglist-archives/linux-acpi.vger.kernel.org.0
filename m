Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0424127AAE7
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Sep 2020 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgI1Jhq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Sep 2020 05:37:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:57449 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbgI1Jhq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Sep 2020 05:37:46 -0400
IronPort-SDR: RzH+KJLeFLsHzISHZ8XxRJrO+YuhijVXafDEa6n2HbJ7ziecep3xqJYvX2oIo/fxm13xXJ/xNH
 BJZwRIbSssHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="226115560"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="226115560"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 02:37:45 -0700
IronPort-SDR: FmBYh7J3ODuTzBO2WMNYSdVb2e1r18oVHokD32Z5WGhv4Bwoxs9B/oeb5l+FwVbZmjfzdwLSus
 A2Yq2G+KIpzA==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="456755403"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 02:37:40 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 40DFA207A0; Mon, 28 Sep 2020 12:37:38 +0300 (EEST)
Date:   Mon, 28 Sep 2020 12:37:38 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Marek Behun <marek.behun@nic.cz>, linux-leds@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH leds v2 05/50] leds: various: guard of_match_table member
 value with of_match_ptr
Message-ID: <20200928093738.GA26842@paasikivi.fi.intel.com>
References: <20200917223338.14164-1-marek.behun@nic.cz>
 <20200917223338.14164-6-marek.behun@nic.cz>
 <20200918061500.GD26842@paasikivi.fi.intel.com>
 <20200918112058.6d3b0d5d@nic.cz>
 <20200918095759.GG26842@paasikivi.fi.intel.com>
 <20200928080336.GA4637@dell>
 <20200928081114.GB4637@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200928081114.GB4637@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Lee,

On Mon, Sep 28, 2020 at 09:11:14AM +0100, Lee Jones wrote:
> On Mon, 28 Sep 2020, Lee Jones wrote:
> 
> > On Fri, 18 Sep 2020, Sakari Ailus wrote:
> > 
> > > On Fri, Sep 18, 2020 at 11:20:58AM +0200, Marek Behun wrote:
> > > > On Fri, 18 Sep 2020 09:15:00 +0300
> > > > Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> > > > 
> > > > > Hi Marek,
> > > > > 
> > > > > On Fri, Sep 18, 2020 at 12:32:53AM +0200, Marek Behún wrote:
> > > > > > Change
> > > > > >   .of_match_table = xxx,
> > > > > > to
> > > > > >   .of_match_table = of_match_ptr(xxx),
> > > > > > in various drivers.
> > > > > > 
> > > > > > This should be standard even for drivers that depend on OF.  
> > > > > 
> > > > > After this patch, none of these drivers will work on ACPI systems anymore.
> > > 
> > > ^
> > > 
> > > If CONFIG_OF is disabled, that is.
> > 
> > What?  of_match_ptr() is designed to change depending on OF or !OF.
> > 
> > Are you confusing this with acpi_match_table()?
> 
> Okay, I just grepped the kernel and found some OF matching in the ACPI
> bus code.  This seems odd to be (at first sight at least).  I'm not
> entirely sure how this is supposed to work, but when you disable OF,
> one could reasonably expect any matching utilising OF based tables to
> be disabled too.

There's really no reason having to enable the entire OF framework just to
allow compatible string matching.

> 
> Not using of_match_ptr() on ACPI enabled platforms sounds batty to
> me.  If this is valid, perhaps the of_match_ptr()semantics should be
> changed to include ACPI.

That'd be one option, yes. But not all drivers that work on both OF and
ACPI rely on the compatible strings on ACPI.

Another option could be adding a new macro, to set that table on both OF
and ACPI when needed? It could be called e.g. of_acpi_match_ptr(), for
instance.

Cc also linux-acpi list and Rafael.

-- 
Regards,

Sakari Ailus
