Return-Path: <linux-acpi+bounces-20323-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B063AD1FA2E
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 16:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10FE430CB213
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 15:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB5C314B96;
	Wed, 14 Jan 2026 15:06:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299D2314D18;
	Wed, 14 Jan 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403179; cv=none; b=S8StY0lvMQkTqSm7lF9KOuYv4SHhY6WEdCV9WUW8gB0jOS1bccj2Srz6LpCMFy+vWNaamPx5KqNI9kKYmbz96ly8DctDSU2Vq3mng2vC22jod1aK47jH+OGxRxN0mmFSNuwNndCFk8yJY21Q2waM15h0BailAq2PNIsQxEtRMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403179; c=relaxed/simple;
	bh=ZwplAmWq3i8HpnU0EdyROIRuq8SfA1FY9cESYarZQ8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6EczEyc9ETfrBgfSfoigdqBOJ+dX8NfSBn/kQUVuAX4z17E23KuFSM40igoepdasUnmY9F/EusLmGt7xPLTXhOd4Yq/5h9wPP4Ky1fXGtB5MeA0zQMAke+IPoBNMSJ0rzQADdaxzhWtVRl/tt63n1P2LC5Ci4kKM0eKWuucjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 822D21515;
	Wed, 14 Jan 2026 07:06:06 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF4893F59E;
	Wed, 14 Jan 2026 07:06:11 -0800 (PST)
Date: Wed, 14 Jan 2026 15:06:09 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
Message-ID: <aWew4SHS4c34z0AU@bogus>
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
 <aWUpQ04uNcXtp0wR@bogus>
 <aWYBef5ZUNKVpg1W@U-2FWC9VHC-2323.local>
 <aWZZeD496CPi20Gc@bogus>
 <aWdAiaC10ear9ajR@U-2FWC9VHC-2323.local>
 <CAJZ5v0h-hjrE85_=6YOJ6oRRZ4=SmKWrs7hCKnrP6_KZTuDePw@mail.gmail.com>
 <aWeoA7LDNSB_F38I@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWeoA7LDNSB_F38I@U-2FWC9VHC-2323.local>

On Wed, Jan 14, 2026 at 10:28:19PM +0800, Feng Tang wrote:
> 
> As for the original issue where kernel printed the error message
> " ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
> can we just printed out all the CPU entries of the PPTT table? 
> which is much cleaner and smaller, and have the enough information
> for quickly identifying the root cause. As the number of cache
> items is usually 3X of number of CPUs.

I am still not sure what additional value is gained by listing all those CPU
entries. On a 512-CPU system, for example, if an issue is identified with the
entry for CPU 256, what extra information is obtained by listing all the other
CPUs, such as those sharing the same L3 cache or entire list of CPUs on this
system?

The message above already indicates that something is wrong with core
(n = 1 in above case). If that is not sufficiently clear, it should be
improved to be more specific about the issue. Simply listing all CPUs in the
PPTT provides no additional insight and only results in an unnecessarily long
and distracting CPU list in the kernel log.

-- 
Regards,
Sudeep

