Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C68395595
	for <lists+linux-acpi@lfdr.de>; Mon, 31 May 2021 08:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhEaGsj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 May 2021 02:48:39 -0400
Received: from verein.lst.de ([213.95.11.211]:48283 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhEaGsi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 May 2021 02:48:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2A34F67373; Mon, 31 May 2021 08:46:56 +0200 (CEST)
Date:   Mon, 31 May 2021 08:46:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, prike.liang@amd.com,
        Shyjumon N <shyjumon.n@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH v3 1/2] nvme: Look for StorageD3Enable on companion
 ACPI device instead
Message-ID: <20210531064655.GA1417@lst.de>
References: <20210528160234.9402-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528160234.9402-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 28, 2021 at 11:02:34AM -0500, Mario Limonciello wrote:
> The documentation around the StorageD3Enable property hints that it
> should be made on the PCI device.  This is where newer AMD systems set
> the property and it's required for S0i3 support.
> 
> So rather than look for nodes of the root port only present on Intel
> systems, switch to the companion ACPI device for all systems.
> David Box from Intel indicated this should work on Intel as well.

I think we need to wait for the confirmation from David.  This looks good,
but I'd like to see testing.  I also wonder how many of the simple suspend
quirks we can drop with this.

Shyjumon and Jon, can you retests the platforms quirked in
1fae37accfc5 ("nvme/pci: Add sleep quirk for Samsung and Toshiba drives")
with this fix?
