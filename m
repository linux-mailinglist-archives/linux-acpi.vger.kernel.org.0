Return-Path: <linux-acpi+bounces-13598-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E439AAE59F
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 17:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5834E7BF536
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B95E28C5BE;
	Wed,  7 May 2025 15:52:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC0D1DE4F1;
	Wed,  7 May 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633142; cv=none; b=f6p1MMl/bjTyVqhBPYkJ7ku0uYyj54LOwrYDWuT5qbU706WtuAYyQewLrZVkEZPT8QlrEIdxIQ6108KQ0vUjtEM34hVbJP+/QrgesW0gYqDszqKtKk4IFvhgin1cjOListnKLh95b9uJyVC6Y5+StPzZr9InnqxoaRJu73lisu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633142; c=relaxed/simple;
	bh=vt2Iqcam8t3hScDL/YTQJk8oD/XltWLtryr/f+vv0K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbusViGWT05ZBY2eE9XvUel6zJqGMtSw1/uh4KkqwkEiz8gP7F20Dn0d7dpzFZ76J7jF1P25qkFQ/XHqlogLRbPtr0nglfHw72QRtLpXkflwZ0A4Rd/+8j5TxwdosE+fsgGc5vRODzBqI+iOTMbSfgrJlOOfJlNzlsQUAMtbIVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D596416F2;
	Wed,  7 May 2025 08:52:08 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 431F03F58B;
	Wed,  7 May 2025 08:52:17 -0700 (PDT)
Date: Wed, 7 May 2025 16:52:14 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Heyne, Maximilian" <mheyne@amazon.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
Message-ID: <20250507-strict-nifty-alligator-496cda@sudeepholla>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <214c2a2d-e0ea-4ec6-9925-05e39319e813@arm.com>
 <20250507-tasteful-wren-of-devotion-f010af@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-tasteful-wren-of-devotion-f010af@sudeepholla>

On Wed, May 07, 2025 at 04:47:10PM +0100, Sudeep Holla wrote:
> On Wed, May 07, 2025 at 10:25:25AM -0500, Jeremy Linton wrote:

[...]

> 
> > Otherwise the original sizeof * change isn't really fixing anything.
> > 
> 
> How about extending the check for entry->length ? Do you think it will
> be any better ? The entry pointer is anyway updated to jump entry->length
> ahead at the end of the loop.
> 

Scratch that, we will still end up reading an invalid node at the end
if (entry + entry->length > table_end)

-- 
Regards,
Sudeep

