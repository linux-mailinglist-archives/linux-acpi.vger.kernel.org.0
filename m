Return-Path: <linux-acpi+bounces-179-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFC37AFEA1
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A56CE284305
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECE12F93
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 08:33:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C4F2F93
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:55:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A402012A;
	Wed, 27 Sep 2023 00:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695801317; x=1727337317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f4PyUwh+YVyTNsxc/+QRSFd54iP09xRqZftgK4fNc8U=;
  b=fIvNNW/ui7PVlOdTZCBZ1kbS7c9Vw704Q8QRvrd+b9+gHotNUYp1VGuw
   T/xHF3SRR/HM9YGBKWn8LQ74+TdkK8I+XPiicjrbsp2EJveiJMTHyF0VQ
   R50/qOlqdjvLApNzCOFCF0OqoF4YudoMxknjiDABEqohMi7xtdidgtKFb
   Jn7sxX/fBsOe0pJj3aoDae9Xk/g9DQcR1vHXd5J2tEPAx+Iu/TD53N1mu
   hb827adG11YqvzBddn5LjW4Ueq6/IQO80fH0Ufs2dSvamCzvce+ut4/jc
   14wlDg09/j3Ovh3F8VN6yfZVk281b8bbF8tiQbNjK9giwA+JCpd+fELwD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385613387"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="385613387"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="819325158"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="819325158"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 27 Sep 2023 00:55:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 5FCBB133D; Wed, 27 Sep 2023 10:55:12 +0300 (EEST)
Date: Wed, 27 Sep 2023 10:55:12 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH 4/4] gpio: acpi: remove acpi_get_and_request_gpiod()
Message-ID: <20230927075512.GE3208943@black.fi.intel.com>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <20230926145943.42814-5-brgl@bgdev.pl>
 <ZRL4epTUrDmHCk8K@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRL4epTUrDmHCk8K@smile.fi.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 06:27:54PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 26, 2023 at 04:59:43PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > With no more users, we can remove acpi_get_and_request_gpiod().
> 
> The best patch in the series!
> Reviewed-by: From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Fully agree!

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

