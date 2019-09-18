Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8067B66F5
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2019 17:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfIRPWY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Sep 2019 11:22:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:41972 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfIRPWY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Sep 2019 11:22:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 08:22:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,521,1559545200"; 
   d="scan'208";a="186494395"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2019 08:22:19 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iAbmb-0001OA-Nd; Wed, 18 Sep 2019 18:22:17 +0300
Date:   Wed, 18 Sep 2019 18:22:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        linux-trace-devel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v7 01/13] tools lib traceevent: Convert remaining %p[fF]
 users to %p[sS]
Message-ID: <20190918152217.GR2680@smile.fi.intel.com>
References: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
 <20190918133419.7969-2-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918133419.7969-2-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 18, 2019 at 04:34:07PM +0300, Sakari Ailus wrote:
> There are no in-kernel %p[fF] users left. Convert the traceevent tool,
> too, to align with the kernel.

>  function. The _tep_ argument is the trace event parser context. The _name_ is
> -the name of the function, the string is copied internally. The _addr_ is
> -the start address of the function. The _mod_ is the kernel module
> -the function may be in (NULL for none).
> +the name of the function, the string is copied internally. The _addr_ is the
> +start address of the function. The _mod_ is the kernel module the function may
> +be in (NULL for none).

I think this is unneeded churn (reformating string). But since maintainer Acked
this, I don't care much. But think about burden to the Git index in million of
instances around the world.

-- 
With Best Regards,
Andy Shevchenko


