Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC268307639
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Jan 2021 13:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhA1MiL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Jan 2021 07:38:11 -0500
Received: from mga12.intel.com ([192.55.52.136]:36810 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhA1MiL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 28 Jan 2021 07:38:11 -0500
IronPort-SDR: uCb+vf+YnLQyZXXZ6aym8NLTRDceuvcOpkuo2C+5Re5tzmFxbQM92qAY73iUddDyFQanVHkTME
 7i9stZzW74YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="159397952"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="159397952"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 04:36:26 -0800
IronPort-SDR: /wEbY7Hliq/Us8TWDwwVLU4FJbNr5YiVZRrlhybuf9O+2/rgGdYYBlkEltZH9cgGrZI0B0u2r2
 3gWNo7iyNtuQ==
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="473655031"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 04:36:22 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 28 Jan 2021 14:36:20 +0200
Date:   Thu, 28 Jan 2021 14:36:20 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/6] thunderbolt: Fix possible NULL pointer dereference
 in tb_acpi_add_link()
Message-ID: <20210128123620.GS2542@lahna.fi.intel.com>
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
 <20210126155723.9388-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126155723.9388-2-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 06:57:18PM +0300, Mika Westerberg wrote:
> From: Mario Limonciello <mario.limonciello@dell.com>
> 
> When we walk up the device hierarchy in tb_acpi_add_link() make sure we
> break the loop if the device has no parent. Otherwise we may crash the
> kernel by dereferencing a NULL pointer.
> 
> Fixes: b2be2b05cf3b ("thunderbolt: Create device links from ACPI description")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied this one separately to thunderbolt.git/fixes.
