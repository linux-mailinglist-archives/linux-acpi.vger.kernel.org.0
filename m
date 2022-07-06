Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7874D568623
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Jul 2022 12:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiGFKv4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jul 2022 06:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiGFKvz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jul 2022 06:51:55 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBD4275E7
        for <linux-acpi@vger.kernel.org>; Wed,  6 Jul 2022 03:51:54 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A741A4CC; Wed,  6 Jul 2022 12:51:51 +0200 (CEST)
Date:   Wed, 6 Jul 2022 12:51:50 +0200
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "jon@solid-run.com" <jon@solid-run.com>,
        Linuxarm <linuxarm@huawei.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "lorenzo.pieralisi@gmail.com" <lorenzo.pieralisi@gmail.com>
Subject: Re: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Message-ID: <YsVpRgcsQokiu3W7@8bytes.org>
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
 <03b03d88-87cd-0b29-863b-2cb2a9a117d1@arm.com>
 <44338c87254d4d439d29694de8f19435@huawei.com>
 <ff579ecb-9a37-09ef-a975-cf1e25ab731e@arm.com>
 <26bbc80ddc7b4260b0d345913ed5ba1b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26bbc80ddc7b4260b0d345913ed5ba1b@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 28, 2022 at 07:59:39AM +0000, Shameerali Kolothum Thodi wrote:
> Now that we have all the required acks, could you please pick this series via
> IOMMU tree?

Applied to core branch, thanks.
