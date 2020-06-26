Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B62020B577
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jun 2020 17:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgFZP6l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jun 2020 11:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgFZP6l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Jun 2020 11:58:41 -0400
Received: from dogfood.home (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33705204EC;
        Fri, 26 Jun 2020 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593187120;
        bh=FC+oTGAs23eBdDUGAh1t176WlXiIhxPuC7xFP7W52W0=;
        h=From:To:Cc:Subject:Date:From;
        b=jIT0I4Svp9S8w+HXR16FZk9s/faTxhTaNm36i51GkF7fn74oRQWEFERHLG8yNepyz
         FWwlJ7coS8W53XEtJadpUIiZJe8VYj+HKj8HEO68/ckE+ZhblwIiopUXdgKe+nT4+a
         Wal3iWhQeOKuIKWmkGDt0k71LhruutLjQpvn2CMI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, kernel-hardening@lists.openwall.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 0/2] arm64/acpi: restrict AML opregion memory access
Date:   Fri, 26 Jun 2020 17:58:30 +0200
Message-Id: <20200626155832.2323789-1-ardb@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

v2:
- do a more elaborate check on the region, against the EFI memory map

v3:
- split into two patches
- fallback to __ioremap() for ACPI reclaim memory, in case it is not covered
  by the linear mapping (e.g., when booting a kdump kernel)

Ard Biesheuvel (2):
  arm64/acpi: disallow AML memory opregions to access kernel memory
  arm64/acpi: disallow writeable AML opregion mapping for EFI code
    regions

 arch/arm64/include/asm/acpi.h | 15 +---
 arch/arm64/kernel/acpi.c      | 75 ++++++++++++++++++++
 2 files changed, 76 insertions(+), 14 deletions(-)

-- 
2.27.0

