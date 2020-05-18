Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9778D1D8B5E
	for <lists+linux-acpi@lfdr.de>; Tue, 19 May 2020 01:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgERXEX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 May 2020 19:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgERXEW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 May 2020 19:04:22 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99AD520849;
        Mon, 18 May 2020 23:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589843062;
        bh=GfUiNBtiusxD7tUiINLEXRG4SGNIJl7n+58QUt6qvZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcpr6uvJ6iosc/Fx8JK5jSmyYYGSfn4dU9VGX/qMwOIsRA0LF2HSNtFOSIFc0isnN
         Ny3QrRBf1uYVcHO38u4ujfkk5KuT1G72w7QuzKE1/igZ440cMRZTMVox05uY1Qk1ED
         Lz3onPGS7fC7qoyDl+sBdGolBjGUK1DXHw4pWR8w=
From:   Will Deacon <will@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ACPI: GTDT: Put GTDT table after parsing
Date:   Tue, 19 May 2020 00:04:05 +0100
Message-Id: <158982168456.1117.3371494781648874842.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1588910753-18543-1-git-send-email-guohanjun@huawei.com>
References: <1588910753-18543-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 8 May 2020 12:05:52 +0800, Hanjun Guo wrote:
> The mapped GTDT table needs to be released after
> the driver init.

Applied to arm64 (for-next/acpi), thanks!

[1/2] ACPI: GTDT: Put GTDT table after parsing
      https://git.kernel.org/arm64/c/5ec605108ff4
[2/2] ACPI: IORT: Add comments for not calling acpi_put_table()
      https://git.kernel.org/arm64/c/701dafe0670c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
