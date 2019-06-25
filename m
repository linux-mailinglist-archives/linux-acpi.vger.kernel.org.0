Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C082655137
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2019 16:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfFYOLU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jun 2019 10:11:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:39777 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729476AbfFYOLU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Jun 2019 10:11:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 07:11:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,416,1557212400"; 
   d="scan'208";a="182898879"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 25 Jun 2019 07:11:16 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Jun 2019 17:11:16 +0300
Date:   Tue, 25 Jun 2019 17:11:16 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] ACPI: PM: Avoid evaluating _PS3 on transitions from
 D3hot to D3cold
Message-ID: <20190625141116.GI2640@lahna.fi.intel.com>
References: <10419005.Mb09WM6RCc@kreacher>
 <3012059.oderKuhLE3@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3012059.oderKuhLE3@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 25, 2019 at 02:04:45PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the power state of a device with ACPI PM is changed from D3hot to
> D3cold, it merely is a matter of dropping references to additional
> power resources (specifically, those in the list returned by _PR3),
> and the _PS3 method should not be invoked for the device then (as
> it has already been evaluated during the previous transition to
> D3hot).
> 
> Fixes: 20dacb71ad28 (ACPI / PM: Rework device power management to follow ACPI 6)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
