Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBA9399B60
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 09:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhFCHTW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Jun 2021 03:19:22 -0400
Received: from verein.lst.de ([213.95.11.211]:60691 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhFCHTW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Jun 2021 03:19:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5AA9968AFE; Thu,  3 Jun 2021 09:17:36 +0200 (CEST)
Date:   Thu, 3 Jun 2021 09:17:35 +0200
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
Subject: Re: [PATCH v3 1/2] nvme: Look for StorageD3Enable on companion
 ACPI device instead
Message-ID: <20210603071735.GA4607@lst.de>
References: <20210528160234.9402-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528160234.9402-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks,

applied to nvme-5.14.  I've also added a fixes tag.
