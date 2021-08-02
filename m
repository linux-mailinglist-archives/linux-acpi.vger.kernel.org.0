Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD433DD2E1
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Aug 2021 11:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhHBJXK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Aug 2021 05:23:10 -0400
Received: from 8bytes.org ([81.169.241.247]:52224 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232965AbhHBJXK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Aug 2021 05:23:10 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 002B5379; Mon,  2 Aug 2021 11:22:58 +0200 (CEST)
Date:   Mon, 2 Aug 2021 11:22:40 +0200
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: Re: [PATCH v6 0/9] ACPI/IORT: Support for IORT RMR node
Message-ID: <YQe5YOZPvOIucqng@8bytes.org>
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
 <35db3320-d6e2-721e-8d49-e5e2e80e2359@nxp.com>
 <014a451d00304b80b3de700817d688de@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <014a451d00304b80b3de700817d688de@huawei.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 27, 2021 at 06:51:56AM +0000, Shameerali Kolothum Thodi wrote:
> A gentle ping on this...

This needs more reviews, and please add

	Will Deacon <will@kernel.org>

when you post the next version of this patch-set.

Regards,

	Joerg
