Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22831C3845
	for <lists+linux-acpi@lfdr.de>; Mon,  4 May 2020 13:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgEDLfC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 May 2020 07:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbgEDLfC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 May 2020 07:35:02 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A5CE2073E;
        Mon,  4 May 2020 11:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588592101;
        bh=/Fy029ucC+efYPOQOL7ZVilAVIHcqwu2rtfv9GhVdkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMuPkCc6MzEKmvHq+p+BVwMm2CATSNoewN1AbHy6rV0if1yFVPJIAWRqQ6QQgZWoP
         oTGGBRPBsXNPbPG2QHNnRuwa2FFNiZk6L6VS/uTjsygmnpej4Zm3suY++qFnspqeui
         dzoq0B2wh4ItnG4aXLwzy8egjJ0m/bxhzzszGSqc=
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        linux-acpi@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v2 0/2] ACPI/IORT: rework num_ids off-by-one quirk
Date:   Mon,  4 May 2020 12:34:53 +0100
Message-Id: <158859046152.207472.4391733811307896496.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501161014.5935-1-ardb@kernel.org>
References: <20200501161014.5935-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 1 May 2020 18:10:12 +0200, Ard Biesheuvel wrote:
> Replace the ACPI OEM ID matching based IORT quirk for the ID region size
> ambiguity with runtime handling of this condition.
> 
> This is based on the observation that we only care about this when it
> causes ambiguity regarding the output reference, which means that we
> will have more than one match for the input ID. In this case, we can
> just disregard the one at the end of a multi-ID region: if we hit it
> first, we record it tentatively but allow a subsequent match to
> supersede it. If we hit the correct match first, there is nothing we
> need to do.
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/2] Revert "ACPI/IORT: Fix 'Number of IDs' handling in iort_id_map()"
      https://git.kernel.org/arm64/c/6d3b29d07c3c
[2/2] ACPI/IORT: work around num_ids ambiguity
      https://git.kernel.org/arm64/c/539979b6ec62

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
