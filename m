Return-Path: <linux-acpi+bounces-427-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27617B8A4B
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 20:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8D0722816BB
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E181BDEC
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMIgUHUK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC561BDC1
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 16:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E14C433C7;
	Wed,  4 Oct 2023 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696438162;
	bh=Pl/CyWpmpy67oQBOmr7t29W7B7Izi7OrIHxghbevJRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cMIgUHUKAG/BKID844uIM19QNSFWgjecnw37K3KYEWUhfHIATrrS4AKHU2uCG4yAB
	 lGlikiB+BbezByQJbPoJqpDYaadKfan/yQPB6hecDK3UwTByjGQn1gRr7jhW7nIRnj
	 th44BQAaKPj2shPBdX/UWckF7VzZLCb1aHGR1vAj7rJG+Vu2dg+vkSJtr1k3ztnCmV
	 gTk/KcNEaIr3PM2WgV0yNR7mNk0vjfHTE/fqPfzLEU1HQhk7L7k69WoADgtjpCGo5t
	 v4Y9NQs74thC5IirzuQ5Xaf1KWS6VD/Tbk7HRonfKncJxC+E4PfqkyN8pjaCvScsaE
	 aumGo5Q58dFrg==
From: Will Deacon <will@kernel.org>
To: lenb@kernel.org,
	catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	sudeep.holla@arm.com,
	Oza Pawandeep <quic_poza@quicinc.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v10] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer
Date: Wed,  4 Oct 2023 17:49:15 +0100
Message-Id: <169643348853.2504487.15808600653362880318.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231003173333.2865323-1-quic_poza@quicinc.com>
References: <20231003173333.2865323-1-quic_poza@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 3 Oct 2023 10:33:33 -0700, Oza Pawandeep wrote:
> Arm® Functional Fixed Hardware Specification defines LPI states,
> which provide an architectural context loss flags field that can
> be used to describe the context that might be lost when an LPI
> state is entered.
> 
> - Core context Lost
>         - General purpose registers.
>         - Floating point and SIMD registers.
>         - System registers, include the System register based
>         - generic timer for the core.
>         - Debug register in the core power domain.
>         - PMU registers in the core power domain.
>         - Trace register in the core power domain.
> - Trace context loss
> - GICR
> - GICD
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer
      https://git.kernel.org/arm64/c/4785aa802853

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

