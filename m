Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9920F3955A4
	for <lists+linux-acpi@lfdr.de>; Mon, 31 May 2021 08:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhEaGyr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 May 2021 02:54:47 -0400
Received: from verein.lst.de ([213.95.11.211]:48300 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhEaGyq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 May 2021 02:54:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F8F067373; Mon, 31 May 2021 08:53:04 +0200 (CEST)
Date:   Mon, 31 May 2021 08:53:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, prike.liang@amd.com
Subject: Re: [PATCH v3 2/2] acpi: Move check for _DSD StorageD3Enable
 property to acpi
Message-ID: <20210531065304.GB1417@lst.de>
References: <20210528160253.9492-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528160253.9492-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 28, 2021 at 11:02:53AM -0500, Mario Limonciello wrote:
> Although first implemented for NVME, this check may be usable by
> other drivers as well.

I think we want to expand this a little more, mentioning that the
Microsoft spec for it also explicitly mentions SATA/AHCI, that Google
has a local tree where this applied to SDHCI and that even if a slot
is intended for storage a user can plug any card into it.

> +/**
> + * acpi_storage_d3 - Check if a storage device should use D3.
> + * @dev: Device to check
> + *
> + * Look for a _DSD property specifying that the storage device
> + * should use D3 to support deep platform power savings during
> + * suspend-to-idle.
> + *
> + */

Maybe something like:

/**
 * acpi_storage_d3 - check if a device must use D3 for suspend
 * @dev: Device to check
 *
 * Returns %true if @pdev should be put into D3 when the ->suspend method is
 * called, else %false.  The name of this function is somewhat misleading
 * as it has nothing to do with storage except for the name of the ACPI
 * property.  On some platforms resume will not work if this hint is ignored.
 */
