Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8A72DFAEE
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Dec 2020 11:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgLUKRg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Dec 2020 05:17:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:56311 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgLUKRg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Dec 2020 05:17:36 -0500
IronPort-SDR: gjpNBE3/R3CCDOKD4FonVip97m/uQfB6MV1UtFlUtIrh6XxyNJNlOBzEP2K8HgIVG7FjYaDZq/
 4Er9ZO+7nitQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="194126669"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="194126669"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 01:08:45 -0800
IronPort-SDR: WduyTp7C+aVCXgMvXhJHG1hdkhhpgWZO1Q1877ueLG/KahFhsxjv5EeiTwNF0Gw/h9hITL6rhT
 5J2bbCHSe2tA==
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="337348305"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 01:08:39 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 4717F205F7; Mon, 21 Dec 2020 11:08:37 +0200 (EET)
Date:   Mon, 21 Dec 2020 11:08:37 +0200
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
Subject: Re: [PATCH v2 01/12] software_node: Fix refcounts in
 software_node_get_next_child()
Message-ID: <20201221090837.GE26370@paasikivi.fi.intel.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-2-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217234337.1983732-2-djrscally@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

Thanks for the update.

On Thu, Dec 17, 2020 at 11:43:26PM +0000, Daniel Scally wrote:
> The software_node_get_next_child() function currently does not hold
> references to the child software_node that it finds or put the ref that
> is held against the old child - fix that.
> 
> Fixes: 59abd83672f7 ("drivers: base: Introducing software nodes to the firmware node framework")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
