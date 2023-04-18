Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895FD6E5913
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Apr 2023 08:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjDRGHP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Apr 2023 02:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRGHP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2023 02:07:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F4D2117
        for <linux-acpi@vger.kernel.org>; Mon, 17 Apr 2023 23:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681798034; x=1713334034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4HOGvGRrgxLPBHF2y8+hD/w5YFi8aWVMZoIaM87X/3c=;
  b=WlA0eZ3fBtCO9i+6tzB/nOI2813jvaCCPgWMdVr0pfXM/FNzORhecDj+
   gDRmTHb49xLc96Q2sOaqBWtVpkL+JL9H9Y5ckCXpm4aTmytjKiwkvTX/+
   my7v3UzdKKLycsQCS5HHVVchmUYM9QusvJWQS6djUH257JSwCX9Gx6PAf
   sdWKw5uFvdi596/df6/lZlU3HpBjT0oMCNhVHq0sdZfTYtBrMKASw1olx
   AIYzjCG3RX4cmbD0MmyUfACGwA+lvuHH6Cl6yCyZZCntilDTZNPRrCIxx
   u3Dy+LuKEVqi/ZtDV6QlvCnix/LWYVPUb06IS6jJsgHMjE9HvxQrgj4yr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="431373300"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="431373300"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 23:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="937123054"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="937123054"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 17 Apr 2023 23:07:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5354D125; Tue, 18 Apr 2023 09:07:17 +0300 (EEST)
Date:   Tue, 18 Apr 2023 09:07:17 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: LPSS: Add 80862289 ACPI HID for second PWM
 controller on Cherry Trail
Message-ID: <20230418060717.GD66750@black.fi.intel.com>
References: <20230417211128.588008-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230417211128.588008-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

On Mon, Apr 17, 2023 at 11:11:28PM +0200, Hans de Goede wrote:
> On some Cherry Trail devices the second PWM controller uses
> 80862289 as ACPI HID, rather then using 80862288 as is done

ACPI _HID (ditto in $subjet)

> for both controllers on most models.
> 
> Add the missing 80862289 ACPI HID, note this uses its own

ACPI _HID

> lpss_device_desc, without ".setup = bsw_pwm_setup" so that
> the pwm_lookup is not added for it.
> On devices where both controllers use the 80862288 HID bsw_pwm_setup()

_HID

> does a UID check to avoid registering the lookup for the second

_UID

> controller but that will not work here.
> 
> Adding the missing id fixes the second PWM controller no longer
> working after the entire LPSS1 island has been in D3 at least
> once, which causes the contents of the LPSS private registers
> to get lost. Adding the HID makes acpi_lpss restore these

_HID

> when the controller moves from D3 to D0.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

With the above changes, feel free to add

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
