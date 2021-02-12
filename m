Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B48319C37
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 11:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhBLJ7s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 04:59:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:53425 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhBLJ7q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Feb 2021 04:59:46 -0500
IronPort-SDR: AWMcEvOMA/KgUrvkMKedPrL1Ybs1rIgUjyAHDv9ah/U44UaUe/IlPmUApnnqhCO0xCAU7YpxEb
 lPNfLAIxRzSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="161532184"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="161532184"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 01:57:56 -0800
IronPort-SDR: AvtK9ndARQGVy4E+Zh213bC+NiKFJ64EIdfF6Wult9Dfh6Irc1uq8KKw8/E6IhXHfYgeK9J0Xe
 64lIR7lxGFBw==
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="376284205"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 01:57:54 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 78F5E20345;
        Fri, 12 Feb 2021 11:57:51 +0200 (EET)
Date:   Fri, 12 Feb 2021 11:57:51 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>
Subject: Re: [PATCH] ACPI: property: Fix fwnode string properties matching
Message-ID: <20210212095751.GB3@paasikivi.fi.intel.com>
References: <5831274.1ZjA0VymzF@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5831274.1ZjA0VymzF@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Thu, Feb 11, 2021 at 07:30:01PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Property matching does not work for ACPI fwnodes if the value of the
> given property is not represented as a package in the _DSD package
> containing it.  For example, the "compatible" property in the _DSD
> below
> 
>   Name (_DSD, Package () {
>     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>     Package () {
>       Package () {"compatible", "ethernet-phy-ieee802.3-c45"}
>     }
>   })
> 
> will not be found by fwnode_property_match_string(), because the ACPI
> code handling device properties does not regard the single value as a
> "list" in that case.
> 
> Namely, fwnode_property_match_string() invoked to match a given
> string property value first calls fwnode_property_read_string_array()
> with the last two arguments equal to NULL and 0, respectively, in
> order to count the items in the value of the given property, with the
> assumption that this value may be an array.  For ACPI fwnodes, that
> operation is carried out by acpi_node_prop_read() which calls
> acpi_data_prop_read() for this purpose.  However, when the return
> (val) pointer is NULL, that function only looks for a property whose
> value is a package without checking the single-value case at all.
> 
> To fix that, make acpi_data_prop_read() check the single-value case
> regardless of the return pointer value if its return pointer argument
> is NULL and modify acpi_data_prop_read_single() handling that case to
> attempt to read the value of the property if the return pointer is
> NULL and return 1 if that succeeds.
> 
> Fixes: 3708184afc77 ("device property: Move FW type specific functionality to FW specific files")
> Reported-by: Calvin Johnson <calvin.johnson@oss.nxp.com>
> Cc: 4.13+ <stable@vger.kernel.org> # 4.13+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for addressing this.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
