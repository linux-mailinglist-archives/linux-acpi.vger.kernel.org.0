Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099332C2570
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Nov 2020 13:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbgKXMNP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 24 Nov 2020 07:13:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:34791 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbgKXMNO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Nov 2020 07:13:14 -0500
IronPort-SDR: sPYzem0wNyX9LUIwReYJ37E+ncYe3a3WpzcqQE+ly/srPw8qd5dJml0dkcc5thsKAd0/NYzFj3
 LdhtHdzqb2NA==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="151191914"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="151191914"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 04:13:14 -0800
IronPort-SDR: 7sRMgkqgJDGROzikiPg+doVbqcPXuLq5Oh0AmMXWxvWpXe6UWiqMbnEVhOKVvWr42ZxXgr6nuM
 JONFxg0kJ8PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="478478918"
Received: from irsmsx604.ger.corp.intel.com ([163.33.146.137])
  by orsmga004.jf.intel.com with ESMTP; 24 Nov 2020 04:13:12 -0800
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 IRSMSX604.ger.corp.intel.com (163.33.146.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Nov 2020 12:13:11 +0000
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Tue, 24 Nov 2020 12:13:11 +0000
From:   "Rojewski, Cezary" <cezary.rojewski@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: RE: [PATCH v1] ASoC: Intel: catpt: Replace open coded variant of
 resource_intersection()
Thread-Topic: [PATCH v1] ASoC: Intel: catpt: Replace open coded variant of
 resource_intersection()
Thread-Index: AQHWwkgdIGKaAow/nEuYVlWZrtvA4KnXMNWA
Date:   Tue, 24 Nov 2020 12:13:11 +0000
Message-ID: <f33b4381ea3a4cf4b8e7f27676cd90ed@intel.com>
References: <20201124095628.54373-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201124095628.54373-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-11-24 10:56 AM, Andy Shevchenko wrote:
> Since we have resource_intersection() helper, let's utilize it here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Promised clean up for recently introduced helper.
> 
> This has dependency to the patches currently in linux-pm tree. Other than that
> everything else is already in upstream. Hence, logically it's better to push
> thru Rafael's tree than wait one more cycle.
> 
>   sound/soc/intel/catpt/core.h   | 11 -----------
>   sound/soc/intel/catpt/loader.c |  2 +-
>   2 files changed, 1 insertion(+), 12 deletions(-)
> 

Thanks for the patch, Andy.

I hope you didn't get the impression I somehow forgotten about this : )
Wanted to make it part of "cleanup/code reduction" after addition of
last two missing features (fw traces + external module support).

Fixes and removal of lpt-specific code were the priority though.
As change is already here, I don't see any reason for delaying its
merge:

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>

Regards,
Czarek
