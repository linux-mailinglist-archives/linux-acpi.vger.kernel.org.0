Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D442225E3
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jul 2020 16:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgGPOjf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Jul 2020 10:39:35 -0400
Received: from verein.lst.de ([213.95.11.211]:34966 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbgGPOjf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Jul 2020 10:39:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 90D1B68BEB; Thu, 16 Jul 2020 16:39:31 +0200 (CEST)
Date:   Thu, 16 Jul 2020 16:39:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Dan Williams <dan.j.williams@intel.com>, shyjumon.n@intel.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V5] drivers/nvme: Add support for ACPI StorageD3Enable
 property
Message-ID: <20200716143931.GA23501@lst.de>
References: <20200702225011.10932-1-david.e.box@linux.intel.com> <20200709184333.6241-1-david.e.box@linux.intel.com> <CAJZ5v0iJeyf+eMsDd37GdBdQq4e_JkJwcCm9VdQNgaxcf_RrEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iJeyf+eMsDd37GdBdQq4e_JkJwcCm9VdQNgaxcf_RrEg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 13, 2020 at 01:12:26PM +0200, Rafael J. Wysocki wrote:
> I would write this as
> 
> if (fwnode_property_read_u8(acpi_fwnode_handle(adev),
>                             "StorageD3Enable", &val))
>         return false;
> 
> return val == 1;
> 
> to eliminate the redundant fwnode variable and untangle the last
> checks somewhat.
> 
> With that changed please feel free to add
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied to nvme-5.9 with the above fixup.
