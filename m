Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89E725FE14
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 18:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgIGQGM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 12:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730308AbgIGQGE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 12:06:04 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C379E2080A;
        Mon,  7 Sep 2020 16:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599494763;
        bh=YlOm7PO2xV5e/CZRpqTxMonNUO2cZ/+UjCy+doAEfAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xnbj6ZRhSgaPvGGBub3MrAyWTkZiPioVzI7sXjMEgkC+mgkV+C3dOytGiNhVEAO88
         bi2AtxyVF2IW5r1V6GemH4n9KKxZEvkD1ifmxK2VlYG1emVseqakSUNJifyvsjiY15
         7CU2ai/k6vBDXrw9BSYLs0zb9uMwkJRYq+tNmChw=
From:   Will Deacon <will@kernel.org>
To:     lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        Zenghui Yu <yuzenghui@huawei.com>, guohanjun@huawei.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, wanghaibin.wang@huawei.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ACPI/IORT: Code cleanups
Date:   Mon,  7 Sep 2020 17:05:39 +0100
Message-Id: <159948518636.584310.6195489797624791903.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818063625.980-1-yuzenghui@huawei.com>
References: <20200818063625.980-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 18 Aug 2020 14:36:23 +0800, Zenghui Yu wrote:
> * From v1 [1]:
>   - As pointed out by Hanjun, remove two now unused inline functions.
>     Compile tested with CONFIG_IOMMU_API is not selected.
> 
> [1] https://lore.kernel.org/r/20200817105946.1511-1-yuzenghui@huawei.com
> 
> Zenghui Yu (2):
>   ACPI/IORT: Drop the unused @ops of iort_add_device_replay()
>   ACPI/IORT: Remove the unused inline functions
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/2] ACPI/IORT: Drop the unused @ops of iort_add_device_replay()
      https://git.kernel.org/arm64/c/1ab64cf81489
[2/2] ACPI/IORT: Remove the unused inline functions
      https://git.kernel.org/arm64/c/c2bea7a1a1c0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
