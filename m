Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422352DCE47
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Dec 2020 10:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgLQJ3L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 04:29:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:1837 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgLQJ3L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Dec 2020 04:29:11 -0500
IronPort-SDR: ve+m5k+NDqtjwa3keGwuZVT1vS+GXT/VEksg+RqOkXzx4tFhpA6nw7RF0T2+7auxJkGSRSHj0U
 RXGS9FA6QkYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="172650301"
X-IronPort-AV: E=Sophos;i="5.78,426,1599548400"; 
   d="scan'208";a="172650301"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 01:27:25 -0800
IronPort-SDR: 35SsHYj6v3p7in39ljv1jdkaos50haWexDHJ/ZCTChLnl45Ba7fxRHaYrZvVYGHILFVF7Nr3mq
 I+N7wJCJZXHg==
X-IronPort-AV: E=Sophos;i="5.78,426,1599548400"; 
   d="scan'208";a="339223589"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 01:27:23 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 17 Dec 2020 11:27:19 +0200
Date:   Thu, 17 Dec 2020 11:27:19 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Hans De Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][PATCH v1 0/3] ACPI: scan: Defer enumeration of devices
 with significant dependencies
Message-ID: <20201217092719.GF5246@lahna.fi.intel.com>
References: <1646930.v2jOOB1UEN@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646930.v2jOOB1UEN@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Mon, Dec 14, 2020 at 09:23:47PM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> This series addresses some enumeration ordering issues by using information
> from _DEP to defer the enumeration of devices that are likely to depend on
> operation region (OpRegion) handlers supplied by the drivers of other
> devices.
> 
> This allows the OpRegion suppliers to be probed and start working before the
> devices depending on them are enumerated.

For the whole series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
