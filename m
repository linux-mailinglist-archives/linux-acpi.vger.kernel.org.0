Return-Path: <linux-acpi+bounces-6308-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605E69041FF
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 18:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814BB1C220F7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 16:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A83A154C03;
	Tue, 11 Jun 2024 16:54:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727C6F31E
	for <linux-acpi@vger.kernel.org>; Tue, 11 Jun 2024 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124856; cv=none; b=cgSfNYg1d7gj1YGHg+WwGqajHUrjPzTTXQd/goYa7NbNcP6bLAOk6grslPwJm3a9V4hgoANvEW4L084aAgyJ2rTWaEBSRrqc9Opf21vNbvqb0ScW5lY8Hre8quS9dOdyiz7eLG8+RC50Ec3eClBu+suByy53pdH3D4ChhM6s5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124856; c=relaxed/simple;
	bh=XkyRTDW+FeGC9DHPe07AtvQGrzhnBWtybCa0+VOeiwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQqoetI9UYVvcoQ48xuXKPvKjQbmgkS4ubre0eBhvAOasAIF8rKrl07o3zeK4phQuwkwaJ6ZBYtdJ47zalQI3yNf2NoVY7amXpGXnJOc0z66vdkzOcDm0bw9FL6znFRTUv+ueyowKILSYbC+Wxjen0FWeli5m3C0eeM2AWEo1ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A57C2BD10;
	Tue, 11 Jun 2024 16:54:15 +0000 (UTC)
Date: Tue, 11 Jun 2024 17:54:13 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 2/3] arm64: cpuidle: Move ACPI specific code into
 drivers/acpi/arm64/
Message-ID: <ZmiBNbSXu4B0czYs@arm.com>
References: <20240605131458.3341095-1-sudeep.holla@arm.com>
 <20240605131458.3341095-3-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605131458.3341095-3-sudeep.holla@arm.com>

On Wed, Jun 05, 2024 at 02:14:57PM +0100, Sudeep Holla wrote:
> The ACPI cpuidle LPI FFH code can be moved out of arm64 arch code as
> it just uses SMCCC. Move all the ACPI cpuidle LPI FFH code into
> drivers/acpi/arm64/cpuidle.c
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/kernel/Makefile                          | 1 -
>  drivers/acpi/arm64/Makefile                         | 1 +
>  {arch/arm64/kernel => drivers/acpi/arm64}/cpuidle.c | 4 ----
>  3 files changed, 1 insertion(+), 5 deletions(-)
>  rename {arch/arm64/kernel => drivers/acpi/arm64}/cpuidle.c (97%)

For arch/arm64 changes:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Lorenzo, Hanjun, please let me know if you want these to go in via the
arm64 tree or Raphael's one.

-- 
Catalin

