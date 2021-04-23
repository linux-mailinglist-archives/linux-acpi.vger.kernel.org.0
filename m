Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE329369801
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 19:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhDWRLv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 13:11:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWRLu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Apr 2021 13:11:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 832166113B;
        Fri, 23 Apr 2021 17:11:11 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, kernel-team@android.com,
        Fu Wei <wefu@redhat.com>,
        dann frazier <dann.frazier@canonical.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64: ACPI GTDT watchdog fixes
Date:   Fri, 23 Apr 2021 18:11:07 +0100
Message-Id: <161919777114.6013.5171405926781894062.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210421164317.1718831-1-maz@kernel.org>
References: <20210421164317.1718831-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 21 Apr 2021 17:43:15 +0100, Marc Zyngier wrote:
> Dann recently reported that his ThunderX machine failed to boot since
> 64b499d8df40 ("irqchip/gic-v3: Configure SGIs as standard
> interrupts"), with a not so pretty crash while trying to send an IPI.
> 
> It turned out to be caused by a mix of broken firmware and a buggy
> GTDT watchdog driver. Both have forever been buggy, but the above
> commit revealed that the error handling path of the driver was
> probably the worse part of it all.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/2] ACPI: GTDT: Don't corrupt interrupt mappings on watchdow probe failure
      https://git.kernel.org/arm64/c/1ecd5b129252
[2/2] ACPI: irq: Prevent unregistering of GIC SGIs
      https://git.kernel.org/arm64/c/2a20b08f06e7

-- 
Catalin

