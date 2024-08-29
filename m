Return-Path: <linux-acpi+bounces-7967-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6287964AFE
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2283D1C21319
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ED81B374C;
	Thu, 29 Aug 2024 16:05:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517511B0127;
	Thu, 29 Aug 2024 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947550; cv=none; b=sCMliT7YzVL7I3xmYr3pxxjUPhpNVmHqXFXeN7hfHrtFvngxd+OCMjG/vUxUZ8zGFrcBnWgmeHNwZ1Iy+07qjpqt6GFi0FCTG5saCnBoe0BOda/Chs4xU5Q2ColqG3MnF4rmeVbcIsZ0QmchapzN82dxWQx5RFVZKjjg7eAwySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947550; c=relaxed/simple;
	bh=B9dP1Bq9TF006buCvjqp4O2Gkg2+YTOFpbLTmJYux2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJNI1tlwGiI63atLD/slGs5ZFQspmm9Wy+y5eLS8cT26M4tdA+YL3ZhBj9xZ/UDjqqg8S0AHCh7hkW/nVntI2aVhpJ2KGv/aPm2feoRd2BbyIDQNJBsdHOPd3noTkn6pizz+u6Cr9SO79+MgGqzDixGGQT7mFdl49g0vDDZu/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0A13DA7;
	Thu, 29 Aug 2024 09:06:13 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD9B23F762;
	Thu, 29 Aug 2024 09:05:46 -0700 (PDT)
Date: Thu, 29 Aug 2024 17:05:44 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: lpieralisi@kernel.org, guohanjun@huawei.com, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: arm64: Fix checkpatch warning - Alignment should
 match open parenthesis
Message-ID: <ZtCcWJc3wkiFheIN@bogus>
References: <20240828133205.17368-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828133205.17368-1-riyandhiman14@gmail.com>

On Wed, Aug 28, 2024 at 07:02:05PM +0530, Riyan Dhiman wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> - CHECK: Alignment should match open parenthesis
>

Changes looks good. But please drop "Fix checkpatch warning" in the subject.

You can have it as
"ACPI: arm64: Fix some parenthesis alignment coding style issues"


Also add a note in the commit log that this has no functional change. It
helps.

-- 
Regards,
Sudeep

