Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11861397A7D
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jun 2021 21:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhFATOJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Jun 2021 15:14:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:61698 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234650AbhFATOJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Jun 2021 15:14:09 -0400
IronPort-SDR: BlOxdSCzhdmZ5NwGUxrQK8+3ZYDfdxBDp1X5H5C4/tveGdEDUPC73d9deEJIOlc+/NTI35aBwE
 I1IDLWr5eBqA==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="264799553"
X-IronPort-AV: E=Sophos;i="5.83,240,1616482800"; 
   d="scan'208";a="264799553"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 12:12:27 -0700
IronPort-SDR: a7nJDfUrrNCtxryWVWxPKxtLZuR3c5Yo2mPV5ZYeZiUOzpHV/j8cBILxQpNBaz8r1B++T+R3t6
 6aZw2JcaFUYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,240,1616482800"; 
   d="scan'208";a="399433138"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2021 12:12:27 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.174])
        by linux.intel.com (Postfix) with ESMTP id 033C4580427;
        Tue,  1 Jun 2021 12:12:27 -0700 (PDT)
Message-ID: <108f45a7c73d3ae571ee518c33dc793f36c1ffd2.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] nvme: Look for StorageD3Enable on companion ACPI
 device instead
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Christoph Hellwig <hch@lst.de>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com,
        prike.liang@amd.com, Shyjumon N <shyjumon.n@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Date:   Tue, 01 Jun 2021 12:12:26 -0700
In-Reply-To: <20210531064655.GA1417@lst.de>
References: <20210528160234.9402-1-mario.limonciello@amd.com>
         <20210531064655.GA1417@lst.de>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2021-05-31 at 08:46 +0200, Christoph Hellwig wrote:
> On Fri, May 28, 2021 at 11:02:34AM -0500, Mario Limonciello wrote:
> > The documentation around the StorageD3Enable property hints that it
> > should be made on the PCI device.  This is where newer AMD systems
> > set
> > the property and it's required for S0i3 support.
> > 
> > So rather than look for nodes of the root port only present on
> > Intel
> > systems, switch to the companion ACPI device for all systems.
> > David Box from Intel indicated this should work on Intel as well.
> 
> I think we need to wait for the confirmation from David.

I've tested one configuration remotely already and it works. I've got
one more to test. I'll know by tomorrow.

David


