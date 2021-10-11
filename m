Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A444286A9
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 08:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhJKGOB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 02:14:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:45255 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234036AbhJKGOA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Oct 2021 02:14:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="313004452"
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="313004452"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 23:12:01 -0700
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="546884850"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 23:11:58 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 11 Oct 2021 09:11:55 +0300
Date:   Mon, 11 Oct 2021 09:11:55 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ACPI: LPSS: Use ACPI_COMPANION() directly
Message-ID: <YWPVq7ebGX/xte/p@lahna>
References: <11853240.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11853240.O9o76ZdvQC@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Oct 10, 2021 at 07:23:01PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI_HANDLE() macro returns the ACPI handle of the ACPI device
> object returned by the ACPI_COMPANION() macro, so it is more
> straightforward to call the latter directly instead of passing
> the handle produced by the former to acpi_bus_get_device().
> 
> Modify the code accordingly (no intentional functional impact).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
