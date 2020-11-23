Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536AA2C0487
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 12:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgKWL1W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 06:27:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728484AbgKWL1V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Nov 2020 06:27:21 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D012078E;
        Mon, 23 Nov 2020 11:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606130841;
        bh=w8D5WuRGeKsn20e9+N0yoXTe3Uv21sYC88zTYSMZ8jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aZNx3CR9wxSBeRhk7ZzurPlnxqmqmVG06HsMMBxIymWOLBFHgTJxBuNUEojnqzGVm
         GeUR2zVCNQs6e5SELHgsmjwA7tx9TxlRxf9ZS64q6zY47KanRF+Ed/9F8BmEtNYHNl
         4pBqv95eM4mTtGY4U9WdFve2wjHEtoSKaxG8qFkc=
From:   Will Deacon <will@kernel.org>
To:     sudeep.holla@arm.com, lenb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        Shiju Jose <shiju.jose@huawei.com>, guohanjun@huawei.com,
        rjw@rjwysocki.net, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com
Subject: Re: [PATCH 1/1] ACPI/IORT: Fix doc warnings in iort.c
Date:   Mon, 23 Nov 2020 11:27:13 +0000
Message-Id: <160612929299.1150715.7602721922330758650.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014093139.1580-1-shiju.jose@huawei.com>
References: <20201014093139.1580-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 14 Oct 2020 10:31:39 +0100, Shiju Jose wrote:
> Fix following warnings caused by mismatch between
> function parameters and function comments.
> 
> drivers/acpi/arm64/iort.c:55: warning: Function parameter or member 'iort_node' not described in 'iort_set_fwnode'
> drivers/acpi/arm64/iort.c:55: warning: Excess function parameter 'node' description in 'iort_set_fwnode'
> drivers/acpi/arm64/iort.c:682: warning: Function parameter or member 'id' not described in 'iort_get_device_domain'
> drivers/acpi/arm64/iort.c:682: warning: Function parameter or member 'bus_token' not described in 'iort_get_device_domain'
> drivers/acpi/arm64/iort.c:682: warning: Excess function parameter 'req_id' description in 'iort_get_device_domain'
> drivers/acpi/arm64/iort.c:1142: warning: Function parameter or member 'dma_size' not described in 'iort_dma_setup'
> drivers/acpi/arm64/iort.c:1142: warning: Excess function parameter 'size' description in 'iort_dma_setup'
> drivers/acpi/arm64/iort.c:1534: warning: Function parameter or member 'ops' not described in 'iort_add_platform_device'

Applied to arm64 (for-next/fixes), thanks!

[1/1] ACPI/IORT: Fix doc warnings in iort.c
      https://git.kernel.org/arm64/c/774c4a3b5e5f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
