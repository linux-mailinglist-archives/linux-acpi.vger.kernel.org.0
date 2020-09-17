Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE53426E438
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 20:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgIQSmk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 14:42:40 -0400
Received: from verein.lst.de ([213.95.11.211]:57039 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728715AbgIQQy6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 12:54:58 -0400
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 12:54:42 EDT
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1B12468BEB; Thu, 17 Sep 2020 18:45:15 +0200 (CEST)
Date:   Thu, 17 Sep 2020 18:45:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-sh@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: support range based offsets in dma-direct v3
Message-ID: <20200917164514.GA5982@lst.de>
References: <20200916061500.1970090-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916061500.1970090-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I've pulled this into the dma-mapping for-next tree.  Thanks Jim and
everyone helping out!
