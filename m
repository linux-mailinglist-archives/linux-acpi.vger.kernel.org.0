Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83E65A4F56
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 08:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfIBGqj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 02:46:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:62434 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbfIBGqj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 02:46:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2019 23:46:39 -0700
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="198526756"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2019 23:46:37 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 2F82220B09; Mon,  2 Sep 2019 09:46:05 +0300 (EEST)
Date:   Mon, 2 Sep 2019 09:46:05 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 01/10] software node: Get reference to parent swnode
 in get_parent op
Message-ID: <20190902064605.GB5475@paasikivi.fi.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
 <20190829101043.24963-2-sakari.ailus@linux.intel.com>
 <20190830122237.GY2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830122237.GY2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 30, 2019 at 03:22:37PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 29, 2019 at 01:10:34PM +0300, Sakari Ailus wrote:
> > The software_node_get_parent() returned a pointer to the parent swnode,
> > but did not take a reference to it, leading the caller to put a reference
> > that was not taken. Take that reference now.
> > 
> 
> > Fixes: 59abd83672f7 ("drivers: base: Introducing software nodes to the
> > 		      firmware node framework")
> 
> I dunno if scripts parse the split line like above.
> 
> Nevertheless, for the code prospective looks good to me. Though you probably
> would like to Cc it to Heikki.

I will cc him for v4.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
