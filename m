Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EE332C43E
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386182AbhCDAMC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:12:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:26126 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1574868AbhCCReY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Mar 2021 12:34:24 -0500
IronPort-SDR: OwyyyKoV+wBPHpl/+PeB08mFPMt89LEoQSZOT9xNqiw0ZKnyIeU7Hvk5BdQa2XJZFBf04rXfG1
 yjjIvJR8zGGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="187301053"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="187301053"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 09:32:34 -0800
IronPort-SDR: zMj+V3njivalQjcn+UbeH+euTLkcj4GIal1DDurCNWWScfNNHUCDBBTOA9CWqdiymks9ovkx8c
 RDmg/pxkgMsw==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="367686672"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 09:32:31 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lHVMK-009h2t-Rl; Wed, 03 Mar 2021 19:32:28 +0200
Date:   Wed, 3 Mar 2021 19:32:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
Message-ID: <YD/ILDHaJ5uG2Htx@smile.fi.intel.com>
References: <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
 <YDjZOU+VMWasjzUb@smile.fi.intel.com>
 <20210227031944.GB24428@dragon>
 <YDzbQqHspfvpYS7Z@smile.fi.intel.com>
 <20210302002725.GE24428@dragon>
 <YD4twyAGvDDOCv+n@smile.fi.intel.com>
 <abbfcdfa-c287-3828-ed6f-bc1e1f13c6b2@codeaurora.org>
 <20210303094300.GB17424@dragon>
 <41593c7e-368b-cfb8-b24a-2e4dca48b465@codeaurora.org>
 <YD+yBmPrKm1n8Tjm@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD+yBmPrKm1n8Tjm@builder.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 03, 2021 at 09:57:58AM -0600, Bjorn Andersson wrote:
> On Wed 03 Mar 09:10 CST 2021, Jeffrey Hugo wrote:

...

> I added the table in the driver, see sc8180x_pdc_map[], and it has gpio
> 14 at position 7, with the 14th entry being gpio 38 - which seems like
> an unlikely change from the reference schematics.

It means for the certain platform this table should be altered (perhaps simply
another table based on IDs or so can be provided).

-- 
With Best Regards,
Andy Shevchenko


