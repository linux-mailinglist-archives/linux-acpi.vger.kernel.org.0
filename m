Return-Path: <linux-acpi+bounces-8701-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE184999A88
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 04:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560C92850B3
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 02:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D03E1F4732;
	Fri, 11 Oct 2024 02:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLDimSEL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0081F470B;
	Fri, 11 Oct 2024 02:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614234; cv=none; b=tuST3B/aPjSRGEtP1m6qp3+c3+Ffsf3RCFcrSWnEiGWVCrx37y3KhNc4AqXMW8RSXrbxkDpG7k6KnmF/XxmS+nz2OOVOugzJydhEsvLFWAkB/z5RiIf8UX3P/LWpjSMxpyx7LcDFIZB79FjwV8GuGqT17z+7tE7ZXSWy8R1Z5zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614234; c=relaxed/simple;
	bh=3/YK9VneKwzLLkknXmO5LCgRY+gNWGyfFD/4EJWpkwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFHcDdQIqUNaFLKMMrzftFtqJtLfbXSZWw9V6F4fND54X3k8lNxcfnPAZG0PCOPIvV68mzIiXRBMgQ9ynJBbN9jFEPatn/zqymjiyN5QiGCnu6vcgQ8KkO3ryJmSiQizpmAl9ORZY80rol0r3Te+JOB3J/jygc5XOmKp8q9LNcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLDimSEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4F5C4CEC5;
	Fri, 11 Oct 2024 02:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728614234;
	bh=3/YK9VneKwzLLkknXmO5LCgRY+gNWGyfFD/4EJWpkwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLDimSELeM5m2N62MRDwwYVh2mk2ZprWfZHOvNU7plClTRAHTx2/64fK319yOHB+7
	 qdsX9YAGBlofEYWUeMeDVF3JwT65JP8YJB1Fo/NxQPeBG/eL6z1WBwPTO61NSQD/+F
	 vXJdS3j0D7eZJXu0f5Zi61iTqDL5Gq9wXBT9+/MYb+Ad/ShqgZwXpRxh7Bng6B1S6a
	 6FeLhhm3Ro+e9qmFu5pEQ0IlMW6JfLEVjbEancE/uuYk1l40a/qzaPJ1VtiZznMXdb
	 RMDUHZdAMkBkfiLy4ODLhssoRag+uLsbbbrZ+xC/OUDe5NmTuYLr93DVpK2l8ccK3V
	 fVu8RNRfLOOnA==
Date: Fri, 11 Oct 2024 10:37:09 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH 8/8] power: supply: core: remove
 {,devm_}power_supply_register_no_ws()
Message-ID: <ZwiPVZjIZVC8ojLt@tzungbi-laptop>
References: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
 <20241005-power-supply-no-wakeup-source-v1-8-1d62bf9bcb1d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241005-power-supply-no-wakeup-source-v1-8-1d62bf9bcb1d@weissschuh.net>

On Sat, Oct 05, 2024 at 12:05:10PM +0200, Thomas Weiﬂschuh wrote:
> The same functionality is available through
> power_supply_config::no_wakeup_source, which is more idiomatic.
> All users of the old API have been converted.
> 
> Also remove the argument "ws" from __power_supply_register(),
> as it is now always "true".
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

