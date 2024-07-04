Return-Path: <linux-acpi+bounces-6768-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654A3927826
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 16:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3401C225F3
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A242D1B1426;
	Thu,  4 Jul 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9KKVb4z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727AA1B121F;
	Thu,  4 Jul 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102766; cv=none; b=nqR4RKz75iDRwUHNqgpCunNaWK9A8sztO4s+F2hlsbXWkuK+dobj3xTpOr/9GvA9lgO9/tr/Maztw87psmF1zbJdZa0f6xnrTWCqWBVqH+QVQZEEFFftk8jGSSP++WkSvLu3Hv69W4k3AfPO6fDna/WnVw4J5BxqW8ulI4Sg0Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102766; c=relaxed/simple;
	bh=rhtBhS/CBJwV8ITSg9IDBvbJbDtnj2UkM1J450xWCtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2fklJapiKaU6Ibw9psOBetkRUYEhXHofWjsPYWqQvK82wUyMbQ5h+TwH0ai2v4uTNiwMoQySiWRaT2RAJQovY3TL93VF3WOpOeUDSRN8ilfFniKNuQFGBrGGTsQlddK+9yKRa9c0bWjkUnYjINHanZ7/lJbQ83unI0f5iUPICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9KKVb4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70D0C4AF0D;
	Thu,  4 Jul 2024 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720102766;
	bh=rhtBhS/CBJwV8ITSg9IDBvbJbDtnj2UkM1J450xWCtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S9KKVb4zR4ws4a4Ey1hdFcsOGe8qLy0xkejIdZvgG7OAEoXgzdWX6TM+hXVjmmTN1
	 fsL4p1AEIEFJLKQckvIuKUih+RFCofhKka9wfVtybFfnFskAC7rJbXF/+2fRY+wh0t
	 UWSWBycthso418WA90A344JZ5WEQzTuWVSka4VsRTtG6E6cvzCUnRZNUCFx7wDHEKN
	 mEasV/UwQMeWeEmPZAQ1FA+CNd+DmU7r3dZtXmrGxMpsNZF5myzfp8NLTcuOwQ09zM
	 nG5b03J68sPWoEpUeNgPn3T3Eq9wPeyw2jVQebxT1yp5pxa6Th0aPjCLRdRf7bSq2f
	 obUBrjWV6kAfg==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v3 0/5] iommu: Remove iommu_fwspec ops
Date: Thu,  4 Jul 2024 15:19:01 +0100
Message-Id: <172010016495.204079.11503801872554345950.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1719919669.git.robin.murphy@arm.com>
References: <cover.1719919669.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 02 Jul 2024 12:40:46 +0100, Robin Murphy wrote:
> v2: https://lore.kernel.org/linux-iommu/cover.1718994350.git.robin.murphy@arm.com/
> 
> Hi all,
> 
> Just a quick update with an extra patch to avoid the mediatek-v1 driver
> breaking (and I have now build-tested ARCH=arm to make sure, apologies
> for being lazy before...)
> 
> [...]

Applied to arm64 (fwspec-ops-removal), thanks!

[1/5] iommu/mediatek-v1: Clean up redundant fwspec checks
      https://git.kernel.org/iommu/c/e7acc36f26b0
[2/5] iommu: Resolve fwspec ops automatically
      https://git.kernel.org/iommu/c/3f7c32091628
[3/5] ACPI: Retire acpi_iommu_fwspec_ops()
      https://git.kernel.org/iommu/c/78596b5c321c
[4/5] OF: Simplify of_iommu_configure()
      https://git.kernel.org/iommu/c/5f937bc48a6a
[5/5] iommu: Remove iommu_fwspec ops
      https://git.kernel.org/iommu/c/3e36c15fc1cc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

