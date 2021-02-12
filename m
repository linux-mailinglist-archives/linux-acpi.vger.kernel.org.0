Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E350A319CA8
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 11:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhBLKah (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 05:30:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:16175 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhBLKag (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Feb 2021 05:30:36 -0500
IronPort-SDR: lQIF3U+6oD7htNhN0ECriiXMTyLRJVQtK3PjYTLnhZ8fJ6jkbHLBuBtIVAHi7lrtaynZL3YfVw
 Y+WdFtJc45DQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="182463613"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="182463613"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 02:28:50 -0800
IronPort-SDR: xMPymEm/e9YiMmihnEa5y2rtorDhIH6vzmGuFw0mnx8OWCamCc/cc+om/C7EASKmVNaAbxnsS3
 YHzGRLsBHvBw==
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="397927633"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 02:28:47 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 12 Feb 2021 12:28:44 +0200
Date:   Fri, 12 Feb 2021 12:28:44 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH] ACPI: property: Fix fwnode string properties matching
Message-ID: <20210212102844.GN2542@lahna.fi.intel.com>
References: <5831274.1ZjA0VymzF@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5831274.1ZjA0VymzF@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

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

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
