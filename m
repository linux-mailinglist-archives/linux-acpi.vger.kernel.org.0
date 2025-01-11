Return-Path: <linux-acpi+bounces-10528-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CBEA0A2A4
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Jan 2025 11:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937AE16889B
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Jan 2025 10:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49A718C932;
	Sat, 11 Jan 2025 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHJo0Mkl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858AA1632DF;
	Sat, 11 Jan 2025 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736590461; cv=none; b=uFvlvxSH30rBxmcq1hD3WFZcdjQKU9bFeqRgLt3yK7P4MQx4hZLJM5Ho86QqNor4sL9LYHJFnhjfV+S0wY0nZ5+iW0avdOTMyvK8bDlsZkcTlkgskmo+jnz/RlVvDkYu+HTwksLrIUuhfTv7YWvelr5TNlqiTMG/vML02J7+/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736590461; c=relaxed/simple;
	bh=81RocCc58SVxGKA+LRZy10WPbaEN7qZvq7MIjf6XJUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfhVF0y6RtOpi8qNOxI5mjvfpgfC9Va6JnJD1eU7ag+VYTGyIqcMepNGMGUKFaEuS/AGVlVyj9UmRG3OpEyZnc1GguGRsD30r0iwS7OJf7vZLqEPI9/7opuKrGFexK+W4JjRK1l67ntEmvLjctRNUkjK3xHmByamZ0n0QyUjRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHJo0Mkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42786C4CED2;
	Sat, 11 Jan 2025 10:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736590461;
	bh=81RocCc58SVxGKA+LRZy10WPbaEN7qZvq7MIjf6XJUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHJo0MklJIaYQPNqqX8p/BaB3y6KA8gbAsnbZ8+PLdWeo06Tv8U846sBwyY5VuWB+
	 b3ewkkhTeOwHfqmU66zv6K0NIjSwzSUr9lsQ4i8CIZvW6YpCyIdswev2DNBMiM1b8k
	 1jhu8nUFVkALXkTxtNMcDygfpdF08lTb9fxU+uGCiFKJ1bCttUKf+t5nSvj/Wp0TQR
	 pewMMlotWpIU7Z7wLinCNZAU8tC87x3P+cMyK/ZybPKZszPdw3HPluDw8VwuBw9eyr
	 zaGB1JfyxIO9LOU9ao8bUBo6IVz3WqVNb7YQV5asL0qxK3dMBjaIxODsSqpvTSoPta
	 skwE8E+IHD6jw==
Date: Sat, 11 Jan 2025 11:14:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] device property: Split property reading bool and
 presence test ops
Message-ID: <ihfpuznw5xojtlvtqi774t66lugzqd33gezvb54lzfhsyhw3iy@fezdvx2ox6p5>
References: <20250109-dt-type-warnings-v1-0-0150e32e716c@kernel.org>
 <20250109-dt-type-warnings-v1-1-0150e32e716c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109-dt-type-warnings-v1-1-0150e32e716c@kernel.org>

On Thu, Jan 09, 2025 at 01:42:05PM -0600, Rob Herring (Arm) wrote:
> The fwnode/device property API currently implement
> (fwnode|device)_property_read_bool() with (fwnode|device)_property_present().
> That does not allow having different behavior depending on the backend.
> 
> Specifically, the usage of (fwnode|device)_property_read_bool() on
> non-boolean properties is deprecated on DT. In order to add a warning
> on this deprecated use, these 2 APIs need separate ops for the backend.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/acpi/property.c  |  1 +
>  drivers/base/property.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/base/swnode.c    |  1 +
>  drivers/of/property.c    |  7 +++++++
>  include/linux/fwnode.h   |  3 +++
>  include/linux/of.h       |  4 +++-
>  include/linux/property.h | 15 +++------------
>  7 files changed, 56 insertions(+), 13 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


