Return-Path: <linux-acpi+bounces-14041-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F3CAC9D54
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Jun 2025 01:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287C63A4545
	for <lists+linux-acpi@lfdr.de>; Sat, 31 May 2025 23:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE2718A6AD;
	Sat, 31 May 2025 23:16:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE4C1E515
	for <linux-acpi@vger.kernel.org>; Sat, 31 May 2025 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748733404; cv=none; b=N/mAWB1i2hUMpM6qqPw0MpLIpHifDDRoCBkj0blfZNqMMcSYCt69EKtiBtu5PnCgkbYnixtlgOLnltR+3m6NIilEGE1kD37binnso/REIpghpFW5MLCBlic6cEqK5W3cXPAkVAw4C3EwApBBPfe0OHafWfcpDFpB2wvHMVH0LSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748733404; c=relaxed/simple;
	bh=8kFlhuISM7zo7MviDnDMsnib+80szu9BfqYsdPpl+XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om1Xil6QxAwCbUuRMmbLoQYrHNSLdJOXygd9VdEB8bxi/9cNu6FuttzSouu9Rp2c40QCTPrv7Lmx34kpcFQnBijMzZViVaAaTzjg47VdoscLryUMRfjC0iHpNd6fp2FsXzPEbhY2q2jPHdCe0aqqVo+25ZwhIAIrTwGh+u1e4hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([65.217.157.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54VNGRYc013508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 31 May 2025 19:16:27 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 368C4340D66; Sat, 31 May 2025 19:16:26 -0400 (EDT)
Date: Sat, 31 May 2025 19:16:26 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Marc MERLIN <marc@merlins.org>
Cc: linux-acpi@vger.kernel.org
Subject: Re: s2idle on kdell xps 9730 does go to sleep but laptop is warm
Message-ID: <20250531231626.GB179983@mit.edu>
References: <aCWbk4z50QYym9gV@merlins.org>
 <aDt0CH4zO96pxdIu@merlins.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDt0CH4zO96pxdIu@merlins.org>

On Sat, May 31, 2025 at 02:26:32PM -0700, Marc MERLIN wrote:
> This is still a problem. Is there more info I can provide? For now it's
> bad enough that I can't have the battery be in S3 sleep for 24H without
> the batteries running out :-/

I believe what is going on is that on more modern systems, it relies
on the OS's drivers to power done various peripherals (e.g., graphics,
SSD's, etc.) and this is no longer being done by the low-level
firmware.  With Linux the CPU is put to sleep, but there's a lot more
on a modern mainboard than just the CPU....

My solution, two tears ago, was to give up on my Dell XPS 13, and I
switched to a M2 MacBook Air, and I run (arm64) Linux in a Parallels
VM.

Sigh....

							- Ted

