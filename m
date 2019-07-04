Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC8D5F410
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2019 09:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfGDHqp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jul 2019 03:46:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:53860 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfGDHqp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Jul 2019 03:46:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 00:46:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,449,1557212400"; 
   d="scan'208";a="184946903"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 04 Jul 2019 00:46:41 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 04 Jul 2019 10:46:40 +0300
Date:   Thu, 4 Jul 2019 10:46:40 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: PM: Unexport acpi_device_get_power()
Message-ID: <20190704074640.GF2640@lahna.fi.intel.com>
References: <1970901.ZntFDt4DbR@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1970901.ZntFDt4DbR@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 04, 2019 at 01:02:49AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Using acpi_device_get_power() outside of ACPI device initialization
> and ACPI sysfs is problematic due to the way in which power resources
> are handled by it, so unexport it and add a paragraph explaining the
> pitfalls to its kerneldoc comment.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Makes perfect sense!

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
