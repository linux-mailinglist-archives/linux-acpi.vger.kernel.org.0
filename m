Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C8D6FCC6C
	for <lists+linux-acpi@lfdr.de>; Tue,  9 May 2023 19:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjEIRLt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 May 2023 13:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjEIRLd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 May 2023 13:11:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78D6EE
        for <linux-acpi@vger.kernel.org>; Tue,  9 May 2023 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683652198; x=1715188198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=n2Fgrw6xn6MZYVBpnki0BXXGAkz3fr3FL+kM3NhjGtk=;
  b=BihAu9byyh4oOhERGEk62SxZC8RyKGDz581zOkAKk6Q/BDIfxll9tD2Y
   hsuI8kAURCEB+p2knT8iAXtbS7LMC5N2OEJqoJeqMSWw8z18ERFH/kLE2
   KhoZQHUfTyRALoq0kwje9/Br05J56Vt8Sv7O/iInGSGcZ0nVjfj03xjFy
   dPtNFCu9CHZozh5CXrWtK5YNdrJNi0Y+evUw3P2QD9qGNPWCO7xe0DpIv
   6NcIrIvgBJ45szhVzIXYcrXuwdWd4vVr3F1JRMyRP/Q4bNTReVbDPotn2
   ZVMTcNYm0TOQ00IljJgtjisKCqzVRCMIkWJ2uBHQNHzO00KOy7GrAGEtH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="352168610"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="352168610"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 10:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="1028889396"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="1028889396"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 09 May 2023 10:09:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5F03617D; Tue,  9 May 2023 20:09:48 +0300 (EEST)
Date:   Tue, 9 May 2023 20:09:48 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] ACPI: LPSS: Add pwm_lookup_table entry for second PWM
 on CHT/BSW devices
Message-ID: <20230509170948.GN66750@black.fi.intel.com>
References: <20230509124100.288814-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230509124100.288814-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 09, 2023 at 02:41:00PM +0200, Hans de Goede wrote:
> BSW PWM2 is used for backlight control for fixed (etched into the glass)
> touch controls on some models.
> 
> Add an entry for the second PWM controller to bsw_pwm_lookup,
> so that drivers can use pwm_get() to get a reference to it.
> 
> These touch-controls have specialized drivers which bind to different
> devices on different models, so the consumer-device-name in the lookup
> table entry is set to NULL, so that only con-id matching is used.
> 
> The con-id is set to "pwm_soc_lpss_2" which describes the PWM controller
> rather than the usual approach of describing its function.
> The specialized (model specific) drivers which need access to the PWM
> controller know they need the "pwm_soc_lpss_2" con-id.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
