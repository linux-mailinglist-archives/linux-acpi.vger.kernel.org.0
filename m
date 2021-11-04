Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4BD445391
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Nov 2021 14:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhKDNMQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Nov 2021 09:12:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:61584 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231649AbhKDNMQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Nov 2021 09:12:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="317901746"
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="scan'208";a="317901746"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 06:09:37 -0700
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="scan'208";a="450196165"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 06:09:36 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id AA43820BFE;
        Thu,  4 Nov 2021 15:09:33 +0200 (EET)
Date:   Thu, 4 Nov 2021 15:09:33 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH 3/3] ACPI: Make acpi_node_get_parent() local
Message-ID: <YYPbjauWdQzVWRrt@paasikivi.fi.intel.com>
References: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
 <20211103133406.659542-4-sakari.ailus@linux.intel.com>
 <YYLAm1X+lFykwTSg@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYLAm1X+lFykwTSg@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 03, 2021 at 07:02:19PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 03, 2021 at 03:34:06PM +0200, Sakari Ailus wrote:
> > acpi_node_get_parent() isn't used outside drivers/acpi/property.c. Make it
> > local.
> 
> Always in favour for such patches!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thanks, Andy!

-- 
Sakari Ailus
