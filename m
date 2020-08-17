Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F30E246D61
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Aug 2020 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389150AbgHQQyu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Aug 2020 12:54:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:49204 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389139AbgHQQyq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Aug 2020 12:54:46 -0400
IronPort-SDR: utHlu5JbjNVTfeZ2s4GkivzgKCGzlV1UxZf+sZYXicTDUBdz3GjWnH8/jyu28z7HKdpbCR3UVs
 cep+qEa2/Puw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="142376313"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="142376313"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 09:54:41 -0700
IronPort-SDR: tHVfuTVKwWmjmX2hdFW0/tAB9G414VPCaldAOIGS16EuMgjfDP55ni5jANSE3vAM7MQ/HFY0P+
 KUDhX99BhmQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="400254171"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 17 Aug 2020 09:54:38 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 17 Aug 2020 19:54:36 +0300
Date:   Mon, 17 Aug 2020 19:54:36 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 8/8] ACPI: watchdog: Replace open coded variant of
 resource_union()
Message-ID: <20200817165436.GV1375436@lahna.fi.intel.com>
References: <20200817163647.48982-1-andriy.shevchenko@linux.intel.com>
 <20200817163647.48982-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817163647.48982-8-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 17, 2020 at 07:36:47PM +0300, Andy Shevchenko wrote:
> Since we have resource_union() helper, let's utilize it here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
