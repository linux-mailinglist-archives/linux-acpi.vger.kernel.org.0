Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F7D399614
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 00:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFBWvW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 18:51:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:62530 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhFBWvW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Jun 2021 18:51:22 -0400
IronPort-SDR: bQIJYUnEKFyURljBJDtKcmSXY4SJ7d8Hp226/kIMFK8PTa5AUD5WLKODO6kLLjFcw70f+ZyeOg
 1Ynkj7RG5KMw==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="265091482"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="265091482"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 15:49:38 -0700
IronPort-SDR: rNhRJ2xo3kwM6tir1AvW30tn821t94TXT/k67tvk6iBd4TKBBjiPLnOAEMSE//6PnvqJPmLXi/
 hNpA4scfFnuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="438573895"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 02 Jun 2021 15:49:38 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.174])
        by linux.intel.com (Postfix) with ESMTP id 792825805A1;
        Wed,  2 Jun 2021 15:49:38 -0700 (PDT)
Message-ID: <7ff9423dc806f1354e51dbb69dea9b70dd8c6eea.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] nvme: Look for StorageD3Enable on companion ACPI
 device instead
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "prike.liang@amd.com" <prike.liang@amd.com>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "N, Shyjumon" <shyjumon.n@intel.com>
Date:   Wed, 02 Jun 2021 15:49:38 -0700
In-Reply-To: <474a58bf-dcc9-48a8-c5ce-fb79f2b76a79@amd.com>
References: <20210528160234.9402-1-mario.limonciello@amd.com>
         <20210531064655.GA1417@lst.de>
         <PH0PR11MB4853EBD21B8D89AC8138308F9E3E9@PH0PR11MB4853.namprd11.prod.outlook.com>
         <474a58bf-dcc9-48a8-c5ce-fb79f2b76a79@amd.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mario,

The patch works for systems that worked on the current implementation.
Thanks.

Reviewed-by: David E. Box <david.e.box@linux.intel.com>

On Tue, 2021-06-01 at 10:15 -0500, Limonciello, Mario wrote:
> > 
> > I think we need to wait for the confirmation from David.  This looks
> > good, but I'd like to see testing.  I also wonder how many of the
> > simple suspend quirks we can drop with this.
> 
> David, do you think you can get this soonish or are you similarly 
> blocked like Shyjumon by remote work restrictions?  As this is causing 
> see this series land for 5.14.  If you can't get to it in time, I would
> prefer that we switch this patch back to how it was conservatively done
> in v1 for 5.14 (and redo 2/2 on top of that):
> https://lore.kernel.org/linux-nvme/20210527113751.GB17266@lst.de/T/#t
> 
> and let you get back to the list when you can to optimize it "later".
> 
> > 
> > Shyjumon and Jon, can you retests the platforms quirked in
> > 1fae37accfc5 ("nvme/pci: Add sleep quirk for Samsung and Toshiba
> > drives") with this fix?
> > 
> > Shyjumon>> Yes, I do agree we need to test this also. However the
> > boards where which I had these issues are not in my remote access now
> > (as the work frequency on this boards are less and also due to Covid
> > situation),
> >                          It might  take some time for me to test. I
> > will update as soon as I can.
> > 


