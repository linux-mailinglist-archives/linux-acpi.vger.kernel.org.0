Return-Path: <linux-acpi+bounces-6369-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF1A906947
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 11:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9C3286077
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D5314037D;
	Thu, 13 Jun 2024 09:50:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8313F449
	for <linux-acpi@vger.kernel.org>; Thu, 13 Jun 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272255; cv=none; b=Q7RDNOuzDrSvlOxtGlFfXkLAeRNcyytixcORsFb8PnYX/ZuWlcYP8YE6qnzk9RELAVzGSbrdMJtr/dHC4r2IywyRic5XztMiUG3ZXE+JBJl3BAAH/S9f7wuGkNXeEv4Ddo6KRBcml8dqD0tiYhl5lFXZcxPcaCs8FU+dismSXlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272255; c=relaxed/simple;
	bh=uyDZb1l+o1TG+KUAhe0HHapY65/ouA6eb9ynai8yiIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQ9bNS0bN9lJVSntP1Iq9/nWd1j875ihBfvUilznyvscDK2oNWYme1sS3eZxyt/wjuabEHzPpvDE65LWqwPjWQIC6BexQ0biMu7xs2WKrbMZsogs3y+tJCoH+gTv69M558swZFYdxtndnmZ5DD6SgFzfYdOZ1NQxsYwfwqb89so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B20CC2BBFC;
	Thu, 13 Jun 2024 09:50:53 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 0/3] ACPI: arm64: some cleanups
Date: Thu, 13 Jun 2024 10:50:51 +0100
Message-Id: <171827224634.46965.14222051392612660568.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240605131458.3341095-1-sudeep.holla@arm.com>
References: <20240605131458.3341095-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 05 Jun 2024 14:14:55 +0100, Sudeep Holla wrote:
> Couple of patches to move the ACPI arch specific code into
> drivers/acpi/arm64/ as they are not strictly arch specific to
> keep them under arch/arm64.
> 
> Regards,
> Sudeep
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/3] ACPI: arm64: Sort entries alphabetically
      https://git.kernel.org/arm64/c/f8c6c92790dd
[2/3] arm64: cpuidle: Move ACPI specific code into drivers/acpi/arm64/
      https://git.kernel.org/arm64/c/99e7a8adc0ca
[3/3] arm64: FFH: Move ACPI specific code into drivers/acpi/arm64/
      https://git.kernel.org/arm64/c/7a7a1cac3c2f

-- 
Catalin


