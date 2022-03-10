Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CC24D43AA
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 10:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiCJJoN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 04:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240892AbiCJJoN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 04:44:13 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23A0694A0
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 01:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646905392; x=1678441392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nJDuBFBWhgnMu54bwr6tU62dHI0EOIlopOB62xKZpFE=;
  b=VPCe8kocGTvPZSWw1aDFaTI55/7oESMXHKpTyFzfUsGLBXRM0VCK1CTJ
   cn4KtrNVlaOE5cOwYm1bCpp7nHpZw7I/PWXtii0dG3EN5tRhYeh94g/ki
   pcCrQdtyYpOM40qngm1CeXKVIb3xqYAqF+dt3MwV0gwMk0CwzMKxhUDlm
   eiwA82BrDU7YHV6DiZ+tAHCr/p7iNUKZwhUl/J3jHWDkxJmLGVUTio56o
   IZ4vzMXuSBCJZd34+bsBlJZctyXfmw1XErq1eiwKCKWfcMUBadvsWlAbW
   vLVDTHCNatrs1q650bj8cizbuw6Q2+EIeWOSIB4RxtEZwnb5sTREVNRu0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235157991"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="235157991"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 01:43:12 -0800
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="554568685"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 01:43:09 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 10 Mar 2022 11:43:06 +0200
Date:   Thu, 10 Mar 2022 11:43:06 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Xiaomeng.Hou@amd.com,
        Aaron.Liu@amd.com, Ray.Huang@amd.com, hdegoede@redhat.com
Subject: Re: [PATCH v5] ACPI: bus: For platform OSC negotiate capabilities
Message-ID: <YinIKrMkqBd4Igma@lahna>
References: <20220309163749.773474-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309163749.773474-1-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 09, 2022 at 10:37:49AM -0600, Mario Limonciello wrote:
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
> ---
> This series was accepted but showed a regression in another use of acpi_run_osc
> so the series was dropped.
> 
> Changes from v4->v5:
>  * Move negotiation entirely into acpi_bus_osc_negotiate_platform_control

Probably worth mentioning that the v5 fixes memory leak that was
reported.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
