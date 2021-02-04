Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFEB30EDCF
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 08:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhBDHxZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 02:53:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:24971 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231767AbhBDHxX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Feb 2021 02:53:23 -0500
IronPort-SDR: jF2GEfHDDX3RMjBoYKOa5TpZzNHBME2T3rkcgpCJ7kT3KMjTNYUdCs7ebyK5JVDXXEnRreHr5S
 uu8TZdSHT88A==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="177685779"
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="177685779"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 23:51:38 -0800
IronPort-SDR: MiXbk0KILb5CmTFx5bx89jEXGyZNmR5Mpgtc41ir8AJSybK5Rb1o5bYnQzgHtDUvfTFREApeVv
 ro2IWBFdr2qQ==
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="372296926"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 23:51:34 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 04 Feb 2021 09:51:32 +0200
Date:   Thu, 4 Feb 2021 09:51:31 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 0/5] thunderbolt / ACPI: Add support for USB4 _OSC
Message-ID: <20210204075131.GQ2542@lahna.fi.intel.com>
References: <20210129083241.72497-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129083241.72497-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 29, 2021 at 11:32:36AM +0300, Mika Westerberg wrote:
> Hi all,
> 
> The just released ACPI 6.4 spec [1] adds a new _OSC method that is used to
> negotiate OS support for native USB4 features such as PCIe tunneling. This
> patch series adds Linux support for the new _OSC and modifies the
> Thunderbolt/USB4 driver accordingly to enable/disable tunneling of
> different protocols.
> 
> There is an additional setting in the firmware connection manager that
> allows the BIOS to disable PCIe tunneling, so we add support for this and
> also make the software connection manager to switch to this "nopcie"
> security level when the _OSC does not allow PCIe tunneling.
> 
> This applies on top of thunderbolt.git/next.
> 
> [1] https://uefi.org/sites/default/files/resources/ACPI_Spec_6_4_Jan22.pdf
> 
> The previous version of the patch series can be found here:
> 
>   https://lore.kernel.org/linux-usb/20210126155723.9388-1-mika.westerberg@linux.intel.com/
> 
> Changes from v1:
> 
>   * Dropped patch 1/6. I already applied it to thunderbolt.git/fixes
>   * Added ACK from Yehezkel to TBT patches
>   * Updated changelog of patch 1/5 and fixed typos too
>   * Added Rafael's tag to patch 4/5.
> 
> Mario Limonciello (1):
>   ACPI: Execute platform _OSC also with query bit clear
> 
> Mika Westerberg (4):
>   thunderbolt: Add support for PCIe tunneling disabled (SL5)
>   thunderbolt: Allow disabling XDomain protocol
>   ACPI: Add support for native USB4 control _OSC
>   thunderbolt: Add support for native USB4 _OSC

All applied to thunderbolt.git/next.
