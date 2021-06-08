Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A47539F554
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 13:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhFHLom (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 07:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232156AbhFHLol (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Jun 2021 07:44:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31B7061354;
        Tue,  8 Jun 2021 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623152569;
        bh=k9u4oLtqZFZqMQL5RbX/43JiWGWq0vXU6dFMnuHjNoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h39WeBtDyBSnnyS/KwdvKIPeiku1C6zXw7LmVal2HB5v0KgjR7LYJPAto245v4w83
         W9mGsRstf8WFhBnWoV6kJ1quWeQX23mNBjCvqMG1Iofg5z8LVtIWPGTm688mbFQP+N
         uRoFyYS5dNBUzRhvhL380PCYnHLnwMMLFENGABvXecoxBPGP2UtukuNStVcek0oFvO
         DV9L5fgy93xFwlVCMAg/9KK/Y9XhNC1ydbAqA72XU3Tr+TCuX6LaDZbXF0pT/dCnJy
         JdTgS6+0RyWe4iTM+Ny6NzHac3JQo3qP54Ur3WTWo8O0MKuytlKVim4DWt4aB7cfKf
         oh4CYOEKQogMg==
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, robh+dt@kernel.org,
        linux-acpi@vger.kernel.org, sudeep.holla@arm.com,
        robin.murphy@arm.com, guohanjun@huawei.com,
        devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
        zhangfei.gao@linaro.org, wangzhou1@hisilicon.com,
        Jonathan.Cameron@huawei.com, lorenzo.pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com,
        rjw@rjwysocki.net, lenb@kernel.org
Subject: Re: [PATCH v15 0/3] iommu/arm-smmu-v3: Add stall support
Date:   Tue,  8 Jun 2021 12:42:34 +0100
Message-Id: <162314710744.3707892.6632600736379822229.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210526161927.24268-1-jean-philippe@linaro.org>
References: <20210526161927.24268-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 26 May 2021 18:19:25 +0200, Jean-Philippe Brucker wrote:
> Add stall support for SMMUv3, enabling I/O page faults and SVA for
> compatible devices. No change since last version [1], but I'd still like
> this to be considered for upstream, because there exists hardware and
> applications.
> 
> Stall is implemented by the Kunpeng 920 processor for its compression
> and crypto accelerators, with which I tested the SVA infrastructure.
> Using the userspace accelerator API [2], a program can obtain a queue
> from one of these devices and submit compression or encryption work
> within the program's address space. UADK [3] provides a library to do
> this, and there is an openssl plugin [4] to use it.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/3] dt-bindings: document stall property for IOMMU masters
      https://git.kernel.org/will/c/ed1d08b9d0c9
[2/3] ACPI/IORT: Enable stall support for platform devices
      https://git.kernel.org/will/c/6522b1e0c78f
[3/3] iommu/arm-smmu-v3: Add stall support for platform devices
      https://git.kernel.org/will/c/395ad89d11fd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
