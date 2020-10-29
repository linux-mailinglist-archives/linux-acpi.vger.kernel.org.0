Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A95D29E627
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 09:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgJ2IQN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 04:16:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:58354 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbgJ2IQI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 04:16:08 -0400
IronPort-SDR: HTSdNJogHuTtetzQVetxwQbEfNhUmgcwOiTu0EnzC05hYHKNoTEQdK/CZAQpyGEGFpgdFdtjM3
 BKBiP36GthwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="156168552"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="156168552"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 01:16:07 -0700
IronPort-SDR: /R6soGKFOYJVlmqoqJf2a69w9RwKE6WZiAA8fv2u6fzxY9z2gHGYtfV9jObtpzvyoEUwlIFfsw
 e/Xa768EjCvg==
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="351342479"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 01:16:05 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 29 Oct 2020 10:13:52 +0200
Date:   Thu, 29 Oct 2020 10:13:52 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-gpio@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v1 2/3] Documentation: firmware-guide: gpio-properties:
 active_low only for GpioIo()
Message-ID: <20201029081352.GP2495@lahna.fi.intel.com>
References: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
 <20201028205101.47583-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028205101.47583-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 28, 2020 at 10:51:00PM +0200, Andy Shevchenko wrote:
> It appears that people may misinterpret active_low field in _DSD
> for GpioInt() resource. Add a paragraph to clarify this.
> 
> Reported-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
