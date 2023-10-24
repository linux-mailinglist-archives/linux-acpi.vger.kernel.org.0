Return-Path: <linux-acpi+bounces-934-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6047D5903
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFCE1C20444
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBA33B2A8
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA823A28B
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 16:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A3CC433CA;
	Tue, 24 Oct 2023 16:30:32 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into a helper
Date: Tue, 24 Oct 2023 17:30:30 +0100
Message-Id: <169816491207.2944710.7569772359224217053.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <E1quv5D-00AeNJ-U8@rmk-PC.armlinux.org.uk>
References: <E1quv5D-00AeNJ-U8@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 23 Oct 2023 14:35:03 +0100, Russell King wrote:
> ACPI, irqchip and the architecture code all inspect the MADT
> enabled bit for a GICC entry in the MADT.
> 
> The addition of an 'online capable' bit means all these sites need
> updating.
> 
> Move the current checks behind a helper to make future updates easier.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into a helper
      https://git.kernel.org/arm64/c/c54e52f84d7a

-- 
Catalin


