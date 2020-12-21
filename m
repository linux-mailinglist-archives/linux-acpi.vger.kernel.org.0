Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01582DFAF2
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Dec 2020 11:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgLUKS5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Dec 2020 05:18:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:56311 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgLUKS5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Dec 2020 05:18:57 -0500
IronPort-SDR: J52zfc7KSzJg1Y72Xo+4taJffezve30wXYTtDAJ7O6U3t15QE3/soxIWXLMUmUi/G7NF003olM
 h3X9YNtFo7RA==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="194126864"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="194126864"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 01:10:30 -0800
IronPort-SDR: NOgRH+wOHRqW6oMR+GxgAx/fv8YFyD3viuutQ+OljaIDrX23PcP9EA1HUlFgoeo7sETXNsymER
 v/78P+YI5Adg==
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="456111247"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 01:10:24 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id B6962205F7; Mon, 21 Dec 2020 11:10:22 +0200 (EET)
Date:   Mon, 21 Dec 2020 11:10:22 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 02/12] property: Return true in
 fwnode_device_is_available for NULL ops
Message-ID: <20201221091022.GF26370@paasikivi.fi.intel.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-3-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217234337.1983732-3-djrscally@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 17, 2020 at 11:43:27PM +0000, Daniel Scally wrote:
> Some types of fwnode_handle do not implement the device_is_available()
> check, such as those created by software_nodes. There isn't really a
> meaningful way to check for the availability of a device that doesn't
> actually exist, so if the check isn't implemented just assume that the
> "device" is present.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>

For this and the 3rd patch:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
