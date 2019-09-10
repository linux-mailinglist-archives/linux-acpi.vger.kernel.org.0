Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D72AE6C0
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2019 11:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfIJJWj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Sep 2019 05:22:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:33526 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbfIJJWj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Sep 2019 05:22:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 02:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="178620145"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 10 Sep 2019 02:22:34 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i7cM5-0004w5-9k; Tue, 10 Sep 2019 12:22:33 +0300
Date:   Tue, 10 Sep 2019 12:22:33 +0300
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
Subject: Re: [PATCH v6 01/12] tools lib traceevent: Convert remaining %p[fF]
 users to %p[sS]
Message-ID: <20190910092233.GY2680@smile.fi.intel.com>
References: <20190910084707.18380-1-sakari.ailus@linux.intel.com>
 <20190910084707.18380-2-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910084707.18380-2-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 10, 2019 at 11:46:56AM +0300, Sakari Ailus wrote:
> There are no in-kernel %p[fF] users left. Convert the traceevent tool,
> too, to align with the kernel.

>  function. The _tep_ argument is the trace event parser context. The _name_ is
> -the name of the function, the string is copied internally. The _addr_ is
> -the start address of the function. The _mod_ is the kernel module
> -the function may be in (NULL for none).
> +the name of the function, the string is copied internally. The _addr_ is the
> +start address of the function. The _mod_ is the kernel module the function may
> +be in (NULL for none).

This seems a churn of reformatting.

> -		if (asprintf(&format, "%%pf: (NO FORMAT FOUND at %llx)\n", addr) < 0)
> +		if (asprintf(&format, "%%ps: (NO FORMAT FOUND at %llx)\n",
> +			     addr) < 0)

Splitting line also seems a churn to me. But this one is up to maintainers.


Other than above, looks good to me, thanks!

-- 
With Best Regards,
Andy Shevchenko


