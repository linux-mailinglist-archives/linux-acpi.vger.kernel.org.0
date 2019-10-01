Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C8DC306A
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2019 11:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfJAJkJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Oct 2019 05:40:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:41144 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfJAJkJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Oct 2019 05:40:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 02:40:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="205032703"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 02:40:06 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 12:40:05 +0300
Date:   Tue, 1 Oct 2019 12:40:05 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 4/6] ACPI / LPSS: Switch to use
 acpi_dev_hid_uid_match()
Message-ID: <20191001094005.GI2714@lahna.fi.intel.com>
References: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
 <20190924193739.86133-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924193739.86133-5-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 24, 2019 at 10:37:37PM +0300, Andy Shevchenko wrote:
> Since we have a generic helper, drop custom implementation in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
