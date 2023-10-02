Return-Path: <linux-acpi+bounces-316-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72547B5061
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 12:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9530B282149
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D681101CB
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:33:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1188AC8F4
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 09:39:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A117DA;
	Mon,  2 Oct 2023 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696239576; x=1727775576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fHrjvcJ6gy9Fptsh53LE767saMnzrLZN5aVBlrefQ7I=;
  b=Oyg/dXKmKF4r+rnKdvg8K8W/D5S0VJ41xoRyn2Ho0d7M5abtvVaoHOgw
   a7NbTyLY+e22P9sOTjdtJlb3XLN1B09EGvcpAr9L4FxFhTcXPp5WQ/ySV
   W3wNBUf6F1x8pQRgxMnjiTtzzADZ04khx7N3qJ8yiXUHiy+ekrwynBkIo
   rBofcqb9/zPJBNWXGJKKyT8AC0935jUXrqf9DxEN9jpRfCfN+mH02E05y
   8zRyc/mKiMqoEST1q4LdurAd5mbK/m0FMYKcPWmq5g8VKdgl8ynDwsPEA
   PsbjnjrjrOcIr36fo3x9X6GphL3++oZ/5v/6L5mgW6Fm9YDQDbs8js8HO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="361988030"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="361988030"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:39:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="997574136"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="997574136"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:39:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qnFOl-000000027be-1Mac;
	Mon, 02 Oct 2023 12:39:31 +0300
Date: Mon, 2 Oct 2023 12:39:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 02/11] gpiolib: add support for scope-based management
 to gpio_device
Message-ID: <ZRqP07zBK5+Y8pDq@smile.fi.intel.com>
References: <20230927142931.19798-1-brgl@bgdev.pl>
 <20230927142931.19798-3-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927142931.19798-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 04:29:22PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> As the few users that need to get the reference to the GPIO device often
> release it right after inspecting its properties, let's add support for
> the automatic reference release to struct gpio_device.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



