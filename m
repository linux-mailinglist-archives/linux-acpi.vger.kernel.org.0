Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB182F4C29
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jan 2021 14:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbhAMNZD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Jan 2021 08:25:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:46597 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbhAMNZD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Jan 2021 08:25:03 -0500
IronPort-SDR: 1kz0cKtco43MR/jXMHW0BEKIAHKKtfi5f20AqH8vqjlFap0EyI4cqQ9JjFqCeS7Hba2KvaL0jV
 mSVXcX5aC41Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="196836962"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="196836962"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 05:23:17 -0800
IronPort-SDR: RD+Ub80QGEiN/6IouSEmhG6/MxR+JvKF9uSFPztpT9gX2Gh2hXdr8B6zNjX/fZbyS9s3lQReJF
 RubQhHVF2VCA==
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="353470294"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 05:23:11 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id EA5C2207BF; Wed, 13 Jan 2021 15:23:09 +0200 (EET)
Date:   Wed, 13 Jan 2021 15:23:09 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, mchehab@kernel.org,
        yong.zhi@intel.com, bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se,
        prabhakar.mahadev-lad.rj@bp.renesas.com, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v5 09/15] lib/test_printf.c: Use helper function to
 unwind array of software_nodes
Message-ID: <20210113132309.GK11878@paasikivi.fi.intel.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-10-djrscally@gmail.com>
 <X/kOYeZtkCspoAC5@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/kOYeZtkCspoAC5@pendragon.ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello all,

On Sat, Jan 09, 2021 at 04:01:05AM +0200, Laurent Pinchart wrote:
> Hi Peter, Steven and Sergey,
> 
> Could you please let us know if you're fine with this patch getting
> merged in v5.12 through the linux-media tree ? The cover letter contains
> additional details (in a nutshell, this is a cross-tree series and we
> would like to avoid topic branches if possible).

I'll proceed to merge this patch through the media tree.

Thanks.

-- 
Kind regards,

Sakari Ailus
