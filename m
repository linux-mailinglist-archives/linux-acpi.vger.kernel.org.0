Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2236A89BE
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 21:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbfIDPyR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 11:54:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:10034 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbfIDPyR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Sep 2019 11:54:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 08:54:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="266707021"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 04 Sep 2019 08:54:13 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i5Xbo-0003Vj-Nt; Wed, 04 Sep 2019 18:54:12 +0300
Date:   Wed, 4 Sep 2019 18:54:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 10/11] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190904155412.GU2680@smile.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
 <20190902083240.20367-11-sakari.ailus@linux.intel.com>
 <20190903130607.cf2qv3s3evobbd5g@pathway.suse.cz>
 <20190904150413.GU5475@paasikivi.fi.intel.com>
 <20190904151759.GS2680@smile.fi.intel.com>
 <f62dd153a23bfbe580aee9e50d87c0ff59f4d0ec.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f62dd153a23bfbe580aee9e50d87c0ff59f4d0ec.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 04, 2019 at 08:39:42AM -0700, Joe Perches wrote:
> On Wed, 2019-09-04 at 18:17 +0300, Andy Shevchenko wrote:
> > On Wed, Sep 04, 2019 at 06:04:13PM +0300, Sakari Ailus wrote:
> > > On Tue, Sep 03, 2019 at 03:06:07PM +0200, Petr Mladek wrote:

> > > Good catch. \w indeed matches a single letter; I'll change that to \w+ and
> > > change the other uses accordingly.
> > 
> > It's weird. \w stands for word matching. How can it match one letter only?
> 
> \w 	matches any single character classified as a “word” character (alphanumeric or “_”)

Thank you for explanation!

-- 
With Best Regards,
Andy Shevchenko


