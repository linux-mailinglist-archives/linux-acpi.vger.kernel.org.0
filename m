Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC4B012CEA2
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2019 11:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfL3KIt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Dec 2019 05:08:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:4969 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfL3KIs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Dec 2019 05:08:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Dec 2019 02:08:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,374,1571727600"; 
   d="scan'208";a="224201938"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 30 Dec 2019 02:08:45 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 30 Dec 2019 12:08:44 +0200
Date:   Mon, 30 Dec 2019 12:08:44 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: baytrail: Remove WARN when setting
 direct-irq pin to output
Message-ID: <20191230100844.GC2628@lahna.fi.intel.com>
References: <20191225132812.90889-1-hdegoede@redhat.com>
 <20191227141220.GA2628@lahna.fi.intel.com>
 <acafef49-bd32-6900-01d2-f6adccabe201@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acafef49-bd32-6900-01d2-f6adccabe201@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 27, 2019 at 11:47:38PM +0100, Hans de Goede wrote:
> The problem is that we hit this path everytime we output a value on the
> pin. I guess we can change the WARN to dev_info_once() if you prefer that.

Yes, I think dev_info_once() would be fine.
