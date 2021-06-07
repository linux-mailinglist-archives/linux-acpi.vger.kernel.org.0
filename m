Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512C339DE7E
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 16:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFGOTr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 10:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFGOTp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Jun 2021 10:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A24C761130;
        Mon,  7 Jun 2021 14:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623075473;
        bh=L/IcAmlfla3G6jqxEY2OT9sBai4M7rEkPnSNSRR930Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pp0Mmj/UapJ4mrUgFZgd3pKjSq1mLFQzXvDWyCijXdrHgS7IrfkUVLtxTuyXRcfvR
         YLe+/lfEOpkQzMIm0B1iw2A7uj9CEnpr3CTp5Cx5DFy8sGCOEP/jVE775bEQxZd9kg
         E4nxsZkBVTB0KF3k76q+Jg2CvjEu0CmLfdlpCIaqbb0qUbXFr+zLV4tmaf6474wTpm
         2mWCpDLPMnO1VcCC4t4a68gZnUMisbV/vQvLRf/Ln+tBgZLao1zMR9TrkPy+m8UAJ9
         qdf+pj5emT3NafmqdeYnAZGKw8vNdETJnq0X4iDVsqWtVAtfrQL7Eao1mNMd9h3Ebu
         700rTX7AbRZ7g==
Date:   Mon, 7 Jun 2021 23:17:47 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, prike.liang@amd.com
Subject: Re: [PATCH v4] acpi: Move check for _DSD StorageD3Enable property to
 acpi
Message-ID: <20210607141747.GA21631@redsun51.ssa.fujisawa.hgst.com>
References: <20210603190753.5084-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603190753.5084-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 03, 2021 at 02:07:53PM -0500, Mario Limonciello wrote:
> Although first implemented for NVME, this check may be usable by
> other drivers as well. Microsoft's specification explicitly mentions
> that is may be usable by SATA and AHCI devices.  Google also indicates
> that they have used this with SDHCI in a downstream kernel tree that
> a user can plug a storage device into.
> 
> Link: Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Suggested-by: Keith Busch <kbusch@kernel.org>
> CC: rrangel@chromium.org
> CC: david.e.box@linux.intel.com
> CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Prike Liang <prike.liang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
