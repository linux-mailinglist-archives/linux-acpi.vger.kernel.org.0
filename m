Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08817A3751
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2019 14:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfH3M5x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Aug 2019 08:57:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:45885 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbfH3M5x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Aug 2019 08:57:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 05:57:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="183793987"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2019 05:57:50 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i3gTN-0007eu-1J; Fri, 30 Aug 2019 15:57:49 +0300
Date:   Fri, 30 Aug 2019 15:57:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 08/10] lib/vsprintf: OF nodes are first and foremost,
 struct device_nodes
Message-ID: <20190830125749.GI2680@smile.fi.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
 <20190829101043.24963-9-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829101043.24963-9-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 29, 2019 at 01:10:41PM +0300, Sakari Ailus wrote:
> Factor out static kobject_string() function that simply calls
> device_node_string(), and thus remove references to kobjects (as these are
> struct device_node).

Not sure. This removes "(%pO?)" error string.

-- 
With Best Regards,
Andy Shevchenko


