Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C8D305CA0
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 14:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbhA0NMM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 08:12:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238271AbhA0NKU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Jan 2021 08:10:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EA55207A2;
        Wed, 27 Jan 2021 13:09:38 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     lorenzo.pieralisi@arm.com, Moritz Fischer <mdf@kernel.org>
Cc:     Will Deacon <will@kernel.org>, guohanjun@huawei.com,
        sudeep.holla@arm.com, linux-acpi@vger.kernel.org,
        moritzf@google.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net
Subject: Re: [PATCH v2] ACPI/IORT: Do not blindly trust DMA masks from firmware
Date:   Wed, 27 Jan 2021 13:09:36 +0000
Message-Id: <161175296410.16506.7622624950228429208.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210122012419.95010-1-mdf@kernel.org>
References: <20210122012419.95010-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 21 Jan 2021 17:24:19 -0800, Moritz Fischer wrote:
> Address issue observed on real world system with suboptimal IORT table
> where DMA masks of PCI devices would get set to 0 as result.
> 
> iort_dma_setup() would query the root complex'/named component IORT
> entry for a DMA mask, and use that over the one the device has been
> configured with earlier.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] ACPI/IORT: Do not blindly trust DMA masks from firmware
      https://git.kernel.org/arm64/c/a1df829ead58

-- 
Catalin

