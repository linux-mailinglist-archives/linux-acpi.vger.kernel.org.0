Return-Path: <linux-acpi+bounces-309-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3F47B46DA
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Oct 2023 12:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B8BE71C208EB
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Oct 2023 10:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9106C15AC6
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Oct 2023 10:30:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA94433
	for <linux-acpi@vger.kernel.org>; Sun,  1 Oct 2023 09:16:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149C1AC;
	Sun,  1 Oct 2023 02:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696151789; x=1727687789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f7ZjnRWA5IXftfGyE3gvweEj9IY5PzhGygrisd80E1g=;
  b=FUfATbPPeV/CU9xNAzHOtWvb1ctyGtpSqXK3TiSTgb4GasjpOrBAYxe5
   wm5O0plRk4tAz7tw7XitjoKFiRNxt2MPiqp9OSp815JKKx59x2GGXTK0C
   GszUdow09gfc8ct90gcNDdAkd0PQ7veyUBmOM4E504KsBcq+VHvntBCMr
   w/YB7ZFgDC950mIPR9x12nuDp8Txhbs9pLzWf0qu8GX3CBbe/du2dfo3S
   moV1emr7L+1wjMdHWvxt2XcM5V6j4t/xecsrt3hVS8yRAxvzx9hdEGZk4
   Bn3ztzC1VAoQaIGEcutjKNxwHvyIaV/I4fpiYBUXmqDQgLlvgHFzznk1a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="446665083"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="446665083"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 02:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="866196860"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="866196860"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 02:16:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qmsYo-00000001rUf-0XnC;
	Sun, 01 Oct 2023 12:16:22 +0300
Date: Sun, 1 Oct 2023 12:16:21 +0300
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
Subject: Re: [PATCH v2 5/5] gpio: acpi: remove acpi_get_and_request_gpiod()
Message-ID: <ZRk45XJgLxSiocO9@smile.fi.intel.com>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
 <93be52fc-fa87-423f-dde2-1b0b758ab632@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93be52fc-fa87-423f-dde2-1b0b758ab632@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 02:45:51PM +0200, Hans de Goede wrote:
> With no more users, we can remove acpi_get_and_request_gpiod().

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Link: https://lore.kernel.org/r/20230926145943.42814-5-brgl@bgdev.pl
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Authorship?

Missing Mika's tag?

-- 
With Best Regards,
Andy Shevchenko



