Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE702A4FEE
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 09:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfIBHaX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 03:30:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:9579 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729408AbfIBHaW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 03:30:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:30:22 -0700
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="357416837"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:30:19 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 3BA0C20B09; Mon,  2 Sep 2019 10:30:17 +0300 (EEST)
Date:   Mon, 2 Sep 2019 10:30:17 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 03/10] device property: Add functions for accessing
 node's parents
Message-ID: <20190902073017.GJ5475@paasikivi.fi.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
 <20190829101043.24963-4-sakari.ailus@linux.intel.com>
 <20190830123448.GB2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830123448.GB2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 30, 2019 at 03:34:48PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 29, 2019 at 01:10:36PM +0300, Sakari Ailus wrote:
> > Add two convenience functions for accessing node's parents:
> > 
> > fwnode_count_parents() returns the number of parent nodes a given node
> > has. fwnode_get_nth_parent() returns node's parent at a given distance
> > from the node itself.
> > 
> > Also reorder fwnode_get_parent() in property.c according to the same order
> > as in property.h.
> 
> > +/**
> > + * fwnode_get_parent - Return parent firwmare node
> > + * @fwnode: Firmware whose parent is retrieved
> 
> I guess you may leave this in the same location. The change will be more clear
> to review and smaller.

I added a separate patch that just moves it up.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
