Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713C560486
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 12:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfGEKdT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 06:33:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:62640 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfGEKdT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Jul 2019 06:33:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 03:33:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="185148881"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 05 Jul 2019 03:33:15 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 05 Jul 2019 13:33:14 +0300
Date:   Fri, 5 Jul 2019 13:33:14 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Raanan Avargil <raanan.avargil@intel.com>
Subject: Re: [PATCH 0/8] thunderbolt: Intel Ice Lake support
Message-ID: <20190705103314.GS2640@lahna.fi.intel.com>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 05, 2019 at 12:57:52PM +0300, Mika Westerberg wrote:
> Hi all,
> 
> With the exception of the first patch which is fix, this series enables
> Thunderbolt on Intel Ice Lake. Biggest difference from the previous
> controllers is that the Thunderbolt controller is now integrated as part of
> the SoC. The firmware messages pretty much follow Titan Ridge but there are
> some differences as well (such as the new RTD3 veto notification). Also Ice
> Lake does not implement security levels so DMA protection is handled by IOMMU.
> 
> This is v5.4 material but I'm sending it out now because I will be on
> vacation next 4 weeks mostly without internet access. When I get back I'll
> gather all the comments and update the series accordingly.
> 
> Thanks!
> 
> Mika Westerberg (8):
>   thunderbolt: Correct path indices for PCIe tunnel
>   thunderbolt: Move NVM upgrade support flag to struct icm
>   thunderbolt: Use 32-bit writes when writing ring producer/consumer
>   thunderbolt: Do not fail adding switch if some port is not implemented
>   thunderbolt: Hide switch attributes that are not set
>   thunderbolt: Expose active parts of NVM even if upgrade is not supported
>   thunderbolt: Add support for Intel Ice Lake
>   ACPI / property: Add two new Thunderbolt property GUIDs to the list

Forgot to Cc Raanan and Raj, now added. Sorry about that. The patch
series can also be viewed here:

  https://lore.kernel.org/lkml/20190705095800.43534-1-mika.westerberg@linux.intel.com/T/#m9cb5a393dfc79f1c2212d0787b6bad5b689db6bd
