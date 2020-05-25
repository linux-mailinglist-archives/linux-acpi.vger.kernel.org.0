Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A121E0B71
	for <lists+linux-acpi@lfdr.de>; Mon, 25 May 2020 12:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389554AbgEYKJx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 May 2020 06:09:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:54391 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389398AbgEYKJx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 May 2020 06:09:53 -0400
IronPort-SDR: YwMnsldVoelR13YrRc6pw2WzPvl2SEswwwnIQJ08y7+7LS3UKPSBOEDuxQAfSaOigbuUywnz7G
 +o8wjTLleslA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 03:09:49 -0700
IronPort-SDR: UsYmB046x+P4gwRnG3gmNDXFzhBXSNFKte831o4xoMJOtg/LzZh/LreJyWoPg+Xv+GPooOF56f
 ZLzWQaYKV6Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="301783605"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 25 May 2020 03:09:48 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdA3L-008lWa-Af; Mon, 25 May 2020 13:09:51 +0300
Date:   Mon, 25 May 2020 13:09:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 4/5] gpio: pca935x: Allow IRQ support for driver built
 as a module
Message-ID: <20200525100951.GM1634618@smile.fi.intel.com>
References: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com>
 <20200520211916.25727-4-andriy.shevchenko@linux.intel.com>
 <CAMpxmJVEav8tOBoMWoekfQUaLOfCNOdj6N8fYx5UQ5e_VtHs5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJVEav8tOBoMWoekfQUaLOfCNOdj6N8fYx5UQ5e_VtHs5w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 25, 2020 at 11:38:32AM +0200, Bartosz Golaszewski wrote:
> śr., 20 maj 2020 o 23:19 Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> napisał(a):
> >
> > Perhaps by some historical reasons the IRQ support has been allowed
> > only for built-in driver. However, there is nothing prevents us
> > to build it as module an use as IRQ chip.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This may have been a stand-alone patch as well,

Yes.

>	so I went ahead and applied it for next.

Thanks!

-- 
With Best Regards,
Andy Shevchenko


