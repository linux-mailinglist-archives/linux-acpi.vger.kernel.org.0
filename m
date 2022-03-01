Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794414C8C59
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Mar 2022 14:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiCANOp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Mar 2022 08:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiCANOp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2022 08:14:45 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610463AA73
        for <linux-acpi@vger.kernel.org>; Tue,  1 Mar 2022 05:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646140444; x=1677676444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eZk9KbrZKK7Mk2lVLeUFcc2F9zUGFmzb+V4dXWg2DLo=;
  b=MuaQVEdAoIGtOTISxeY6pUHBC3SSE5pOw6o8BAbi+dvDLdhuNYK3Z8GR
   dA2bt7QDRyO1MEmJpAI6hnT0LRxgMgEQATitvoo8r3KU49Sd6ywQz+dem
   RnN1N4qPnfA6ehjqtw1HRZiXctCHY/vnTIxSKM30Go+1+hqSrU5orpZIm
   DAmmA5Qd5frekOpRMZ2YPO8tfAgTfTh7ZH18j+ffNcerOk+ie/Us7Q5Ix
   dyE9XolfkHc/IaWuZ1WlmEeKN8gh3qjDBvoNHjNcK1GjZ0qrQM6WsZNVv
   g7FuAHcTwH9VSD0GOA0hw2m5GL5bCyE/Cbpr7gb4YACeE+Dj/PXZ0h/XR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252860890"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252860890"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 05:14:04 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="545086918"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 05:14:00 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Mar 2022 15:12:48 +0200
Date:   Tue, 1 Mar 2022 15:12:48 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Xiaomeng.Hou@amd.com,
        Aaron.Liu@amd.com, Ray.Huang@amd.com, hdegoede@redhat.com
Subject: Re: [PATCH v4 3/3] ACPI: bus: For platform OSC negotiate capabilities
Message-ID: <Yh4b0G/xkSlvEPlO@lahna>
References: <20220301124908.1931221-1-mario.limonciello@amd.com>
 <20220301124908.1931221-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301124908.1931221-3-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 01, 2022 at 06:49:08AM -0600, Mario Limonciello wrote:
> According to the ACPI 6.4 spec:
> It is strongly recommended that the OS evaluate _OSC with the Query
> Support Flag set until _OSC returns the Capabilities Masked bit clear,
> to negotiate the set of features to be granted to the OS for native
> support; a platform may require a specific combination of features
> to be supported natively by an OS before granting native control
> of a given feature. After negotiation with the query flag set,
> the OS should evaluate without it so that any negotiated values
> can be made effective to hardware.
> 
> Currently the code sends the exact same values in both executions of the
> _OSC and this leads to some problems on some AMD platforms in certain
> configurations.
> 
> The following notable capabilities are set by OSPM when query is enabled:
> * OSC_SB_PR3_SUPPORT
> * OSC_SB_PCLPI_SUPPORT
> * OSC_SB_NATIVE_USB4_SUPPORT
> 
> The first call to the platform OSC returns back a masked capabilities
> error because the firmware did not acknowledge OSC_SB_PCLPI_SUPPORT but
> it acknolwedged the others.
> 
> The second call to the platform _OSC without the query flag set then
> fails because the OSPM still sent the exact same values.  This leads
> to not acknowledging OSC_SB_NATIVE_USB4_SUPPORT and later USB4 PCIe
> tunnels can't be authorized.
> 
> This problem was first introduced by commit 159d8c274fd9 ("ACPI: Pass the
> same capabilities to the _OSC regardless of the query flag") which subtly
> adjusted the behavior from 719e1f5 ("ACPI: Execute platform _OSC also
> with query bit clear").
> 
> The _OSC was called exactly 2 times:
>  * Once to query and request from firmware
>  * Once to commit to firmware without query
> 
> To fix this problem, continue to call the _OSC until the firmware has
> indicated that capabilities are no longer masked or after an arbitrary
> number of negotiation attempts.
> 
> Furthermore, to avoid the problem that commit 159d8c274fd9 ("ACPI: Pass
> the same capabilities to the _OSC regardless of the query flag")
> introduced, explicitly mark support for CPC and CPPCv2 even if they
> were masked by the series of query calls due to table loading order on
> some systems.
> 
> Fixes: 159d8c274fd9 ("ACPI: Pass the same capabilities to the _OSC regardless of the query flag")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
