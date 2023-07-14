Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3CF753D27
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jul 2023 16:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbjGNOV7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jul 2023 10:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjGNOV7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Jul 2023 10:21:59 -0400
X-Greylist: delayed 421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Jul 2023 07:21:57 PDT
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F29AF9B
        for <linux-acpi@vger.kernel.org>; Fri, 14 Jul 2023 07:21:57 -0700 (PDT)
Received: from 8bytes.org (p200300f6af03f600fd690381fa83412b.dip0.t-ipconnect.de [IPv6:2003:f6:af03:f600:fd69:381:fa83:412b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 4810D28012A;
        Fri, 14 Jul 2023 16:14:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1689344095;
        bh=F/D7IwlzeRTbVVFVQRrvrHtSo5B6tCQYfdQKsjjGZxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jp3PihVqiKnlzmHVqFa9YWANdQakKslbqTfMqagAPFsJZPLtl8G315CluEVsz1IKN
         ie9DKXxujsgeG6yc3N5EUKv4hmowrAcybCnSqVcPGXSf6f1UbKKapLpgV6UcIP/EqU
         bH2afUqVj//RSfYXnQtMLpFW4OB5YeQRWWq7qiSO3OcoxmqSWH5fplE2XuwD4JeqIq
         iSa9eGZFb+o6eR5kPvjU/SSOmAIQS5idSGf993PJZmeMdjPKUelStLuGttAQbN9hbD
         0PVZeMlsu2K0v7/3/kMWl1qvEE3THgi6VcQFrwqzRM1aN2IQKU5IOfu0oIVL54+UUZ
         wIto+NKQ9GfIA==
Date:   Fri, 14 Jul 2023 16:14:54 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 00/10] Consolidate the probe_device path
Message-ID: <ZLFYXlSBZrlxFpHM@8bytes.org>
References: <0-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
 <ZJCmmOfR7Cl+OtOc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJCmmOfR7Cl+OtOc@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 19, 2023 at 04:03:52PM -0300, Jason Gunthorpe wrote:
> Joerg? I think we are good on this one now, it has been quite for two weeks

Applied now, thanks Jason.
