Return-Path: <linux-acpi+bounces-10526-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF47A0A010
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Jan 2025 02:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 621E17A3170
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Jan 2025 01:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B184130A7D;
	Sat, 11 Jan 2025 01:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+GCuK6y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679212C544;
	Sat, 11 Jan 2025 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736558754; cv=none; b=RYaK56a5tsSbzbkQIWtz7knRRQSdYLQPPexNZRygsDinosoM58gkfYRgq1XYK+3T0HQk6j0mn8KAQjkEjcNJq7lzsLgmHsomr+TkpKIaimng+8QfLwRj+LOx6pe0/WhDQPzuSQeDEfTjTwwRJ1Hwtd/p/h35XytgB88R/1su/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736558754; c=relaxed/simple;
	bh=clfMus+25TqGQbzgBAWlVOKubFIUw6fWT2vkmDmjiIE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HkEIvdpuy0itxVSMBNLe9qRQYiWcFkIsTr2udBb24kWtehKB/ewz+maUVY+nEDi3LrJzsoBGiyIxdd88k0zqfyce9lQol+/9cW+sY2ivvjt2Yg4j0l2DNilIL0E62n3BNb19o7TBuK9A1Mm5f1TLkf2qiT4Taa8V07Xwt5pOCls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+GCuK6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EDEC4CED6;
	Sat, 11 Jan 2025 01:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736558754;
	bh=clfMus+25TqGQbzgBAWlVOKubFIUw6fWT2vkmDmjiIE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K+GCuK6y80qi4zaNXKZ7+GO6dIUec0i7s0GmX25n6jQzLTXmKLtOxn+5Zrl9mPEKG
	 zFo9pjuQxz79uAWqSkaKdLZtTR+viCHy2O+QsqJtolBye3lKFqq4eFHnyQXqXwUQ6m
	 ZSHhkJakBWIkvJb3YFCsLXvJcfmt1oJVlaUTiQb3u28iBuQ8VTIGPQM8M//Dyc5GP7
	 6omndSI4XjK/Xly0n7h9kRjoA0gXfX0aPX74zUmimZJesxnyuF/uAtHCYW+A6EHLow
	 OU4LoBbt+N/6AeY0lFjuJ1Cid16/ggZBdSXlPRmc/czrzzIWYQrPJwhUAwylbyEN5d
	 P0u9j7e3ADO4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB469380AA57;
	Sat, 11 Jan 2025 01:26:17 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.13-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iDiC=NnXKBWt=Cx2jWr_Ke7M6Gfe-h3KXFvZPziDveCw@mail.gmail.com>
References: <CAJZ5v0iDiC=NnXKBWt=Cx2jWr_Ke7M6Gfe-h3KXFvZPziDveCw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iDiC=NnXKBWt=Cx2jWr_Ke7M6Gfe-h3KXFvZPziDveCw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.13-rc7
X-PR-Tracked-Commit-Id: cd4a7b2e6a2437a5502910c08128ea3bad55a80b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 475c9f5854d3c68ac9aa0239c1db14ae0fcc1d8b
Message-Id: <173655877664.2259020.3189088468962451320.pr-tracker-bot@kernel.org>
Date: Sat, 11 Jan 2025 01:26:16 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Jan 2025 22:14:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.13-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/475c9f5854d3c68ac9aa0239c1db14ae0fcc1d8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

