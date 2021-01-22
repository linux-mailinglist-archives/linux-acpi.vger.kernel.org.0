Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EF13003B5
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 14:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbhAVNDg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 08:03:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:52985 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbhAVNDL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Jan 2021 08:03:11 -0500
IronPort-SDR: 7lkUmEHSiP1kb5ePz6hKW+nXZ0z6ZEiZmiqs1xzEJ2+hgj9yveH1RxkAe2LNy1Zk3hDgAl+CpU
 3i5MXyo3/UKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="240983067"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="240983067"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 05:00:54 -0800
IronPort-SDR: XzZPcp38cb30QULsLcXsgLNu4kNWEm2c+0ePLWkyZqoP1WUAH3b3OtPGcyWJbbrJsHw31Kfcoa
 L2i9km9f35xQ==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="357014636"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 05:00:50 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 22 Jan 2021 15:00:48 +0200
Date:   Fri, 22 Jan 2021 15:00:48 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     rjw@rjwysocki.net, AceLan Kao <acelan.kao@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI / device_sysfs: Prefer "compatible" modalias
Message-ID: <20210122130048.GN1988617@lahna.fi.intel.com>
References: <20210122125302.991591-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122125302.991591-1-kai.heng.feng@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 22, 2021 at 08:53:02PM +0800, Kai-Heng Feng wrote:
> Commit 8765c5ba1949 ("ACPI / scan: Rework modalias creation when
> "compatible" is present") may create two "MODALIAS=" in uevent file if
> conditions are met.
> 
> This breaks systemd-udevd, which assumes each "key" in uevent file is
> unique. The internal implementation of systemd-udevd overwrites the
> first MODALIAS with the second one, so its kmod rule doesn't load driver
> for the first MODALIAS.
> 
> So if both ACPI modalias and OF modalias are present, use the latter
> one to ensure there's only one MODALIAS.
> 
> Reference: https://github.com/systemd/systemd/pull/18163
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
