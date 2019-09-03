Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6060FA6764
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2019 13:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfICL2E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Sep 2019 07:28:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:11167 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728270AbfICL2E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Sep 2019 07:28:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 04:28:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; 
   d="scan'208";a="266262707"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 03 Sep 2019 04:28:01 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i56ye-0008GR-7d; Tue, 03 Sep 2019 14:28:00 +0300
Date:   Tue, 3 Sep 2019 14:28:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 09/11] lib/vsprintf: OF nodes are first and foremost,
 struct device_nodes
Message-ID: <20190903112800.GW2680@smile.fi.intel.com>
References: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
 <20190902135732.23455-10-sakari.ailus@linux.intel.com>
 <20190903085233.oksjcwqwdxb53eig@pathway.suse.cz>
 <20190903092816.qutqnjba7okcauim@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903092816.qutqnjba7okcauim@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 03, 2019 at 11:28:16AM +0200, Petr Mladek wrote:
> On Tue 2019-09-03 10:52:33, Petr Mladek wrote:
> > On Mon 2019-09-02 16:57:30, Sakari Ailus wrote:
> > > Factor out static kobject_string() function that simply calls
> > > device_node_string(), and thus remove references to kobjects (as these are
> > > struct device_node).

> > > -		return kobject_string(buf, end, ptr, spec, fmt);
> > > +		return device_node_string(buf, end, ptr, spec, fmt + 1);
> > 
> > I know that this come from from kobject_string(). But please, modify
> > it to follow the style used by other %p modifiers. I mean to pass
> > "fmt" as is and then use:
> > 
> > 	if (fmt[1] != 'F')
> 
> Ah, I see that it would need more changes in device_node_string().
> OK, let's leave the patch as is. I am sorry for the noise.

I came to the same conclusions, though can we consider to drop this patch?

-- 
With Best Regards,
Andy Shevchenko


