Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BF9345700
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Mar 2021 05:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhCWEzC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Mar 2021 00:55:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:42797 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhCWEzC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Mar 2021 00:55:02 -0400
IronPort-SDR: c97/r/el3Srh6XHK3/qZbcleyqaT9QG1G+8A3ivO7xrj56f4D5ZVds7Y+LD433CJYwfi0VCvth
 H08u82iLB9RA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="177972533"
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; 
   d="scan'208";a="177972533"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 21:55:01 -0700
IronPort-SDR: yhYI/1uJUy4l7EaguqVVIxEe5ZZZxUj0hnwrZZI9coHoAAaF92ddet0KSoGvVBDrlciJjtUgFf
 bzAhf0k1z9Bw==
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; 
   d="scan'208";a="414797782"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 21:54:59 -0700
Date:   Tue, 23 Mar 2021 12:59:08 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [PATCH] ACPI: CPPC: Add emtpy stubs of functions for
 CONFIG_ACPI_CPPC_LIB unset
Message-ID: <20210323045908.GA71586@chenyu-desktop>
References: <538668936.KFQZekuijD@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <538668936.KFQZekuijD@kreacher>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 16, 2021 at 04:54:03PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> For convenience, add empty stubs of library functions defined in
> cppc_acpi.c for the CONFIG_ACPI_CPPC_LIB unset case.
> 
> Because one of them needs to return CPUFREQ_ETERNAL, include
> linux/cpufreq.h into the CPPC library header file and drop the
> direct inclusion of it from cppc_acpi.c.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
