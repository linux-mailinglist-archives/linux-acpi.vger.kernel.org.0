Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48D9463F25
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Nov 2021 21:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343651AbhK3UYs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Nov 2021 15:24:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:21450 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234770AbhK3UYs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Nov 2021 15:24:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="223192059"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="223192059"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 12:21:28 -0800
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="477253028"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 12:21:27 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id C8C5B20399;
        Tue, 30 Nov 2021 22:21:24 +0200 (EET)
Date:   Tue, 30 Nov 2021 22:21:24 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com,
        rafael@kernel.org
Subject: Re: [PATCH 1/7] device property: Fix fwnode_graph_devcon_match()
 fwnode leak
Message-ID: <YaaHxMMiV9kHxbjt@paasikivi.fi.intel.com>
References: <20211130153250.935726-1-sakari.ailus@linux.intel.com>
 <YaZMPtzYumINzvz7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaZMPtzYumINzvz7@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

Thanks for the comments.

On Tue, Nov 30, 2021 at 06:07:26PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 30, 2021 at 05:32:44PM +0200, Sakari Ailus wrote:
> > For each endpoint it encounters, fwnode_graph_devcon_match() checks
> > whether the endpoint's remote port parent device is available. If it is
> > not, it ignores the endpoint but does not put the reference to the remote
> > endpoint port parent fwnode. For available devices the fwnode handle
> > reference is put as expected.
> > 
> > Put the reference for unavailable devices now.
> 
> I like the series, thanks!
> For non-commented you may take my
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> 
> The rest can gain it if you are okay with my proposals.
> 
> Also, please fix Cc list, it has fancy address in the Cc list.

I forgot to write one more e-mail address before pressing enter...

-- 
Regards,

Sakari Ailus
