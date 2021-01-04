Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F112E972D
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 15:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhADOZS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 09:25:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:3389 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbhADOZS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Jan 2021 09:25:18 -0500
IronPort-SDR: HzD8qVZnRVZH4WuDb14PW6w9fulgheUns5d0LDQppHsGNEzdNp6e7ANginEClY2+3PBBgYL3WP
 sxOmZZYj9Ehw==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="174382945"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="174382945"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 06:23:31 -0800
IronPort-SDR: 889WU4NtFg6Q+ZE52WHlFoetA5WoKSQM7dOkzcKtiaPnEswl5CghDM3uej06SPrMcjHO0D3CdN
 DFRv8jE+M4yw==
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="349546122"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 06:23:24 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kwQmX-001aww-VM; Mon, 04 Jan 2021 16:24:25 +0200
Date:   Mon, 4 Jan 2021 16:24:25 +0200
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
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 07/15] include: fwnode.h: Define format macros for
 ports and endpoints
Message-ID: <20210104142425.GW4077@smile.fi.intel.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
 <20210103231235.792999-8-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103231235.792999-8-djrscally@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jan 03, 2021 at 11:12:27PM +0000, Daniel Scally wrote:
> OF, ACPI and software_nodes all implement graphs including nodes for ports
> and endpoints. These are all intended to be named with a common schema,
> as "port@n" and "endpoint@n" where n is an unsigned int representing the
> index of the node. To ensure commonality across the subsystems, provide a
> set of macros to define the format.

Since v5, can you modify subject prefix to be "device property: "?
Same for patches 3 and 4, please.

-- 
With Best Regards,
Andy Shevchenko


