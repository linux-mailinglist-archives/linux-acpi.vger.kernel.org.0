Return-Path: <linux-acpi+bounces-19661-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DE0CCB58B
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 11:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F3E3302AAB6
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 10:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DC9333445;
	Thu, 18 Dec 2025 10:22:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799102E6116;
	Thu, 18 Dec 2025 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766053369; cv=none; b=qc5HwlYfvVhFNlDVCt5T304q9kTjQ1THSyviDBTBCKr+XWDNwUy3IdamTlDNYVnUi987u7tXRfvOAtfN3NBk6e27zHPNIeefI1ECB4cMxcZWhdgtBybjmtMzBo7sQ7pWQ1kc6G1443iX/WpERHC9RjusKB+zOh5K7ZyoUy/0Dwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766053369; c=relaxed/simple;
	bh=mFHiw7KS45+Y5Ey+urMC6Lnv/CqjydjTc7etoHKEfKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0c1jnWOCtyspKH6MvtoeUzo+GuDOc06Cg5kFgQu7AcIwrPwI8nnBuvpmbn939cLJGkDWVbK/bZWIiiHs3QsQmaEknY1RtRw8EFSofBVRSTrqqiqyO7KTp57+abEOBnSCp1DC3vq/axw8ND6cABUjDBlqNyaLpY3silRQSU6rEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 963B7FEC;
	Thu, 18 Dec 2025 02:22:38 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6D4D3F73F;
	Thu, 18 Dec 2025 02:22:43 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
To: krzk@kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: tony.luck@intel.com,
	bp@alien8.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	linux-doc@vger.kernel.org,
	Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com,
	ahmed.tiba@arm.com
Subject: Re: [PATCH 10/12] dt-bindings: ras: document estatus provider
Date: Thu, 18 Dec 2025 10:22:36 +0000
Message-ID: <20251218102238.2235329-1-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2a2baef6-c294-4c31-bec2-10fbaa3f7941@kernel.org>
References: <2a2baef6-c294-4c31-bec2-10fbaa3f7941@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 18/12/2025 07:48, Krzysztof Kozlowski wrote:
> Please follow standard mailing list reply style. I am not reading the
> rest and I still expect to implement my feedback fully.

Apologies for the poor reply formatting.

I will resend my reply with proper inline formatting and full
context preserved, and follow up with a new revision implementing
your feedback.

Thanks.
Ahmed

