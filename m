Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DE85F3E3B
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Oct 2022 10:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJDIYs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Oct 2022 04:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiJDIYm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Oct 2022 04:24:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F962627
        for <linux-acpi@vger.kernel.org>; Tue,  4 Oct 2022 01:24:38 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="286047362"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="286047362"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 01:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="619030307"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="619030307"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 04 Oct 2022 01:24:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1ofdE9-001yBW-0I;
        Tue, 04 Oct 2022 11:24:33 +0300
Date:   Tue, 4 Oct 2022 11:24:32 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, kai.heng.feng@canonical.com,
        Johannes =?iso-8859-1?Q?Pen=DFel?= <johannespenssel@posteo.net>,
        linux-acpi@vger.kernel.org, devel@acpica.org
Subject: Re: [RFC v3 4/4] ACPI: EC: fix ECDT probe ordering issues
Message-ID: <YzvtwCTShC/yYovH@smile.fi.intel.com>
References: <20221003144214.345279-1-hdegoede@redhat.com>
 <20221003144214.345279-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003144214.345279-5-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 03, 2022 at 04:42:14PM +0200, Hans de Goede wrote:
> ACPI-2.0 says that the EC OpRegion handler must be available immediately
> (like the standard default OpRegion handlers):
> 
> Quoting from the ACPI spec version 6.3: "6.5.4 _REG (Region) ...

(Side note: As of today the revision 6.5 of the ACPI specification is
 available)

> 2. OSPM must make Embedded Controller operation regions, accessed via
> the Embedded Controllers described in ECDT, available before executing
> any control method. These operation regions may become inaccessible
> after OSPM runs _REG(EmbeddedControl, 0)."
> 
> So acpi_bus_init() calls acpi_ec_ecdt_probe(), which calls
> acpi_install_address_space_handler() to install the EC's OpRegion
> handler, early on.
> 
> This not only installs the OpRegion handler, but also calls the EC's
> _REG method. The _REG method call is a problem because it may rely on
> initialization done by the _INI methods of one of the PCI / _SB root devs,
> see for example: https://bugzilla.kernel.org/show_bug.cgi?id=214899 .
> 
> Generally speaking _REG methods are executed when the ACPI-device they
> are part of has a driver bound to it. Where as _INI methods must be
> executed at table load time (according to the spec). The problem here
> is that the early acpi_install_address_space_handler() call causes
> the _REG handler to run too early.
> 
> To allow fixing this the ACPICA code now allows to split the OpRegion
> handler installation and the executing of _REG into 2 separate steps.
> 
> This commit uses this ACPICA functionality to fix the EC probe ordering
> by delaying the executing of _REG for ECDT described ECs till the matching
> EC device in the DSDT gets parsed and acpi_ec_add() for it gets called.
> This moves the calling of _REG for the EC on devices with an ECDT to
> the same point in time where it is called on devices without an ECDT table.

...

> +	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
> +		acpi_execute_reg_methods(ec->handle, ACPI_ADR_SPACE_EC);

> +		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);

Just to be sure: do you need atomic operation here? Does it prevent of any
kind of races? Because if it had been the case, it would have been done via
test_and_set_bit() rather than testing and setting separated.

> +	}

-- 
With Best Regards,
Andy Shevchenko


