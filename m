Return-Path: <linux-acpi+bounces-10527-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E9BA0A2A1
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Jan 2025 11:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8DC16888E
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Jan 2025 10:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC92918C33B;
	Sat, 11 Jan 2025 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIPG302+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20831632F3;
	Sat, 11 Jan 2025 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736590363; cv=none; b=riniRqsnMpuPlxtHchmkkwKBGdlddlkl85/ea/A/PArXMCa04Ftfws+qwn2KRi45od/l8jgzKmhfHrPLq+uZBkVYqw5/LDZKcuh2uaAP/B+BMhrwIsOsujE8mcgnzuBQ4rwVKCTFZZH01qlaI8EvKZqEO2PYgP9a2HDGMUgnQWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736590363; c=relaxed/simple;
	bh=BQoi7SkkehYbvLMFnQm1BKT1SVMQlvbCM4r0U8WcKsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/R9ocCg4iNNoTRJUMOeDllq8UErzCbcxIRO4YCZZCOBh6FuPFDfd7bWPU6Y+uRJm/Xu4SkNa5IV86v1sjx27UvZSeb5iGbScVdOhy1S3wB5WcCxMm5YWRLl5uJ28n5YwG5FGQ7Az36PMnSFxpCiyVHpCz5I8NMuEmgpg3dfyzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIPG302+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507F4C4CED2;
	Sat, 11 Jan 2025 10:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736590363;
	bh=BQoi7SkkehYbvLMFnQm1BKT1SVMQlvbCM4r0U8WcKsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIPG302+CrAoknjTksq29WvFJ7o8Fs243ztsZ7tDsHLbs4FiosweLt37TmemEyEN9
	 9M7JsQC9Hpy+IufpJVVSNfnV9rRKcNhaGJgpN12BQ06cWlFewatZ/fBm1sbtCAzkVf
	 JvlslO44mlNOiqiLQMhHZzAwiod7NWob48VJTWeGpgfObm10vxoOzYMPZuMLuljQvI
	 E6Qs++tE56SEQLya1Z7y3CAuTjuL6SgNnpRgTTQBbshe4feONjmaGfOrz9ZKt6rQ/7
	 FpHM+1s5f3Acg+wSnxei4a2SlXjy+ttrcKNkASKYFfz6m3LNNme9U0v/DNA4Ap4SUb
	 Pp7xMN4/lvuaA==
Date: Sat, 11 Jan 2025 11:12:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] of: Warn when of_property_read_bool() is used on
 non-boolean properties
Message-ID: <27srflvfjbk2lwhhcl2ynrogxnldgdlfgkfkodkbhjlo4jmiit@2rvps6glelew>
References: <20250109-dt-type-warnings-v1-0-0150e32e716c@kernel.org>
 <20250109-dt-type-warnings-v1-2-0150e32e716c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109-dt-type-warnings-v1-2-0150e32e716c@kernel.org>

On Thu, Jan 09, 2025 at 01:42:06PM -0600, Rob Herring (Arm) wrote:
> The use of of_property_read_bool() for non-boolean properties is
> deprecated. The primary use of it was to test property presence, but
> that has been replaced in favor of of_property_present(). With those
> uses now fixed, add a warning to discourage new ones.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/of/property.c | 26 ++++++++++++++++++++++++++
>  include/linux/of.h    | 25 +++++++------------------
>  2 files changed, 33 insertions(+), 18 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


