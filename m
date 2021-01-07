Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A322ED160
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 15:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbhAGOGc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 09:06:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:34935 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbhAGOGc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Jan 2021 09:06:32 -0500
IronPort-SDR: d6Tf+Ib61/uoN9iwqhHoDdjkwUBa0Xc48ydcwwkh1//eQjnloCmhFI9MPPJfzhJ38cRltjCp8f
 /aFuhERSOWUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="164496875"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="164496875"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 06:04:45 -0800
IronPort-SDR: z+6k2atxnFNgkMXTm375fLKHEBt2Qq7N2XeP2WseLO21euHdixYWyyJ6OQL9x6fgYMi+FqGmJJ
 PKUVOvqv9p7w==
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="463044704"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 06:04:36 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kxVuz-004maB-3C; Thu, 07 Jan 2021 16:05:37 +0200
Date:   Thu, 7 Jan 2021 16:05:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, mchehab@kernel.org,
        sergey.senozhatsky@gmail.com, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, robert.moore@intel.com,
        erik.kaneda@intel.com, pmladek@suse.com, rostedt@goodmis.org,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se,
        prabhakar.mahadev-lad.rj@bp.renesas.com, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v5 15/15] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
Message-ID: <20210107140537.GX4077@smile.fi.intel.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-16-djrscally@gmail.com>
 <20210107140505.GW4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107140505.GW4077@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 07, 2021 at 04:05:05PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 07, 2021 at 01:28:38PM +0000, Daniel Scally wrote:

> Seems like missed changelog (no need to resend, just send a follow up).

I meant the follow up with only changelog text, thanks!

-- 
With Best Regards,
Andy Shevchenko


