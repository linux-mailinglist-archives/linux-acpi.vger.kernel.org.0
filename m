Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 200BDE84EC
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2019 10:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfJ2J4X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Oct 2019 05:56:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:25881 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfJ2J4X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Oct 2019 05:56:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="189891562"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 29 Oct 2019 02:56:20 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iPOEe-000251-3p; Tue, 29 Oct 2019 11:56:20 +0200
Date:   Tue, 29 Oct 2019 11:56:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 00/12] ACPICA version 20191018v2
Message-ID: <20191029095620.GS32742@smile.fi.intel.com>
References: <20191025213700.14685-1-erik.schmauss@intel.com>
 <20191028155833.GN32742@smile.fi.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53C6648FF@ORSMSX122.amr.corp.intel.com>
 <2812725.QSNE5ueIqz@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2812725.QSNE5ueIqz@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 28, 2019 at 10:16:58PM +0100, Rafael J. Wysocki wrote:
> On Monday, October 28, 2019 6:49:10 PM CET Schmauss, Erik wrote:
> > > -----Original Message-----
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Monday, October 28, 2019 8:59 AM
> > > To: Schmauss, Erik <erik.schmauss@intel.com>
> > > Cc: Rafael J . Wysocki <rafael@kernel.org>; linux-acpi@vger.kernel.org
> > > Subject: Re: [PATCH v2 00/12] ACPICA version 20191018v2
> > > On Fri, Oct 25, 2019 at 02:36:48PM -0700, Erik Schmauss wrote:

> > I agree. It makes sense to use the interface in the same commit for linux
> 
> OK, done.
> 
> Please check the result in the bleeding-edge branch of my tree.

I have checked the contents of the patch 5 and it's fine, thanks!

(Since for the rest I have no changes, I think they are fine as well)

-- 
With Best Regards,
Andy Shevchenko


