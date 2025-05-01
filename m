Return-Path: <linux-acpi+bounces-13408-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AD7AA5EA9
	for <lists+linux-acpi@lfdr.de>; Thu,  1 May 2025 14:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCFF7AB2F1
	for <lists+linux-acpi@lfdr.de>; Thu,  1 May 2025 12:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0515433A0;
	Thu,  1 May 2025 12:53:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180E0335C7;
	Thu,  1 May 2025 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746104037; cv=none; b=ptA4ZqjjMKmVI3P40W5iX/PQlrqxHKADdg46SSmPMkOmBy6+t/jplho3DmDhG68jTRyLuYAdF7T6F21wigojuGZPnCrnQQ1ODNAP3jt91fPp05euKlKQpw5abb4YX5LnY/x9A4jn1bTf8yUu8AtmXu9jFyBCTv7hi9tUl+dlbgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746104037; c=relaxed/simple;
	bh=j4mQGHPu+EJqfKmthc8Fj5mnKlwjtgRblyz40oB5vhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFtCrfOzcluhsnMCOW1dqQnRJBdMiEb+4wNANZxK1SFz2a09ldhh1RhpM1lwmjE777OpoueFBlvbm6hhPmmkkSaX2IiCR+f8M0HpO53tMJ7F+Fkp8vcvNu6FcK9s4u4uhz3Yp7RYq63Q61R4KV+50kpLjb/hxHHmsxLXMlgyCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6022168F;
	Thu,  1 May 2025 05:53:47 -0700 (PDT)
Received: from bogus (unknown [10.57.20.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D5533F5A1;
	Thu,  1 May 2025 05:53:53 -0700 (PDT)
Date: Thu, 1 May 2025 13:53:50 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] ACPI: APEI: EINJ: Fix probe error message
Message-ID: <20250501-gay-bull-of-flowers-6edebf@sudeepholla>
References: <20250501124621.1251450-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501124621.1251450-1-jonathanh@nvidia.com>

On Thu, May 01, 2025 at 01:46:21PM +0100, Jon Hunter wrote:
> Commit 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device
> interface") updated the APEI error injection driver to use the faux
> device interface and now for devices that don't support ACPI, the
> following error message is seen on boot:
> 
>  ERR KERN faux acpi-einj: probe did not succeed, tearing down the device
> 
> The APEI error injection driver returns -ENODEV in the probe function
> if ACPI is not supported and so after transitioning the driver to the
> faux device interface, the error returned from the probe now causes the
> above error message to be displayed.
> 
> Fix this by moving the code that detects if ACPI is supported to the
> einj_init() function to fix the false error message displayed for
> devices that don't support ACPI.
> 

Good catch, it was silently passing error before.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

