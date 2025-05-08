Return-Path: <linux-acpi+bounces-13640-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E13AAFACA
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 15:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E9E1B61C41
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50887221D90;
	Thu,  8 May 2025 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM5RJCob"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2620A17BA5;
	Thu,  8 May 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746709365; cv=none; b=XnBWVFpnSEt+8Ii5rxriGwNui9CuyLGDIkVLBBQNTfOWbqmhDuIL2bSPaAHdmYAW3LJJFUmLkvgA7j9m5T2CPBATkUOxrWhnfHyIVpEFs+tNUDBGSXGqwJbDz9t+TXev6IkfKp/Vys2Z6x9nHtFdlq1XCrANo6OnP3zfXrTKLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746709365; c=relaxed/simple;
	bh=3jYIMlTRS21sFwI2KZR6aQTeSVvwhaMYQmdsc+lOmvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlWt4YHFMVzs0qIDCMLRtlvfRjZ9y8s+tq6bzNpmvpFJ7kZrfzma6r0GbFWcy+5RrYQHokTDl+mvjIwcJCiKHCjR8qs4nbA4OKColadBIQOCX6wseUHOni64SsSCUZHvEe2SBvWameOp5Va9YuL2E7Mm59X4cbZ0H1DlTIU0org=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM5RJCob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62ACC4CEE7;
	Thu,  8 May 2025 13:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746709363;
	bh=3jYIMlTRS21sFwI2KZR6aQTeSVvwhaMYQmdsc+lOmvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fM5RJCob3QZpPVDNWRh3u4IuG2knKHM3A8fO8bPRFDTlh3az/dDQD2aI3vOGaUdia
	 Ip+iLBgIGRCjelyn8/K26PX0UM3lj/iFzroldvYZZMWion6/MXLbGloz7jHruC55an
	 sQTU+U370CFcNKlFw9oKn1w8LnjFUcy2ooZdS7ZLz4sBVVwYE0hHswe6GFPc80Ho4m
	 p5+VxmvnWWkARwOd4HlLNC1Ry9mw/fWtAnzfEblnttFWkrEmTnGeRZaXApCmwVsb39
	 W9MNxPwNkA0PYdPpeBPMuhuMvrrQaCb27z5KYsqdmMNG0ILcXgr4BX9LxGipv6HzTa
	 nf+nIlTNomZTg==
From: Will Deacon <will@kernel.org>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	Huang Yiwei <quic_hyiwei@quicinc.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	xueshuai@linux.alibaba.com,
	quic_aiquny@quicinc.com,
	quic_satyap@quicinc.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	kernel@oss.qualcomm.com
Subject: Re: [PATCH v2] firmware: SDEI: Allow sdei initialization without ACPI_APEI_GHES
Date: Thu,  8 May 2025 14:02:35 +0100
Message-Id: <174670772284.646111.7927928404698891686.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250507045757.2658795-1-quic_hyiwei@quicinc.com>
References: <20250507045757.2658795-1-quic_hyiwei@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 07 May 2025 12:57:57 +0800, Huang Yiwei wrote:
> SDEI usually initialize with the ACPI table, but on platforms where
> ACPI is not used, the SDEI feature can still be used to handle
> specific firmware calls or other customized purposes. Therefore, it
> is not necessary for ARM_SDE_INTERFACE to depend on ACPI_APEI_GHES.
> 
> In commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES
> in acpi_init()"), to make APEI ready earlier, sdei_init was moved
> into acpi_ghes_init instead of being a standalone initcall, adding
> ACPI_APEI_GHES dependency to ARM_SDE_INTERFACE. This restricts the
> flexibility and usability of SDEI.
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/1] firmware: SDEI: Allow sdei initialization without ACPI_APEI_GHES
      https://git.kernel.org/arm64/c/59529bbe642d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

