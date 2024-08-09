Return-Path: <linux-acpi+bounces-7465-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D907694D1A3
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 15:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4351F24B9F
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 13:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C7819580A;
	Fri,  9 Aug 2024 13:53:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C8B1E49B
	for <linux-acpi@vger.kernel.org>; Fri,  9 Aug 2024 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211637; cv=none; b=hQMqjInCYe8+BtPGMyrRv90OtA6O2WHwMaoKYTCBEbc9LtXUTrODA46sOxZmCDS1cwQO13Etqqn32qhQQiGnS1TGEL49jlVt/+1BZpDbdi0lfeR+BjW/6x29+JCvk1C62Uf981VWXYjR17ZsR+hUKe8Clcho85vZhr6HR/Xte5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211637; c=relaxed/simple;
	bh=Mvu11gfbK130YzAznijiBo58nForu8wKijjpyX/U2nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5t4uvoGWSBImh30eWQ4Q4b/0xZ+ay/Ncydnuw6gAiIa4JRtEjn3pVCaToAEw7XE178nW2y6QvoXYpeSTZPQ++msEvuX9zJZnu0f94tal1bhl9qMqIz0Xk4zbx3D1Aoti8yuwidkDHFpXIm80NreNhAaOjflJwJ4MlyB3vxuGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FE3413D5;
	Fri,  9 Aug 2024 06:54:20 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F3C33F71E;
	Fri,  9 Aug 2024 06:53:53 -0700 (PDT)
Date: Fri, 9 Aug 2024 14:53:51 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	<linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ACPI: ARM64: add acpi_iort.h to MAINTAINERS
Message-ID: <ZrYfb7rM0MLSNpJB@bogus>
References: <20240808130946.1028376-1-guohanjun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808130946.1028376-1-guohanjun@huawei.com>

On Thu, Aug 08, 2024 at 09:09:46PM +0800, Hanjun Guo wrote:
> IORT(Input Output Remapping Table) represents the I/O topology of an
> Arm-based system for use with the ACPI, so acpi_iort.h is for arm64
> only.
> 
> This helps git-send-email to figure out the proper maintainers when
> touching the file.
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

