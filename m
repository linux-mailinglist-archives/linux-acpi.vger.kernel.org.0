Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6F54CEAF4
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Mar 2022 12:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiCFLSN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Mar 2022 06:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCFLSM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Mar 2022 06:18:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD3B6BDDE
        for <linux-acpi@vger.kernel.org>; Sun,  6 Mar 2022 03:17:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 174E760AD8
        for <linux-acpi@vger.kernel.org>; Sun,  6 Mar 2022 11:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE03FC340EC;
        Sun,  6 Mar 2022 11:17:16 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH V2 0/2] ACPI: Add LoongArch-related definitions
Date:   Sun,  6 Mar 2022 19:18:36 +0800
Message-Id: <20220306111838.810959-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
boot protocol LoongArch-specific interrupt controllers (similar to APIC)
are already added in the next revision of ACPI Specification (current
revision is 6.4).

This patchset are preparing to add LoongArch support in mainline kernel,
we can see a snapshot here:
https://github.com/loongson/linux/tree/loongarch-next

Cross-compile tool chain to build kernel:
https://github.com/loongson/build-tools/releases

Loongson and LoongArch documentations:
https://github.com/loongson/LoongArch-Documentation

ECR for LoongArch-specific interrupt controllers:
https://mantis.uefi.org/mantis/view.php?id=2203
https://mantis.uefi.org/mantis/view.php?id=2313

ACPI changes of LoongArch have been approved in the last year, but the
new version of ACPI SPEC hasn't been made public yet.

V2: Remove merged patches and update commit messages.

Huacai Chen and Jianmin Lv(2):
 ACPICA: MADT: Add LoongArch APICs support.
 ACPICA: Events: Support fixed pcie wake event.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn> 
---
 drivers/acpi/acpica/evevent.c  |  17 ++++--
 drivers/acpi/acpica/hwsleep.c  |  12 ++++
 drivers/acpi/acpica/utglobal.c |   4 ++
 drivers/acpi/tables.c          |  10 ++++
 include/acpi/actbl2.h          | 125 ++++++++++++++++++++++++++++++++++++++++-
 include/acpi/actypes.h         |   3 +-
 6 files changed, 163 insertions(+), 8 deletions(-)
--
2.27.0

