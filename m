Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91122A4FDD
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 09:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfIBH2L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 03:28:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:65228 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfIBH2L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 03:28:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:28:10 -0700
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="186935638"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:28:07 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 73F4620B09; Mon,  2 Sep 2019 10:28:05 +0300 (EEST)
Date:   Mon, 2 Sep 2019 10:28:05 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 08/10] lib/vsprintf: OF nodes are first and foremost,
 struct device_nodes
Message-ID: <20190902072805.GH5475@paasikivi.fi.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
 <20190829101043.24963-9-sakari.ailus@linux.intel.com>
 <20190830125749.GI2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830125749.GI2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 30, 2019 at 03:57:49PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 29, 2019 at 01:10:41PM +0300, Sakari Ailus wrote:
> > Factor out static kobject_string() function that simply calls
> > device_node_string(), and thus remove references to kobjects (as these are
> > struct device_node).
> 
> Not sure. This removes "(%pO?)" error string.

Indeed. I'll add it back for v4.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
