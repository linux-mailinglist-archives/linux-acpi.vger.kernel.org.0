Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149B44C700A
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Feb 2022 15:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiB1Ovg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Feb 2022 09:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiB1Ovg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Feb 2022 09:51:36 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AAC8091A
        for <linux-acpi@vger.kernel.org>; Mon, 28 Feb 2022 06:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646059857; x=1677595857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DOQ/mrplyBBVdMUiUKZge5sdMKQm//NuTh5SKxS9WT4=;
  b=AS1rz+EbAcQof7Bi1a18LkRAt+L9KuQ1VvjhpYvsjNJEx+oOHkagCla+
   nec/aq7S/cnQ82Z6h97rprvJVp8EN1ozIBrc2J63qMlBXlbMwCWfc0rns
   pdJaRbbjV52xSCmRVKf9Fnku9WBkNrI96Qa9KpNNkkyttpjV7+KsJdNGk
   0DU1OnOqsoOTi0PEqDznUdUT29yvA09L1Y3ebFstgcUX0mHGh8Nse/BWq
   Teh2soPhchBPqzPowbRqGkxAUdWuJZjg+WwjWmlpBUFEuGzMO1SF4jvJg
   EE5A9V0kbUOvh9ywcIEB+j6OKFR+PaljJvxa99YII6dSjdqAK/ewdBmuc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="313614954"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="313614954"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 06:50:57 -0800
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="544754830"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 06:50:54 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 28 Feb 2022 16:46:31 +0200
Date:   Mon, 28 Feb 2022 16:46:31 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Xiaomeng.Hou@amd.com,
        Aaron.Liu@amd.com, Ray.Huang@amd.com, hdegoede@redhat.com
Subject: Re: [PATCH v2 1/3] ACPI: APEI: Adjust for acpi_run_osc logic changes
Message-ID: <YhzgR/YgbEsvtZNG@lahna>
References: <20220225055224.190669-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225055224.190669-1-mario.limonciello@amd.com>
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

On Thu, Feb 24, 2022 at 11:52:22PM -0600, Mario Limonciello wrote:
> As this function calls the OSC with the OSC_QUERY_ENABLE set in
> OSC_QUERY_DWORD, ensure that it continues to operate the same if
> the function has returned AE_SUPPORT.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
