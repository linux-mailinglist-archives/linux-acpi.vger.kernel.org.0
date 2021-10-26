Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09DA43BAE0
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 21:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbhJZTgF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 15:36:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:37615 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238774AbhJZTgE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 15:36:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="229854952"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="229854952"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 12:33:39 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="447242519"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 12:33:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mfSCD-001IJ5-M4;
        Tue, 26 Oct 2021 22:33:17 +0300
Date:   Tue, 26 Oct 2021 22:33:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 0/2] ACPI: scan: Honor certain device identification
 rules
Message-ID: <YXhX/cTjH/H9UOnQ@smile.fi.intel.com>
References: <11860508.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11860508.O9o76ZdvQC@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 26, 2021 at 08:51:49PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> There are some rules in the ACPI spec regarding which device identification
> objects can be used together etc., but they are not followed by the kernel
> code.
> 
> This series modifies the code to follow the spec more closely (see patch
> changelogs for details).

I understand the motivation, but afraid about consequences on the OEM cheap
devices that are not always follow letter of the specification.

As per Intel platforms I would look into Baytrail / Cherrytrail devices for
the past (I think Hans may help here a lot) and into Elkhart Lake in the
present (for the letter I mostly refer to CSRT + DSDT cooperation to get
GP DMA devices enumerated, so I _hope_ DSDT shouldn't have _ADR and _HID
together).

Hence, from the code perspective
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

From the practice I would wait for some tests. I will try to find any new
information about latest firmware tables on Elkhart Lake machines.

-- 
With Best Regards,
Andy Shevchenko


