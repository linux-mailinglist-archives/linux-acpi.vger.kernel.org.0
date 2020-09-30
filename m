Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3CF27F436
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Sep 2020 23:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgI3V3U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Sep 2020 17:29:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgI3V3U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Sep 2020 17:29:20 -0400
Received: from localhost.localdomain (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 308552072E;
        Wed, 30 Sep 2020 21:29:17 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        Jonathan.Cameron@huawei.com, linux-acpi@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] arm64: permit ACPI core to map kernel memory used for table overrides
Date:   Wed, 30 Sep 2020 22:29:16 +0100
Message-Id: <160150134422.10710.17141741550968278682.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200929132522.18067-1-ardb@kernel.org>
References: <20200929132522.18067-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 29 Sep 2020 15:25:22 +0200, Ard Biesheuvel wrote:
> Jonathan reports that the strict policy for memory mapped by the
> ACPI core breaks the use case of passing ACPI table overrides via
> initramfs. This is due to the fact that the memory type used for
> loading the initramfs in memory is not recognized as a memory type
> that is typically used by firmware to pass firmware tables.
> 
> Since the purpose of the strict policy is to ensure that no AML or
> other ACPI code can manipulate any memory that is used by the kernel
> to keep its internal state or the state of user tasks, we can relax
> the permission check, and allow mappings of memory that is reserved
> and marked as NOMAP via memblock, and therefore not covered by the
> linear mapping to begin with.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: permit ACPI core to map kernel memory used for table overrides
      https://git.kernel.org/arm64/c/a509a66a9d0d

-- 
Catalin

