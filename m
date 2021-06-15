Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAB03A8636
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jun 2021 18:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhFOQUX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Jun 2021 12:20:23 -0400
Received: from verein.lst.de ([213.95.11.211]:50179 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhFOQUW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Jun 2021 12:20:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 508EC67373; Tue, 15 Jun 2021 18:18:15 +0200 (CEST)
Date:   Tue, 15 Jun 2021 18:18:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
        prike.liang@amd.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v8 1/2] ACPI: Check StorageD3Enable _DSD property in
 ACPI code
Message-ID: <20210615161815.GA986@lst.de>
References: <20210609184018.26017-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609184018.26017-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks, I've applied the series to nvme-5.14.
