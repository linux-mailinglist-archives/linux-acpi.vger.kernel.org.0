Return-Path: <linux-acpi+bounces-19718-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F941CD07F4
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 16:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5271A30EE136
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 15:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4201346FD0;
	Fri, 19 Dec 2025 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsTj1KhI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0278346FB7
	for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2025 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157375; cv=none; b=KivJKuNcN0oO5CzvIr+9EUaAsD6BPfmwW7JknuuUAPR8Fcm84W8lzIl1iEbq3Vks2hL/qQDMrJ283jC2mtFD4xh80JWGsEqQzK3wMoksyAaIzk5njDsJvye0C6sv5A8gqYZOMsJVIU87ocKcXmVRDSCY7MBddS26fagBckxMcJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157375; c=relaxed/simple;
	bh=rhfr+aR4wS/WaDXIAWbTZY95OZBHvwruftMFhRoSxAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDFBUuY0jnUcVzAzJaDxrg4pki6U2S7dydjq0Z7n+LjU4Fuy0cImCFdwpB+6C/7Z9oCg8cKDMGy57ABl2kGewqaJC8TfF7DypfB5qsTHedhP+7AAaHaeyBgvG2hBj3nkzxQ/axC1NeY/q7wJo8TAlx+Wusol5gaBASD2nILZENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsTj1KhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7CEC4CEF1;
	Fri, 19 Dec 2025 15:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766157375;
	bh=rhfr+aR4wS/WaDXIAWbTZY95OZBHvwruftMFhRoSxAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nsTj1KhISuVDW1SRlUkMcxfguARMuOiLCHlnHKCiGN0LBPMzw7QMzh6kzq8LuNfLO
	 QEH/OCcFuYhMU4ujFOnUhEtpYmxjd8w7YREZ3HgOoAgZeMqMQ8UaNvF5gTlptc1A0S
	 qNNZcO0KnziSDSOiWqXsQzDUoxTlfQcIJxXNJ5HVz8K4HzKg0ZwPpV5EFUgifviYbw
	 UI2S6PBBCvafroL5lCiMVG6nQ5L+pV7b2cmOqy1kAkhqwPu5/fLBf+ytNP6mr8mx/b
	 oiQqtpeL0Uk5Hq2v6m4IfdLq0NlkOvhYJFoy8+Ib6cE4fpsKIFbZkBpZ8F7gYB6a1h
	 Bax1/cTpB95GQ==
Date: Fri, 19 Dec 2025 16:16:09 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Update the maintainers for ARM64 ACPI
Message-ID: <aUVsOXF75Sb7wL7n@lpieralisi>
References: <20251219144906.348353-1-guohanjun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219144906.348353-1-guohanjun@huawei.com>

On Fri, Dec 19, 2025 at 10:49:06PM +0800, Hanjun Guo wrote:
> ARM64 ACPI patches go via ARM64 tree, but the listed maintainers
> for ARM64 ACPI don't include Catalin and Will, and there is no
> F: line under the ARM64 architecture entry, so emails will not
> route to Catalin and Will in an automatic way.
> 
> Adding Catalin and Will to the maintainers entry for ARM64 ACPI
> to fix the problem, it will make life easy for merging ARM64 ACPI
> patches.
> 
> Adding new maintainer entries for ARM64 ACPI doesn't mean the review
> work will balance to the new maintainer, patches still need to be
> acked by currently listed folks (Lorenzo, Hanjun, Sudeep) before
> merging them.
> 
> Link: https://lore.kernel.org/linux-acpi/aS2ZTfS9YVO98Exe@willie-the-truck/
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9d..6050d94a50ec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -335,6 +335,8 @@ ACPI FOR ARM64 (ACPI/arm64)
>  M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>  M:	Hanjun Guo <guohanjun@huawei.com>
>  M:	Sudeep Holla <sudeep.holla@arm.com>
> +M:	Catalin Marinas <catalin.marinas@arm.com>
> +M:	Will Deacon <will@kernel.org>

:)

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

>  L:	linux-acpi@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> -- 
> 2.25.1
> 

