Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC051C108E
	for <lists+linux-acpi@lfdr.de>; Fri,  1 May 2020 11:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgEAJ65 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 May 2020 05:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbgEAJ65 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 May 2020 05:58:57 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 679D92166E;
        Fri,  1 May 2020 09:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588327137;
        bh=aFo1Y0DYbsYo3jYYrmHZ2Qv7b19V9eJuOxE+i6hPCD4=;
        h=From:To:Cc:Subject:Date:From;
        b=qyhREBc/MbW7sftq4eFaMnKGNk1n7RdIPIrgfRGJN32n9CERZiyG0O/G5O+vYa77C
         ZhMrvEpNRRiAX2YEoGJwb7SEY91LKL5UGGSAhdIPFM5FXBQbI2vmfntKr53w9mc8sk
         Fgc2BT57h/hCTcf9qHaYr5o4DguLh505gnsU2XTM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH RFC 0/2] ACPI/IORT: rework num_ids off-by-one quirk
Date:   Fri,  1 May 2020 11:58:41 +0200
Message-Id: <20200501095843.25401-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Replace the ACPI OEM ID matching based IORT quirk for the ID region size
ambiguity with runtime handling of this condition.

This is based on the observation that we only care about this when it
causes ambiguity regarding the output reference, which means that we
will have more than one match for the input ID. In this case, we can
just disregard the one at the end of a multi-ID region: if we hit it
first, we record it tentatively but allow a subsequent match to
supersede it. If we hit the correct match first, there is nothing we
need to do.

Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Pankaj Bansal <pankaj.bansal@nxp.com>
Cc: Will Deacon <will@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>

Ard Biesheuvel (2):
  Revert "ACPI/IORT: Fix 'Number of IDs' handling in iort_id_map()"
  ACPI/IORT: work around num_ids ambiguity

 drivers/acpi/arm64/iort.c | 78 +++++---------------
 1 file changed, 19 insertions(+), 59 deletions(-)

-- 
2.17.1

