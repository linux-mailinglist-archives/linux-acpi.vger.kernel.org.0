Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445672E9740
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 15:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbhADO05 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 09:26:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:59985 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbhADO05 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Jan 2021 09:26:57 -0500
IronPort-SDR: TxDkdx2CX2GCnQs5j0FtRSvNjx8NnDr4wnuTs/5h4SpHMY1ZUMGctGJsufh/lYL0WEfFzy/i42
 zjEpRcMeWtbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="177113868"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="177113868"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 06:25:30 -0800
IronPort-SDR: 4F31ycCsW+RpBBzvfzihxYCk+fn+W8VV2zGwWvdBPVt3c9/9YKeMUj0egE8GYdmxEU1VhUo/qo
 yND/eLd3Nwqg==
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="461961604"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 06:25:24 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kwQoT-001ay9-TK; Mon, 04 Jan 2021 16:26:25 +0200
Date:   Mon, 4 Jan 2021 16:26:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        sergey.senozhatsky@gmail.com, mchehab@kernel.org, lenb@kernel.org,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org
Subject: Re: [PATCH v4 13/15] acpi: Add acpi_dev_get_next_match_dev() and
 helper macro
Message-ID: <20210104142625.GX4077@smile.fi.intel.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
 <20210103231235.792999-14-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103231235.792999-14-djrscally@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jan 03, 2021 at 11:12:33PM +0000, Daniel Scally wrote:
> To ensure we handle situations in which multiple sensors of the same
> model (and therefore _HID) are present in a system, we need to be able
> to iterate over devices matching a known _HID but unknown _UID and _HRV
>  - add acpi_dev_get_next_match_dev() to accommodate that possibility and
> change acpi_dev_get_first_match_dev() to simply call the new function
> with a NULL starting point. Add an iterator macro for convenience.

Since v5, also please update prefix in the Subject here to be "ACPI / bus: ".

-- 
With Best Regards,
Andy Shevchenko


