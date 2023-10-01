Return-Path: <linux-acpi+bounces-307-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1910A7B46D8
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Oct 2023 12:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 2C42A1C208BB
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Oct 2023 10:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022FC15AC0
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Oct 2023 10:30:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA681364
	for <linux-acpi@vger.kernel.org>; Sun,  1 Oct 2023 08:42:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27944B3;
	Sun,  1 Oct 2023 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696149739; x=1727685739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sWvqOZkq+0BZQpNOVZiv4CjVHp5FMxqth8BjfwKctd4=;
  b=fjRfMgUttgZhdecu+AxR2DaJgL158gt49+BQg0ZcU88LLjRfnFSkoqjw
   cG3qEylV3LgtwCmlBHPcLT3KLPRCdSE3uoCOWyM6Yz1WVrPhKLd91jG36
   +ygij6qLYeUrdTfWPZUnh/Ge9stRagnd926HML988txxThv9kvuIX2Sd3
   R2Uto0i8eXnAtT5IkSGhl9k1EcIFIGlC6T4m0RDf+e8473yPnUA1J6krj
   hqKZFGmf6rNCDXt2TIyBQxhlP+8UjXoFHE5qji5ENan62etL+FRtEQBkp
   C5nBjIrnaXrItsCVd/3/1t9L692TeAsvzIzl/YH+6rJKiEhHzC1iTzmke
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="385333195"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="385333195"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 01:42:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="820596568"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="820596568"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 01:42:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qms1k-00000001r7u-234T;
	Sun, 01 Oct 2023 11:42:12 +0300
Date: Sun, 1 Oct 2023 11:42:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 2/5] platform/x86: int3472: Add new
 skl_int3472_gpiod_get_from_temp_lookup() helper
Message-ID: <ZRkw5FfhSq3J+Wb8@smile.fi.intel.com>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
 <b8b1a3f0-3aca-341c-07ee-389b077a01f7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b1a3f0-3aca-341c-07ee-389b077a01f7@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 02:42:50PM +0200, Hans de Goede wrote:
> Add a new skl_int3472_gpiod_get_from_temp_lookup() helper.
> 
> This is a preparation patch for removing usage of the deprecated
> gpiod_toggle_active_low() and acpi_get_and_request_gpiod() functions.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> [hdegoede@redhat.com] use the new skl_int3472_fill_gpiod_lookup() helper
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Something wrong between authorship and committer and SoB chain.
I believe you need to preserve the authorship and add yourself as
Co-developed-by: ?

-- 
With Best Regards,
Andy Shevchenko



