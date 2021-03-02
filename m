Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5B932B443
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Mar 2021 06:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353074AbhCCE4e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 23:56:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:42598 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1443736AbhCBNkJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Mar 2021 08:40:09 -0500
IronPort-SDR: rWj1AbbLZNH62JPn2Gx/jOq+5rWadgKPSfOGzoGiWz59DxmBMQyBrLPMTAf6P9cnRWWCD5LVwT
 wG3xQ7kDXxMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="206447801"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="206447801"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 05:37:55 -0800
IronPort-SDR: G1fW5sdk4Dy1+HAokgZG1kozWLuckxJ8i2tjnXBSimIgEi9PvOr7fs9MDtXKm8AtgD8Mu97OUX
 6BalTeVuOV4w==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="368962687"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 05:37:53 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 81F082011B;
        Tue,  2 Mar 2021 15:37:21 +0200 (EET)
Date:   Tue, 2 Mar 2021 15:37:21 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: bus: Constify is_acpi_node() and friends
 (part 2)
Message-ID: <20210302133721.GG3@paasikivi.fi.intel.com>
References: <20210302133548.88230-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302133548.88230-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 02, 2021 at 03:35:48PM +0200, Andy Shevchenko wrote:
> The commit 8b9d6802583a ("ACPI: Constify acpi_bus helper functions,
> switch to macros") only changed functions for CONFIG_ACPI=y case.
> This part adjusts the rest.
> 
> Fixes: 8b9d6802583a ("ACPI: Constify acpi_bus helper functions, switch to macros")
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
