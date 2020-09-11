Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D848E265F55
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Sep 2020 14:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgIKMOg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Sep 2020 08:14:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:25316 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgIKMNi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 11 Sep 2020 08:13:38 -0400
IronPort-SDR: 52XsU1LdFlkZo11C00j/BA6w8Evv9a3/V1tga02qrIBH411PCAbgMoy8tJjTThpeTLG8be7Ha9
 5ehFhfBBB7zQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="220296942"
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="220296942"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:11:14 -0700
IronPort-SDR: IuXzKhmbK9o4Dul8zRwA1SN5tCnJAoObl17SRVCiaVvQEiTajzqaED83Ha3ZbUMZLcvrNFfzc5
 QMuTtD5qV7mg==
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="286879413"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:11:11 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 8CAC52079D; Fri, 11 Sep 2020 15:11:09 +0300 (EEST)
Date:   Fri, 11 Sep 2020 15:11:09 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        linux-media <linux-media@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v8 6/6] at24: Support probing while off
Message-ID: <20200911121109.GE26842@paasikivi.fi.intel.com>
References: <20200903081550.6012-1-sakari.ailus@linux.intel.com>
 <20200903081550.6012-7-sakari.ailus@linux.intel.com>
 <CAMpxmJX40=iYYxL9Uvs1Pjj9c3NvZBGJ9Mh9-87T0c==FKEXRw@mail.gmail.com>
 <20200909111121.GJ2272@ninjato>
 <CAMpxmJXDrL92QH_Vb+P4LoQ-WGBMM42GvzXjquW2Lzotm5wggA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJXDrL92QH_Vb+P4LoQ-WGBMM42GvzXjquW2Lzotm5wggA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Bartosz, Wolfram,

On Wed, Sep 09, 2020 at 01:56:34PM +0200, Bartosz Golaszewski wrote:
> On Wed, Sep 9, 2020 at 1:11 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> >
> > > This currently conflicts with the fix I queued for at24 for v5.9.
> > > Which tree is going to take this series?
> >
> > I recall we agreed on I2C.
> >
> 
> Sakari,
> 
> can you rebase the at24 driver patch on top of Wolfram's tree as soon
> as he merges my PR with at24 fixes?

I need some additional time with the set, and that may take it beyond
v5.10. Either way, I'll keep you posted.

Thanks.

-- 
Kind regards,

Sakari Ailus
