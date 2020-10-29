Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F2A29E609
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 09:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgJ2INb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 04:13:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:35280 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbgJ2INV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 04:13:21 -0400
IronPort-SDR: K+zLlOxd/NKQEhBf+WzmxCunRKu9bSLGUzmTVFqn1BgurXddLr6dUH8YAbPm3Z4VCXol+Cn2GN
 JDp++QCBlkRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="168526448"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="168526448"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 01:13:20 -0700
IronPort-SDR: agDYh3Fb7s9+0dDfbbGN4GFsUviUp9DQ1XzenGH3rHdWkxr7KLFcaURn5CPekjjz3j3J7iOHEn
 rYfa/O5nLhrA==
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="469046957"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 01:13:18 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 29 Oct 2020 10:13:15 +0200
Date:   Thu, 29 Oct 2020 10:13:15 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/3] Documentation: firmware-guide: gpio-properties:
 Fix factual mistakes
Message-ID: <20201029081315.GO2495@lahna.fi.intel.com>
References: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 28, 2020 at 10:50:59PM +0200, Andy Shevchenko wrote:
> Fix factual mistakes and style issues in GPIO properties document.

Can you clarify here what factual mistakes this fixes :)

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
