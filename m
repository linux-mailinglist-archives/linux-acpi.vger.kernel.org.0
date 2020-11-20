Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8672BAA13
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Nov 2020 13:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgKTM2M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Nov 2020 07:28:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:25589 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbgKTM2L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Nov 2020 07:28:11 -0500
IronPort-SDR: VXkOfeImNyJE1GtalIpiKrN963cGDjVGT3umlfDZjObOl4ARg5JBwQEccR28kCOqey7V8qnziH
 Qt6b1zdvEiiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="168892194"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="168892194"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 04:28:11 -0800
IronPort-SDR: nfBqt7rIEHwsG+hMAzCo+x19jOOmOiS5wxcCkf7YjHLrzWHsXkS7JbgoG3EXMuXZS1nfD1WdTA
 R46RH99SfaOA==
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="477216981"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 04:28:08 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 20 Nov 2020 14:28:05 +0200
Date:   Fri, 20 Nov 2020 14:28:05 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: ACPI: enumeration: add PCI hierarchy
 representation
Message-ID: <20201120122805.GT2495@lahna.fi.intel.com>
References: <20201120111125.78296-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120111125.78296-1-f.suligoi@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 20, 2020 at 12:11:25PM +0100, Flavio Suligoi wrote:
> For "fixed" PCI devices, such as chips directly soldered
> on the main board (ethernet, Wi-Fi, serial ports, etc.),
> it is possible to find an ACPI enumeration.
> 
> This allows to add useful properties to these devices.
> Just for an example: the property "gpio-line-names" can be
> added to the pins of a GPIO expander on the PCI bus.
> 
> In order to find the ACPI name of a PCI device, it's necessary
> to disassemble the BIOS ACPI tables (in particular the DSDT)
> and also to analyze the PCI bus topology of the board.
> 
> This patch, with a practical example, show how to do this.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
