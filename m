Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382163A76D1
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jun 2021 07:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhFOF5c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Jun 2021 01:57:32 -0400
Received: from verein.lst.de ([213.95.11.211]:47329 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhFOF5b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Jun 2021 01:57:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C9DEA67373; Tue, 15 Jun 2021 07:55:24 +0200 (CEST)
Date:   Tue, 15 Jun 2021 07:55:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
        prike.liang@amd.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Julian Sikorski <belegdol@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v8 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs
 to force the D3 hint
Message-ID: <20210615055524.GA21218@lst.de>
References: <20210609184018.26017-1-mario.limonciello@amd.com> <20210609184018.26017-2-mario.limonciello@amd.com> <831df669-b38e-9f4b-dd67-b613aaab6c28@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <831df669-b38e-9f4b-dd67-b613aaab6c28@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 14, 2021 at 09:02:36PM -0500, Limonciello, Mario wrote:
> Christoph, Keith ping on this series.  Any other thoughts?
> If it's good can you take this in for nvme-5.14 since Rafael mentioned
> the conflict from the other StorageD3Enable commit in nvme-5.14?

I'll queue it up for nvme-5.14.  I was planning to do a run today.
