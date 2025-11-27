Return-Path: <linux-acpi+bounces-19315-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E189C8EC84
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 15:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9C514E7FDA
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 14:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E26832938A;
	Thu, 27 Nov 2025 14:37:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B5C1A9FAB;
	Thu, 27 Nov 2025 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254271; cv=none; b=WVsh/hYSORMLVRlhFQsBxttrQo6zYjPIqUN1UqcBbK+CaxUjaf/8lxV2x+bNh0Ef1wq0gZlNrhwCG9ZI3jVO6HEtLUx/M3vsEaHMGMEFwQuVKp77ezsDuBtOeOlmvHKoApUlJ4q1yflvT/E9x01VwGiIqHdJpzEAZLxifGL9RQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254271; c=relaxed/simple;
	bh=ODEa9TJ/Jwy1PDIEodSJswrnSAElu01WKgRkjQy8msg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFeKrPQ/LtcJn/qzfsEf2aUM2lLmC2USrcL71nhhlgM+PA1esN++WlrzMabK08egopnRFwqTY5hxkeKEFTWKsFH8mzSuV7lbvqS6zQmJpycphGjnmm0BVnmmONaMtJSexB9hGUKD5PXO3umrkSuINd61hOGmheIDSollb1tNBy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8EDF1063;
	Thu, 27 Nov 2025 06:37:41 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE6843F73B;
	Thu, 27 Nov 2025 06:37:47 -0800 (PST)
Date: Thu, 27 Nov 2025 14:37:45 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
Cc: jassisinghbrar@gmail.com, linux-acpi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	Jamie Iles <jamie.iles@oss.qualcomm.com>
Subject: Re: [PATCH] mailbox: pcc: don't zero error register
Message-ID: <20251127-cherubic-chicken-of-honeydew-075eac@sudeepholla>
References: <20251105144229.467089-1-punit.agrawal@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105144229.467089-1-punit.agrawal@oss.qualcomm.com>

On Wed, Nov 05, 2025 at 02:42:29PM +0000, Punit Agrawal wrote:
> From: Jamie Iles <jamie.iles@oss.qualcomm.com>
> 
> The error status mask for a type 3/4 subspace is used for reading the
> error status, and the bitwise inverse is used for clearing the error
> with the intent being to preserve any of the non-error bits.  However,
> we were previously applying the mask to extract the status and then
> applying the inverse to the result which ended up clearing all bits.
> 
> Instead, store the inverse mask in the preserve mask and then use that
> on the original value read from the error status so that only the error
> is cleared.
> 
> Fixes: c45ded7e1135 ("mailbox: pcc: Add support for PCCT extended PCC subspaces(type 3/4)")

Good catch!

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

