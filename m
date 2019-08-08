Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B865F860BC
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2019 13:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfHHLTr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Aug 2019 07:19:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:25767 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731312AbfHHLTr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Aug 2019 07:19:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 04:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="186319415"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga002.jf.intel.com with ESMTP; 08 Aug 2019 04:19:43 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hvgSL-0001t9-Rk; Thu, 08 Aug 2019 14:19:41 +0300
Date:   Thu, 8 Aug 2019 14:19:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 0/2] intel-hid: intel-vbtn: Suspend-related fix and update
Message-ID: <20190808111941.GJ30120@smile.fi.intel.com>
References: <1717835.1Yz4jNODO2@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717835.1Yz4jNODO2@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 08, 2019 at 10:40:19AM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> These two patches fix a minor issue related to system suspend in the intel-hid
> and intel-vbtn drivers and update the suspend/resume handling in intel-hid to
> reduce special-casing in it somewhat.
> 

AFAIR the original patches go via other than PDx86 tree.
Thus, while patches are looking good to me,

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Please refer to the changelogs for details.

-- 
With Best Regards,
Andy Shevchenko


