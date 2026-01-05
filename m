Return-Path: <linux-acpi+bounces-19969-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2EBCF5EA4
	for <lists+linux-acpi@lfdr.de>; Mon, 05 Jan 2026 23:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E34AA3034414
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 22:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB44311597;
	Mon,  5 Jan 2026 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXNSeifY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650F93101D0;
	Mon,  5 Jan 2026 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653926; cv=none; b=VeKTWnfkn5OIKidIg/wT1zI91z6P4xjvIgwKCym78Ytwbpfs2oBOu3bNgQXL5KsPaqeIabBIxMDPnwvyiTgOM065+qbUEhVH2C12AMFug7XHoPo4XEluNj18wqB3V6pKohc2q5P0yJYZ0j8OjQcnCJz6EfGaFtd2itcSKL5JTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653926; c=relaxed/simple;
	bh=I75yBkyRZFLocoE/u51IEgfXbNSVrc/zHh5vjuWZwpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlytVfsFv/5WDYYIz+yhOjWI2vF7H9CnXZNO5NTs7CMDKF9JZWiERnxME+smpg9oxl3W3XB16mTw951VXNpWXzQnV+Al1FDg5taMnybCDbzTDoMmwGX0vJCXnEE950t6KjJk1mVNcJheoP6W6Jg6lYNNTV8A++PygQS2jdG4chE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXNSeifY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E59C116D0;
	Mon,  5 Jan 2026 22:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767653926;
	bh=I75yBkyRZFLocoE/u51IEgfXbNSVrc/zHh5vjuWZwpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXNSeifYz813CLe1GeFmNGfCX5t2eaQzTkz6RS98k6tl9CDHvlO2Kd895HobyzOPe
	 WPH7JbkyXXegYe+MVkR7mP5cQSv7mKhk4bevY+Muqlri+3CsBbhJ9nYzbYcxbPlTkl
	 XZrT0OSVxu+lZWxT23pTWFpgNypGvHwo0DAWQXea07iS+PF+l+9dW9T4iv+dVStueB
	 ttCrj2jUVDXya9plVK59DoBFiifUtleG5JUSidjrfHDM78l77cQRSaZaIOqA0Jv/O8
	 CE95OcsiFyL908v1PF2rL8jDqa+vqIh5QEQvFuNc/GrK5cdJUwNxnEoDTG/8+bbfhm
	 GoQMFp9mUpvxw==
From: Will Deacon <will@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Koichi Okuno <fj2767dz@aa.jp.fujitsu.com>,
	Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5] ACPI: AGDI: Add interrupt signaling mode support
Date: Mon,  5 Jan 2026 22:58:21 +0000
Message-ID: <176764598538.1443384.12447831892240359560.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251222065359.27330-1-fj1078ii@aa.jp.fujitsu.com>
References: <20251222065359.27330-1-fj1078ii@aa.jp.fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 22 Dec 2025 15:53:34 +0900, Kazuhiro Abe wrote:
> AGDI has two types of signaling modes: SDEI and interrupt.
> Currently, the AGDI driver only supports SDEI.
> Therefore, add support for interrupt signaling mode.
> The interrupt vector is retrieved from the AGDI table, and call panic
> function when an interrupt occurs.
> 
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI: AGDI: Add interrupt signaling mode support
      https://git.kernel.org/arm64/c/9296d4fd190f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

