Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5CBF8BF1E
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2019 19:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfHMRBP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Aug 2019 13:01:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:24701 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfHMRBO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Aug 2019 13:01:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 10:01:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="194233254"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 13 Aug 2019 10:01:10 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 13 Aug 2019 20:01:09 +0300
Date:   Tue, 13 Aug 2019 20:01:09 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Raanan Avargil <raanan.avargil@intel.com>,
        David Laight <David.Laight@aculab.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 7/8] thunderbolt: Add support for Intel Ice Lake
Message-ID: <20190813170109.GB18281@lahna.fi.intel.com>
References: <20190812123847.50802-1-mika.westerberg@linux.intel.com>
 <20190812123847.50802-8-mika.westerberg@linux.intel.com>
 <20190813161038.tip2u2z22xqnmfjl@wunner.de>
 <20190813164930.GA18281@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813164930.GA18281@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 13, 2019 at 07:49:35PM +0300, Mika Westerberg wrote:
> > If so, I'd suggest:
> > 
> > 	/* Keep the domain powered while veto is in effect */
> > 	if (cmpxchg(&icm->veto, false, true))
> > 		pm_runtime_get(&tb->dev);
> > 
> > You'll have to declare icm->veto unsigned int instead of bool
> > because thunderbolt.ko is compiled if CONFIG_COMPILE_TEST is
> > enabled and there are arches which do not support cmpxchg for
> > a size of 1 byte.
> > 
> > The other bools in struct icm should likewise be unsigned int
> > per Linus' dictum:
> > https://lkml.org/lkml/2017/11/21/384
> 
> Yeah, it probably wastes some space but I like them because IMHO they
> are more readable than bitfields. We have a bunch of other bools in the
> driver structures so if we are going to convert struct icm we should do
> the same for others to keep things consistent. Probably should be a
> separate cleanup patch.

Then again assigning to bool looks more "correct" than with bitfield:

   icm->veto = false;

vs.

   icm->veto = 0;

It is possible to use false/true with bitfield but it does not feel
right. Maybe it's just me ;-)
