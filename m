Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979F317DDE8
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2020 11:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgCIKss (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Mar 2020 06:48:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:15000 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgCIKss (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Mar 2020 06:48:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 03:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,532,1574150400"; 
   d="scan'208";a="353345195"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 09 Mar 2020 03:48:45 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 09 Mar 2020 12:48:44 +0200
Date:   Mon, 9 Mar 2020 12:48:44 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add missing __init(const) markers to
 initcall-s
Message-ID: <20200309104844.GK2540@lahna.fi.intel.com>
References: <20200306144722.175298-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306144722.175298-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 06, 2020 at 03:47:22PM +0100, Hans de Goede wrote:
> The gpiolib ACPI code uses 2 initcall-s and the called function
> (and used DMI table) is missing __init(const) markers.
> 
> This commit fixes this freeing up some extra memory once the kernel
> has completed booting.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
