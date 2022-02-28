Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784554C7227
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Feb 2022 18:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbiB1RHB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Feb 2022 12:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbiB1RGz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Feb 2022 12:06:55 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161686E3B
        for <linux-acpi@vger.kernel.org>; Mon, 28 Feb 2022 09:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646067976; x=1677603976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pb7Hm42mf/lmlTOz5cdZFdZ4Dl3I16sTY1nNhUrhYz4=;
  b=B8/ui41E4P3HDrkTCVM5J9OxtTVs76qqe4KNz9hPMVhh3dRYe7MbZ5pr
   kI+SrJyJQoDRFQoTAo2cJJxQXRTzAw1bvHNwy92VrN4joAtLIK/ziwhoL
   U7cNNw3Pp8WI6tOwmDiPyBpLDOx5YruNhfAzKkd/7KDHFT8JGDJgUedwJ
   jtZXAJ2uELCgT4MONoRWitcgombY7KJPspVfQVLRUdLJugnrn3Fuw2SNY
   YMf4kwiVNeDItjKan3hqgB/CT8e1rKaBEa7daoloVCvCRFxg/M9qk4ZHy
   TibXOsh9rBvJbtwYQNZpbGxV/o4mqcpoGxKg/BZssfb7mfrLektvldHcO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="313650698"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="313650698"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:06:16 -0800
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="492780679"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:06:13 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 28 Feb 2022 19:06:11 +0200
Date:   Mon, 28 Feb 2022 19:06:11 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Xiaomeng.Hou@amd.com,
        Aaron.Liu@amd.com, Ray.Huang@amd.com, hdegoede@redhat.com
Subject: Re: [PATCH v2 2/3] ACPI: bus: Allow negotiating OSC capabilities
Message-ID: <Yh0BA/JUInoQYaYq@lahna>
References: <20220225055224.190669-1-mario.limonciello@amd.com>
 <20220225055224.190669-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225055224.190669-2-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 24, 2022 at 11:52:23PM -0600, Mario Limonciello wrote:
> Currently when capabilities have been masked by firmware during a
> negotiation with OSC_QUERY_ENABLE set they're silently ignored
> by the caller.  If the caller calls `acpi_run_osc` again without
> query set and the same capabilities, then they instead get a failure
> possibly leading to downstream problems.
> 
> So instead when query is set return AE_SUPPORT which callers can then
> use for determining that capabilities were masked.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
