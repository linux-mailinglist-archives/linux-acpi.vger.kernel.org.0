Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A420E21FDDF
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jul 2020 21:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgGNTwo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Jul 2020 15:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbgGNTwo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Jul 2020 15:52:44 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C582622B51;
        Tue, 14 Jul 2020 19:52:42 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, sudeep.holla@arm.com,
        kernel-hardening@lists.openwall.com, linux-acpi@vger.kernel.org,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/2] arm64/acpi: restrict AML opregion memory access
Date:   Tue, 14 Jul 2020 20:52:41 +0100
Message-Id: <159475635407.4337.14038873676675267041.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626155832.2323789-1-ardb@kernel.org>
References: <20200626155832.2323789-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 26 Jun 2020 17:58:30 +0200, Ard Biesheuvel wrote:
> v2:
> - do a more elaborate check on the region, against the EFI memory map
> 
> v3:
> - split into two patches
> - fallback to __ioremap() for ACPI reclaim memory, in case it is not covered
>   by the linear mapping (e.g., when booting a kdump kernel)
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/2] arm64/acpi: disallow AML memory opregions to access kernel memory
      https://git.kernel.org/arm64/c/1583052d111f
[2/2] arm64/acpi: disallow writeable AML opregion mapping for EFI code regions
      https://git.kernel.org/arm64/c/325f5585ec36

-- 
Catalin

