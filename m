Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EE955DAE9
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 15:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbiF1K3u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jun 2022 06:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244644AbiF1K3t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jun 2022 06:29:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EB62DABD;
        Tue, 28 Jun 2022 03:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656412188; x=1687948188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Au78MCEIZK1ygGIJgEKGdmYvYhaAqsHQWJs7/sj4sBI=;
  b=YsZNcazOeYMnaz7YP/eSg2Yk6dpWEktSLzJkxBzD6Us4x7l+o3qiTiI6
   MzFCnCviI+42v7d/xiRCGT6bSqaMXHMwJ+l9iPbgdNh8hX2J2lt4wgAv6
   Mi9BTw2kEjLZa7siqM/klOcpi/gqYMW1gAG46LR7ZLzmJPb+DjLQIxzhy
   /6Up/6J9uW2OdBMMUD/liDsLEc8IiUzZg/V2rrEe2Bs2GKQ7xqveBHcv2
   +YN+zb5+n4TG4ZnYPI+nvHoxlNEQlyomPuFEEXxTeIGP7KOM/QdOP9IYU
   bGjPYISfnt2Ej/QUB6h2hXpasiZITocaY8HJ84ztrW2PODDDGtbHsKoBr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="281741453"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="281741453"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:29:47 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="594743946"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:29:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1o68TW-000whw-HH;
        Tue, 28 Jun 2022 13:29:42 +0300
Date:   Tue, 28 Jun 2022 13:29:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        platform-driver-x86@vger.kernel.org,
        Stefan Seyfried <seife+kernel@b1-systems.com>
Subject: Re: [PATCH 2/7] platform/x86: panasonic-laptop: de-obfuscate button
 codes
Message-ID: <YrrYFgu17uC+bMxo@smile.fi.intel.com>
References: <20220624112340.10130-1-hdegoede@redhat.com>
 <20220624112340.10130-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624112340.10130-3-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 24, 2022 at 01:23:35PM +0200, Hans de Goede wrote:
> From: Stefan Seyfried <seife+kernel@b1-systems.com>
> 
> In the definition of panasonic_keymap[] the key codes are given in
> decimal, later checks are done with hexadecimal values, which does
> not help in understanding the code.
> Additionally use two helper variables to shorten the code and make
> the logic more obvious.

(Note, all comments are up to you, I understand that this is a fix and maybe
 better to make code neat in a separate change)

...

>  	struct input_dev *hotk_input_dev = pcc->input_dev;
>  	int rc;
>  	unsigned long long result;
> +	unsigned int key;
> +	unsigned int updown;

Perhaps make them more like reversed xmas tree order?

...

>  			sparse_keymap_report_event(hotk_input_dev,
> -					result & 0xf, 0x80, false);
> +					key, 0x80, false);

Maybe move one or more parameters to the previous line?

...

>  		if (!sparse_keymap_report_event(hotk_input_dev,
> -						result & 0xf, result & 0x80, false))
> +						key, updown, false))
>  			pr_err("Unknown hotkey event: 0x%04llx\n", result);

Ditto.

Although I would even go for

	rc = sparse_...;
	if (!rc)
		pr_err(...);


pattern.

-- 
With Best Regards,
Andy Shevchenko


