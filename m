Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F60A2AD67E
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 13:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgKJMjp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 07:39:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:2937 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJMjp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Nov 2020 07:39:45 -0500
IronPort-SDR: PiNzRcTCKGDvj2PsPbyzguueLndRW9Ui3Kymt4TmpXk3HjLYsk3JNb2CPH/vtCaStic9rtIjuC
 aq/1Lwpl+4Hg==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="156971136"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="156971136"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 04:39:43 -0800
IronPort-SDR: CofVXQfwb/b6mTBj+zXm2G4HmzdnMKV8inpcbu1rp3tPvcyJlRu7vcUNwsUYs8kw6OESowXPLt
 cw62KKLX+NYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="428353901"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 10 Nov 2020 04:39:39 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 10 Nov 2020 14:39:39 +0200
Date:   Tue, 10 Nov 2020 14:39:39 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lukasz Stelmach <l.stelmach@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v8 3/6] software node: implement reference properties
Message-ID: <20201110123939.GN1224435@kuha.fi.intel.com>
References: <20201109172435.GJ4077@smile.fi.intel.com>
 <CGME20201109181851eucas1p241de8938e399c0b603c764593b057c41@eucas1p2.samsung.com>
 <dleftj4klypf5u.fsf%l.stelmach@samsung.com>
 <20201109185305.GT1003057@dtor-ws>
 <20201109190551.GM4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109190551.GM4077@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 09, 2020 at 09:05:51PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 09, 2020 at 10:53:05AM -0800, Dmitry Torokhov wrote:
> > On Mon, Nov 09, 2020 at 07:18:37PM +0100, Lukasz Stelmach wrote:
> > > It was <2020-11-09 pon 19:24>, when Andy Shevchenko wrote:
> 
> ...
> 
> > > Probably I have missed something and I will be greatful, if you tell me
> > > where I can find more information about software nodes. There are few
> > > users in the kernel and it isn't obvious for me how to use software
> > > nodes properly.
> > 
> > Yeah, I disagree with Andy here. The lookup tables are a crutch that we
> > have until GPIO and PWM a taught to support software nodes (I need to
> > resurrect my patch series for GPIO, if you have time to test that would
> > be awesome).
> 
> We don't have support for list of fwnodes, this will probably break things
> where swnode is already exist.
> 
> I think Heikki may send a documentation patch to clarify when swnodes can and
> can't be used. Maybe I'm mistaken and above is a good use case by design.

Yeah, the problem is that I'm not sure that we can limit the swnodes
for any specific purpose, or dictate very strictly how they are used
with other possible fwnodes.

Right now I'm thinking we should simply not talk about the
relationship a software node should have or can have with other
fwnodes (regardless of their type) in the swnode documentation.

Br,

-- 
heikki
