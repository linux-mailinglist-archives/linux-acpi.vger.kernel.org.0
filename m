Return-Path: <linux-acpi+bounces-19405-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FE2C9EB2A
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 11:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4BC3A66FB
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 10:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544452E92BA;
	Wed,  3 Dec 2025 10:28:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831BB2E8B97;
	Wed,  3 Dec 2025 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764757705; cv=none; b=qO7XoDulMo0h9Rf5KcL++jDCz/rGpQ9vz6+JmmQMIeNwbuYyMFt1GeHqk6Q9dIAZX/FQEJs/Gm0dI/KRh0oy0Am5h2onKjNpOxcA+9yt6eVIVGVsDVcR2vreBuSORDD8PsJQckqYPzI4SuDHQ/45xrRBixs/TXbv6z7tJv+FPIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764757705; c=relaxed/simple;
	bh=ouMwDWIU2e55dKyO0lyyYC7S+CYHcBZToAGEUlg4BL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LW0Lv5w2I6LCNmoMfTxIw2DJt5BW+8hm1QSVC53D3ZiK/k5nDxrgQwlICcBuJBAgxT1qoZMyF4qVMZ7TAPSx8uvPwXuoJHGCKa2VQIIU2Ty/0rduxsEVREvj2bYvtwxMBPPwxJLJ5UBeJeiPr06Q7wRVpKJy82TOCwX1FcQuCpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 530DF339;
	Wed,  3 Dec 2025 02:28:15 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9407A3F73B;
	Wed,  3 Dec 2025 02:28:20 -0800 (PST)
Date: Wed, 3 Dec 2025 10:28:17 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
Cc: <jassisinghbrar@gmail.com>, <lenb@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lkp@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, <olivier.dautricourt@sipearl.com>,
	<olivierdautricourt@gmail.com>, <rafael@kernel.org>,
	<thibault.cantori@sipearl.com>
Subject: Re: [PATCH v3 1/2] mailbox: pcc: support polling mode when there is
 no platform IRQ
Message-ID: <20251203-persimmon-condor-of-essence-9fc43d@sudeepholla>
References: <20251127-lovely-real-wrasse-b1fbcd@sudeepholla>
 <20251202101215.2240024-1-andrea.tomassetti@sipearl.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202101215.2240024-1-andrea.tomassetti@sipearl.com>

On Tue, Dec 02, 2025 at 11:12:14AM +0100, Andrea Tomassetti wrote:
> The goal is to allow clients to submit a message in both irq and polling
> mode of the pcc mailbox. The ACPI specification does not require a
> platform irq for pcc channels. Let's implement the case where it is not
> available.
>

Just curious if you have a real use case for this polling mode on your
platforms or ...

> Tested-by: Thibault Cantori <thibault.cantori@sipearl.com>
> Co-developed-by: Olivier Dautricourt <olivier.dautricourt@sipearl.com>
> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@sipearl.com>
> Signed-off-by: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511120243.soxAFpqQ-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202511120558.Cln7LF6M-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202511120729.R3XQNSnx-lkp@intel.com/

You are just trying to fix these warnings. If it is latter, we don't have to
add support for polling mode especially if it can't be tested on real
platforms.

-- 
Regards,
Sudeep

