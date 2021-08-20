Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093103F2C0F
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Aug 2021 14:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbhHTM3S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Aug 2021 08:29:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:37456 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240376AbhHTM3M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Aug 2021 08:29:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="196345975"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="196345975"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 05:28:34 -0700
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="490444844"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 05:28:32 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id CAE0F201C5;
        Fri, 20 Aug 2021 15:28:30 +0300 (EEST)
Date:   Fri, 20 Aug 2021 15:28:30 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [RFC 1/3] imx258: Defer probing on ident register read fail (on
 ACPI)
Message-ID: <20210820122830.GA3@paasikivi.fi.intel.com>
References: <20210819201936.7390-1-sakari.ailus@linux.intel.com>
 <20210819201936.7390-2-sakari.ailus@linux.intel.com>
 <YR+eJytxRcVpSxgA@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YR+eJytxRcVpSxgA@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 20, 2021 at 03:20:55PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 19, 2021 at 11:19:34PM +0300, Sakari Ailus wrote:
> > Return -EPROBE_DEFER if probing the device fails because of the I²C
> > transaction (-EIO only). This generally happens when the power on sequence
> > of the device has not been fully performed yet due to later probing of
> > other drivers.
> 
> ...
> 
> > +	if (ret == -EIO && is_acpi_device_node(dev_fwnode(&client->dev))) {
> 
> has_acpi_companion() is better to have here, no?

Agreed.

-- 
Sakari Ailus
